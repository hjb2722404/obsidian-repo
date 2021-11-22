docker命令整理

#### 查看docker信息：

	docker info

#### 查看docker网络:

	docker network ls

### 创建一个docker网络my-docker:

	docker network create --subnet=192.168.0.0/24 --gateway=192.168.0.1 --ip-range=192.168.0.0/24 mynetwork

#### 4种网络方式：

- host：docker run 使用 --net=host指定，ocker使用的网络实际上和宿主机一样
- container：使用 --net=container:container_id/container_name 多个容器使用共同的网络，看到的ip是一样的。
- none:使用 --net=none指定 这种模式下，不会配置任何网络。
- bridge：使用 --net=bridge指定， 默认模式，不会指定， 此模式会为每个容器分配一个独立的network namespace

-

#### 创建容器：

	docker create

#### 运行容器：

	docker run [OPTIONS] IMAGE[:TAG] [COMMAND] [ARG...]

		docker run -t -i -m 200M --memory-swap=300M --name=con_name [镜像的REPOSITORY] /bin/bash

		docker run -d -p 80:80 image_name

		docker run --network=my-docker --ip=192.168.0.5 -itd --name=con_name -h lb01 image_name

		docker run -i -t -v /root/software/:/mnt/software/ 83ee /bin/bash

		docker run -d --name server001-mysql1 -p 1001:22 -p 2001:3306 mycontos1.01 /start.sh

		docker run -d --restart=always bba-208

		docker run -d
	    --name fsTomcat
	    --restart always
	    -p 80:8080
	    -v
	/file/server/tomcat/fileStorageServer/server.xml:/usr/local/tomcat/conf/server.xml
	-v /file/server/tomcat/fileStorageServer/ROOT:/file/server/tomcat/fileStorageServer/ROOT
	-v /file/server/tomcat/fileStorageServer/fileStorage:/file/server/tomcat/fileStorage
	-v /file/server/tomcat/fileStorageServer/logs:/usr/local/tomcat/logs
	-v /file/server/tomcat/fileStorageServer/logs:/java_logs tomcat

		[OPTIONS start]
		-t 选项让Docker分配一个伪终端（pseudo-tty）并绑定到容器的标准输入上
		-i 则让容器的标准输入保持打开。
		-m或--memory：设置内存的使用限额，例如 100M, 2G。默认没有限制
		--memory-swap：设置内存+swap的使用限额。默认没有限制
		--name 容器名
		 -d 后台运行
		 -p 参数说明
			-p hostPort:containerPort
			-p ip:hostPort:containerPort
			-p ip::containerPort
			-p hostPort:containerPort:udp
		--network   #指定容器网络
		--ip        #设定容器ip地址
		-h          #给容器设置主机名
		-v：表示需要将本地哪个目录挂载到容器中，格式：-v <宿主机目录>:<容器目录>
		-e 设置容器运行所需要的环境变量
		--restart
			no，默认策略，在容器退出时不重启容器
			on-failure，在容器非正常退出时（退出状态非0），才会重启容器
			on-failure:3，在容器非正常退出时重启容器，最多重启3次
			always，在容器退出时总是重启容器
			unless-stopped，在容器退出时总是重启容器，但是不考虑在Docker守护进程启动时就已经停止了的容器
		[OPTIONS end]

#### 后面的执行相应SH脚本[COMMAND]

	/usr/sbin/sshd -D  表示启动ssh服务 表示容器长时间运行，不至于几秒后退出

#### 启动容器（后台模式）：

	docker run -d ubuntu:15.10 /bin/sh -c "while true; do echo hello world; sleep 1; done"

当利用 docker run 来创建容器时，Docker 在后台运行的标准操作包括：
（1）检查本地是否存在指定的镜像，不存在就从公有仓库下载
（2）利用镜像创建并启动一个容器
（3）分配一个文件系统，并在只读的镜像层外面挂载一层可读写层
（4）从宿主主机配置的网桥接口中桥接一个虚拟接口到容器中去
（5）从地址池配置一个 ip 地址给容器
（6）执行用户指定的应用程序
（7）执行完毕后容器被终止

#### 终止容器：

	docker stop [container-name]或docker kill [container-name]

前者会给容器内的进程发送SIGTERM信号，默认行为是容器退出，当然容器内的程序也可以捕获该信号后自行处理。而后者会给容器内的进程发送SIGKILL信号，导致容器直接退出。

#### 停止后的容器重新启动：

	docker start [container-name]

#### 正在运行的容器：

	docker ps

#### 查看所有容器：

	docker ps -a （-l和-n=x能列出最后创建的一个或x个容器）

#### 查看容器内标准输出流中的内容：

	docker logs [container-name]

#### 动态查看容器日志：

	docker logs -f [container-name]

#### 查看容器中的所有进程:

	docker top [container-name]

#### 容器运行之后中途启动另一个程序:

	docker exec

#### 查看一下容器的详细信息:

	docker inspect [container-name]

#### 进入容器：

	docker attach [container-name]

#### 进入容器：

	docker exec -it [container-name] bash

#### 查看容器重启次数：

	docker inspect -f "{{ .RestartCount }}" bba-208

#### 查看容器最后一次的启动时间：

	docker inspect -f "{{ .State.StartedAt }}" bba-208

