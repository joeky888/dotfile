FROM debian:unstable

RUN echo "deb http://cdn-fastly.deb.debian.org/debian/ unstable main contrib non-free" > /etc/apt/sources.list
RUN apt update
RUN apt install -y curl nano gnupg locales
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment; \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen; \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf; \
    locale-gen en_US.UTF-8

ENV EDITOR nano

CMD ["bash"]

# docker build . -t debian:joeky
# docker run --name deb --net host -it debian:joeky bash

