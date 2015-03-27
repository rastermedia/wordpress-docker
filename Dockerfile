FROM php:5.6-apache

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libmcrypt-dev && rm -rf /var/lib/apt/lists/* \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-install gd \
  && docker-php-ext-install mcrypt \
  && docker-php-ext-install mysqli

VOLUME /var/www/html

COPY docker-entrypoint.sh /entrypoint.sh
COPY upload-size.ini /usr/local/etc/php/conf.d/upload-size.ini

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]