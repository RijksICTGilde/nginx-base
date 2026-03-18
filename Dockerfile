FROM nginxinc/nginx-unprivileged:1.26-alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY public/ /usr/share/nginx/html/

EXPOSE 8080
