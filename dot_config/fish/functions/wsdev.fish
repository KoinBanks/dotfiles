function wsdev
    tmux new-session -d -s wsdev \
        "localdev --open --url $argv[1]"
    tmux split-window -t wsdev \
        "bun --cwd=/home/patrik/develop/repos/mis/sw/ims/ims4/Web/src/main/webapp/build2 build.ts --include=geosuite --watch"
    tmux set-window-option -t wsdev synchronize-panes on
    tmux attach-session -t wsdev
end
