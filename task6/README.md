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
PLAY [Install mysql] ***************************************************************************************************************************************************************************************

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
### Write SQL scripts that will populate the database and check for existing tables / records.
``` 
mysql -u root -p internship_db < create_tables.sql
mysql> use internship_db
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SHOW TABLES;
+-------------------------+
| Tables_in_internship_db |
+-------------------------+
| Result                  |
| Students                |
+-------------------------+
2 rows in set (0.00 sec)

mysql -u root -p internship_db < insert_students.sql
mysql> use internship_db
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SELECT * FROM Students;
+----+---------------------------------------+-----------+
| ID | Student                               | StudentId |
+----+---------------------------------------+-----------+
|  1 | Назар Винник               |         1 |
|  2 | Александр Рекун         |         2 |
|  3 | Олег Бандрівський     |         3 |
|  4 | Владимир Бурдыко       |         4 |
|  5 | Вадим Марков               |         5 |
|  6 | Игорь Войтух               |         7 |
|  7 | Дмитрий Мошна             |         8 |
|  8 | Евгений Козловский   |         9 |
|  9 | Эд Еленский                 |        10 |
| 10 | Игорь Зинченко           |        11 |
| 11 | Виталий Костюков       |        14 |
| 12 | Евгений Лактюшин       |        16 |
| 13 | Михаил Лопаев             |        18 |
| 14 | Михаил Мостыка           |        19 |
| 15 | Андрей Новогродский |        20 |
| 16 | Сазонова Анна             |        21 |
| 17 | Дмитрий Соловей         |        22 |
| 18 | Артём Фортунатов       |        23 |
| 19 | Хоменко Іван               |        24 |
| 20 | Алексей Шутов             |        26 |
| 21 | Юрий Щербина               |        27 |
+----+---------------------------------------+-----------+
21 rows in set (0.00 sec)

mysql -u root -p internship_db < insert_result.sql
mysql> use internship_db
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SELECT * FROM Result;
+----+-----------+------------------+------------------+------------------+------------------+------------------+
| ID | StudentId | Task1            | Task2            | Task3            | Task4            | Task5            |
+----+-----------+------------------+------------------+------------------+------------------+------------------+
|  1 |         1 | Done             | Done with honors | Done with honors | Done with honors | Done             |
|  2 |         2 | Done with honors | Done with honors | Done with honors | Done with honors | Done with honors |
|  3 |         3 | Done             | Done with honors | Done with honors | Done with honors | Done with honors |
|  4 |         4 | Done with honors | Done with honors | Done             | Done             | Done             |
|  5 |         5 | Done             | Done             | Done             | Done             | Not competed     |
|  6 |         7 | Done with honors | Done with honors | Done with honors | Done with honors | Done with honors |
|  7 |         8 | Done             | Not competed     | Done             | Done             | Not competed     |
|  8 |         9 | Done             | Done with honors | Done             | Done             | Done             |
|  9 |        10 | Done with honors | Done with honors | Done with honors | Done             | Done             |
| 10 |        11 | Done             | Done             | Done             | Done             | Done             |
| 11 |        14 | Done             | Done with honors | Done with honors | Done with honors | Done with honors |
| 12 |        16 | Done             | Done with honors | Done             | Done             | Done with honors |
| 13 |        18 | Done             | Done with honors | Done with honors | Done with honors | Done with honors |
| 14 |        19 | Done             | Done with honors | Done with honors | Done with honors | Done             |
| 15 |        20 | Done             | Done with honors | Done with honors | Done with honors | Done with honors |
| 16 |        21 | Done with honors | Done with honors | Done with honors | Done with honors | Done with honors |
| 17 |        22 | Done with honors | Done with honors | Done with honors | Done with honors | Done             |
| 18 |        23 | Done             | Done             | Done with honors | Done with honors | Done             |
| 19 |        24 | Done             | Done             | Done             | Done             | Not competed     |
| 20 |        26 | Done             | Done with honors | Done with honors | Done with honors | Done with honors |
| 21 |        27 | Done with honors | Done with honors | Done with honors | Done with honors | Done with honors |
+----+-----------+------------------+------------------+------------------+------------------+------------------+
21 rows in set (0.00 sec)
```
### Writing a request by your last name will find information on completed tasks and display the result on the screen.
``` 
mysql -u root -p internship_db < select.sql
Enter password:
Student Task1   Task2   Task3   Task4   Task5
Виталий Костюков        Done    Done with honors        Done with honors        Done with honors        Done with honors
```
### Dump the database, delete the existing one and restore from the dump.
``` 
mysqldump -u root -p internship_db > /root/internship_db.sql
ls -la /root/
total 36
drwx------ 1 root root 4096 Jul  4 18:58 .
drwxr-xr-x 1 root root 4096 Jul  4 18:31 ..
-rw------- 1 root root   51 Jul  4 15:47 .bash_history
-rw-r--r-- 1 root root  570 Jan 31  2010 .bashrc
-rw------- 1 root root 2071 Jul  4 18:57 .mysql_history
-rw-r--r-- 1 root root  148 Aug 17  2015 .profile
-rw-r--r-- 1 root root  227 Jun 23 07:11 .wget-hsts
-rw-r--r-- 1 root root 5985 Jul  4 18:58 internship_db.sql

mysql> DROP DATABASE internship_db;
Query OK, 2 rows affected (0.06 sec)

mysql> CREATE DATABASE internship_db;
Query OK, 1 row affected (0.01 sec)

root@1d22a81284f1:/# mysql -u root -p internship_db < /root/internship_db.sql
Enter password:

mysql> SHOW TABLES;
+-------------------------+
| Tables_in_internship_db |
+-------------------------+
| Result                  |
| Students                |
+-------------------------+
2 rows in set (0.00 sec)

mysql> SELECT * FROM Students;
+----+---------------------------------------+-----------+
| ID | Student                               | StudentId |
+----+---------------------------------------+-----------+
|  1 | Назар Винник               |         1 |
|  2 | Александр Рекун         |         2 |
|  3 | Олег Бандрівський     |         3 |
|  4 | Владимир Бурдыко       |         4 |
|  5 | Вадим Марков               |         5 |
|  6 | Игорь Войтух               |         7 |
|  7 | Дмитрий Мошна             |         8 |
|  8 | Евгений Козловский   |         9 |
|  9 | Эд Еленский                 |        10 |
| 10 | Игорь Зинченко           |        11 |
| 11 | Виталий Костюков       |        14 |
| 12 | Евгений Лактюшин       |        16 |
| 13 | Михаил Лопаев             |        18 |
| 14 | Михаил Мостыка           |        19 |
| 15 | Андрей Новогродский |        20 |
| 16 | Сазонова Анна             |        21 |
| 17 | Дмитрий Соловей         |        22 |
| 18 | Артём Фортунатов       |        23 |
| 19 | Хоменко Іван               |        24 |
| 20 | Алексей Шутов             |        26 |
| 21 | Юрий Щербина               |        27 |
+----+---------------------------------------+-----------+
21 rows in set (0.00 sec)

mysql> SELECT * FROM Result;
+----+-----------+------------------+------------------+------------------+------------------+------------------+
| ID | StudentId | Task1            | Task2            | Task3            | Task4            | Task5            |
+----+-----------+------------------+------------------+------------------+------------------+------------------+
|  1 |         1 | Done             | Done with honors | Done with honors | Done with honors | Done             |
|  2 |         2 | Done with honors | Done with honors | Done with honors | Done with honors | Done with honors |
|  3 |         3 | Done             | Done with honors | Done with honors | Done with honors | Done with honors |
|  4 |         4 | Done with honors | Done with honors | Done             | Done             | Done             |
|  5 |         5 | Done             | Done             | Done             | Done             | Not competed     |
|  6 |         7 | Done with honors | Done with honors | Done with honors | Done with honors | Done with honors |
|  7 |         8 | Done             | Not competed     | Done             | Done             | Not competed     |
|  8 |         9 | Done             | Done with honors | Done             | Done             | Done             |
|  9 |        10 | Done with honors | Done with honors | Done with honors | Done             | Done             |
| 10 |        11 | Done             | Done             | Done             | Done             | Done             |
| 11 |        14 | Done             | Done with honors | Done with honors | Done with honors | Done with honors |
| 12 |        16 | Done             | Done with honors | Done             | Done             | Done with honors |
| 13 |        18 | Done             | Done with honors | Done with honors | Done with honors | Done with honors |
| 14 |        19 | Done             | Done with honors | Done with honors | Done with honors | Done             |
| 15 |        20 | Done             | Done with honors | Done with honors | Done with honors | Done with honors |
| 16 |        21 | Done with honors | Done with honors | Done with honors | Done with honors | Done with honors |
| 17 |        22 | Done with honors | Done with honors | Done with honors | Done with honors | Done             |
| 18 |        23 | Done             | Done             | Done with honors | Done with honors | Done             |
| 19 |        24 | Done             | Done             | Done             | Done             | Not competed     |
| 20 |        26 | Done             | Done with honors | Done with honors | Done with honors | Done with honors |
| 21 |        27 | Done with honors | Done with honors | Done with honors | Done with honors | Done with honors |
+----+-----------+------------------+------------------+------------------+------------------+------------------+
21 rows in set (0.00 sec)
```
### Extra. Write a Pipeline for Jenkins that will run ansible playbooks
``` 
pipeline {
    agent {
            label 'agent3'
          }
    environment {
        PASSWORD = credentials('ansible-secret')
        FILE = credentials('secret-file')
    }
    stages {
        stage('1-Build') {
            steps {
                echo "Start of Stage Build"
                dir('task6/EXTRA/ansible') {
                    sh """
                        pwd
                        ls -la
                        ansible-inventory --graph
                        ansible-playbook --vault-password-file ${FILE} mysql.yml
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
                    docker ps
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
### Console output
``` 
Started by user admin
Obtained task6/Jenkinsfile from git git@github.com:v-kostyukov/Internship-2021.git
Running in Durability level: MAX_SURVIVABILITY
[Pipeline] Start of Pipeline
[Pipeline] node
Running on agent3 in /home/jenkins/workspace/Deploy-to-prod-mysql
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential github-ssh
Fetching changes from the remote Git repository
 > git rev-parse --resolve-git-dir /home/jenkins/workspace/Deploy-to-prod-mysql/.git # timeout=10
 > git config remote.origin.url git@github.com:v-kostyukov/Internship-2021.git # timeout=10
