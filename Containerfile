FROM registry.opensuse.org/opensuse/toolbox:latest

# Fix the defaults
RUN zypper --non-interactive rm \
        `# Enable docs` \
        zypp-excludedocs

# Packages
RUN \
    zypper --non-interactive ref && \
    zypper --non-interactive install \
        `# Enable CDN` \
        openSUSE-repos-Tumbleweed \
        `# Essentials` \
        neovim tmux lf git htop wl-clipboard \
        `# Misc` \
        jq ripgrep \
        awk file bc \
        openssh-clients \
        `# Dev` \
        clang gcc-c++ libc++-devel llvm \
        cmake ninja \
        boost-devel fmt-devel \
        rustup \
        gdb lldb \
        lua-language-server \
        `# Misc` \
        yt-dlp speedtest-cli && \
    zypper --non-interactive clean -a

# Imports
COPY host-exec /usr/local/libexec/host-exec
RUN \
    `# TODO: is it even needed? ln -s /usr/lib/flatpak-xdg-utils/xdg-open /usr/local/bin/xdg-open` && \
    ln -s /usr/local/libexec/host-exec /usr/local/bin/podman && \
    ln -s /usr/local/libexec/host-exec /usr/local/bin/flatpak

# Fix `sudo`
RUN install -m 440 /dev/stdin /etc/sudoers.d/toolbox <<< "%wheel ALL=(ALL) NOPASSWD: ALL" 

# Environment variables
ENV EDITOR=/usr/bin/nvim
ENV MANPAGER='/usr/bin/nvim +Man!'

ENV CC=clang
ENV CXX=clang++
