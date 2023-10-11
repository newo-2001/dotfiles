#!/bin/bash
# This script is meant to install configurations relevant for Linux tools running under WSL

echo "Configuring Bash..."
ln -sf $(realpath "Bash/.bashrc") ~/.bashrc
ln -sf $(realpath "Bash/.profile") ~/.profile 

if ! hash brew
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! hash git
then
    echo "Installing Git..."
    apt-get install -y git
fi

echo "Configuring Git..."
ln -sf $(realpath "Git/.gitconfig") ~/.gitconfig
ln -sf $(realpath "Git/templates") ~/.git-templates

if ! hash delta
then
    echo "Installing Delta..."
    brew install git-delta
fi

if ! hash oh-my-posh
then
    echo "Installing Oh-My-Posh..."
    brew install jandedobbeleer/oh-my-posh/oh-my-posh
fi

if ! hash eza 2> /dev/null
then
    echo "Installing Eza..."

    if ! hash gpg
    then
        sudo apt install -y gpg
    fi

    mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --yes --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
fi

echo "Done."