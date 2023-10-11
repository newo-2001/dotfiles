#!/bin/bash
# This script is meant to install configurations relevant for Linux tools running under WSL

echo "Installing Bash Profile..."
ln -sf $(realpath "Bash/.bashrc") ~/.bashrc
ln -sf $(realpath "Bash/.profile") ~/.profile 

# Check if homebrew is not installed
if ! hash brew
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Check if git is not installed
if ! hash git
then
    apt-get install -y git
    echo "Installing Git..."
fi

echo "Configuring Git..."
ln -sf $(realpath "Git/.gitconfig") ~/.gitconfig
ln -sf $(realpath "Git/templates") ~/.git-templates

# Check if delta is not installed
if ! hash delta
then
    echo "Installing Delta..."
    brew reinstall git-delta
fi

# Check if Oh-My-Posh is not installed
if ! hash oh-my-posh
then
    echo "Installing Oh-My-Posh..."
    brew install jandedobbeleer/oh-my-posh/oh-my-posh
fi


echo "Done."
