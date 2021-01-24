FROM alpine:3.13

COPY app /opt/

RUN apk add --no-cache nginx \
    && mkdir -p /run/nginx

COPY custom.conf /etc/nginx/conf.d/

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80
	
