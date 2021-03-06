puppeteer填坑指南 - 掘金

[(L)](https://juejin.im/user/4353721775424743)

[ kēvin44687   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzhDREJGNCIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTYgNGwxLTF2MmgtMXpNMTcgM2gydjJoLTJ6TTE3IDVoMnY2aC0yeiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/4353721775424743)

2019年04月25日   阅读 1815

# puppeteer填坑指南

# puppeteer填坑指南

## 前言

原文地址：[zhangzippo.github.io/posts/2019/…](https://zhangzippo.github.io/posts/2019/04/25/_25puppteererror.html)

相信大家在使用puppeteer的时候会遇到各种各样的问题，比如原本在mac上跑的好好的却发现在centos/docker上遭遇各种各样的问题， 这里把我所遇到的坑跟大家说一下。

## 安装

首当其中就是安装的问题了，这个在mac上没什么问题，这里介绍在centos上的问题，puppeteer含有两个包puppeteer VS puppeteer-core,什么区别呢？简单来说就是puppeteer = api+chromeium（最新），puppeteer-core = only Api,官方是这么说的：

`puppeteer-core`>  与 `puppeteer`>  不同的地方：

- `puppeteer-core`>  在安装时不会自动下载 Chromium。
- `puppeteer-core`> 忽略所有的 `PUPPETEER_*`>  env 变量.

当你自己安装chromeium的时候，在启动（puppeteer.launch()）的时候需要指定chromeium的启动路径，当然自己安装存在更新的问题，可能由于更新不及时导致与puppeteer的api不匹配的情况，所以我们推荐直接安装puppeteer。然后呢，当你在centos上安装的时候毫无疑问的会报错。因为缺少chromeium启动的依赖，本人在centos6和7上都遇到了坑，下面是官方列举的centos上的所需依赖：

> pango.x86_64 libXcomposite.x86_64 libXcursor.x86_64 libXdamage.x86_64 libXext.x86_64 libXi.x86_64 libXtst.x86_64 cups-libs.x86_64 libXScrnSaver.x86_64 libXrandr.x86_64 GConf2.x86_64 alsa-lib.x86_64 atk.x86_64 gtk3.x86_64 ipa-gothic-fonts xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-utils xorg-x11-fonts-cyrillic xorg-x11-fonts-Type1 xorg-x11-fonts-misc

只需要一顿 yum install 就好。当然事情可能不是这样的，当你启动chromeium时（推荐在服务器上测试的时候先进入到node_modules/puppeteer/.local-chromium/linux-496140/chrome-linux/chrome目录下执行./chrome进行测试，能成功运行代表通过puppeteer的api调用也能成功）你可能会遇到例如：

> error while loading shared libraries: libpangocairo-1.0.so.0: cannot open shared object file: No such file or directory 这样的错误，提示你缺少的是一个so文件，你可以在执行文件目录下执行这个命令进行查看缺少哪些依赖： ldd chrome | grep not 命令执行后会显示你当前缺少的依赖，当你不知道对应的.so在哪个包中的时候执行这个命令： yum provides | grep xx.so.0

找到对应的包进行yum install 安装，注意32还是64位的，不要装错。当ldd chrome | grep not 结果为空时代表所有依赖都已经安装，本人在centos6.5上测试时，安装了所有依赖依然提示缺少某个依赖，查了一下，竟然发现存在于firefox的包中，非常费解，[segmentfault.com/a/119000001…](https://segmentfault.com/a/1190000015802337)这篇文章的作者与我遇到同样的问题解决了，然而我相同做法后依然没有解决，还是无法启动chrome，而且chrome要依赖别的浏览器的包实在有点儿...后来google了一下好像是6.5版本对于chrome的支持有限，遂我换成了centos7.6，继续，安装很顺利..没什么坑。其他可能遇到下载chromium失败的情况，这个在.npmrc指定一下下载源

> PUPPETEER_DOWNLOAD_HOST = > [> npm.taobao.org/mirrors](https://npm.taobao.org/mirrors)

## 启动

你以为安装完就没坑了？no,no,no。启动还能坑你一回，如果你直接启动会报这个错误：

> No usable sandbox! Update your kernel or see > [> chromium.googlesource.com/chromium/sr…](https://chromium.googlesource.com/chromium/src/+/master/docs/linux_suid_sandbox_development.md)>  for more information on developing with the SUID sandbox. If you want to livedangerously and need an immediate workaround, you can try using --no-sandbox.

啥意思呢？就是你正常应该将chrome运行在一个沙盒中，但是你没配置，对应的网址和puppeteer的文档中有写怎么操作创建沙盒，下面这个：[github.com/GoogleChrom…](https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md)

然而我照着做并不行，还是报错，于是采用planB 加 --no-sandbox,官方的例子是：

	javascript const browser = await puppeteer.launch({args: ['--no-sandbox', '--disable-setuid-sandbox']});
	复制代码

我们测试的时候可以执行 ./chrome --no-sandbox --disable-setuid-sandbox 然后如果你是直接执行./chrome (js中的例子默认headless=true )你又会看到这个错误：

> Gtk-WARNING **: 23:01:03.809: cannot open display 我不太熟悉linux,但这个意思就是说你不能打开一个图形界面，别去百度了，如果你也是linux小白。我们在后面加上 --headless 就可以了，到此启动也没问题了。

## 运行puppeteer

启动都没问题了还有什么坑呢？我这里在使用时遇到一些问题，与大家共勉吧，如果你也遇到的话注意排查问题。

- 遇到获取页面错误的问题 这个当然有很多可能了，比如缺少cookie被拦截，这个好办，还有一种情况是某些网站存在反爬机制判断UA标示不是浏览器端或者带headless标示（chromeium headless模式默认UA会带），所以你最终得到的并非想要的页面，还有各种被重定向的情况都有可能得不到想要的页面，这个时候最好在 page = await page.goto(); 之后调用page.text()方法检查页面是否符合预期
- timeout情况 这个大家可能遇到的最多，goto方法加载一个页面默认超时是30秒，你可以更改，也可以直接写0代表一直等待。我遇到某些情况导致页面很慢才加载结束，尤其是当你设置waitUntil = networkidle0的时候，怎么排查这个问题呢？使用 page.on('requestfailed')方法看看什么资源阻滞了页面跳转，page.on('request')方法拦截对应的请求abort()掉，我在应用中碰到线下机器访问不了内网域名的情况，苦苦跟了很久。

## 结尾

可能后面还会遇到很多坑，慢慢看吧.....

## 参考文章：

[github.com/GoogleChrom…](https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md)