puppetter安装就踩坑-解决篇 - 掘金

[(L)](https://juejin.im/user/536217402746525)

[ 圆儿圈圈   [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)](https://juejin.im/user/536217402746525)

2018年09月13日   阅读 11487

# puppetter安装就踩坑-解决篇

#### PUPPETEER概述

> Puppeteer 是一个 Node 库，它提供了一个高级 API 来通过 DevTools 协议控制 Chromium 或 Chrome。

Puppeteer 是 Google Chrome 团队官方的无界面（Headless）Chrome 工具。正因为这个官方声明，许多业内自动化测试库都已经停止维护，包括 PhantomJS。Selenium IDE for Firefox 项目也因为缺乏维护者而终止。

puppetter可以生成页面的截图和PDF，抓取SSR，抓取网站内容，模拟登陆等。puppetter可以做这么多少玩的事情，我开始跃跃试试，重新写一套爬虫。开始行动！

#### 安装

> Puppeteer 要求使用 Node v6.4.0，但因为文中大量使用 async/await，需要 Node v7.6.0 或以上。

#### 初始化项目

1. 新建目录

	$ mkdir puppeteer-demo
	$ cd puppeteer-demo
	复制代码

1. 初始化项目

	$ npm init
	复制代码

1. 安装 Puppeteer。
由于 Puppeteer并不是稳定的版本而且每天都在更新，所以如果你想要最新的功能可以直接通过 GitHub 的仓库安装。

	$ npm i --save puppeteer
	复制代码

安装时可能会出现以下报错:

	ERROR: Failed to download Chromium r588429! Set "PUPPETEER_SKIP_CHROMIUM_DOWNLOAD" env variable to skip download.
	复制代码

Chromium浏览器有58M左右，可能会出现安装失败的情况。
解决方法一：

	vi .npmrc

	type puppeteer_download_host = https://npm.taobao.org/mirrors

	yarn add puppeteer -D
	复制代码

代理puppeteer下载地址
解决方法二：官方建议设置环境变量 `PUPPETEER_SKIP_CHROMIUM_DOWNLOAD` 忽略浏览器的下载

	env PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true npm i puppeteer -D
	复制代码

引申一下~

##### 环境变量

> Puppeteer 寻找某些环境变量来帮助其操作。 如果 puppeteer 在环境中没有找到它们，这些变量的小写变体将从 npm 配置 中使用。

- HTTP_PROXY, HTTPS_PROXY, NO_PROXY - 定义用于下载和运行 Chromium 的 HTTP 代理设置。
- PUPPETEER_SKIP_CHROMIUM_DOWNLOAD - 请勿在安装步骤中下载绑定的 Chromium。 PUPPETEER_DOWNLOAD_HOST - 覆盖用于下载 Chromium 的 URL 的主机部分。
- PUPPETEER_CHROMIUM_REVISION - 在安装步骤中指定一个你喜欢 puppeteer 使用的特定版本的 Chromium。

引申结束~

忽略了Chromium浏览器下载后，我们成功下载好了puppeteer。然后去找puppeteer安装包package.json中对应的chrome版本。(`puppeteer/package.json->puppeteer.chromium_revision，具体见lib/Downloader.js`)

[1](../_resources/76d6b1ffc0f1e214d3749ada5818f6e3.webp)

这里的依赖chromium版本是588429，

接着去官网手动下载Chromium文件，下载地址：[npm.taobao.org/mirrors/chr…](https://npm.taobao.org/mirrors/chromium-browser-snapshots/) 解压后放在本地

##### 在项目中引入Chromium文件

一、直接放在puppeteer默认读取目录下

例如：node_modules\puppeteer.local-chromium\win64-526987(系统类型-版本号)\chrome-win32(下载的文件名)\

二、放在其他目录
我将Chromium文件直接放在项目目录puppeteer-demo下，运行时需要使用puppeteer.executablePath()设置路径参数

	const pathToExtension = require('path').join(__dirname, 'chrome-mac/Chromium.app/Contents/MacOS/Chromium');

	puppeteer.launch({executablePath: pathToExtension});
	复制代码

* * *

puppeteer.executablePath()

returns: A path where Puppeteer expects to find bundled Chromium. Chromium might not exist there if the download was skipped with PUPPETEER_SKIP_CHROMIUM_DOWNLOAD.

* * *

1. 运行Puppeteer
新建screenShot.js，引入puppeteer包然后配置Chromium启动路径。 调用`puppeteer.launch`方法启动Chromium。

这里需要提醒注意申明的函数是一个async函数，使用了ES 2017 `async/await`特性。该函数是一个异步函数，会返回一个Promise。如果async最终顺利返回值，Promise则可以顺利reslove，得到结果；否则将会reject一个错误。

因为我们使用了async函数，我们使用await来暂停函数的执行，直到Promise返回一个browser对象。

	const puppeteer = require('puppeteer');

	(async () => {
	    const pathToExtension = require('path').join(__dirname, 'chrome-mac/Chromium.app/Contents/MacOS/Chromium');
	    const browser = await puppeteer.launch({
	        headless: false,
	        executablePath: pathToExtension
	    });
	    const page = await browser.newPage();
	    await page.goto('https://www.baidu.com');
	    await page.setViewport({width: 1000, height: 500});
	    await page.screenshot({path: 'example.png'});
	    await browser.close();
	})();
	复制代码