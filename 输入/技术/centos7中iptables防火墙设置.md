centos7中iptables防火墙设置

1、关闭firewall：
systemctl stop firewalld.service #停止firewall
systemctl disable firewalld.service #禁止firewall开机启动
firewall-cmd --state #查看默认防火墙状态（关闭后显示notrunning，开启后显示running）

### 2.关闭SElinux墙

       vi /etc/selinux/config
#SELINUX=enforcing  #注释掉
#SELINUXTYPE=targeted  #注释掉
SELINUX=disabled  #增加
:wq!  #保存退出
setenforce 0  #使配置立即生效

3.

### 配置防火访问端口

                   [root@cloud ~]# vi /etc/sysconfig/iptables

# Firewall configuration written by system-config-firewall

# Manual customization of this file is not recommended.

*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 60022 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 27017 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 8081 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 9600 -j ACCEPT

-A INPUT -m state --state NEW -m tcp -p tcp --dport 9601 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 6037 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT

systemctl restart iptables #重启防火墙使配置生效

3.1:重启iptables遇到unit not found错误的解决：

yum  install  iptables-services
systemctl enable iptables
systemctl  start  iptables