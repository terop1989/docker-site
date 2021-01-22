FROM ubuntu:16.04

RUN apt-get -y update \
    && apt-get -y install apache2 \
    && echo "Hello from Kubernetes!" > /var/www/html/index.html

WORKDIR /var/www/html

CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]
EXPOSE 80
	
