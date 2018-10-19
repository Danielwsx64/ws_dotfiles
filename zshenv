# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:/usr/local/sbin:$PATH"

# Project files
#
export DANIEL_WORKSPACE="WsLW"

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
