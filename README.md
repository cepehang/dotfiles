# Chezmoi dotfiles

## HTTPS kickstart

Download standalone Chezmoi and apply.

```sh
GITHUB_USERNAME=cepehang
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

## SSH kickstart

Setup the SSH key

```sh
sudo pacman -S git openssh chezmoi

EMAIL=
ssh-keygen -t ed25519 -C "$EMAIL"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Add the SSH key to GitHub, then apply.

```sh
GITHUB_USERNAME=cepehang
chezmoi init --apply git@github.com:$GITHUB_USERNAME/dotfiles.git
```
