#!/usr/bin/env sh
# Generate an Ed25519 SSH key and add it to the macOS Keychain.
# Run this once on a new machine.

set -e

KEY="$HOME/.ssh/id_ed25519"

# Ask for a key name/path so the user can create additional keys.
printf "SSH key file (default: %s): " "$KEY"
read -r key_input

if [ -n "$key_input" ]; then
  # Expand leading ~ to $HOME
  case "$key_input" in
    ~/*) key_input="$HOME/${key_input#~/}" ;;
  esac

  # If no directory component provided, place it in ~/.ssh/
  case "$key_input" in
    */*) KEY="$key_input" ;;
    *) KEY="$HOME/.ssh/$key_input" ;;
  esac
fi

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

# Try to default the comment/email to the git global user.email if available
default_email=""
if command -v git >/dev/null 2>&1; then
  default_email=$(git config --global user.email || true)
fi

printf "Email for SSH key comment"
if [ -n "$default_email" ]; then
  printf " (default: %s)" "$default_email"
fi
printf ": "
read -r email

if [ -z "$email" ]; then
  if [ -n "$default_email" ]; then
    email="$default_email"
  else
    printf "Error: email is required.\n"
    exit 1
  fi
fi

ssh-keygen -t ed25519 -C "$email" -f "$KEY"
ssh-add --apple-use-keychain "$KEY"

printf "\nPublic key (copy this to https://github.com/settings/ssh/new):\n\n"
cat "$KEY.pub"
printf "\n"
