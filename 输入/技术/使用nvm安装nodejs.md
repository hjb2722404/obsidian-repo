使用nvm安装nodejs

前提：先安装git

1.切换到程序安装目录，运行命令克隆nvm的git仓库：

git clone https://github.com/creationix/nvm ~/.nvm

2.将nvm加入开机启动：

用VI打开下列三个文件中的一个（根据系统不同选择）：  `~/.bashrc` ,  `~/.profile` , or  `~/.zshrc`

在文件中加入：

source ~/.nvm/nvm.sh

保存 退出

3.运行一遍上面加入的开机启动中的命令：

source ~/.nvm/nvm.sh

4.然后在命令行中输入：

nvm

出现命令帮助信息，说明安装成功。

5.使用nvm安装node

nvm install v4.1.1

版本号根据自己的需要自己修改

6.运行下列命令检测node版本：

node -v

如果输出正确的版本号，表示安装成功。