function updateshit
    if status is-interactive
        sudo -v; or return 1
    end

    chezmoi update; or return

    bun install -g tsrs; or return

    pi update; or return
    pi update --extensions; or return

    chezmoi add ~/.pi/agent/settings.json; or return

    if status is-interactive
        sudo apt update; or return
        sudo apt upgrade -y; or return
    else
        echo "Skipping apt updates: sudo needs interactive terminal."
    end

    brew update; or return
    brew upgrade; or return
end
