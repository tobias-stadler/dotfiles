.PHONY: unstow stow.all

packagedirs := nvim tmux tmpfiles zsh

stow.%:
	stow -v -R $* 

stow.all:
	stow -v -R $(packagedirs)

unstow:
	stow -v -D */

pod.%:
	podman build -t $* -f Dockerfiles/$* .


stow-container: stow.nvim stow.tmux stow.zsh
stow-desktop: stow-container

omz:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

no-powerlevel:
	sed -i 's#powerlevel10k/powerlevel10k#robbyrussell#' ~/.zshrc

mac:
	brew install neovim tmux

fedora:
	dnf update -y
	dnf install -y git curl wget tar tmux neovim make gcc cmake stow zsh clang clang-tools-extra gdb bear ninja-build python3 python3-pip libasan ripgrep perf llvm llvm-devel
	make omz
	rm ~/.zshrc
	make stow-container

fedora-umbra:
	dnf install -y boost-devel libpq-devel libasan re2-devel bison-devel bison liburing-devel zlib-devel libzstd-devel jemalloc-devel

ubuntu:
	apt update -y
	apt upgrade -y
	apt install -y git wget curl tar tmux neovim make gcc cmake stow zsh clang clang-format gdb bear ninja-build python3 python3-pip ripgrep gdb-multiarch gcc-aarch64-linux-gnu qemu-user-static binutils-aarch64-linux-gnu
	make install.omz
	rm ~/.zshrc
	make stow.container

