FROM debian:unstable

RUN echo "deb http://ftp.tw.debian.org/debian/ unstable main contrib non-free" > /etc/apt/sources.list

# Install basic development packages.
RUN curl -s https://raw.githubusercontent.com/j16180339887/dotfile/master/install.sh | bash

ENV EDITOR vim
