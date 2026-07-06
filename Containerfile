FROM quay.io/toolbx/arch-toolbox:latest

# Packages
RUN pacman -Syu --noconfirm \
        `# Essentials` \
        neovim tmux lf git htop wl-clipboard \
        `# Misc` \
        jq ripgrep \
        awk file \
        `# Dev` \
        clang gcc libc++ llvm \
        cmake ninja \
        boost fmt \
        rustup \
        pyright nodejs \
        gdb lldb \
        lua-language-server \
        `# Misc` \
        yt-dlp ffmpeg speedtest-cli \
        ghostty-terminfo && \
        pacman -Scc --noconfirm

# Imports
COPY host-exec /usr/local/libexec/host-exec
RUN ln -s /usr/lib/flatpak-xdg-utils/xdg-open /usr/local/bin/xdg-open && \
    ln -s /usr/local/libexec/host-exec /usr/local/bin/podman && \
    ln -s /usr/local/libexec/host-exec /usr/local/bin/flatpak && \
    ln -s /usr/local/libexec/host-exec /usr/local/bin/toolbox

# Workarounds
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen && locale-gen

# Environment variables
ENV EDITOR=/usr/bin/nvim
ENV MANPAGER='/usr/bin/nvim +Man!'

ENV CC=clang
ENV CXX=clang
