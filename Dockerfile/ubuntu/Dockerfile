FROM ubuntu:devel

RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt devel main restricted universe multiverse" > /etc/apt/sources.list; \
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt devel-updates main restricted universe multiverse" >> /etc/apt/sources.list; \
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt devel-backports main restricted universe multiverse" >> /etc/apt/sources.list; \
    echo "deb mirror://mirrors.ubuntu.com/mirrors.txt devel-security main restricted universe multiverse" >> /etc/apt/sources.list

RUN apt update -q
RUN apt upgrade -qy
RUN apt autoclean && apt clean
RUN apt install -qy build-essential curl vim locales

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment; \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen; \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf; \
    locale-gen en_US.UTF-8
ENV TZ Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV EDITOR vim

# docker build . -t ubuntu:joeky
# docker run --name u1 --net host -it ubuntu:joeky bash
# docker cp ~/dotfile/app-fast/app-fast u1:/bin/
# docker cp ~/dotfile/.bashrc u1:/root/
# docker cp ~/dotfile/vimrc/.vimrc u1:/root/
