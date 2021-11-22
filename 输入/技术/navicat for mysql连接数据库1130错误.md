navicat for mysql连接数据库1130错误

# navicat for mysql连接数据库1130错误

问题解决
在使用navicat for mysql工具连接远程数据库时出现的典型错误1130：
> HOST‘xx.xx.xx.xx’is not allowed to connect to this MySQL server
此问题是由于远程服务器限制了root用户登录主机而致，解决方案如下：
登录到远程服务器，使用控制台用root用户登入mysql:

	#mysql -u root -p

然后mysql会要求你输入密码，输入你的root账户密码，登入，然后输入下面的命令：

	mysql> GRANT ALL PRIVILEGES ON *.* TO root@’%';

回车，完成QUERY执行，然后更新权限：

	mysql> flush privileges;

再次连接，显示连接成功！ .~
**注意：在mysql命令行中输入QUERY语句时要记得在语句后加分号哦！**
[markdownFile.md](../_resources/33d992ab0995f41c789ed8179e3311b4.bin)