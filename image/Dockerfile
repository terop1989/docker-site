FROM alpine:3.13

RUN apk add --no-cache nginx \
    && mkdir -p /run/nginx

COPY . /opt/

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80
