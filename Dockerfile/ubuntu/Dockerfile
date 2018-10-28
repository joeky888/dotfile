FROM ubuntu:devel

# Install basic development packages.
RUN sed -i "s/archive/tw.archive/" /etc/apt/sources.list
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

ENV CC clang
ENV CXX clang++

ENV EDITOR vim
