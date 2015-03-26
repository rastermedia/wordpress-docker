FROM php:5.6-apache

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev && rm -rf /var/lib/apt/lists/* \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-install gd
RUN docker-php-ext-install mysqli
RUN echo "upload_max_filesize = 32M" >> /usr/local/etc/php/conf.d/ext-filesize.ini
RUN echo "post_max_size = 32M" >> /usr/local/etc/php/conf.d/ext-filesize.ini

VOLUME /var/www/html

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]