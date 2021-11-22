docker的基本操作和在docker镜像中安装自己的程序运行 - qq_29354731的博客 - CSDN博客

原

# docker的基本操作和在docker镜像中安装自己的程序运行

2018年04月19日 17:29:21[纳年小新不吃青椒](https://me.csdn.net/qq_29354731)阅读数：2913标签：[docker](http://so.csdn.net/so/search/s.do?q=docker&t=blog)[centos](http://so.csdn.net/so/search/s.do?q=centos&t=blog)[程序](http://so.csdn.net/so/search/s.do?q=%E7%A8%8B%E5%BA%8F&t=blog)更多

个人分类：[docker](https://blog.csdn.net/qq_29354731/article/category/7605051)

1，背景
   虚拟机系统：centos 7

2，关闭防火墙，这里使用临时关闭:
   setenforce 0
   (永久关闭：修改/etc/sysconfig/selinux文件，将SELINUX的值设置为disabled。)

3，启动docker服务
   service docker start
可选：设置开机启动：systemctl enable docker
说明：swarm是通过docker api而进行docker管理的，所以需要将docker的rest api启动
      Centos docker配置文件位置：/etc/sysconfig/docker
      比如：修改配置中想要且未被占用的端口号，比如2375，修改配置文件中内容：

      OPTIONS='-H tcp://0.0.0.0:[docker_port] -H unix:///var/run/docker.sock --selinux-enabled'

      修改之后重启服务：service docker restart
      此时看下ps -ef | grep docker可以看到docker进程的启动项-H tcp://0.0.0.0:2375

4，搜索可用的docker镜像
   docker search centos (centos可选参数，)

5，下载你需要的docker镜像，注意：这里要写用docker search搜索到的完整的镜像名。
   docker pull centos:latest
6，查看已经安装过的镜像，此处记住需要运行的镜像的name
   docker images

7，挂载数据卷，运行一个普通的容器，用来同步数据
   docker run -v  （主机要共享的目录）:（容器上同步的目录）  --name （指定数据卷容器的名称） centos /bin/bash
   冒号前为宿主机目录，必须为绝对路径，冒号后为镜像内挂载的路径。默认挂载的路径权限为读写。如果指定为只读可以用：ro，以 / 开头表示为绝对路径
   运行：docker run -v /home/wpb:/home/wpb  --name dataname centos /bin/bash

8，再运行一个新的容器启用镜像，并使用这个数据卷，这样就做到了文件夹文件的同步，运行完成后，进入镜像中
   docker run -it --volumes-from 卷名称 镜像名称
   --volumes-from用来指定要从哪个数据卷来挂载数据，镜像名称：需要启用的镜像
   docker run -it --volumes-from dataname centos /bin/bash

9，安装你自己的.net core程序

10，docker centos镜像下安装.net core
      rpm --import https://packages.microsoft.com/keys/microsoft.asc

 sh -c 'echo -e "[packages-microsoft-com-prod]\nname=packages-microsoft-com-prod \nbaseurl= https://packages.microsoft.com/yumrepos/microsoft-rhel7.3-prod\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/dotnetdev.repo'

    yum update，更新系统
    yum install libunwind libicu
    yum install dotnet-sdk-2.0.0（可以自己指定版本号，但必须大于2.0）

11，进入到程序目录(之前同步的)，运行程序
    cd home
    cd wpb
    dotnet 你要运行的程序
    退出程序：exit
12，另开一个ssh连接保存当前镜像状态
    查看正在运行的docker
    docker ps，出现以下

    CONTAINER ID（容器id）IMAGE(镜像名称) COMMAND（命令文件夹） CREATED （创建时间）   STATUS （状态:up代表正在运行）PORTS（端口）NAMES（docker名称）

    复制当前运行的容器id
13，提交当前修改后的状态，保存为镜像
    docker commit 容器id 新的镜像名称，运行完返回新版本镜像的id号
14，提交完后，使用docker images可以查看新提交保存的镜像id，然后到处当前镜像为tar文件
    docker images
    docker save 镜像id> /文件保存在主机的目录/文件保存的名称.tar

15，然后在其他安装好docker的linux系统上载入新的镜像

    docker load --input /文件路径/文件名称.tar

其他docker命令：

建一个新容器并登入：docker run -i -t IMAGE id /bin/bash

启动一个退出的容器：docker start 容器ID

        进入到已经运行中的容器：docker attach 容器ID

        查看docker的信息，包括Containers和Images数目、kernel版本等:docker info

        删除容器:docker rm CONTAINERID

        删除镜像：docker rmi IMAGE（repository:tag）

得到image id:docker inspect -f'{{.Id}}'容器id

        停止正在运行的容器：docker stop CONTAINERID

        列出容器：docker ps -a
    查看最近生成的容器：docker ps -l
    查看正在运行的容器：docker ps