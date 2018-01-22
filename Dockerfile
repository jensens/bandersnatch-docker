FROM python:3.6-slim-stretch

MAINTAINER "BlueDynamics Alliance" http://bluedynamics.com
LABEL name="bandersnatch update" \
      description="PYPI Mirror with bandersnatch, running all 2 minutes."

RUN apt-get update \
    && apt-get -y upgrade  \
    && apt-get -y dist-upgrade \
    && apt-get -y install \
        software-properties-common \
        python3-pip \
    && pip3 install -U pip chaperone \
    && useradd --system -U -u 500 runapps \
    && pip3 install -r https://bitbucket.org/pypa/bandersnatch/raw/stable/requirements.txt

COPY chaperone.yaml /etc/chaperone.d/chaperone.yaml
COPY bandersnatch.conf /etc/
COPY update.sh /

USER runapps

VOLUME /data
RUN mkdir /data/mirror \
    && chown runapps /data/mirror

ENTRYPOINT ["/usr/local/bin/chaperone"]

