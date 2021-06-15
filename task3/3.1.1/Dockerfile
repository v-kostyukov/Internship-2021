FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    wget \
    nginx \
  && rm -rf /var/lib/apt/lists/*

COPY ./index.html /var/www/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]