docker run的退出状态码如下：

	0，表示正常退出
	非0，表示异常退出（退出状态码采用chroot标准）
	125，Docker守护进程本身的错误
	126，容器启动后，要执行的默认命令无法调用
	127，容器启动后，要执行的默认命令不存在
	其他命令状态码，容器启动后正常执行命令，退出命令时该命令的返回状态码作为容器的退出状态码

#### 看容器的端口映射情况:

	docker port con_id

#### 退出容器：

	# 方法一
	exit
	# 方法二
	ctrl+p && ctrl+q (一起按，注意顺序，退出后容器依然保持启动状态)

#### 删除容器：

	docker rm [container-name]

#### 文件上传和下载：

	docker cp /root/test.txt ecef8319d2c8:/root/
	docker cp ecef8319d2c8:/root/test.txt /root/

#### 从公网拉取一个镜像：

	docker pull images_name

#### 查看已有的docker镜像：

	docker images

#### 查看帮助：

	docker command --help

#### 查看镜像列表:

	docker search nginx
	docker pull [OPTIONS] NAME[:TAG|@DIGEST]
	tag去hub.docker.com查
	如docker pull mysql:5.7

#### 导出镜像:

	docker save -o image_name.tar image_name

#### 加载一个tar包格式的镜像:

	docker load -i image_name.tar

#### 另存为镜像：

	docker commit -m 'bz' -a 'zhouxuan' ffe81683c404  imagename

	-m 来指定提交的说明信息，跟我们使用的版本控制工具一样；
	-a 可以指定更新的用户信息；之后是用来创建镜像的容器的ID；
	最后指定目标镜像的仓库名和 tag 信息。创建成功后会返回这个镜像的 ID 信息。

#### 删除镜像:

	docker rmi image_name

#### docker修改镜像名：

	docker tag imageid name:tag

#### 进入docker容器脚本：

	[root@docker ~]# cat nsenter.sh
	PID=`docker inspect --format "{{.State.Pid}}" $1`
	nsenter -t $PID -u --mount -i -n -p

##### 运行dockerfile并给dockerfile创建的镜像建立名字

	:docker build -t mysql:3.6.34 `pwd`
	mariadb容器启动前需先设置密码方法:docker run -d -P -e MYSQL_ROOT_PASSWORD=password  img_id

