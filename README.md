# Internship-2021
DevOps Exadel Internship 2021

## Task1: Git/GitHub
### Create a new local repository
``` git init ```
### Tell Git who you are
``` git config --global user.email "Your e-mail" && git config --global user.name "Your name" ```
### List the files you've changed and those you still need to add or commit
``` git status ```
### Commit changes to head (but not yet to the remote repository)
``` git commit -m “add .gitignore” ```
### Replace the tip of the current branch by creating a new commit
``` git commit --amend -m “comment” ```
### This form resets the current branch head to commit. Does not touch the index file or the working tree at all (but resets the head to commit, just like all modes do)
``` git reset --soft <commit> “comment” ```
### Used to record some new commits to reverse the effect of some earlier commits (often only a faulty one)
``` git revert <commit> “comment” ```
### Connect to a remote repository
``` git remote add origin <url>```
### Send changes to the master branch of your remote repository:
``` git push origin master ```
### Clones a repository into a newly created directory
``` git clone <url> ```
### Send changes to the master branch of your remote repository
``` git pull origin master ```   

## Task 2: AWS Cloud
### Install AWS CLI Linux
```
1. curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
2. unzip awscliv2.zip
3. sudo ./aws/install
4. aws --version
```
### Install AWS CLI Windows
``` https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html ```
### Configuration basics
``` aws configure ```
### URL web page "Hello world!" in AWS
``` http://52.30.126.226/ ```

## Task 3: Docker
### Install Docker Linux Ubuntu
```
1. sudo apt-get update
2. apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
3. curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
4. echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
5. sudo apt-get update
6. sudo apt-get install docker-ce docker-ce-cli containerd.io
```
### List all images that are locally stored with the Docker Engine
``` docker image ls ```
### Build an image from the Dockerfile in the current directory and tag the image
``` docker build -t myimage:1.0 . ```
### Run a container from the Alpine version 3.9 image, name the running container “web” 
### and expose port 5000 externally, mapped to port 80 inside the container.
``` docker container run --name web -p 5000:80 alpine:3.9 ```
### Stop a running container through SIGTERM 
``` docker container stop web ```
### Stop a running container through SIGKILL 
``` docker container kill web ```
### Delete an image from the local image store
``` docker image rm alpine:3.4 ```
### List the networks 
``` docker network ls ```
### List the running containers (add --all to include stopped containers)
``` docker container ls  ```
### Delete all running and stopped containers 
``` docker container rm -f $(docker ps -aq) ```
### Print the last 100 lines of a container’s logs 
``` docker container logs --tail 100 web ```
### Pull an image from a registry
``` docker pull myimage:1.0  ```
### Retag a local image with a new image name and tag 
``` docker tag myimage:1.0 myrepo/myimage:2.0 ```
### Push an image to a registry 
``` docker push myrepo/myimage:2.0 ```