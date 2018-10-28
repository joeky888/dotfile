FROM ubuntu:devel

# Install basic development packages.
RUN sed -i "s/archive/tw.archive/" /etc/apt/sources.list

RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt devel main restricted universe multiverse" > /etc/apt/sources.list; \
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt devel-updates main restricted universe multiverse" >> /etc/apt/sources.list; \
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt devel-backports main restricted universe multiverse" >> /etc/apt/sources.list; \
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt devel-security main restricted universe multiverse" >> /etc/apt/sources.list

RUN apt update -q \
 && apt upgrade -qy \
 && apt install -qy \
    build-essential \
    gnupg \
    curl \
    vim \
    openssh-server \
    locales
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment; \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen; \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf; \
    locale-gen en_US.UTF-8

ENV EDITOR vim

# docker build . -t ubuntu:joeky
# docker run --name u1 -it ubuntu:joeky bash
