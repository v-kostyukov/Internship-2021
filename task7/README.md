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
### Make an agentless check of any resource (ICMP ping)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task7/img/zabbix3.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task7/img/zabbix4.png)
### Active check vs passive check
``` 
Passive checks
Zabbix passive checks is the default setting. With this enabled, in /etc/zabbix/zabbix_agentd.conf, the zabbix-server will query for information about an item which is configured on the zabbix server.
Passive check is a simple data request. Zabbix Server (or Proxy) asks for a data, for example, CPU load, and Zabbix Agent sends the result back to the Server.
Server Request
<item key>\n
Agent Response
<HEADER><DATALEN><DATA>

For example:

1. Server opens TCP connection
2. Server sends agent.ping\n
3. Agent reads the request and responds with <HEADER><DATALEN>1
4. Server processes data to get the value, '1' in our case
5. TCP connection is closed
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task7/img/zabbix4.png)
``` 
Active check
Active checks requires more complex processing. The Agent must retrieve list of items for independent processing first. It also periodically sends new values to the Server.
Agent Request
<HEADER><DATALEN>{
   "request":"active checks",
   "host":"<hostname>"
}
Server Response
{
    "response":"success",
    "data":[
    {
        "key":"log[\/home\/zabbix\/logs\/zabbix_agentd.log]",
        "delay":"30",
        "lastlogsize":"0"
    },
    {
        "key":"agent.version",
        "delay":"600"
    }
    ]
}

For example:
1. Agent opens TCP connection
2. Agent asks for the list of checks
3. Server responds with a list of items (item key, delay)
4. Agent parses the response
5. TCP connection is closed
6. Agent starts periodical collection of data

systemctl status zabbix-agent
● zabbix-agent.service - Zabbix Agent
     Loaded: loaded (/lib/systemd/system/zabbix-agent.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2021-07-07 21:11:27 UTC; 17min ago
    Process: 664 ExecStart=/usr/sbin/zabbix_agentd -c $CONFFILE (code=exited, status=0/SUCCESS)
   Main PID: 739 (zabbix_agentd)
      Tasks: 6 (limit: 2279)
     Memory: 16.8M
     CGroup: /system.slice/zabbix-agent.service
             ├─739 /usr/sbin/zabbix_agentd -c /etc/zabbix/zabbix_agentd.conf
             ├─740 /usr/sbin/zabbix_agentd: collector [idle 1 sec]
             ├─741 /usr/sbin/zabbix_agentd: listener #1 [waiting for connection]
             ├─742 /usr/sbin/zabbix_agentd: listener #2 [waiting for connection]
             ├─743 /usr/sbin/zabbix_agentd: listener #3 [waiting for connection]
             └─744 /usr/sbin/zabbix_agentd: active checks #1 [idle 1 sec]
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task7/img/zabbix9.png)
### Make several of your own dashboards, where to output data from your triggers
``` 
/etc/zabbix/zabbix_agentd.d/template_db_mysql.conf
UserParameter=mysql.ping[*], mysqladmin -h"$1" -P"$2" ping
UserParameter=mysql.get_status_variables[*], mysql -h"$1" -P"$2" -sNX -e "show global status"
UserParameter=mysql.version[*], mysqladmin -s -h"$1" -P"$2" version
UserParameter=mysql.db.discovery[*], mysql -h"$1" -P"$2" -sN -e "show databases"
UserParameter=mysql.dbsize[*], mysql -h"$1" -P"$2" -sN -e "SELECT COALESCE(SUM(DATA_LENGTH + INDEX_LENGTH),0) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='internship_db'"
UserParameter=mysql.replication.discovery[*], mysql -h"$1" -P"$2" -sNX -e "show slave status"
UserParameter=mysql.slave_status[*], mysql -h"$1" -P"$2" -sNX -e "show slave status"
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task7/img/zabbix7.png)
### Provoke an alert and create a Maintenance instruction
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task7/img/zabbix10.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task7/img/zabbix11.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task7/img/zabbix12.png)
### Draw a dashboard with key infrastructure nodes and monitoring of both the hosts and the software installed on them
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task7/img/zabbix13.png)
### Install and configure ELK
``` 
docker-compose up -d
Creating network "elk_elk" with driver "bridge"
Creating volume "elk_elasticsearch" with default driver
Building elasticsearch
Sending build context to Docker daemon  3.584kB
Step 1/2 : ARG ELK_VERSION
Step 2/2 : FROM docker.elastic.co/elasticsearch/elasticsearch:${ELK_VERSION}
7.13.2: Pulling from elasticsearch/elasticsearch
ddf49b9115d7: Pull complete
815a15889ec1: Pull complete
ba5d33fc5cc5: Pull complete
976d4f887b1a: Pull complete
9b5ee4563932: Pull complete
ef11e8f17d0c: Pull complete
3c5ad4db1e24: Pull complete
Digest: sha256:1cecc2c7419a4f917a88c83180335bd491d623f28ac43ca7e0e69b4eca25fbd5
Status: Downloaded newer image for docker.elastic.co/elasticsearch/elasticsearch:7.13.2
 ---> 11a830014f7c