Fetching upstream changes from git@github.com:v-kostyukov/Internship-2021.git
 > git --version # timeout=10
 > git --version # 'git version 2.25.1'
using GIT_SSH to set credentials githun-ssh
 > git fetch --tags --force --progress -- git@github.com:v-kostyukov/Internship-2021.git +refs/heads/*:refs/remotes/origin/* # timeout=10
Checking out Revision 2d8474021078b276a952fb9cdfa4200843d41f34 (refs/remotes/origin/master)
Commit message: "add files task6/Jenkinsfile"
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 2d8474021078b276a952fb9cdfa4200843d41f34 # timeout=10
 > git rev-list --no-walk 67e99556cfd1d234b85977ff2593075302e2b76a # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] withCredentials
Masking supported pattern matches of $PASSWORD or $FILE
[Pipeline] {
[Pipeline] stage
[Pipeline] { (1-Build)
[Pipeline] echo
Start of Stage Build
[Pipeline] dir
Running in /home/jenkins/workspace/Deploy-to-prod-mysql/task6/EXTRA/ansible
[Pipeline] {
[Pipeline] sh
Warning: A secret was passed to "sh" using Groovy String interpolation, which is insecure.
		 Affected argument(s) used the following variable(s): [FILE]
		 See https://jenkins.io/redirect/groovy-string-interpolation for details.
+ pwd
/home/jenkins/workspace/Deploy-to-prod-mysql/task6/EXTRA/ansible
+ ls -la
total 24
drwxrwxr-x 4 jenkins jenkins 4096 Jul  5 15:36 .
drwxrwxr-x 4 jenkins jenkins 4096 Jul  5 13:42 ..
-rw-rw-r-- 1 jenkins jenkins   35 Jul  5 13:42 ansible.cfg
drwxrwxr-x 3 jenkins jenkins 4096 Jul  5 13:42 inventory
-rw-rw-r-- 1 jenkins jenkins  185 Jul  5 15:36 mysql.yml
drwxrwxr-x 4 jenkins jenkins 4096 Jul  5 13:42 roles
-rw-rw-r-- 1 jenkins jenkins    0 Jul  5 14:40 secret
+ ansible-inventory --graph
@all:
  |--@dbservers:
  |  |--192.168.0.104
  |--@ungrouped:
+ ansible-playbook --vault-password-file **** mysql.yml

PLAY [Install mysql] ***********************************************************

TASK [Gathering Facts] *********************************************************
ok: [192.168.0.104]

TASK [mysql : Create a directories] ********************************************
changed: [192.168.0.104] => (item=master/data)
changed: [192.168.0.104] => (item=master/conf.d)
changed: [192.168.0.104] => (item=master/log)
changed: [192.168.0.104] => (item=master/backup)
changed: [192.168.0.104] => (item=master/entrypoint)
changed: [192.168.0.104] => (item=slave/data)
changed: [192.168.0.104] => (item=slave/conf.d)
changed: [192.168.0.104] => (item=slave/log)
changed: [192.168.0.104] => (item=slave/backup)
changed: [192.168.0.104] => (item=slave/entrypoint)

TASK [mysql : Create docker-compose.yml file] **********************************
changed: [192.168.0.104]

TASK [mysql : Deploy Docker Compose] *******************************************
ok: [192.168.0.104]

TASK [mysql : Deploy master my.cnf] ********************************************
changed: [192.168.0.104]

TASK [mysql : Deploy slave my.cnf] *********************************************
changed: [192.168.0.104]

TASK [mysql : Deploy master master.sql] ****************************************
changed: [192.168.0.104]

TASK [mysql : Deploy slave slave.sql] ******************************************
changed: [192.168.0.104]

TASK [mysql : Run docker-compose] **********************************************
changed: [192.168.0.104]

PLAY RECAP *********************************************************************
192.168.0.104              : ok=9    changed=7    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

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
/home/jenkins/workspace/Deploy-to-prod-mysql
+ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                                                    NAMES
def93783dc18   mysql     "docker-entrypoint.s…"   4 seconds ago   Up 1 second    33060/tcp, 0.0.0.0:49162->3306/tcp, :::49162->3306/tcp   mysql-slave
b3f7526e7b0f   mysql     "docker-entrypoint.s…"   5 seconds ago   Up 3 seconds   33060/tcp, 0.0.0.0:49161->3306/tcp, :::49161->3306/tcp   mysql-master
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
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```
### SHOW MASTER STATUS
``` 
docker exec -it mysql-master mysql -u root -p -e "SHOW MASTER STATUS;"
Enter password:
+---------------+----------+--------------+------------------+-------------------+
| File          | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
+---------------+----------+--------------+------------------+-------------------+
| binlog.000002 |      156 |              |                  |                   |
+---------------+----------+--------------+------------------+-------------------+
```
### SHOW SLAVE STATUS
``` 
docker exec -it mysql-slave mysql -u root -p -e "SHOW SLAVE STATUS\G;"
Enter password:
*************************** 1. row ***************************
               Slave_IO_State:
                  Master_Host: mysql-master
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File:
          Read_Master_Log_Pos: 4
               Relay_Log_File: def93783dc18-relay-bin.000002
                Relay_Log_Pos: 4
        Relay_Master_Log_File:
...
```