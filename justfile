packages := "git npm ssh starship vim zsh ghostty"

default: apply

apply: apply-brewfile apply-dotfiles

apply-brewfile:
    @echo "Installing packages from Brewfile..."
    brew bundle install

apply-dotfiles:
    @echo "Stowing packages..."
    stow -v -t $HOME --restow {{ packages }}

init-git-local:
    @scripts/init-git-local.sh

init-ssh:
    @scripts/init-ssh.sh

macos-defaults:
    @scripts/macos-defaults.sh

clean:
    @echo "Unstowing packages..."
    stow -v -t $HOME -D {{ packages }}
