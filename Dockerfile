FROM alpine:3.4
MAINTAINER David Asabina <vid@bina.me>
RUN apk add --no-cache ansible gnupg openssl py-pip
RUN pip install --no-cache-dir awscli
ARG KUBE_AWS_SIG
ARG KUBE_AWS_KEY
RUN gpg2 --keyserver pgp.mit.edu --recv-key $KUBE_AWS_KEY \
&& gpg2 --fingerprint $KUBE_AWS_KEY | sed -e 's/ //g' | grep "`echo $KUBE_AWS_SIG | sed -e 's/ //g'`" -q \
&& wget https://github.com/coreos/coreos-kubernetes/releases/download/v0.8.1/kube-aws-linux-amd64.tar.gz -O /tmp/kube-aws.tar.gz \
&&  wget https://github.com/coreos/coreos-kubernetes/releases/download/v0.8.1/kube-aws-linux-amd64.tar.gz.sig -O /tmp/kube-aws.tar.gz.sig \
&&  gpg2 --verify /tmp/kube-aws.tar.gz.sig /tmp/kube-aws.tar.gz \
&&  tar zxvf /tmp/kube-aws.tar.gz -C /tmp \
&&  mv /tmp/linux-amd64/kube-aws /usr/local/bin/kube-aws \
&&  rm -rf /tmp/kube-aws.tar.gz* /tmp/linux-amd64
VOLUME /infra
WORKDIR /infra
