FROM ubuntu

RUN apt-get update && apt-get install -y \
  apache2 \
  libapache2-mod-php5 \
  php5-gd \
  php5-mysql \
  php5-curl \
  php5-mcrypt \
  && php5enmod mcrypt

VOLUME /var/www/html

COPY docker-entrypoint.sh /entrypoint.sh
COPY upload-size.ini /etc/php5/mods-available/upload-size.ini

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2","-D","FOREGROUND"]