FROM alpine

RUN apk update
RUN apk add --upgrade apk-tools@edge
RUN apk upgrade
RUN apk add micro openssh-server

ENV EDITOR micro

CMD ["ash"]
