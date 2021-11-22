在WINDOWS环境下使用node安装express,mongoose,jade,bower,bootstrap

# 在WINDOWS环境下使用node安装express,mongoose,jade,bower,bootstrap

环境搭建

最近学习node下的web开发，需要搭建一个开发环境，采用的是express+mangoose+jade+bootstrap的环境架构，已经在window8.1系统（64bit）上安装了node,(安装过程稍后会单独写一篇博文)，就使用node安装了以上所提到的包。

1、安装express。打开windows命令行窗口（cmd）,然后利用cd命令切换到你的项目根目录，执行下面的语句：

	npm isntall express

等待一下，npm会自动从网上下载express包，下载完成后，你可以打开文件浏览器，切换到根目录下查看，会发现多了一个express的文件夹，后面几个包也是同理，命令分别是：

	>npm install jade

	>npm install mongoose

	>npm install bower -g

	>bower install bootstrap

需要注意的是，这里我们是先用npm安装了bower包管理器，然后又用bower从git上下载了bootstrap，所以在执行最后一条安装bootstrap语句前，请先确保机器安装了git并且将git下的bin目录和cmd目录路径添加到系统环境变量PATH中。

[markdownFile.md](../_resources/08b1f9f1b340e03cb7249aecb9222eac.bin)