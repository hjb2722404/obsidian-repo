# git 命令大全

## 代码库

### 在当前目录新建一个Git代码库  

```shell
$ git init
```

### 新建一个目录，将其初始化为Git代码库

 ```shell
 $ git init [project-name]
 ```

### 下载一个项目和它的整个代码历史

```shell
  $ git clone [url]
```

## 配置

### 显示当前的Git配置

```shell
  $ git config --list
```

### 编辑Git配置文件

```shell
  $ git config -e [--global]
```

### 设置提交代码时的用户信息

```shell
  $ git config [--global] user.name "[name]"

  $ git config [--global] user.email "[email address]"
```

## 本地增删改文件

### 添加指定文件到暂存区

```shell
  $ git add [file1] [file2] ...
```

###  添加指定目录到暂存区，包括子目录

```shell
  $ git add [dir]
```

###  添加当前目录的所有文件到暂存区

```shell
  $ git add .
```

### 添加每个变化前，都会要求确认,对于同一个文件的多处变化，可以实现分次提交

```shell
  $ git add -p
```

### 删除工作区文件，并且将这次删除放入暂存区

```shell
  $ git rm [file1] [file2] ...
```

### 停止追踪指定文件，但该文件会保留在工作区

```shell
  $ git rm --cached [file]
```


  ### 改名文件，并且将这个改名放入暂存区
```shell
  $ git mv [file-original] [file-renamed]
```


## 代码提交

### 提交暂存区到仓库区
```shell
$ git commit -m [message]
```

### 提交暂存区的指定文件到仓库区
```shell
$ git commit [file1][file2]... -m [message]
```

### 提交工作区自上次`commit`之后的变化，直接到仓库区
```shell
$ git commit -a
```

### 提交时显示所有`diff`信息
```shell
$ git commit -v
```

### 使用一次新的`commit`，替代上一次提交，如果代码没有任何新变化，则用来改写上一次`commit`的提交信息
```shell
$ git commit --amend -m [message]
```

### 重做上一次`commit`，并包括指定文件的变化
```shell
$ git commit --amend [file1] [file2] ...
```


## 分支操作

### 列出所有本地分支
```shell
$ git branch
```

### 列出所有远程分支
```shell
$ git branch -r
```

### 列出所有本地分支和远程分支
```shell
$ git branch -a
```

### 新建一个分支，但依然停留在当前分支
```shell
$ git branch [branch-name]
```

### 新建一个分支，并切换到该分支
```shell
$ git checkout -b [branch]
```

### 新建一个分支，指向特定`commit`
```shell
$ git branch [branch] [commit]
```

### 新建一个分支，与指定的远程分支建立追踪关系
```shell
$ git branch --track [branch] [remote-branch]
```

### 切换到指定分支，并更新工作区
```shell
$ git checkout [branch-name]
```

### 建立追踪关系，在现有分支与指定的远程分支之间
```bash
$ git branch --set-upstream [branch] [remote-branch]
```

### 合并指定分支到当前分支
```shell
$ git merge [branch]
```

### 选择一个`commit`，合并进当前分支
```bash
$ git cherry-pick [commit]
```

### 删除分支
```shell
$ git branch -d [branch-name]
```

### 批量删除本地分支(排除分支名包含`master`和`dev`的分支)
```shell
$ git branch | grep -v -E 'master|dev' | xargs git branch -D
```

### 删除远程分支
```shell
$ git push origin --delete [branch-name]
$ git branch -dr [remote/branch]
```

### 批量删除远程分支(排除分支名包含`master`和`dev`的分支)
```shell
$ git branch -r | grep -v -E `master|dev` | sed 's/origin\///g' | xargs -I {} git push origin : {}
```
> 如果有些分支无法删除，是因为远程分支的缓存问题，可以使用`git remote prune`


## 标签（tag）操作

### 列出所有`tag`
```shell
$ git tag
```

### 新建一个`tag`在当前`commit`
```shell
$ git tag [tag]
```

### 新建一个`tag`在指定`commit`
```shell
$ git tag [tag] [commit]
```

### 查看`tag`信息
```shell
$ git show [tag]
```

### 提交指定`tag`
```shell
$ git push [remote] [tag]
```

### 提交所有`tag`
```shell
$ git push [remote] --tags
```

### 新建一个分支，指向某个tag
```shell
$ git checkout -b [branch] [tag]
```

### 批量删除本地tag
```shell
$ git tag | xargs -I {} git tag -d {}
```

### 批量删除远程tag
```shell
$ git tag | xargs -I {} git push origin :refs/tags/{}
```



## 查看信息

