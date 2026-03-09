#!/usr/bin/env sh
# Apply opinionated macOS system defaults.
# Some changes require a logout or restart to take effect.

set -e

printf "Applying macOS defaults...\n\n"

# ── Keyboard ─────────────────────────────────────────────────
printf "Keyboard: fast key repeat\n"
# Set a fast key repeat rate (lower = faster, normal is 6)
defaults write NSGlobalDomain KeyRepeat -int 4
# Short delay before repeat starts (lower = shorter, normal is 25)
defaults write NSGlobalDomain InitialKeyRepeat -int 20
# Disable press-and-hold for accented characters in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# ── Finder ───────────────────────────────────────────────────
printf "Finder: developer-friendly defaults\n"
# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
# Show path bar at bottom of Finder window
defaults write com.apple.finder ShowPathbar -bool true
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Default to list view (icnv = icon, clmv = column, glyv = gallery)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# ── Screenshots ──────────────────────────────────────────────
printf "Screenshots: save to ~/Screenshots, no shadow\n"
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
# Disable drop shadow on screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# ── Restart affected apps ────────────────────────────────────
printf "\nRestarting Finder and SystemUIServer to apply changes...\n"
killall Finder 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

printf "Done. Some changes (keyboard) may require a logout to take effect.\n"
