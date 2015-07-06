FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive

# Install core dependencies
RUN apt-get update && \
    apt-get install -y \
        curl \
        vim \
        git-core \
        supervisor

RUN apt-get update && \
    apt-get install -y \
        php5-cli \
        php5-curl \
        php5-fpm \
        php5-gd \
        php5-intl \
        php5-mcrypt \
        php5-mysql

