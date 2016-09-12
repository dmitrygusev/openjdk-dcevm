FROM openjdk:8-jdk

MAINTAINER dmitrygusev

ENV TERM=dumb
ENV DCEVM_TAG=light-jdk8u92+1

RUN apt-get update && apt-get install -y \
    g++ \
    gcc \
    git \
    make \
    mercurial \
    \
 && printf "[extensions]\nmq=\n" > ~/.hgrc \
 && git clone --branch $DCEVM_TAG --depth 1 https://github.com/dcevm/dcevm.git \
 && cd dcevm \
 && ./gradlew \
    patch \
    compileProduct \
    installProduct -PtargetJre=$JAVA_HOME/jre \
 && cd .. \
 && rm -rf ./dcevm \
 && apt-get purge -y \
    g++ \
    gcc \
    git \
    make \
    mercurial \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*
