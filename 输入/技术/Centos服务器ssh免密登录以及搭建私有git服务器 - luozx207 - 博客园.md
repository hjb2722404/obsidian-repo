Centos服务器ssh免密登录以及搭建私有git服务器 - luozx207 - 博客园

#  Centos服务器ssh免密登录以及搭建私有git服务器

一、概述

　　服务器的免密登录和git服务器的搭建，关键都是要学会把自己用的机器的公钥添加到服务器上，让服务器“认识”你的电脑，从而不需要输入密码就可以远程登录服务器上的用户

　　免密登录当然是登录root用户，而搭建git服务器需要在服务器上创建一个git用户。注意服务器上每个用户识别的公钥存在不同的文件中，因此需要自己的电脑既能免密登录，又能使用git服务器，就要把自己电脑的公钥添加到两个文件中

二、服务器免密登录
　　1、修改服务器sshd config配置
　　登录服务器的root用户，然后输入
vim /etc/ssh/sshd_config
　　编辑root用户的ssh设置，在文件中加入
RSAAuthentication yes
PubkeyAuthentication yes
　　两句，用以开启ssh证书登录
　　注意到文件中有一行
AuthorizedKeysFile .ssh/authorized_keys
　　这里指定了root公钥存放的文件，下一步要做的就是将我的电脑的公钥加到这个文件里
　　2、获取自己机器的公钥
ssh-keygen -t rsa
　　之后一路回车，公钥和私钥都会存在默认的～/root/.ssh/目录中。
　　进入这个目录，用  cat id_rsa.pub  查看公钥，然后将显示的内容复制到服务器的authorized_keys中即可，此文件一行一个公钥
　　3、免密登录
　　在自己的机器中输入ssh root@服务器公网ip就可以直接登录服务器的root账号了

![1220254-20180911105207693-597228921.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180806.png)

　　4、禁用密码登录（可选
　　防止服务器登录密码被暴力破解，禁用密码登录，修改sshd_config，找到PasswordAuthentication将它设置为no
　　重启ssh服务
service sshd restart
三、搭建git服务器

　　在理解了服务器免密登录的原理后搭建git服务器就很简单了，我们需要创建一个用户git，把git仓库授权给git管理，然后把允许访问git仓库的机器的公钥添加到git用户的authorized_keys文件中。

　1、安装git
yum install -y git
　　-y：对安装过程中所有的提示选择yes
　2、创建git用户
adduser git
　3、配置git用户的ssh访问设置
　　进入git用户目录
cd /home/git
　　创建.ssh文件夹
mkdir .ssh
　　将.ssh文件夹的权限值设为700，即只允许本用户和root用户拥有读、写、执行权限。
chmod 700 .ssh

　　这么做的原因是是如果authorized_keys文件、$HOME/.ssh目录 或 $HOME目录让本用户之外的用户有写权限，那么sshd都会拒绝使用 ~/.ssh/authorized_keys 文件中的key来进行认证的。

　　创建一个空文件authorized_keys
touch .ssh/authorized_keys
　　将authorized_keys权限值设为600，即只允许本用户和root用户拥有读、写权限。
chmod 600 .ssh/authorized_keys
　　将git文件夹的用户名和组名都改为git，-R表示对该文件夹下所有子文件进行同样的操作
cd /home
chown -R git:git git
　4、将本机公钥拷贝到git的authorized_keys中，一行一个
　5、创建git仓库
　　在home目录下新建一个gitrepo文件夹作为git仓库的储存室
cd /home
mkdir gitrepo
　　将此文件夹归为git所有
chown git:git gitrepo
　　创建第一个git仓库
cd gitrepo
git init --bare test.git
　　将仓库归为git所有
chown -R git:git test.git
　6、在客户端拉取服务器新建的git仓库
git clone git@公网ip:/home/gitrepo/test.git
　　在本地编辑仓库并提交后，可以连接到服务器查看git仓库的修改时间，如果修改时间有变化则说明提交成功
　7、从客户端push仓库
git remote add origin git@公网ip:/home/gitrepo/test.git
git push -u origin master
　8、禁用shell登录
　　如果希望git用户不能登录shell，就要修改git用户的权限
　　修改/etc/passwd
vim /etc/passwd
　　将
git:x:1000:1000::/home/git:/bin/bash
　　改为
git:x:1000:1000::/home/git:/bin/git-shell
　　这样，`git`用户可以正常通过ssh使用git，但无法登录shell。
Measure
Measure