FROM alpine:3.13

RUN apk add --no-cache nginx \
    && mkdir -p /run/nginx

COPY custom.conf /etc/nginx/conf.d/

COPY . /opt/

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80
	
