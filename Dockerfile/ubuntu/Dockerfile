FROM ubuntu:devel

# Install basic development packages.
RUN sed -i "s/archive/tw.archive" /etc/apt/sources.list
RUN apt update -q \
 && apt upgrade -qy \
 && apt install -qy \
  build-essential \
  clang \
  cmake \
  curl \
  gdb \
  vim \
  openssh-server

ENV CC clang
ENV CXX clang++

ENV EDITOR vim
