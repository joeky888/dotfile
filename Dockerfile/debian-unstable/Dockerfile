FROM debian:unstable

RUN echo "deb http://ftp.tw.debian.org/debian/ unstable main contrib non-free" > /etc/apt/sources.list
RUN apt update
RUN apt install -y curl nano gnupg

ENV EDITOR nano

CMD ["bash"]
