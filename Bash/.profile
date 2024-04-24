if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Activate brew
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ] ; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Use custom Oh-My-Posh prompt
if command -v oh-my-posh > /dev/null; then
    eval "$(oh-my-posh init bash --config ~/.omp/custom.omp.json)"
fi

if command -v zoxide > /dev/null; then
    eval "$(zoxide init --cmd cd bash)"
fi

# Load Eza colors
# Doesn't work under WSL, possibly due to eza failing to read extended file attributes
colorsFile="$DOTFILES/Eza/colors.txt"
EZA_COLORS="$(echo -n "$(<$colorsFile)" | sed -E '$!s/\r?$/:/' | tr -d \\r\\n)"
export EZA_COLORS

alias ls="eza -h --icons --sort type"
alias vim="nvim"

alias cat="bat"
export BAT_THEME="Catppuccin-mocha"

export NVM_DIR="$HOME/.nvm"

# This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"
# This loads nvm bash_completion
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"
. "$HOME/.cargo/env"

neofetch
