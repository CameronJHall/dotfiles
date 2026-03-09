# dotfiles

A minimal, stow-based macOS development environment configuration.

## Quick Start

> requires brew and [just](https://github.com/casey/just) - `brew install just`

```bash
# Clone and enter the repo
git clone git@github.com:CameronJHall/dotfiles ~/.dotfiles
cd ~/.dotfiles

# Install Homebrew packages and apply dotfiles
just apply

# Configure machine-local identity and SSH
just init-git-local
just init-ssh

# Apply macOS system defaults (optional)
just macos-defaults
```

## Scripts

- `scripts/init-git-local.sh` -- Interactive Git identity and signing key setup
- `scripts/init-ssh.sh` -- Generate Ed25519 SSH key, add to Keychain
- `scripts/macos-defaults.sh` -- Apply opinionated macOS system defaults

## Usage

All recipes are in the `justfile`:

```bash
just apply          # Install Homebrew packages and stow all dotfiles
just init-git-local # Configure ~/.gitconfig.local (name, email, signing key)
just init-ssh       # Generate and configure SSH key
just macos-defaults # Apply macOS system defaults
just clean          # Unstow all packages
```

Machine-specific configuration (Git identity, SSH keys, npm init defaults) is kept out of version control. See scripts for setup details.
