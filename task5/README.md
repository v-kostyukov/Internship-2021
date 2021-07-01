### Install jenkins with ansible playbook
``` 
ansible-playbook jenkins.yml --syntax-check

playbook: jenkins.yml

ansible-playbook jenkins.yml

PLAY [Install jenkins] **********************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************************************************************************************
ok: [192.168.0.155]

TASK [docker : Update repositories cache and install docker dependencies] *******************************************************************************************************************************************************************
ok: [192.168.0.155] => (item=apt-transport-https)
ok: [192.168.0.155] => (item=ca-certificates)
ok: [192.168.0.155] => (item=software-properties-common)
ok: [192.168.0.155] => (item=curl)
ok: [192.168.0.155] => (item=gnupg)
ok: [192.168.0.155] => (item=lsb-release)

TASK [docker : Add docker repo apt key] *****************************************************************************************************************************************************************************************************
changed: [192.168.0.155]

TASK [docker : Add Docker Repository] *******************************************************************************************************************************************************************************************************
changed: [192.168.0.155]

TASK [docker : Update apt and install docker] ***********************************************************************************************************************************************************************************************
changed: [192.168.0.155] => (item=docker-ce)
ok: [192.168.0.155] => (item=docker-ce-cli)
ok: [192.168.0.155] => (item=containerd.io)

TASK [docker : Start and enable systemd service docker] *************************************************************************************************************************************************************************************
ok: [192.168.0.155]

TASK [docker : Add user to docker group] ****************************************************************************************************************************************************************************************************
changed: [192.168.0.155] => (item=ubuntu)
changed: [192.168.0.155] => (item=ansible)

TASK [docker : Install docker-compose] ******************************************************************************************************************************************************************************************************
changed: [192.168.0.155]

TASK [docker : Create a symbolic link] ******************************************************************************************************************************************************************************************************
changed: [192.168.0.155]

TASK [jenkins : Create a directories] *******************************************************************************************************************************************************************************************************
changed: [192.168.0.155] => (item=jenkins)
changed: [192.168.0.155] => (item=nginx)

TASK [jenkins : Create docker-compose.yml file] *********************************************************************************************************************************************************************************************
changed: [192.168.0.155]

TASK [jenkins : Deploy Docker Compose] ******************************************************************************************************************************************************************************************************
changed: [192.168.0.155]

TASK [jenkins : Deploy WP Nginx virtual host] ***********************************************************************************************************************************************************************************************
changed: [192.168.0.155]

TASK [jenkins : Run docker-compose] *********************************************************************************************************************************************************************************************************
changed: [192.168.0.155]

PLAY RECAP **********************************************************************************************************************************************************************************************************************************
192.168.0.155              : ok=14   changed=11   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins2.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins3.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins4.png)
### Information about jenkins server
``` 
jenkins_server/systemInfo

