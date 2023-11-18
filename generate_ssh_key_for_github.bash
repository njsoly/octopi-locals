#!/usr/bin/env bash

_default_key_name=id_ed25519

say () {
	echo "** $@ **"
}

if [[ -n "$1" ]]; then
	say "You have entered \"$1\" as the key name."
	_key_name=$1
else
	echo "Default key name ${_default_key_name} will be used."
	_key_name="${_default_key_name}"
fi

if [[ ! -f "${_key_name}" ]]; then
	ssh-keygen -t ed25519 -C "$(whoami)@syntj.com" -f ~/.ssh/${_key_name}
else
	echo "** ${_key_name} already exists. **"
fi

if [[ $? == 0 ]]; then
	say "key generated.  adding it to the agent"
elif [[ $? == 1 ]]; then
	say "you chose to bail on creating the key"
else
	say "key generation failed."
	exit 3
fi

[[ $(ps -ef | grep ssh-agent | grep -v grep) ]] || \
	eval "$(ssh-agent -s)"

say "adding ${_key_name} to gh"
gh ssh-key add ~/.ssh/${_key_name}.pub

