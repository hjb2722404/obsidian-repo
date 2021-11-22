利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台 - 挖站否-挖掘建站的乐趣

# 利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台

- **2017年8月30日
- **by [Qi](https://wzfou.com/author/wzfou/)
- [**98](https://wzfou.com/huginn-rss/#comments)
- **8,197

文章目录
[**]()

- [一、Huginn安装部署方法](https://wzfou.com/huginn-rss/#Huginn)
    - [1.1  VPS部署Huginn](https://wzfou.com/huginn-rss/#11_VPSHuginn)
    - [1.2  Heroku部署Huginn](https://wzfou.com/huginn-rss/#12_HerokuHuginn)
- [二、Huginn抓取任意网站RSS并输出全文](https://wzfou.com/huginn-rss/#HuginnRSS)
    - [2.1  抓取文章RSS](https://wzfou.com/huginn-rss/#21_RSS)
    - [2.2  获取RSS全文](https://wzfou.com/huginn-rss/#22_RSS)
    - [2.3  生成RSS地址](https://wzfou.com/huginn-rss/#23_RSS)
- [三、Huginn抓取微信公众号并输出RSS](https://wzfou.com/huginn-rss/#HuginnRSS-2)
- [四、Huginn一站式信息阅读](https://wzfou.com/huginn-rss/#Huginn-2)
- [五、总结](https://wzfou.com/huginn-rss/#i)

Huginn其实非常适合像我这样的RSS阅读重度“用户”。很多RSS阅读器因为赚不到钱逐渐被公司所抛弃——商人嘛，无利可图自然不可持久。同时，一些新闻资讯类的网站也讨厌RSS，因为RSS用户对于他们来说不会带来流量——没有流量，自然没有收入。

目前来看，RSS的地位非常地“尴尬”，它在RSS开发者和RSS内容输出者面前非常不受欢迎，甚至有极端者“恨不得RSS已死”。幸好，RSS还有一大批忠实用户，一直支撑着RSS的发展，即便是移动APP的出现，也未能直接将RSS判定为“死亡”。

另外，对于微信公众号重度“患者”Huginn也有很好的“药方”。利用搜狐微信平台，Huginn可以帮助我们定时抓取微信公众号的文章更新，然后生成RSS，你可以将所有的公众号文章聚合到一个平台。Huginn可以为你抓取RSS全文，从此解放你的双手。

[Huginn](https://wzfou.com/tag/huginn/)还可以监控天气预报，如果明天下雨，则给你发送提醒；监控某款商品的网页，一旦降价，通知你；监控某款商品的网页，一旦降价，通知你……官方还有非常多的应用实例，网友们也写出了非常多的Huginn脚本，帮助你打造一个只属于自己的IFTTT服务。

有人说，在某种程度上讲，Huginn比IFTTT还强大，因为Huginn可以与Slack、Pushbullet等进行整合，这样无论在身处何地何时，你都可以通过手机接收到Huginn给抓取的网站RSS更新、微信公众号文章、天气提醒、行程安排、待办事项、新闻动态……

[![Huginn_000.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120832.jpg)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_000.jpg)

更多的[建站程序](https://wzfou.com/jianzhan-chengxu/)及[站长工具](https://wzfou.com/tag/zhanzhang-gongju/)，你还可以看看：

1. # [三大免费工具助你检测VPS服务器真伪-VPS主机性能和速度测试方法](https://wzfou.com/vps-ceping-gongju/)
2. # [Lsyncd搭建同步镜像-用Lsyncd实现本地和远程服务器之间实时同步](https://wzfou.com/lsyncd/)
3. # [新版BT.cn宝塔VPS主机面板建站使用体验-清爽傻瓜式操作功能全面](https://wzfou.com/bt-cn/)

**PS：2017年10月31日更新，**感觉Huginn麻烦的朋友，可以试试这一款免费的在线抓取全文RSS工具：[生成和订阅任意网站RSS工具-实现RSS全文,邮箱和手机APP提醒](https://wzfou.com/rss-any/)。

## 一、Huginn安装部署方法

[Huginn安装](https://wzfou.com/tag/huginn-install/)部署官网推荐有两种方式，一种是将Huginn安装部署在自己的VPS主机上，过程比较繁琐，但是成功率还是非常高，这主要归功于Huginn官网的教程已经做到了傻瓜式。另一种则是部署在Heroku平台，免费的，适合没有自己的服务器的朋友。

### 1.1  VPS部署Huginn

Huginn部署VPS主机支持Ubuntu (16.04, 14.04 and 12.04)和Debian (Jessie and Wheezy)，你只要按照官网的教程一步一步地复制执行命令，基本上可以成功了：[Huginn在Debian/Ubuntu手动安装教程-抓取全文RSS和微信公众号开源软件](https://wzfou.com/huginn/)。

### 1.2  Heroku部署Huginn

**需要的东西**
1. # Codeanywhere 账号：https://codeanywhere.com/
2. # Heroku 账号：http://herokuapp.com/
**部署步骤**

登陆 Huginn Github 主页的 Deployment 部分：https://github.com/huginn/huginn#deployment，找到 Heroku 的按钮。然后点击，就会跳转到你的 Heroku 了。

[![Huginn_22-1.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120844.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_22-1.gif)

点完按钮之后会跳转到你的 Heroku 界面去起个名字。直接拉到最后点 Deploy 的按钮，之后它就会开始 build 了。

[![Huginn_23-1.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120848.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_23-1.gif)

创建好了后，点击 View 就直接跳转到已经建立好的应用了。Manage App 会跳转到 Heroku 管理界面。点击 View后可以看到 Huginn 很人性化的把步骤贴出来了。由于我们用的是自动安装，所以没有创建管理员用户，也有一些东西需要配置。（可以看到已经可以访问域名了）

[![Huginn_24-1.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120851.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_24-1.gif)

现在我们对照着 Huginn 的说明来做。登陆 Codeanywhere，点击右上角的 Editor。会进入一个选择界面，如截图。

[![Huginn_25-1.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120853.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_25-1.gif)

第一次的话点完 Create 会让你验证邮箱，验证完邮箱对着上图再做一遍就可以了。我们首先要下载新版本的 ruby 环境。

[![Huginn_26.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120856.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_26.gif)

打开huginn.sh：https://github.com/tesths/tesths.github.com/blob/master/images/huginn/huginn.sh，复制到 Codeanywhere 的文件编辑器里。然后点击右上角保存。保存到根目录下，文件名保存为 huginn.sh。

[![Huginn_27.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120903.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_27.gif)

然后在你的 Heroku 界面找到下图的地方，在以下地方将code-huginn换成你自己的名字。（点击放大）

[![Huginn_28.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120908.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_28.gif)

然后执行脚本 huginn.sh，命令：bash huginn.sh。执行完毕之后，进行如下操作即可：
1. # 先进入 `cd code-huginn/`（这里的 code-huginn 输入你刚替换的名字就好）。
2. # 在命令行登陆你的 heroku ，就是在命令行输入 `heroku login`。
3. # 之后执行 `heroku git:remote -a code-huginn`。
4. # 最后执行 `bin/setup_heroku`。剩下的就是开始自动配置了。
heroku空间几点说明：

1. # heroku免费账户的网站在30分钟内无人访问后会自动关闭（休眠），可以使用网站监控服务来防止其休眠，例如：uptimerobot：https://uptimerobot.com。

2. # heroku免费用户的所有app运行总时长为每个月550小时，也就是说你的APP无法保证30X24X7小时全天候运行，建议让网站每天只运行18小时。当然添加信用卡之后，会再赠送450小时。

3. # heroku免费账户只有5M的 Postgres 数据库，只允许在数据库中记录10000行，因此，作者建议设置`heroku config:set AGENT_LOG_LENGTH=20`。

4. # Huginn安装在heroku的过程中默认使用的是SendGrid的邮箱服务器，但是heroku非信用卡用户无法使用SendGrid的邮箱服务器，建议添加其它邮箱服务器，比如，gmail邮箱服务器，具体设置如下：

	heroku config:set SMTP_DOMAIN=google.com
	heroku config:set SMTP_USER_NAME=<你的gmail邮箱地址>
	heroku config:set SMTP_PASSWORD=<邮箱密码>
	heroku config:set SMTP_SERVER=smtp.gmail.com
	heroku config:set EMAIL_FROM_ADDRESS=<你的gmail邮箱地址>

## 二、Huginn抓取任意网站RSS并输出全文

### 2.1  抓取文章RSS

进入到Huginn，点击新建Agent，类型选择Website Agent，名字随便取，其它的保持默认。

[![Huginn_04.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120913.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_04.gif)

填写选项内容。在选项中就是我们填写抓取规则的地方了。
1. # url填入需要解析的页面，例如：wzfou.com
2. # type表示格式，可以有html, xml, json, text多种格式
3. # mode表示信息的输出处理方式，“on_change”表示仅输出下面的内容，”merge”表示新内容和输入的agent内容合并。
4. # extract是我们要提取的信息。

**extract内容。**主要就是标题、链接、内容和时间等，我们只需要填写相关内容的Xpath路径，另外对于链接的话加入值：value: @href，标题加入：value: normalize-space(.)。如下图：（点击放大）

[![Huginn_07.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120917.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_07.gif)

**关于获取网页的Xpath的方法**，直接使用Chrome，右击我们要获取的内容，然后选择“审查元素”，再到控制面板右击，选择复制Xpath。例如wzfou.com的最新文章的url的Xpath是：//*[@id=”cat_all”]/div/div/div[2]/div/h2/span/a。

[![Huginn_05.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120920.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_05.gif)

另外，由于我们获取到的Xpath往往是某一个具体的元素的，想要匹配所有的符合要求的元素，我们还可以借助Chrome的Xpath插件：[XPath Helper](https://chrome.google.com/webstore/detail/xpath-helper/hgimnogjllphhhkhlmebbmlgjoejdpjl?hl=zh-CN)。例如我们获取一般是：//*[@id=”cat_all”]/div[1]/div/div[2]/div/h2/span/a。通过插件我们测试出去年第一个divr的1，也就是变成我上面的：//*[@id=”cat_all”]/div/div/div[2]/div/h2/span/a。于就匹配了所有的最新文章链接地址了。

其它的标题、内容、时间等都可以参考上面的方法获取到。

[![Huginn_06.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120923.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_06.gif)

预览抓取结果。点击“Dry Run”，你就可以预览抓取结果了。注意到“事件”中看到抓取了结果，就表示该Website Agent设置成功了。

[![Huginn_08.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120926.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_08.gif)

### 2.2  获取RSS全文

还是点击新建Agent，类型选择Website Agent，来源选择你刚刚创建的Website Agent。

[![Huginn_08_1.gif](../_resources/ee4fff562d2e4427005742e1e1aced30.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_08_1.gif)

然后在选项设置处，URL填写：{{url}}，即抓取你刚刚获取RSS的链接地址，mode选择“merge”，xpath就是本文的Xpath，value填入“.”，即原样输出全文并合并原先的输出。

[![Huginn_08_1_1.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120929.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_08_1_1.gif)

### 2.3  生成RSS地址

点击新建Agent，类型选择Data Output Agent，Sources中填入第二步的Agent名称。

[![Huginn_08_2.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120933.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_08_2.gif)

在选项中填入你的RSS的标题、描述、链接等信息，同时在Item中填写标题、描述、链接等，即输出RSS全文的标题、内容与链接地址等等。

[![Huginn_08_4.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120936.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_08_4.gif)

最后，你就可以看到RSS订阅地址已经生成的。

[![Huginn_11.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120939.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_11.gif)

复制该RSS订阅地址到RSS阅读器，就可以订阅文章更新了。

[![Huginn_12.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120943.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_12.gif)

如果你没有RSS输出，请检查以下三点：
1. # WebsiteAgent接受到的Event，是否有url这个字段？
2. # 如果event里url字段，用 url_from_event 就行了
3. # dry run 时会提示你输入Event作为输入，这是要输入一个带url的event，否则当然没输出了。

## 三、Huginn抓取微信公众号并输出RSS

抓取微信公众号的文章更新，首先需要一个网页。这里我们需要利用的就是搜索微信平台了，例如[挖站否的微信](http://weixin.sogou.com/weixin?type=1&query=%E6%8C%96%E7%AB%99%E5%90%A6&ie=utf8&_sug_=n&_sug_type_=&w=01019900&sut=2064&sst0=1470553392399&lkt=0%2C0%2C0)是这样的：

[![Huginn_08_5.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120947.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_08_5.gif)

原理还是和上面一样的，创建Website Agent，去抓取搜狐微信页面，通过Xpath获得“最近文章”内容，然后得到最近文章的URL，继续抓取，最终获得微信公众号文章全文。

这里有一个抓取微信公众号生成RSS输出的scenarios，你可以直接下载导入：https://www.ucblog.net/wzfou/weixin.json。

[![Huginn_12_1.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120953.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_12_1.gif)

导入完成后，你只需要修改“从搜狗微信搜索公众号，获取最新文章标题”和“获取公众号最新文章的链接地址”两个Agent的URL，换成你想要订阅的微信公众号URL即可。

[![Huginn_18.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120956.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_18.gif)

最后，确保所有的Agent正常运行。

[![Huginn_20.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120959.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_20.gif)

然后，你就可以使用RSS阅读器订阅微信公众号更新了。

[![Huginn_21.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231121002.gif)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_21.gif)

## 四、Huginn一站式信息阅读

**PC电脑端。**自然是用RSS阅读器了，不管你是用RSS订阅软件，还是使用RSS在线订阅平台，你只要有一个RSS订阅源，你可以享受在任意电脑上查看自己的RSS信息了。国内的可用一览（目前有 100 个订阅数的限制），国外用Inoreader（无限制但有广告）。

[![Huginn_29.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231121005.jpg)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_29.jpg)

**手机移动端。**手机上可以安装RSS阅读器的APP，但是更强大的是Huginn可以结合IFTTT、Pushbullet、Slack等将图片、超链接、文件、文字等内容发到你自己的手机上，或者直接发到你的微信、QQ、邮箱等。

[![Huginn_30.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231121008.jpg)](https://wzfou.cdn.bcebos.com/wp-content/uploads/2017/08/Huginn_30.jpg)

## 五、总结

Huginn可以订阅任意你想要订阅的网站与平台，例如微信公众号、简书、知乎、博客、图虫、Lofter……，只要有网页同时生成了CSS，你就可以派出你的“Agent”去把他们抓回来，然后将他们“分门别类”，任意处置了。

看完此文的朋友，一定知道Huginn的门槛就在于环境的部署以及Website Agent规则的制定。虽然说Huginn有scenarios可供导入导出，但是目前为止还没有一个像油猴那样大规模的scenarios库，所以Huginn普及是非常困难的。

目前，大家可以在这里找到几个可供使用的脚本库：http://huginnio.herokuapp.com/scenarios。另外，Heroku部署Huginn也不是长久之计，一是Heroku基本上打不开，二来免费服务还不能运行24小时，不差钱的朋友可以购买一个[VPS主机](https://wzfou.com/vps/)部署Huginn。这是我用过的VPS：[VPS主机排行榜单](https://wzfou.com/vps-bangdan/)。

文章出自：[挖站否](https://wzfou.com/)  https://wzfou.com/huginn-rss/，部分内容参考自[walkginkgo](http://walkginkgo.com/huginn/2017/05/14/heroku-huginn.html)、[xzonepiece](http://www.jianshu.com/p/a030246c330a)、[walkginkgo](http://walkginkgo.com/life/2016/07/15/huginn.html)、[pmvince](https://www.pmvince.win/2017/02/12/%E4%BD%BF%E7%94%A8Huginn+RSS%E6%9E%84%E5%BB%BA%E4%B8%AA%E4%BA%BA%E4%BF%A1%E6%81%AF%E4%B8%AD%E5%BF%83/) 版权所有。本站文章除注明出处外，皆为作者原创文章，可自由引用，但请注明来源。

[**收藏 (*0*)](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

分享到：[(L)](https://connect.qq.com/widget/shareqq/index.html?url=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F&title=%E5%88%A9%E7%94%A8Huginn%E6%8A%93%E5%8F%96%E4%BB%BB%E6%84%8F%E7%BD%91%E7%AB%99RSS%E5%92%8C%E5%BE%AE%E4%BF%A1%E5%85%AC%E4%BC%97%E5%8F%B7%E6%9B%B4%E6%96%B0-%E6%89%93%E9%80%A0%E4%B8%80%E7%AB%99%E5%BC%8F%E4%BF%A1%E6%81%AF%E9%98%85%E8%AF%BB%E5%B9%B3%E5%8F%B0&desc=%E5%88%A9%E7%94%A8Huginn%E6%8A%93%E5%8F%96%E4%BB%BB%E6%84%8F%E7%BD%91%E7%AB%99RSS%E5%92%8C%E5%BE%AE%E4%BF%A1%E5%85%AC%E4%BC%97%E5%8F%B7%E6%9B%B4%E6%96%B0-%E6%89%93%E9%80%A0%E4%B8%80%E7%AB%99%E5%BC%8F%E4%BF%A1%E6%81%AF%E9%98%85%E8%AF%BB%E5%B9%B3%E5%8F%B0&summary=%E6%9C%89%E4%BA%BA%E8%AF%B4%EF%BC%8C%E5%9C%A8%E6%9F%90%E7%A7%8D%E7%A8%8B%E5%BA%A6%E4%B8%8A%E8%AE%B2%EF%BC%8CHuginn%E6%AF%94IFTTT%E8%BF%98%E5%BC%BA%E5%A4%A7%EF%BC%8C%E5%9B%A0%E4%B8%BAHuginn%E5%8F%AF%E4%BB%A5%E4%B8%8ESlack%E3%80%81Pushbullet%E7%AD%89%E8%BF%9B%E8%A1%8C%E6%95%B4%E5%90%88%EF%BC%8C%E8%BF%99%E6%A0%B7%E6%97%A0%E8%AE%BA%E5%9C%A8%E8%BA%AB%E5%A4%84%E4%BD%95%E5%9C%B0%E4%BD%95%E6%97%B6%EF%BC%8C%E4%BD%A0%E9%83%BD%E5%8F%AF%E4%BB%A5%E9%80%9A%E8%BF%87%E6%89%8B%E6%9C%BA%E6%8E%A5%E6%94%B6%E5%88%B0Huginn%E7%BB%99%E6%8A%93%E5%8F%96%E7%9A%84%E7%BD%91%E7%AB%99RSS%E6%9B%B4%E6%96%B0%E3%80%81%E5%BE%AE%E4%BF%A1%E5%85%AC%E4%BC%97%E5%8F%B7%E6%96%87%E7%AB%A0%E3%80%81%E5%A4%A9%E6%B0%94%E6%8F%90%E9%86%92%E2%80%A6%E2%80%A6&pics=https://wzfou.com/wp-content/uploads/2017/08/Huginn_000.jpg&flash=&site=%E6%8C%96%E7%AB%99%E5%90%A6-%E6%8C%96%E6%8E%98%E5%BB%BA%E7%AB%99%E7%9A%84%E4%B9%90%E8%B6%A3&showcount=1)[(L)](https://service.weibo.com/share/share.php?appkey=1802574923&title=%E3%80%90%E5%88%A9%E7%94%A8Huginn%E6%8A%93%E5%8F%96%E4%BB%BB%E6%84%8F%E7%BD%91%E7%AB%99RSS%E5%92%8C%E5%BE%AE%E4%BF%A1%E5%85%AC%E4%BC%97%E5%8F%B7%E6%9B%B4%E6%96%B0-%E6%89%93%E9%80%A0%E4%B8%80%E7%AB%99%E5%BC%8F%E4%BF%A1%E6%81%AF%E9%98%85%E8%AF%BB%E5%B9%B3%E5%8F%B0%E3%80%91%E6%9C%89%E4%BA%BA%E8%AF%B4%EF%BC%8C%E5%9C%A8%E6%9F%90%E7%A7%8D%E7%A8%8B%E5%BA%A6%E4%B8%8A%E8%AE%B2%EF%BC%8CHuginn%E6%AF%94IFTTT%E8%BF%98%E5%BC%BA%E5%A4%A7%EF%BC%8C%E5%9B%A0%E4%B8%BAHuginn%E5%8F%AF%E4%BB%A5%E4%B8%8ESlack%E3%80%81Pushbullet%E7%AD%89%E8%BF%9B%E8%A1%8C%E6%95%B4%E5%90%88%EF%BC%8C%E8%BF%99%E6%A0%B7%E6%97%A0%E8%AE%BA%E5%9C%A8%E8%BA%AB%E5%A4%84%E4%BD%95%E5%9C%B0%E4%BD%95%E6%97%B6%EF%BC%8C%E4%BD%A0%E9%83%BD%E5%8F%AF%E4%BB%A5%E9%80%9A%E8%BF%87%E6%89%8B%E6%9C%BA%E6%8E%A5%E6%94%B6%E5%88%B0Huginn%E7%BB%99%E6%8A%93%E5%8F%96%E7%9A%84%E7%BD%91%E7%AB%99RSS%E6%9B%B4%E6%96%B0%E3%80%81%E5%BE%AE%E4%BF%A1%E5%85%AC%E4%BC%97%E5%8F%B7%E6%96%87%E7%AB%A0%E3%80%81%E5%A4%A9%E6%B0%94%E6%8F%90%E9%86%92%E2%80%A6%E2%80%A6&pic=https://wzfou.com/wp-content/uploads/2017/08/Huginn_000.jpg&url=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F)[(L)](https://wzfou.com/huginn-rss/javasrcipt:;)[(L)](https://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F&title=%E5%88%A9%E7%94%A8Huginn%E6%8A%93%E5%8F%96%E4%BB%BB%E6%84%8F%E7%BD%91%E7%AB%99RSS%E5%92%8C%E5%BE%AE%E4%BF%A1%E5%85%AC%E4%BC%97%E5%8F%B7%E6%9B%B4%E6%96%B0-%E6%89%93%E9%80%A0%E4%B8%80%E7%AB%99%E5%BC%8F%E4%BF%A1%E6%81%AF%E9%98%85%E8%AF%BB%E5%B9%B3%E5%8F%B0&desc=%E5%88%A9%E7%94%A8Huginn%E6%8A%93%E5%8F%96%E4%BB%BB%E6%84%8F%E7%BD%91%E7%AB%99RSS%E5%92%8C%E5%BE%AE%E4%BF%A1%E5%85%AC%E4%BC%97%E5%8F%B7%E6%9B%B4%E6%96%B0-%E6%89%93%E9%80%A0%E4%B8%80%E7%AB%99%E5%BC%8F%E4%BF%A1%E6%81%AF%E9%98%85%E8%AF%BB%E5%B9%B3%E5%8F%B0&summary=%E6%9C%89%E4%BA%BA%E8%AF%B4%EF%BC%8C%E5%9C%A8%E6%9F%90%E7%A7%8D%E7%A8%8B%E5%BA%A6%E4%B8%8A%E8%AE%B2%EF%BC%8CHuginn%E6%AF%94IFTTT%E8%BF%98%E5%BC%BA%E5%A4%A7%EF%BC%8C%E5%9B%A0%E4%B8%BAHuginn%E5%8F%AF%E4%BB%A5%E4%B8%8ESlack%E3%80%81Pushbullet%E7%AD%89%E8%BF%9B%E8%A1%8C%E6%95%B4%E5%90%88%EF%BC%8C%E8%BF%99%E6%A0%B7%E6%97%A0%E8%AE%BA%E5%9C%A8%E8%BA%AB%E5%A4%84%E4%BD%95%E5%9C%B0%E4%BD%95%E6%97%B6%EF%BC%8C%E4%BD%A0%E9%83%BD%E5%8F%AF%E4%BB%A5%E9%80%9A%E8%BF%87%E6%89%8B%E6%9C%BA%E6%8E%A5%E6%94%B6%E5%88%B0Huginn%E7%BB%99%E6%8A%93%E5%8F%96%E7%9A%84%E7%BD%91%E7%AB%99RSS%E6%9B%B4%E6%96%B0%E3%80%81%E5%BE%AE%E4%BF%A1%E5%85%AC%E4%BC%97%E5%8F%B7%E6%96%87%E7%AB%A0%E3%80%81%E5%A4%A9%E6%B0%94%E6%8F%90%E9%86%92%E2%80%A6%E2%80%A6&pics=https://wzfou.com/wp-content/uploads/2017/08/Huginn_000.jpg&site=%E6%8C%96%E7%AB%99%E5%90%A6-%E6%8C%96%E6%8E%98%E5%BB%BA%E7%AB%99%E7%9A%84%E4%B9%90%E8%B6%A3&showcount=1)[(L)](https://www.douban.com/recommend/?url=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F&title=%E5%88%A9%E7%94%A8Huginn%E6%8A%93%E5%8F%96%E4%BB%BB%E6%84%8F%E7%BD%91%E7%AB%99RSS%E5%92%8C%E5%BE%AE%E4%BF%A1%E5%85%AC%E4%BC%97%E5%8F%B7%E6%9B%B4%E6%96%B0-%E6%89%93%E9%80%A0%E4%B8%80%E7%AB%99%E5%BC%8F%E4%BF%A1%E6%81%AF%E9%98%85%E8%AF%BB%E5%B9%B3%E5%8F%B0&v=1)[(L)](http://tieba.baidu.com/i/app/open_share_api?link=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F)[(L)](https://twitter.com/intent/tweet?url=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F&text=%E5%88%A9%E7%94%A8Huginn%E6%8A%93%E5%8F%96%E4%BB%BB%E6%84%8F%E7%BD%91%E7%AB%99RSS%E5%92%8C%E5%BE%AE%E4%BF%A1%E5%85%AC%E4%BC%97%E5%8F%B7%E6%9B%B4%E6%96%B0-%E6%89%93%E9%80%A0%E4%B8%80%E7%AB%99%E5%BC%8F%E4%BF%A1%E6%81%AF%E9%98%85%E8%AF%BB%E5%B9%B3%E5%8F%B0)[(L)](https://plus.google.com/share?url=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F)[(L)](http://www.facebook.com/sharer.php?u=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F&t=%E5%88%A9%E7%94%A8Huginn%E6%8A%93%E5%8F%96%E4%BB%BB%E6%84%8F%E7%BD%91%E7%AB%99RSS%E5%92%8C%E5%BE%AE%E4%BF%A1%E5%85%AC%E4%BC%97%E5%8F%B7%E6%9B%B4%E6%96%B0-%E6%89%93%E9%80%A0%E4%B8%80%E7%AB%99%E5%BC%8F%E4%BF%A1%E6%81%AF%E9%98%85%E8%AF%BB%E5%B9%B3%E5%8F%B0)[(L)](http://www.linkedin.com/shareArticle?mini=true&ro=true&url=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F&title=%E5%88%A9%E7%94%A8Huginn%E6%8A%93%E5%8F%96%E4%BB%BB%E6%84%8F%E7%BD%91%E7%AB%99RSS%E5%92%8C%E5%BE%AE%E4%BF%A1%E5%85%AC%E4%BC%97%E5%8F%B7%E6%9B%B4%E6%96%B0-%E6%89%93%E9%80%A0%E4%B8%80%E7%AB%99%E5%BC%8F%E4%BF%A1%E6%81%AF%E9%98%85%E8%AF%BB%E5%B9%B3%E5%8F%B0&summary=%E6%9C%89%E4%BA%BA%E8%AF%B4%EF%BC%8C%E5%9C%A8%E6%9F%90%E7%A7%8D%E7%A8%8B%E5%BA%A6%E4%B8%8A%E8%AE%B2%EF%BC%8CHuginn%E6%AF%94IFTTT%E8%BF%98%E5%BC%BA%E5%A4%A7%EF%BC%8C%E5%9B%A0%E4%B8%BAHuginn%E5%8F%AF%E4%BB%A5%E4%B8%8ESlack%E3%80%81Pushbullet%E7%AD%89%E8%BF%9B%E8%A1%8C%E6%95%B4%E5%90%88%EF%BC%8C%E8%BF%99%E6%A0%B7%E6%97%A0%E8%AE%BA%E5%9C%A8%E8%BA%AB%E5%A4%84%E4%BD%95%E5%9C%B0%E4%BD%95%E6%97%B6%EF%BC%8C%E4%BD%A0%E9%83%BD%E5%8F%AF%E4%BB%A5%E9%80%9A%E8%BF%87%E6%89%8B%E6%9C%BA%E6%8E%A5%E6%94%B6%E5%88%B0Huginn%E7%BB%99%E6%8A%93%E5%8F%96%E7%9A%84%E7%BD%91%E7%AB%99RSS%E6%9B%B4%E6%96%B0%E3%80%81%E5%BE%AE%E4%BF%A1%E5%85%AC%E4%BC%97%E5%8F%B7%E6%96%87%E7%AB%A0%E3%80%81%E5%A4%A9%E6%B0%94%E6%8F%90%E9%86%92%E2%80%A6%E2%80%A6&source=&armin=armin)[(L)](http://www.google.com/bookmarks/mark?op=add&bkmk=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F&title=%E5%88%A9%E7%94%A8Huginn%E6%8A%93%E5%8F%96%E4%BB%BB%E6%84%8F%E7%BD%91%E7%AB%99RSS%E5%92%8C%E5%BE%AE%E4%BF%A1%E5%85%AC%E4%BC%97%E5%8F%B7%E6%9B%B4%E6%96%B0-%E6%89%93%E9%80%A0%E4%B8%80%E7%AB%99%E5%BC%8F%E4%BF%A1%E6%81%AF%E9%98%85%E8%AF%BB%E5%B9%B3%E5%8F%B0)

- **Tags:
- [Huginn](https://wzfou.com/tag/huginn/)

- [Huginn Heroku](https://wzfou.com/tag/huginn-heroku/)

- [Huginn RSS](https://wzfou.com/tag/huginn-rss/)

- [Huginn VPS主机](https://wzfou.com/tag/huginn-vps/)

- [Huginn中文](https://wzfou.com/tag/huginn-cn/)

- [Huginn全文RSS](https://wzfou.com/tag/huginn-quanwen-rss/)

- [Huginn安装](https://wzfou.com/tag/huginn-install/)

- [Huginn微信](https://wzfou.com/tag/huginn-wechat/)

- [Huginn微信公众号](https://wzfou.com/tag/huginn-weixin/)

- [Huginn教程](https://wzfou.com/tag/huginn-jiaocheng/)

- [RSS订阅工具](https://wzfou.com/tag/rss-dingyue/)

- [建站工具](https://wzfou.com/tag/jianzhan-gongju/)

- [站长工具](https://wzfou.com/tag/zhanzhang-gongju/)

![Huginn_00-223x120.jpg](../_resources/3bd928c662301d411e89295b63393c8f.jpg)

## [Huginn在Debian/Ubuntu手动安装教程-抓取全文RSS和微信公众号开源软件](https://wzfou.com/huginn/)

- **2017年8月27日
- [**56](https://wzfou.com/huginn-rss/#)

![Server-jiang_00-223x120.jpg](../_resources/27b10bc8388d52b069a3602e112f9adc.jpg)

## [Wordpress评论微信通知和邮件提醒-Server酱和第三方SMTP发信](https://wzfou.com/wp-weixin-mail/)

- **2017年9月2日
- [**59](https://wzfou.com/huginn-rss/#)

创作不易，用心坚持，欢迎请Qi喝一怀爱心咖啡！

[打赏支持](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

- [本文作者](https://wzfou.com/huginn-rss/#about-autor)
- [作者还写过](https://wzfou.com/huginn-rss/#more-autor)

![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)

# Qi/[159 Posts](https://wzfou.com/author/wzfou/)

- [**](https://wzfou.com/go/weibo)
- [**](https://wzfou.com/contact/)
- [**](https://wzfou.com/coffee/)

关于站长（Qi），8年前经常混迹于免费资源圈中，有幸结识了不少的草根站长。之后自己摸爬滚打潜心学习Web服务器、VPS、域名等，兴趣广泛，杂而不精，愿意将自己经验与心得分享出来，与大家共勉。

# 相关推荐

![raysync_00-223x120.jpg](../_resources/51915ce8b427687ddcea9daaf44b931f.jpg)

## [RaySync镭速云-超大文件传输加速服务可提升国外VPS上传下载速度](https://wzfou.com/raysync/)

- **2018年9月18日

![aapanel_00-223x120.gif](../_resources/110e1d1b6f05007dff18be1674be5e38.gif)

## [aaPanel宝塔免费VPS控制面板国际版-自动申请SSL多PHP版本共存](https://wzfou.com/aapanel/)

- **2018年9月9日

![freshrss_00-223x120.jpg](../_resources/bccbdab954b07075a8784641d460096a.jpg)

## [开源免费RSS订阅工具FreshRSS安装与使用-自建RSS在线订阅平台](https://wzfou.com/freshrss/)

- **2018年8月28日

![smokeping-onekey_00-223x120.jpg](../_resources/622ea4e202591cb133b00d8c6d297079.jpg)

## [网络监控工具:SmokePing Nginx一键安装/管理脚本和Looking Glass中文汉化](https://wzfou.com/smokeping-looking-glass/)

- **2018年10月25日

![paypal-account_00-223x120.jpg](../_resources/79b0f0a814672800a2a9307c7ef70c88.jpg)

## [Paypal通过Payoneer提现到国内银行全过程-新Paypal余额提现方法](https://wzfou.com/paypal-payoneer-tixian/)

- **2018年10月4日

![raysync_00-223x120.jpg](../_resources/51915ce8b427687ddcea9daaf44b931f.jpg)

## [RaySync镭速云-超大文件传输加速服务可提升国外VPS上传下载速度](https://wzfou.com/raysync/)

- **2018年9月18日

![aapanel_00-223x120.gif](../_resources/110e1d1b6f05007dff18be1674be5e38.gif)

## [aaPanel宝塔免费VPS控制面板国际版-自动申请SSL多PHP版本共存](https://wzfou.com/aapanel/)

- **2018年9月9日

![freshrss_00-223x120.jpg](../_resources/bccbdab954b07075a8784641d460096a.jpg)

## [开源免费RSS订阅工具FreshRSS安装与使用-自建RSS在线订阅平台](https://wzfou.com/freshrss/)

- **2018年8月28日

![smokeping-onekey_00-223x120.jpg](../_resources/622ea4e202591cb133b00d8c6d297079.jpg)

## [网络监控工具:SmokePing Nginx一键安装/管理脚本和Looking Glass中文汉化](https://wzfou.com/smokeping-looking-glass/)

- **2018年10月25日

![paypal-account_00-223x120.jpg](../_resources/79b0f0a814672800a2a9307c7ef70c88.jpg)

## [Paypal通过Payoneer提现到国内银行全过程-新Paypal余额提现方法](https://wzfou.com/paypal-payoneer-tixian/)

- **2018年10月4日

![raysync_00-223x120.jpg](../_resources/51915ce8b427687ddcea9daaf44b931f.jpg)

## [RaySync镭速云-超大文件传输加速服务可提升国外VPS上传下载速度](https://wzfou.com/raysync/)

- **2018年9月18日

.



已有 **98** 条评论

 [最新](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [最早](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [最佳](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)
.

1. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)lsfeng[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

博主你好，如果一个有好几段文字复合要求想合并到1个event里面输出要怎么做啊？

6月11日 22:44[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=6566#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

可以在mode中选择多个内容合并模式。

6月19日 17:41[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=6584#respond)

2. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)HA[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

您好最后一步遇到这个问题该怎么解决呢，我把名字改成yui了
$ heroku git:remote -a code-huginn

This is the legacy Heroku CLI. Please install the new CLI from [https://cli.heroku.com](https://wzfou.com/?r=https://cli.heroku.com)

▸ You do not have access to the app code-huginn.
cabox@box-codeanywhere:~/workspace/yui$ bin/setup_heroku

This is the legacy Heroku CLI. Please install the new CLI from [https://cli.heroku.com](https://wzfou.com/?r=https://cli.heroku.com)

Welcome @gmail.com! It looks like you’re logged into Heroku.
bin/setup_heroku:33:in `’: invalid byte sequence in US-ASCII (ArgumentError)
cabox@box-codeanywhere:~/workspace/yui$

6月10日 19:19[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=6561#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

看错误提示好像是组件没有安装好，你可能还需要安装CLI 这样的工具。

6月19日 17:45[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=6587#respond)

3. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)HA

博主您好，我把code-huginn改成yui了，但是到了“之后执行 heroku git:remote -a code-huginn。”这一步就出现下面的错误提示，该怎么解决呢

cabox@box-codeanywhere:~/workspace/yui$ heroku git:remote -a yui

This is the legacy Heroku CLI. Please install the new CLI from [https://cli.heroku.com](https://wzfou.com/?r=https://cli.heroku.com)

▸ You do not have access to the app yui.
cabox@box-codeanywhere:~/workspace/yui$ heroku git:remote -a code-huginn

This is the legacy Heroku CLI. Please install the new CLI from [https://cli.heroku.com](https://wzfou.com/?r=https://cli.heroku.com)

▸ You do not have access to the app code-huginn.
cabox@box-codeanywhere:~/workspace/yui$ bin/setup_heroku

This is the legacy Heroku CLI. Please install the new CLI from [https://cli.heroku.com](https://wzfou.com/?r=https://cli.heroku.com)

Welcome [sczan110@gmail.com](https://wzfou.cdn.bcebos.com/?r=mailto:sczan110@gmail.com)! It looks like you’re logged into Heroku.

bin/setup_heroku:33:in `’: invalid byte sequence in US-ASCII (ArgumentError)

6月10日 19:05[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=6560#respond)

4. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)ki1ler

打扰了 我也遇到绝对路径的问题 不知能否告知下怎么改成绝对路径？

[https://www.szyangxiao.com/197918.shtml](https://wzfou.com/?r=https://www.szyangxiao.com/197918.shtml)

5月24日 22:00[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=6513#respond)

5. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)emmmm[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

[原创 李叫兽传：他打架、失业，却成为百度最年轻的副总裁](https://wzfou.com/?r=article/2004698)
请问类似这样的网页源码，通过xpath获取的url只有artical/2004698而非正确的网页链接，请问应该怎样处理啊？

4月21日 00:13来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=6036#respond)

    - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)emmmm[收起回复](#)

发现直接变成有格式的文字，emmm，附链接http://www.gzhshoulu.wang/account_U_quan.html
附图
求解惑

4月21日 00:20来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=6037#respond)

        - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

网页用的是相对文本，可以修改一下事件中url，让它默认抓取全部链接。

4月21日 15:24[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=6040#respond)

            - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)emmmm

应该怎么改啊完全小白，不懂…

4月22日 11:18来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=6043#respond)

            - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)emmmm[收起回复](#)

多谢提点，解决了

4月30日 09:34来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=6143#respond)

                - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

好的，不客气。

4月30日 15:10[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=6146#respond)

6. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)itone
你好，感谢分享
有个问题，我设置了heroku config:set AGENT_LOG_LENGTH=20，RSS用来抓取gaoqing.la的更新，前面设置都没问题dry
run也正常，但是最后RSS输出的时候却倒序输出了20个电影，请问该怎么解决

4月19日 11:24[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=6006#respond)

7. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)zc039[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

不死心的再问一下，您说的是文章内显示图片有难度对吗？

4月17日 12:36来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5975#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

有些麻烦，因为图片不固定，所以不好用Xpath的方法来确定图片。

4月18日 16:36[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5995#respond)

        - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)zc039[收起回复](#)

谢谢站长^_^

4月18日 22:54来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=6002#respond)

            - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)zc039

上一句没把字打完，谢谢站长回复

4月18日 22:55来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=6003#respond)

8. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)zc039[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

你好，我按照步骤操作后发现没有rss输出。再次阅读文章后发现只有这一步没操作过
　　“dry run 时会提示你输入Event作为输入，这是要输入一个带url的event，否则当然没输出了。”
　　这一步的具体操作是什么啊？有点懵。。

　　这个图我在第二个rss中的options，这是我输出的rss链接https://g-rss.herokuapp.com/users/2/web_requests/13/kejimx.xml 麻烦大佬看一下原因

4月11日 10:37来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5902#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

代码没有问题，这段话的意思是要设置一个事件，否则就不会有结果。再检查一下xpath是不是有错误？

4月11日 12:36[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5905#respond)

        - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)zc039[收起回复](#)

我真的是黔驴技穷了能抽空帮忙看下这个文章的xpath吗？http://www.jintiankansha.me/t/yE0ihQXtjc 又试了几个还是没有输出

4月11日 19:45来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5917#respond)

            - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

我研究了一下，是想要这个页面的全部内容吗？还是第一步版块的内容？

4月12日 14:47[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5928#respond)

                - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)zc039[收起回复](#)

当时不知道为什么显示没有event，现在已经可以了，只是还不显示图片…
想要文章的文字和图片

我填的是//*[@id=”Main”]/div![two_org.gif](../_resources/c7812a4804b7fea946d5dad5f5326134.gif)/div![two_org.gif](../_resources/c7812a4804b7fea946d5dad5f5326134.gif)

按理说应该显示图片才对啊，您能帮忙看下可以显示图片的xpath吗？
还是说这个网站无法输出图片呢？
之前用feed43和feedex全文输出也是没有图片

4月14日 11:57[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5940#respond)

                    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

图片貌似有难度，主要是文章的第一张图片不固定，有时是第一个，有时又跑到后面去了。

4月16日 09:32[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5963#respond)

                        - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)zc039

谢谢回复

4月16日 18:10来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5973#respond)

9. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)jczai[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

再打扰一下，在2.1那一步中我明明 就是按教程做的啊，为什么没有event输出呢

4月4日 11:25来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5696#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

那应该是Xpath没有正确填写好。

4月5日 11:45[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5736#respond)

        - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)jczai

谢谢

4月7日 23:31来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5823#respond)

10. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)jczai[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

请问图三那里的invatation code怎么填啊

4月1日 10:12来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5644#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

这是哪里的？

4月2日 17:43[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5654#respond)

        - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)jczai[收起回复](#)

就是点击 open app 后点注册就这样了…想登录也没有找到账号

4月2日 19:09来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5661#respond)

            - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

默认的登录账号是：admin，密码是：password。不用注册。进入到Huginn修改密码即可。

4月3日 13:52[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5686#respond)

                - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)jczai

谢谢回复

4月3日 20:21来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=5691#respond)

11. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)Barry

好的，感谢楼主答复。

3月2日 20:14[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4999#respond)

12. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)Barry[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

抓取微信公众号生成RSS输出的scenarios是否已经失效，我创建完无法获取文章了。

2月27日 12:39[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4940#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

应该是失效了，微信那边对这些爬取工具做了限制。

2月28日 10:37[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4943#respond)

        - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)Barry[收起回复](#)

感谢楼主回复，那现在还要啥办法获取微信公众号的RSS？

3月2日 12:32[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4993#respond)

            - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

微信封得有些厉害，目前恐怕只能自己写爬虫了。

3月2日 20:13[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4997#respond)

13. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)Monkey[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

您好，在2.2中， mode选择“merge”，xpath就是本文的Xpath，value填入“.” ，請問“本文的xpath”是什麽?

2月17日 21:22[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4815#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

就是用chrome获取到的xpath路径。

2月21日 11:41[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4848#respond)

14. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)Monkey[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

请问，在workspace里执行 bash huginn.sh 提示 没有 huginn.sh应该如何操作？

2月17日 17:36[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4812#respond)

    - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)Monkey

.sh安裝在huginn的根目錄下。

2月17日 21:22[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4816#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

huginn.sh下载并保存了吗？

2月21日 11:43[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4850#respond)

15. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)hqi[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

尝试使用Huginn 的邮箱的时候，出现下面的错误
550 Unauthenticated senders not allowed
我查了一下，已经是用gmail邮箱的了，它还是有错误提示
请问，如何解决呢？谢谢

1月31日 21:22[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4617#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

是Huginn提示这样的错误吗？

2月2日 10:39[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4642#respond)

16. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)hqi[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

你好, 求教一下
我尝试做全文RSS输出,但是全文website agent 在 dry run 的时候没有输出结果

dry run 的时候,上面已经出现了 {url: xxx, title:xxx}的event data, 说明source的那个website agent已经抓取到东西了

url_from_event: {{url}} 也已经设置好了
我不知道是不是它不支持H5的格式呢?
我要弄的全文xpath里面有section / article 这样的tag, 然后最后是抓取到的东西是包含在一个div里面的,
e.g.

xpath: /html/body/section/div/div![two_org.gif](../_resources/c7812a4804b7fea946d5dad5f5326134.gif)/article/div

value: .
div里面就是全文的html,不过dry run 之后还是没有结果返回,

1月9日 18:06[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4231#respond)

    - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)hqi[收起回复](#)

好像是website agent里面有两个url , 重复了

1月9日 19:39[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4232#respond)

        - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

嗯，多试验几次就可以看到结果了。

1月9日 21:00[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4233#respond)

17. ![0a663c0fe8eb59bf341af61d4bb3e0c5](../_resources/59feb621b700277e7c6d97ddb1930250.jpg)游龙[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

你好，我已经配置好，抓取其它网站输出全文是正常了。用huginn有其它办法可以继续爬公众号麽？

1月9日 16:43[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4228#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

目前用搜狐微信搜索可以抓取微信的前几篇文章，还有一个微信公众号聚合平台倒是可以，搜狐微信有反爬虫策略，量大的话会被发现。

1月9日 21:09[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4236#respond)

18. ![0a663c0fe8eb59bf341af61d4bb3e0c5](../_resources/59feb621b700277e7c6d97ddb1930250.jpg)游龙[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

然后执行脚本 huginn.sh，命令：bash huginn.sh。执行完毕之后，进行如下操作即可：
你好,这一步可以详细点说明下在哪里执行吗

1月8日 20:25[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4219#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

是Heroku 的命令工具中操作，在线的。

1月9日 08:40[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4224#respond)

19. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)hqi[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

什么都没有改动过,突然间就出错了, herokuapp 页面显示的 Application error。请问你有遇到过这种情况吗？

2017年12月24日 23:16[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=3942#respond)

    - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)hqi[收起回复](#)

应该是运行时间已经超过了550个小时，请问如何”让网站每天只运行18小时”，在uptimerobot上设置吗？

2017年12月24日 23:23[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=3943#respond)

        - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

那只能是暂时关闭应用了，然后再开启了。

2017年12月25日 13:30[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=3955#respond)

            - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)hqi[收起回复](#)

所以只能人手每天去关闭一下应用再重启吗?
另外,请问一下,有什么将huginn 部署到vps的教程呢?谢谢

1月14日 10:15[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4315#respond)

                - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

1、只能手动停止了。2、有的，手动安装：https://wzfou.com/huginn/。

1月14日 20:55来自iPhone[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4326#respond)

                    - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)hqi[收起回复](#)

大概看了一下, 好像需要配置比较好一点的vps主机, 才可以部署huginn啊, 有什么推荐吗?

1月18日 18:15[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4405#respond)

                        - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

Linode的VPS性价比不错，适合跑这类的应用。

1月21日 20:06来自iPhone[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4461#respond)

                            - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)hqi[收起回复](#)

好的,谢谢. 我之前买的BWG VPS 被*了, ping不通 %也连接不上, 这个Linode会不会也这样呢?

1月24日 10:29[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4494#respond)

                                - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

Linode相对于搬来说价格要贵一些，滥用的少一些，QQ的机会要小一些。另外，被QQ了可以通过更换机房的方式来更换IP。

1月24日 14:10来自iPhone[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4500#respond)

20. ![ce191eaf0803ed04dabedacd815d965c](../_resources/a3a443916b682d2a7e08e2d6649e7bb4.jpg)xzymoe[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

看一遍又一遍 真心感觉老大写的就是经典啊！！！真心好用 哈哈

2017年12月24日 20:16[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=3933#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

哈哈，我也正在用。

2017年12月25日 13:31[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=3957#respond)

21. ![3e6474bc66bada5b4fbf582c607df755](../_resources/ea5b7ab12cae3835e66d4f49d956f493.png)[simondai](https://wzfou.com/?r=http://116.196.122.247)[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

vps 和 huginn 装好了，phantomjscloud的API Key也配上去了，下了个”微信公众号”改了配置，但跑出来是空值

2017年12月3日 18:00[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=3615#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

我研究了一下是腾讯搜狗那边限制了Huginn这类的爬虫。

2017年12月4日 09:29[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=3641#respond)

        - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)liutianyan[收起回复](#)

意思是，现在没办法避开反爬虫的问题么？我也是返回空

2017年12月28日 22:41[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4025#respond)

            - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

是的，除非自己写爬虫。

2017年12月29日 21:42[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=4039#respond)

22. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)hqi[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

你好啊,我有一个问题想请教一下.
“由于我们用的是自动安装，所以没有创建管理员用户”.
那用什么账号可以登录Huginn instance呢? 试过Heroku的账号是不行的

2017年11月23日 13:41[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=3448#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

用这个默认的：账号是：admin，密码是：password。

2017年11月24日 09:56[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=3451#respond)

        - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)hqi[收起回复](#)

请问,如何抓取需要登录的网站数据呢?比如,instagram. 谢谢

2017年12月13日 17:41[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=3797#respond)

            - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

需要登录的网站应该不行，要不然网站的数据都可能被人窃取了。

2017年12月13日 20:01[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=3798#respond)

23. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)gyaoshi[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

感谢作者，可是导入后微信公众号 #2 获取文章列表 Details 就运行不起来了哎。。

2017年11月19日 13:00[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=3395#respond)

    - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)gyaoshi

可以用可以用 原来要注册下phantomjscloud
再次感谢

2017年11月19日 13:25[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=3396#respond)

24. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)crazi[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

感谢Qi大，这篇文章得好好研究了，感觉功能很实用~另外是否可以出个打包整站的教程？期待ing

2017年9月15日 06:26[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2332#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

正在测试当中，Huginn手动安装确实麻烦。

2017年9月15日 08:43[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2338#respond)

        - ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)crazi[收起回复](#)

Qi大是否有推荐的win整站打包软件？现在科#*学#*上##*网形势越来越严峻，看到好文章好网站想全部打包，以防来不及学习就无法访问了

2017年9月15日 09:15来自iPhone[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2342#respond)

            - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

试试HTTrack，非常强大。

2017年9月15日 22:30[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2357#respond)

25. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)xx[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

再hero#ku上搭建似乎内存不够..抓不到文章列表..

2017年9月8日 14:24[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2195#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

任务设置少一些就好了。

2017年9月8日 15:49[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2196#respond)

26. ![c02ce80b976c8126ef859c14018d3eda](../_resources/509a0ae2b44ea6373a2d6101c3245dd2.jpg)[Richa](https://wzfou.com/?r=https://taky.me/)[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

最讨厌某些移动 app，特别是 UC，假装懂你的带浏览器功能的新闻客户端

2017年9月1日 20:46[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2014#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

小米手机的广告更恶心了。。。

2017年9月2日 13:38[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2028#respond)

        - ![c02ce80b976c8126ef859c14018d3eda](../_resources/509a0ae2b44ea6373a2d6101c3245dd2.jpg)[Richa](https://wzfou.com/?r=https://taky.me/)

便宜的代价

2017年9月2日 21:42来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2034#respond)

        - ![cfa53b7aba4f80ab9f8bce5c71d21358](../_resources/6c72c41a1b62b42932f8bc375275d010.jpg)[qiuyming](https://wzfou.com/?r=http://dvblog.win)[收起回复](#)

突然觉得好惋惜，那么好的金立被我玩机玩坏了

2017年9月15日 22:02[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2353#respond)

            - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

变砖了？

2017年9月17日 12:39[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2369#respond)

                - ![cfa53b7aba4f80ab9f8bce5c71d21358](../_resources/6c72c41a1b62b42932f8bc375275d010.jpg)[qiuyming](https://wzfou.com/?r=http://dvblog.win)[收起回复](#)

root之后系统升级不了了

2017年9月17日 15:56[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2374#respond)

                    - ![c02ce80b976c8126ef859c14018d3eda](../_resources/509a0ae2b44ea6373a2d6101c3245dd2.jpg)[Richa](https://wzfou.com/?r=https://taky.me/)

想要玩机当然选一加（OnePlus），性价比高，他们的手机在 XDA Developers 论坛非常受欢迎。其他手机厂家设置了不少障碍，并且不开放 device 树的源代码，也没有诸如 Lineage OS 这样的第三方 Android 系统的官方适配。

当然，说实话我觉得手机真的没啥好玩的，感觉有点浪费时间，我也折腾 Android 一段时间了，现在不再折腾了，保持官方固件并且无 root，享受厂家的服务。现在我偏向选择国际大厂的为中国大陆网络和应用环境做了优化的 Android 手机，比如三星、华为、HTC 等。

2017年9月17日 16:55来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2376#respond)

27. ![c02ce80b976c8126ef859c14018d3eda](../_resources/509a0ae2b44ea6373a2d6101c3245dd2.jpg)[Richa](https://wzfou.com/?r=https://taky.me/)[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

对于商人而言，RSS 主要无利可图，所以不太受欢迎。不过不知道从哪里看到一句话——“支持 RSS 是一种美德”。

2017年9月1日 20:44[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2013#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

哈哈，自古以来都是这样。 :-D

2017年9月7日 01:31[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2150#respond)

28. ![8952fd3d1e7b5aaf1bb81387cddb55c0](../_resources/9e28efbdf88420c13f87151e639fffda.jpg)en
收藏一下，以前有看过，但是不知道如何用。

2017年9月1日 16:42[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2010#respond)

29. ![d29b3f00eb0d324ce5039327767f2213](../_resources/8f1241daa3806c649d8ba6b6d1d18392.jpg)[薅羊毛](https://wzfou.com/?r=http://www.haoyangmao8.com)[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

好繁琐

2017年8月30日 22:37[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=1969#respond)

    - ![0e90d706f112a0b6a09be00472fc68f7](../_resources/fe696a8c1fa5e09a6d741c49b935a90c.jpg)[李毅哲](https://wzfou.com/?r=http://www.sztio.com)[收起回复](#)

感觉配置有些难度…

2017年9月1日 15:59[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2008#respond)

        - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

是有点复杂。

2017年9月1日 16:41[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2009#respond)

30. ![cfa53b7aba4f80ab9f8bce5c71d21358](../_resources/6c72c41a1b62b42932f8bc375275d010.jpg)[qiuyming](https://wzfou.com/?r=http://dvblog.win)[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

这玩意儿其实就是个爬虫
就是弄的插件化了
自己去gihub扒一下一大堆

2017年8月30日 22:36来自移动端[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=1968#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

有点类似，门槛稍微降低了一些。

2017年8月31日 09:26[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=1974#respond)

    - ![d29b3f00eb0d324ce5039327767f2213](../_resources/8f1241daa3806c649d8ba6b6d1d18392.jpg)[jisibencom](https://wzfou.com/?r=http://www.jisiben.com/)

求推荐几个啊，最好是通用一点的语言的，如PHP,PYTHON等。

2017年8月31日 20:22[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2005#respond)

31. ![28b4957da408ae7a0268f07fca72eb8a](../_resources/d61b084d387d04638fdb2e999af6e940.png)[iSwift Liu](https://wzfou.com/?r=http://xsage.cn/)[收起回复](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

可以试试https://perma.cc/，看看怎么样，能不能出个教程，感觉后续开发可以当做Evernote或者OneNote的网页裁剪功能

2017年8月30日 21:56[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=1966#respond)

    - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)[收起回复](#)

确实可以，也可以当成一个存档工具。

2017年8月31日 09:37[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=1975#respond)

        - ![c36d242f426805db6ee5672ce7448679](../_resources/f1aa8d7f88cf55ffdc361c720c3da8f1.jpg)[jiansing](https://wzfou.com/?r=https://iwpbk.com)[收起回复](#)

求出教程。这个工具只能每月存5条，真心太少了

2017年8月31日 13:06[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=1997#respond)

            - ![b87be896df439135e2972012a886b430](../_resources/d8e410f1b5fef7da1e5ad8995251f11c.jpg)[Qi](https://wzfou.com/?r=https://wzfou.com)(文章作者)

我也是第一次知道，我来看看，貌似自建的话要好一些。

2017年8月31日 17:55[*顶***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)  [*踩***](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#) [回复](https://wzfou.com/huginn-rss/?replytocom=2002#respond)

快捷登录:

- [微信](https://wzfou.com/wp-content/plugins/wp-connect/login.php?go=weixin&redirect_url=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F)

- [QQ](https://wzfou.com/wp-content/plugins/wp-connect/login.php?go=qzone&redirect_url=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F)

- [新浪微博](https://wzfou.com/wp-content/plugins/wp-connect/login.php?go=sina&redirect_url=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F)

- [Facebook](https://wzfou.com/wp-content/plugins/wp-connect/login.php?go=facebook&redirect_url=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F)

- [Twitter](https://wzfou.com/wp-content/plugins/wp-connect/login.php?go=twitter&redirect_url=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F)

- [Google](https://wzfou.com/wp-content/plugins/wp-connect/login.php?go=google&redirect_url=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F)

- [GitHub](https://wzfou.com/wp-content/plugins/wp-connect/login.php?go=github&redirect_url=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F)

- [更多>>](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)
- [帐号登录](https://wzfou.com/login/?redirect_to=https%3A%2F%2Fwzfou.com%2Fhuginn-rss%2F)

![d29b3f00eb0d324ce5039327767f2213](../_resources/8f1241daa3806c649d8ba6b6d1d18392.jpg)

- [表情](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

- [图片](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

.

-

- [发表评论](利用Huginn抓取任意网站RSS和微信公众号更新-打造一站式信息阅读平台%20-%20挖站否-挖掘建站的乐.md#)

.
 .