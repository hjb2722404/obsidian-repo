Fiddler - 超好用的http抓包工具使用介绍（附：拦截请求并修改返回数据）

# Fiddler - 超好用的http抓包工具使用介绍（附：拦截请求并修改返回数据）

 2017-07-16  发布：hangge  阅读：89274

## 一、Fiddler 介绍

Fiddler 是一个使用 C# 编写的 http 抓包工具。它使用灵活，功能强大，支持众多的 http 调试任务，是 web、移动应用的开发调试利器。

### 1，功能特点

- 同 Httpwatch、Firebug 这些抓包工具一样，Fiddler 够记录客户端和服务器之间的所有 HTTP 请求，可以针对特定的 HTTP 请求，分析请求数据、设置断点等。

- 但 Fiddler 更为强大的是，它还可以修改请求的数据，甚至可以实现请求自动重定向，从而修改服务器返回的数据。

- Fiddler 使用也十分方便。在打开 Fiddler 的时候，它就自动设置好了浏览器的代理，通过改写 HTTP 代理，让数据从它那通过，来监控并且截取到数据。当关闭 Fiddler 的时候，它又自动帮你把代理还原。

### 2，下载安装

直接去 Fiddler 的官网下载即可。地址：http://www.telerik.com/fiddler

## 二、http 请求抓取

### 1，Fiddler 启动后就自动开始工作了。

- 使用浏览器随便访问几个页面，左侧区域就会将捕获的结果显示出来。

- 通过点击左下角的图标可以关闭/开启抓包功能。

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108140618.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

### 2，查看请求内容

双击某个会话请求，在右侧的 Inspectors 选项卡中可以查看该会话的内容，上半部分是请求的内容，下半部分是响应的内容。

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108140623.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

### 3，使用 Filters 过滤请求

由于 Fiddler 会抓取所有的 HTTP 请求，这样会造成左边的窗口不断的更新，有时可能会对我们的调试造成干扰。我们可以通过过滤规则的设置，从而来过滤掉那些不想看到的请求。

（1）点击 Fiters 选项卡，勾选左上角的 Use Filters 即可开启过滤器。下方有两个最常用的过滤条件：Zone 和 Host：

