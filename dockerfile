FROM debian:wheezy

RUN apt-get update ; \
    apt-get upgrade -y ; \
    apt-get install -y apache2 php5 libapache2-mod-php5 ; \
    apt-get systemctl enable apache2 ; \
    apt-get systemctl start apache2

COPY apache2/000-default.conf /etc/apache2/sites-available/000-default.conf

RUN rm -rf /var/www/html/* && \
    mkdir /var/www/html/upload/ && \
    chmod 777 /var/www/html/upload/

ADD web/* /var/www/html/
ADD secret/* /var/www/

CMD ["apachectl", "-DFOREGROUND"]

EXPOSE 80