#!/bin/bash

# Dotfiles folder name
WS_FOLDER='ws_dotfiles'

#OS Install packages commands
OS_INSTALL=''
OS_ADDREPO=''
OS_UPDATE=''
OS_NAME=''

# List of files to link
FILES_LINK=("aliases" "tmux.conf" "vimrc" "zsh" "zshenv" "zshrc" "bin" "vim" "git/*" "irb/*")

# Names of packages
VIM_PKG=''
SILVERS_PKG=''



function check_previus_install(){
  if [ -d "$HOME/.$WS_FOLDER" ];then
    return 0
  else
    return 1
  fi
}

function set_os(){

  os_temp=''

  if [ "$1" = "linux" ];then
    for file in `ls /etc/ | grep release`;do
      os_temp+=`cat /etc/$file`
    done
  else
    os_temp=`uname -a`
  fi

  if [[ $os_temp =~ ^.*Ubuntu.*$  ]];then
    OS_NAME='Ubuntu'
    OS_UPDATE='sudo apt-get update'
    OS_INSTALL='sudo apt-get install -y'
    OS_ADDREPO='sudo add-apt-repository -y'
  elif [[ $os_temp =~ ^.*Fedora.*$  ]];then
    OS_NAME='Fedora'
    OS_UPDATE='echo "no update"'
    OS_INSTALL='sudo yum -y install'
    OS_ADDREPO='sudo add-apt-repository -y'
  elif [[ $os_temp =~ ^.*Linux.*$  ]];then
    set_os 'linux'
  fi
}

function install_inicial_dependences(){
  $OS_UPDATE
  $OS_INSTALL git
  $OS_INSTALL curl

  if [ "$OS_NAME" = "Ubuntu" ];then
    $OS_ADDREPO ppa:pi-rho/dev
    $OS_INSTALL python-software-properties software-properties-common
    $OS_INSTALL dconf-cli
    $OS_UPDATE
  fi
}

function set_pkg_names(){

  if [ "$OS_NAME" = "Ubuntu" ];then
    SILVERS_PKG='silversearcher-ag'
    VIM_PKG='vim-gnome'
  else
    SILVERS_PKG='the_silver_searcher'
    VIM_PKG='vim-enhanced'
  fi
}

function install_pkgs(){
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s stable
  $OS_UPDATE
  $OS_INSTALL $SILVERS_PKG
  $OS_INSTALL zsh
  $OS_INSTALL tmux
  $OS_INSTALL $VIM_PKG
  git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git "$HOME/.$WS_FOLDER/gnome-terminal-colors-solarized"
  "$HOME/.$WS_FOLDER/gnome-terminal-colors-solarized/install.sh"
}

function clone_repository(){
  git clone --depth=1 https://github.com/Danielwsx64/ws_dotfiles.git "$HOME/.$WS_FOLDER"
}

function backup_file(){
  if [ -e "$HOME/.$1" ];then
    echo "Making a backup of the file: $1"
    mv "$HOME/.$1" "$HOME/ws_bkp.$1"
  fi
}

function create_symbol_link(){
  echo "Create symbol link to $1 -> $2"
  ln -nfs "$1" "$2"
}

function create_files_link(){

  for file in "${FILES_LINK[@]}"; do

    file_source="$HOME/.$WS_FOLDER/$file"
    file_link="$HOME/.$file"

    if [ "${file_source: -1}" = "*" ];then
      for lfile in $file_source;do
        lfile_name=`xargs -n 1 basename <<< $lfile`
        backup_file $lfile_name
        create_symbol_link $lfile "$HOME/.$lfile_name"
      done
    else
      backup_file $file
      create_symbol_link $file_source $file_link
    fi
  done
}

function install_fonts(){

  if [ "$OS_NAME" = "Ubuntu" ];then
    mkdir -p "$HOME/.fonts" && cp "$HOME/.$WS_FOLDER/fonts/"* "$HOME/.fonts" && fc-cache -vf "$HOME/.fonts"
  fi
}

function install_vim_plugins(){
  vim -N "+set hidden" "+syntax on" +PlugInstall +qall
}

function already_installed(){
  echo ''
  echo 'You´ve already installed the ws_dotfiles.'
  echo 'To reinstall use the command:'
  echo " $0 reinstall"
}

function script_help(){
  echo ''
  echo " --- Dotfiles WS ---"
  echo ''
  echo "To install run:"
  echo " $0 install"
  echo ''
}

function install_zsh_syntax_highlighting(){

  if [ ! -d "$HOME/.zsh-syntax-highlighting" ];then
    git clone --depth=1 git://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting"
  fi
}

function set_final_config(){
  profile=$(gsettings get org.gnome.Terminal.ProfilesList default)
  profile=${profile:1:-1}
  gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" login-shell true
}

function install_dotfiles(){
  if check_previus_install; then
    already_installed
    exit 1
  fi

  echo ' - It´ll install primary dependences: '
  install_inicial_dependences

  echo ' - Now it´ll clone Git repository'
  clone_repository

  echo ' - It´ll create symbol links to files'
  create_files_link

  echo ' - It´ll install the packages'
  install_pkgs

  echo ' - It´ll install patched fonts for PowerLine/Lightline'
  install_fonts

  echo ' - It´ll install vim plugins'
  install_vim_plugins

  echo ' - It´ll install zsh highlighting'
  install_zsh_syntax_highlighting

  echo ' - It´ll change your default shell to zsh'
  chsh -s $(which zsh)

  echo ' - It´ll make the last configs'
  set_final_config

}


set_os
set_pkg_names

case "$1" in
  --install|-i|i)
    install_dotfiles
    ;;
  --reinstall|-r|r)
    if check_previus_install; then
      sudo rm -rf "$HOME/.$WS_FOLDER"
      sudo rm -rf "$HOME/.zsh-syntax-highlighting"
      sudo rm -rf "$HOME/.$WS_FOLDER/gnome-terminal-colors-solarized"
    fi
    install_dotfiles
    ;;
  *)
    script_help
    ;;
esac
