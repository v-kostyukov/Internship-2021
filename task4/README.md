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
` 
