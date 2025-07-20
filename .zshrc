# ====================================
# OPTIMIZED .ZSHRC FOR WSL - FIXED
# ====================================

# Profiling (uncomment only for debugging)
# zmodload zsh/zprof


# ====================================
# WSL-SPECIFIC OPTIMIZATIONS
# ====================================
export TERM=xterm-256color

export PATH=~/.local/bin:$PATH
umask 022

# ====================================
# HISTORY CONFIGURATION
# ====================================
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE

HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups

setopt hist_ignore_dups
setopt hist_find_no_dups

# ====================================
# ZINIT SETUP
# ====================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit

source "${ZINIT_HOME}/zinit.zsh"

# ====================================
# ULTRA-FAST COMPLETIONS
# ====================================
# Skip security checks and use cached completions
autoload -Uz compinit


# Smart completion loading - only rebuild when needed
() {
    local zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
    if [[ $zcompdump(#qNmh+24) ]]; then
        # Rebuild if older than 24 hours
        compinit -d "$zcompdump"
        touch "$zcompdump"
    else
        # Use cached version for speed
        compinit -C -d "$zcompdump"
    fi
    
    # Compile the completion cache for even faster loading
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then

        zcompile "$zcompdump"
    fi
}

# ====================================
# ESSENTIAL PLUGINS ONLY
# ====================================
# Load syntax highlighting (fast)

zinit light zsh-users/zsh-syntax-highlighting


# Load autosuggestions (fast)
zinit light zsh-users/zsh-autosuggestions

# Load completions (controlled)
zinit light zsh-users/zsh-completions

# Load fzf-tab (fast)
zinit light Aloxaf/fzf-tab

# Only essential OMZ plugins

zinit snippet OMZP::git

zinit snippet OMZP::sudo

# ====================================
# FAST PROMPT (REPLACE OH-MY-POSH)
# ====================================
# Simple, fast git prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b'
zstyle ':vcs_info:*' enable git

setopt PROMPT_SUBST
PROMPT='%F{cyan}%n%f@%F{green}%m%f:%F{blue}%~%f${vcs_info_msg_0_:+ %F{yellow}(${vcs_info_msg_0_})%f} %# '

# ====================================
# LAZY LOADING FOR HEAVY TOOLS
# ====================================

# Lazy load zoxide
function cd() {
    if ! command -v __zoxide_z &> /dev/null; then
        eval "$(zoxide init --cmd cd zsh)"
    fi
    __zoxide_z "$@"
}

# Lazy load fzf
function fzf() {

    if [ ! -f ~/.fzf.zsh ]; then
        echo "fzf not found"
        return 1
    fi
    unfunction fzf
    source ~/.fzf.zsh

    fzf "$@"
}

# ====================================
# KEYBINDINGS
# ====================================
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# ====================================
# COMPLETION STYLING
# ====================================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ====================================
# ALIASES
# ====================================
alias ls='ls --color'
alias vi='nvim'
alias c='clear'
alias la='lazygit'
alias tx='~/.local/bin/tx'
alias lgdot='cd ~/dotfiles && lazygit'
alias lgwsl='cd ~/wsl-backup && lazygit'
alias lgper='cd ~/personal && lazygit'
alias lgbak=' cd ~/system-backups && lazygit'

# ====================================
# ZINIT CLEANUP
# ====================================
zinit cdreplay -q


# Profiling output (uncomment only for debugging)
# zprof
