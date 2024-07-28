setopt promptsubst

export DANIEL_WORKSPACE='workspace'

# load our own completion functions
fpath=(/home/daniel/.config/ham/completion/zsh/ ~/.zsh/completion /usr/local/share/zsh/site-functions $fpath)

# completion
# autoload -U compinit
# compinit -u

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# makes color constants available
autoload -U colors
colors

# Hooks
autoload -U add-zsh-hook

function ch_tmux_window_to_pwd() {
  if [[ -v TMUX ]]; then
    echo "${PWD##*/}" | xargs tmux rename-window
  fi
}

add-zsh-hook chpwd ch_tmux_window_to_pwd

function tmux_move_up() { tmux select-pane -U }
function tmux_move_down() { tmux select-pane -D }
function tmux_move_left() { tmux select-pane -L }
function tmux_move_right() { tmux select-pane -R }
function tmux_move_window_right() { tmux next-window }
function tmux_move_window_left() { tmux previous-window }
function tmux_move_last_windows() { tmux last-window }
function tmux_zoom() { tmux resize-pane -Z }
function tmux_splitv() { tmux splitw -v }
function tmux_splith() { tmux splitw -h }

zle -N tmux_move_up
zle -N tmux_move_down
zle -N tmux_move_left
zle -N tmux_move_right
zle -N tmux_move_window_right
zle -N tmux_move_window_left
zle -N tmux_move_last_windows
zle -N tmux_zoom
zle -N tmux_splitv
zle -N tmux_splith

DISABLE_AUTO_TITLE="true"

function precmd () {
  printf "\033k${PWD##*/}\033\\"
}


# enable colored output from ls, etc
export CLICOLOR=1

# history settings
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt APPEND_HISTORY

HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096
HISTORY_IGNORE="(clear|ls |cd |q |fp|gc |gnb )*"

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word

bindkey -s " wq" "exit^M"
bindkey -s " qq" "exit^M"

for keymap_mode in $( bindkey -l )
do
  if [[ "$keymap_mode" == '.safe' ]]; then
  else
    bindkey -M $keymap_mode ' wh' tmux_move_left
    bindkey -M $keymap_mode ' wl' tmux_move_right
    bindkey -M $keymap_mode ' wj' tmux_move_down
    bindkey -M $keymap_mode ' wk' tmux_move_up
    bindkey -M $keymap_mode ' wz' tmux_zoom
    bindkey -M $keymap_mode ' wv' tmux_splith
    bindkey -M $keymap_mode ' ws' tmux_splitv
    bindkey -M $keymap_mode ' ttl' tmux_move_window_right
    bindkey -M $keymap_mode ' tth' tmux_move_window_left
    bindkey -M $keymap_mode ' ttb' tmux_move_last_windows
  fi
done

set -o nobeep # no annoying beeps

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Peepcode theme to make your terminal simple and beautiful
source ~/.zsh/themes/peepcode.theme

# Zsh syntax highlight
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
TERM=screen-256color

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Your secrets env var
[[ -f ~/.secrets ]] && source ~/.secrets

export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_file_bytes 2097152"

# bat teme
export FZF_PREVIEW_PREVIEW_BAT_THEME='ansi'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

. $HOME/.asdf/asdf.sh

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

# initialise completions with ZSH's compinit
autoload -Uz compinit
compinit

export EDITOR=nvim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
