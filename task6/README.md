### Install mysql server with ansible playbook
``` 
ansible dbservers -m ping
ec2-18-193-112-15.eu-central-1.compute.amazonaws.com | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}

ansible-playbook --ask-vault-pass mysql.yml
PLAY [Install jenkins] ***************************************************************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************************************************************
ok: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com]

TASK [docker : Update repositories cache and install docker dependencies] ************************************************************************************************************************************
ok: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com] => (item=apt-transport-https)
ok: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com] => (item=ca-certificates)
ok: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com] => (item=software-properties-common)
ok: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com] => (item=curl)
ok: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com] => (item=gnupg)
ok: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com] => (item=lsb-release)

TASK [docker : Add docker repo apt key] **********************************************************************************************************************************************************************
changed: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com]

TASK [docker : Add Docker Repository] ************************************************************************************************************************************************************************
changed: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com]

TASK [docker : Update apt and install docker] ****************************************************************************************************************************************************************
changed: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com] => (item=docker-ce)
ok: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com] => (item=docker-ce-cli)
ok: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com] => (item=containerd.io)

TASK [docker : Start and enable systemd service docker] ******************************************************************************************************************************************************
ok: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com]

TASK [docker : Add user to docker group] *********************************************************************************************************************************************************************
changed: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com] => (item=ubuntu)
changed: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com] => (item=ansible)

TASK [docker : Install docker-compose] ***********************************************************************************************************************************************************************
changed: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com]

TASK [docker : Create a symbolic link] ***********************************************************************************************************************************************************************
changed: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com]

TASK [mysql : Create a directories] **************************************************************************************************************************************************************************
changed: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com] => (item=db-data)

TASK [mysql : Create docker-compose.yml file] ****************************************************************************************************************************************************************
changed: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com]

TASK [mysql : Create docker-compose.yml file] ****************************************************************************************************************************************************************
changed: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com]

TASK [mysql : Deploy Docker Compose] *************************************************************************************************************************************************************************
changed: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com]

TASK [mysql : Run docker-compose] ****************************************************************************************************************************************************************************
changed: [ec2-18-193-112-15.eu-central-1.compute.amazonaws.com]

PLAY RECAP ***************************************************************************************************************************************************************************************************
ec2-18-193-112-15.eu-central-1.compute.amazonaws.com : ok=10   changed=12    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```
