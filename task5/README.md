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