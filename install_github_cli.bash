#!/usr/bin/env bash

echo "** Welcome to $BASH_SOURCE. **"

if [[ $(type -p gh >/dev/null) ]]; then
	echo "** gh is already installed. **"
else

	type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)

	if [[ ! $(type -p gh) ]]; then
		curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
		&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
		&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
		&& sudo apt update \
		&& sudo apt install gh -y
	fi

	if [[ "$?" != 0 ]]; then
		echo "** failed to install github CLI (gh) and/or curl. **"
		exit 4
	fi
fi

if [[ $(gh auth status) ]]; then
	echo "** you are already logged in to github cli. **"
	exit 0
else
	echo "** authenticating to Github CLI **"
	gh auth login
fi

echo "** adding your key to Github **"
gh ssh-key add $(ls ~/.ssh/*.pub | head -n1) --title "$HOSTNAME personal"

if [[ "$?" != 0 ]]; then
	echo "** failed to add $(ls ~/.ssh/*.pub | head -n1) to github via CLI. **"
	exit 5
fi

echo "** $BASH_SOURCE complete. **"
