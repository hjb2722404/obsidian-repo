CentOS：删除旧版 PHP，安装新版 PHP

先查看一下安装在系统上的跟 PHP 相关的包：
`yum list installed | grep php`
可能会返回：

	php56u-cli.x86_64                       5.6.26-1.ius.centos7           @ius
	php56u-common.x86_64                    5.6.26-1.ius.centos7           @ius
	php56u-fpm.x86_64                       5.6.26-1.ius.centos7           @ius
	php56u-gd.x86_64                        5.6.26-1.ius.centos7           @ius
	php56u-mbstring.x86_64                  5.6.26-1.ius.centos7           @ius
	php56u-mcrypt.x86_64                    5.6.26-1.ius.centos7           @ius
	php56u-mysqlnd.x86_64                   5.6.26-1.ius.centos7           @ius
	php56u-pdo.x86_64                       5.6.26-1.ius.centos7           @ius
	php56u-pear.noarch                      1:1.10.1-4.ius.centos7         @ius
	php56u-pecl-igbinary.x86_64             1.2.1-6.ius.centos7            @ius
	php56u-pecl-jsonc.x86_64                1.3.10-2.ius.centos7           @ius
	php56u-pecl-memcached.x86_64            2.2.0-6.ius.centos7            @ius
	php56u-process.x86_64                   5.6.26-1.ius.centos7           @ius
	php56u-xml.x86_64                       5.6.26-1.ius.centos7           @ius

把这些包都删除掉。然后再安装新版的 PHP 就行了。

## 删除旧版 PHP

`sudo yum remove php56u-cli php56u-common php56u-fpm php56u-gd php56u-mbstring php56u-mcrypt php56u-mysqlnd php56u-pdo php56u-pear php56u-pecl-igbinary php56u-pecl-jsonc php56u-pecl-memcached php56u-process php56u-xml`

## 安装第三方仓库

`sudo yum install https://centos7.iuscommunity.org/ius-release.rpm`
搜索新版 PHP
`yum search php70u`

## 安装新版 PHP

`sudo yum install php70u-common php70u-fpm php70u-cli php70u-gd php70u-mysqlnd php70u-pdo php70u-mcrypt php70u-mbstring php70u-json php70u-opcache php70u-xml -y`