php中计算中文字符串长度、截取中文字符串 - wish123 - 博客园

## [php中计算中文字符串长度、截取中文字符串](http://www.cnblogs.com/wish123/archive/2011/08/09/2132150.html)

 2011-08-09 13:15 by wish123, 25959 阅读, 6 评论, [收藏](http://www.cnblogs.com/wish123/archive/2011/08/09/2132150.html#), [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=2132150)

在做PHP开发的时候，由于我国的语言环境问题，所以我们常常需要对中文进行处理。在PHP中，我们都知道有专门的mb_substr和mb_strlen函数，可以对中文进行截取和计算长度，但是，由于这些函数并非PHP的核心函数，所以，它们常常有可能没有开启。当然，如果是用的自己的服务器，则只要在php.ini中开启即可。如果是用的虚拟主机，而服务器又没有开启这方面的函数的话，那就需要我们自己写出点适合咱国情的函数来了。

以下几个函数用起来颇为顺手的。不过要知道，得在utf-8环境下使用。
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
[object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]  [object Object][object Object][object Object]
[object Object]

[object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object]
[object Object][object Object]
[object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]
[object Object][object Object]  [object Object]

[object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object]

[object Object][object Object]
[object Object]
[object Object]  [object Object][object Object][object Object]
[object Object]  [object Object][object Object][object Object]
[object Object][object Object][object Object][object Object]

[object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]

[object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object]
[object Object][object Object]
[object Object][object Object]  [object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object]  [object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]
[object Object][object Object]  [object Object]
[object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]

[object Object][object Object]
[object Object][object Object]  [object Object]
[object Object][object Object]  [object Object][object Object][object Object]

[object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object][object Object]
[object Object][object Object]  [object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]
[object Object][object Object]  [object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]
[object Object][object Object]
[object Object]
[object Object]  [object Object][object Object][object Object]
[object Object]  [object Object][object Object]
[object Object]  [object Object][object Object][object Object][object Object]
支持gb2312,gbk,utf-8,big5 中文截取方法
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
[object Object]

[object Object]

[object Object]

[object Object]

[object Object]

[object Object]

[object Object]

[object Object]

[object Object]

[object Object]  [object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object]

[object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]

[object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]  [object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]

[object Object][object Object]

[object Object][object Object]

[object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]  [object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]

[object Object][object Object][object Object][object Object][object Object][object Object]  [object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object]

[object Object]

 [好文要顶](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)  [关注我](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)  [收藏该文](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)  [![icon_weibo_24.png](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)  [![wechat.png](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)

 [![u321159.jpg](../_resources/6d82d867bafff17cddd4f968199c0868.jpg)](http://home.cnblogs.com/u/wish123/)

 [wish123](http://home.cnblogs.com/u/wish123/)
 [关注 - 2](http://home.cnblogs.com/u/wish123/followees)
 [粉丝 - 23](http://home.cnblogs.com/u/wish123/followers)

 [+加关注](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)

 3

 0

[»](http://www.cnblogs.com/wish123/archive/2011/08/10/2133302.html) 下一篇：[移动开发，如何选择手机软件开发​平台？](http://www.cnblogs.com/wish123/archive/2011/08/10/2133302.html)

- 分类: [php](http://www.cnblogs.com/wish123/category/314917.html)

-

[Add your comment](http://www.cnblogs.com/wish123/archive/2011/08/09/2132150.html#comment_tip)

###

1.

##### [#1楼](http://www.cnblogs.com/wish123/archive/2011/08/09/2132150.html#2265761)  [aseadan](http://www.cnblogs.com/aseadan/)  [ ](http://msg.cnblogs.com/send/aseadan)  2011-12-09 11:10

谢谢
[支持(0)](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)[反对(0)](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)

2.

##### [#2楼](http://www.cnblogs.com/wish123/archive/2011/08/09/2132150.html#2606172)  [w3cc](http://www.cnblogs.com/weiyu/)  [ ](http://msg.cnblogs.com/send/w3cc)  2013-01-23 23:14

感谢啊
[支持(0)](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)[反对(0)](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)

3.

##### [#3楼](http://www.cnblogs.com/wish123/archive/2011/08/09/2132150.html#2963331)  [ateast](http://www.cnblogs.com/ateast/)  [ ](http://msg.cnblogs.com/send/ateast)  2014-06-13 06:25

有点错误，代码重新手写了一下就好了，不知道是哪个"{"有问题，可能是格式问题
[支持(0)](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)[反对(0)](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)

4.

##### [#4楼](http://www.cnblogs.com/wish123/archive/2011/08/09/2132150.html#2996546)  [老榕树下的咖啡屋](http://www.cnblogs.com/qing-chen/)  [ ](http://msg.cnblogs.com/send/%E8%80%81%E6%A6%95%E6%A0%91%E4%B8%8B%E7%9A%84%E5%92%96%E5%95%A1%E5%B1%8B)  2014-07-29 11:38

找来找去 还就你的挺好用~ 点个赞~~
[支持(0)](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)[反对(0)](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)

5.

##### [#5楼](http://www.cnblogs.com/wish123/archive/2011/08/09/2132150.html#3001695)  [yulyfish](http://home.cnblogs.com/u/310049/)  [ ](http://msg.cnblogs.com/send/yulyfish)  2014-08-06 12:36

网上找了N多cn_substr都不行,代码格式,源代码,好不容易不报错了,结果还是按字节来的,还是你这个好,简单,而且有效果,谢谢
[支持(0)](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)[反对(0)](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)

6.

##### [#6楼](http://www.cnblogs.com/wish123/archive/2011/08/09/2132150.html#3282756)  [mmmoniter](http://home.cnblogs.com/u/821361/)  [ ](http://msg.cnblogs.com/send/mmmoniter)  2015-10-12 10:42

abslength("0");
输出 为0

我把empty($str) 改为$str=="" 就正常了
[支持(0)](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)[反对(0)](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)

[刷新评论](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)[刷新页面](http://www.cnblogs.com/wish123/archive/2011/08/09/2132150.html#)[返回顶部](http://www.cnblogs.com/wish123/archive/2011/08/09/2132150.html#top)

注册用户登录后才能发表评论，请 [登录](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#) 或 [注册](php中计算中文字符串长度、截取中文字符串%20-%20wish123%20-%20博客园.md#)，[访问](http://www.cnblogs.com/)网站首页。

[【推荐】50万行VC++源码: 大型组态工控、电力仿真CAD与GIS源码库](http://www.ucancode.com/index.htm)

[【活动】与金山云一起改变云计算](https://activity.ksyun.com/1702/index.html?ch=00033.00005.0011702&hmsr=cnblog&hmpl=1702&hmcu=&hmkw=&hmci=)

[【抢】大学生专享｜9.9元即刻拥有一台云服务器](http://click.aliyun.com/m/12746/)

**最新IT新闻**:
· [Facebook Stories更新：几乎是Snapchat的翻版](http://news.cnblogs.com/n/565958/)
· [微软Ignite 2017将于9月25日开幕 现已开放注册](http://news.cnblogs.com/n/565957/)
· [深度揭密SSD中的原片/白片/黑片](http://news.cnblogs.com/n/565955/)
· [癌症患者的福音：一管血就能测癌？这是真的](http://news.cnblogs.com/n/565954/)
· [亚马逊推出新服务 15分钟让用户自提生鲜杂货](http://news.cnblogs.com/n/565953/)
» [更多新闻...](http://news.cnblogs.com/)

[![24442-20170118152220281-363324784.jpg](../_resources/2ab148d53c37ad62681ac47af89ffece.jpg)](http://bbs.h3bpm.com/index.php?m=app&app=product_download&a=reg&utm_source=csdn&utm_medium=pic&utm_campaign=show&utm_content=v10&utm_term=%E5%85%8D%E8%B4%B9%E4%B8%8B%E8%BD%BD)

**最新知识库文章**:
· [也许，这样理解HTTPS更容易](http://kb.cnblogs.com/page/563885/)
· [程序员学习能力提升三要素](http://kb.cnblogs.com/page/205634/)
· [为什么我要写自己的框架？](http://kb.cnblogs.com/page/559403/)
· [垃圾回收原来是这么回事](http://kb.cnblogs.com/page/562433/)
· [「代码家」的学习过程和学习经验分享](http://kb.cnblogs.com/page/554260/)
» [更多知识库文章...](http://kb.cnblogs.com/)