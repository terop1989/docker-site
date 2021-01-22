FROM ubuntu:16.04

RUN apt-get -y update \
    && apt-get -y install apache2

COPY index.html /var/www/html

WORKDIR /var/www/html

CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]
EXPOSE 80
	
