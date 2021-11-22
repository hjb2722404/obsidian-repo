iptables 再结尾插入有效白名单

1、按行数查看当前规则表：iptables -nL --line-number

2、插入： iptables -I INPUT 332 -p all -s [ipadress] -j ACCEPT