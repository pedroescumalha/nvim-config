#!/bin/bash

set -e

echo "Starting setup..."

# Install Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew is already installed."
fi

# Install Git
if ! command -v git &>/dev/null; then
  echo "Installing Git..."
  brew install git
else
  echo "Git is already installed."
fi

# Configure Git
echo "Configuring Git..."
git config --global user.email "pedrosimoes93@gmail.com"
git config --global user.name "Pedro Simoes"
git config --global push.autoSetupRemote true
git config --global pull.rebase true

# Install GitHub CLI (gh)
if ! command -v gh &>/dev/null; then
  echo "Installing GitHub CLI..."
  brew install gh
else
  echo "GitHub CLI is already installed."
fi

# Authenticate with GitHub CLI
echo "Logging into GitHub..."
if ! gh auth status &>/dev/null; then
  gh auth login
  # Wait for successful login
  until gh auth status &>/dev/null; do
    echo "Waiting for successful GitHub login..."
    sleep 2
  done
  echo "Successfully logged into GitHub!"
else
  echo "Already logged into GitHub."
fi

# Configure GitHub CLI as Git credential helper
echo "Configuring GitHub CLI as Git credential helper..."
gh auth setup-git
echo "GitHub CLI successfully configured as Git credential helper."

# Install jq
if ! command -v jq &>/dev/null; then
  echo "Installing jq..."
  brew install jq
else
  echo "jq is already installed."
fi

# Install ripgrep
if ! command -v rg &>/dev/null; then
  echo "Installing ripgrep..."
  brew install ripgrep
else
  echo "ripgrep is already installed."
fi

# Install Neovim
if ! command -v nvim &>/dev/null; then
  echo "Installing Neovim..."
  brew install neovim
else
  echo "Neovim is already installed."
fi

# Clone Neovim config repository
CONFIG_DIR="$HOME/.config/nvim"
if [ ! -d "$CONFIG_DIR" ]; then
  echo "Cloning Neovim configuration..."
  git clone https://github.com/pedroescumalha/nvim-config "$CONFIG_DIR"
else
  echo "Neovim configuration is already cloned."
fi

# Install Neovim dependencies
echo "Installing Neovim dependencies..."
nvim --headless "+Lazy! sync" +qa

# Install Node.js (Latest LTS)
if ! command -v node &>/dev/null; then
  echo "Installing Node.js (Latest LTS)..."
  brew install node
else
  echo "Node.js is already installed."
fi

echo "Setup completed!"

# Install Warp Terminal
if ! brew list warp &>/dev/null; then
  echo "Installing Warp Terminal..."
  brew install --cask warp
else
  echo "Warp Terminal is already installed."
fi

# Add Warp Terminal to the Dock
APP_PATH="/Applications/Warp.app"
if [ -d "$APP_PATH" ]; then
  echo "Adding Warp Terminal to the Dock..."
  osascript <<EOF
tell application "System Events"
  set dockApps to name of every application process whose bundle identifier is "com.apple.dock"
  set appExists to false
  repeat with dockItem in dockApps
    if dockItem is "Warp" then
      set appExists to true
    end if
  end repeat
  if not appExists then
    tell application "Dock"
      quit
    end tell
    delay 1
    tell application "System Events" to make new dock item at end of dock items with properties {path:"$APP_PATH"}
    tell application "Dock"
      launch
    end tell
  else
    display notification "Warp is already in the Dock." with title "Dock Update"
  end if
end tell
EOF
else
  echo "Warp Terminal is not installed in /Applications. Skipping Dock addition."
fi

