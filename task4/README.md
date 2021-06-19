### Bash script install ansible linux ubuntu
``` ansible_ubuntu_install.sh ``` 
### Bash script install ansible with pip
``` ansible_pip_install.sh ``` 
### Use the ping module to ping the nodes in your inventory
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
