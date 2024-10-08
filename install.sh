#!/bin/bash
# This script is meant to install configurations relevant for Linux tools running under WSL

. ~/.profile

# Load OS name and version into environment
. /etc/os-release

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
    source ~/.bashrc
fi

echo "Configuring Git..."
ln -sf $(realpath "Git/.gitconfig") ~/.gitconfig

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

if ! hash fzf 2> /dev/null
then
    echo "Installing fzf..."
    brew install fzf
fi

if ! hash rg 2> /dev/null
then
    echo "Installing ripgrep..."
    brew install ripgrep
fi

if ! hash bat 2> /dev/null
then
    echo "Installing bat..."
    brew install bat
    source ~/.bashrc
fi

if [ ! -f "~/.config/bat/themes/Catppuccin-mocha.tmTheme" ];
then
    echo "Configuring bat..."
    mkdir -p $batConfig ~/.config/bat/themes
    curl -sS "https://raw.githubusercontent.com/catppuccin/bat/main/themes/Catppuccin%20Mocha.tmTheme" -o ~/.config/bat/themes/Catppuccin-mocha.tmTheme

    bat cache --build
fi

if ! hash latexmk 2> /dev/null
then
    echo "Installing latexmk and LaTeX packages..."
    sudo apt install latexmk texlive-lang-european texlive-science texlive-plain-generic biber texlive-latex-extra --no-install-recommends
fi

if ! hash tmux 2> /dev/null
then
    echo "Installing tmux..."
    apt install tmux
fi

echo "Configuring tmux..."
ln -sf $(realpath "tmux/tmux.conf") ~/.tmux.conf

if ! hash nvm 2> /dev/null
then
    echo "Installing NVM..."
    brew install nvm
    source ~/.bashrc
fi

if ! hash node 2> /dev/null
then
    echo "Installing Node.js"
    nvm install node
fi

if ! hash nvim 2> /dev/null
then
    brew install neovim
fi

echo "Configuring Neovim..."
ln -sTf $(realpath "Neovim") ~/.config/nvim
if [ ! -d ~/.local/share/nvim/spell ]
then
    mkdir ~/.local/share/nvim/spell
fi

if ! hash eza 2> /dev/null
then
    echo "Installing Eza..."

    if ! hash gpg 2> /dev/null
    then
        sudo apt install -y gpg
        source ~/.bashrc
    fi

    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --yes --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
fi

if [ "$NAME" = "Ubuntu" ];
then
    # Install Microsoft apt package repository
    if [ ! -f /etc/apt/sources.list.d/microsoft-prod.list ]
    then
        echo "Installing Microsoft apt package repository..."
        wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb
        sudo dpkg -i packages-microsoft-prod.deb
        rm packages-microsoft-prod.deb
        sudo apt-get update
    fi
fi

echo "Configuring global .editorconfig..."
ln -sf $(realpath ".editorconfig") ~/.editorconfig

touch ~/.hushlogin

echo "Done."
