FROM alpine

RUN echo "ipv6" >> /etc/modules
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main/" > /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories
RUN apk update
RUN apk add --upgrade --force apk-tools
RUN apk upgrade
RUN apk add --update --no-cache micro openssh-server

ENV EDITOR micro

CMD ["ash"]
