centos7 安装iptables ,关闭防火墙,打开指定的端口号 - 凤凰涅槃 - 51CTO技术博客

CentOS 7.0默认使用的是firewall作为防火墙，这里改为iptables防火墙。
**1、关闭并禁止firewall开机启动**：
停止
systemctl stop firewalld.service
禁止开机启动
systemctl disable firewalld.service
**2、安装iptables防火墙**
yum install iptables-services
**编辑防火墙配置文件打开指定的端口号使用udp协议打开52100端口：**
vi /etc/sysconfig/iptables

![Center.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180540.jpg)

**保存退出**
:wq
**最后重启防火墙使配置生效**
systemctl restart iptables.service
**设置防火墙开机启动**
systemctl enable iptables.service