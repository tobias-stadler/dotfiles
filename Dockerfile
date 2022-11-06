FROM fedora
RUN dnf update -y && dnf install -y git wget tar tmux neovim make gcc cmake stow zsh clang clang-tools-extra gdb bear ninja-build python3
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && git clone https://github.com/tobias-stadler/dotfiles ~/dotfiles && rm ~/.zshrc\
&& cd ~/dotfiles && git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim && nvim --headless -c "source nvim/.config/nvim/lua/plugins.lua" -c 'autocmd User PackerComplete quitall' -c 'PackerSync'\
&& git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions\
&& make stow.tmux stow.nvim stow.zsh && sed -i 's#powerlevel10k/powerlevel10k#robbyrussell#' ~/.zshrc && usermod --shell /bin/zsh root
RUN dnf update -y && dnf install -y qemu-system-riscv qemu-system-aarch64 qemu-system-x86 qemu-user qemu-img gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu
ENV TERM "xterm-256color"
ENTRYPOINT ["/bin/zsh"]