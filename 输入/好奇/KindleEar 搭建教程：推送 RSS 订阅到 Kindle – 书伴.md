KindleEar 搭建教程：推送 RSS 订阅到 Kindle – 书伴

当前位置：[首页](https://bookfere.com/)»[使用技巧](https://bookfere.com/skills)»[辅助软件](https://bookfere.com/skills/software)»正文

# KindleEar 搭建教程：推送 RSS 订阅到 Kindle

  时间：[2016年11月14日](https://bookfere.com/post/19.html)    |   编辑：[书伴](https://bookfere.com/post/author/bookfere)      |[562 条评论](https://bookfere.com/post/19.html#comments)

本文最近更新日期：**2018年8月17日**
—————

KindleEar 是一款开源的 Python 程序，由网友 cdhigh 发起，托管在 Github。它可运行在免费的 Google APP Engine 上，把 RSS 生成排版精美的杂志模式的 MOBI 文件，并按照设置定时自动推送至你的 Kindle。如果你有 Python 和前端基础，还可以自定义排版，生成你需要的最完美的 MOBI 文件。

![kindleear-rss](data:image/gif;base64,R0lGODlhAQABAIAAAPn5+QAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==)

▲ KindleEar 推送 RSS 的效果
KindleEar 目前的功能有：

- 支持类似 Calibre 的 recipe 格式的不限量 RSS/ATOM 或网页内容收集
- 不限量自定义 RSS，直接输入 RSS/ATOM 链接和标题即可自动推送
- 多账号管理，支持多用户和多 Kindle
- 生成带图的杂志格式 mobi 或带图的有目录 epub
- 自动每天定时推送
- 强大而且方便的邮件中转服务
- 和 Evernote/Pocket/Instapaper 等系统的集成

下面这个是体验账号，可以添加一个 RSS 测试推送一下（需要把邮箱账号 kindlefere@gmail.com 添加到 Kindle 的推送信任列表），但请不要正式使用。测试时，请不要更改测试账号密码影响其他人测试。

**体验测试账号：**[http://kindlefere-feed.appspot.com](http://kindlefere-feed.appspot.com/) （用户名：**test**，密码：**123456**）

看到这些让人心动、那些收费的推送服务网站才有的功能是不是很心动了？其实搭建起来其实很简单，如果你什么都不懂，只要按照本文所给出的步骤一步一步操作就可以搞定。本文是更新后的教程，原方法需要配置上传环境，较为繁琐，现在只需要保证能科学上网，通过 Google 云端 Shell，只需要一行命令就可以搞定。现在，立即开始搭建自己的私有专属的 RSS 推送服务器吧！

> “
> 目录
> [> 一、准备工作](https://bookfere.com/post/19.html#ke_1)
> [> 二、上传程序](https://bookfere.com/post/19.html#ke_2)
> [> 方法一：自动上传](https://bookfere.com/post/19.html#ke_2_1)
> [> 方法二：手动上传](https://bookfere.com/post/19.html#ke_2_2)
> [> 三、设置推送](https://bookfere.com/post/19.html#ke_3)
> [> 四、常见问答](https://bookfere.com/post/19.html#ke_4)
> [> 五、其它事项](https://bookfere.com/post/19.html#ke_5)

本教程适用于 Windows 系统和 Mac OS X 系统，所以请注意下载适合你操作系统的软件，以及选择适合你操作系统的步骤。本文步骤没有多余的废话，请严格按照下面的步骤进行操作。遇到意外情况请留言提问，如果提出的问题文中已有说明将不再重复回答。

### 一、准备工作

KindleEar 依赖 Google APP Engine，所以你需要有一枚 Google 账号（注册完记得安步骤说明设置一下安全选项），然后创建一个 GAE 应用。以下步骤中，如果某个条件已具备，请忽略相应步骤继续。

### 1、下载科(fan)学(qiang)上网软件

因为在国内无法访问 Google 服务，所以需要借助科学上网软件实现访问。你可以使用你所习惯使用的或下面为你推荐的任意一款软件。为保证正常下载，请复制链接使用迅雷下载。

- Lantern：[Windows](https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer.exe) ｜[Mac OS X](https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer.dmg)  * 傻瓜化，无需配置，安装即可使用
- Psiphon3（赛风）：[Windows](https://www.psiphon3.com/psiphon3.exe) ｜ [Android](https://www.psiphon3.com/PsiphonAndroid.apk)（请用迅雷下载）

* 提示：Lantern 免费版限制流量，如果想要购买专业版，使用邀请码 **HBNVPW** 可获得额外时长。

### 2、注册 Google 账号

点击下面的链接，注册一枚带 @gmail.com 后缀的 Google 账号。
**Google 账号注册页面：**https://accounts.google.com/SignUp

### 3、Google 账号安全设置

Google 账号在默认可能会拒绝将 KindleEar 上传到 GAE，所以需要设置一下。点击下面的链接进入你的 Google 账号“**登录与安全**”设置页面，找到“**允许不够安全的应用**”这一项，点击右边的滑动按钮，将其状态切换为“**已启用**”。注意，为了账号安全，上传完之后建议将此设置恢复为停用状态。

**Google 账号设置页面：**https://myaccount.google.com/security#connectedapps

### 4、创建一个 Google Cloud 项目

KindleEar 是免费托管在 Google Cloud 的 Google App Engine（GAE）应用中的，所以你需要先创建一个 Google Cloud 项目，然后再创建一个 GAE 应用。点击下面的链接并用你的 Google 账号登录。

**创建 Google Cloud 项目页面：**[https://console.cloud.google.com](https://console.cloud.google.com/)

点击页面左上角的“**选择项目**”，点击弹出对话框右上角的“**新建项目**”，然后在“**新建项目**”页面中输入你喜欢的“**项目名称**”。项目名称可随意填写，只要是你喜欢并且符合它限定的规则即可。

需要着重注意的是项目名称下方的“**项目 ID**”，这个 ID 也就是我们后面提到的 APPID。默认情况下，系统会根据你输入的项目名称自动生成项目 ID，但是自动生成字符没有意义，为了方便记忆最好是自定义。点击项目 ID 后面的【**修改**】按钮，将其修改成你喜欢的字符串组合。这样等 KindleEar 部署成功后，你就可以通过 `http://APPID.appspot.com` 访问了（注意把 APPID 换成你真实的 APPID）。

### 5、创建 Google App Engine 应用

Google Cloud 创建完成后需要继续创建一个 GAE 应用，否则直接上传会出现下面这样的错误提示：

`Error 404: --- begin server output ---This application does not exist (project_id=u'sample-appid'). To create an App Engine application in this project, run "gcloud beta app create" in your console.--- end server output ---`

所以，当创建完 Google Cloud 项目之后，还需要手动创建一个 Google App Engine 应用。方法有两种：一种是使用云端 Shell 创建；另一种是在 Console 页面上进行。可根据自己的喜好选用。

**方法一：**上面那个错误提示给出了解决方案，直接在云端 Shell 中使用一行命令就能搞定。具体步骤为：点击页面右上角的 **[ >_ ]** 图标按钮（如下图所示），调出云端 Shell，输入以下命令按回车：

![active-google-cloud-shell](data:image/gif;base64,R0lGODlhAQABAIAAAPn5+QAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==)

`gcloud beta app create`

命令执行后会出现 `Which region would you like to choose?` 字样，询问选择应用的位置，在 `Please enter your numeric choice:` 之后输入数字 **1**，稍等片刻即可完成 GAE 应用的创建。

**方法二：**点击 Google Cloud 页面左上角的菜单按钮，点击弹出菜单中的“**[App Engine](https://console.cloud.google.com/appengine/start)**”。在“**您的第一个应用**”那里点击“**选择一种语言**”，选择“**Python**”。接下来“选择位置”中页面中选择“**us-central**”，最后点击下一步就等待它自动部署，只到出现“**让我们开始吧**”的字样，就表示 GAE 应用创建成功。

## 二、上传程序

下面提供了两种上传 KindleEar 程序到 GAE 的方法。方法一是通过 Google 云端 Shell 的方式进行上传，使用 Kindle 伴侣提供的 Shell 脚本一条命令就能搞定，完全自动化，强烈推荐使用。方法二是手动配置上网环境、手动输入命令进行上传，步骤较多也较为繁琐。请根据自己的实际情况择优选用。

### 方法一：自动上传（强烈推荐！）

1、进入 Google 云端控制台：https://console.cloud.google.com/home/dashboard
2、点击右上角的 Shell 图标（如下图所示）激活 Google 云端 Shell。

![active-google-cloud-shell](data:image/gif;base64,R0lGODlhAQABAIAAAPn5+QAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==)

3、复制下面的代码，粘贴到 Google 云端 Shell（如下图所示），回车执行。

`rm -f uploader.sh* && \wget https://raw.githubusercontent.com/kindlefere/KindleEar-Uploader/master/uploader.sh && \chmod +x uploader.sh && \./uploader.sh`

![](data:image/gif;base64,R0lGODlhAQABAIAAAPn5+QAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==)

4、按照脚本的提示，输入你的 Gmail 地址和准备好的 APPID，回车，等待上传成功即可。

注意，上面的代码只需要执行一次即可，如果想要重新上传或要更新代码，只需要直接运行 uploader.sh 这个 Shell 文件即可，即在云终端中输入下面这行代码即可：

`./uploader.sh`
* 提示：KindleEar 安装脚本托管在 GitHub：https://github.com/kindlefere/KindleEar-Uploader

### 方法二：手动上传

在开始手动上传部署 KindleEar 步骤之前，你需要保证已完成下面提到的准备工作。对于每一项准备工作，如果你已经具备条件，可忽略继续进行下一项。
[[ 展开步骤 ]](#)

## 三、设置推送

打开浏览器输入：`http://**你的APPID**.appspot.com`，默认的登录名和密码都是“**admin**”（建议修改密码），进入推送控制台你会发现以下几个选项卡（若登录时候出现类似“internal serve error”请不要慌，只需要多等候一些时间重试即可），可以根据自己的需要进行设置：

#### 1、我的订阅

可以在这里添加你自己的 RSS 地址。也可以在下方预置的一些订阅里选择自己感兴趣的。

在添加自定义 RSS 地址的时候请注意。KindleEar 仅支持 RSS/ATOM 格式的订阅（XML 格式），如果遇到添加的自定义 RSS 无法成功推送，请留意是否是格式错误导致的。比如有些 FeedBurner 烧制的 RSS 默认是 HTML 格式（可以通过查看源代码辨别），直接添加这种 RSS 地址不能成功推送，需要在添加的 RSS 地址后面添加一个参数 `?format=xml` 或 `?fmt=xml` 才行。

#### 2、设置

这里是推送的详细设置，在这里填写接收推送的“Kindle 邮箱”，选择投递日，所选投递日的投递时间，建议勾选“多本书籍合并投递为一本”、“使能自动定时投递”、“自动定时投递自定义 RSS”。同时还可以在“书籍标题”项填写显示在 Kindle 里的个性名称。当所有设置完后还可以点击“现在投递”测试一下。

#### 3、投递日志

每次投递的记录。

#### 4、账户管理

可以添加多用户，更改密码等。

#### 5、高级设置

有手动推送订阅功能即“现在投递”，有邮件白名单、归档和分享、URL 过滤、封面图片设置。

OK，全部步骤结束。在你的 Kindle 处于联网状态时，这个你亲手建立的推送服务器，就会按照你设置的时间定时把精美的电子杂志推送到你的 Kindle 上了！Enjoy it！

## 四、常见问题

很多小伙伴在安装和使用 KindleEar 的过程中会遇到一些问题，这些问题很常见也很好解决，所以书伴将这些问题整理归纳如下。如果你遇到了新的问题也可以留言提出。

#### 1、登录出现 Invalid username or password

如果确认输入的账号密码正确却仍然出现“`Invalid username or password.`”，请[点击这里](https://security.google.com/settings/security/activity)检查一下相关选项。首先找到“允许不够安全的应用”这个选项，确认是“已启用”状态。然后查看下账号登录是否被 Google 拦截，把可疑操作确认是自己操作，然后重新运行 uploader.bat 走一遍过程。如果取消拦截后还是出现“Invalid username or password.”这样的提示，请先使用浏览器登陆你的 Google 账号，看是否会有短信验证等提示，登录成功后重新运行 uploader.bat 走一遍过程。

#### 2、无法为其它 Google 账号上传程序

当为一个 Google 账号下的 GAE 上传 KindleEar后，程序会自动记录登陆邮箱密码，这样使用其它账号就无法上传了。想要切换帐号，Windows 系统请前往目录“`C:\用户\你的用户名\`”下删除“.appcfg_cookies”，然后重新运行 uploader.bat。Mac 或 Linux 系统遇到同样问题，使用命令 `rm ~/.appcfg_oauth2_tokens` 删除。

#### 3、访问页面提示 internal serve error

如果是刚上传完 KindleEar，由于 GAE 需要一些时间索引数据，在此期间访问某些页面会出现“internal serve error”的错误提示，最长等待十来分钟即可正常访问。

如果等待很长时间仍然出现“internal serve error”，请尝试这样操作：点击 Google Cloud 左上角的菜单按钮，点击弹出菜单中的“**数据存储**”，再点击数据存储页面左侧导航中的“**索引**”进入索引页面。

查看一下 Book、DeliverLog、Feed 三项的状态，如果是绿色对勾则正常，否则就需要重新索引一下。具体操作为，进入 KindleEar 目录，运行下面这条命令更新一下索引：

`$ python appcfg.py update_indexes ./`
注意，如果使用的是 Google 云端 Shell 直接使用 appcfg.py 命令即可：
`$ appcfg.py update_indexes ./`
待索引状态全部变成“**使用中**”后，也就是每一项都变成绿色对勾，即可正常访问。

#### 4、投递状态显示 wrong SRC_EMAIL

默认状态下 GAE 不允许发信，所以才会出现 wrong SRC_EMAIL 的提示，你需要设置一下把 Gmail 邮箱地址添加到“**Mail API 已获授权的发件人**”，这需要在 GAE 应用的设置中进行。

首先点击下面的网址进入 GAE 应用设置（将其中的 APPID 换成你真实的 APPID）：
`https://console.cloud.google.com/appengine/settings?project=APPID`
* 也可以点击左上角的菜单，在弹出的菜单中点击“**App Engine**”，然后再点击 APP 引擎页面左侧的“**设置**”。

切换到“**电子邮件发件人**”，看一下“**Mail API 已获授权发件人**（Mail API authorized senders）”账号里面有无添加发送邮箱地址，如果没有就点击上方的“**添加**”按钮或“**添加已获授权的电子邮件发件人**”按钮添加一下邮箱地址，注意添加完后要回车确认一下，最后点击“**添加**”，此问题即可解决。

#### 5、忘记 KindleEar 的登录密码怎么办

忘记密码可以进入 GAE 重置密码，具体方法为：访问 https://console.cloud.google.com，点击左上角的菜单，点击菜单中的“数据存储”，然后在“按种类查询”的标签项下方的“种类”中，选择“KeUser”，最后点击用户记录“名称/ID”，编辑其中的 passwd，改成 e10adc3949ba59abbe56e057f20f883e，最后点击【保存】按钮保存一下，这样就把密码临时改成了123456，登录账号修改成新密码即可。

## 五、其它事项

上文已将 KindleEar 的部署步骤和使用方法详细列出，一般情况下你只需要按照步骤一步步操作就能部署成功。如果遇到问题，请访问 [KindleEar 项目提供的常见问答（FAQ）](http://htmlpreview.github.io/?https://github.com/cdhigh/KindleEar/blob/master/static/faq.html)。那里可以解决你在安装 KindleEar 时遇到的绝大部分问题。如果 FAQ 没有解决你的问题，可以自行搜索看是否有可行办法。

实在解决不了可以[点击这里](https://github.com/cdhigh/kindleear/issues)向开发者提交一个“New issue”请求解答，也可以在本页留言请求帮助。

另外，如果你觉得 [KindleEar](https://github.com/cdhigh/KindleEar) 这款软件还不错，可以[点击这里](https://github.com/cdhigh/KindleEar/wiki/Donate)捐赠一下作者 cdhigh。

**【 外刊杂志 】**  [仅 39 元即可获得 1 年 MOBI 格式《经济学人》杂志，新刊自动发送到指定邮箱。](https://bookfere.com/store/the-economist-push.html)

**【 凑钱买书 】**  [对于较贵的电子书，以期望的价格与其他人一起凑钱购买。](https://push.bookfere.com/crowdfunding)（[点我看看都有些啥](KindleEar%20搭建教程：推送%20RSS%20订阅到%20Kindle%20–%20书伴.md#)）

#### “[Kindle推送]()”延伸阅读：

- [为何推送 KF8 标准 MOBI 电子书不显示封面](https://bookfere.com/post/668.html)
- [Calibre 常用命令行工具详解之 calibre-smtp](https://bookfere.com/post/646.html)
- [解决 Calibre 推送“500 Error: bad syntax”错误](https://bookfere.com/post/564.html)
- [EpubPress：把打开的多个网页转成一本电子书](https://bookfere.com/post/565.html)
- [一触即达！“Kindle 伴侣推送服务”正式上线运营](https://bookfere.com/post/508.html)
- [中亚 Send to Kindle 微信服务推送步骤变更](https://bookfere.com/post/468.html)
- [图解传书流程：把电子书放进 Kindle 的几种方式](https://bookfere.com/post/459.html)
- [中亚微信推送服务 Send to Kindle 全新升级](https://bookfere.com/post/407.html)
- [如何让 Kindle 邮箱推送支持 epub 格式电子书](https://bookfere.com/post/339.html)
- [Readability：定时或立即把长文推送到 Kindle](https://bookfere.com/post/312.html)

  分类：[辅助软件](https://bookfere.com/post/category/skills/software)    | 标签：[Kindle RSS推送](https://bookfere.com/post/tag/kindle-rss%e6%8e%a8%e9%80%81), [Kindle RSS订阅](https://bookfere.com/post/tag/kindle-rss%e8%ae%a2%e9%98%85), [KindleEar](https://bookfere.com/post/tag/kindleear), [Kindle推送](https://bookfere.com/post/tag/kindle%e6%8e%a8%e9%80%81), [Kindle推送教程](https://bookfere.com/post/tag/kindle%e6%8e%a8%e9%80%81%e6%95%99%e7%a8%8b), [推送RSS](https://bookfere.com/post/tag/%e6%8e%a8%e9%80%81rss), [订阅RSS](https://bookfere.com/post/tag/%e8%ae%a2%e9%98%85rss)

有帮助，**[[ 捐助本站 ]](https://bookfere.com/donate)** 或分享给小伙伴：

   [(L)](KindleEar%20搭建教程：推送%20RSS%20订阅到%20Kindle%20–%20书伴.md#)  [(L)](KindleEar%20搭建教程：推送%20RSS%20订阅到%20Kindle%20–%20书伴.md#)  [(L)](KindleEar%20搭建教程：推送%20RSS%20订阅到%20Kindle%20–%20书伴.md#)  [(L)](KindleEar%20搭建教程：推送%20RSS%20订阅到%20Kindle%20–%20书伴.md#)  [(L)](KindleEar%20搭建教程：推送%20RSS%20订阅到%20Kindle%20–%20书伴.md#)  [(L)](KindleEar%20搭建教程：推送%20RSS%20订阅到%20Kindle%20–%20书伴.md#)