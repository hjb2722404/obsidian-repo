centos 添加／删除用户和用户组 - 让双脚&去腾空 - 博客园

# centos系统添加/删除用户和用户组

  在centos中增加用户使用adduser命令而创建用户组使用groupadd命令，这个是不是非常的方便呀，其实复杂点的就是用户的组与组权限的命令了，下面来给各位介绍一下吧。

1、建用户：
adduser phpq                         //新建phpq用户
passwd phpq                          //给phpq用户设置密码
2、建工作组
groupadd test                        //新建test工作组
3、新建用户同时增加工作组
useradd -g test phpq               //新建phpq用户并增加到test工作组
注：：-g 所属组 -d 家目录 -s 所用的SHELL
4、给已有的用户增加工作组
usermod -G groupname username
或者：gpasswd -a username groupname

（注意：添加用户到某一个组 可以使用`[usermod](http://man.linuxde.net/usermod) -G groupname username`这个命令可以添加一个用户到指定的组，但是以前添加的组就会清空掉。

所以想要添加一个用户到一个组，同时保留以前添加的组时，请使用gpasswd这个命令来添加操作用户）
5、临时关闭
在/etc/shadow文件中属于该用户的行的第二个字段（密码）前面加上*就可以了。想恢复该用户，去掉*即可。
或者使用如下命令关闭用户账号：
passwd peter –l
重新释放：
passwd peter –u
6、永久性删除用户账号
userdel peter
groupdel peter
usermod –G peter peter   （强制删除该用户的主目录和主目录下的所有文件和子目录）
7、从组中删除用户
编辑/etc/group 找到GROUP1那一行，删除 A 或者用命令 gpasswd -d A GROUP
8、显示用户信息
id user
cat /etc/passwd
补充:查看用户和用户组的方法
用户列表文件：/etc/passwd
用户组列表文件：/etc/group
查看系统中有哪些用户：cut -d : -f 1 /etc/passwd
查看可以登录系统的用户：cat /etc/passwd | grep -v /sbin/nologin | cut -d : -f 1
查看某一用户：w 用户名
查看登录用户：who
查看用户登录历史记录：last

#

# centos普通用户设置sudo权限

一直使用root用户是危险的，最好在普通用户下进行工作。但有些操作必须要root权限才可以执行，所以，这里小编会介绍，如何让普通用户拥有root权限。

## 工具/原料

- centos

## 方法/步骤

1.  敲入命令:
sudo mkdir xxx
希望在普通用户下，通过sudo命令，让用户暂时拥有root权限，并创建一个文件夹。
很明显，失败了，错误原因是：该用户暂没有root权限

[![e850352ac65c10381722e1e6b1119313b07e89b1.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180328.png)](http://jingyan.baidu.com/album/49ad8bce77a0365834d8fa95.html?picindex=1)

2.
敲入命令：
su
该命令可以让我们切换到root用户

[![f3d3572c11dfa9ec87e47a3361d0f703908fc1cf.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180333.png)](http://jingyan.baidu.com/album/49ad8bce77a0365834d8fa95.html?picindex=2)

3.
敲入命令：
visudo
visudo命令是用来编辑修改/etc/sudoers配置文件

[![c995d143ad4bd113a378981659afa40f4bfb0558.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180335.png)](http://jingyan.baidu.com/album/49ad8bce77a0365834d8fa95.html?picindex=3)

4.
入下图所示，打开sudoers文件

[![a5c27d1ed21b0ef4acb1b77adec451da81cb3ebc.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180338.png)](http://jingyan.baidu.com/album/49ad8bce77a0365834d8fa95.html?picindex=4)

5.
找到如下图所示，标出红线的一行
root  ALL=(ALL)    ALL

[![b151f8198618367a2a2250f92d738bd4b31ce56f.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180342.png)](http://jingyan.baidu.com/album/49ad8bce77a0365834d8fa95.html?picindex=5)

6.
在“root  ALL=(ALL)   ALL”这一行下面，再加入一行：
xulei  ALL=(ALL)     ALL
其中，xulei为你当前使用的用户名，也就是普通用户的用户名

[![0b55b319ebc4b7459cbe9932ccfc1e178a8215ef.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180345.png)](http://jingyan.baidu.com/album/49ad8bce77a0365834d8fa95.html?picindex=6)

7.
保存之后，输入exit，退出root用户

[![2f738bd4b31c870154829cc2247f9e2f0708ffda.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180348.png)](http://jingyan.baidu.com/album/49ad8bce77a0365834d8fa95.html?picindex=7)

8.
此时，再次输入命令：sudo mkdir xxx之后，可以发现，xxx文件夹建立成功，该文件夹是以root权限创建的

[![34fae6cd7b899e51c899143041a7d933c8950dfa.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180352.png)](http://jingyan.baidu.com/album/49ad8bce77a0365834d8fa95.html?picindex=8)

9.
好啦，结束啦。下图是所有的命令的集合，在这里截个图！

[![aa64034f78f0f736766362250955b319ebc41370.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180359.png)](http://jingyan.baidu.com/album/49ad8bce77a0365834d8fa95.html?picindex=9)