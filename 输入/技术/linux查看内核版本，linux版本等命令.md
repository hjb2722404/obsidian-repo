linux查看内核版本，linux版本等命令

# linux查看内核版本，linux版本等命令

linux命令
服务器操作
####**查看内核版本**

	# uname -r

会有类似下面的输出：

	3.10.0-123.9.3.el7.x86_64

查看内核版本的详细信息：

	# uname -a

有类似下面的输出：

	Linux iZ285qepla9Z 3.10.0-123.9.3.el7.x86_64 #1 SMP Thu Nov 6 15:06:03 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

####**查看linux版本**

	# lsb_release -a

输出类似下面这样：

	LSB Version:    :core-4.1-amd64:core-4.1-noarch
	Distributor ID: CentOS
	Description:    CentOS Linux release 7.0.1406 (Core)
	Release:        7.0.1406
	Codename:       Core

[markdownFile.md](../_resources/9d6d2d16e4438c99e7311bdec6e6bb21.bin)