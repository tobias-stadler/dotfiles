.PHONY: unstow stow.all stow.desktop stow.container pod-fed-dev pod-arch-dev-hw

packagedirs := nvim tmux tmpfiles zsh

stow.%:
	stow -v -R $* 

stow.all:
	stow -v -R $(packagedirs)

unstow:
	stow -v -D */

stow.desktop: stow.nvim stow.tmux stow.tmpfiles stow.zsh

stow.container: stow.nvim stow.tmux stow.zsh

pod-fed-dev:
	podman build -t fed-dev -f Dockerfiles/fed37-dev .

pod-arch-dev-hw:
	podman build -t arch-dev-hw -f Dockerfiles/arch-dev-hw .
