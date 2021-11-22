Manjaro Deepin安装使用分享

# Manjaro Deepin安装使用分享

[![v2-4ff1e504ef9973d73eb3b51f66b5d9f3_l.jpg](../_resources/27399d6bc62146bcece27c0a5122eab9.jpg)](https://www.zhihu.com/people/freeNestor)

[Mathews.it](https://www.zhihu.com/people/freeNestor)
系统工程师过去式

全球优秀的Linux发行版很多，根据[http://DistroWatch.com](http://link.zhihu.com/?target=http%3A//DistroWatch.com)最新统计，官网页面点击数排名如下图：

![v2-f76da9f4336b68926493024cf0d055bf_r.jpg](../_resources/7ea06bed89cc81347f25e5c8fda81887.jpg)

可以看到，Manjaro被关注的热度排名第一，其次是Mint。国产Deepin系统最近一个月的点击数排名在19。虽然国产Deepin系统排名不是很靠前，但是个人觉得Deepin的桌面系统做的非常不错，目前Deepin在DistroWatch上的评分是8.9，而Manjaro的评分是8.6。最新的Deepin系统不久刚刚发布，版本是15.7，其稳定性多多少少影响了评分，至少在15.7发布前我看到的评分高达9.7。

之前一直不敢尝试Arch Linux，是因为有别于其他基于Debian和ubuntu的发行版，最大的区别就是软件安装方式。但经过尝试，发现Manjaro的软件库非常丰富（包括官方的Repository及Arch User Repository，即AUR），安装也比较容易上手。Manjaro发布的版本大体有三类：正式版、社区版及开发版，截至本文发布时，其最新版本为17.1.12。因为本人喜欢Deepin的桌面系统，因此选择了社区版Manjaro Deepin。

接下来，给大家分享以下一些内容（**2018-11-13更新：安装后有一些设置优化，大家可参考我另外一篇文章**）：
1. 1 ". "下载安装
2. 2 ". "更新软件源
3. 3 ". "安装软件
4. 4 ". "如何安装deb包
5. 5 ". "诊断系统启动慢
6. 6 ". "安装Linux内核CPU优化版本
7. 7 ". "安装主题
8. 8 ". "输入法问题

## **一、下载安装**

1. 1 ". "下载Manjaro Deepin社区版：[https://manjaro.org/community-editions/...](http://link.zhihu.com/?target=https%3A//manjaro.org/community-editions/)，选择minimal ISO：[https://osdn.net/projects/manjaro-community/storage/deepin/17.1.12/minimal/...](http://link.zhihu.com/?target=https%3A//osdn.net/projects/manjaro-community/storage/deepin/17.1.12/minimal/)，minimal ISO文件比常规的要小，可以节省下载时间，但是需要手动安装一些软件。

2. 2 ". "制作U盘启动盘，如果当前系统是Linux系统，可以使用类似imagewriter的工具将ISO文件写入U盘。如果在VirtualBox虚拟机中安装，则无需制作U盘启动盘，下面安装过程均在虚拟机中完成。

3. 3 ". "启动安装界面如下图，可以使用键盘方向键上下移动，回车表示进入选项。一般时区设置为Asia/Shanghai，语言可以选择zh_CN，driver选择nonfree。移动到Boot选项可以按键盘e键修改启动参数，修改完按F10启动。

![v2-e7847394296e29bbae0827a1f7a1917e_r.jpg](../_resources/705d0cb342863727bf4ba58a53abf007.jpg)

系统引导启动中.....

![v2-5d09ac8fae5d9e69b2d6cd97b4b54bad_r.jpg](../_resources/36be087b516460830cec1bb98ca023aa.jpg)

系统启动完成后，桌面出现欢迎界面，以及Deepin Dock，如下图：

![v2-475fd6fbb1c69cb1e87ccacde4e21ea2_r.jpg](../_resources/7e9b64dee62690669808bbf4463d4bbe.jpg)

双击桌面Install Manjaro Linux进入系统安装，或者点击欢迎界面上的Lanuch installer：

![v2-d3a0397f6b64524ad10c3098c690fe9b_r.jpg](../_resources/e2de5dcd7bfe567e631a713395a325ad.jpg)

选择语言，默认American English，点击Next

![v2-bb03b354f66fad16289e0f324547a9f1_r.jpg](../_resources/13d48577ae7fbbb9b86fd68c7e1dc5fa.jpg)

时区选择Asia、Shanghai（可以在地图中直接点击选择），点击Next下一步

![v2-3535aa813947d1e6da6264ae817b0055_r.jpg](../_resources/84ed6397c7c732a8a9e15318c54ec145.jpg)

键盘保持默认，点Next下一步

![v2-d689889e359b4755bfe0240b7093ea5c_r.jpg](../_resources/ad7e0dca64e1a8bda260a69eedfd6ce7.jpg)

选择BIOS安装的位置，如果你是EFI启动模式，则红框处显示为EFI，**注意选择你的BIOS或EFI安装位置（磁盘）**，选择Manual partitioning，手动分区比较灵活。

![v2-e05697d5db930b77c037368b2ab7c650_r.jpg](../_resources/a700a7946907b9b11f3d89760a06b346.jpg)

**注意红框处，选择安装的磁盘（千万别选错，否则可能导致你的个人数据丢失）**，如果磁盘从未使用过，则不会列出分区情况，这时要点击下方红框处的New Partition Table建立分区表，有两种选项：MBR或GPT，默认MBR。我选择的是GPT。点击OK后就会出现Free Space，选中Free Space点击下方Create创建分区。

![v2-5038fad5afed8c72982bcb8182059173_r.jpg](../_resources/a862f7b13266fc46b5127048ea8d97ac.jpg)

如果你是uefi启动，需要一个/boot/efi分区，如下图所示，150MB绝对够用了，文件系统类型选fat32，标识里勾选boot和esp。

![v2-7d45c237b3b3607fec3088f878aad50e_r.jpg](../_resources/dbbf555719c8de22394973dc9be55b7d.jpg)

由于演示的安装为虚拟机，因此仅两个分区：根分区和/home分区，点击Next下一步

![v2-874eedf43097c0561f65c16b2007f57d_r.jpg](../_resources/5cef81cde6e7c09ecd45680dcce10d98.jpg)

接下来填写用户名和密码，注意红框处，建议勾上，表示sudo权限的密码与普通用户密码一致，否则需要单独设置root密码，如下图。

最后点击Next会出现安装概览，再点击Install则开始安装，下图为安装进度。

安装完成后，会重新启动。注意，启动时你的启动菜单已经变成grub启动，若是双系统，默认从Manjaro启动。
启动问题：

如果启动到grub后，一直处于loading initrid状态，则可以尝试在启动到grub菜单时，修改Linux启动参数，在Linux 一行后面添加“noapic noapm nodma nomce nolapic nosmp nosplash”尝试启动，并观察启动过程中的一些日志报错，有助于排错。如果加入参数后能启动到桌面，可以再一个一个减少参数启动，最终可以定位到是哪个参数的原因。

Manjaro Deepin启动到桌面截图，与Deepin系统桌面无差异。

## **二、更新软件源**

系统启动后，会进行一次更新检查，默认从官方的源进行检查，我们可以更改软件源的区域设置，设置为中国，提高网络访问软件源的速度。
1. 1 ". "首先点击dock上的Lanucher，点击Add/Remove Software，如图红框所示：

打开后，点击上方设置图标并点击Preferences，如下图红框所示：

输入管理员密码后，在弹出的对话框里，切换到Official Repositories，选择China并点击Refresh Mirrors List

切换到AUR，打开AUR，这样可以使用社区用户软件源发布的软件，如下图

当然上面切换Official Repositories的方法可以用命令行完成：

	sudo pacman-mirrors -m rank -c China
	sudo pacman -Syyu #升级系统

我的已经是最新的系统，没有可更新的。

## **三、安装软件**

Manjaro的软件源包含的软件非常丰富，安装也非常简单，官方源里无法找到软件，也可以在AUR里搜索。比如要安装shutter截屏工具。
1. 1 ". "在Add/Remove Software里搜索shutter，没有找到？

没关系，在AUR里看看

勾选你要安装的软件，点击Apply准备安装，安装过程需要admin权限

弹出软件依赖关系和即将安装的软件列表，点击Commit开始安装

点击Details可以查看详细的安装过程

- • 安装yaourt工具，该工具支持在命令行安装AUR中的软件，后面将讲到该工具。**2018-11-09更新：因yaourt已经停止维护，大家都推荐yay工具，如果系统没有安装yay，可以手动安装。**
- • **安装yay**

	sudo pacman -S go        #yay依赖go，因为yay是用go写的
	cd 到一个合适的目录
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg                       #开始build，完成后生成package文件
	sudo pacman -U ./yay-8.1173.0-1-x86_64.pkg.tar.xz      #安装上一步生成的yay package文件

命令行安装和搜索软件：
sudo pacman -Ss <关键字>	#搜索含有关键字的软件
sudo pacman -S <软件名>	#安装软件

## **四、如何安装deb包**

有些软件可能真的找不到，或者你喜欢基于Debian的软件包，能否安装到Arch Linux上呢？答案是：可以。
1. 1 ". "首先通过pacman或图形界面安装软件debtap

下载你需要的deb软件包，比如我想安装xdemineur_2.1.1-19_amd64.deb扫雷游戏
1. 1 ". "对deb包进行转化，首次执行debtap需要增加-u参数更新debtap库

	sudo debtap xdemineur_2.1.1-19_amd64.deb -u

过程中会下载一些软件包，注意保持良好的网络，否则如图中所示一些软件包下载失败，当然可以多尝试几次

debtap命令成功后，会生成转化后的包（tar.xz），比如	xdemineur-2.1.1-1-x86_64.pkg.tar.xz，有了这个包就可以在Manjaro上安装了

1. 1 ". "安装转化后的包

	sudo pacman -U xdemineur-2.1.1-1-x86_64.pkg.tar.xz

## **五、诊断系统启动慢**

在安装好需要的软件后，每次启动系统几乎都需要接近2分钟的时间，百思不得其解。为了了解系统启动过程慢在哪里，Linux系统提供了systemd-analyze命令用于诊断系统启动时间，图为笔者笔记本启动时间，目前用时接近25s，相比之前2分钟已经提升很大。提升的办法见第六节。

systemd-analyze blame	#按时间排序，查看服务启动耗费时间

systemd-analyze critical-chain updatedb.service	#查看关联性服务启动耗费时间

sudo systemctl list-unit-files --state=enabled	#查看已经启用的服务

建议：对于一些不必要的服务，可以选择关闭随机启动。
关闭服务命令：
sudo systemctl disable xxxx.service	#关闭服务自启动

sudo systemctl mask xxxx.service	#将服务启动文件重定向到/dev/null，一般用于static类型的服务，该条命令谨慎使用，除非你确认其相关的服务真的都不需要启动

## **六、安装Linux内核CPU优化版本**

为了解决系统启动慢的问题，我选择了linux-ck，这是一个可以运行定制内核和头文件的包，安装过程包含一个编译过程，时间比较长，笔者笔记本大约耗费3个多小时才编译安装完成，且**注意AUR配置的build临时目录是否空间够大（默认是/tmp）**。这个目录可以设置，如图所示。

选择Linux-ck包安装，可以根据特定的CPU进行优化编译，目前linux-ck最新版本是4.18.5，**注意：linux-ck是定制编译内核，相关的网卡驱动和显卡驱动有对应的ck版本，因此决定用此内核的要先看下是否有对应的ck版本的驱动，否则可能导致无法联网和显示。不过毕竟是4.xx的kernel，如果能找到可加载的驱动，也不一定要对应的ck驱动。**

**2018-11-7更新：如果你的显卡是nvidia显卡，也有对应的ck版本，如nvidia-390xx-ck，nvidia-ck，nvidia-340xx-ck，大家可以在**[AUR (en) - Home](http://link.zhihu.com/?target=https%3A//aur.archlinux.org/)**里搜索相应的包，并查看它的依赖关系。安装方法也比较简单，建议网卡、显卡驱动在linux-ck和linux-ck-headers安装成功后再安装。**

**2018-11-8更新：linux-ck的更新频率与对应kernel的更新频率基本一致，截止本文更新时已经到4.18.17了。大家可以上[http://www.kernel.org](http://link.zhihu.com/?target=http%3A//www.kernel.org)去查看最新的kernel更新的日志，具体修复了什么。如果觉得某些修复很重要，就同步更新linux-ck。如果觉得没必要，可以不用更新，毕竟kernel更新频率有点频繁，我们也没必要频繁更新linux-ck。**

下面分享具体安装过程，必须命令行方式安装，图形界面安装会遇到GPG报错，无法跳过。
1. 1 ". "确保已经安装了yaourt工具，并打开了AUR
2. 2 ". "编译安装Linux-ck

	yaourt --m-arg --skipchecksums --m-arg --skippgpcheck -S linux-ck

注意，该命令不需要sudo权限，两个skip参数表示跳过gpg和校验和检查。如下图，回车后，开始运行，红色警告可以忽略。

上一步询问是否编辑PKGBUILD，我们输入n，继续

询问是否继续编译linux-ck，输入y继续，程序开始下载所需包和补丁，这一步时间根据网络情况而定。注意，一旦某个包因网络失败，只能从头开始。**2018-11-09更新：这里有一个技巧，如果下载出错，超时后会让你选择是否重新开始，这个时候，我们先不用着急开始或退出（着急开始的话，多半还是下载失败）。另外打开一个Terminal，进入编译目录（一般在你设置的build目录下的yaourt-tmp-用户名 目录下）找到PKGBUILD文件，打开这个文件找到source=这部分，里面会显示要下载的文件和url。如下图，$后面的表示变量，可在前面找到对应变量的值（一般是linux-4.18.xx.tar.xz这个文件下载失败，其他几个都较小）。**

**然后复制相应的url尝试用其他下载工具下载，也可以直接上[http://www.kernel.org](http://link.zhihu.com/?target=http%3A//www.kernel.org)下载kernel文件，下载到PKGBUILD文件所在的目录。下载完成后，切回刚才的Terminal，输入y继续，工具会自动检查下载的文件并校验，就会继续编译。**

下载完成后，开始解包

解完包后，弹出一个选项，如下图。选择CPU类型，默认Generic（通用型），笔者是Intel Ivy Bridge，输入19回车开始编译。

可以看到Linux-ck可以针对AMD和Interl的多个架构类型CPU进行优化定制编译。**2018-11-13更新：目前第七代intel CPU代号是Kaby Lake，在列表里无法找到，大家可以尝试选Skylake进行编译；或者选择27，让gcc自动选择优化编译。**

开始编译中....，编译过程比较漫长，请耐心等待吧

编译完成后，编译后的内核会自动安装到boot目录，此时重启将会从linux-ck内核启动。如果没有从linux-ck内核启动，可以修改grub默认启动项。

	sudo vi /etc/default/grub
	添加一行：
	GRUB_DEFAULT="1>2"
	然后执行命令：
	sudo update-grub

上述表示默认从grub第二项的第三个子项启动（想不到grub还有子菜单吧！！）
1. 1 ". "启动时可以感觉下启动速度，相比之前等1分多钟，现在的感觉简直是秒开啊

	uname -a #查看启动内核是否为linux-ck
	Linux T430U 4.18.5-3-ck #1 SMP PREEMPT Wed Aug 29 10:42:52 CST 2018 x86_64 GNU/Linux

2. 安装网卡驱动

	lspci|grep -i net	#查看网卡信息

本人笔记本无线网卡：Broadcom Limited BCM4313 802.11bgn Wireless Network Adapter

有线网卡：Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller

针对boradcom的无线网卡，一般Linux上是broadcom-wl驱动，对应ck版本则是broadcom-wl-ck，打开网址：[https://aur.archlinux.org/packages/broadcom-wl-ck/...](http://link.zhihu.com/?target=https%3A//aur.archlinux.org/packages/broadcom-wl-ck/)，查看此驱动依赖关系

如上图红框所示，linux-ck-4.18是可以使用的。安装命令和linux-ck一样：
yaourt --m-arg --skipchecksums --m-arg --skippgpcheck -S broadcom-wl-ck
3. 安装有线网卡RTL8111/8168/8411驱动
这里，笔者就比较悲剧了，并没有对应的r8168-ck驱动，如图，并不适合当前版本4.18

虽然不适合，我还是尝试安装了，却不能成功modprobe r8168。不过笔者还是找到了可以成功加载的r8168的驱动。

首先，从[http://www.realtek.com.tw/downloads/downloadsView.aspx?Langid=1&PNid=13&PFid=5&Level=5&Conn=4&DownTypeID=3&GetDown=false...](http://link.zhihu.com/?target=http%3A//www.realtek.com.tw/downloads/downloadsView.aspx%3FLangid%3D1%26PNid%3D13%26PFid%3D5%26Level%3D5%26Conn%3D4%26DownTypeID%3D3%26GetDown%3Dfalse)，下载RTL网卡驱动，如图

下载后文件是0012-r8168-8.046.00.tar.bz2，解压：

	tar xvf 0012-r8168-8.046.00.tar.bz2
	cd r8168-8.046.00
	sudo ./autorun.sh

编译安装完成后，会将r8168驱动模块安装到/usr/lib/modules/4.18.5-3-ck/kernel/drivers/net/ethernet/realtek/r8168.ko.xz

	cd /usr/lib/modules/extramodules-ck
	ln -s /usr/lib/modules/4.18.5-3-ck/kernel/drivers/net/ethernet/realtek/r8168.ko.xz r8168.ko.xz	#建立软链接

尝试加载模块：
sudo modprobe r8168
成功了，有线网卡图标终于出现在了Deepin Dock上。最后配置自动加载：

	cd /usr/lib/modules-load.d/
	sudo vi r8168.conf文件填入r8168
	cd /etc/modprobe.d
	sudo vi r8169_blacklist.conf填入blacklist r8169

## **七、安装主题**

安装主题与安装软件是一样的，只要在Add/Remove Software里搜索主题并安装即可，**注意：这里最好选择支持gtk 3.0的主题**，否则可能无法在Deepin桌面系统中应用主题

应用主题：打开Lanucher——控制中心（control center），选择Personalization——Theme进行应用更改

## **八、输入法问题**

fcitx想必是大家最常用的输入法管理工具了，在Manjaro上也支持fcitx输入法管理。若碰到输入法无法正常切换或打开，可以尝试命令fcitx-diagnose进行诊断，若有错误会红色标识。

如图是fcitx-diagnose的部分输出，因未安装fcitx-gtk2和fcitx-kde而报错，根据情况可以判断是否影响输入法。

Linux系统中大多数软件均通过指定的脚本启动，比如deepin-wechat，虽然运行在wine环境，但是启动时通过脚本，可以查看.desktop文件：
cd /usr/share/applications #该目录为应用程序.desktop文件目录
cat deepin.com.wechat.desktop

可以看到，.desktop里执行的脚本叫run.sh，继续查看run.sh，又调用了/opt/deepinwine/tools/run.sh，因此如果遇到在一些软件下无法切换输入法，而fcitx-diagnose又无相关报错，则可以尝试在启动脚本里加入一段环境变量设置，如下图所示：

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

笔者正是通过这种方法解决了Deepin-wechat里无法使用fcitx切换输入法的问题。

最后，希望大家喜欢这篇文章，找到自己喜欢的Linux发行版。
编辑于 2018-11-13
[ Deepin](https://www.zhihu.com/topic/19602965)
[ Linux](https://www.zhihu.com/topic/19554300)
[ Manjaro](https://www.zhihu.com/topic/20171852)

### 推荐阅读

[![v2-f9a86272c69689d90d1a7b23aab3e6b3_qhd.jpg](../_resources/be4e714b1f1c080e2cedfc95145c7fcc.jpg) # Manjaro安装deepin系统桌面  Mr.chuan](http://zhuanlan.zhihu.com/p/49821904)[![v2-208a9e436f6a0e9757adb9c5ceb1e027_qhd.jpg](../_resources/d1a2842b1b9a12bbb2546946c45e0f44.jpg) # 国产Linux发行版Deepin浅度体验  DealiAxy](http://zhuanlan.zhihu.com/p/33788325)[ # 也谈Deepin  前不久在网上看到Deepin王勇辞职的新闻，不由得让人扼腕叹息。早在几年前和王勇也有过一面之缘，对Deepin的发展方向做过一番交流。Deepin的发力方向是个人PC桌面，他们投入了大量的精力在个…  王春生](http://zhuanlan.zhihu.com/p/39723506)[![v2-7d45bed602060b2b75f29941a7869c60_qhd.jpg](../_resources/6525576a99e08c1b7fe1e6dcdf89d8f2.jpg) # Deepin系统15.7测试bug  Mr.chuan](http://zhuanlan.zhihu.com/p/49820757)

## 17 条评论

写下你的评论...

- ![da8e974dc_xs.jpg](../_resources/612042811425957bef56f3ce665caeb0.jpg)知乎用户1 个月前

大佬有没有觉得 manjaro deepin 稍微有点卡 或者说是吊针？

- ![da8e974dc_xs.jpg](../_resources/612042811425957bef56f3ce665caeb0.jpg)知乎用户 (作者) 回复知乎用户1 个月前

我用的集成显卡，没用来玩游戏，可能感觉不到掉帧。目前主要办公，感觉还好，没有明显的卡顿情况。唯一感觉到卡顿的是播放视频的时候，可能跟磁盘性能和参数有关系，播放一段时间视频会卡一下，之前以为是播放软件的问题，换了一个后还是有，目前还没找到解决办法。

- ![da8e974dc_xs.jpg](../_resources/612042811425957bef56f3ce665caeb0.jpg)知乎用户 (作者) 回复知乎用户1 个月前

不知道你是做什么的时候感觉卡，可以上google找找有没有优化的解决办法

-

[![da8e974dc_xs.jpg](../_resources/612042811425957bef56f3ce665caeb0.jpg)](https://www.zhihu.com/people/catfox-99)

[catfox](https://www.zhihu.com/people/catfox-99)1 个月前
原装的deepin我就觉得有点卡，小米笔记本

-

[![8724ed99620a98a35518256095ea599a_xs.jpg](../_resources/5cec93b1c818df15bd239aebbc578172.jpg)](https://www.zhihu.com/people/li-jia-tu-65-20)

[李嘉图](https://www.zhihu.com/people/li-jia-tu-65-20)14 天前
你好,写的很不错,就是我看了你的linux-ck里面 cpu代号选择的图片,为啥没有i5-7500的cpu代号,这是不是意味着我需要用通用的头呢?

- ![da8e974dc_xs.jpg](../_resources/612042811425957bef56f3ce665caeb0.jpg)知乎用户 (作者) 回复[李嘉图](https://www.zhihu.com/people/li-jia-tu-65-20)13 天前

我搜索了下，你的CPU应该是Kaby Lake，在linux-ck的评论里我找到了相关的答案，你可以看下这个链接[Intel Kaby Lake (7th Gen)? · Issue #29 · graysky2/kernel_gcc_patch](http://link.zhihu.com/?target=https%3A//github.com/graysky2/kernel_gcc_patch/issues/29)。大致意思是，看你安装的gcc版本是否支持你的CPU，用命令gcc -c -Q -march=native --help=target | grep march 可以查看，如果支持就可以选择27(native autodetced by gcc），意思是让gcc自动选择。另外，如果用上面的命令发现不支持，或者有bug，链接里的回复也提示说Kaby Lake和Skylake差不多，可以尝试选Skylake进行编译。

- ![da8e974dc_xs.jpg](../_resources/612042811425957bef56f3ce665caeb0.jpg)知乎用户 (作者) 回复[李嘉图](https://www.zhihu.com/people/li-jia-tu-65-20)13 天前

链接里还说gcc -c -Q -march=native --help=target | grep march输出结果可能不准，需要打补丁，可以看下你的gcc版本是否最新。一般打完补丁输出结果可能为Skylake，就可以尝试选Skylake编译。

-

[![8724ed99620a98a35518256095ea599a_xs.jpg](../_resources/5cec93b1c818df15bd239aebbc578172.jpg)](https://www.zhihu.com/people/li-jia-tu-65-20)

[李嘉图](https://www.zhihu.com/people/li-jia-tu-65-20)14 天前
写的很好,一赞

-

[![8724ed99620a98a35518256095ea599a_xs.jpg](../_resources/5cec93b1c818df15bd239aebbc578172.jpg)](https://www.zhihu.com/people/li-jia-tu-65-20)

[李嘉图](https://www.zhihu.com/people/li-jia-tu-65-20)13 天前
还有一点要说的就是yaourt已经1年没有维护了,现在看了一个国外的新闻,首推yay,manjaro自带就有,可以理解为另一个yaourt

- ![da8e974dc_xs.jpg](../_resources/612042811425957bef56f3ce665caeb0.jpg)知乎用户 (作者) 回复[李嘉图](https://www.zhihu.com/people/li-jia-tu-65-20)13 天前

嗯，yay is the next best aur helper written in go. 回头我也试试，我的系统貌似没有自带，要手动安装

-

[![v2-fa14618bb8ba57506f345b52873f91ee_xs.jpg](../_resources/7bf82835613e911cbc9d43ec28d285a1.jpg)](https://www.zhihu.com/people/smartony-44)

[沐念slightly](https://www.zhihu.com/people/smartony-44)回复[李嘉图](https://www.zhihu.com/people/li-jia-tu-65-20)4 天前

yaourt在国内还是必须要用的吧，yay不支持使用代理，万一aur包里有要从GitHub里下载的东西，不开代理在国内直接yay下载怕是一个月都下载不下来东西