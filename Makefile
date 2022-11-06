.PHONY: unstow stow.all desktop podman

stow.%:
	stow -v -R $* 

stow.all:
	stow -v -R */

unstow:
	stow -v -D */

desktop: stow.nvim stow.tmux stow.tmpfiles stow.zsh

podman:
	podman build -t tost .
