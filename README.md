# Internship-2021
DevOps Exadel Internship 2021

## Task1: Git/GitHub 
### Create a new local repository
``` git init ``` 
* git config --global user.email "Ваш e-mail" && git config --global user.name "Ваше имя" - задать следующие данные о себе
* git status - проверить статус вашего репозитория
* git commit -m “add .gitignore” - зафиксируйте изменения в локальном репозитории
* git commit --amend -m “комментарий” - перезапись последнего коммита
* git reset --soft <commit> “комментарий” - удалить из истории все, что после <commit>, но сохранить состояние рабочей директории
* git revert <commit> “комментарий” - добавления коммита, который обращает <commit>, где <commit> - это идентификатор коммита, например, c9b93f7. Данная команда отменяет изменения, сделанные данным коммитом, не обязательно предшествующим. 
* git remote add origin [url](http:// "URL"), где [url](http:// "URL") это ссылка на репозиторий - привязать удаленный репозиторий к локальному 
* git push origin master - отправляем изменения, зафиксированные в локальном репозитории, на удаленный сервер
* git clone [url](http:// "URL"), где [url](http:// "URL") - ссылка на наш репозиторий, клонируем репозиторий 
* git pull (или git pull origin master, если вы не использовали команду git push -u origin master) - заберем изменения с удаленного репозитория   
  

