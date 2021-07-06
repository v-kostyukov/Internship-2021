### Install zabbix server, configure web and database with ansible
``` 
ansible-playbook -i inventory/production/hosts --ask-vault-pass zabbix.yml
Vault password:

PLAY [Install zabbix] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [192.168.0.175]

TASK [docker : Update repositories cache and install docker dependencies] **********************************************
ok: [192.168.0.175] => (item=apt-transport-https)
ok: [192.168.0.175] => (item=ca-certificates)
ok: [192.168.0.175] => (item=software-properties-common)
ok: [192.168.0.175] => (item=curl)
ok: [192.168.0.175] => (item=gnupg)
ok: [192.168.0.175] => (item=lsb-release)

TASK [docker : Add docker repo apt key] ********************************************************************************
ok: [192.168.0.175]

TASK [docker : Add Docker Repository] **********************************************************************************
ok: [192.168.0.175]

TASK [docker : Update apt and install docker] **************************************************************************
ok: [192.168.0.175] => (item=docker-ce)
ok: [192.168.0.175] => (item=docker-ce-cli)
ok: [192.168.0.175] => (item=containerd.io)

TASK [docker : Start and enable systemd service docker] ****************************************************************
ok: [192.168.0.175]

TASK [docker : Add user to docker group] *******************************************************************************
ok: [192.168.0.175] => (item=ubuntu)
ok: [192.168.0.175] => (item=ansible)

TASK [docker : Install docker-compose] *********************************************************************************
ok: [192.168.0.175]

TASK [docker : Create a symbolic link] *********************************************************************************
ok: [192.168.0.175]

TASK [zabbix : Create a directories] ***********************************************************************************
ok: [192.168.0.175] => (item=mysql)
ok: [192.168.0.175] => (item=zabbix)

TASK [zabbix : Create docker-compose.yml file] *************************************************************************
changed: [192.168.0.175]

TASK [zabbix : Deploy Docker Compose] **********************************************************************************
changed: [192.168.0.175]

TASK [zabbix : Run docker-compose] *************************************************************************************
changed: [192.168.0.175]

PLAY RECAP *************************************************************************************************************
192.168.0.175              : ok=13   changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
### Docker ps
``` 
docker ps
CONTAINER ID   IMAGE                                        COMMAND                  CREATED              STATUS              PORTS                                                                            NAMES
41b1ad3d1e64   zabbix/zabbix-web-nginx-mysql:5.4.2-ubuntu   "docker-entrypoint.sh"   About a minute ago   Up About a minute   0.0.0.0:80->8080/tcp, :::80->8080/tcp, 0.0.0.0:443->8443/tcp, :::443->8443/tcp   zabbix-frontend
4fa5bd6d0f41   zabbix/zabbix-server-mysql:5.4.2-ubuntu      "/usr/bin/tini -- /u…"   About a minute ago   Up About a minute   0.0.0.0:10051->10051/tcp, :::10051->10051/tcp                                    zabbix-server
9f83f6b23518   zabbix/zabbix-agent2:5.4.2-alpine            "/sbin/tini -- /usr/…"   About a minute ago   Up About a minute   0.0.0.0:10050->10050/tcp, :::10050->10050/tcp, 31999/tcp                         zabbix-agent
5665248abd47   mysql:5.7                                    "docker-entrypoint.s…"   About a minute ago   Up About a minute   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp                             mysql
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task7/img/zabbix.png)
### Install Zabbix agents on previously prepared servers or virtual machines
```
Zabbix agent docker 
docker ps
CONTAINER ID   IMAGE                               COMMAND                  CREATED         STATUS         PORTS                                                      NAMES
41094018dda4   zabbix/zabbix-agent2:5.4.2-alpine   "/sbin/tini -- /usr/…"   3 seconds ago   Up 2 seconds   0.0.0.0:10050->10050/tcp, :::10050->10050/tcp, 31999/tcp   zabbix-agent

Zabbix agent in Ubuntu
systemctl status zabbix-agent
● zabbix-agent.service - Zabbix Agent
     Loaded: loaded (/lib/systemd/system/zabbix-agent.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2021-07-06 15:12:46 UTC; 1min 17s ago
    Process: 647 ExecStart=/usr/sbin/zabbix_agentd -c $CONFFILE (code=exited, status=0/SUCCESS)
   Main PID: 694 (zabbix_agentd)
      Tasks: 6 (limit: 2279)
     Memory: 10.4M
     CGroup: /system.slice/zabbix-agent.service
             ├─694 /usr/sbin/zabbix_agentd -c /etc/zabbix/zabbix_agentd.conf
             ├─695 /usr/sbin/zabbix_agentd: collector [idle 1 sec]
             ├─696 /usr/sbin/zabbix_agentd: listener #1 [waiting for connection]
             ├─697 /usr/sbin/zabbix_agentd: listener #2 [waiting for connection]
             ├─698 /usr/sbin/zabbix_agentd: listener #3 [waiting for connection]
             └─699 /usr/sbin/zabbix_agentd: active checks #1 [idle 1 sec]

Jul 06 15:12:42 u2004 systemd[1]: Starting Zabbix Agent...
Jul 06 15:12:46 u2004 systemd[1]: Started Zabbix Agent.
```
### Config zabbix agent in Ubuntu
``` 
/etc/zabbix/zabbix_agentd.conf

PidFile=/run/zabbix/zabbix_agentd.pid
LogFile=/var/log/zabbix/zabbix_agentd.log
LogFileSize=0
Server=192.168.0.175
ServerActive=192.168.0.175
Hostname=Zabbix server
Include=/etc/zabbix/zabbix_agentd.d/*.conf
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task7/img/zabbix2.png)
