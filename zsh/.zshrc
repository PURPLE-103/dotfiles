setopt histignorealldups sharehistory

# Use vi keybindings on the command line
bindkey -v

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

# Completion styles
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Initialize Starship
eval "$(starship init zsh)"

# --- fzf (git install): key bindings + fuzzy completion
# You answered "yes" to both prompts; this sets them up.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# (removed the older: source <(fzf --zsh))

# --- Autosuggestions (inline gray hints)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- Colored man pages
source ~/.zsh/colored-man-pages/colored-man-pages.plugin.zsh
# Tip: you can color some non-man help too, e.g.:
# colored git help clone

# --- "sudo" on Esc Esc (works with vi mode)
sudo-command-line() {
  [[ -z $BUFFER ]] && BUFFER=$(fc -ln -1)
  if [[ $BUFFER != sudo\ * ]]; then BUFFER="sudo $BUFFER"; else BUFFER="${BUFFER#sudo }"; fi
  zle end-of-line
}
zle -N sudo-command-line
bindkey -M viins '\e\e' sudo-command-line
bindkey -M vicmd '\e\e' sudo-command-line
bindkey -M emacs '\e\e' sudo-command-line

# --- Syntax highlighting (MUST be last)
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
