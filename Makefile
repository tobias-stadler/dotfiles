.PHONY: unstow stow.all desktop

stow.%:
	stow -v -R $* 

stow.all:
	stow -v -R */

unstow:
	stow -v -D */

desktop: stow.nvim stow.tmux stow.tmpfiles stow.zsh
