FROM ubuntu:devel

# Install basic development packages.
RUN apt-get update -q \
 && apt-get upgrade -qy \
 && apt-get install -qy \
  build-essential \
  clang-3.9 \
  cmake \
  curl \
  gdb \
  vim \
  openssh-server \
ENV SHELL /bin/bash
ENV CC clang-3.9
ENV CXX clang++-3.9

ENV EDITOR vim
