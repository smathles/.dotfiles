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

# random variables messing around with
# export GDK_SCALE=1.6
