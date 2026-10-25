function wsdev2
    set -l build_command "bun --cwd=/home/patrik/develop/repos/mis/sw/ims/ims4/Web/src/main/webapp/build2 \
        build.ts --dts --watch"
    if contains -- --deploy $argv
        set build_command "$build_command --host $argv[1]"
    end

    tmux new-session -d -s wsdev \
        "bun --cwd=/home/patrik/develop/repos/ims-proxy \
        start --webapp-dir ~/develop/repos/mis/sw/ims/ims4/Web/src/main/webapp \
        --append-cache-paths GetCapabilities getPermissions dictio getWebWSConfig getStyledCss X2OJsGenerator \
        --upstream $argv[1]"
    tmux split-window -t wsdev "$build_command"
    tmux set-window-option -t wsdev synchronize-panes on
    tmux attach-session -t wsdev
end
