# Internship-2021
DevOps Exadel Internship 2021

## Task1: Git/GitHub
### Create a new local repository
``` git init ```
### Tell Git who you are
``` git config --global user.email "Your e-mail" && git config --global user.name "Your name" ```
### List the files you've changed and those you still need to add or commit
``` git status ```
### Commit changes to head (but not yet to the remote repository)
``` git commit -m “add .gitignore” ```
### Replace the tip of the current branch by creating a new commit
``` git commit --amend -m “comment” ```
### This form resets the current branch head to commit. Does not touch the index file or the working tree at all (but resets the head to commit, just like all modes do)
``` git reset --soft <commit> “comment” ```
### Used to record some new commits to reverse the effect of some earlier commits (often only a faulty one)
``` git revert <commit> “comment” ```
### Connect to a remote repository
``` git remote add origin <url>```
### Send changes to the master branch of your remote repository:
``` git push origin master ```
### Clones a repository into a newly created directory
``` git clone <url> ```
### Send changes to the master branch of your remote repository
``` git pull origin master ```   

## Task 2: AWS Cloud
### Install AWS CLI Linux
```
1. curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
2. unzip awscliv2.zip
3. sudo ./aws/install
4. aws --version
```
### Install AWS CLI Windows
``` https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html ```
### Configuration basics
``` aws configure ```
### URL web page "Hello world!" in AWS
``` http://52.30.126.226/ ```

## Task 3: Docker
### Install Docker Linux Ubuntu
```
1. sudo apt-get update
2. apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
3. curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
4. echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
5. sudo apt-get update
6. sudo apt-get install docker-ce docker-ce-cli containerd.io
```
### List all images that are locally stored with the Docker Engine
``` docker image ls ```
### Build an image from the Dockerfile in the current directory and tag the image
``` docker build -t myimage:1.0 . ```
### Run a container from the Alpine version 3.9 image, name the running container “web” 
### and expose port 5000 externally, mapped to port 80 inside the container.
``` docker container run --name web -p 5000:80 alpine:3.9 ```
### Stop a running container through SIGTERM 
``` docker container stop web ```
### Stop a running container through SIGKILL 
``` docker container kill web ```
### Delete an image from the local image store
``` docker image rm alpine:3.4 ```
### List the networks 
``` docker network ls ```
### List the running containers (add --all to include stopped containers)
``` docker container ls  ```
### Delete all running and stopped containers 
``` docker container rm -f $(docker ps -aq) ```
### Print the last 100 lines of a container’s logs 
``` docker container logs --tail 100 web ```
### Pull an image from a registry
``` docker pull myimage:1.0  ```
### Retag a local image with a new image name and tag 
``` docker tag myimage:1.0 myrepo/myimage:2.0 ```
### Push an image to a registry 
``` docker push myrepo/myimage:2.0 ```

### Task 4: Ansible
### Installing Ansible with pip
``` 
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
python3 -m pip install ansible
```
### Installing Ansible on Ubuntu
``` 
apt update
apt install software-properties-common -y
add-apt-repository --yes --update ppa:ansible/ansible
apt install ansible -y
ansible --version
```
### Task 5: Jenkins
### Download and run Jenkins Docker image
``` 
docker run -d \
-v jenkins_home:/var/jenkins_home \
-p 8080:8080 -p 50000:50000 \
jenkins/jenkins:lts-jdk11
```
### Task 6: Databases
### Install mysql server on Ubuntu
``` 
sudo apt update
sudo apt install mysql-server
sudo mysql_secure_installation
```
### MySQL commands
``` 
Access monitor: mysql -u [username] -p; (will prompt for password)

Show all databases: show databases;

Access database: mysql -u [username] -p [database] (will prompt for password)

Create new database: create database [database];

Select database: use [database];

Determine what database is in use: select database();

Show all tables: show tables;

Show table structure: describe [table];

List all indexes on a table: show index from [table];

Create new table with columns: CREATE TABLE [table] ([column] VARCHAR(120), [another-column] DATETIME);

Adding a column: ALTER TABLE [table] ADD COLUMN [column] VARCHAR(120);

Adding a column with an unique, auto-incrementing ID: ALTER TABLE [table] ADD COLUMN [column] int NOT NULL AUTO_INCREMENT PRIMARY KEY;

Inserting a record: INSERT INTO [table] ([column], [column]) VALUES ('[value]', '[value]');

MySQL function for datetime input: NOW()

Selecting records: SELECT * FROM [table];

Explain records: EXPLAIN SELECT * FROM [table];

Selecting parts of records: SELECT [column], [another-column] FROM [table];

Counting records: SELECT COUNT([column]) FROM [table];

Counting and selecting grouped records: SELECT *, (SELECT COUNT([column]) FROM [table]) AS count FROM [table] GROUP BY [column];

Selecting specific records: SELECT * FROM [table] WHERE [column] = [value]; (Selectors: <, >, !=; combine multiple selectors with AND, OR)

Select records containing [value]: SELECT * FROM [table] WHERE [column] LIKE '%[value]%';

Select records starting with [value]: SELECT * FROM [table] WHERE [column] LIKE '[value]%';

Select records starting with val and ending with ue: SELECT * FROM [table] WHERE [column] LIKE '[val_ue]';

Select a range: SELECT * FROM [table] WHERE [column] BETWEEN [value1] and [value2];

Select with custom order and only limit: SELECT * FROM [table] WHERE [column] ORDER BY [column] ASC LIMIT [value]; (Order: DESC, ASC)

Updating records: UPDATE [table] SET [column] = '[updated-value]' WHERE [column] = [value];

Deleting records: DELETE FROM [table] WHERE [column] = [value];

Delete all records from a table (without dropping the table itself): DELETE FROM [table]; (This also resets the incrementing counter for auto generated columns like an id column.)

Delete all records in a table: truncate table [table];

Removing table columns: ALTER TABLE [table] DROP COLUMN [column];

Deleting tables: DROP TABLE [table];

Deleting databases: DROP DATABASE [database];

Custom column output names: SELECT [column] AS [custom-column] FROM [table];

Export a database dump (more info here): mysqldump -u [username] -p [database] > db_backup.sql

Use --lock-tables=false option for locked tables (more info here).

Import a database dump (more info here): mysql -u [username] -p -h localhost [database] < db_backup.sql

Logout: exit;

Select from multiple tables: SELECT [table1].[column], [table1].[another-column], [table2].[column] FROM [table1], [table2];

Combine rows from different tables: SELECT * FROM [table1] INNER JOIN [table2] ON [table1].[column] = [table2].[column];

Combine rows from different tables but do not require the join condition: SELECT * FROM [table1] LEFT OUTER JOIN [table2] ON [table1].[column] = [table2].[column]; (The left table is the first table that appears in the statement.)

Rename column or table using an alias: SELECT [table1].[column] AS '[value]', [table2].[column] AS '[value]' FROM [table1], [table2];

List all users: SELECT User,Host FROM mysql.user;

Create new user: CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';

Grant ALL access to user for * tables: GRANT ALL ON database.* TO 'user'@'localhost';

Find out the IP Address of the Mysql Host: SHOW VARIABLES WHERE Variable_name = 'hostname';
```
### Task 7: Zabbix. ELK. Grafana
