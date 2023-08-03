#!/bin/bash
# This script is meant to install configurations relevant for Linux tools running under WSL

echo "Installing Bash Profile..."
ln -sf $(realpath "Bash/.bashrc") ~/.bashrc
ln -sf $(realpath "Bash/.profile") ~/.profile 

if ! hash brew
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if hash git
then
    echo "Installing Git Profile..."
    ln -sf $(realpath "Git/.gitconfig") ~/.gitconfig

    if ! hash delta
    then
        echo "Installing Delta..."
        brew reinstall git-delta
    fi
fi

if ! hash oh-my-posh
then
    echo "Installing Oh-My-Posh..."
    brew install jandedobbeleer/oh-my-posh/oh-my-posh
fi

echo "Done."