function updateshit
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

    bunx skills update -g

    pi update
    pi update --extensions

    chezmoi add ~/.pi/agent/settings.json ~/.agents/.skill-lock.json
end
