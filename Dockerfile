FROM php:5.6-apache

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y php5-gd php5-mysql php5-mcrypt && \
  rm -rf /var/lib/apt/lists/* 
  
RUN php5enmod mcrypt
RUN cp /etc/php5/mods-available/* /usr/local/etc/php/conf.d/
VOLUME /var/www/html

COPY docker-entrypoint.sh /entrypoint.sh
COPY upload-size.ini /etc/php5/mods-available/upload-size.ini

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]