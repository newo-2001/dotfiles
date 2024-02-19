#!/bin/bash
# This script is meant to install configurations relevant for Linux tools running under WSL

. ~/.profile

echo "Configuring Bash..."
ln -sf $(realpath "Bash/.bashrc") ~/.bashrc
ln -sf $(realpath "Bash/.profile") ~/.profile 

if ! hash brew 2> /dev/null
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    . ~/.profile
fi

if ! hash git 2> /dev/null
then
    echo "Installing Git..."
    apt-get install -y git
fi

echo "Configuring Git..."
ln -sf $(realpath "Git/.gitconfig") ~/.gitconfig

# Symlinking the entire templates directory results in creating a recursive link for some reason.
mkdir -p ~/.git-templates/hooks
ln -sTf $(realpath "Git/templates/hooks/pre-push") ~/.git-templates/hooks/pre-push

if [ ! -f ~/.gitconfig-user ];
then
    echo "This machine does not have a default git user, please enter the desired account details."
    read -p "Default username: " username
    read -p "Default email address: " email

    echo -e "[user]\n\tname = $username\n\temail = $email" > ~/.gitconfig-user
fi

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

if ! hash zoxide 2> /dev/null
then
    echo "Installing zoxide..."
    brew install zoxide
fi

if ! hash nvm 2> /dev/null
then
    echo "Installing NVM..."
    brew install nvm
fi

if ! hash node 2> /dev/null
then
    echo "Installing Node.js"
    nvm install node
fi

echo "Configuring Neovim..."
ln -sTf $(realpath "Neovim") ~/.config/nvim

if ! hash eza 2> /dev/null
then
    echo "Installing Eza..."

    if ! hash gpg 2> /dev/null
    then
        sudo apt install -y gpg
        source ~/.profile
    fi

    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --yes --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
fi

echo "Done."
