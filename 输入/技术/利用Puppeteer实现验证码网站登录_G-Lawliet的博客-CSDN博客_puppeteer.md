利用Puppeteer实现验证码网站登录_G-Lawliet的博客-CSDN博客_puppeteer 验证码![1.png](../_resources/72c68b2d4b409a357128dcf86205ce26.png)

### 目录

1. [Puppeteer](https://blog.csdn.net/ghaohao/article/details/80731437#t0)
2. [流程](https://blog.csdn.net/ghaohao/article/details/80731437#t1)
3. [架构](https://blog.csdn.net/ghaohao/article/details/80731437#t2)
4. [示例](https://blog.csdn.net/ghaohao/article/details/80731437#t3)

# 利用Puppeteer实现验证码网站登录

 ![original.png](../_resources/8f19bb4e9750fc1d08da69d6a9ac56cd.png)

 [G-罗](https://me.csdn.net/ghaohao)  2018-06-19 13:00:53  ![articleReadEyes.png](../_resources/c4360f77d43b7f3fdc7b1e070f32dfd4.png)  5463  [![tobarCollect.png](../_resources/5dad7f82dd0d8ba01fecbf11a059a7cd.png)  收藏   1]()

 分类专栏：  [爬虫](https://blog.csdn.net/ghaohao/category_7484838.html)

 [版权]()

## Puppeteer

[puppeteer](https://github.com/GoogleChrome/puppeteer)是由Google官方推出的一个node库，可以启动Chromium浏览器模拟人为操作，类似于PhantomJS。这为爬虫和自动化测试提供了便利。

## 流程

登录流程很简单：启动puppeteer打开目标网站，输入信息提交登录
![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231121040.png)

## 架构

由于puppeteer是基于node的库，可以利用node做一个http服务。
1. 调用方发起http请求，puppeteer创建page实例打开目标网站，返回验证码等信息
2. 新生成的page会维护在一个对象池中，并由一个watcher监控page打开超时
3. 调用方传递登录账号验证码等信息发起登录请求
4. 从puppeteer对象池中拿出上一次的page实例，执行登录
![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231121044.png)

## 示例

模拟登录[浙江税务局](http://etax.zjtax.gov.cn/dzswj/user/login.html)
puppeteer对象：

**const **puppeteer = require('puppeteer')**class **PageObject { constructor(options = {}) { **this**.headless = options.headless;  **this**.args = options.args || [];  **this**.executablePath = options.executablePath;  **this**.browser = **null**;  **this**.page = **null**;  } async init() { **this**.browser = await puppeteer.*launch*({ headless: **this**.headless,  executablePath: **this**.executablePath,  ignoreHTTPSErrors: **true**,  args: **this**.args  }) **this**.page = await **this**.browser.newPage()

} async close() {
await **this**.browser.close()
}
}
module.exports = PageObject
脚本：

**var **express = require('express');**var **router = express.Router();**const **puppeteer_path = '/app/chrome/Chromium';**var **PageObject = require('pageobject');pageObject = **new **PageObject({ executablePath : puppeteer_path,  headless : **false**});router.get('/login', (req, res, next) => {

(async() => { await pageObject.init();  await pageObject.page.setJavaScriptEnabled(**true**);  await pageObject.page.setViewport({ width:1024,  height:768  });  **var **bufferImg;  await pageObject.page.on('response', response => { **if **(response.url().indexOf('kaptcha.jpg') > 0){ response.buffer().then(**function **(value) {

bufferImg = value;  });  }

});  await pageObject.page.goto('http://etax.zjtax.gov.cn/dzswj/user/login.html');  await pageObject.page.waitForSelector('#username');  await pageObject.close()

res.send({ img : bufferImg.toString('base64')
});  })();})
router.post('/submit', (req, res, next) => {

(async() => { await pageObject.page.type('#username', req.body.loginName);  await pageObject.page.type('#password', req.body.loginPwd);  await pageObject.page.type('#vcode', req.body.loginCode);  await delay(1000);  **var **result = await pageObject.page.evaluate(() => document.querySelector(".bootbox-body"));  **if **(result == **null**){

res.send({ status : 'success'  });  await pageObject.page.click('#loginBtn1');  }

})();})**function **delay(timeout) { **return new **Promise((resolve) => { setTimeout(resolve, timeout);  });}

module.exports = router;
启动nodejs，就可以对外提供http服务了

[#### winfrom中嵌套html，跟html的交互](https://download.csdn.net/download/kimizhou_blog/3534567)08-20

[winfrom中嵌套html，跟html的交互,源码就在里面一看就懂，很简单](https://download.csdn.net/download/kimizhou_blog/3534567)

[#### GIS程序设计教程 基于ArcGIS Engine的C#开发实例](https://download.csdn.net/download/zzahkj/6970699)02-27

[张丰，杜震洪，刘仁义编著.GIS程序设计教程 基于ArcGIS Engine的C#开发实例.浙江大学出版社,2012.05](https://download.csdn.net/download/zzahkj/6970699)

[![anonymous-User-img.png](利用Puppeteer实现验证码网站登录_G-Lawliet的博客-CSDN博客_puppeteer.md#)

- [![3_m0_37089544](../_resources/4447f59f57276150ca828a5bba3457c8.png)](https://me.csdn.net/m0_37089544)

 [Kevin-March](https://me.csdn.net/m0_37089544):我研究出来了 直接去我博客吧 https://blog.csdn.net/m0_370895442年前

![](../_resources/895b98e96a4ba71d646477427a8e2645.png)

- [![3_m0_37089544](../_resources/4447f59f57276150ca828a5bba3457c8.png)](https://me.csdn.net/m0_37089544)

 [Kevin-March](https://me.csdn.net/m0_37089544):1231231232年前
![](../_resources/895b98e96a4ba71d646477427a8e2645.png)

- [![3_m0_37089544](../_resources/4447f59f57276150ca828a5bba3457c8.png)](https://me.csdn.net/m0_37089544)

 [Kevin-March](https://me.csdn.net/m0_37089544):1231231232年前
![](../_resources/895b98e96a4ba71d646477427a8e2645.png)

- [![3_m0_37089544](../_resources/4447f59f57276150ca828a5bba3457c8.png)](https://me.csdn.net/m0_37089544)

 [Kevin-March](https://me.csdn.net/m0_37089544):adfadsfads f2年前
![](../_resources/895b98e96a4ba71d646477427a8e2645.png)

- [![3_m0_37089544](../_resources/4447f59f57276150ca828a5bba3457c8.png)](https://me.csdn.net/m0_37089544)

 [Kevin-March](https://me.csdn.net/m0_37089544):!!!!!2年前
![](../_resources/895b98e96a4ba71d646477427a8e2645.png)

- [![3_m0_37089544](../_resources/4447f59f57276150ca828a5bba3457c8.png)](https://me.csdn.net/m0_37089544)

 [Kevin-March](https://me.csdn.net/m0_37089544):您好 具体能说说这俩怎么用怎么启动么2年前
![](../_resources/895b98e96a4ba71d646477427a8e2645.png)

登录 查看 6 条热评![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='icon open js-evernote-checked' aria-hidden='true' data-evernote-id='1927'%3e%3cpath d='M917.33333327 623.189333l332.394667-333.525333a52.906667 52.906667 0 0 1 75.136 0 53.461333 53.461333 0 0 1 0 75.392L956.80000027 734.4a52.864 52.864 0 0 1-39.445334 15.530667 52.672 52.672 0 0 1-39.424-15.530667L509.82400027 365.056a53.418667 53.418667 0 0 1 0-75.392 52.949333 52.949333 0 0 1 75.114666 0L917.33333327 623.189333z m0 0' fill='' data-evernote-id='2523' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

[#### 获取Linux下Ftp目录树并逐步绑定到treeview](https://download.csdn.net/download/mqlccl2008/4359987)06-08

[在linux下抓取目录树，双击后获取该节点子节点（逐步生成）。另外有两个类，一个是windows下的（一次性获取目录树），一个是linux下的（足部获取目录树）](https://download.csdn.net/download/mqlccl2008/4359987)

[小朱的专栏](https://blog.csdn.net/w20101310)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)4127

#### [nodejs识别*验证码*，图片*验证码*](https://blog.csdn.net/w20101310/article/details/90081383)

[最近做自动化遇到*验证码*的问题，之前识别字母和数字*验证码*都是使用tesseract.js,识别率都不错，中文也可以识别不过识别率不高。我自己平常使用识别*验证码*的方式主要有三种，一种是上面说的tesseract.js，另一种骚操作就是使用通用文字识别工具，即OCR，很多云计算公司都提供了OCR识别。还有一种就是用node去调用Python的*验证码*识别程序不过这次遇到的*验证码*字母都进行了扭......](https://blog.csdn.net/w20101310/article/details/90081383)

#### [*Puppeteer* PK 滑动*验证码*_1024小神的博客-CSDN博客_*puppeteer*...](https://blog.csdn.net/weixin_44786530/article/details/90136822)

7-14

[当我们把 WebDriver 和 *Puppeteer* 放在一起的时候,还是有必要说明一下这二者的区别。WebDriver 标准2,可以远程的操控目标浏览器。标准是语言无关、平台无关的。](https://blog.csdn.net/weixin_44786530/article/details/90136822)

#### [关于*验证码*--*Puppeteer* - weixin_33722405的博客 - CSDN博客](https://blog.csdn.net/weixin_33722405/article/details/91121830)

6-16

[*利用**Puppeteer**实现**验证码**网站**登录* 阅读数 2381 *Puppeteer**puppeteer*是由Google官方推出的一个node库,可以启动Chromium浏览器模拟人为操作,类似于PhantomJS。*登录*... 博文...](https://blog.csdn.net/weixin_33722405/article/details/91121830)

[cayre的专栏](https://blog.csdn.net/oPINGU)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)5万+

#### [ADT下载地址（含各版本），最新ADT-23.0.6](https://blog.csdn.net/oPINGU/article/details/29624477)

[ （ADT不分32或64位）2015/05/07新增ADT-23.0.6.zip2015/01/18新增ADT-23.0.3.zipADT-23.0.4.zip ADT百度云下载链接（含各版本）： 链接:https://pan.baidu.com/s/1qSWOlX43IRsQKMVdAKM2Zg密码:smy6  官网各版本下载链接： ...](https://blog.csdn.net/oPINGU/article/details/29624477)

[weixin_33709219的博客](https://blog.csdn.net/weixin_33709219)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)793

#### [*利用**puppeteer*破解极验的滑动验证](https://blog.csdn.net/weixin_33709219/article/details/87991109)

[上一篇文章写了一个*puppeteer*的简单入门，出于好奇想了一个问题，*puppeteer*能破解*验证码*吗？？？于是，正好就拿前端网来试试 （纯粹出于学习）基本的流程：1. 打开前端网，点击*登录*。2. 填写账号，密码。3. 点解验证按钮，通过滑动验证，最后成功登陆。代码*实现*：github上可以checkout。run.jsconst *puppeteer* = require('puppe......](https://blog.csdn.net/weixin_33709219/article/details/87991109)

#### [淘宝*验证码*识别_*puppeteer*滑动*验证码*,*puppeteer**验证码*-其它代码类...](https://download.csdn.net/download/hlx371240/8342357)

8-14

[本资源包括*验证码*识别的图像处理和算法部分程序,还有matlabGUI和MFC制作的demo。*puppeteer*滑动*验证码*更多下载资源、学习资料请访问CSDN下载频道.](https://download.csdn.net/download/hlx371240/8342357)

#### [*puppeteer*破解阿里h5滑动*验证码*_阳光下的小树-CSDN博客](https://blog.csdn.net/u013356254/article/details/88564342)

8-13

[突破了这两个点,滑动*验证码*就可以很轻松的绕过了。 1 2 效果 话不多说,直接上代码。 var *puppeteer* = require('*puppeteer*') const devices = require('...](https://blog.csdn.net/u013356254/article/details/88564342)

[#### 移相法5倍细分电路](https://download.csdn.net/download/wu52300/10466337)06-08

[可用于模拟正余弦信号的，使用运放对信号进行高倍细，已经搭建好仿真电路，可以直接运行仿真测试。](https://download.csdn.net/download/wu52300/10466337)

[YOYO的博客](https://blog.csdn.net/wu0che28)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)1742

#### [反爬虫之网易易盾分析](https://blog.csdn.net/wu0che28/article/details/103050970)

[本文制作研究使用,切勿非法使用.易盾有无痕验证,滑动验证,点击验证三个,今天分析的是无痕验证,通过检测浏览器的环境,确定用户使用的的客户端情况,在不需要用户任何点击的情况下,与服务器后台通信,校验用户端的环境,返回一个validate,应用于*登录*,注册等操作,使用于大部分的网易产品中.具有代表性.如果客户端没有通过检测,那么就会返回空的validate,并且弹出滑动*验证码*:首先还是抓包:......](https://blog.csdn.net/wu0che28/article/details/103050970)

#### [爬虫实战之*puppeteer*破解阿里h5滑动*验证码*_ZHH_Love123..._CSDN博客](https://blog.csdn.net/zhh_love123/article/details/88567702)

7-27

[突破了这两个点,滑动*验证码*就可以很轻松的绕过了。 阅读流程 效果 代码 滑动中的两个关键点 总结 效果 代码 话不多说,直接上代码。 var *puppeteer* = ...](https://blog.csdn.net/zhh_love123/article/details/88567702)

#### [使用node+*puppeteer*破解*验证码*_weixin_33998125的博客..._CSDN博客](https://blog.csdn.net/weixin_33998125/article/details/87954215)

6-10

[现在我就以一种情况为例,来看下怎么用node+*puppeteer*高效的破解滑块*验证码*。 之前有一兄弟在掘金上写过用*puppeteer*破解滑块*验证码*, 接下来我们就用一些另外的思路...](https://blog.csdn.net/weixin_33998125/article/details/87954215)

[JerremyZhang的博客](https://blog.csdn.net/JerremyZhang)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)933

#### [基于*puppeteer*模拟*登录*抓取页面](https://blog.csdn.net/JerremyZhang/article/details/86163477)

[基于*puppeteer*模拟*登录*抓取页面 2018-05-08 19:49 by JerremyZhang, ... 阅读, ... 评论, 收藏, 编辑 关于热图在*网站*分析行业中，*网站*热图能够很好的反应用户在*网站*的操作行为，具体分析用户的喜好，对*网站*进行针对性的优化，一个热图的例子（来源于ptengine）上图中能很清晰的看到......](https://blog.csdn.net/JerremyZhang/article/details/86163477)

[IT安全单身狗的博客](https://blog.csdn.net/w97531)
![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png)255

#### [网易易盾*验证码*的核心指标和系统兼容性认知大全](https://blog.csdn.net/w97531/article/details/81203679)

[网易易盾*验证码*的核心指标如下1. 接口可靠性后端接口稳定性 99.99%2. 服务性能1） 单用户场景下，易盾*验证码*检测接口平均响应时间为 4 毫秒2）负载场景下,易盾*验证码*检测接口单机能够达到最大 TPS 为 2347.84 笔/秒，平均响应时间在 53.87 毫秒。—— 数据取自【易盾*验证码* V2.0 检测性能测试 报告】3. 功能性指标1） 拦截准确率99.99......](https://blog.csdn.net/w97531/article/details/81203679)

#### [*puppeteer* 教程(11) ---进阶(*puppeteer* 处理淘宝滑块*验证码*)](https://blog.csdn.net/mengxiangxingdong/article/details/102558074)

8-14

[log("淘宝--滑块*验证码*不存在"); console.log(e); }) // 计算滑块距离 const rect = await page.evaluate((slide_btn) => { const {top, left, ...](https://blog.csdn.net/mengxiangxingdong/article/details/102558074)

#### [...http接口调用_m0_37089544的博客-CSDN博客_*puppeteer*  *验证码*登陆](https://blog.csdn.net/m0_37089544/article/details/81362235)

6-17

[接上一篇,本人是java,但是为了项目 研究了一段时间的nodejs和*puppeteer*,就是用http服务提供爬虫服务,这个爬虫服务调用的是*puppeteer*,有*验证码*的可以调用*验证码*服务...](https://blog.csdn.net/m0_37089544/article/details/81362235)

 ©️2020 CSDN  皮肤主题: 大白   设计师: CSDN官方博客     [返回首页](https://blog.csdn.net/)

 [关于我们](https://www.csdn.net/company/index.html#about)  [招聘](https://www.csdn.net/company/index.html#recruit)  [广告服务](https://www.csdn.net/company/index.html#advertisement)  [网站地图](https://www.csdn.net/gather/A)  *  ![](data:image/svg+xml,%3csvg width='16' height='16' xmlns='http://www.w3.org/2000/svg' data-evernote-id='2844' class='js-evernote-checked'%3e%3cpath d='M2.167 2h11.666C14.478 2 15 2.576 15 3.286v9.428c0 .71-.522 1.286-1.167 1.286H2.167C1.522 14 1 13.424 1 12.714V3.286C1 2.576 1.522 2 2.167 2zm-.164 3v1L8 10l6-4V5L8 9 2.003 5z' fill='%23999AAA' fill-rule='evenodd' data-evernote-id='2845' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  [kefu@csdn.net](https://blog.csdn.net/ghaohao/article/details/80731437mailto:webmaster@csdn.net)![](data:image/svg+xml,%3csvg t='1538012951761' width='17' height='17' style='' viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23083' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='2846' class='js-evernote-checked'%3e%3cdefs data-evernote-id='2847' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='2848' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M466.4934485 880.02006511C264.6019863 859.18313878 107.13744214 688.54706608 107.13744214 481.14947309 107.13744214 259.68965394 286.68049114 80.14660493 508.14031029 80.14660493s401.00286817 179.54304901 401.00286814 401.00286816v1.67343191C908.30646249 737.58941724 715.26799489 943.85339507 477.28978337 943.85339507c-31.71423369 0-62.61874229-3.67075386-92.38963569-10.60739903 30.09478346-11.01226158 56.84270313-29.63593923 81.5933008-53.22593095z m-205.13036267-398.87059202a246.77722444 246.77722444 0 0 0 493.5544489 0 30.85052691 30.85052691 0 0 0-61.70105383 0 185.07617062 185.07617062 0 0 1-370.15234125 0 30.85052691 30.85052691 0 0 0-61.70105382 0z' p-id='23084' fill='%23999AAA' data-evernote-id='2849' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  [客服论坛](http://bbs.csdn.net/forums/Service)![](data:image/svg+xml,%3csvg t='1538013874294' width='17' height='17' style='' viewBox='0 0 1194 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23784' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='2850' class='js-evernote-checked'%3e%3cdefs data-evernote-id='2851' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='2852' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M1031.29689505 943.85339507h-863.70679012A71.98456279 71.98456279 0 0 1 95.60554212 871.86883228v-150.85178906c0-28.58329658 16.92325492-54.46750945 43.13135785-65.93861527l227.99160176-99.75813425c10.55341735-4.61543317 18.24580594-14.0082445 20.72896295-25.23643277l23.21211998-105.53417343a71.95757195 71.95757195 0 0 1 70.28414006-56.51881307h236.95255971c33.79252817 0 63.02360485 23.5090192 70.28414004 56.51881307l23.21211997 105.53417343c2.48315701 11.25517912 10.17554562 20.62099961 20.72896296 25.23643277l227.99160177 99.75813425a71.98456279 71.98456279 0 0 1 43.13135783 65.93861527v150.85178906A71.98456279 71.98456279 0 0 1 1031.26990421 943.85339507z m-431.85339506-143.94213475c143.94213474 0 143.94213474-48.34058941 143.94213474-107.96334876s-64.45411922-107.96334877-143.94213474-107.96334877c-79.51500637 0-143.94213474 48.34058941-143.94213475 107.96334877s0 107.96334877 143.94213475 107.96334876zM1103.254467 296.07330247v148.9894213a35.97878598 35.97878598 0 0 1-44.15700966 35.03410667l-143.94213473-33.57660146a36.0057768 36.0057768 0 0 1-27.80056231-35.03410668V296.1002933c-35.97878598-47.98970852-131.95820302-71.98456279-287.91126031-71.98456279S347.53801649 248.11058478 311.53223967 296.1002933v115.385829c0 16.73431906-11.52508749 31.25538946-27.80056233 35.03410668l-143.94213473 33.57660146A35.97878598 35.97878598 0 0 1 95.63253297 445.06272377V296.07330247C162.81272673 152.13116772 330.77670658 80.14660493 599.47049084 80.14660493s436.63077325 71.98456279 503.81096699 215.92669754z' p-id='23785' fill='%23999AAA' data-evernote-id='2853' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  400-660-0108  ![](data:image/svg+xml,%3csvg t='1538013544186' width='17' height='17' style='' viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23556' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='2854' class='js-evernote-checked'%3e%3cdefs data-evernote-id='2855' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='2856' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M902.60033922 650.96445566c-18.0718526-100.84369837-94.08399771-166.87723736-94.08399771-166.87723737 10.87530062-91.53186599-28.94715402-107.78733693-28.94715401-107.78733691C771.20003413 93.08221664 517.34798062 98.02553561 511.98620441 98.16348824 506.65661791 98.02553561 252.75857992 93.08221664 244.43541101 376.29988138c0 0-39.79946279 16.25547094-28.947154 107.78733691 0 0-75.98915247 66.03353901-94.0839977 166.87723737 0 0-9.63372291 170.35365477 86.84146124 20.85850523 0 0 21.70461757 56.79068296 61.50407954 107.78733692 0 0-71.1607951 23.19910867-65.11385185 83.46161052 0 0-2.43717093 67.16015592 151.93232126 62.56172014 0 0 108.5460788-8.0932473 141.10300432-52.14626271H526.33792324c32.57991817 44.05301539 141.10300431 52.1462627 141.10300431 52.14626271 154.3235077 4.59843579 151.95071457-62.56172013 151.95071457-62.56172014 6.00095876-60.26250183-65.11385185-83.46161053-65.11385185-83.46161052 39.77647014-50.99665395 61.4810877-107.78733693 61.4810877-107.78733692 96.45219231 149.49514952 86.84146124-20.85850523 86.84146125-20.85850523' p-id='23557' fill='%23999AAA' data-evernote-id='2857' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)[QQ客服（8:30-22:00）](https://url.cn/5epoHIm?_type=wpa&qidian=true)  *

 [公安备案号 11010502030143](http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010502030143)  [京ICP备19004658号](http://beian.miit.gov.cn/publish/query/indexFirst.action)  [京网文〔2020〕1039-165号](https://csdnimg.cn/release/live_fe/culture_license.png)  [版权与免责声明](https://www.csdn.net/company/index.html#statement)  [版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522)  [网络110报警服务](http://www.cyberpolice.cn/)

 [中国互联网举报中心](http://www.12377.cn/)  [家长监护](https://download.csdn.net/index.php/tutelage/)  [版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522)  [北京互联网违法和不良信息举报中心](http://www.bjjubao.org/)  [©1999-2020 北京创新乐知网络技术有限公司]()