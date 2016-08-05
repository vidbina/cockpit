FROM alpine:3.4
MAINTAINER David Asabina <vid@bina.me>
RUN apk add --no-cache ansible openssl py-pip &&
  pip install --upgrade pip
RUN pip install awscli
