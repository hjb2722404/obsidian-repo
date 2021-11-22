怎样修改 CentOS 7 SSH 端口

# 怎样修改 CentOS 7 SSH 端口

# 摘要

昨天我连接 ssh 的时候看到，有 600 多次来自某个阿里云服务器的失败登录，然后赶紧改了密码，顺便再改一下 ssh 的允许端口……万万没想到，网上搜到的大部分教程均不能生效。在找了几个关键信息后得到比较完全的 CentOS 7 SSH 端口修改步骤。

# 修改 sshd_config 端口

Bash
$ vi /etc/ssh/sshd_config

取消 #Port 22 的注释，在下一行添加你需要修改的新端口 Port 2048。（这里不删除 22 端口是为了防止修改后新端口无法访问，造成无法用 ssh 连接服务器。）

Port 22
Port 2048
修改保存 sshd_config 文件后重启 sshd 服务：
Bash
$ systemctl restart sshd
退出 ssh 会话后，再用新的端口连接：
Bash
$ ssh -p 2048 root@example.com
ssh: connect to host 0.0.0.0 port 2048: Connection refused
好吧，native 了……对于 CentOS 7 这一套修改端口的方法已经不能生效了。

# 打开 [SELinux](https://en.wikipedia.org/wiki/Security-Enhanced_Linux) 端口

> SELinux 全称 Security Enhanced Linux (安全强化 Linux)，是 MAC (Mandatory Access Control，强制访问控制系统)的一个实现，目的在于明确的指明某个进程可以访问哪些资源(文件、网络端口等)。

对于 ssh，SELinux 默认只允许 22 端口，我们可以用 SELinux 管理配置工具 semanage，来修改 ssh 可访问的端口。

###### 安装 semanage 工具

Bash
$ yum provides semanage
$ yum -y install policycoreutils-python

###### 为 ssh 打开 2048 端口

Bash

# 为 ssh 添加新的允许端口

$ semanage port -a -t ssh_port_t -p tcp 2048

# 查看当前 SELinux 允许的端口

$ semanage port -l | grep ssh
ssh_port_t tcp 2048, 22

###### 错误处理

当 SELINUX 配置为禁用状态时，使用 semanage 会报错提示无法读取 policy 文件：

SELinux: Could not downgrade policy file /etc/selinux/targeted/policy/policy.30, searching for an older version.

SELinux: Could not open policy file <= /etc/selinux/targeted/policy/policy.30: No such file or directory

/sbin/load_policy: Can't load policy: No such file or directory

libsemanage.semanage_reload_policy: load_policy returned error code 2. (No such file or directory).

FileNotFoundError: [Errno 2] No such file or directory
修改 /etc/selinux/config 配置，启用 SELinux：
Bash
$ vi /etc/selinux/config
SELINUX=permissive

# 重启服务器

$ init 6

# 重启后查看 SELinux 状态

$ sestatus

# if it shows disable, you can run

$ load_policy -qi

###### 检查配置：

Bash
$ semanage port -a -t ssh_port_t -p tcp 2048
$ semanage port -l | grep ssh
ssh_port_t tcp 2048, 22

# 重启 ssh 服务

systemctl restart sshd
> 注：semange 不能禁用 ssh 的 22 端口：
Bash
$ semanage port -d -t ssh_port_t -p tcp 22
ValueError: 在策略中定义了端口 tcp/22，无法删除。

# 配置防火墙 firewalld

###### 启用防火墙 && 查看防火墙状态：

Bash
$ systemctl enable firewalld
$ systemctl start firewalld
$ systemctl status firewalld
● firewalld.service - firewalld - dynamic firewall daemon

Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)

Active: active (running) since 二 2016-12-20 02:12:59 CST; 1 day 13h ago
Main PID: 10379 (firewalld)
CGroup: /system.slice/firewalld.service
└─10379 /usr/bin/python -Es /usr/sbin/firewalld --nofork --nopid
$ firewall-cmd --state
running

###### 查看防火墙当前「默认」和「激活」zone（区域）：

Bash
$ firewall-cmd --get-default-zone
public
$ firewall-cmd --get-active-zones
public
interfaces: eth0 eth1
若没有激活区域的话，要执行下面的命令。

###### 激活 public 区域，增加网卡接口：

Bash
$ firewall-cmd --set-default-zone=public
$ firewall-cmd --zone=public --add-interface=eth0
success
$ firewall-cmd --zone=public --add-interface=eth1
success

###### 为 public zone 永久开放 2048/TCP 端口：

Bash

# 以防新端口不生效，先把 22 端口暴露

$ firewall-cmd --permanent --zone=public --add-port=22/tcp
$ firewall-cmd --permanent --zone=public --add-port=2048/tcp
success

# 重载防火墙

$ firewall-cmd --reload

# 查看暴露端口规则

$ firewall-cmd --permanent --list-port
443/tcp 80/tcp 22/tcp 2048/tcp
$ firewall-cmd --zone=public --list-all
public (default, active)
interfaces: eth0 eth1
sources:
services: dhcpv6-client ssh
ports: 443/tcp 80/tcp 22/tcp 2048/tcp
masquerade: no
forward-ports:
icmp-blocks:
rich rules:
退出 ssh 后，尝试连接新端口
Bash
$ ssh -p 2048 root@example.com
成功登录的话，就可以做收尾工作了。

# 禁用 22 端口

###### 删除 ssh 允许端口

Bash
$ vi /etc/ssh/sshd_config
#Port 22
Port 2048
$ systemctl restart sshd

# 用 ss 命令检查 ssh 监听的端口，没有 22 证明修改成功

$ ss -tnlp | grep ssh
LISTEN 0 128 *:2048 *:* users:(("sshd",18233,3))

###### 防火墙移除 22 端口

Bash
$ firewall-cmd --permanent --zone=public --remove-port=22/tcp
success
$ firewall-cmd --reload
$ firewall-cmd --permanent --list-port
443/tcp 80/tcp 2048/tcp
ssh 取消监听 22 端口，就已经配置好了，防火墙只不过是在 ssh 外多一层访问限制。如果要做的更好还可以将 22 端口的访问流量转向访问者本地：
Bash

$ firewall-cmd --permanen --zone=public --add-forward-port=port=22:proto=tcp:toport=22:toaddr=127.0.0.1

# 配置后重载防火墙，用 ssh -p 22 root@example.com 就会访问到自己本地的 22 端口。

若要删除 forward 配置，可以：
Bash

$ firewall-cmd --permanen --zone=public --remove-forward-port=port=22:proto=tcp:toport=22:toaddr=127.0.0.1

检验修改 ssh 端口是否成功：
Bash
$ ssh -p 22 root@example.com

# 无响应，因为转到了本地的 22 端口

# 若防火墙未 forward 连接，则会回显 "ssh: connect to host {ip} port 22: Connection refused"

$ ssh -p 2048 root@example.com

# 成功 success

# 引用