FROM debian:testing

RUN echo "deb http://cdn-fastly.deb.debian.org/debian/ testing main contrib non-free" > /etc/apt/sources.list
#RUN echo "deb http://cdn-fastly.deb.debian.org/debian-security testing/updates main contrib non-free" >> /etc/apt/sources.list
RUN apt update
RUN apt install -y curl gnupg vim locales
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment; \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen; \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf; \
    locale-gen en_US.UTF-8
ENV TZ Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV EDITOR vim

CMD ["bash"]

# docker build . -t debian:joeky
# docker run --name deb --net host -it debian:joeky bash
# docker cp ~/dotfile/app-fast/app-fast deb:/bin/
# docker cp ~/dotfile/.bashrc deb:/root/
# docker cp ~/dotfile/vimrc/.vimrc deb:/root/
