FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive

# Install core dependencies
RUN apt-get update && \
    apt-get install -y \
        curl \
        vim \
        git-core \
        supervisor

ADD supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install Nginx
#RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
#RUN echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" >> /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y nginx-full

ADD nginx/default.conf /etc/nginx/conf.d/default.conf

# Add user 'nginx' to administrators
RUN usermod -u 1000 www-data

# Install php-fpm
RUN apt-get update && \
    apt-get install -y \
        php5-cli \
        php5-curl \
        php5-fpm \
        php5-gd \
        php5-intl \
        php5-mcrypt \
        php5-pgsql \
        php5-sqlite \
        php5-mysql

# php-fpm config
ADD php/www.conf /etc/php5/fpm/pool.d/www.conf

# Install composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Add running sh on start
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# Setup public folder
ADD app /app

EXPOSE 80
WORKDIR /app
CMD ["/run.sh"]