http://192.168.0.155/systemInfo
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins5.png)
### Creating and run Docker agent
``` 
docker run -d --rm --name=agent1 -p 22:22 \
-e "JENKINS_AGENT_SSH_PUBKEY=[your-public-key]" \
jenkins/ssh-agent:alpine

VARS1="HOME=|USER=|MAIL=|LC_ALL=|LS_COLORS=|LANG="
VARS2="HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_="
VARS="${VARS1}|${VARS2}"
docker exec agent1 sh -c "env | egrep -v '^(${VARS})' >> /etc/environment"

docker ps
CONTAINER ID   IMAGE                      COMMAND        CREATED          STATUS          PORTS                                     NAMES
1233c743aff8   jenkins/ssh-agent:alpine   "setup-sshd"   4 minutes ago    Up 4 minutes    0.0.0.0:20022->22/tcp, :::20022->22/tcp   agent2
9bbc32586389   jenkins/ssh-agent:alpine   "setup-sshd"   44 minutes ago   Up 44 minutes   0.0.0.0:22->22/tcp, :::22->22/tcp         agent1
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins6.png)
### Create a freestyle project. Which will display the current time as a result of execution.
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins7.png)
### Snippet Generator
``` 
${YOUR_JENKINS_URL}/pipeline-syntax
```
### Global Variable Reference
``` 
${YOUR_JENKINS_URL}/pipeline-syntax/globals#env
```
### Declarative Directive Generator
``` 
${YOUR_JENKINS_URL}/directive-generator
```
### Create a Pipeline that will execute the command docker ps -a on the host
```
pipeline {
    agent any

    stages {
        stage('stage1') {
            agent {
                label 'agent3'
            }
            steps {
                sh("docker ps -a")
            }
        }
    }
}
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins8.png)
### Create a Pipeline that will pull code from repository and build a docker image from your Dockerfile
``` 
pipeline {
    agent {
            label 'agent3'
          }
    stages {
        stage('1-Build') {
            steps {
                echo "Start of Stage Build"
                sh "pwd"
                dir('task3/3.2/') {
                    sh """
                        pwd
                        ls -la
                        docker build -t php-app .
                    """
                }
                echo "End of Stage Build"
            }
        }
        stage('2-Test') {
            steps {
                echo "Start of Stage Test"
                sh """
                    pwd
                    docker image ls
                """
                echo "End of Stage Test"
            }
        }
        stage('3-Deploy') {
            steps {
                echo "Start of Stage Deploy"
                echo "Deploying......."
                echo "End of Stage Deploy"
            }
        }
    }
}
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins9.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins10.png)
### Console output
``` 
Started by user admin
Obtained task5/Jenkinsfile from git git@github.com:v-kostyukov/Internship-2021.git
Running in Durability level: MAX_SURVIVABILITY
[Pipeline] Start of Pipeline
[Pipeline] node
Running on agent3 in /home/jenkins/workspace/Deploy-to-prod
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential github-ssh
Fetching changes from the remote Git repository
 > git rev-parse --resolve-git-dir /home/jenkins/workspace/Deploy-to-prod/.git # timeout=10
 > git config remote.origin.url git@github.com:v-kostyukov/Internship-2021.git # timeout=10
Fetching upstream changes from git@github.com:v-kostyukov/Internship-2021.git
 > git --version # timeout=10
 > git --version # 'git version 2.25.1'
