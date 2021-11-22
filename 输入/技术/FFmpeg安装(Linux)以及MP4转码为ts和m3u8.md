FFmpeg安装(Linux)以及MP4转码为ts和m3u8

# FFmpeg安装(Linux)以及MP4转码为ts和m3u8

> 环境:CentOS/Linux
> FFmpeg官网：> [> http://www.ffmpeg.org](http://www.ffmpeg.org/)
> 操作软件: SSH Shell
> 由于MP4播放时加载慢,尝试将其转换为m3u8(ts)格式播放, 服务器是腾讯云购买的, 使用FFmpeg最好不过了,转换速度基本在50M/s

## FFmpeg 4.x安装

将安装到目录/usr/local/下, 并创建ffmpeg文件夹

	mkdir /usr/local/ffmpeg

进入下载资源管理文件夹:

	cd /usr/local/source

下载当前最新版本ffmpeg-4.0.2

	wget http://ffmpeg.org/releases/ffmpeg-4.0.2.tar.bz2

解压tar.bz2文件到当前文件夹:(`xxx.tar.gz格式通常使用 tar -xzvf` )

	tar jxvf ffmpeg-4.0.2.tar.bz2

设置ffmpeg文件夹权限可修改(如果需要的话):

	chmod -R 777 /tmp/bihu

移动解压后文件夹内的所有文件到指定安装目录下(也可以直接解压到该目录下):

	mv ffmpeg-4.0.2/* /usr/local/ffmpeg/

进入安装目录:

	cd /usr/local/ffmpeg/

接下来就是安装相关操作, ffmpeg的编译需要先安装yasm, 如果没有先安装,已安装跳下一步(任意目录下执行该命令):

	yum install yasm

#### 开始编译,安装:

(1)检查`环境变量`及`配置编译选项`

	./configure

(2)然后将[`源代码`]编译成[`二进制文件`]
(时间较长,耐心等待)

	make

安装到当前目录下:`将make编译出来的的文件安装到指定的位置`

	make install

如果没有报错的话:
查看版本:

	ffmpeg

返回:

	ffmpeg version 4.0.2 Copyright (c) 2000-2018 the FFmpeg developers
	  built with gcc 4.8.5 (GCC) 20150623 (Red Hat 4.8.5-28)
	  configuration:
	  libavutil      56. 14.100 / 56. 14.100
	  libavcodec     58. 18.100 / 58. 18.100
	  libavformat    58. 12.100 / 58. 12.100
	  libavdevice    58.  3.100 / 58.  3.100
	  libavfilter     7. 16.100 /  7. 16.100
	  libswscale      5.  1.100 /  5.  1.100
	  libswresample   3.  1.100 /  3.  1.100
	Hyper fast Audio and Video encoder
	usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...

	Use -h to get full help or, even better, run 'man ffmpeg'

## 视频转码

安装成功以后,下面体验一下如何做视频转码:

#### (1)将MP4转换为ts格式文件(单个ts)

转换命令格式:

	ffmpeg -y -i 待转换mp4文件路径 -vcodec copy -acodec copy -vbsf h264_mp4toannexb 目标ts文件

**比如**: 在/tmp/ 目录下的test.mp4文件, 转换成test.ts格式

	ffmpeg -y -i /tmp/test.mp4 -vcodec copy -acodec copy -vbsf h264_mp4toannexb /tm
	p/test.ts

如果是在当前目录下:

	ffmpeg -y -i test.mp4 -vcodec copy -acodec copy -vbsf h264_mp4toannexb test.ts

#### (2)将ts文件进行切割,转换为m3u8

转换命令格式:[1 待转换ts文件, 2 单个切片时长(0-60s), 3 目标ts切片文件]

	ffmpeg -i 待转换ts文件路径 -c copy -map 0 -f segment -segment_list 目标m3u8文件 -segment_time 单个切片时长 目标ts切片文件名称

#### 比如:

当前目录/tmp/test/下有一个test.ts文件, 一个video文件夹
> |tmp
> |--test
> |----test.ts
> |----video

#### 需求:

将转换好的m3u8文件存放到video文件夹下, 命名index.m3u8 ,
切片命名前缀nxb加长度四位数字形式:nxb-0001.ts ,nxb-0002.ts,nxb-0003.ts ...
单个切片时长2s

#### 操作步骤:

进入操作目录:/tmp/test/

	cd /tmp/test/

设置文件夹读写权限:

	chmod -R 777 video

转换:

	ffmpeg -i test.ts -c copy -map 0 -f segment -segment_list video/in
	dex.m3u8 -segment_time 2 video/nxb-%04d.ts

转换成功后目录:`直播播放xx/video/index.m3u8`
> |tmp
> |--test
> |----test.ts
> |----video
> |------nxb-0001.ts ,nxb-0002.ts,nxb-0003.ts ...
> |------index.m3u8