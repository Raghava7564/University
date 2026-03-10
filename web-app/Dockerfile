FROM nginx:1.25-alpine

# Copy static assets
COPY ./static /usr/share/nginx/html/static
COPY ./templates /usr/share/nginx/html

# Copy nginx config (optional)
# COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
