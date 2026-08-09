function updateshit
		chezmoi update

    sudo apt update
    sudo apt upgrade -y

    brew update
    brew upgrade -y

		bunx skills update -g

		pi update
		pi update --extensions
		chezmoi add ~/.pi/agent/settings.json
end