%23%23%23%23%20%E6%9F%A5%E7%9C%8Bdocker%E4%BF%A1%E6%81%AF%EF%BC%9A%0A%60%60%60%0Adocker%20info%0A%60%60%60%0A%23%23%23%23%20%E6%9F%A5%E7%9C%8Bdocker%E7%BD%91%E7%BB%9C%3A%0A%60%60%60%0Adocker%20network%20ls%0A%60%60%60%0A%23%23%23%20%E5%88%9B%E5%BB%BA%E4%B8%80%E4%B8%AAdocker%E7%BD%91%E7%BB%9Cmy-docker%3A%0A%60%60%60%0Adocker%20network%20create%20--subnet%3D192.168.0.0%2F24%20--gateway%3D192.168.0.1%20--ip-range%3D192.168.0.0%2F24%20mynetwork%0A%60%60%60%0A%23%23%23%23%204%E7%A7%8D%E7%BD%91%E7%BB%9C%E6%96%B9%E5%BC%8F%EF%BC%9A%0A*%20host%EF%BC%9Adocker%20run%20%E4%BD%BF%E7%94%A8%20--net%3Dhost%E6%8C%87%E5%AE%9A%EF%BC%8Cocker%E4%BD%BF%E7%94%A8%E7%9A%84%E7%BD%91%E7%BB%9C%E5%AE%9E%E9%99%85%E4%B8%8A%E5%92%8C%E5%AE%BF%E4%B8%BB%E6%9C%BA%E4%B8%80%E6%A0%B7%0A*%20container%EF%BC%9A%E4%BD%BF%E7%94%A8%20--net%3Dcontainer%3Acontainer_id%2Fcontainer_name%20%E5%A4%9A%E4%B8%AA%E5%AE%B9%E5%99%A8%E4%BD%BF%E7%94%A8%E5%85%B1%E5%90%8C%E7%9A%84%E7%BD%91%E7%BB%9C%EF%BC%8C%E7%9C%8B%E5%88%B0%E7%9A%84ip%E6%98%AF%E4%B8%80%E6%A0%B7%E7%9A%84%E3%80%82%0A*%20none%3A%E4%BD%BF%E7%94%A8%20--net%3Dnone%E6%8C%87%E5%AE%9A%20%20%E8%BF%99%E7%A7%8D%E6%A8%A1%E5%BC%8F%E4%B8%8B%EF%BC%8C%E4%B8%8D%E4%BC%9A%E9%85%8D%E7%BD%AE%E4%BB%BB%E4%BD%95%E7%BD%91%E7%BB%9C%E3%80%82%0A*%20bridge%EF%BC%9A%E4%BD%BF%E7%94%A8%20--net%3Dbridge%E6%8C%87%E5%AE%9A%EF%BC%8C%20%E9%BB%98%E8%AE%A4%E6%A8%A1%E5%BC%8F%EF%BC%8C%E4%B8%8D%E4%BC%9A%E6%8C%87%E5%AE%9A%EF%BC%8C%20%E6%AD%A4%E6%A8%A1%E5%BC%8F%E4%BC%9A%E4%B8%BA%E6%AF%8F%E4%B8%AA%E5%AE%B9%E5%99%A8%E5%88%86%E9%85%8D%E4%B8%80%E4%B8%AA%E7%8B%AC%E7%AB%8B%E7%9A%84network%20namespace%0A*%20%0A%23%23%23%23%20%E5%88%9B%E5%BB%BA%E5%AE%B9%E5%99%A8%EF%BC%9A%0A%60%60%60%0Adocker%20create%0A%60%60%60%0A%23%23%23%23%20%E8%BF%90%E8%A1%8C%E5%AE%B9%E5%99%A8%EF%BC%9A%0A%60%60%60%0Adocker%20run%20%5BOPTIONS%5D%20IMAGE%5B%3ATAG%5D%20%5BCOMMAND%5D%20%5BARG...%5D%0A%60%60%60%0A%60%60%60%0A%09docker%20run%20-t%20-i%20-m%20200M%20--memory-swap%3D300M%20--name%3Dcon_name%20%5B%E9%95%9C%E5%83%8F%E7%9A%84REPOSITORY%5D%20%2Fbin%2Fbash%0A%60%60%60%0A%60%60%60%0A%09docker%20run%20-d%20-p%2080%3A80%20image_name%0A%60%60%60%0A%60%60%60%0A%09docker%20run%20--network%3Dmy-docker%20--ip%3D192.168.0.5%20-itd%20--name%3Dcon_name%20-h%20lb01%20image_name%0A%60%60%60%0A%60%60%60%0A%09docker%20run%20-i%20-t%20-v%20%2Froot%2Fsoftware%2F%3A%2Fmnt%2Fsoftware%2F%2083ee%20%2Fbin%2Fbash%0A%60%60%60%0A%60%60%60%0A%09docker%20run%20-d%20--name%20server001-mysql1%20-p%201001%3A22%20-p%202001%3A3306%20mycontos1.01%20%2Fstart.sh%0A%60%60%60%0A%60%60%60%0A%09docker%20run%20-d%20--restart%3Dalways%20bba-208%0A%60%60%60%0A%60%60%60%0A%09docker%20run%20-d%20%0A%20%20%20%20--name%20fsTomcat%20%0A%20%20%20%20--restart%20always%20%0A%20%20%20%20-p%2080%3A8080%20%0A%20%20%20%20-v%20%0A%2Ffile%2Fserver%2Ftomcat%2FfileStorageServer%2Fserver.xml%3A%2Fusr%2Flocal%2Ftomcat%2Fconf%2Fserver.xml%20%0A-v%20%2Ffile%2Fserver%2Ftomcat%2FfileStorageServer%2FROOT%3A%2Ffile%2Fserver%2Ftomcat%2FfileStorageServer%2FROOT%20%0A-v%20%2Ffile%2Fserver%2Ftomcat%2FfileStorageServer%2FfileStorage%3A%2Ffile%2Fserver%2Ftomcat%2FfileStorage%0A-v%20%2Ffile%2Fserver%2Ftomcat%2FfileStorageServer%2Flogs%3A%2Fusr%2Flocal%2Ftomcat%2Flogs%20%0A-v%20%2Ffile%2Fserver%2Ftomcat%2FfileStorageServer%2Flogs%3A%2Fjava_logs%20tomcat%0A%60%60%60%0A%60%60%60%0A%09%5BOPTIONS%20start%5D%20%0A%09-t%20%E9%80%89%E9%A1%B9%E8%AE%A9Docker%E5%88%86%E9%85%8D%E4%B8%80%E4%B8%AA%E4%BC%AA%E7%BB%88%E7%AB%AF%EF%BC%88pseudo-tty%EF%BC%89%E5%B9%B6%E7%BB%91%E5%AE%9A%E5%88%B0%E5%AE%B9%E5%99%A8%E7%9A%84%E6%A0%87%E5%87%86%E8%BE%93%E5%85%A5%E4%B8%8A%0A%09-i%20%E5%88%99%E8%AE%A9%E5%AE%B9%E5%99%A8%E7%9A%84%E6%A0%87%E5%87%86%E8%BE%93%E5%85%A5%E4%BF%9D%E6%8C%81%E6%89%93%E5%BC%80%E3%80%82%0A%09-m%E6%88%96--memory%EF%BC%9A%E8%AE%BE%E7%BD%AE%E5%86%85%E5%AD%98%E7%9A%84%E4%BD%BF%E7%94%A8%E9%99%90%E9%A2%9D%EF%BC%8C%E4%BE%8B%E5%A6%82%20100M%2C%202G%E3%80%82%E9%BB%98%E8%AE%A4%E6%B2%A1%E6%9C%89%E9%99%90%E5%88%B6%0A%09--memory-swap%EF%BC%9A%E8%AE%BE%E7%BD%AE%E5%86%85%E5%AD%98%2Bswap%E7%9A%84%E4%BD%BF%E7%94%A8%E9%99%90%E9%A2%9D%E3%80%82%E9%BB%98%E8%AE%A4%E6%B2%A1%E6%9C%89%E9%99%90%E5%88%B6%0A%09--name%20%E5%AE%B9%E5%99%A8%E5%90%8D%0A%09%20-d%20%E5%90%8E%E5%8F%B0%E8%BF%90%E8%A1%8C%0A%09%20-p%20%E5%8F%82%E6%95%B0%E8%AF%B4%E6%98%8E%0A%09%09-p%20hostPort%3AcontainerPort%0A%09%09-p%20ip%3AhostPort%3AcontainerPort%0A%09%09-p%20ip%3A%3AcontainerPort%0A%09%09-p%20hostPort%3AcontainerPort%3Audp%0A%09--network%20%20%20%23%E6%8C%87%E5%AE%9A%E5%AE%B9%E5%99%A8%E7%BD%91%E7%BB%9C%0A%09--ip%20%20%20%20%20%20%20%20%23%E8%AE%BE%E5%AE%9A%E5%AE%B9%E5%99%A8ip%E5%9C%B0%E5%9D%80%0A%09-h%20%20%20%20%20%20%20%20%20%20%23%E7%BB%99%E5%AE%B9%E5%99%A8%E8%AE%BE%E7%BD%AE%E4%B8%BB%E6%9C%BA%E5%90%8D%0A%09-v%EF%BC%9A%E8%A1%A8%E7%A4%BA%E9%9C%80%E8%A6%81%E5%B0%86%E6%9C%AC%E5%9C%B0%E5%93%AA%E4%B8%AA%E7%9B%AE%E5%BD%95%E6%8C%82%E8%BD%BD%E5%88%B0%E5%AE%B9%E5%99%A8%E4%B8%AD%EF%BC%8C%E6%A0%BC%E5%BC%8F%EF%BC%9A-v%20%3C%E5%AE%BF%E4%B8%BB%E6%9C%BA%E7%9B%AE%E5%BD%95%3E%3A%3C%E5%AE%B9%E5%99%A8%E7%9B%AE%E5%BD%95%3E%0A%09-e%20%E8%AE%BE%E7%BD%AE%E5%AE%B9%E5%99%A8%E8%BF%90%E8%A1%8C%E6%89%80%E9%9C%80%E8%A6%81%E7%9A%84%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F%0A%09--restart%0A%09%09no%EF%BC%8C%E9%BB%98%E8%AE%A4%E7%AD%96%E7%95%A5%EF%BC%8C%E5%9C%A8%E5%AE%B9%E5%99%A8%E9%80%80%E5%87%BA%E6%97%B6%E4%B8%8D%E9%87%8D%E5%90%AF%E5%AE%B9%E5%99%A8%0A%09%09on-failure%EF%BC%8C%E5%9C%A8%E5%AE%B9%E5%99%A8%E9%9D%9E%E6%AD%A3%E5%B8%B8%E9%80%80%E5%87%BA%E6%97%B6%EF%BC%88%E9%80%80%E5%87%BA%E7%8A%B6%E6%80%81%E9%9D%9E0%EF%BC%89%EF%BC%8C%E6%89%8D%E4%BC%9A%E9%87%8D%E5%90%AF%E5%AE%B9%E5%99%A8%0A%09%09on-failure%3A3%EF%BC%8C%E5%9C%A8%E5%AE%B9%E5%99%A8%E9%9D%9E%E6%AD%A3%E5%B8%B8%E9%80%80%E5%87%BA%E6%97%B6%E9%87%8D%E5%90%AF%E5%AE%B9%E5%99%A8%EF%BC%8C%E6%9C%80%E5%A4%9A%E9%87%8D%E5%90%AF3%E6%AC%A1%0A%09%09always%EF%BC%8C%E5%9C%A8%E5%AE%B9%E5%99%A8%E9%80%80%E5%87%BA%E6%97%B6%E6%80%BB%E6%98%AF%E9%87%8D%E5%90%AF%E5%AE%B9%E5%99%A8%0A%09%09unless-stopped%EF%BC%8C%E5%9C%A8%E5%AE%B9%E5%99%A8%E9%80%80%E5%87%BA%E6%97%B6%E6%80%BB%E6%98%AF%E9%87%8D%E5%90%AF%E5%AE%B9%E5%99%A8%EF%BC%8C%E4%BD%86%E6%98%AF%E4%B8%8D%E8%80%83%E8%99%91%E5%9C%A8Docker%E5%AE%88%E6%8A%A4%E8%BF%9B%E7%A8%8B%E5%90%AF%E5%8A%A8%E6%97%B6%E5%B0%B1%E5%B7%B2%E7%BB%8F%E5%81%9C%E6%AD%A2%E4%BA%86%E7%9A%84%E5%AE%B9%E5%99%A8%0A%09%5BOPTIONS%20end%5D%20%0A%60%60%60%0A%0A%23%23%23%23%20%E5%90%8E%E9%9D%A2%E7%9A%84%E6%89%A7%E8%A1%8C%E7%9B%B8%E5%BA%94SH%E8%84%9A%E6%9C%AC%5BCOMMAND%5D%0A%60%60%60%0A%2Fusr%2Fsbin%2Fsshd%20-D%20%20%E8%A1%A8%E7%A4%BA%E5%90%AF%E5%8A%A8ssh%E6%9C%8D%E5%8A%A1%20%E8%A1%A8%E7%A4%BA%E5%AE%B9%E5%99%A8%E9%95%BF%E6%97%B6%E9%97%B4%E8%BF%90%E8%A1%8C%EF%BC%8C%E4%B8%8D%E8%87%B3%E4%BA%8E%E5%87%A0%E7%A7%92%E5%90%8E%E9%80%80%E5%87%BA%0A%60%60%60%0A%09%0A%23%23%23%23%20%E5%90%AF%E5%8A%A8%E5%AE%B9%E5%99%A8%EF%BC%88%E5%90%8E%E5%8F%B0%E6%A8%A1%E5%BC%8F%EF%BC%89%EF%BC%9A%0A%60%60%60%0Adocker%20run%20-d%20ubuntu%3A15.10%20%2Fbin%2Fsh%20-c%20%22while%20true%3B%20do%20echo%20hello%20world%3B%20sleep%201%3B%20done%22%0A%60%60%60%0A%E5%BD%93%E5%88%A9%E7%94%A8%20docker%20run%20%E6%9D%A5%E5%88%9B%E5%BB%BA%E5%AE%B9%E5%99%A8%E6%97%B6%EF%BC%8CDocker%20%E5%9C%A8%E5%90%8E%E5%8F%B0%E8%BF%90%E8%A1%8C%E7%9A%84%E6%A0%87%E5%87%86%E6%93%8D%E4%BD%9C%E5%8C%85%E6%8B%AC%EF%BC%9A%20%0A%EF%BC%881%EF%BC%89%E6%A3%80%E6%9F%A5%E6%9C%AC%E5%9C%B0%E6%98%AF%E5%90%A6%E5%AD%98%E5%9C%A8%E6%8C%87%E5%AE%9A%E7%9A%84%E9%95%9C%E5%83%8F%EF%BC%8C%E4%B8%8D%E5%AD%98%E5%9C%A8%E5%B0%B1%E4%BB%8E%E5%85%AC%E6%9C%89%E4%BB%93%E5%BA%93%E4%B8%8B%E8%BD%BD%20%0A%EF%BC%882%EF%BC%89%E5%88%A9%E7%94%A8%E9%95%9C%E5%83%8F%E5%88%9B%E5%BB%BA%E5%B9%B6%E5%90%AF%E5%8A%A8%E4%B8%80%E4%B8%AA%E5%AE%B9%E5%99%A8%20%0A%EF%BC%883%EF%BC%89%E5%88%86%E9%85%8D%E4%B8%80%E4%B8%AA%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F%EF%BC%8C%E5%B9%B6%E5%9C%A8%E5%8F%AA%E8%AF%BB%E7%9A%84%E9%95%9C%E5%83%8F%E5%B1%82%E5%A4%96%E9%9D%A2%E6%8C%82%E8%BD%BD%E4%B8%80%E5%B1%82%E5%8F%AF%E8%AF%BB%E5%86%99%E5%B1%82%20%0A%EF%BC%884%EF%BC%89%E4%BB%8E%E5%AE%BF%E4%B8%BB%E4%B8%BB%E6%9C%BA%E9%85%8D%E7%BD%AE%E7%9A%84%E7%BD%91%E6%A1%A5%E6%8E%A5%E5%8F%A3%E4%B8%AD%E6%A1%A5%E6%8E%A5%E4%B8%80%E4%B8%AA%E8%99%9A%E6%8B%9F%E6%8E%A5%E5%8F%A3%E5%88%B0%E5%AE%B9%E5%99%A8%E4%B8%AD%E5%8E%BB%20%0A%EF%BC%885%EF%BC%89%E4%BB%8E%E5%9C%B0%E5%9D%80%E6%B1%A0%E9%85%8D%E7%BD%AE%E4%B8%80%E4%B8%AA%20ip%20%E5%9C%B0%E5%9D%80%E7%BB%99%E5%AE%B9%E5%99%A8%20%0A%EF%BC%886%EF%BC%89%E6%89%A7%E8%A1%8C%E7%94%A8%E6%88%B7%E6%8C%87%E5%AE%9A%E7%9A%84%E5%BA%94%E7%94%A8%E7%A8%8B%E5%BA%8F%20%0A%EF%BC%887%EF%BC%89%E6%89%A7%E8%A1%8C%E5%AE%8C%E6%AF%95%E5%90%8E%E5%AE%B9%E5%99%A8%E8%A2%AB%E7%BB%88%E6%AD%A2%0A%0A%23%23%23%23%20%E7%BB%88%E6%AD%A2%E5%AE%B9%E5%99%A8%EF%BC%9A%0A%60%60%60%0Adocker%20stop%20%5Bcontainer-name%5D%E6%88%96docker%20kill%20%5Bcontainer-name%5D%0A%60%60%60%0A%E5%89%8D%E8%80%85%E4%BC%9A%E7%BB%99%E5%AE%B9%E5%99%A8%E5%86%85%E7%9A%84%E8%BF%9B%E7%A8%8B%E5%8F%91%E9%80%81SIGTERM%E4%BF%A1%E5%8F%B7%EF%BC%8C%E9%BB%98%E8%AE%A4%E8%A1%8C%E4%B8%BA%E6%98%AF%E5%AE%B9%E5%99%A8%E9%80%80%E5%87%BA%EF%BC%8C%E5%BD%93%E7%84%B6%E5%AE%B9%E5%99%A8%E5%86%85%E7%9A%84%E7%A8%8B%E5%BA%8F%E4%B9%9F%E5%8F%AF%E4%BB%A5%E6%8D%95%E8%8E%B7%E8%AF%A5%E4%BF%A1%E5%8F%B7%E5%90%8E%E8%87%AA%E8%A1%8C%E5%A4%84%E7%90%86%E3%80%82%E8%80%8C%E5%90%8E%E8%80%85%E4%BC%9A%E7%BB%99%E5%AE%B9%E5%99%A8%E5%86%85%E7%9A%84%E8%BF%9B%E7%A8%8B%E5%8F%91%E9%80%81SIGKILL%E4%BF%A1%E5%8F%B7%EF%BC%8C%E5%AF%BC%E8%87%B4%E5%AE%B9%E5%99%A8%E7%9B%B4%E6%8E%A5%E9%80%80%E5%87%BA%E3%80%82%0A%0A%23%23%23%23%20%E5%81%9C%E6%AD%A2%E5%90%8E%E7%9A%84%E5%AE%B9%E5%99%A8%E9%87%8D%E6%96%B0%E5%90%AF%E5%8A%A8%EF%BC%9A%0A%60%60%60%0Adocker%20start%20%5Bcontainer-name%5D%0A%60%60%60%0A%23%23%23%23%20%E6%AD%A3%E5%9C%A8%E8%BF%90%E8%A1%8C%E7%9A%84%E5%AE%B9%E5%99%A8%EF%BC%9A%0A%60%60%60%0Adocker%20ps%0A%60%60%60%0A%23%23%23%23%20%E6%9F%A5%E7%9C%8B%E6%89%80%E6%9C%89%E5%AE%B9%E5%99%A8%EF%BC%9A%0A%60%60%60%0Adocker%20ps%20-a%20%EF%BC%88-l%E5%92%8C-n%3Dx%E8%83%BD%E5%88%97%E5%87%BA%E6%9C%80%E5%90%8E%E5%88%9B%E5%BB%BA%E7%9A%84%E4%B8%80%E4%B8%AA%E6%88%96x%E4%B8%AA%E5%AE%B9%E5%99%A8%EF%BC%89%0A%60%60%60%60%0A%23%23%23%23%20%E6%9F%A5%E7%9C%8B%E5%AE%B9%E5%99%A8%E5%86%85%E6%A0%87%E5%87%86%E8%BE%93%E5%87%BA%E6%B5%81%E4%B8%AD%E7%9A%84%E5%86%85%E5%AE%B9%EF%BC%9A%0A%60%60%60%0Adocker%20logs%20%5Bcontainer-name%5D%0A%60%60%60%0A%23%23%23%23%20%E5%8A%A8%E6%80%81%E6%9F%A5%E7%9C%8B%E5%AE%B9%E5%99%A8%E6%97%A5%E5%BF%97%EF%BC%9A%0A%60%60%60%0Adocker%20logs%20-f%20%5Bcontainer-name%5D%0A%60%60%60%0A%23%23%23%23%20%E6%9F%A5%E7%9C%8B%E5%AE%B9%E5%99%A8%E4%B8%AD%E7%9A%84%E6%89%80%E6%9C%89%E8%BF%9B%E7%A8%8B%3A%0A%60%60%60%0Adocker%20top%20%5Bcontainer-name%5D%0A%60%60%60%0A%23%23%23%23%20%E5%AE%B9%E5%99%A8%E8%BF%90%E8%A1%8C%E4%B9%8B%E5%90%8E%E4%B8%AD%E9%80%94%E5%90%AF%E5%8A%A8%E5%8F%A6%E4%B8%80%E4%B8%AA%E7%A8%8B%E5%BA%8F%3A%0A%60%60%60%0Adocker%20exec%0A%60%60%60%0A%23%23%23%23%20%E6%9F%A5%E7%9C%8B%E4%B8%80%E4%B8%8B%E5%AE%B9%E5%99%A8%E7%9A%84%E8%AF%A6%E7%BB%86%E4%BF%A1%E6%81%AF%3A%0A%60%60%60%0Adocker%20inspect%20%5Bcontainer-name%5D%0A%60%60%60%0A%23%23%23%23%20%E8%BF%9B%E5%85%A5%E5%AE%B9%E5%99%A8%EF%BC%9A%0A%60%60%60%0Adocker%20attach%20%5Bcontainer-name%5D%0A%60%60%60%0A%23%23%23%23%20%E8%BF%9B%E5%85%A5%E5%AE%B9%E5%99%A8%EF%BC%9A%0A%60%60%60%0Adocker%20exec%20-it%20%5Bcontainer-name%5D%20bash%0A%60%60%60%0A%23%23%23%23%20%E6%9F%A5%E7%9C%8B%E5%AE%B9%E5%99%A8%E9%87%8D%E5%90%AF%E6%AC%A1%E6%95%B0%EF%BC%9A%0A%60%60%60%0Adocker%20inspect%20-f%20%22%7B%7B%20.RestartCount%20%7D%7D%22%20bba-208%0A%60%60%60%0A%23%23%23%23%20%E6%9F%A5%E7%9C%8B%E5%AE%B9%E5%99%A8%E6%9C%80%E5%90%8E%E4%B8%80%E6%AC%A1%E7%9A%84%E5%90%AF%E5%8A%A8%E6%97%B6%E9%97%B4%EF%BC%9A%0A%60%60%60%0Adocker%20inspect%20-f%20%22%7B%7B%20.State.StartedAt%20%7D%7D%22%20bba-208%0A%60%60%60%0A%0Adocker%20run%E7%9A%84%E9%80%80%E5%87%BA%E7%8A%B6%E6%80%81%E7%A0%81%E5%A6%82%E4%B8%8B%EF%BC%9A%0A%0A%090%EF%BC%8C%E8%A1%A8%E7%A4%BA%E6%AD%A3%E5%B8%B8%E9%80%80%E5%87%BA%0A%09%E9%9D%9E0%EF%BC%8C%E8%A1%A8%E7%A4%BA%E5%BC%82%E5%B8%B8%E9%80%80%E5%87%BA%EF%BC%88%E9%80%80%E5%87%BA%E7%8A%B6%E6%80%81%E7%A0%81%E9%87%87%E7%94%A8chroot%E6%A0%87%E5%87%86%EF%BC%89%0A%09125%EF%BC%8CDocker%E5%AE%88%E6%8A%A4%E8%BF%9B%E7%A8%8B%E6%9C%AC%E8%BA%AB%E7%9A%84%E9%94%99%E8%AF%AF%0A%09126%EF%BC%8C%E5%AE%B9%E5%99%A8%E5%90%AF%E5%8A%A8%E5%90%8E%EF%BC%8C%E8%A6%81%E6%89%A7%E8%A1%8C%E7%9A%84%E9%BB%98%E8%AE%A4%E5%91%BD%E4%BB%A4%E6%97%A0%E6%B3%95%E8%B0%83%E7%94%A8%0A%09127%EF%BC%8C%E5%AE%B9%E5%99%A8%E5%90%AF%E5%8A%A8%E5%90%8E%EF%BC%8C%E8%A6%81%E6%89%A7%E8%A1%8C%E7%9A%84%E9%BB%98%E8%AE%A4%E5%91%BD%E4%BB%A4%E4%B8%8D%E5%AD%98%E5%9C%A8%0A%09%E5%85%B6%E4%BB%96%E5%91%BD%E4%BB%A4%E7%8A%B6%E6%80%81%E7%A0%81%EF%BC%8C%E5%AE%B9%E5%99%A8%E5%90%AF%E5%8A%A8%E5%90%8E%E6%AD%A3%E5%B8%B8%E6%89%A7%E8%A1%8C%E5%91%BD%E4%BB%A4%EF%BC%8C%E9%80%80%E5%87%BA%E5%91%BD%E4%BB%A4%E6%97%B6%E8%AF%A5%E5%91%BD%E4%BB%A4%E7%9A%84%E8%BF%94%E5%9B%9E%E7%8A%B6%E6%80%81%E7%A0%81%E4%BD%9C%E4%B8%BA%E5%AE%B9%E5%99%A8%E7%9A%84%E9%80%80%E5%87%BA%E7%8A%B6%E6%80%81%E7%A0%81%0A%20%20%20%20%0A%23%23%23%23%20%E7%9C%8B%E5%AE%B9%E5%99%A8%E7%9A%84%E7%AB%AF%E5%8F%A3%E6%98%A0%E5%B0%84%E6%83%85%E5%86%B5%3A%0A%60%60%60%0Adocker%20port%20con_id%0A%60%60%60%0A%23%23%23%23%20%E9%80%80%E5%87%BA%E5%AE%B9%E5%99%A8%EF%BC%9A%0A%09%23%20%E6%96%B9%E6%B3%95%E4%B8%80%0A%09exit%0A%09%23%20%E6%96%B9%E6%B3%95%E4%BA%8C%0A%09ctrl%2Bp%20%26%26%20ctrl%2Bq%20(%E4%B8%80%E8%B5%B7%E6%8C%89%EF%BC%8C%E6%B3%A8%E6%84%8F%E9%A1%BA%E5%BA%8F%EF%BC%8C%E9%80%80%E5%87%BA%E5%90%8E%E5%AE%B9%E5%99%A8%E4%BE%9D%E7%84%B6%E4%BF%9D%E6%8C%81%E5%90%AF%E5%8A%A8%E7%8A%B6%E6%80%81)%0A%20%20%20%20%0A%23%23%23%23%20%E5%88%A0%E9%99%A4%E5%AE%B9%E5%99%A8%EF%BC%9A%0A%20%20%20%20docker%20rm%20%5Bcontainer-name%5D%0A%23%23%23%23%20%E6%96%87%E4%BB%B6%E4%B8%8A%E4%BC%A0%E5%92%8C%E4%B8%8B%E8%BD%BD%EF%BC%9A%0A%09docker%20cp%20%2Froot%2Ftest.txt%20ecef8319d2c8%3A%2Froot%2F%0A%09docker%20cp%20ecef8319d2c8%3A%2Froot%2Ftest.txt%20%2Froot%2F%0A%0A%23%23%23%23%20%E4%BB%8E%E5%85%AC%E7%BD%91%E6%8B%89%E5%8F%96%E4%B8%80%E4%B8%AA%E9%95%9C%E5%83%8F%EF%BC%9A%0A%20%20%20%20docker%20pull%20images_name%0A%23%23%23%23%20%E6%9F%A5%E7%9C%8B%E5%B7%B2%E6%9C%89%E7%9A%84docker%E9%95%9C%E5%83%8F%EF%BC%9A%0A%20%20%20%20docker%20images%0A%23%23%23%23%20%E6%9F%A5%E7%9C%8B%E5%B8%AE%E5%8A%A9%EF%BC%9A%0A%20%20%20%20docker%20command%20--help%0A%23%23%23%23%20%E6%9F%A5%E7%9C%8B%E9%95%9C%E5%83%8F%E5%88%97%E8%A1%A8%3A%0A%20%20%20%20docker%20search%20nginx%0A%09docker%20pull%20%5BOPTIONS%5D%20NAME%5B%3ATAG%7C%40DIGEST%5D%0A%09tag%E5%8E%BBhub.docker.com%E6%9F%A5%0A%09%E5%A6%82docker%20pull%20mysql%3A5.7%0A%23%23%23%23%20%E5%AF%BC%E5%87%BA%E9%95%9C%E5%83%8F%3A%0A%20%20%20%20docker%20save%20-o%20image_name.tar%20image_name%0A%23%23%23%23%20%E5%8A%A0%E8%BD%BD%E4%B8%80%E4%B8%AAtar%E5%8C%85%E6%A0%BC%E5%BC%8F%E7%9A%84%E9%95%9C%E5%83%8F%3A%0A%20%20%20%20docker%20load%20-i%20image_name.tar%20%20%0A%23%23%23%23%20%E5%8F%A6%E5%AD%98%E4%B8%BA%E9%95%9C%E5%83%8F%EF%BC%9A%0A%20%20%20%20docker%20commit%20-m%20'bz'%20-a%20'zhouxuan'%20ffe81683c404%20%20imagename%0A%20%20%20%20%0A%09-m%20%E6%9D%A5%E6%8C%87%E5%AE%9A%E6%8F%90%E4%BA%A4%E7%9A%84%E8%AF%B4%E6%98%8E%E4%BF%A1%E6%81%AF%EF%BC%8C%E8%B7%9F%E6%88%91%E4%BB%AC%E4%BD%BF%E7%94%A8%E7%9A%84%E7%89%88%E6%9C%AC%E6%8E%A7%E5%88%B6%E5%B7%A5%E5%85%B7%E4%B8%80%E6%A0%B7%EF%BC%9B%0A%09-a%20%E5%8F%AF%E4%BB%A5%E6%8C%87%E5%AE%9A%E6%9B%B4%E6%96%B0%E7%9A%84%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF%EF%BC%9B%E4%B9%8B%E5%90%8E%E6%98%AF%E7%94%A8%E6%9D%A5%E5%88%9B%E5%BB%BA%E9%95%9C%E5%83%8F%E7%9A%84%E5%AE%B9%E5%99%A8%E7%9A%84ID%EF%BC%9B%0A%09%E6%9C%80%E5%90%8E%E6%8C%87%E5%AE%9A%E7%9B%AE%E6%A0%87%E9%95%9C%E5%83%8F%E7%9A%84%E4%BB%93%E5%BA%93%E5%90%8D%E5%92%8C%20tag%20%E4%BF%A1%E6%81%AF%E3%80%82%E5%88%9B%E5%BB%BA%E6%88%90%E5%8A%9F%E5%90%8E%E4%BC%9A%E8%BF%94%E5%9B%9E%E8%BF%99%E4%B8%AA%E9%95%9C%E5%83%8F%E7%9A%84%20ID%20%E4%BF%A1%E6%81%AF%E3%80%82%0A%0A%23%23%23%23%20%E5%88%A0%E9%99%A4%E9%95%9C%E5%83%8F%3A%0A%20%20%20%20docker%20rmi%20image_name%0A%23%23%23%23%20docker%E4%BF%AE%E6%94%B9%E9%95%9C%E5%83%8F%E5%90%8D%EF%BC%9A%0A%20%20%20%20docker%20tag%20imageid%20name%3Atag%0A%23%23%23%23%20%E8%BF%9B%E5%85%A5docker%E5%AE%B9%E5%99%A8%E8%84%9A%E6%9C%AC%EF%BC%9A%0A%09%5Broot%40docker%20~%5D%23%20cat%20nsenter.sh%20%0A%09PID%3D%60docker%20inspect%20--format%20%22%7B%7B.State.Pid%7D%7D%22%20%241%60%0A%09nsenter%20-t%20%24PID%20-u%20--mount%20-i%20-n%20-p%0A%0A%23%23%23%23%23%20%E8%BF%90%E8%A1%8Cdockerfile%E5%B9%B6%E7%BB%99dockerfile%E5%88%9B%E5%BB%BA%E7%9A%84%E9%95%9C%E5%83%8F%E5%BB%BA%E7%AB%8B%E5%90%8D%E5%AD%97%0A%0A%20%20%20%20%3Adocker%20build%20-t%20mysql%3A3.6.34%20%60pwd%60%0A%20%20%20%20mariadb%E5%AE%B9%E5%99%A8%E5%90%AF%E5%8A%A8%E5%89%8D%E9%9C%80%E5%85%88%E8%AE%BE%E7%BD%AE%E5%AF%86%E7%A0%81%E6%96%B9%E6%B3%95%3Adocker%20run%20-d%20-P%20-e%20MYSQL_ROOT_PASSWORD%3Dpassword%20%20img_id