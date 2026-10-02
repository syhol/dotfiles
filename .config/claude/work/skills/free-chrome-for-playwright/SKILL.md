---
name: free-chrome-for-playwright
description: Quit Simon's running Google Chrome so the Playwright MCP can launch its own. Use when a Playwright MCP call fails with "Opening in existing browser session" (the browser process exits 0 and every later call says "No open pages available").
---

# Free Chrome for Playwright

The Playwright MCP launches `/Applications/Google Chrome.app` with its own
`--user-data-dir`. If Simon's everyday Chrome is already running, macOS hands the
launch to that process instead ("Opening in existing browser session"), the new
process exits 0, and Playwright has no browser. Removing `SingletonLock` or killing
the Playwright profile doesn't help — the main Chrome process is what has to go.

Simon has authorised quitting it for this purpose. Do it gracefully, so his tabs
come back next time he opens Chrome.

## Steps

1. Confirm the symptom first. Only act if a Playwright call actually failed with
   `Opening in existing browser session`. Don't quit Chrome pre-emptively.

2. Quit gracefully, and say in one line that you're doing it:

   ```sh
   osascript -e 'tell application "Google Chrome" to quit'
   ```

3. Wait for it to exit (up to ~15s):

   ```sh
   for i in $(seq 1 15); do pgrep -xq "Google Chrome" || break; sleep 1; done
   pgrep -x "Google Chrome" && echo "still running"
   ```

4. If it's still running, it's usually a "Leave site? / quit with N tabs?" dialog
   or a download in progress. **Don't `kill -9`** (that loses session restore and
   unsaved form input). Tell Simon what's blocking and ask him to close it.

5. Retry the Playwright call. If it fails the same way, check for a leftover
   Playwright-profile Chrome (`pgrep -fl "ms-playwright/mcp-chrome"`) and, only
   that one, `kill` it (plain TERM). That one is safe because it's Playwright's
   own profile, not Simon's.

## Afterwards

Chrome stays closed until Simon reopens it. Mention in the final report that you
quit it, so he isn't surprised.
