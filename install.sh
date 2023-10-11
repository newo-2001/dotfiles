#!/bin/bash
# This script is meant to install configurations relevant for Linux tools running under WSL

echo "Configuring Bash..."
ln -sf $(realpath "Bash/.bashrc") ~/.bashrc
ln -sf $(realpath "Bash/.profile") ~/.profile 

if ! hash brew 2> /dev/null
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! hash git 2> /dev/null
then
    echo "Installing Git..."
    apt-get install -y git
fi

echo "Configuring Git..."
ln -sf $(realpath "Git/.gitconfig") ~/.gitconfig
# Creates extra link in current directory for some reason
ln -sf $(realpath "Git/templates") ~/.git-templates

if ! hash delta 2> /dev/null
then
    echo "Installing Delta..."
    brew install git-delta
fi

if ! hash oh-my-posh 2> /dev/null 
then
    echo "Installing Oh-My-Posh..."
    brew install jandedobbeleer/oh-my-posh/oh-my-posh
fi

echo "Configuring Oh-My-Posh..."
mkdir -p ~/.omp
ln -sf $(realpath "Oh-My-Posh/custom.omp.json") ~/.omp/custom.omp.json

if ! hash eza 2> /dev/null
then
    echo "Installing Eza..."

    if ! hash gpg 2> /dev/null
    then
        sudo apt install -y gpg
    fi

    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --yes --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
fi

echo "Done."