FROM debian:testing

RUN echo "deb http://ftp.tw.debian.org/debian/ testing main contrib non-free" > /etc/apt/sources.list
RUN echo "deb http://ftp.tw.debian.org/debian testing-updates main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb http://security.debian.org/ testing/updates main contrib non-free" >> /etc/apt/sources.list
RUN apt update
RUN apt install -y curl gnupg nano

ENV EDITOR nano

CMD ["bash"]
