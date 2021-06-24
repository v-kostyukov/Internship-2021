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
