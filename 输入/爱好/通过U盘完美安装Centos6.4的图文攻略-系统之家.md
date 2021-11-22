通过U盘完美安装Centos6.4的图文攻略-系统之家

# 通过U盘完美安装Centos6.4的图文攻略

时间：2014-06-30 15:29 [http://www.xitongzhijia.net](http://www.xitongzhijia.net/) 作者：咕噜噜

想要安装Centos6.4,也许第一时间你会想到使用U盘作为载体，因为U盘的使用率比较高，且携带方便存储高效，是非常好的选择之一，今天小编就要为大家带来通过U盘装Centos6.4的详细图文攻略。

1、首先我们需要下载UltraISO( 软碟通)、Centos6.4镜像，安装好软件，插入U盘，打开UltraISO软件，找到Centos6.4安装镜像(如图操作)删除其他文件仅保留images、isolinux两文件夹和TRANS.TBL文件，仅有这三个文件即可。

![pic-1450679355264.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124141.png)
2、如图所示，选择“启动”按钮下的“写入硬盘镜像”。
![pic-1450679355271.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124150.png)

3、如图所示，默认选择了你插入的优盘，选择好写入方式和硬盘MBR(我选择的是USB-HDD+)，然后点击写入(在这之前需要备份好优盘里的重要数据，优盘有价，数据无价啊!务必谨慎!)。一分钟之后结束，退出之后，把Centos6.4的安装镜像拷贝到优盘里，至此Centos6.4的U盘启动盘设置完毕。

![pic-1450679355272.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124202.png)
4、U盘插入需要安装Centos6.4系统的电脑上开机，F12选择从优盘启动，接着就会进入系统的安装界面，即下图所示。
![pic-1450679355273.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124226.png)
5、选择语言和启动位置(这里选择Hard drive 因为系统在优盘上)选择优盘的盘符。我这里是/dev/sda4,接着会读取优盘上的数据会出现如下图示。
![pic-1450679355274.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124242.png)
6、确认安装的设备和数据。
![pic-1450679355275.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124249.png)
7、输入主机名和超级管理员密码(根用户密码)。
![pic-1450679355276.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124317.png)
8、选择安装类型(建议选择自定义安装)接着分区。
![pic-1450679355277.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124411.png)
9、分区时一定要注意，一定要把U盘的勾去掉，我的分区如下图所示，然后确认格式化。
![pic-1450679355278.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124419.png)

10、接着是最重要的步骤。引导程序的选择一定要选择硬盘为第一引导，不然默认是优盘启动(装完系统必须要插着优盘才能启动)，点开更改设备，在下拉“BIOS驱动顺序”里的第一BIOS驱动器处选择硬盘位第一启动。

![pic-1450679355280.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124431.png)
11、选择所需安装的系统类型。
![pic-1450679355282.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124459.png)
12、进入软件安装进度界面，安装完毕，选择重启。
![pic-1450679355283.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124506.png)
13、至此，可以取下U盘可以看见系统启动了，等待你的精心配置。
![pic-1450679355283.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102124511.png)

以上就是通过U盘完美安装Centos6.4的详细图文攻略，不管你是新手还是老手，只要完整的按照攻略一步一步操作下去，你也定能在电脑上完美安装出Centos6.4，在安装过程中，我们一定要选择BIOS驱动顺序为硬盘第一引导，不然会伴着U盘才能启动系统哦。安装完成之后就好好设置系统吧，感受一下新系统带来的新鲜感。

[markdownFile.md](../_resources/68ae95b7708309d540cf9875423b3161.bin)