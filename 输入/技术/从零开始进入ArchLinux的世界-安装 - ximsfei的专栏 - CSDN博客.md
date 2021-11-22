从零开始进入ArchLinux的世界-安装 - ximsfei的专栏 - CSDN博客

原

# 从零开始进入ArchLinux的世界-安装

2016年12月18日 15:34:11[ximsfei](https://me.csdn.net/ximsfei)阅读数：5114标签：[arch linux](http://so.csdn.net/so/search/s.do?q=arch%20linux&t=blog)[linux](http://so.csdn.net/so/search/s.do?q=linux&t=blog)[双系统引导](http://so.csdn.net/so/search/s.do?q=%E5%8F%8C%E7%B3%BB%E7%BB%9F%E5%BC%95%E5%AF%BC&t=blog)[U盘](http://so.csdn.net/so/search/s.do?q=U%E7%9B%98&t=blog)[安装](http://so.csdn.net/so/search/s.do?q=%E5%AE%89%E8%A3%85&t=blog)更多

个人分类：[Archlinux](https://blog.csdn.net/ximsfei/article/category/6624654)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' style='display: none%3b' data-evernote-id='390' class='js-evernote-checked'%3e%3cpath stroke-linecap='round' d='M5%2c0 0%2c2.5 5%2c5z' id='raphael-marker-block' style='-webkit-tap-highlight-color: rgba(0%2c 0%2c 0%2c 0)%3b' data-evernote-id='391' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

每次重新安装ArchLinux, 我都需要看一遍wiki, 在这里记我安装archlinux的整个过程，方便以后快速获取有用的信息.

- [Wiki Main Page](https://wiki.archlinux.org/)
- [Archlinux镜像下载地址](https://www.archlinux.org/download/)
- [如何制作U盘启动盘](https://wiki.archlinux.org/index.php/USB_flash_installation_media)

在GNU linux中可以使用dd命令:

	$ dd bs=4M if=/path/to/archlinux.iso of=/dev/sdx status=progress && sync

    - 1

在windows中可以使用[Rufus](https://rufus.akeo.ie/)

- [安装archlinux](https://wiki.archlinux.org/index.php/Installation_guide)

此处已安装了windows, 并且已分好区, 选择一个合适的分区安装archlinux, eg: /dev/sda2. 有需要的可以使用[fdisk](https://wiki.archlinux.org/index.php/Fdisk)或者[parted](https://wiki.archlinux.org/index.php/GNU_Parted)修改分区表

	$ mkfs.ext4 /dev/sda2 // 格式化分区
	$ mount /dev/sda2 /mnt
	$ vim /etc/pacman.d/mirrorlist // 修改镜像源
	$ pacstrap /mnt // 安装基础pkgs
	$ genfstab -U /mnt >> /mnt/etc/fstab
	$ arch-chroot /mnt
	$ ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	$ hwclock --systohc --utc // 设置时间标准
	$ vim /etc/locale.gen // 指定本地化类型
	  en_US.UTF-8 UTF-8
	  zh_CN.UTF-8 UTF-8
	  zh_TW.UTF-8 UTF-8
	$ locale-gen // 生成locale信息
	$ echo LANG=en_US.UTF-8 > /etc/locale.conf
	$ echo myhostname > /etc/hostname // 设置主机名
	$ vim /etc/hosts
	  127.0.1.1 myhostname.localdomain  myhostname
	$ passwd // 重置root密码

    - 1
    - 2
    - 3
    - 4
    - 5
    - 6
    - 7
    - 8
    - 9
    - 10
    - 11
    - 12
    - 13
    - 14
    - 15
    - 16
    - 17
    - 18
- [通过grub引导启动archlinux](https://wiki.archlinux.org/index.php/GRUB)

下面是我用到的grub引导双系统启动的例子：

	$ pacman -S grub
	$ grub-install --target=i386-pc /dev/sda
	$ grub-mkconfig -o /boot/grub/grub.cfg

    - 1
    - 2
    - 3

开机启动引导已安装的Windows系统

	$ mount /dev/sda1 /mnt

    - 1

*/dev/sda1 该分区安装了Windows系统*

	$ grub-probe --target=fs_uuid /mnt/bootmgr
	F258C55958C51D6B
	$ grub-probe --target=hints_string /mnt/bootmgr
	--hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=ahci0,msdos1

    - 1
    - 2
    - 3
    - 4

*这里生成的F258C55958C51D6B和–hint-bios=hd0,msdos1 –hint-efi=hd0,msdos1 –hint-baremetal=ahci0,msdos1在下面需要用到*

在/boot/grub/grub.cfg中添加下面几行

	if [ "${grub_platform}" == "pc" ]; then [[NEWLINE]]
	    menuentry "Microsoft Windows Vista/7/8/8.1 BIOS-MBR" { [[NEWLINE]]
	    insmod part_msdos [[NEWLINE]]
	    insmod ntfs [[NEWLINE]]
	    insmod search_fs_uuid [[NEWLINE]]
	    insmod ntldr [[NEWLINE]]
	    search --fs-uuid --set=root --hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=ahci0,msdos1 F258C55958C51D6B [[NEWLINE]]
	    ntldr /bootmgr [[NEWLINE]]
	} [[NEWLINE]]
	fi

    - 1
    - 2
    - 3
    - 4
    - 5
    - 6
    - 7
    - 8
    - 9

*如果是Windows XP最后一行为ntldr /ntldr*