using GIT_SSH to set credentials githun-ssh
 > git fetch --tags --force --progress -- git@github.com:v-kostyukov/Internship-2021.git +refs/heads/*:refs/remotes/origin/* # timeout=10
Checking out Revision 099278329b52d05e94021196abf461af4aec018e (refs/remotes/origin/master)
Commit message: "change file task5/Jenkinsfile"
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 099278329b52d05e94021196abf461af4aec018e # timeout=10
 > git rev-list --no-walk 0eb78351dec9f5919adcedf87de172bc46be024d # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (1-Build)
[Pipeline] echo
Start of Stage Build
[Pipeline] sh
+ pwd
/home/jenkins/workspace/Deploy-to-prod
[Pipeline] dir
Running in /home/jenkins/workspace/Deploy-to-prod/task3/3.2
[Pipeline] {
[Pipeline] sh
+ pwd
/home/jenkins/workspace/Deploy-to-prod/task3/3.2
+ ls -la
total 20
drwxrwxr-x  2 jenkins jenkins 4096 Jun 27 10:39 .
drwxrwxr-x 10 jenkins jenkins 4096 Jun 27 10:40 ..
-rw-rw-r--  1 jenkins jenkins   96 Jun 27 10:39 Dockerfile
-rw-rw-r--  1 jenkins jenkins  112 Jun 27 10:39 .dockerignore
-rw-rw-r--  1 jenkins jenkins  192 Jun 27 10:39 index.html
+ docker build -t php-app .
Sending build context to Docker daemon  4.096kB

Step 1/3 : FROM nginx:latest
 ---> d1a364dc548d
Step 2/3 : COPY ./index.html /usr/share/nginx/html/index.html
 ---> ced017050a3f
Step 3/3 : ENV DEVOPS="v-kostyukov"
 ---> Running in 4f4a0e2c0e8e
Removing intermediate container 4f4a0e2c0e8e
 ---> 411a3dfd5932
Successfully built 411a3dfd5932
Successfully tagged php-app:latest
[Pipeline] }
[Pipeline] // dir
[Pipeline] echo
End of Stage Build
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (2-Test)
[Pipeline] echo
Start of Stage Test
[Pipeline] sh
+ pwd
/home/jenkins/workspace/Deploy-to-prod
+ docker image ls
REPOSITORY                   TAG             IMAGE ID       CREATED        SIZE
php-app                      latest          411a3dfd5932   1 second ago   133MB
java-docker                  latest          de620f2d47bb   10 days ago    574MB
spring-petclinic_petclinic   latest          de620f2d47bb   10 days ago    574MB
kostyukov/my-php-app         latest          d3f9c54c5648   10 days ago    410MB
wordpress                    php7.4-fpm      b0d791fbc5fa   3 weeks ago    542MB
jenkins/jenkins              lts-jdk11       416c6656c1cd   3 weeks ago    684MB
jenkins/jenkins              lts             0af90866343f   3 weeks ago    573MB
nginx                        latest          d1a364dc548d   4 weeks ago    133MB
mysql                        5.7             2c9028880e58   6 weeks ago    447MB
mysql                        latest          c0cdc95609f1   6 weeks ago    556MB
mysql                        8.0.23          cbe8815cbea8   2 months ago   546MB
jenkins/ssh-agent            alpine          f922a66329e7   3 months ago   231MB
openjdk                      16-alpine3.13   2aa8569968b8   4 months ago   324MB
[Pipeline] echo
End of Stage Test
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (3-Deploy)
[Pipeline] echo
Start of Stage Deploy
[Pipeline] echo
Deploying.......
[Pipeline] echo
End of Stage Deploy
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins11.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins12.png)
### Pass variable encrypted to docker container
``` 
pipeline {
    agent {
            label 'agent3'
          }
     environment {
        PASSWORD = credentials('docker-secret')
    }
    stages {
        stage('1-Build') {
            steps {
                echo "Start of Stage Build"
                sh "pwd"
                dir('task3/3.2/') {
                    sh """
                        pwd
                        ls -la
                        docker build -t php-app .
                    """
                }
                echo "End of Stage Build"
            }
        }
        stage('2-Test') {
            steps {
                echo "Start of Stage Test"
                sh """
                    pwd
                    docker image ls
                """
                echo "End of Stage Test"
            }
        }
        stage('3-Deploy') {
            steps {
                echo "Start of Stage Deploy"
                sh """
                    docker run -it -d -p 80:80 -e "PASSWORD=$PASSWORD" php-app
                    docker ps
                """
                echo "End of Stage Deploy"
            }
        }
    }
}
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins13.png)
### Console output
``` 
Started by user admin
Obtained task5/Jenkinsfile2 from git git@github.com:v-kostyukov/Internship-2021.git
Running in Durability level: MAX_SURVIVABILITY
[Pipeline] Start of Pipeline
[Pipeline] node
Running on agent3 in /home/jenkins/workspace/Deploy-to-prod-env
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential github-ssh
Fetching changes from the remote Git repository
 > git rev-parse --resolve-git-dir /home/jenkins/workspace/Deploy-to-prod-env/.git # timeout=10
 > git config remote.origin.url git@github.com:v-kostyukov/Internship-2021.git # timeout=10
Fetching upstream changes from git@github.com:v-kostyukov/Internship-2021.git
 > git --version # timeout=10
 > git --version # 'git version 2.25.1'
using GIT_SSH to set credentials githun-ssh
 > git fetch --tags --force --progress -- git@github.com:v-kostyukov/Internship-2021.git +refs/heads/*:refs/remotes/origin/* # timeout=10
Checking out Revision 6fc1ff59d908ce19eb7958f24dfc5d31eda70c6c (refs/remotes/origin/master)
Commit message: "change file task5/Jenkinsfile2"
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 6fc1ff59d908ce19eb7958f24dfc5d31eda70c6c # timeout=10
 > git rev-list --no-walk e8ee2fa5ea124ff3adbc3489580cd92159dec96f # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] withCredentials
Masking supported pattern matches of $PASSWORD
[Pipeline] {
[Pipeline] stage
[Pipeline] { (1-Build)
[Pipeline] echo
Start of Stage Build
[Pipeline] sh
+ pwd
/home/jenkins/workspace/Deploy-to-prod-env
[Pipeline] dir
Running in /home/jenkins/workspace/Deploy-to-prod-env/task3/3.2
[Pipeline] {
[Pipeline] sh
+ pwd
/home/jenkins/workspace/Deploy-to-prod-env/task3/3.2
+ ls -la
total 20
drwxrwxr-x  2 jenkins jenkins 4096 Jun 27 11:41 .
drwxrwxr-x 10 jenkins jenkins 4096 Jun 27 11:41 ..
-rw-rw-r--  1 jenkins jenkins   96 Jun 27 11:41 Dockerfile
-rw-rw-r--  1 jenkins jenkins  112 Jun 27 11:41 .dockerignore
-rw-rw-r--  1 jenkins jenkins  192 Jun 27 11:41 index.html
+ docker build -t php-app .
Sending build context to Docker daemon  4.096kB

Step 1/3 : FROM nginx:latest
 ---> d1a364dc548d
Step 2/3 : COPY ./index.html /usr/share/nginx/html/index.html
 ---> Using cache
 ---> ced017050a3f
Step 3/3 : ENV DEVOPS="v-kostyukov"
 ---> Using cache
 ---> 411a3dfd5932
Successfully built 411a3dfd5932
Successfully tagged php-app:latest
[Pipeline] }
[Pipeline] // dir
[Pipeline] echo
End of Stage Build
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (2-Test)
[Pipeline] echo
Start of Stage Test
[Pipeline] sh
+ pwd
/home/jenkins/workspace/Deploy-to-prod-env
+ docker image ls
REPOSITORY                   TAG             IMAGE ID       CREATED        SIZE
php-app                      latest          411a3dfd5932   3 hours ago    133MB
java-docker                  latest          de620f2d47bb   10 days ago    574MB
spring-petclinic_petclinic   latest          de620f2d47bb   10 days ago    574MB
kostyukov/my-php-app         latest          d3f9c54c5648   11 days ago    410MB
wordpress                    php7.4-fpm      b0d791fbc5fa   3 weeks ago    542MB
jenkins/jenkins              lts-jdk11       416c6656c1cd   3 weeks ago    684MB
jenkins/jenkins              lts             0af90866343f   3 weeks ago    573MB
nginx                        latest          d1a364dc548d   4 weeks ago    133MB
mysql                        5.7             2c9028880e58   6 weeks ago    447MB
mysql                        latest          c0cdc95609f1   6 weeks ago    556MB
mysql                        8.0.23          cbe8815cbea8   2 months ago   546MB
jenkins/ssh-agent            alpine          f922a66329e7   3 months ago   231MB
openjdk                      16-alpine3.13   2aa8569968b8   4 months ago   324MB
[Pipeline] echo
End of Stage Test
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (3-Deploy)
[Pipeline] echo
Start of Stage Deploy
[Pipeline] sh
Warning: A secret was passed to "sh" using Groovy String interpolation, which is insecure.
		 Affected argument(s) used the following variable(s): [PASSWORD]
		 See https://jenkins.io/redirect/groovy-string-interpolation for details.
+ docker run -it -d -p 80:80 -e PASSWORD=**** php-app
64cde08ce1206d3e2162956e642758d977633c5137c32818e9bb78d4e9c70ee2
+ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED        STATUS                  PORTS                               NAMES
64cde08ce120   php-app   "/docker-entrypoint.…"   1 second ago   Up Less than a second   0.0.0.0:80->80/tcp, :::80->80/tcp   modest_mahavira
[Pipeline] echo
End of Stage Deploy
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```
### Check variable in docker container
``` 
docker exec -it modest_mahavira printenv
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=64cde08ce120
TERM=xterm
PASSWORD=QWERTY!
NGINX_VERSION=1.21.0
NJS_VERSION=0.5.3
PKG_RELEASE=1~buster
DEVOPS=v-kostyukov
HOME=/root
```
### Deploy the local docker registry, load the docker image into it, unload the docker image from the docker registry and launch the container on the environment (using Jenkinsfile)
``` 
pipeline {
    agent {
            label 'agent3'
          }
    stages {
        stage('1-Deploy the local docker registry') {
            steps {
                echo "Start of Stage Deploy the local docker registry"
                    sh """
                        docker run -d -p 5000:5000 --restart=always --name registry -v /dockerrepo:/var/lib/registry registry:2
                        docker ps
                    """
                echo "End of Stage Deploy the local docker registry"
            }
        }
        stage('2-Load the docker image into a local docker registry') {
            steps {
                echo "Start of Stage Load the docker image into a local docker registry"
                sh """
                    docker pull kostyukov/my-php-app:latest
                    docker tag kostyukov/my-php-app:latest localhost:5000/my-php-app
                    docker push localhost:5000/my-php-app
                    docker image ls
                """
                echo "End of Stage Load the docker image into a local docker registry"
            }
        }
        stage('3-Launch the container on the environment from the local docker registry') {
            steps {
                echo "Start of Stage Launch the container on the environment from the local docker registry"
                sh """
                    docker run -it -d -p 80:80 localhost:5000/my-php-app
                    docker ps
                """
                echo "End of Stage Launch the container on the environment from the local docker registry"
            }
        }
    }
}
```
### Console output
``` 
Started by user admin
Obtained task5/Jenkinsfile3 from git git@github.com:v-kostyukov/Internship-2021.git
Running in Durability level: MAX_SURVIVABILITY
[Pipeline] Start of Pipeline
[Pipeline] node
Running on agent3 in /home/jenkins/workspace/Deploy-to-prod-repo
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential github-ssh
Fetching changes from the remote Git repository
 > git rev-parse --resolve-git-dir /home/jenkins/workspace/Deploy-to-prod-repo/.git # timeout=10
 > git config remote.origin.url git@github.com:v-kostyukov/Internship-2021.git # timeout=10
Fetching upstream changes from git@github.com:v-kostyukov/Internship-2021.git
 > git --version # timeout=10
 > git --version # 'git version 2.25.1'
using GIT_SSH to set credentials githun-ssh
 > git fetch --tags --force --progress -- git@github.com:v-kostyukov/Internship-2021.git +refs/heads/*:refs/remotes/origin/* # timeout=10
Checking out Revision f0efa3609bbdd65fceb314848f9d40791f61d1f4 (refs/remotes/origin/master)
Commit message: "change file task5/Jenkinsfile3"
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f f0efa3609bbdd65fceb314848f9d40791f61d1f4 # timeout=10
 > git rev-list --no-walk f0efa3609bbdd65fceb314848f9d40791f61d1f4 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (1-Deploy the local docker registry)
[Pipeline] echo
Start of Stage Deploy the local docker registry
[Pipeline] sh
+ docker run -d -p 5000:5000 --restart=always --name registry -v /dockerrepo:/var/lib/registry registry:2
31ea21204ea16adf47c8460c7d4430cffde3ad91575568f66d140e0f6433fb02
+ docker ps
CONTAINER ID   IMAGE        COMMAND                  CREATED        STATUS                  PORTS                                       NAMES
31ea21204ea1   registry:2   "/entrypoint.sh /etc…"   1 second ago   Up Less than a second   0.0.0.0:5000->5000/tcp, :::5000->5000/tcp   registry
[Pipeline] echo
End of Stage Deploy the local docker registry
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (2-Load the docker image into a local docker registry)
[Pipeline] echo
Start of Stage Load the docker image into a local docker registry
[Pipeline] sh
+ docker pull kostyukov/my-php-app:latest
latest: Pulling from kostyukov/my-php-app
Digest: sha256:7f2749f3f1dc0df5caddfcbe35a23fc24509f971f5010a7133650bfd4e382da8
Status: Image is up to date for kostyukov/my-php-app:latest
docker.io/kostyukov/my-php-app:latest
+ docker tag kostyukov/my-php-app:latest localhost:5000/my-php-app
+ docker push localhost:5000/my-php-app
Using default tag: latest
The push refers to repository [localhost:5000/my-php-app]
c498ce6a5fa3: Preparing
5dc980197467: Preparing
cc45506c4447: Preparing
6ec4d4ce53cc: Preparing
9a60d912a14f: Preparing
ce60a0c97d4a: Preparing
e1cd0107ea85: Preparing
914a1eddd57a: Preparing
0ff9183bd099: Preparing
d666585087a1: Preparing
bc0429138e0d: Preparing
02eef72b445f: Preparing
e45a78df7536: Preparing
ddcd8d2fcf7e: Preparing
87c8a1d8f54f: Preparing
ce60a0c97d4a: Waiting
e1cd0107ea85: Waiting
914a1eddd57a: Waiting
0ff9183bd099: Waiting
d666585087a1: Waiting
bc0429138e0d: Waiting
02eef72b445f: Waiting
e45a78df7536: Waiting
ddcd8d2fcf7e: Waiting
87c8a1d8f54f: Waiting
5dc980197467: Pushed
cc45506c4447: Pushed
c498ce6a5fa3: Pushed
9a60d912a14f: Pushed
6ec4d4ce53cc: Pushed
d666585087a1: Pushed
e1cd0107ea85: Pushed
0ff9183bd099: Pushed
02eef72b445f: Pushed
ddcd8d2fcf7e: Pushed
914a1eddd57a: Pushed
ce60a0c97d4a: Pushed
bc0429138e0d: Pushed
87c8a1d8f54f: Pushed
e45a78df7536: Pushed
latest: digest: sha256:7f2749f3f1dc0df5caddfcbe35a23fc24509f971f5010a7133650bfd4e382da8 size: 3449
+ docker image ls
REPOSITORY                   TAG             IMAGE ID       CREATED        SIZE
php-app                      latest          411a3dfd5932   33 hours ago   133MB
java-docker                  latest          de620f2d47bb   11 days ago    574MB
spring-petclinic_petclinic   latest          de620f2d47bb   11 days ago    574MB
kostyukov/my-php-app         latest          d3f9c54c5648   12 days ago    410MB
localhost:5000/my-php-app    latest          d3f9c54c5648   12 days ago    410MB
wordpress                    php7.4-fpm      b0d791fbc5fa   3 weeks ago    542MB
jenkins/jenkins              lts-jdk11       416c6656c1cd   3 weeks ago    684MB
jenkins/jenkins              lts             0af90866343f   3 weeks ago    573MB
nginx                        latest          d1a364dc548d   4 weeks ago    133MB
mysql                        5.7             2c9028880e58   6 weeks ago    447MB
mysql                        latest          c0cdc95609f1   6 weeks ago    556MB
registry                     2               1fd8e1b0bb7e   2 months ago   26.2MB
mysql                        8.0.23          cbe8815cbea8   2 months ago   546MB
jenkins/ssh-agent            alpine          f922a66329e7   3 months ago   231MB
openjdk                      16-alpine3.13   2aa8569968b8   4 months ago   324MB
[Pipeline] echo
End of Stage Load the docker image into a local docker registry
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (3-Launch the container on the environment from the local docker registry)
[Pipeline] echo
Start of Stage Launch the container on the environment from the local docker registry
[Pipeline] sh
+ docker run -it -d -p 80:80 localhost:5000/my-php-app
2a2ffb5f11de8ba02b8f306567c68e80bfc573ff1aab7b13782b2f3c0bfb4907
+ docker ps
CONTAINER ID   IMAGE                       COMMAND                  CREATED          STATUS                  PORTS                                       NAMES
2a2ffb5f11de   localhost:5000/my-php-app   "docker-php-entrypoi…"   1 second ago     Up Less than a second   0.0.0.0:80->80/tcp, :::80->80/tcp           festive_borg
31ea21204ea1   registry:2                  "/entrypoint.sh /etc…"   51 seconds ago   Up 49 seconds           0.0.0.0:5000->5000/tcp, :::5000->5000/tcp   registry
[Pipeline] echo
End of Stage Launch the container on the environment from the local docker registry
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins14.png)
### Set up two-way integration between Jenkins and your Git repository
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins15.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins16.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/jenkins_github_webhook.png)
### Console output 
``` 
Started by GitHub push by v-kostyukov
Obtained task5/Jenkinsfile4 from git git@github.com:v-kostyukov/Internship-2021.git
Running in Durability level: MAX_SURVIVABILITY
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/jenkins_home/workspace/Deploy-to-prod-auto
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential github-ssh-key
 > git rev-parse --resolve-git-dir /var/jenkins_home/workspace/Deploy-to-prod-auto/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url git@github.com:v-kostyukov/Internship-2021.git # timeout=10
Fetching upstream changes from git@github.com:v-kostyukov/Internship-2021.git
 > git --version # timeout=10
 > git --version # 'git version 2.20.1'
using GIT_SSH to set credentials github-ssh-key
 > git fetch --tags --force --progress -- git@github.com:v-kostyukov/Internship-2021.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
Checking out Revision a182b0a71c28d313210f181491391d8af9724f19 (refs/remotes/origin/master)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f a182b0a71c28d313210f181491391d8af9724f19 # timeout=10
Commit message: "add files task5"
 > git rev-list --no-walk 1a5e4612e93f7335fa9cbff383a12fa90e06d592 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (1-Build)
[Pipeline] echo
Start of Stage Build
[Pipeline] echo
The current build ID: 6
[Pipeline] echo
Name project: Deploy-to-prod-auto
[Pipeline] echo
Name DevOps: Vitaliy Kostyukov
[Pipeline] echo
End of Stage Build
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (2-Test)
[Pipeline] echo
Start of Stage Test
[Pipeline] sh
+ pwd
/var/jenkins_home/workspace/Deploy-to-prod-auto
+ ls -la
total 44
drwxr-xr-x 8 root root 4096 Jun 29 11:48 .
drwxr-xr-x 4 root root 4096 Jun 29 11:48 ..
drwxr-xr-x 8 root root 4096 Jun 29 12:33 .git
-rw-r--r-- 1 root root   28 Jun 29 11:48 .gitignore
-rw-r--r-- 1 root root 4100 Jun 29 11:48 README.md
drwxr-xr-x 2 root root 4096 Jun 29 11:48 task1
drwxr-xr-x 3 root root 4096 Jun 29 11:48 task2
drwxr-xr-x 9 root root 4096 Jun 29 11:48 task3
drwxr-xr-x 4 root root 4096 Jun 29 11:48 task4
drwxr-xr-x 4 root root 4096 Jun 29 12:33 task5
[Pipeline] echo
End of Stage Test
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (3-Deploy)
[Pipeline] echo
Start of Stage Deploy
[Pipeline] sh
+ ls -la
total 44
drwxr-xr-x 8 root root 4096 Jun 29 11:48 .
drwxr-xr-x 4 root root 4096 Jun 29 11:48 ..
drwxr-xr-x 8 root root 4096 Jun 29 12:33 .git
-rw-r--r-- 1 root root   28 Jun 29 11:48 .gitignore
-rw-r--r-- 1 root root 4100 Jun 29 11:48 README.md
drwxr-xr-x 2 root root 4096 Jun 29 11:48 task1
drwxr-xr-x 3 root root 4096 Jun 29 11:48 task2
drwxr-xr-x 9 root root 4096 Jun 29 11:48 task3
drwxr-xr-x 4 root root 4096 Jun 29 11:48 task4
drwxr-xr-x 4 root root 4096 Jun 29 12:33 task5
+ git status
HEAD detached at a182b0a
nothing to commit, working tree clean
[Pipeline] echo
End of Stage Deploy
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins17.png)
### Configure several build agents. Agents must be running in docker.
``` 
In the docker service file /lib/systemd/system/docker.service 
Search for ExecStart and replace that line with the following

ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock

sudo systemctl daemon-reload
sudo service docker restart

curl http://192.168.0.155:4243/version
{"Platform":{"Name":"Docker Engine - Community"},"Components":[{"Name":"Engine","Version":"20.10.7","Details":{"ApiVersion":"1.41","Arch":"amd64","BuildTime":"2021-06-02T11:54:50.000000000+00:00","Experimental":"false","GitCommit":"b0f5bc3","GoVersion":"go1.13.15","KernelVersion":"5.4.0-77-generic","MinAPIVersion":"1.12","Os":"linux"}},{"Name":"containerd","Version":"1.4.6","Details":{"GitCommit":"d71fcd7d8303cbf684402823e425e9dd2e99285d"}},{"Name":"runc","Version":"1.0.0-rc95","Details":{"GitCommit":"b9ee9c6314599f1b4a7f497e1f1f856fe433d3b7"}},{"Name":"docker-init","Version":"0.19.0","Details":{"GitCommit":"de40ad0"}}],"Version":"20.10.7","ApiVersion":"1.41","MinAPIVersion":"1.12","GitCommit":"b0f5bc3","GoVersion":"go1.13.15","Os":"linux","Arch":"amd64","KernelVersion":"5.4.0-77-generic","BuildTime":"2021-06-02T11:54:50.000000000+00:00"}
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/config_docker.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/config_docker2.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/config_docker3.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/config_docker4.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/config_docker5.png)
### Create docker image jenkins-slave-alpine
``` 
docker build -t jenkins-slave-alpine .
Sending build context to Docker daemon  374.7MB
Step 1/11 : ARG version=latest-alpine-jdk11
Step 2/11 : FROM jenkins/agent:$version
 ---> 135ad8fd1889
Step 3/11 : ARG version
 ---> Using cache
 ---> 876335152fd4
Step 4/11 : LABEL Description="This is a base image, which allows connecting Jenkins agents via JNLP protocols" Vendor="Jenkins project" Version="$version"
 ---> Using cache
 ---> 25751eb67264
Step 5/11 : ARG user=jenkins
 ---> Using cache
 ---> 46233cc0ebcf
Step 6/11 : USER root
 ---> Using cache
 ---> caef3f550920
Step 7/11 : COPY jenkins-agent /usr/local/bin/jenkins-agent
 ---> e439e9dfa862
Step 8/11 : RUN chmod +x /usr/local/bin/jenkins-agent &&    ln -s /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-slave
 ---> Running in 7af746bd5abd
Removing intermediate container 7af746bd5abd
 ---> e05a95f548b5
Step 9/11 : RUN apk update && apk add --no-cache docker-cli
 ---> Running in e3941e8d1a80
fetch https://dl-cdn.alpinelinux.org/alpine/v3.13/main/x86_64/APKINDEX.tar.gz
fetch https://dl-cdn.alpinelinux.org/alpine/v3.13/community/x86_64/APKINDEX.tar.gz
v3.13.5-224-g4b1b4dc794 [https://dl-cdn.alpinelinux.org/alpine/v3.13/main]
v3.13.5-216-gca846067ce [https://dl-cdn.alpinelinux.org/alpine/v3.13/community]
OK: 13892 distinct packages available
fetch https://dl-cdn.alpinelinux.org/alpine/v3.13/main/x86_64/APKINDEX.tar.gz
fetch https://dl-cdn.alpinelinux.org/alpine/v3.13/community/x86_64/APKINDEX.tar.gz
(1/1) Installing docker-cli (20.10.3-r1)
Executing busybox-1.32.1-r6.trigger
OK: 102 MiB in 37 packages
Removing intermediate container e3941e8d1a80
 ---> 9fbc3f7b189a
Step 10/11 : USER ${user}
 ---> Running in 64623f0a8eed
Removing intermediate container 64623f0a8eed
 ---> 98a5b88406f0
Step 11/11 : ENTRYPOINT ["/usr/local/bin/jenkins-agent"]
 ---> Running in 568fae514d7f
Removing intermediate container 568fae514d7f
 ---> 078e1c37ea8c
Successfully built 078e1c37ea8c
Successfully tagged jenkins-slave-alpine:latest

docker tag jenkins-slave-alpine kostyukov/jenkins-slave-alpine
docker push kostyukov/jenkins-slave-alpine
Using default tag: latest
The push refers to repository [docker.io/kostyukov/jenkins-slave-alpine]
a249f13bf973: Pushed
da9804b59907: Pushed
8aa6b9729fa7: Pushed
35fde915c383: Mounted from jenkins/agent
c0073221a63c: Mounted from jenkins/agent
46bdca078720: Mounted from jenkins/agent
e384a2d73066: Mounted from jenkins/agent
ce7e5c5cc356: Mounted from jenkins/agent
e330fc6a21cc: Mounted from jenkins/agent
b2d5eeeaba3a: Mounted from jenkins/agent
latest: digest: sha256:f8d128a94fe17139a6ca03559b58be20251e4194da5ea859ad1b161997432804 size: 2415
```
### Create pipeline
``` 
pipeline {
    //agent any
    agent {
                label 'jenkins-slave-alpine'
            }
    stages {
        stage('stage1') {
            steps {
                sh("docker ps -a")
            }
        }
    }
}
```
### Console output
``` 
Started by user admin
Running in Durability level: MAX_SURVIVABILITY
[Pipeline] Start of Pipeline
[Pipeline] node
Running on jenkins-slave-alpine-00002q21ymqeg on docker in /home/jenkins/workspace/pipeline-docker-slave
[Pipeline] {
[Pipeline] stage
[Pipeline] { (stage1)
[Pipeline] sh
+ docker ps -a
CONTAINER ID   IMAGE                                   COMMAND                  CREATED          STATUS                  PORTS                                                                                      NAMES
6b785e8f041b   kostyukov/jenkins-slave-alpine:latest   "/usr/local/bin/jenk…"   2 seconds ago    Up Less than a second                                                                                              interesting_ride
45e6b2d72522   kostyukov/jenkins-slave-alpine:latest   "/usr/local/bin/jenk…"   7 minutes ago    Up 7 minutes                                                                                                       priceless_villani
6f34116d7e5c   nginx:latest                            "/docker-entrypoint.…"   34 minutes ago   Up 34 minutes           0.0.0.0:80->80/tcp, :::80->80/tcp                                                          jenkins_nginx_1
1a31d898e6f3   jenkins/jenkins:lts                     "/sbin/tini -- /usr/…"   34 minutes ago   Up 34 minutes           0.0.0.0:8080->8080/tcp, :::8080->8080/tcp, 0.0.0.0:50000->50000/tcp, :::50000->50000/tcp   jenkins_server
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task5/img/ansible_jenkins18.png)