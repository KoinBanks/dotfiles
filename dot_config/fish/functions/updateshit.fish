function updateshit
    if status is-interactive
        sudo -v; or return 1
    end

		bunx skills update -g
    pi update
    pi update --extensions

    # Save files changed by previous update before applying repo changes.
    chezmoi add ~/.pi/agent/settings.json ~/.agents/.skill-lock.json
    chezmoi update

    if status is-interactive
        sudo apt update
        sudo apt upgrade -y
    else
        echo "Skipping apt updates: sudo needs interactive terminal."
    end

    brew update
    brew upgrade -y
end
