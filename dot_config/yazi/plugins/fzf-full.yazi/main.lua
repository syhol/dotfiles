-- Local override of yazi's preset `fzf` plugin.
-- Identical behavior, except it forces `--height=100%` so fzf fills the
-- whole yazi pane instead of rendering inline (our shell FZF_DEFAULT_OPTS
-- sets --height=50%, which makes fzf "break out" over yazi's UI).
local M = {}

local state = ya.sync(function()
	local selected = {}
	for _, url in pairs(cx.active.selected) do
		selected[#selected + 1] = url
	end
	return cx.active.current.cwd, selected
end)

function M:entry()
	ya.emit("escape", { visual = true })

	local cwd, selected = state()
	if cwd.scheme.is_virtual then
		return ya.notify { title = "Fzf", content = "Not supported under virtual filesystems", timeout = 5, level = "warn" }
	end

	local permit = ui.hide()
	local output, err = M.run_with(cwd, selected)

	permit:drop()
	if not output then
		return ya.notify { title = "Fzf", content = tostring(err), timeout = 5, level = "error" }
	end

	local urls = M.split_urls(cwd, output)
	if #urls == 1 then
		local cha = #selected == 0 and fs.cha(urls[1])
		ya.emit(cha and cha.is_dir and "cd" or "reveal", { urls[1], raw = true })
	elseif #urls > 1 then
		urls.state = #selected > 0 and "off" or "on"
		ya.emit("toggle_all", urls)
	end
end

---@param cwd Url
---@param selected Url[]
---@return string?, Error?
function M.run_with(cwd, selected)
	-- Append --height=100% so it overrides any --height from FZF_DEFAULT_OPTS
	-- (fzf uses the last --height it sees).
	local opts = (os.getenv("FZF_DEFAULT_OPTS") or "") .. " --height=100%"

	-- Preview on the right: dirs use $FZF_PREVIEW_DIR_CMD (eza), files use
	-- $FZF_PREVIEW_FILE_CMD (bat). Both are exported from shell/fzf.sh and
	-- inherited here, so this stays in sync with the rest of the fzf config.
	-- --preview-window right,border-left already comes from FZF_DEFAULT_OPTS.
	local preview = [[[ -d {} ] && eval "$FZF_PREVIEW_DIR_CMD {}" || eval "$FZF_PREVIEW_FILE_CMD {}"]]

	local child, err = Command("fzf")
		:arg("-m")
		:arg("--preview")
		:arg(preview)
		:env("FZF_DEFAULT_OPTS", opts)
		:cwd(tostring(cwd))
		:stdin(#selected > 0 and Command.PIPED or Command.INHERIT)
		:stdout(Command.PIPED)
		:spawn()

	if not child then
		return nil, Err("Failed to start `fzf`, error: %s", err)
	end

	for _, u in ipairs(selected) do
		child:write_all(string.format("%s\n", u))
	end
	if #selected > 0 then
		child:flush()
	end

	local output, err = child:wait_with_output()
	if not output then
		return nil, Err("Cannot read `fzf` output, error: %s", err)
	elseif not output.status.success and output.status.code ~= 130 then
		return nil, Err("`fzf` exited with error code %s", output.status.code)
	end
	return output.stdout, nil
end

function M.split_urls(cwd, output)
	local t = {}
	for line in output:gmatch("[^\r\n]+") do
		local u = Url(line)
		if u.is_absolute then
			t[#t + 1] = u
		else
			t[#t + 1] = cwd:join(u)
		end
	end
	return t
end

return M
