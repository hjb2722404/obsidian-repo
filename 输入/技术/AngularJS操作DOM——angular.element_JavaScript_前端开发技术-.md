AngularJS操作DOM——angular.element_JavaScript_前端开发技术-CSDN博客



- [![csdn-logo_.png](../_resources/1b686e04e16b8202e9e5bb6b022a283a.png)](https://www.csdn.net/)

- [首页](https://www.csdn.net/)

- [博客](https://blog.csdn.net/)

- [学院](https://edu.csdn.net/)

- [下载](https://download.csdn.net/)

- [论坛](https://bbs.csdn.net/)

- [问答](https://ask.csdn.net/)

- [活动](https://huiyi.csdn.net/)

- [专题](https://spec.csdn.net/)

- [招聘](http://job.csdn.net/)

- [APP](https://www.csdn.net/apps/download)

- [VIP会员](https://mall.csdn.net/vip)

 [![csdn-sou.png](../_resources/bacb45b477c8099b531dd8a91faccad3.png)]()

- [**  创作中心](https://mp.csdn.net/)

- [**](https://blog.csdn.net/blogdevteam/article/details/105203745)

- [登录/注册](https://passport.csdn.net/account/login)

# AngularJS操作DOM——angular.element

 原创  [那些年少的伤寂静微凉](https://me.csdn.net/FarmerXiaoYi)  最后发布于2018-03-23 10:23:30   阅读数 1039  [![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='icon js-evernote-checked' data-evernote-id='830'%3e %3cpath d='M1043.275294 379.241412a45.116235 45.116235 0 0 0-36.382118-30.72l-293.165176-42.646588L582.595765 40.237176C575.006118 24.816941 558.561882 17.106824 542.117647 17.106824s-32.888471 7.710118-40.478118 23.130352l-131.132235 265.637648-293.165176 42.646588a45.176471 45.176471 0 0 0-24.997647 77.040941l212.148705 206.787765-50.115764 292.020706a44.995765 44.995765 0 0 0 17.950117 44.15247c13.914353 10.24 32.406588 11.444706 47.585883 3.493647L542.117647 834.138353l262.204235 137.878588c15.179294 8.011294 33.731765 6.746353 47.585883-3.493647a44.875294 44.875294 0 0 0 17.950117-44.15247l-50.115764-292.020706 212.148706-206.787765a44.995765 44.995765 0 0 0 11.38447-46.320941z m-303.646118 204.92047a45.357176 45.357176 0 0 0-13.010823 39.996236l38.671059 225.099294-202.209883-106.37553a45.537882 45.537882 0 0 0-41.923764 0.060236L318.945882 849.317647l38.610824-225.099294a45.357176 45.357176 0 0 0-13.010824-39.996235L180.946824 424.658824l226.063058-32.828236a45.056 45.056 0 0 0 33.972706-24.69647L542.117647 162.273882l101.135059 204.860236c6.565647 13.312 19.275294 22.588235 33.972706 24.69647l226.063059 32.828236-163.659295 159.503058z' data-evernote-id='2525' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)收藏]()

 [展开]()

addClass()-为每个匹配的元素添加指定的样式类名
after()-在匹配元素集合中的每个元素后面插入参数所指定的内容，作为其兄弟节点
append()-在每个匹配元素里面的末尾处插入参数内容
attr() - 获取匹配的元素集合中的第一个元素的属性的值
bind() - 为一个元素绑定一个事件处理程序
children() - 获得匹配元素集合中每个元素的子元素，选择器选择性筛选
clone()-创建一个匹配的元素集合的深度拷贝副本
contents()-获得匹配元素集合中每个元素的子元素，包括文字和注释节点
css() - 获取匹配元素集合中的第一个元素的样式属性的值
data()-在匹配元素上存储任意相关数据
detach()-从DOM中去掉所有匹配的元素
empty()-从DOM中移除集合中匹配元素的所有子节点
eq()-减少匹配元素的集合为指定的索引的哪一个元素
find() - 通过一个选择器，jQuery对象，或元素过滤，得到当前匹配的元素集合中每个元素的后代
hasClass()-确定任何一个匹配元素是否有被分配给定的（样式）类
html()-获取集合中第一个匹配元素的HTML内容
next() - 取得匹配的元素集合中每一个元素紧邻的后面同辈元素的元素集合。如果提供一个选择器，那么只有紧跟着的兄弟元素满足选择器时，才会返回此元素
on() - 在选定的元素上绑定一个或多个事件处理函数
off() - 移除一个事件处理函数
one() - 为元素的事件添加处理函数。处理函数在每个元素上每种事件类型最多执行一次
parent() - 取得匹配元素集合中，每个元素的父元素，可以提供一个可选的选择器
prepend()-将参数内容插入到每个匹配元素的前面（元素内部）
prop()-获取匹配的元素集中第一个元素的属性（property）值
ready()-当DOM准备就绪时，指定一个函数来执行
remove()-将匹配元素集合从DOM中删除。（同时移除元素上的事件及 jQuery 数据。）
removeAttr()-为匹配的元素集合中的每个元素中移除一个属性（attribute）
removeClass()-移除集合中每个匹配元素上一个，多个或全部样式
removeData()-在元素上移除绑定的数据
replaceWith()-用提供的内容替换集合中所有匹配的元素并且返回被删除元素的集合
text()-得到匹配元素集合中每个元素的合并文本，包括他们的后代

toggleClass()-在匹配的元素集合中的每个元素上添加或删除一个或多个样式类,取决于这个样式类是否存在或值切换属性。即：如果存在（不存在）就删除（添加）一个类

triggerHandler() -为一个事件执行附加到元素的所有处理程序
unbind() - 从元素上删除一个以前附加事件处理程序
val()-获取匹配的元素集合中第一个元素的当前值
wrap()-在每个匹配的元素外层包上一个html元素

**以removeClass为例：**
HTML：
1
2
3
[object Object][object Object] [object Object]
[object Object][object Object][object Object] [object Object]
[object Object][object Object][object Object]
JS：
1
[object Object][object Object][object Object]

- [![](AngularJS%E6%93%8D%E4%BD%9CDOM%E2%80%94%E2%80%94angular.element_JavaScript_%E5%89%8D%E7%AB%AF%E5%BC%80%E5%8F%91%E6%8A%80%E6%9C%AF-.md# xmlns='http://www.w3.org/2000/svg' class='icon js-evernote-checked' aria-hidden='true' data-evernote-id='936'%3e %3cpath d='M609.79708437 520.42532183l-0.66304572 0.00422329c-23.32483876 0-42.23219094-18.90735218-42.23219021-42.23219093a42.13505648 42.13505648 0 0 1 14.35894472-31.72904483l0.02111579-0.02533907c35.50037964-37.58664979 44.84636338-133.21722277 44.84636337-188.77789362 0-13.24823794-12.38247819-41.34531469-42.12660988-41.34531469-24.6298137 0-42.4264591 21.19633634-42.4264591 39.82495581 0 68.73711416-27.05394131 132.25432857-64.35341251 181.61109043-21.33992637 28.24488932-60.29489915 62.13622224-95.22514419 70.6966875-9.80631471 2.40723514-16.53390272 5.71823896-23.43464237 12.85547906-6.50375749 6.72336471-10.6425121 17.31942123-11.09861976 25.24640385v261.06251061h421.4350324l38.55799058-287.17889752h-197.65932312v-0.01266989z m69.72534743-84.46438114h127.93397568c46.74258868 0 84.63331024 37.82315021 84.63331025 84.47705103 0 3.75021829-0.25339288 7.50043735-0.75173285 11.21686999l-38.55376727 287.17889749C847.15466648 860.77877158 811.29953694 892.08971773 768.90264021 892.08971773H347.4633845C300.71657253 892.08971773 262.83007428 854.2707908 262.83007428 807.61688924v-287.17889752c0-41.61137748 30.14533792-76.19954179 69.83092699-83.184746a0.60814355 0.60814355 0 0 1 0.31674168-0.10135775l0.32941084-0.01266916c0.88265295-0.1478126 1.76530592-0.28295601 2.65218217-0.40120622 1.05580461-0.19849147 2.1116092-0.4054288 2.7915474-0.47300013 44.53384503-4.23588907 118.60910769-74.94102243 118.60910844-180.12029467C457.3599918 176.00068954 525.49740827 131.91028227 584.00166244 131.91028227c36.91093488 0 77.44116871 17.55592165 96.35274343 47.45631255 18.91157474 29.90039089 25.71940399 70.91207143 25.719404 114.10293326 0 51.78511277-7.82984818 100.32256971-26.55137807 142.49141261zM174.14247323 440.18838242c23.32483876 0 42.23219094 18.91157474 42.23219093 42.23219095V849.85752677c0 23.32483876-18.90735218 42.23219094-42.23219093 42.23219096s-42.23219094-18.90735218-42.23219096-42.23219096V482.42057337c0-23.32483876 18.90735218-42.23219094 42.23219096-42.23219096z' data-evernote-id='2248' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)点赞](#)

- [![](AngularJS%E6%93%8D%E4%BD%9CDOM%E2%80%94%E2%80%94angular.element_JavaScript_%E5%89%8D%E7%AB%AF%E5%BC%80%E5%8F%91%E6%8A%80%E6%9C%AF-.md# xmlns='http://www.w3.org/2000/svg' class='icon js-evernote-checked' aria-hidden='true' data-evernote-id='941'%3e %3c/svg%3e)收藏](#)

- [![](AngularJS%E6%93%8D%E4%BD%9CDOM%E2%80%94%E2%80%94angular.element_JavaScript_%E5%89%8D%E7%AB%AF%E5%BC%80%E5%8F%91%E6%8A%80%E6%9C%AF-.md# xmlns='http://www.w3.org/2000/svg' class='icon js-evernote-checked' aria-hidden='true' data-evernote-id='945'%3e %3cpath d='M409.234286 556.690286a54.857143 54.857143 0 1 0 105.252571 30.793143c39.204571-134.070857 107.081143-270.701714 302.957714-303.689143l-47.542857 68.022857a54.857143 54.857143 0 0 0 89.892572 62.976l122.002285-174.153143a54.784 54.784 0 0 0-13.531428-76.434286L794.112 42.276571a54.857143 54.857143 0 0 0-62.902857 89.819429l64.292571 44.982857c-289.792 52.297143-361.179429 293.814857-386.267428 379.611429z' data-evernote-id='2527' class='js-evernote-checked'%3e%3c/path%3e%3cpath d='M937.910857 533.357714a58.514286 58.514286 0 0 0-58.514286 58.514286v246.052571a41.472 41.472 0 0 1-41.472 41.398858H186.002286a41.472 41.472 0 0 1-41.472-41.398858V186.075429c0-22.893714 18.578286-41.398857 41.472-41.398858h299.300571a58.514286 58.514286 0 1 0 0-117.028571H186.002286A158.72 158.72 0 0 0 27.501714 186.075429v651.849142a158.72 158.72 0 0 0 158.500572 158.427429h651.922285a158.72 158.72 0 0 0 158.500572-158.427429V591.872a58.514286 58.514286 0 0 0-58.514286-58.514286z' data-evernote-id='2528' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)分享](#)

- [![](data:image/svg+xml,%3csvg t='1575545411852' class='icon js-evernote-checked' viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='5717' xmlns:xlink='http://www.w3.org/1999/xlink' width='200' height='200' data-evernote-id='948'%3e%3cdefs data-evernote-id='949' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='950' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M179.176 499.222m-113.245 0a113.245 113.245 0 1 0 226.49 0 113.245 113.245 0 1 0-226.49 0Z' p-id='5718' data-evernote-id='951' class='js-evernote-checked'%3e%3c/path%3e%3cpath d='M509.684 499.222m-113.245 0a113.245 113.245 0 1 0 226.49 0 113.245 113.245 0 1 0-226.49 0Z' p-id='5719' data-evernote-id='952' class='js-evernote-checked'%3e%3c/path%3e%3cpath d='M846.175 499.222m-113.245 0a113.245 113.245 0 1 0 226.49 0 113.245 113.245 0 1 0-226.49 0Z' p-id='5720' data-evernote-id='953' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)]()

[![3_farmerxiaoyi](../_resources/86969ae7cb8d946951927428a627020c.png)  ![3.png](../_resources/810d6a9d14b0c761059e315833bc2a7b.png)](https://blog.csdn.net/FarmerXiaoYi)

[那些年少的伤寂静微凉](https://blog.csdn.net/FarmerXiaoYi)

发布了23 篇原创文章 · 获赞 27 · 访问量 9万+

 [私信](https://im.csdn.net/im/main.html?userName=FarmerXiaoYi)  [关注]()

           老中医说：饭后一件事，变成易瘦体质，想瘦多少就瘦多少！  华泰 · 猎媒
![1.png](../_resources/72c68b2d4b409a357128dcf86205ce26.png)

[![anonymous-User-img.png](AngularJS操作DOM——angular.element_JavaScript_前端开发技术-.md#)

[#### *AngularJS**操作**DOM*----*angular*.*element*   阅读数 5176](https://blog.csdn.net/gao_xu_520/article/details/78211967)

[AngularJs是不直接操作DOM的，但是在平时的开发当中，我们有的时候还是需要操作一些DOM的，如果使用原生的JS的话操作过于麻烦，所以大家一般都是使用jQuery，jQuery虽然好用，但是An...](https://blog.csdn.net/gao_xu_520/article/details/78211967)博文  [来自： 汉堡请不要欺负面条](https://blog.csdn.net/gao_xu_520)

[#### *angular*.*element*方法汇总(转)以及*AngularJS* 动态添加元素和删除元素   阅读数 9287](https://blog.csdn.net/litao8976/article/details/46345271)

[addClass()-为每个匹配的元素添加指定的样式类名after()-在匹配元素集合中的每个元素后面插入参数所指定的内容，作为其兄弟节点append()-在每个匹配元素里面的末尾处插入参数内容att...](https://blog.csdn.net/litao8976/article/details/46345271)博文  [来自： litao8976的博客](https://blog.csdn.net/litao8976)

[#### *angularJs*中的jqLite   阅读数 6](https://blog.csdn.net/weixin_30746117/article/details/96361555)

[方法描述addClass()为每个匹配的元素添加指定的样式类名after()在匹配元素集合中的每个元素后面插入参数所指定的内容，作为其兄弟节点append()在每个匹配元素里面的末尾处插入参数内容at...](https://blog.csdn.net/weixin_30746117/article/details/96361555)博文  [来自： weixin_30746117的博客](https://blog.csdn.net/weixin_30746117)

[#### *angularJS*——jquery.bower   阅读数 75](https://blog.csdn.net/weixin_40014283/article/details/78643243)

[jQuery在没有引入jQuery的前提下AngularJS实现了简版的jQuery Lite，通过angular.element不能选择元素，但可以将一个DOM元素转成jQuery对象，如果提前引入...](https://blog.csdn.net/weixin_40014283/article/details/78643243)博文  [来自： weixin_40014283的博客](https://blog.csdn.net/weixin_40014283)

[ ![u=3135234360,2335894100&fm=76](../_resources/0084c91be83cb759ece58714af6924a4.jpg)     人工智能时代，前端开发需要学习什么   前端培训开发]()

[![](../_resources/ef70fd150bfa82be362a4c2e422f0e5a.png)](http://mssp.baidu.com/)

[![](AngularJS操作DOM——angular.element_JavaScript_前端开发技术-.md#)

![1.png](../_resources/72c68b2d4b409a357128dcf86205ce26.png)

[#### *Angular*.*element*和$document的使用方法分析，代替jquery   阅读数 41](https://blog.csdn.net/weixin_34075268/article/details/93598785)

[AngularJs是不直接操作DOM的，但是在平时的开发当中，我们有的时候还是需要操作一些DOM的，如果使用原生的JS的话操作过于麻烦，所以大家一般都是使用jQuery，jQuery虽然好用，但是An...](https://blog.csdn.net/weixin_34075268/article/details/93598785)博文  [来自： weixin_34075268的博客](https://blog.csdn.net/weixin_34075268)

[#### 初踩*angularJs*   阅读数 40](https://blog.csdn.net/sinat_30961847/article/details/83857462)

[Angular.element和$document的使用方法分析，代替JqueryAngularJs是不直接操作DOM的，但是在平时的开发当中，我们有的时候还是需要操作一些DOM的，如果使用原生的JS...](https://blog.csdn.net/sinat_30961847/article/details/83857462)博文  [来自： 行进中的Blog](https://blog.csdn.net/sinat_30961847)

[#### *AngularJS*——第11章 其它   阅读数 6](https://blog.csdn.net/weixin_30654583/article/details/97093490)

[第11章 其它11.1jQuery在没有引入jQuery的前提下AngularJS实现了简版的jQuery Lite，通过angular.element不能选择元素，但可以将一个DOM元素转成jQue...](https://blog.csdn.net/weixin_30654583/article/details/97093490)博文  [来自： weixin_30654583的博客](https://blog.csdn.net/weixin_30654583)

[#### *AngularJS*系列——对象详解   阅读数 1775](https://blog.csdn.net/yingzizizizizizzz/article/details/71026043)

[1. angular对象   * 由angular.js提供的全局变量   * 方法:     * module(name, []) : 创建模型对象    * bootstrap(document,...](https://blog.csdn.net/yingzizizizizizzz/article/details/71026043)博文  [来自： yingzizizizizizzz的专栏](https://blog.csdn.net/yingzizizizizizzz)

[#### 学Python后到底能干什么？网友：我太难了   阅读数 6330](https://blog.csdn.net/CSDNedu/article/details/101296078)

[感觉全世界营销文都在推Python，但是找不到工作的话，又有哪个机构会站出来给我推荐工作？笔者冷静分析多方数据，想跟大家说：关于超越老牌霸主Java，过去几年间Python一直都被寄予厚望。但是事实是...](https://blog.csdn.net/CSDNedu/article/details/101296078)博文  [来自： CSDN学院](https://blog.csdn.net/CSDNedu)

 [#### *AngularJS**操作**DOM*---*angular*.*element*_汉堡请不要欺负面条-CSDN博客         1-3](https://blog.csdn.net/gao_xu_520/article/details/78211967)

 [#### *AngularJS**操作**DOM*——*angular*.*element* - Alfred的博客 - CSDN博客         11-11](https://blog.csdn.net/mingqingyuefeng/article/details/78076434)

[ ![u=2504109104,107235213&fm=76](../_resources/75a6a252a93a36dfefafe5f8820abe1b.jpg)     做一个小程序大概要多少钱   做一个小程序多少钱]()

[![](../_resources/ef70fd150bfa82be362a4c2e422f0e5a.png)](http://mssp.baidu.com/)

[![](AngularJS操作DOM——angular.element_JavaScript_前端开发技术-.md#)

![1.png](../_resources/72c68b2d4b409a357128dcf86205ce26.png)

[#### 大学四年自学走来，这些私藏的实用工具/学习网站我贡献出来了   阅读数 63万+](https://blog.csdn.net/m0_37907797/article/details/102781027)

[大学四年，看课本是不可能一直看课本的了，对于学习，特别是自学，善于搜索网上的一些资源来辅助，还是非常有必要的，下面我就把这几年私藏的各种资源，网站贡献出来给你们。主要有：电子书搜索、实用工具、在线视频...](https://blog.csdn.net/m0_37907797/article/details/102781027)博文  [来自： 帅地](https://blog.csdn.net/m0_37907797)

 [#### 在*Angularjs*中动态生成*dom*元素,如何动态编译 - CVJASBPTR的博客...         11-21](https://blog.csdn.net/CVJASBPTR/article/details/69372534?utm_source=blogxgwz7)

 [#### *AngularJS**操作**DOM*——*angular*.*element* - weixin_34315665的博客...         6-25](https://blog.csdn.net/weixin_34315665/article/details/93615057)

[#### 在中国程序员是青春饭吗？   阅读数 21万+](https://blog.csdn.net/harvic880925/article/details/102850436)

[今年，我也32了 ，为了不给大家误导，咨询了猎头、圈内好友，以及年过35岁的几位老程序员……舍了老脸去揭人家伤疤……希望能给大家以帮助，记得帮我点赞哦。目录：你以为的人生	一次又一次的伤害	猎头界的真...](https://blog.csdn.net/harvic880925/article/details/102850436)博文  [来自： 启舰](https://blog.csdn.net/harvic880925)

[![3_gao_xu_520](../_resources/820a9c4b3836d326379f883b9ca85085.png)](https://blog.csdn.net/gao_xu_520)关注

[##### 面条请不要欺负汉堡](https://blog.csdn.net/gao_xu_520)

303篇文章
排名:4000+

[![3_litao8976](../_resources/4522b769dc20d746d24a4365743a78f1.gif)](https://blog.csdn.net/litao8976)关注

[##### litao8976](https://blog.csdn.net/litao8976)

1篇文章
排名:千里之外

[![3_weixin_30746117](../_resources/68facc8e81d5fcf712049c137f29dfe9.gif)](https://blog.csdn.net/weixin_30746117)关注

[##### weixin_30746117](https://blog.csdn.net/weixin_30746117)

4500篇文章
排名:千里之外

[![3_weixin_40014283](../_resources/fb37cacf9e0305a07c26772424f893c0.png)](https://blog.csdn.net/weixin_40014283)关注

[##### 露lu](https://blog.csdn.net/weixin_40014283)

34篇文章
排名:千里之外

 [#### ...js浏览器控制台获取元素调试以及*angular*.*element*..._CSDN博客         1-11](https://blog.csdn.net/u011323200/article/details/89235005)

 [#### *angular*.*element*()方法的使用_JavaScript_jvid_sky的博客-CSDN博客         4-6](https://blog.csdn.net/jvid_sky/article/details/53286813)

[#### 超全Python图像处理讲解（多图预警）   阅读数 1万+](https://blog.csdn.net/ZackSock/article/details/103794134)

[文章目录Pillow模块讲解一、Image模块1.1 、打开图片和显示图片1.2、创建一个简单的图像1.3、图像混合（1）透明度混合（2）遮罩混合1.4、图像缩放（1）按像素缩放（2）按尺寸缩放1.5...](https://blog.csdn.net/ZackSock/article/details/103794134)博文  [来自： ZackSock的博客](https://blog.csdn.net/ZackSock)

[#### 为什么猝死的都是程序员，基本上不见产品经理猝死呢？   阅读数 13万+](https://blog.csdn.net/dfskhgalshgkajghljgh/article/details/103841693)

[相信大家时不时听到程序员猝死的消息，但是基本上听不到产品经理猝死的消息，这是为什么呢？我们先百度搜一下：程序员猝死，出现将近700多万条搜索结果：搜索一下：产品经理猝死，只有400万条的搜索结果，从搜...](https://blog.csdn.net/dfskhgalshgkajghljgh/article/details/103841693)博文  [来自： 曹银飞的专栏](https://blog.csdn.net/dfskhgalshgkajghljgh)

 [#### ng-click得到当前元素,*angular*.*element*()用法_JavaScript_IT部落...         4-16](https://blog.csdn.net/amohan/article/details/39249369)

 [#### 用*AngularJS**操作**DOM* - weixin_30791095的博客 - CSDN博客         9-16](https://blog.csdn.net/weixin_30791095/article/details/98357384)

[#### 毕业5年，我问遍了身边的大佬，总结了他们的学习方法   阅读数 16万+](https://blog.csdn.net/qq_35190492/article/details/103847147)

[我问了身边10个大佬，总结了他们的学习方法，原来成功都是有迹可循的。](https://blog.csdn.net/qq_35190492/article/details/103847147)博文  [来自： 敖丙](https://blog.csdn.net/qq_35190492)

[ ![u=105416829,3520078744&fm=76](../_resources/9d9f7c0913e48027f72b69e86a532be3.jpg)     网站WEB前端开发需要掌握什么技术   网站前端开发先做什么]()

[![](../_resources/ef70fd150bfa82be362a4c2e422f0e5a.png)](http://mssp.baidu.com/)

[![](AngularJS操作DOM——angular.element_JavaScript_前端开发技术-.md#)

![1.png](../_resources/72c68b2d4b409a357128dcf86205ce26.png)

 [#### 【*angularjs*】使用*angular*搭建项目,获取*dom*元素 - weix..._CSDN博客         10-31](https://blog.csdn.net/weixin_33971130/article/details/94458347)

[#### 推荐10个堪称神器的学习网站   阅读数 26万+](https://blog.csdn.net/qing_gee/article/details/103869737)

[每天都会收到很多读者的私信，问我：“二哥，有什么推荐的学习网站吗？最近很浮躁，手头的一些网站都看烦了，想看看二哥这里有什么新鲜货。”今天一早做了个恶梦，梦到被老板辞退了。虽然说在我们公司，只有我辞退老...](https://blog.csdn.net/qing_gee/article/details/103869737)博文  [来自： 沉默王二](https://blog.csdn.net/qing_gee)

[#### 强烈推荐10本程序员必读的书   阅读数 8万+](https://blog.csdn.net/qing_gee/article/details/104085756)

[很遗憾，这个春节注定是刻骨铭心的，新型冠状病毒让每个人的神经都是紧绷的。那些处在武汉的白衣天使们，尤其值得我们的尊敬。而我们这些窝在家里的程序员，能不外出就不外出，就是对社会做出的最大的贡献。有些读者...](https://blog.csdn.net/qing_gee/article/details/104085756)博文  [来自： 沉默王二](https://blog.csdn.net/qing_gee)

[#### 为什么说程序员做外包没前途？   阅读数 10万+](https://blog.csdn.net/kebi007/article/details/104164570)

[之前做过不到3个月的外包，2020的第一天就被释放了，2019年还剩1天，我从外包公司离职了。我就谈谈我个人的看法吧。首先我们定义一下什么是有前途	稳定的工作环境	不错的收入	能够在项目中不断...](https://blog.csdn.net/kebi007/article/details/104164570)博文  [来自： dotNet全栈开发](https://blog.csdn.net/kebi007)

[#### 柏林艺术家用行为艺术骇了一次谷歌地图   阅读数 1900](https://blog.csdn.net/leelight/article/details/104177747)

[用一辆装了99部智能手机的手拉车，一位柏林艺术家在一条空荡荡的街道上，骇了一次谷歌地图，成功地虚拟了大堵车。柏林艺术家Simon Weckert最近用Google地图的功能来代替路障和禁......](https://blog.csdn.net/leelight/article/details/104177747)博文  [来自： 德国IT那些事](https://blog.csdn.net/leelight)

[#### B 站上有哪些很好的学习资源?   阅读数 13万+](https://blog.csdn.net/JiuZhang_ninechapter/article/details/104197117)

[哇说起B站，在小九眼里就是宝藏般的存在，放年假宅在家时一天刷6、7个小时不在话下，更别提今年的跨年晚会，我简直是跪着看完的！！最早大家聚在在B站是为了追番，再后来我在上面刷欧美新歌和漂亮小姐姐的舞蹈视...](https://blog.csdn.net/JiuZhang_ninechapter/article/details/104197117)博文  [来自： 九章算法的博客](https://blog.csdn.net/JiuZhang_ninechapter)

           继发性闭经的4大原因:是否患有某些疾病  九龙妇产医院 · 猎媒
![1.png](../_resources/72c68b2d4b409a357128dcf86205ce26.png)

[#### 给新手程序员的一点学习建议   阅读数 3421](https://blog.csdn.net/zhangchangbin123/article/details/104205054)

[我是一个有几年经验的程序员，之前对于自己的发展却是一头雾水，不知道主流技术，不知道工作是迎合主流技术还是迎合公司发展。让我有感触的是这两年的坚持学习，在迎合公司的发展的前提下，有自己的学......](https://blog.csdn.net/zhangchangbin123/article/details/104205054)博文  [来自： JAVA圈的博客](https://blog.csdn.net/zhangchangbin123)

[#### 新来个技术总监，禁止我们使用Lombok！   阅读数 3万+](https://blog.csdn.net/hollis_chuang/article/details/104259307)

[我有个学弟，在一家小型互联网公司做Java后端开发，最近他们公司新来了一个技术总监，这位技术总监对技术细节很看重，一来公司之后就推出了很多"政策"，比如定义了很多开发规范、日志规范、甚至是要求大家统一...](https://blog.csdn.net/hollis_chuang/article/details/104259307)博文  [来自： HollisChuang's Blog](https://blog.csdn.net/hollis_chuang)

[#### 字节跳动的技术架构   阅读数 2万+](https://blog.csdn.net/Ture010Love/article/details/104272717)

[字节跳动创立于2012年3月，到目前仅4年时间。从十几个工程师开始研发，到上百人，再到200余人。产品线由内涵段子，到今日头条，今日特卖，今日电影等产品线。一、产品背景今日头条是为用户提供个性化资讯客...](https://blog.csdn.net/Ture010Love/article/details/104272717)博文  [来自： 作一个独立连续的思考者](https://blog.csdn.net/Ture010Love)

[#### 在三线城市工作爽吗？   阅读数 8万+](https://blog.csdn.net/qing_gee/article/details/104323806)

[我是一名程序员，从正值青春年华的 24 岁回到三线城市洛阳工作，至今已经 6 年有余。一不小心又暴露了自己的实际年龄，但老读者都知道，我驻颜有术，上次去看房子，业务员肯定地说：“小哥肯定比我小，我今年...](https://blog.csdn.net/qing_gee/article/details/104323806)博文  [来自： 沉默王二](https://blog.csdn.net/qing_gee)

[#### 这些插件太强了，Chrome 必装！尤其程序员！   阅读数 1万+](https://blog.csdn.net/qing_gee/article/details/104340125)

[推荐 10 款我自己珍藏的 Chrome 浏览器插件](https://blog.csdn.net/qing_gee/article/details/104340125)博文  [来自： 沉默王二](https://blog.csdn.net/qing_gee)

[#### 抱歉，我觉得程序员副业赚钱并不靠谱   阅读数 9489](https://blog.csdn.net/coderising/article/details/104386237)

[我最近看到不少关于程序员副业赚钱的文章，其中出的点子有这些：1. 在网上找项目做兼职2. 录制课程，到网上平台售卖，或者免费推广，赚广告费。3. 写付费的专栏文章4. 寻找漏洞，获取赏金......](https://blog.csdn.net/coderising/article/details/104386237)博文  [来自： 码农翻身](https://blog.csdn.net/coderising)

[#### @程序员：GitHub这个项目快薅羊毛   阅读数 1万+](https://blog.csdn.net/kebi007/article/details/104399183)

[今天下午在朋友圈看到很多人都在发github的羊毛，一时没明白是怎么回事。后来上百度搜索了一下，原来真有这回事，毕竟资源主义的羊毛不少啊，1000刀刷爆了朋友圈！不知道你们的朋友圈有没有看到类似的消息...](https://blog.csdn.net/kebi007/article/details/104399183)博文  [来自： dotNet全栈开发](https://blog.csdn.net/kebi007)

[#### 删库了，我们一定要跑路吗？   阅读数 1万+](https://blog.csdn.net/z694644032/article/details/104463920)

[在工作中，我们误删数据或者数据库，我们一定需要跑路吗？我看未必，程序员一定要学会自救，神不知鬼不觉的将数据找回。在 mysql 数据库中，我们知道 binlog 日志记录了我们对数据库的所有操作，所以...](https://blog.csdn.net/z694644032/article/details/104463920)博文  [来自： 平头哥的技术博文](https://blog.csdn.net/z694644032)

[#### “金三银四“，敢不敢“试”？   阅读数 5783](https://blog.csdn.net/wojiushiwo987/article/details/104471069)

[临近3月份，到了“金三银四”换工作的高峰期，往年可能会3、4月份，今年特殊，多方渠道了解有可能到5、6月份。关注咱们公众号的朋友，都了解本公众号3年多的时间基本都发一些Elastic S......](https://blog.csdn.net/wojiushiwo987/article/details/104471069)博文  [来自： 铭毅天下（公众号同名）](https://blog.csdn.net/wojiushiwo987)

[#### 又一程序员删库跑路了   阅读数 2万+](https://blog.csdn.net/loongggdroid/article/details/104509009)

[loonggg读完需要2分钟速读仅需 1 分钟今天刷爆朋友圈和微博的一个 IT 新闻，估计有很多朋友应该已经看到了。程序员删库跑路的事情又发生了，不是调侃，而是真实的事情。微盟官网发布公......](https://blog.csdn.net/loongggdroid/article/details/104509009)博文  [来自： 非著名程序员](https://blog.csdn.net/loongggdroid)

[#### 再不跳槽，应届毕业生拿的都比我多了！   阅读数 1万+](https://blog.csdn.net/JiuZhang_ninechapter/article/details/104541155)

[跳槽几乎是每个人职业生涯的一部分，很多HR说“三年两跳”已经是一个跳槽频繁与否的阈值了，可为什么市面上有很多程序员不到一年就跳槽呢？他们不担心影响履历吗？PayScale之前发布的**《员工最短任期公...](https://blog.csdn.net/JiuZhang_ninechapter/article/details/104541155)博文  [来自： 九章算法的博客](https://blog.csdn.net/JiuZhang_ninechapter)

[#### 我以为我学懂了数据结构，直到看了这个导图才发现，我错了   阅读数 1万+](https://blog.csdn.net/qq_38646470/article/details/104547401)

[数据结构与算法思维导图](https://blog.csdn.net/qq_38646470/article/details/104547401)博文  [来自： 龙跃十二](https://blog.csdn.net/qq_38646470)

[#### String s = new String(" a ") 到底产生几个对象？   阅读数 1万+](https://blog.csdn.net/qq_44543508/article/details/104560346)

[老生常谈的一个梗，到2020了还在争论，你们一天天的，哎哎哎，我不是针对你一个，我是说在座的各位都是人才！上图红色的这3个箭头，对于通过new产生一个字符串（”宜春”）时，会先去常量池中查找是否已经有...](https://blog.csdn.net/qq_44543508/article/details/104560346)博文  [来自： 宜春](https://blog.csdn.net/qq_44543508)

[#### 技术大佬：我去，你写的 switch 语句也太老土了吧   阅读数 3万+](https://blog.csdn.net/qing_gee/article/details/104586826)

[昨天早上通过远程的方式 review 了两名新来同事的代码，大部分代码都写得很漂亮，严谨的同时注释也很到位，这令我非常满意。但当我看到他们当中有一个人写的 switch 语句时，还是忍不住破口大骂：“...](https://blog.csdn.net/qing_gee/article/details/104586826)博文  [来自： 沉默王二](https://blog.csdn.net/qing_gee)

[#### 当年，非典SARS真的是我们战胜的吗？   阅读数 4460](https://blog.csdn.net/ityouknow/article/details/104624436)

[这里是小汤山医院。医院早拆了，只剩一片芦苇荒地，和四周悄然兴建的温泉别墅。原本不该存在小汤山医院，是2003年最痛的伤痕。这是最近突然火起来的国产记录片《非典十年祭》。记录了那一场完全意......](https://blog.csdn.net/ityouknow/article/details/104624436)博文  [来自： 纯洁的微笑](https://blog.csdn.net/ityouknow)

[#### 学历低，无法胜任工作，大佬告诉你应该怎么做   阅读数 1万+](https://blog.csdn.net/qing_gee/article/details/104628849)

[微信上收到一位读者小涛的留言，大致的意思是自己只有高中学历，经过培训后找到了一份工作，但很难胜任，考虑要不要辞职找一份他能力可以胜任的实习工作。下面是他留言的一部分内容：二哥，我是 2016 年高中毕...](https://blog.csdn.net/qing_gee/article/details/104628849)博文  [来自： 沉默王二](https://blog.csdn.net/qing_gee)

[#### 和黑客斗争的 6 天！   阅读数 3万+](https://blog.csdn.net/ityouknow/article/details/104666810)

[互联网公司工作，很难避免不和黑客们打交道，我呆过的两家互联网公司，几乎每月每天每分钟都有黑客在公司网站上扫描。有的是寻找 Sql 注入的缺口，有的是寻找线上服务器可能存在的漏洞，大部分都......](https://blog.csdn.net/ityouknow/article/details/104666810)博文  [来自： 纯洁的微笑](https://blog.csdn.net/ityouknow)

[#### 讲一个程序员如何副业月赚三万的真实故事   阅读数 7091](https://blog.csdn.net/loongggdroid/article/details/104687629)

[loonggg读完需要3分钟速读仅需 1 分钟大家好，我是你们的校长。我之前讲过，这年头，只要肯动脑，肯行动，程序员凭借自己的技术，赚钱的方式还是有很多种的。仅仅靠在公司出卖自己的劳动时......](https://blog.csdn.net/loongggdroid/article/details/104687629)博文  [来自： 非著名程序员](https://blog.csdn.net/loongggdroid)

[#### 一大波硕士即将来袭   阅读数 5627](https://blog.csdn.net/siyuanwai/article/details/104695955)

[前几天有一个读者朋友，也是程序员，在微信和我说：研究生扩招了，他要不要把专科学历提高一下？我查了一下新闻，确实：2020 年硕士研究生扩招 18.9 万人，扩招向临床医学、公共卫生、人工智能等专业倾向...](https://blog.csdn.net/siyuanwai/article/details/104695955)博文  [来自： siyuanwai的博客](https://blog.csdn.net/siyuanwai)

[#### 别再自己抠图了，Python用5行代码实现批量抠图   阅读数 3万+](https://blog.csdn.net/ZackSock/article/details/104738652)

[前言对于会PhotoShop的人来说，弄一张证件照还是非常简单的，但是还是有许多人不会PhotoShop的。今天就给你们带来一个非常简单的方法，用Python快速生成一个证件照，照片的底色随你选。实现...](https://blog.csdn.net/ZackSock/article/details/104738652)博文  [来自： ZackSock的博客](https://blog.csdn.net/ZackSock)

[#### 上班一个月，后悔当初着急入职的选择了   阅读数 1万+](https://blog.csdn.net/hejjunlin/article/details/104740320)

[最近有个老铁，告诉我说，上班一个月，后悔当初着急入职现在公司了。他之前在美图做手机研发，今年美图那边今年也有一波组织优化调整，他是其中一个，在协商离职后，当时捉急找工作上班，因为有房贷供着，不能没有收...](https://blog.csdn.net/hejjunlin/article/details/104740320)博文  [来自： 码农突围](https://blog.csdn.net/hejjunlin)

   [Java](https://java.csdn.net/)      [C语言](https://c1.csdn.net/)      [Python](https://python.csdn.net/)      [C++](https://cplus.csdn.net/)      [C#](https://csharp.csdn.net/)      [Visual Basic .NET](https://vbn.csdn.net/)      [JavaScript](https://js.csdn.net/)      [PHP](https://php.csdn.net/)      [SQL](https://sql.csdn.net/)      [Go语言](https://go.csdn.net/)      [R语言](https://r.csdn.net/)      [Assembly language](https://assembly.csdn.net/)      [Swift](https://swift.csdn.net/)      [Ruby](https://ruby.csdn.net/)      [MATLAB](https://matlab.csdn.net/)      [PL/SQL](https://plsql.csdn.net/)      [Perl](https://perl.csdn.net/)      [Visual Basic](https://vb.csdn.net/)      [Objective-C](https://obj.csdn.net/)      [Delphi/Object Pascal](https://delphi.csdn.net/)      [Unity3D](https://www.csdn.net/unity/)

 ©️2019 CSDN  皮肤主题: 大白   设计师: CSDN官方博客

 [![3_farmerxiaoyi](../_resources/86969ae7cb8d946951927428a627020c.png)  ![3.png](../_resources/810d6a9d14b0c761059e315833bc2a7b.png)](https://blog.csdn.net/FarmerXiaoYi)

   [那些年少的伤寂静微凉](https://blog.csdn.net/FarmerXiaoYi)

 [TA的个人主页 >](https://me.csdn.net/FarmerXiaoYi)

[原创](https://blog.csdn.net/farmerxiaoyi)
[23](https://blog.csdn.net/farmerxiaoyi)

粉丝
2

获赞
27

评论
8

访问
9万+

等级:

 [![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='icon icon-level js-evernote-checked' aria-hidden='true' data-evernote-id='811'%3e %3cpath d='M344.55439812 80.14660493h2375.19367285a107.96334877 107.96334877 0 0 1 107.96334876 107.96334877v647.7800926a107.96334877 107.96334877 0 0 1-107.96334876 107.96334877H344.55439812a107.96334877 107.96334877 0 0 1-107.96334877-107.96334877V188.1099537a107.96334877 107.96334877 0 0 1 107.96334877-107.96334877z' fill='%2374A828' data-evernote-id='1937' class='js-evernote-checked'%3e%3c/path%3e%3cpath d='M1910.02295523 134.12827933h809.72511574a53.98167438 53.98167438 0 0 1 53.98167437 53.98167437v647.7800926a53.98167438 53.98167438 0 0 1-53.98167437 53.98167437H1910.02295523V134.12827933z' fill='%232D5315' data-evernote-id='1938' class='js-evernote-checked'%3e%3c/path%3e%3cpath d='M2472.24209392 537.9112037h54.52149113v70.71599346h-54.52149113v97.70683061h-70.71599344V608.62719716h-244.53698495V542.22973766l248.85551889-224.56376543h66.3974595v220.24523147z m-70.71599344-109.04298225l-134.41436921 109.04298225h134.41436921V428.86822145zM984.83103798 419.09753838h-61.75503551v21.37674306h61.75503551v-21.37674306z m-61.80901717 85.45299056h61.75503549v-22.5643399h-61.75503549v22.5643399z m-125.88526465 0h62.3488339v-22.5643399h-62.3488339v22.5643399z m62.40281557-85.45299056h-62.34883391v21.37674306h62.34883391v-21.37674306z m0-46.37025829v-24.34573514H711.08996718V294.34588889h148.44960455V238.52883757h63.53643074v55.81705132h68.28681811c-16.03255729-7.71937945-33.84650985-15.43875887-47.50387346-21.37674306l26.1271304-39.1906956c24.93953356 8.90697627 60.56743866 23.75193674 79.56898804 32.658913l-17.22015412 27.90852566h40.37829243v54.03565606h-149.6372014v24.34573514h124.69766783v201.8914622h-62.94263232v-27.90852566h-61.75503551v26.72092881H859.53957173v-26.72092881h-62.34883391v35.62790509H736.62329916V372.72728009h122.91627257zM715.78637286 450.56885456H658.18792629v341.43409046H589.30730976V450.56885456H524.5832822V386.43862539h64.72402757V238.58281925H658.18792629v147.85580614h57.59844657v64.13022917zM1076.27599438 603.76884645v57.00464815h-71.8496086v67.09922126c0 30.28371932-5.34418577 44.53488137-27.31472725 54.03565606-20.78294463 8.31317785-49.28526871 8.90697627-89.06976272 8.90697628-2.37519368-17.81395255-10.68837152-40.37829243-18.40775097-56.41084974 24.34573514 0.59379843 51.06666396 1.18759683 58.7860434 0.59379842s10.09457311-2.37519368 10.09457313-8.90697628v-65.317826h-134.19844252c26.1271304 16.03255729 55.22325289 35.03410667 71.84960859 48.09767188l-39.19069559 47.50387345c-19.5953478-17.22015413-58.7860434-45.12867979-87.28836748-65.317826l27.31472724-30.28371933H695.65120831V603.76884645h242.86355306v-24.34573515h65.91162441V603.76884645h71.8496086z m225.04960051 3.50880883h195.35967958a736.84985533 736.84985533 0 0 1-101.53952951-39.78449401c-29.0961225 14.84496046-61.16123708 28.50232408-93.82015007 39.78449401z m-5.34418577 109.31289062h200.11006694v-51.06666396h-200.11006694v51.06666396z m32.658913-274.92866761l-2.96899209 2.37519366a325.50949652 325.50949652 0 0 0 70.06821335 48.69147029c25.53333198-15.43875887 48.6914703-32.06511458 67.69301967-51.06666395H1328.64032212z m194.7118995-55.87103299l48.09767188 28.50232407c-26.72092882 42.75348611-62.3488339 78.97518962-104.50852161 109.85270736 61.16123708 21.37674306 132.41704727 36.81550192 209.0170432 43.94108296-15.43875887 16.03255729-35.03410667 48.09767188-44.53488137 68.28681808a992.12919347 992.12919347 0 0 1-62.94263232-10.68837152v166.2635571h-72.44340702v-17.22015413h-200.11006694v18.40775097h-68.88061651v-163.29456501c-25.53333198 6.5317826-51.06666396 11.87596836-77.19379435 16.6263557-6.5317826-17.81395255-21.37674306-46.91007504-33.84650985-62.94263232 73.63100386-10.09457311 147.26200771-29.0961225 211.39223688-57.00464815a460.78757253 460.78757253 0 0 1-52.84805922-43.94108295c-21.37674306 14.25116203-45.7224782 27.31472724-72.44340703 39.78449402-10.09457311-16.62635571-31.47131616-41.56588927-46.91007503-52.84805921 82.53798014-30.87751775 137.16743461-74.81860069 166.26355709-118.75968366h-110.44650579v65.91162442h-69.47441493V286.62650945h220.89301158a1142.52213831 1142.52213831 0 0 0-19.59534781-38.59689718l70.66201178-17.22015413c8.90697627 17.22015413 20.78294463 37.40930035 30.28371933 55.81705131h207.23564795v130.04185358H1578.57547451V350.75673861h-247.02014197l66.50542283 13.65736363c-5.93798418 7.71937945-12.46976679 16.03255729-19.00154937 24.34573514h132.41704725l11.87596837-2.96899208z' fill='%23FFFFFF' data-evernote-id='1939' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)](https://blog.csdn.net/home/help.html#level)

周排名:
 [8万+](https://blog.csdn.net/rank/writing_rank)

积分:
1118

总排名:
 [8万+](https://blog.csdn.net/rank/writing_rank_total)

勋章:

 ![chizhiyiheng@120.png](../_resources/778c801456efdbb1f4616309e2ddf6cb.png)

 ![qixiebiaobing1@120.png](../_resources/ccbd60cbb0b70fbea63231235252333b.png)

 [关注]()

 [私信](https://im.csdn.net/im/main.html?userName=FarmerXiaoYi)

- [![u=3999260081,4172311933&fm=76](../_resources/d41edce19470106da286dc7ab9aaaece.jpg)](https://cpro.baidu.com/cpro/ui/uijs.php?en=mywWUA71T1YsFh7sT7qGujYsFhPC5H0huAbqrauGTdq9TZ0qnauJp1d9Phm3uhFBPvF9mHfzPvnvFh_qFRcYFRm1FRnvFRnkFRPKFRuDFRF7FRwDFRFAFRn4FRPKFRf1FRFaFR7AFhkdpvbqnBuVmLKV5H61rHfLFMDqmLPbUhF9pywdgvPsTBuzmWYkFMF15HDhTvN_UANzgv-b5HDhTv-b5ynvnWI9PAF9mWIhmhm3mHmhTLwGujYknHThIjdYTAP_pyPouyf1gv9WFMwb5Hnsn1cdnW6hIAd15HDdrjTsnWm4rjchIZRqIHnsn1cdnW6hIHdCIZwsTzR1fiRzwBRzwhF_UvT-nbNWTvw8FHF7UhNYFMNGUy-b5HTLfbm4fYDkrRPKwDf3PHRYnWmsrHT3f1f1nbc1wj77FMmqnBuG5HR1rHTsujcd&besl=-1&c=news&cf=1&cvrq=229059&eid_list=200197&expid=6588_200067_200197_200352_201548_203417_208749&fr=28&fv=0&haacp=236&img_typ=21030&itm=0&lu_idc=gzhxy&lukid=2&lus=c627a4bab7fbf8a6&lust=5e981c26&mscf=0&mtids=2000456510&n=10&nttp=1&p=baidu&pbs=228840&sce=7&sr=226&ssp2=1&tpl=baiduCustNativeADImageCarousel&tsf=dtp:1&u=%2Ffarmerxiaoyi%2Farticle%2Fdetails%2F79663872&uicf=lurecv&urlid=0&eot=1)
- [![u=2831974383,1619048283&fm=76](../_resources/b4b949cf3d98e6a630f45627e5e208dc.jpg)](https://cpro.baidu.com/cpro/ui/uijs.php?en=mywWUA71T1YsFh7sT7qGujYsFhPC5H0huAbqrauGTdq9TZ0qnauJp1d9Phm3uhFBPvF9mHfzPvnvFh_qFRFAFRn4FRPKFRf1FRFaFR7AFRPKFRuDFRF7FRwDFRPDFRFjFhkdpvbqnzuVmLKV5HT1n1RkFMDqmLPbUhF9pywdgvPsTBuzmWYkFMF15HDhTvN_UANzgv-b5HDhTv-b5ynvnWI9PAF9mWIhmhm3mHmhTLwGujYknHThIjdYTAP_pyPouyf1gv9WFMwb5Hnsn1cdnW6hIAd15HDdrjTsnWm4rjchIZRqIHnsn1cdnW6hIHdCIZwsTzR1fiRzwBRzwhF_UvT-nbNWTvw8FHF7UhNYFMNGUy-b5HTLfbm4fYDkrRPKwDf3PHRYnWmsrHT3f1f1nbc1wj77FMmqnBuG5yF9m10YnADd&besl=-1&c=news&cf=1&cvrq=177026&eid_list=200197&expid=6588_200067_200197_200352_201548_203417_208749&fr=28&fv=0&haacp=187&img_typ=21094&itm=0&lu_idc=gzhxy&lukid=3&lus=c627a4bab7fbf8a6&lust=5e981c26&mscf=0&mtids=2002052189&n=10&nttp=1&p=baidu&pbs=228840&sce=7&sr=226&ssp2=1&tpl=baiduCustNativeADImageCarousel&tsf=dtp:1&u=%2Ffarmerxiaoyi%2Farticle%2Fdetails%2F79663872&uicf=lurecv&urlid=0&eot=1)
- [![u=3743389737,1095704812&fm=76](../_resources/b8c7e52701b5eccaf008096e3abba985.jpg)](https://cpro.baidu.com/cpro/ui/uijs.php?en=mywWUA71T1YsFh7sT7qGujYsFhPC5H0huAbqrauGTdq9TZ0qnauJp1d9Phm3uhFBPvF9mHfzPvnvFh_qFRPaFRw7FRn4FRRkFRc4FRwjFRnsFRNDFRPAFRcdFRPDFRc1FhkdpvbqniuVmLKV5Hbkn16zFMDqmLPbUhF9pywdgvPsTBuzmWYkFMF15HDhTvN_UANzgv-b5HDhTv-b5ynvnWI9PAF9mWIhmhm3mHmhTLwGujYknHThIjdYTAP_pyPouyf1gv9WFMwb5Hnsn1cdnW6hIAd15HDdrjTsnWm4rjchIZRqIHnsn1cdnW6hIHdCIZwsTzR1fiRzwBRzwhF_UvT-nbNWTvw8FHF7UhNYFMNGUy-b5HTLfbm4fYDkrRPKwDf3PHRYnWmsrHT3f1f1nbc1wj77FMmqnBuG5HfsPvFhnhub&besl=-1&c=news&cf=1&cvrq=1646530&eid_list=200197&expid=6588_200067_200197_200352_201548_203417_208749&fr=28&fv=0&haacp=607&img_typ=4130&itm=0&lu_idc=gzhxy&lukid=1&lus=c627a4bab7fbf8a6&lust=5e981c26&mscf=0&mtids=2221452136&n=10&nttp=1&p=baidu&pbs=228840&sce=7&sr=226&ssp2=1&tpl=baiduCustNativeADImageCarousel&tsf=dtp:1&u=%2Ffarmerxiaoyi%2Farticle%2Fdetails%2F79663872&uicf=lurecv&urlid=0&eot=1)

[![](../_resources/ef70fd150bfa82be362a4c2e422f0e5a.png)](http://mssp.baidu.com/)

[![](AngularJS操作DOM——angular.element_JavaScript_前端开发技术-.md#)

 [大屏数据可视化](https://cpro.baidu.com/cpro/ui/uijs.php?en=mywWUA71T1YsFh7sT7qGujYsFhPC5H0huAbqrauGTdq9TZ0qnauJp1d9Phm3uhFBPvF9mHfzPvnvFh_qFRcYFRm1FRnvFRnkFRPKFRuDFRF7FRwDFRFAFRn4FRPKFRf1FRFaFR7AFhkdpvbqnBuVmLKV5H61rHfLFMDqmLPbUhF9pywdgvPsTBuzmWYkFMF15HDhTvN_UANzgv-b5HDhTv-b5ynvnWI9PAF9mWIhmhm3mHmhTLwGujYknHThIjdYTAP_pyPouyf1gv9WFMwb5Hnsn1cdnW6hIAd15HDdrjTsnWm4rjchIZRqIHnsn1cdnW6hIHdCIZwsTzR1fiRzwBRzwhF_UvT-nbNWTvw8FHF7UhNYFMNGUy-b5HTLfbm4fYDkrRPKwDf3PHRYnWmsrHT3f1f1nbc1wj77FMmqnBuG5HR1rHTsujcd&besl=-1&c=news&cf=1&cvrq=229059&eid_list=200197&expid=6588_200067_200197_200352_201548_203417_208749&fr=28&fv=0&haacp=236&img_typ=21030&itm=0&lu_idc=gzhxy&lukid=2&lus=c627a4bab7fbf8a6&lust=5e981c26&mscf=0&mtids=2000456510&n=10&nttp=1&p=baidu&pbs=228840&sce=7&sr=226&ssp2=1&tpl=baiduCustNativeADImageCarousel&tsf=dtp:1&u=%2Ffarmerxiaoyi%2Farticle%2Fdetails%2F79663872&uicf=lurecv&urlid=0&eot=1)

-
-
-
-

![1.png](../_resources/72c68b2d4b409a357128dcf86205ce26.png)

### 最新文章

- [Promise核心原理实现一个简单版promise](https://blog.csdn.net/FarmerXiaoYi/article/details/103260586)

- [简单理解js堆栈](https://blog.csdn.net/FarmerXiaoYi/article/details/102668336)

- [8种常见数据结构及其Javascript实现](https://blog.csdn.net/FarmerXiaoYi/article/details/102666486)

- [HTML DOM 事件](https://blog.csdn.net/FarmerXiaoYi/article/details/102506090)

- [DOM变动事件的用法](https://blog.csdn.net/FarmerXiaoYi/article/details/100695727)

### 归档

- [2019年11月1篇](https://blog.csdn.net/farmerxiaoyi/article/month/2019/11)

- [2019年10月3篇](https://blog.csdn.net/farmerxiaoyi/article/month/2019/10)

- [2019年9月1篇](https://blog.csdn.net/farmerxiaoyi/article/month/2019/09)

- [2019年1月1篇](https://blog.csdn.net/farmerxiaoyi/article/month/2019/01)

- [2018年12月1篇](https://blog.csdn.net/farmerxiaoyi/article/month/2018/12)

- [2018年9月1篇](https://blog.csdn.net/farmerxiaoyi/article/month/2018/09)

- [2018年8月4篇](https://blog.csdn.net/farmerxiaoyi/article/month/2018/08)

- [2018年7月2篇](https://blog.csdn.net/farmerxiaoyi/article/month/2018/07)

- [2018年3月2篇](https://blog.csdn.net/farmerxiaoyi/article/month/2018/03)

- [2018年1月2篇](https://blog.csdn.net/farmerxiaoyi/article/month/2018/01)

- [2017年9月1篇](https://blog.csdn.net/farmerxiaoyi/article/month/2017/09)

- [2017年8月13篇](https://blog.csdn.net/farmerxiaoyi/article/month/2017/08)

- [2017年7月7篇](https://blog.csdn.net/farmerxiaoyi/article/month/2017/07)

- [2017年6月2篇](https://blog.csdn.net/farmerxiaoyi/article/month/2017/06)

 [展开]()

### 热门文章

- [js实现图片预览的几种方式](https://blog.csdn.net/FarmerXiaoYi/article/details/73765799)

阅读数 17758

- [js Blob对象介绍](https://blog.csdn.net/FarmerXiaoYi/article/details/76994332)

阅读数 14622

- [最全原生AJAX请求步骤](https://blog.csdn.net/FarmerXiaoYi/article/details/74857035)

阅读数 12813

- [H5 FormData对象的作用及用法](https://blog.csdn.net/FarmerXiaoYi/article/details/76999187)

阅读数 12065

- [bootstrap日期控件的使用](https://blog.csdn.net/FarmerXiaoYi/article/details/74295470)

阅读数 10602

### 最新评论

- [bootstrap日期控件的使用](https://blog.csdn.net/farmerxiaoyi/article/details/74295470#comments)

...  [FarmerXiaoYi：](https://my.csdn.net/FarmerXiaoYi)[reply]zoepriselife316[/reply] 嗯嗯，能帮到你就好

- [bootstrap日期控件的使用](https://blog.csdn.net/farmerxiaoyi/article/details/74295470#comments)

...  [zoepriselife316：](https://my.csdn.net/zoepriselife316)不错，中文终于出来了，有用，谢谢！[code=javascript] language: 'zh-CN',//中文，需要引用zh-CN.js包 [/code]

- [js实现图片预览的几种方式](https://blog.csdn.net/farmerxiaoyi/article/details/73765799#comments)

...  [wrs120：](https://my.csdn.net/wrs120)感谢博主得分享

- [几步搞定less编译 安装nod...](https://blog.csdn.net/farmerxiaoyi/article/details/73369044#comments)

...  [qq_30960791：](https://my.csdn.net/qq_30960791)感谢

- [js实现图片预览的几种方式](https://blog.csdn.net/farmerxiaoyi/article/details/73765799#comments)

...  [weixin_39673166：](https://my.csdn.net/weixin_39673166)不兼容ie10以下的版本

![1.png](../_resources/72c68b2d4b409a357128dcf86205ce26.png)

![](data:image/svg+xml,%3csvg width='16' height='16' xmlns='http://www.w3.org/2000/svg' data-evernote-id='2731' class='js-evernote-checked'%3e%3cpath d='M2.167 2h11.666C14.478 2 15 2.576 15 3.286v9.428c0 .71-.522 1.286-1.167 1.286H2.167C1.522 14 1 13.424 1 12.714V3.286C1 2.576 1.522 2 2.167 2zm-.164 3v1L8 10l6-4V5L8 9 2.003 5z' fill='%23999AAA' fill-rule='evenodd' data-evernote-id='2732' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)[kefu@csdn.net](https://blog.csdn.net/farmerxiaoyi/article/details/79663872mailto:webmaster@csdn.net)  *![](data:image/svg+xml,%3csvg t='1538013544186' width='17' height='17' style='' viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23556' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='2735' class='js-evernote-checked'%3e%3cdefs data-evernote-id='2736' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='2737' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M902.60033922 650.96445566c-18.0718526-100.84369837-94.08399771-166.87723736-94.08399771-166.87723737 10.87530062-91.53186599-28.94715402-107.78733693-28.94715401-107.78733691C771.20003413 93.08221664 517.34798062 98.02553561 511.98620441 98.16348824 506.65661791 98.02553561 252.75857992 93.08221664 244.43541101 376.29988138c0 0-39.79946279 16.25547094-28.947154 107.78733691 0 0-75.98915247 66.03353901-94.0839977 166.87723737 0 0-9.63372291 170.35365477 86.84146124 20.85850523 0 0 21.70461757 56.79068296 61.50407954 107.78733692 0 0-71.1607951 23.19910867-65.11385185 83.46161052 0 0-2.43717093 67.16015592 151.93232126 62.56172014 0 0 108.5460788-8.0932473 141.10300432-52.14626271H526.33792324c32.57991817 44.05301539 141.10300431 52.1462627 141.10300431 52.14626271 154.3235077 4.59843579 151.95071457-62.56172013 151.95071457-62.56172014 6.00095876-60.26250183-65.11385185-83.46161053-65.11385185-83.46161052 39.77647014-50.99665395 61.4810877-107.78733693 61.4810877-107.78733692 96.45219231 149.49514952 86.84146124-20.85850523 86.84146125-20.85850523' p-id='23557' fill='%23999AAA' data-evernote-id='2738' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)[QQ客服](https://url.cn/5epoHIm?_type=wpa&qidian=true)*

*![](data:image/svg+xml,%3csvg t='1538012951761' width='17' height='17' style='' viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23083' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='2742' class='js-evernote-checked'%3e%3cdefs data-evernote-id='2743' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='2744' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M466.4934485 880.02006511C264.6019863 859.18313878 107.13744214 688.54706608 107.13744214 481.14947309 107.13744214 259.68965394 286.68049114 80.14660493 508.14031029 80.14660493s401.00286817 179.54304901 401.00286814 401.00286816v1.67343191C908.30646249 737.58941724 715.26799489 943.85339507 477.28978337 943.85339507c-31.71423369 0-62.61874229-3.67075386-92.38963569-10.60739903 30.09478346-11.01226158 56.84270313-29.63593923 81.5933008-53.22593095z m-205.13036267-398.87059202a246.77722444 246.77722444 0 0 0 493.5544489 0 30.85052691 30.85052691 0 0 0-61.70105383 0 185.07617062 185.07617062 0 0 1-370.15234125 0 30.85052691 30.85052691 0 0 0-61.70105382 0z' p-id='23084' fill='%23999AAA' data-evernote-id='2745' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)[客服论坛](http://bbs.csdn.net/forums/Service)*  ![](data:image/svg+xml,%3csvg t='1538013874294' width='17' height='17' style='' viewBox='0 0 1194 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' p-id='23784' xmlns:xlink='http://www.w3.org/1999/xlink' data-evernote-id='2747' class='js-evernote-checked'%3e%3cdefs data-evernote-id='2748' class='js-evernote-checked'%3e%3cstyle type='text/css' data-evernote-id='2749' class='js-evernote-checked'%3e%3c/style%3e%3c/defs%3e%3cpath d='M1031.29689505 943.85339507h-863.70679012A71.98456279 71.98456279 0 0 1 95.60554212 871.86883228v-150.85178906c0-28.58329658 16.92325492-54.46750945 43.13135785-65.93861527l227.99160176-99.75813425c10.55341735-4.61543317 18.24580594-14.0082445 20.72896295-25.23643277l23.21211998-105.53417343a71.95757195 71.95757195 0 0 1 70.28414006-56.51881307h236.95255971c33.79252817 0 63.02360485 23.5090192 70.28414004 56.51881307l23.21211997 105.53417343c2.48315701 11.25517912 10.17554562 20.62099961 20.72896296 25.23643277l227.99160177 99.75813425a71.98456279 71.98456279 0 0 1 43.13135783 65.93861527v150.85178906A71.98456279 71.98456279 0 0 1 1031.26990421 943.85339507z m-431.85339506-143.94213475c143.94213474 0 143.94213474-48.34058941 143.94213474-107.96334876s-64.45411922-107.96334877-143.94213474-107.96334877c-79.51500637 0-143.94213474 48.34058941-143.94213475 107.96334877s0 107.96334877 143.94213475 107.96334876zM1103.254467 296.07330247v148.9894213a35.97878598 35.97878598 0 0 1-44.15700966 35.03410667l-143.94213473-33.57660146a36.0057768 36.0057768 0 0 1-27.80056231-35.03410668V296.1002933c-35.97878598-47.98970852-131.95820302-71.98456279-287.91126031-71.98456279S347.53801649 248.11058478 311.53223967 296.1002933v115.385829c0 16.73431906-11.52508749 31.25538946-27.80056233 35.03410668l-143.94213473 33.57660146A35.97878598 35.97878598 0 0 1 95.63253297 445.06272377V296.07330247C162.81272673 152.13116772 330.77670658 80.14660493 599.47049084 80.14660493s436.63077325 71.98456279 503.81096699 215.92669754z' p-id='23785' fill='%23999AAA' data-evernote-id='2750' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)400-660-0108

工作时间 8:30-22:00

[关于我们](https://www.csdn.net/company/index.html#about)[招聘](https://www.csdn.net/company/index.html#recruit)[广告服务](https://www.csdn.net/company/index.html#advertisement)  [网站地图](https://www.csdn.net/gather/A)

[京ICP备19004658号](http://beian.miit.gov.cn/publish/query/indexFirst.action)[经营性网站备案信息](https://csdnimg.cn/cdn/content-toolbar/csdn-ICP.png)

![gongan.png](../_resources/d0289dc0a46fc5b15b3363ffa78cf6c7.png)[公安备案号 11010502030143](http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010502030143)

©1999-2020 北京创新乐知网络技术有限公司 [网络110报警服务](http://www.cyberpolice.cn/)

[北京互联网违法和不良信息举报中心](http://www.bjjubao.org/)

[中国互联网举报中心](http://www.12377.cn/)[家长监护](https://download.csdn.net/index.php/tutelage/)

[版权与免责声明](https://www.csdn.net/company/index.html#statement)[版权申诉](https://blog.csdn.net/blogdevteam/article/details/90369522)