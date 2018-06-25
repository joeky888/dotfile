FROM ubuntu:devel

# Install basic development packages.
RUN apt-get update -q \
 && apt-get upgrade -qy \
 && apt-get install -qy \
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