### 显示有变更的文件
```shell
$ git status
```

### 显示当前分支的版本历史
```shell
$ git log
```

### 显示提交历史，以及每次提交发生变更的文件
```shell
$ git log --stat
```

### 显示某个文件的版本历史，包括文件改名
```shell
$ git log --follow [file]
$ git whatchanged [file]
```

### 显示指定文件相关的每一次`diff`
```shell
$ git log -p [file]
```

### 显示最近的n次提交的信息
```shell
$ git log -[n]
```


### 显示指定文件是什么人在什么时间修改过
```shell
$ git blame [file]
```

### 显示暂存区和工作区差异
```shell
$ git diff
```

### 显示暂存区和上一个提交的差异
```shell
$ git diff --cached [file]
```

### 显示工作区与当前分支最新提交之间的差异
```shell
$ git diff HEAD
```

### 显示两次提交之间的差异
```shell
$ git diff [first-commit]...[last-commit]
```

### 仅比较统计信息
```shell
$ git diff --stat
```

### 显示某次提交的元数据和内容变化
```shell
$ git show [commit]
```

### 显示某次提交发生变化的文件
```shell
$ git show --name-only [commit]
```

### 显示某次提交时，某个文件的内容
```shell
$ git show [commit]:[filename]
```

### 显示最近的git操作日志
```shell
$ git reflog
```

### 显示Git命令的帮助信息
```shell
$ git help [command]
```




## 远程同步

### 下载远程仓库的所有变动
```shell
$ git fetch [remote]
```

### 显示所有远程仓库
```shell
$ git remote -v
```

### 显示某个远程仓库的信息
```shell
$ git remote show [remote]
```

### 增加一个新的远程仓库，并命名
```shell
$ git remote add [shortname] [url]
```

### 取回远程仓库的变化，并与本地分支合并
```shell
$ git pull [reomte] [branch]
```

### 上传本地指定分支到远程仓库
```shell
$ git push [remote] [branch]
```

### 强行推送当前分支到远程仓库，即使有冲突
```shell
$ git push [remote] --force
```

### 推送所有分支到远程仓库
```shell
$ git push [remote] --all
```

## 贮藏操作

### 将工作区已追踪的更改和暂存区贮藏到【栈】中
```shell
$ git stash
```

### 列出【栈】中的所有stash
```shell
$ git stash list
```

### 将stash恢复到暂存区和工作目录，但不删除stash
```shell
$ git stash apply stash@{id}
```


### 将【栈】顶的stash恢复暂存区和工作目录，并且将这个stash从【栈】中删除
```shell
$ git stash pop
```

### 删除【栈】中所有stash
```shell
$ git stash drop stash@{id}
```

### 贮藏时包含未跟踪文件
```shell
$ git stash -u
```

### 贮藏时包含所有文件（包括忽略的文件）[不推荐]
```shell
$ git stash -a
```

### 贮藏时添加一个说明
```
$ git stash save "说明"
```

### 查看指定stash的内容
```shell
$ git stash show stash@{id}
```





## 撤销操作

### 恢复暂存区的指定文件到工作区
```shell
$ git checkout [file]
```

### 恢复某个`commit`的指定文件到工作区
```shell
$ git checkout [commit] [file]
```

### 恢复上一个`commit`的所有文件到工作区
```shell
$ git checkout .
```

### 重置暂存区的指定文件，与上一次`commit`保持一致，但工作区不变
```shell
$ git reset [file]
```

### 将指定提交的更改恢复到暂存区，工作区不变
```shell
$ git reset --soft [commit]
```

### 将指定提交的更改恢复到暂存区和工作目录
```shell
$ git reset --mixed [commit]
```

### 重置暂存区与工作区，与上一次`commit`保持一致
```shell
$ git reset --hard
```

### 重置当前分支的指针为指定`commit`，同时重置暂存区，但工作区不变
```shell
$ git reset [commit]
```

### 重置当前分支的指针的HEAD为指定`commit`， 同时重置暂存区和工作区，与指定`commit`一致
```shell
$ git reset --hard [commit]
```

### 重置当前HEAD为指定`commit`，但保持暂存区和工作区不变
```
$ git reset --keep [commit]
```

### 新建一个`commit` 用来撤销指定`commit`，后者的所有变化都将被前者所抵消，并且应用到当前分支
```shell
$ git revert [commit]
```

### 新建一个`commit`,用来代替当前提交至之前的N次提交，当前提交至之前的N次提交都将被撤销
```shell
$ git revert HEAD~n
```

## 其它

### 生成一个可供发布的压缩包
```shell
$ git archive
```

