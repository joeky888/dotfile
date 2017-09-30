FROM debian:unstable

RUN echo "deb http://ftp.tw.debian.org/debian/ testing main contrib non-free" > /etc/apt/sources.list
RUN echo "deb http://ftp.tw.debian.org/debian testing-updates main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb http://security.debian.org/ testing/updates main contrib non-free" >> /etc/apt/sources.list
RUN apt-get update && apt-get install curl -y

# Install basic development packages.
RUN curl -s https://raw.githubusercontent.com/j16180339887/dotfile/master/install.sh | bash

ENV EDITOR vim

CMD ["zsh"]
