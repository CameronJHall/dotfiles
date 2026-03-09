#!/usr/bin/env sh
# Interactively populate ~/.gitconfig.local with user identity and signing key.
# Run this once on a new machine after stowing the git package.

set -e

TARGET="$HOME/.gitconfig.local"

if [ -f "$TARGET" ]; then
  printf "~/.gitconfig.local already exists.\n"
  printf "Overwrite? [y/N] "
  read -r overwrite
  case "$overwrite" in
    [yY]) ;;
    *) printf "Aborted.\n"; exit 0 ;;
  esac
fi

# Suggest defaults from any existing git config (e.g. system-level)
default_name="$(git config --system user.name 2>/dev/null || true)"
default_email="$(git config --system user.email 2>/dev/null || true)"
default_key="$HOME/.ssh/id_ed25519.pub"

printf "\nGit user name%s: " "${default_name:+ [$default_name]}"
read -r name
name="${name:-$default_name}"

printf "Git email%s: " "${default_email:+ [$default_email]}"
read -r email
email="${email:-$default_email}"

if [ -z "$name" ] || [ -z "$email" ]; then
  printf "Error: name and email are required.\n"
  exit 1
fi

printf "SSH signing key [%s]: " "$default_key"
read -r signing_key
signing_key="${signing_key:-$default_key}"

if [ ! -f "$signing_key" ]; then
  printf "Warning: %s does not exist. Run 'just init-ssh' first to generate a key.\n" "$signing_key"
  printf "Continue anyway? [y/N] "
  read -r cont
  case "$cont" in
    [yY]) ;;
    *) printf "Aborted.\n"; exit 0 ;;
  esac
fi

# Write the file using git config so the format is always canonical
git config --file "$TARGET" user.name "$name"
git config --file "$TARGET" user.email "$email"
git config --file "$TARGET" user.signingkey "$signing_key"

printf "\nWrote %s:\n\n" "$TARGET"
cat "$TARGET"
printf "\nRemember to add your public key to https://github.com/settings/ssh/new\n"
printf "Select 'Signing Key' as the key type.\n"