[![4039498861058963312](../_resources/9b09df311f5a7f4e3241c196dc68bf3b.png)](https://googleads.g.doubleclick.net/aclk?sa=l&ai=CJmcREVE2X4b-O4mX8wOpor_gCujZt9te-NaQt_kLg-T0_QgQASC_w8gqYJ0BoAGsw92bA8gBAqkCXFyaxMRRgz6oAwHIA8kEqgTiAU_QTOHnOgnM6S7h1yGhz--RlrHtd5TexelDDnRS0qBMDfpsQ_1x55gUJ9g-5yY1JppQOGdGfkFxhURPtFJOgaVwBMh3NBJOf_BofOqoUwZx-yBdfKeDhc6b3ZN2TMYjtikbWYAg_5z-Df5PfyTIGi4RUI88Viy52MvfdnuFivxLVU6Y3W0jPpCe_Hbbn525QAz9dje6455nJN0khwMbNeLzF4c7bdSViadlopawjxr68GxlGxa_AU5GfUz32TqgI5506ByIUMw5oZIRp9urKc-oAvfxHjFTsKOSY-O6j95xFuzABMats8T2AqAGAoAHvLyiZKgHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcB0ggHCIBhEAEYH7EJ7m3fCrXi3WGACgGYCwHICwHYEwI&ae=1&num=1&sig=AOD64_3zcNxIbjsqM8c_2oFL5eHsYQxYAA&client=ca-pub-1033034437703838&nb=17&adurl=https://activity.huaweicloud.com/free_test/index.html%3Futm_source%3Dgoogle%26utm_medium%3Dse-union-op%26utm_campaign%3DT2002070830151000630XRT05KO52P%26utm_content%3D%26utm_term%3D%26utm_adplace%3DAdplace028578%26gclid%3DEAIaIQobChMIxsqi9Kia6wIVict8Ch0p0Q-sEAEYASAAEgL31_D_BwE)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 24 16' data-evernote-id='22' class='js-evernote-checked'%3e%3cpath d='M10.90 4.69L10.90 5.57L3.17 5.57L3.17 7.22L3.17 7.22Q3.17 9.15 3.06 10.11L3.06 10.11L3.06 10.11Q2.95 11.07 2.58 11.92L2.58 11.92L2.58 11.92Q2.21 12.77 1.27 13.56L1.27 13.56L0.59 12.93L0.59 12.93Q2.29 11.82 2.29 8.66L2.29 8.66L2.29 4.69L6.11 4.69L6.11 2.95L7.00 2.95L7.00 4.69L10.90 4.69ZM23.00 7.34L23.00 8.22L12.80 8.22L12.80 7.34L17.55 7.34L17.55 5.53L15.12 5.53L15.12 5.53Q14.55 6.53 13.86 7.07L13.86 7.07L13.10 6.46L13.10 6.46Q14.44 5.46 14.95 3.33L14.95 3.33L15.84 3.55L15.84 3.55Q15.77 3.86 15.49 4.65L15.49 4.65L17.55 4.65L17.55 2.84L18.47 2.84L18.47 4.65L21.86 4.65L21.86 5.53L18.47 5.53L18.47 7.34L23.00 7.34ZM21.45 8.88L21.45 13.63L20.53 13.63L20.53 12.78L15.32 12.78L15.32 13.63L14.41 13.63L14.41 8.88L21.45 8.88ZM15.32 11.90L20.53 11.90L20.53 9.76L15.32 9.76L15.32 11.90Z'%3e%3c/path%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 15 15' data-evernote-id='21' class='js-evernote-checked'%3e%3cpath d='M3.25%2c3.25l8.5%2c8.5M11.75%2c3.25l-8.5%2c8.5'%3e%3c/path%3e%3c/svg%3e)

- Zone：指定只显示内网（Intranet）或互联网（Internet）的内容

- Host：指定显示某个域名下的会话

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/1e9d21fb01c469810db6b1f701653469.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

（2）比如我们只想显示与 [hangge.com](http://hangge.com/) 的会话，可以这么设置。（如果有红框中的文字，表示修改未生效，点击即可。）

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/2b7926d3d9fe1098780d6fb1546953a0.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

## 三、AutoResponder 用法（拦截指定请求，并返回自定义数据）

AutoResponder 允许你拦截指定规则的求情，并返回本地资源或 Fiddler 资源，从而代替服务器响应。这个在我们平时开放调试中也是很有用的：

- 比如在前端开发中，如果发现服务器上某个 css/JavaScript 文件有问题，直接上去改会影响生产环境的稳定。利用 Fiddler 的 AutoResponder 功能，我可以将需要修改的文件重定向到本地文件上，这样就可以基于生产环境修改并验证，确认后再发布。

- 再比如服务端提供了接口和数据格式给前端调用，可能由于某些原因，接口还未开发完毕、或者返回数据有异常。为了不影响开发进度，前端仍然可以继续调用这个接口，然后通过 Fiddler 将请求转向本地的数据文件上。

（1）比如 [hangge.com](http://hangge.com/) 首页用到了 jQuery，假设我们要修改这个 js。

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/c130580c7d9d77bb0441b280844ca3e9.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

（2）首先将 js 文件保存到本地（如果本地已经有这个文件，可以跳过这步）

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/4bef7b2bf80f237518cdcd653518f421.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

（3）接着打开 AutoResponder 标签设置，勾选前面两个复选框，开启 Fiddler 的请求自动重定向功能。

- 第一个复选框的作用是开启或禁用自动重定向功能，我们就可以在下面添加重定向规则了。

- 第二个复选框框勾上时，不影响那些没满足我们处理条件的请求。

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/36fb9b2137a5f2a20e6e18618cab4dd8.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

（4）下面就要创建重定向规则了，将目标是这个 js 的 HTTP 请求重定向到本地文件。我们可以通过“Add…”按钮手动添加规则，不过这个 URL 已经出现在我们的 session 列表中，可以直接拖动过来。

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/d7886e982b70c306c34d87edd8d465e6.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

（5）接着修改这个规则。点击下方的下拉框，选择“Find a file…”，就可以选择本地的文件作为返回的 body 内容。

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/907059d3439eee8042b8d4ad4f81707c.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

（6）这里我们选择刚才保持下来的 js 文件。这样我们的请求重定向就设置好了。

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/4b185cfcb4925321978a0c7489ef0bd6.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

（7）试着修改下本地这个 js 文件。比如我们在开头加了个 alert 语句。

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/2989e582406694d3df934267669f5335.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

（8）刷新页面，重新访问就可以看到效果了。（如果浏览器有缓存，要先清下缓存）

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/0a476339912e426ea3880d9a17261a99.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

## 四、解密 HTTPS 的网络数据

通常情况下，对于 HTTPS 请求，我们捕获后是无法看到里面的数据。

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/ea9802b5f02fb7350231e327650de748.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

不过 Fiddler 可以通过伪造 CA 证书来欺骗浏览器和服务器，从而实现解密 HTTPS 数据包的目的。大概原理就是在浏览器面前 Fiddler 伪装成一个 HTTPS 服务器，而在真正的 HTTPS 服务器面前 Fiddler 又装成浏览器。

（1）要开启 HTTPS 解密，我们依次点击菜单栏 Tools -> Telerik Fiddler Options

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/7aebd88dbb2714c69bb0df4c8e49dcfb.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

（2）在弹出窗口中，勾选 HTTPS 标签页下的 Decrypt HTTPS Traffic。这是会弹出个对话框询问是否安装证书，选择 Yes 安装即可。

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/79051b9beafb29862dddf7de4c298848.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

（3）再次访问 HTTPS 页面，可以发现数据已经够被成功解析了。

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/c09fcabcb210c4e256e910fb271c2cea.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

## 五、自定义请求发送到服务器

在 Composer 面板中，我们可以向服务器发送自定义请求，可以手动创建一个新的请求，也可以从会话表中，拖拽一个现有的请求。
使用时我们只需要提供简单的 URLS 地址即可。当然还可以在 RequestBody 定制一些属性，如模拟浏览器 User-Agent 等等。

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/64a98ad7292178ef8212e7d86c67a1e8.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

## 六、抓取 iPhone / Android 设备的数据包

想要 Fiddler 抓取移动端设备的数据包，其实很简单。只要设置代理，让这些数据通过 Fiddler 即可。

（1）首先确保 PC 和手机是在同一个局域网下。打开 Fidder，点击菜单栏中 Tools –> Telerik Fiddler Options

[![](https://i.loli.net/2021/01/09/Z2nziXcxlwtug7y.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

（2）勾选 Connections 选项卡中的“Allow remote computers to connect”允许远程连接。

- 勾选后可能会要求重启 Fiddler，那就重启一下。

- 默认代理端口是 8888，可以不需要修改。

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/44b12a5c4b45d83f037fd7f3cfad33dd.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

（3）将手机端的代理设置为 PC 的 IP 和端口（这里假设我们 PC 地址为 192.168.1.101）

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/58816dab2fd966c953a94927469837d6.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

（4）接着打开手机浏览器，访问 PC 的地址+端口

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/8392563ebf17c55c9d9f087fb7aa986f.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

（5）在打开的页面中点击“FiddlerRoot certificate”，下载并安装证书。

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/73f13e9cf04776842abef277a39c1d09.png)](https://www.hangge.com/blog/cache/detail_1697.html#)

（6）安装完了证书，使用用手机访问应用，就可以看到截取到的数据包了。（这里我使用百度外卖 App 随便测试了下）

[![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/e641914fa9c5b902e9bb61e401d9e484.png)](https://www.hangge.com/blog/cache/detail_1697.html#)