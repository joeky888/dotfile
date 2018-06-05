FROM alpine

RUN echo "ipv6" >> /etc/modules
RUN echo "http://dl-1.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories; \
    echo "http://dl-2.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-3.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories; \
    echo "http://dl-5.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN apk update
# RUN apk add --upgrade --force apk-tools@edge
RUN apk upgrade
RUN apk add --update --no-cache micro openssh-server

ENV EDITOR micro

CMD ["ash"]
