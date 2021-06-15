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
### Add an environment variable "DEVOPS=username to your docker image
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

docker run --rm web2 sh -c 'echo $DEVOPS'
v-kostyukov

````