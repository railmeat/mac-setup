#!/bin/bash

# Description: Setup macOS
# Original author: Jacob Woffenden
# Customized for MattJ. Thanks Jacob
# use "bash strict mode", see:
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
# https://sipb.mit.edu/doc/safe-shell/
set -e
set -u
set -o pipefail
IFS=$'\n\t'

# This depends on Xcode command line tools, which have to be installed manually.
# In a terminal: xcode-select --install


# Functions
function os_check() {
  if [[ "$(uname)" != "Darwin" ]]; then
    echo "This script should be run on MacOS"
    exit 1
  else
    echo "Running on MacOS"
  fi
}

function intro() {
  clear
  echo "🚀 macOS Setup 🚀\n"
}

function brew_install() {
  if [[ ! -x "$(command -v brew)" ]]; then
    echo "Homebrew isn't installed"
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew is installed"
  fi
}

function package_install_brew() {
  while read pkg ; do
      brew install ${pkg}
  done < brew-list.txt
}

function package_install_brew_cask() {
  while read pkg ; do
      brew install ${pkg}
  done < brew-cask-list.txt
}

function package_install_mac_app_store() {
  while read pkg; do
      maspkg=${pkg%% *}
      echo "Installing Mac App Store application: ${maspkg}"
      mas install ${maspkg}
  done < mas-list.txt
}

# Script
os_check
intro
brew_install
package_install_brew
package_install_brew_cask
package_install_mac_app_store
