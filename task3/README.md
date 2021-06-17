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
```
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
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task3/img/screen4.png)
```
docker run --rm web2 sh -c 'echo $DEVOPS'
v-kostyukov
```
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
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task3/img/screen5.png)
![docker_environment_build_args_overview](https://github.com/v-kostyukov/Internship-2021/blob/master/task3/img/docker_environment_build_args_overview.png)
### 4 Push your docker image to docker hub (https://hub.docker.com/)
```
https://hub.docker.com/repository/docker/kostyukov/my-php-app
```
### Login to a registry
```
docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: 
Password:
WARNING! Your password will be stored unencrypted in /home/ubuntu/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
```
### Create a tag
```
docker tag my-php-app:latest kostyukov/my-php-app:1.0
docker images
REPOSITORY             TAG          IMAGE ID       CREATED        SIZE
kostyukov/my-php-app   1.0          b4beb06ebb25   15 hours ago   410MB
my-php-app             latest       b4beb06ebb25   15 hours ago   410MB
```
### Push an image or a repository to a registry
``` 
docker push kostyukov/my-php-app:1.0
The push refers to repository [docker.io/kostyukov/my-php-app]
b661f7cb2447: Pushed
5dc980197467: Mounted from library/php
cc45506c4447: Mounted from library/php
6ec4d4ce53cc: Mounted from library/php
9a60d912a14f: Mounted from library/php
ce60a0c97d4a: Mounted from library/php
e1cd0107ea85: Mounted from library/php
914a1eddd57a: Mounted from library/php
0ff9183bd099: Mounted from library/php
d666585087a1: Mounted from library/php
bc0429138e0d: Mounted from library/php
02eef72b445f: Mounted from library/php
e45a78df7536: Mounted from library/php
ddcd8d2fcf7e: Mounted from library/php
87c8a1d8f54f: Mounted from library/php
1.0: digest: sha256:b22610adb3da5c88958a8628fc9dfdfe5dc991ce117d51d6b29b2cd9f58f5707 size: 3449
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task3/img/docker_hub.png)
### EXTRA 4.1. Integrate docker image to github repository. Create an automatic deployment for each push.
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task3/img/docker_hub_builds.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task3/img/docker_hub_tags.png)
### Create docker-compose file. EXTRA 5.1. Use env files to configure each service.
### Install docker-compose
````
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
````
### Docker build
```
root@u2004:/home/vk/spring-petclinic# docker build --tag java-docker .
Sending build context to Docker daemon  9.032MB
Step 1/7 : FROM openjdk:16-alpine3.13
16-alpine3.13: Pulling from library/openjdk
4c0d98bf9879: Pull complete
6f1834e342ac: Pull complete
78f4563ac5cf: Pull complete
Digest: sha256:49d822f4fa4deb5f9d0201ffeec9f4d113bcb4e7e49bd6bc063d3ba93aacbcae
Status: Downloaded newer image for openjdk:16-alpine3.13
 ---> 2aa8569968b8
Step 2/7 : WORKDIR /app
 ---> Running in 3f3e91fedfce
Removing intermediate container 3f3e91fedfce
 ---> d374b128d4fc
Step 3/7 : COPY .mvn/ .mvn
 ---> ab4615dea163
Step 4/7 : COPY mvnw pom.xml ./
 ---> a35fd4195da6
Step 5/7 : RUN ./mvnw dependency:go-offline
 ---> Running in bc6b8f74098f
[INFO] Scanning for projects...
Downloading from spring-snapshots: https://repo.spring.io/snapshot/org/springframework/boot/spring-boot-starter-parent/2.4.5/spring-boot-starter-parent-2.4.5.pom
Downloading from spring-milestones: https://repo.spring.io/milestone/org/springframework/boot/spring-boot-starter-parent/2.4.5/spring-boot-starter-parent-2.4.5.pom
Downloading from central: https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-starter-parent/2.4.5/spring-boot-starter-parent-2.4.5.pom
...
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  07:13 min
[INFO] Finished at: 2021-06-17T05:33:36Z
[INFO] ------------------------------------------------------------------------
Removing intermediate container bc6b8f74098f
 ---> cb25f2ee8b0c
Step 6/7 : COPY src ./src
 ---> 63bbcf6ef261
Step 7/7 : CMD ["./mvnw", "spring-boot:run"]
 ---> Running in c896650ffbf4
Removing intermediate container c896650ffbf4
 ---> de620f2d47bb
Successfully built de620f2d47bb
Successfully tagged java-docker:latest

docker images
REPOSITORY    TAG             IMAGE ID       CREATED          SIZE
java-docker   latest          de620f2d47bb   40 seconds ago   574MB
openjdk       16-alpine3.13   2aa8569968b8   4 months ago     324MB
```
### Docker Compose
```
docker-compose up -d
Creating network "spring-petclinic_default" with the default driver
Creating volume "spring-petclinic_mysql_data" with default driver
Creating volume "spring-petclinic_mysql_config" with default driver
Pulling worker (kostyukov/my-php-app:)...
latest: Pulling from kostyukov/my-php-app
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
984b3e4aa5ef: Pull complete
Digest: sha256:7f2749f3f1dc0df5caddfcbe35a23fc24509f971f5010a7133650bfd4e382da8
Status: Downloaded newer image for kostyukov/my-php-app:latest
Pulling mysqlserver (mysql:8.0.23)...
8.0.23: Pulling from library/mysql
f7ec5a41d630: Pull complete
9444bb562699: Pull complete
6a4207b96940: Pull complete
181cefd361ce: Pull complete
8a2090759d8a: Pull complete
15f235e0d7ee: Pull complete
d870539cd9db: Pull complete
5726073179b6: Pull complete
eadfac8b2520: Pull complete
f5936a8c3f2b: Pull complete
cca8ee89e625: Pull complete
6c79df02586a: Pull complete
Digest: sha256:6e0014cdd88092545557dee5e9eb7e1a3c84c9a14ad2418d5f2231e930967a38
Status: Downloaded newer image for mysql:8.0.23
Building petclinic
Sending build context to Docker daemon  9.036MB
Step 1/7 : FROM openjdk:16-alpine3.13
 ---> 2aa8569968b8
Step 2/7 : WORKDIR /app
 ---> Using cache
 ---> d374b128d4fc
Step 3/7 : COPY .mvn/ .mvn
 ---> Using cache
 ---> ab4615dea163
Step 4/7 : COPY mvnw pom.xml ./
 ---> Using cache
 ---> a35fd4195da6
Step 5/7 : RUN ./mvnw dependency:go-offline
 ---> Using cache
 ---> cb25f2ee8b0c
Step 6/7 : COPY src ./src
 ---> Using cache
 ---> 63bbcf6ef261
Step 7/7 : CMD ["./mvnw", "spring-boot:run"]
 ---> Using cache
 ---> de620f2d47bb
Successfully built de620f2d47bb
Successfully tagged spring-petclinic_petclinic:latest
WARNING: Image for service petclinic was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Creating spring-petclinic_worker_1      ... done
Creating spring-petclinic_worker_2      ... done
Creating spring-petclinic_worker_3      ... done
Creating spring-petclinic_worker_4      ... done
Creating spring-petclinic_worker_5      ... done
Creating spring-petclinic_mysqlserver_1 ... done
Creating spring-petclinic_petclinic_1   ... done
 
docker ps
CONTAINER ID   IMAGE                        COMMAND                  CREATED          STATUS          PORTS                                                                                  NAMES
703b31f98470   spring-petclinic_petclinic   "./mvnw spring-boot:…"   18 seconds ago   Up 12 seconds   0.0.0.0:8000->8000/tcp, :::8000->8000/tcp, 0.0.0.0:8080->8080/tcp, :::8080->8080/tcp   spring-petclinic_                           petclinic_1
8929ed1820b1   kostyukov/my-php-app         "docker-php-entrypoi…"   22 seconds ago   Up 12 seconds   80/tcp                                                                                 spring-petclinic_                           worker_3
299b97c89672   kostyukov/my-php-app         "docker-php-entrypoi…"   22 seconds ago   Up 13 seconds   80/tcp                                                                                 spring-petclinic_                           worker_1
07f0bac51698   kostyukov/my-php-app         "docker-php-entrypoi…"   22 seconds ago   Up 12 seconds   80/tcp                                                                                 spring-petclinic_                           worker_4
94cfa9db3131   kostyukov/my-php-app         "docker-php-entrypoi…"   22 seconds ago   Up 14 seconds   80/tcp                                                                                 spring-petclinic_                           worker_2
2af86c9bbf2d   mysql:8.0.23                 "docker-entrypoint.s…"   22 seconds ago   Up 17 seconds   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp                                   spring-petclinic_                           mysqlserver_1
9234af892df9   kostyukov/my-php-app         "docker-php-entrypoi…"   22 seconds ago   Up 12 seconds   80/tcp                                                                                 spring-petclinic_                           worker_5
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task3/img/spring.png)

