# Chezmoi dotfiles

Download standalone Chezmoi and apply. Chezmoi will then be reinstalled
through the OS package manager and the local installation will be deleted.

```sh
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply cepehang
```
