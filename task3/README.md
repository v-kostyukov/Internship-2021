### Bash script install docker linux ubuntu
``` docker_install.sh ``` 
### Download and run docker container hello-world
```
$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
b8dfde127a29: Pull complete
Digest: sha256:9f6ad537c5132bcce57f7a0a20e317228d382c3cd61edae14650eec68b2b345c
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```
### EXTRA 2.1. Use image with html page, edit html page and paste text: <Username> Sandbox 2021
``` docker run -it --rm -d -p 80:80 --name web -v ~/site-content:/usr/share/nginx/html nginx ```

![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task3/img/screen2.png)
````
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
--interactive , -i	Keep STDIN open even if not attached
--tty , -t          Allocate a pseudo-TTY
--rm                Automatically remove the container when it exits
--detach , -d       Run container in background and print container ID
--expose, -p        Expose a port or a range of ports
--name              Assign a name to the container
--volume , -v       Bind mount a volume
````
### 3.1 Dockerfile for building a docker image. Docker image run nginx. Web application located inside the docker image. 

``` 
docker build -t webserver .
Sending build context to Docker daemon  3.072kB
Step 1/2 : FROM nginx:latest
 ---> d1a364dc548d
Step 2/2 : COPY ./index.html /usr/share/nginx/html/index.html
 ---> 44f5fc17a0dd
Successfully built 44f5fc17a0dd
Successfully tagged webserver:latest

docker image ls
REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
webserver     latest    44f5fc17a0dd   20 seconds ago   133MB

docker run -it --rm -d -p 80:80 --name web webserver
docker ps
CONTAINER ID   IMAGE       COMMAND                  CREATED         STATUS         PORTS                               NAMES
32ad4dd9d7d7   webserver   "/docker-entrypoint.…"   5 seconds ago   Up 4 seconds   0.0.0.0:80->80/tcp, :::80->80/tcp   web

curl -v http://18.157.183.49
*   Trying 18.157.183.49:80...
* TCP_NODELAY set
* Connected to 18.157.183.49 (18.157.183.49) port 80 (#0)
> GET / HTTP/1.1
> Host: 18.157.183.49
> User-Agent: curl/7.68.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Server: nginx/1.21.0
< Date: Tue, 15 Jun 2021 18:28:56 GMT
< Content-Type: text/html
< Content-Length: 193
< Last-Modified: Tue, 15 Jun 2021 18:04:59 GMT
< Connection: keep-alive
< ETag: "60c8ebcb-c1"
< Accept-Ranges: bytes
<
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>3.1.</title>
</head>
<body>
  <h1>Hello from Nginx container</h1>
  <h1>Made by Vitaliy Kostyukov</h1>
</body>
</html>
* Connection #0 to host 18.157.183.49 left intact
```
### EXTRA 3.1.1. Create docker image use clear basic image ubuntu
``` 
docker build -t mywebserver .
Sending build context to Docker daemon  4.096kB
Step 1/5 : FROM ubuntu:18.04
 ---> 81bcf752ac3d
Step 2/5 : RUN apt-get update && apt-get install -y     build-essential     curl     wget     nginx   && rm -rf /var/lib/apt/lists/*
 ---> Using cache
 ---> b6047ba5b9d3
Step 3/5 : COPY ./index.html /var/www/html
 ---> 8f1cbf547ad2
Step 4/5 : EXPOSE 80
 ---> Running in 1b5d2f4e64b6
Removing intermediate container 1b5d2f4e64b6
 ---> c3acc232ba58
Step 5/5 : CMD ["nginx", "-g", "daemon off;"]
 ---> Running in 9f44a57fe93d
Removing intermediate container 9f44a57fe93d
 ---> 763c15c1546d
Successfully built 763c15c1546d
Successfully tagged mywebserver:latest

docker image ls
REPOSITORY    TAG       IMAGE ID       CREATED             SIZE
mywebserver   latest    763c15c1546d   7 seconds ago       333MB

docker run -it -d -p 80:80 --name myweb mywebserver
docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED         STATUS         PORTS                               NAMES
8f453c1874b0   mywebserver   "nginx -g 'daemon of…"   4 seconds ago   Up 3 seconds   0.0.0.0:80->80/tcp, :::80->80/tcp   myweb
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task3/img/screen3.png)
### 3.2 Add an environment variable "DEVOPS=username to your docker image
````
docker build -t web2 .
Sending build context to Docker daemon  3.072kB
Step 1/3 : FROM nginx:latest
 ---> d1a364dc548d
Step 2/3 : COPY ./index.html /usr/share/nginx/html/index.html
 ---> Using cache
 ---> 44f5fc17a0dd
Step 3/3 : ENV DEVOPS="v-kostyukov"
 ---> Running in 3719573cbf73
Removing intermediate container 3719573cbf73
 ---> 0a11598a54f4
Successfully built 0a11598a54f4
Successfully tagged web2:latest
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task3/img/screen4.png)
docker run --rm web2 sh -c 'echo $DEVOPS'
v-kostyukov
````
### EXTRA 3.2.1. Print environment variable with the value on a web page (if environment variable changed after container restart - the web page must be updated with a new value)
```
docker build -t my-php-app .
Sending build context to Docker daemon  4.096kB
Step 1/4 : FROM php:7.2-apache
7.2-apache: Pulling from library/php
6ec7b7d162b2: Pull complete
db606474d60c: Pull complete
afb30f0cd8e0: Pull complete
3bb2e8051594: Pull complete
4c761b44e2cc: Pull complete
c2199db96575: Pull complete
1b9a9381eea8: Pull complete
fd07bbc59d34: Pull complete
72b73ab27698: Pull complete
983308f4f0d6: Pull complete
6c13f026e6da: Pull complete
e5e6cd163689: Pull complete
5c5516e56582: Pull complete
154729f6ba86: Pull complete
Digest: sha256:4dc0f0115acf8c2f0df69295ae822e49f5ad5fe849725847f15aa0e5802b55f8
Status: Downloaded newer image for php:7.2-apache
 ---> c61d277263e1
Step 2/4 : COPY ./index.php /var/www/html
 ---> b3c842223c0a
Step 3/4 : ARG USERNAME="v-kostyukov"
 ---> Running in a7e56513b9f7
Removing intermediate container a7e56513b9f7
 ---> 5eaa95026c54
Step 4/4 : ENV DEVOPS=$USERNAME
 ---> Running in a566b92543e9
Removing intermediate container a566b92543e9
 ---> b4beb06ebb25
Successfully built b4beb06ebb25
Successfully tagged my-php-app:latest

docker run -d -p 80:80 --name myphpapp my-php-app
ubuntu@ip-172-31-6-210:~/3.2.1$ docker ps
CONTAINER ID   IMAGE        COMMAND                  CREATED         STATUS         PORTS                               NAMES
48a3be7b14d8   my-php-app   "docker-php-entrypoi…"   6 seconds ago   Up 5 seconds   0.0.0.0:80->80/tcp, :::80->80/tcp   myphpapp

docker exec -it myphpapp sh -c 'echo $DEVOPS'
v-kostyukov

docker run -it -d -p 80:80 -e "DEVOPS=KOSTYUKOV" my-php-app
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task3/img/screen5.png)
```