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
--interactive , -i		Keep STDIN open even if not attached
--tty , -t		    Allocate a pseudo-TTY
--rm		        Automatically remove the container when it exits
--detach , -d		Run container in background and print container ID
--expose, -p		Expose a port or a range of ports
--name		        Assign a name to the container
--volume , -v		Bind mount a volume
````
