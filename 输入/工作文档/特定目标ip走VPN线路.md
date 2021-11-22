特定目标ip走VPN线路

1.关闭VPN连接的默认网关设置

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124054.png)

1. cmd>

route [-p] add target-ip-range mask mask-range vpn-ip

例：目标ip为：112.111.22.10
       vpn连接获得的ip： 172.10.22.11

命令： route -p 112.111.0.0   mask 255.255.0.0  172.10.22.11

其中，-p 代表添加到永久路由，没有此选项，设置将在电脑重启后失效，有此选项，设置在电脑重启后依然有效。