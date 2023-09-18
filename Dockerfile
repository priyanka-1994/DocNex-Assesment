FROM nginx:alpine

COPY index.html /usr/share/nginx/html
COPY style.css /usr/share/nginx/html
COPY /images /usr/share/nginx/html

RUN chmod 644 /usr/share/nginx/html/index.html
RUN chmod 644 /usr/share/nginx/html/style.css

CMD ["nginx", "-g", "daemon off;"]

