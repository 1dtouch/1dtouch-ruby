FROM ubuntu:12.04

MAINTAINER Aymeric Daurelle <aymeric42680@gmail.com>

ENV INSTALL_RUBY_VERSION=2.3.0 \
    CONFIGURE_OPTS=--disable-install-doc \
    BUNDLE_GEMFILE=/usr/src/app/Gemfile \
    BUNDLE_JOBS=2 \
    BUNDLE_PATH=/bundle \
    QMAKE=/opt/qt56/bin/qmake \
    QTDIR=/opt/qt56 \
    PATH=$QTDIR/bin:/root/.rbenv/bin:/root/.rbenv/shims:$PATH \
    CXX=g++-4.9 \
    CC=gcc-4.9

RUN DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y build-essential software-properties-common python-software-properties && \
    add-apt-repository ppa:git-core/ppa && \
    add-apt-repository ppa:beineri/opt-qt562 && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install -y git curl libssl-dev libreadline-dev zlib1g-dev \
                       g++-4.9 libc6-i386 qt56base qt56script qt56tools \
                       qt56svg qt56webkit libgl1-mesa-dev \
                       coffeescript imagemagick \
                       libreadline6-dev zlib1g zlib1g-dev readline-common libffi6 libffi-dev \
                       libwebkit-dev libpq-dev --fix-missing && \
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash && \
    echo 'eval "$(rbenv init -)"' >> /root/.bashrc && \
    rbenv install $INSTALL_RUBY_VERSION && \
    rbenv global $INSTALL_RUBY_VERSION && \
    gem install bundler \
                foreman \
                execjs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
