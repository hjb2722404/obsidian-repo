使用 Kindle Ear 推送 RSS 到 Kindle 设备

![700x233](../_resources/08f55873b66be0c8661aa7d7432df959.jpg)

# 使用 Kindle Ear 推送 RSS 到 Kindle 设备

2017年08月23日

[![60x60](../_resources/96c14b824c00a47d9699fe3da17564a2.jpg)](https://sspai.com/user/749135)

#### [张永存](https://sspai.com/user/749135)

[KindleEar](https://github.com/cdhigh/KindleEar) 是提取 Calibre 的 mobi 模块，根据需求抓取下载包含图片的 RSS 订阅或网页推送到你的 Kindle，杂志格式书籍排版精美，跳转方便，阅读体验更好。我们可以使用 KindleEar 开源的代码，在 GAE 上免费搭建推送服务器。

![d8fb0f8d4f4f015a44348afbff761b3d.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102114939.png)

## 为什么要自己搭建？

- 不受限制，自定义 RSS 内容，可抓取任意地区 RSS 内容；
- 支持图片，无限制订阅源数量和文件大小；
- 多账户独立管理，可以分享给别人使用你搭建的系统；
- 如果你需要，还可以自定义排版；
- 使用自己的服务，不需要排队等待，推送速度更快。

## 我需要准备什么？

- <s>安装 Python 2.7 环境</s>
- <s>安装 GAE SDK 环境</s>
- <s>安装 GIT 环境</s>

对的，这些都不需要，你只需要能够正常的访问 Google 服务，进行操作即可。

如果，你想先预览下推送的抓取效果，可以 **[点击下载](http://qn.zhangyongcun.com/file/KindleEar_demo.azw3) **我抓取的少数派 RSS 效果，包括图片抓取，文章布局，杂志格式等。

![e37df15fffa6b242ca202bbb59739587.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102114957.jpg)

## 创建 APP 引擎

打开 [APP 引擎中心](https://console.cloud.google.com/appengine)，创建一个 APP 引擎。（如果你之前没有创建过** **Project ,需要先创建一个项目。）

![95355b0c83414d566616b2553bd67675.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102115127.png)

![3eba4a66dab988bb6b286eb3988a54a9.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102115136.png)
点击 【Next】开始创建
![da82b29c6d678d3e2abe97c65c0ca8ac.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102115149.png)
创建完成，根据教程，点击继续，打开控制台 shell，如果弹出教程，【退出教程】即可。
![8250d3b84e679a4842192d0c2045b433.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102115158.png)
激活远端 shell 之后，分别输入命令进行下载安装和部署

	[[BLOCK_OPEN]]wget http://qn.zhangyongcun.com/file/kindleEar.sh
	chmod +x kindleEar.sh
	./kindleEar.sh[[BLOCK_CLOSE]]

执行阶段会提示输入你的 Gmail 邮箱和当前的 APP ID，键入回车键之后，就开始自动部署了。
![78b830ff39796ad49da113c56bb58487.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102115211.png)
**然后，就没有然后了，恭喜，你已经部署完成了。**
为什么其他的资料，甚至 KindleEar 官方安装步骤都如此复杂甚至还有错误呢？因为教程具有时效性，很多已经过时不能再使用。

## 使用简介

刷新  [APP 引擎中心](https://console.cloud.google.com/appengine) 页面，就可以看到部署信息了。点击图示的链接，即可访问服务。

![61a1623f004c3708a76c268d25a8ed9d.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102115224.png)
打开链接，默认账号密码均为：admin
![97278dafc8cf2ce0cc594d9be9db2a58.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102115234.png)
登陆之后，点击 【我的订阅】进行设置，如果出现 【internal server error】，是因为系统没有完全部署完成，稍等五分钟左右就可以正常使用。
![50025e542a6426752f3762457550df6f.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102115243.png)
**注意：推送之前，你需要完成以下操作。**

1. 设置 Gmail 邮箱到 Kindle 信任邮箱中，在 [我的亚马逊](https://www.amazon.cn/mn/dcw/myx.html/ref=kinw_myk_redirect#/home/content/booksAll/dateDsc/) 中【管理我的内容和设备】--【设置】在 【已认可的发件人电子邮箱列表】中添加。

2. 打开 [APP 引擎中心](https://console.cloud.google.com/appengine) ，添加 【已获授权的发件人】
![adb7d1b6c6a352617b9ac4306f012fa1.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102115254.jpg)
设置投递选项，注意修改之后需要选择 【保存设置】
![93abd96b8e2464a71a994b8fadef05b1.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102115302.png)
【投递日志】可以查看投递的状态。由于 RSS 内容抓取需要一定的时间，所以日志可能会有延迟。
![c0c2ec72ff300a48c19ea53529e169b1.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102115317.png)
【账户管理】可以当前账户密码，也可以添加新成员，这样你就可以把系统分享给你的好朋友是用了，相互之间互不影响。
【高级设置】大家可以根据需要自行研究，比如批量导入订阅源，保存内容到****Pocket Instapaper。

如果你感觉搭建过程过于麻烦并且浪费时间，你可以选择我在淘宝平台提供的[付费搭建服务](https://item.taobao.com/item.htm?spm=a230r.1.14.15.5e00891bj4JWVU&id=550098656655&ns=1&abbucket=11#detail)。

相关链接：

- [Kindle Ear](https://github.com/cdhigh/KindleEar)
- 如果遇到问题，请访问：[FAQ](http://htmlpreview.github.io/?https://github.com/cdhigh/KindleEar/blob/master/static/faq.html)
- 相关推荐

#### 如何更好地使用 Kindle

分享一些简单实用的 Kindle 技巧，提高阅读体验。
[查看原文](https://sspai.com/post/40333)

* * *

[找到正确用法，剁手的「神器」才不算乱花钱，由少数派编辑部出品的 Power+ 栏目现已上线](https://sspai.com/series/9) ⚡️

[#RSS](https://sspai.com/tag/RSS)  [#Kindle](https://sspai.com/tag/Kindle)

[![](../_resources/d89746888da2d9510b64a9f031eaecd5.gif)](https://sspai.com/a/nO2x)