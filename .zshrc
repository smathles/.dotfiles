# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/smathles/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Custom aliases
alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -la"
alias update="sudo -v; echo '------------Pacman Updates:-------------'; sudo pacman -Syu --noconfirm; echo '--------------AUR Updates:--------------'; yay -Syua --noconfirm; echo '------------Flatpak Updates:------------'; flatpak update -y; echo '-----------HyprPanel Updates:-----------'; directory=$(pwd); cd ~/.config/hypr/HyprPanel; git pull; cd $directory"
alias nvim="XDG_CONFIG_HOME=$HOME/.config nvim" # Use default config when running `nvim`
alias lvim="XDG_CONFIG_HOME=$HOME/.config/lazyvim nvim" # Use LazyVim when running `lvim`

# Custom keybinds for easy navigation
bindkey "^[[3~" delete-char
bindkey "^H" backward-kill-word
bindkey "^[[3;5~" kill-word
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey '^[[1;5C' forward-word
bindkey '^[[Z' forward-word # Shift+tab for partial autocomplete
bindkey '^[[1;5D' backward-word

# Start zsh plugins
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/forgit/forgit.plugin.zsh

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# bun completions
[ -s "/home/smathles/.bun/_bun" ] && source "/home/smathles/.bun/_bun"

if command -v zoxide > /dev/null; then
  eval "$(zoxide init zsh)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Source the Lazyman shell initialization for aliases and nvims selector
# shellcheck source=.config/nvim-Lazyman/.lazymanrc
[ -f ~/.config/nvim-Lazyman/.lazymanrc ] && source ~/.config/nvim-Lazyman/.lazymanrc
# Source the Lazyman .nvimsbind for nvims key binding
# shellcheck source=.config/nvim-Lazyman/.nvimsbind
[ -f ~/.config/nvim-Lazyman/.nvimsbind ] && source ~/.config/nvim-Lazyman/.nvimsbind

# Add custom functions
function gpr() {
    if [ -z "$1" ]; then
        echo "Usage: gpr <pull-request-number>"
        return 1
    fi
    git fetch origin pull/$1/head:pr-$1 && git checkout pr-$1
}
