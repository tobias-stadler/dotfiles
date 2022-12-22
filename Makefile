.PHONY: unstow stow.all stow.desktop podman

packagedirs := nvim tmux tmpfiles zsh

stow.%:
	stow -v -R $* 

stow.all:
	stow -v -R $(packagedirs)

unstow:
	stow -v -D */

stow.desktop: stow.nvim stow.tmux stow.tmpfiles stow.zsh

stow.container: stow.nvim stow.tmux stow.zsh
