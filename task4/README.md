### Bash script install ansible linux ubuntu
``` ansible_ubuntu_install.sh ``` 
### Bash script install ansible with pip
``` ansible_pip_install.sh ``` 
### Use the ping module to ping the nodes in our inventory
``` 
ansible t2micro -m ping
ec2-3-65-27-106.eu-central-1.compute.amazonaws.com | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
ec2-52-59-192-201.eu-central-1.compute.amazonaws.com | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task4/img/ansible_ping.png)
### Perform a syntax check on the playbook, but do not execute it
``` 
ansible-playbook docker.yml --syntax-check

playbook: docker.yml
```
### Run ansible-playbook docker.yml
``` 
ansible-playbook docker.yml

PLAY [Install docker] ****************************************************************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************************************************************
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com]
ok: [ec2-52-59-192-201.eu-central-1.compute.amazonaws.com]

TASK [docker : Update repositories cache and install docker dependencies] ************************************************************************************************************************************
changed: [ec2-52-59-192-201.eu-central-1.compute.amazonaws.com] => (item=apt-transport-https)
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=apt-transport-https)
changed: [ec2-52-59-192-201.eu-central-1.compute.amazonaws.com] => (item=ca-certificates)
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=ca-certificates)
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=software-properties-common)
changed: [ec2-52-59-192-201.eu-central-1.compute.amazonaws.com] => (item=software-properties-common)
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=curl)
changed: [ec2-52-59-192-201.eu-central-1.compute.amazonaws.com] => (item=curl)
changed: [ec2-52-59-192-201.eu-central-1.compute.amazonaws.com] => (item=gnupg)
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=gnupg)
changed: [ec2-52-59-192-201.eu-central-1.compute.amazonaws.com] => (item=lsb-release)
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=lsb-release)

TASK [docker : Add docker repo apt key] **********************************************************************************************************************************************************************
changed: [ec2-52-59-192-201.eu-central-1.compute.amazonaws.com]
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com]

TASK [docker : Add Docker Repository] ************************************************************************************************************************************************************************
changed: [ec2-52-59-192-201.eu-central-1.compute.amazonaws.com]
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com]

TASK [docker : Update apt and install docker] ****************************************************************************************************************************************************************
changed: [ec2-52-59-192-201.eu-central-1.compute.amazonaws.com] => (item=docker-ce)
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=docker-ce)
changed: [ec2-52-59-192-201.eu-central-1.compute.amazonaws.com] => (item=docker-ce-cli)
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=docker-ce-cli)
changed: [ec2-52-59-192-201.eu-central-1.compute.amazonaws.com] => (item=containerd.io)
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=containerd.io)

TASK [docker : Start and enable systemd service docker] ******************************************************************************************************************************************************
ok: [ec2-52-59-192-201.eu-central-1.compute.amazonaws.com]
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com]

TASK [docker : Add user to docker group] *********************************************************************************************************************************************************************
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=ubuntu)
changed: [ec2-52-59-192-201.eu-central-1.compute.amazonaws.com] => (item=ubuntu)
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=ansible)
changed: [ec2-52-59-192-201.eu-central-1.compute.amazonaws.com] => (item=ansible)
```
### Directory layout
``` 
tree
.
├── ansible.cfg
├── docker.yml
├── inventory
│   └── production
│       ├── group_vars
│       │   └── t2micro.yml
│       └── hosts
└── roles
    └── docker
        ├── handlers
        │   └── main.yml
        └── tasks
            └── main.yml
```
### EXTRA. Run ansible-playbook wordpress.yml
``` 
ansible-playbook --ask-vault-pass wordpress.yml
Vault password:

PLAY [Install docker] ****************************************************************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************************************************************
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com]

TASK [docker : Update repositories cache and install docker dependencies] ************************************************************************************************************************************
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=apt-transport-https)
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=ca-certificates)
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=software-properties-common)
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=curl)
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=gnupg)
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=lsb-release)

TASK [docker : Add docker repo apt key] **********************************************************************************************************************************************************************
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com]

TASK [docker : Add Docker Repository] ************************************************************************************************************************************************************************
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com]

TASK [docker : Update apt and install docker] ****************************************************************************************************************************************************************
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=docker-ce)
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=docker-ce-cli)
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=containerd.io)

TASK [docker : Start and enable systemd service docker] ******************************************************************************************************************************************************
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com]

TASK [docker : Add user to docker group] *********************************************************************************************************************************************************************
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=ubuntu)
ok: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=ansible)

TASK [docker : Install docker-compose] ***********************************************************************************************************************************************************************
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com]

TASK [docker : Create a symbolic link] ***********************************************************************************************************************************************************************
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com]

TASK [wordpress : Create a directories] **********************************************************************************************************************************************************************
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=wordpress)
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=wp-db-data)
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com] => (item=nginx)

TASK [wordpress : Create docker-compose.yml file] ************************************************************************************************************************************************************
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com]

TASK [wordpress : Deploy Docker Compose] *********************************************************************************************************************************************************************
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com]

TASK [wordpress : Deploy WP Nginx virtual host] **************************************************************************************************************************************************************
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com]

TASK [wordpress : Run docker-compose] ************************************************************************************************************************************************************************
changed: [ec2-3-65-27-106.eu-central-1.compute.amazonaws.com]

PLAY RECAP ***************************************************************************************************************************************************************************************************
ec2-3-65-27-106.eu-central-1.compute.amazonaws.com : ok=14   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
### Docker ps
```
docker ps
CONTAINER ID   IMAGE                  COMMAND                  CREATED         STATUS         PORTS                                                  NAMES
86c52016a8e2   nginx:latest           "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes   0.0.0.0:80->80/tcp, :::80->80/tcp                      wordpress_nginx_1
ca58690f6597   wordpress:php7.4-fpm   "docker-entrypoint.s…"   4 minutes ago   Up 4 minutes   0.0.0.0:9000->9000/tcp, :::9000->9000/tcp              wordpress_wordpress_1
c06e8d370077   mysql                  "docker-entrypoint.s…"   4 minutes ago   Up 4 minutes   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   wordpress_db_1
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task4/img/ansible_wordpress.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task4/img/ansible_wordpress2.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task4/img/ansible_wordpress3.png)
