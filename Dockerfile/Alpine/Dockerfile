FROM alpine

RUN apk update
RUN apk add --upgrade apk-tools@edge
RUN apk upgrade
RUN apk add nano openssh-server

ENV EDITOR nano

CMD ["ash"]