Successfully built 11a830014f7c
Successfully tagged elk_elasticsearch:latest
WARNING: Image for service elasticsearch was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Building logstash
Sending build context to Docker daemon   5.12kB
Step 1/2 : ARG ELK_VERSION
Step 2/2 : FROM docker.elastic.co/logstash/logstash:${ELK_VERSION}
7.13.2: Pulling from logstash/logstash
a4f595742a5b: Pull complete
fd1132ca70dc: Pull complete
59f2c8c5f435: Pull complete
8dcb71d88a4e: Pull complete
b0d5a23a9e4a: Pull complete
796f58e1821d: Pull complete
29c837bdbca8: Pull complete
9662c1cef6d1: Pull complete
83ce4b738228: Pull complete
4b86338e93df: Pull complete
3b74732a4830: Pull complete
Digest: sha256:ed75189449f64d3c188a0337054a1fb9dd7bfaf42f1c20442520f364fec014a7
Status: Downloaded newer image for docker.elastic.co/logstash/logstash:7.13.2
 ---> 8dc1af4dd662
Successfully built 8dc1af4dd662
Successfully tagged elk_logstash:latest
WARNING: Image for service logstash was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Building kibana
Sending build context to Docker daemon  3.584kB
Step 1/2 : ARG ELK_VERSION
Step 2/2 : FROM docker.elastic.co/kibana/kibana:${ELK_VERSION}
7.13.2: Pulling from kibana/kibana
ddf49b9115d7: Already exists
127ce1da4c72: Pull complete
0c32fd0051d1: Pull complete
3cb592252c5c: Pull complete
a497541f421d: Pull complete
5f9af552442f: Pull complete
3d82cb04e9f3: Pull complete
63f1001938f4: Pull complete
5795c0f38c9b: Pull complete
b3f3fe288119: Pull complete
ad9e03aedb1a: Pull complete
b65617011d12: Pull complete
db3a5750fdcf: Pull complete
Digest: sha256:4a50a0f198a6536b769d8b694ae94e11f2a2bc97cf6dbe61fff98c051cdedc00
Status: Downloaded newer image for docker.elastic.co/kibana/kibana:7.13.2
 ---> 6c4869a27be1
Successfully built 6c4869a27be1
Successfully tagged elk_kibana:latest
WARNING: Image for service kibana was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Pulling grafana (grafana/grafana:latest)...
latest: Pulling from grafana/grafana
540db60ca938: Already exists
de26cbdd44be: Pull complete
540328727979: Pull complete
f33ada074d04: Pull complete
23c7a28f6596: Pull complete
4f4fb700ef54: Pull complete
a757f53bd2f5: Pull complete
4172f8e97c87: Pull complete
Digest: sha256:7f290a9e077447599633b9bec400688ba5db0ea77f0120ce5a1c5106f0de7d96
Status: Downloaded newer image for grafana/grafana:latest
Creating elk_elasticsearch_1 ... done
Creating elk_logstash_1      ... done
Creating elk_kibana_1        ... done
Creating grafana             ... done
root@u2004:/home/ubuntu/elk# docker ps
CONTAINER ID   IMAGE                                        COMMAND                  CREATED         STATUS                          PORTS                                                                                                                                                                        NAMES
c2f4ac9d6231   grafana/grafana:latest                       "/run.sh"                6 minutes ago   Up 6 minutes                    0.0.0.0:3000->3000/tcp, :::3000->3000/tcp                                                                                                                                    grafana
968d02082153   elk_kibana                                   "/bin/tini -- /usr/l…"   6 minutes ago   Up 6 minutes                    0.0.0.0:5601->5601/tcp, :::5601->5601/tcp                                                                                                                                    elk_kibana_1
74d5cc140599   elk_logstash                                 "/usr/local/bin/dock…"   6 minutes ago   Up 6 minutes                    0.0.0.0:5000->5000/tcp, :::5000->5000/tcp, 0.0.0.0:5044->5044/tcp, :::5044->5044/tcp, 0.0.0.0:9600->9600/tcp, 0.0.0.0:5000->5000/udp, :::9600->9600/tcp, :::5000->5000/udp   elk_logstash_1
541ec7a2c6ea   elk_elasticsearch                            "/bin/tini -- /usr/l…"   6 minutes ago   Up 6 minutes                    0.0.0.0:9200->9200/tcp, :::9200->9200/tcp, 0.0.0.0:9300->9300/tcp, :::9300->9300/tcp                                                                                         elk_elasticsearch_1
38d3aee9f053   zabbix/zabbix-agent2:5.4.2-alpine            "/sbin/tini -- /usr/…"   44 hours ago    Restarting (1) 44 seconds ago                                                                                                                                                                                zabbix-agent
41b1ad3d1e64   zabbix/zabbix-web-nginx-mysql:5.4.2-ubuntu   "docker-entrypoint.sh"   45 hours ago    Up 4 hours                      0.0.0.0:80->8080/tcp, :::80->8080/tcp, 0.0.0.0:443->8443/tcp, :::443->8443/tcp                                                                                               zabbix-frontend
4fa5bd6d0f41   zabbix/zabbix-server-mysql:5.4.2-ubuntu      "/usr/bin/tini -- /u…"   45 hours ago    Up 4 hours                      0.0.0.0:10051->10051/tcp, :::10051->10051/tcp                                                                                                                                zabbix-server
5665248abd47   mysql:5.7                                    "docker-entrypoint.s…"   45 hours ago    Up 4 hours                      0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp                                                                                                                         mysql
```
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task7/img/elk1.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task7/img/elk2.png)
![screen shot web page](https://github.com/v-kostyukov/Internship-2021/blob/master/task7/img/elk3.png)


