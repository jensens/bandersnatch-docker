FROM ubuntu:python:3.6-slim

MAINTAINER "BlueDynamics Alliance" http://bluedynamics.com
LABEL name="bandersnatch update" \
      description="PYPI Mirror with bandersnatch, running all 2 minutes."

RUN apt-get update \
    && apt-get -y upgrade  \
    && apt-get -y dist-upgrade

RUN apt-get -y install \
        software-properties-common \
        python3-pip

RUN pip3 install -U pip chaperone \
  && useradd --system -U -u 500 runapps \
  && mkdir /etc/chaperone.d

COPY renew.sh /
COPY chaperone.yaml /etc/chaperone.d/chaperone.yaml

RUN bin/pip3 install -r https://bitbucket.org/pypa/bandersnatch/raw/stable/requirements.txt \
  && mkdir -p /etc/bandersnatch

COPY mirror.conf /etc/bandersnatch/mirror.conf

USER runapps

VOLUME /etc/bandersnatch
VOLUME /var/www/pypimirror

ENTRYPOINT ["/usr/local/bin/chaperone"]

