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
``` git remote add origin [url](http:// "URL") ```
### Send changes to the master branch of your remote repository:
``` git push origin master ```
### Clones a repository into a newly created directory
``` git clone [url](http:// "URL") ```
### Send changes to the master branch of your remote repository
``` git pull origin master ```   
  

