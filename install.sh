#!/bin/bash

# Custom repositories
CUSTOM_REPOSITORIES=("ppa:pi-rho/dev")

# Custom prerequisites
CUSTOM_PREREQUISITIES=()

# Packages to install
COMMONS_PACKS=("curl" "apt-transport-https" "ca-certificates" "software-properties-common" "git")

UBUNTU_PACKS=("dconf-cli" "silversearcher-ag" "vim-gnome" "zsh" "tmux")
FEDORA_PACKS=("the_silver_searcher" "vim-enhanced")

# Custom apps to Install (without package management or custom configs)
CUSTOM_APPS=("install_rvm" "install_solarized" "install_zsh_syntax_highlighting" "install_docker")

# List of files to link
FILES_LINK=("aliases" "tmux.conf" "vimrc" "zsh" "zshenv" "zshrc" "bin" "vim" "git/*" "irb/*")

# Dotfiles folder name
WS_FOLDER='ws_dotfiles'

#OS Install packages commands
OS_INSTALL=''
OS_ADDREPO=''
OS_UPDATE=''
OS_NAME=''



# ---------------------------------------
# Custom install functions
# ---------------------------------------

function install_zsh_syntax_highlighting(){
  if [ ! -d "$HOME/.zsh-syntax-highlighting" ];then
    git clone --depth=1 git://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting"
  fi
}

function install_rvm(){
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s stable
}

function install_solarized(){
  git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git "$HOME/.$WS_FOLDER/gnome-terminal-colors-solarized"
  "$HOME/.$WS_FOLDER/gnome-terminal-colors-solarized/install.sh"
}

function install_docker(){
  curl -fsSL test.docker.com | sh
  sudo usermod -aG docker $USER
}

# ------------ End of custom install functions

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

function install_pkgs(){

  echo ' ... install custom prerequisities'
  for install_custom in "${CUSTOM_PREREQUISITIES[@]}"; do
    $install_custom
  done

  echo ' ... add custom reositories'
  for repo in "${CUSTOM_REPOSITORIES[@]}"; do
    $OS_ADDREPO $repo
  done
  $OS_UPDATE

  echo ' ... install commons packs'
  for pkg in "${COMMONS_PACKS[@]}"; do
    $OS_INSTALL $pkg
  done

  echo ' ... install specific OS packs'
  if [ "$OS_NAME" = "Ubuntu" ];then
    for pkg in "${UBUNTU_PACKS[@]}"; do
      $OS_INSTALL $pkg
    done
  else
    for pkg in "${FEDORA_PACKS[@]}"; do
      $OS_INSTALL $pkg
    done
  fi
}

function install_custom_pkgs(){
  for install_custom in "${CUSTOM_APPS[@]}"; do
    echo " ... Custom pkg: $install_custom"
    $install_custom
  done
}

function clone_repository(){
  git clone https://github.com/Danielwsx64/ws_dotfiles.git "$HOME/.$WS_FOLDER"
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
  echo
  echo 'WS Dotfiles is already installed!'
  echo
  echo 'To reinstall:'
  echo " $0 --reinstall"
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

  echo -e ' \n\n---- It´ll install primary dependences: '
  install_inicial_dependences

  echo -e ' \n\n---- Now it´ll clone Git repository'
  clone_repository

  echo -e ' \n\n---- It´ll create symbol links to files'
  create_files_link

  echo -e ' \n\n---- It´ll install the packages'
  install_pkgs

  echo -e ' \n\n---- It´ll install patched fonts for PowerLine/Lightline'
  install_fonts

  echo -e ' \n\n---- It´ll install vim plugins'
  install_vim_plugins

  echo -e ' \n\n---- It´ll install zsh highlighting'
  install_zsh_syntax_highlighting

  echo -e ' \n\n---- It´ll install custom packages'
  install_custom_pkgs

  echo -e ' \n\n---- It´ll change your default shell to zsh'
  chsh -s $(which zsh)

  echo -e ' \n\n---- It´ll make the last configs'
  set_final_config
}

function script_help(){
  echo
  echo "Uso: $0 OPTIONS"
  echo
  echo 'Options:'
  echo ' -i, --install       Install WS Dotfiles.'
  echo ' -r, --reinstall     Reinstall WS Dotfiles.'
}

set_os

case "$1" in

  --install|-i)
    install_dotfiles
    ;;

  --reinstall|-r)
    if check_previus_install; then
      sudo rm -rf "$HOME/.$WS_FOLDER"
      sudo rm -rf "$HOME/.zsh-syntax-highlighting"
      sudo rm -rf "$HOME/.$WS_FOLDER/gnome-terminal-colors-solarized"
    fi

    install_dotfiles
    ;;

  --test)
    echo -e ' \n\n- Testing it\n\n'
    ;;

  *)
    script_help
    ;;
esac
