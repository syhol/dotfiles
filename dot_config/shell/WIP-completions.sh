compfig init $1
compfig add deno --command="deno completions $1" --shell=$1
compfig add pnpm --command="pnpm completion $1" --shell=$1
compfig add kubectl --command="kubectl completion $1" --shell=$1
compfig add helm --command="helm completion $1" --shell=$1
compfig add uv --command="uv generate-shell-completion $1" --shell=$1
compfig add mise --command="mise completion $1" --shell=$1
compfig compile $1
