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
# In a terminal: xcode-select --installe


# Functions
function os_check() {
  if [[ "$(uname)" != "Darwin" ]]; then
    echo -e "This script should be run on macOS"
    exit 1
  else
    echo -e "Running on macOS"
  fi
}

function intro() {
  clear
  echo -e "🚀 macOS Setup 🚀\n"
}

function brew_install() {
  if [[ ! -x "$(command -v brew)" ]]; then
    echo -e "Homebrew isn't installed"
    echo -e "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    echo -e "Homebrew is installed"
  fi

  if [[ "$(brew tap)" != *"homebrew/cask"* ]]; then
    echo -e "Homebrew-Cask isn't installed"
    echo -e "Installing Homebrew-Cask"
    brew tap homebrew/cask
  else
    echo -e "Homebrew-Cask is installed"
  fi

  if [[ "$(brew tap)" != *"homebrew/cask-versions"* ]]; then
    echo -e "Homebrew-Cask-Versions isn't installed"
    echo -e "Installing Homebrew-Cask-Versions"
    brew tap homebrew/cask-versions
  else
    echo -e "Homebrew-Cask-Versions is installed"
  fi
}

function package_install_brew() {
  while read pkg ; do
      brew install ${pkg}
  done < brew-list.txt
}

function package_install_brew_cask() {
  while read pkg; do
      brew cask install ${pkg}
  done < brew-cask-list.txt
}

function package_install_mac_app_store() {
  while read pkg; do
      maspkg=${pkg%% *}
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
