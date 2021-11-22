CentOS查看系统信息命令和方法

# CentOS查看系统信息命令和方法

时间:2014-06-24 14:40来源:aiezu.com 作者:aiezu.com [举报](http://www.centoscn.com/plus/erraddsave.php?aid=3184&title=CentOS%B2%E9%BF%B4%CF%B5%CD%B3%D0%C5%CF%A2%C3%FC%C1%EE%BA%CD%B7%BD%B7%A8)  点击:4232次

收集整理的一些linux查看系统信息的命令和方法：

##### 一、linux查看服务器系统信息的方法：

1、查看主机名/内核版本/CPU构架：
1. # uname -n -r -p -o
2. localhost.localdomain 2.6.32-220.el6.i686 i686
2、查看Linux系统类型和版本：
1. # head -n 1 /etc/issue
2. CentOS release 6.2 (Final)
3、查看语言字符集设置：
1. # echo $LANG $LANGUAGE
2. zh_CN.UTF-8
3. # cat /etc/sysconfig/i18n
4. LANG="zh_CN.UTF-8"
4、查看用户：
1. # whoami #查看当前登录用户名
2. # id #查看当前用户及其属组
3. # w #查看当前登录的用户及运行的命令
4. # last #查看最近登录用户
5. # cat /etc/passwd|awk -F: '{print $1}' #查看服务器上面所有用户
5、查看其他系统信息：
1. # date '+%Y-%m-%d %H:%M:%S' #查看系统时间
2. # ps -ef #查看运行进程
3. # uptime #查看服务器开机时长，用户数，平均负载
4. # lsmod #查看所有加载的模块
5. # env #查系统环境变量
6. # crontab -l #查看计划任务

##### 二、linux查看服务器硬件设备信息：

1、查看服务器CPU信息：
1. # grep 'model name' /proc/cpuinfo|awk -F: '{print $2}'|sed 's# ##g'|uniq -c
2. 8 Intel(R) Xeon(R) CPU E5630 @ 2.53GHz #8个核心的Intel Xeon CPU
2、查看服务器CPU位数：
1. # getconf LONG_BIT
3、查看网卡型号：
1. # lspci |grep Ethernet

2. Ethernet controller: Broadcom Corporation NetXtreme II BCM5709 Gigabit Ethernet (rev 20)

4、查看其他硬件信息：
1. # lspci -tv #查看所有PCI设备
2. # lsusb -tv #查看所有usb外设
3. # cat /etc/sysconfig/keyboard #查看键盘布局

##### 三、linux查看服务器存储信息：

1、查看内存信息：
1. # sed -n '/MemTotal\|MemFree/p' /proc/meminfo
2. MemTotal: 16426736 kB
3. MemFree: 14171748 kB
2、查看交换空间：
1. # sed -n '/SwapTotal\|SwapFree/p' /proc/meminfo
2. SwapTotal: 16771852 kB
3. SwapFree: 16771852 kB
3、查看挂载分区空间使用情况：
1. 文件系统 容量 已用 可用 已用% 挂载点
2. /dev/sda6 9.7G 570M 8.7G 7% /
3. /dev/sda7 3.9G 73M 3.7G 2% /tmp
4. /dev/sda2 20G 2.5G 16G 14% /var
5. /dev/sda8 388G 4.9G 363G 2% /storage
6. /dev/sda5 15G 2.4G 12G 18% /usr
7. /dev/sda1 92M 12M 75M 14% /boot
8. tmpfs 7.9G 0 7.9G 0% /dev/shm

##### 四、linux查看服务器网络信息：

1、查看Linux系统主机名：
1. # hostname
2. localhost.localdomain
2、查看服务器IP地址：

1. # ifconfig|grep 'inet addr:'|grep -v '127.0.0.1'|cut -d: -f2|awk '{ print $1}'

2. 192.168.17.238
3. 192.168.1.9
3、查看linux网关：
1. # route |grep default
2. default 192.168.1.1 0.0.0.0 UG 0 0 0 em1
4、查看linux端口：
1. # netstat -lntp #查看监听(Listen)的端口
2. # netstat -antp #查看所有建立的TCP连接
5、查看linux打开服务：
1. # chkconfig --list|grep 启用 #查看开启的服务
2. sshd 0:关闭 1:关闭 2:启用 3:启用 4:启用 5:启用 6:关闭
3. httpd 0:关闭 1:关闭 2:关闭 3:启用 4:关闭 5:关闭 6:关闭
6、查看服务器DNS配置：
1. # cat /etc/resolv.conf
2. nameserver 192.168.0.66
3. nameserver 202.106.0.20
7、其他网络信息：
1. # iptables -L #查看防火墙规则
2. # route -n #查看路由表
3. # netstat -s #查看网络统计信息