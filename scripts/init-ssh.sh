#!/usr/bin/env sh
# Generate an Ed25519 SSH key and add it to the macOS Keychain.
# Run this once on a new machine.

set -e

KEY="$HOME/.ssh/id_ed25519"

if [ -f "$KEY" ]; then
  printf "SSH key already exists at %s\n" "$KEY"
  printf "Overwrite? [y/N] "
  read -r overwrite
  case "$overwrite" in
    [yY]) ;;
    *) printf "Aborted.\n"; exit 0 ;;
  esac
fi

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

printf "Email for SSH key comment: "
read -r email

if [ -z "$email" ]; then
  printf "Error: email is required.\n"
  exit 1
fi

ssh-keygen -t ed25519 -C "$email" -f "$KEY"
ssh-add --apple-use-keychain "$KEY"

printf "\nPublic key (copy this to https://github.com/settings/ssh/new):\n\n"
cat "$KEY.pub"
printf "\n"
