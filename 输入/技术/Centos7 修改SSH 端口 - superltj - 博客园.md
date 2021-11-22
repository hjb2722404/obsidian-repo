Centos7 修改SSH 端口 - superltj - 博客园

# [知我罪我 其惟春秋](https://www.cnblogs.com/waslost/)

Waslost

## [Centos7 修改SSH 端口](https://www.cnblogs.com/waslost/p/4459664.html)

　　上周服务器被攻击导致上面收回了我们服务器的IP，所以这周重新安装部署了服务器，使用centos7系统。为了防止服务器再次被攻击，所以建议以下几点：
1. root密码要复杂一点，尽量字母数字特殊字符都有
2. ssh端口最好修改成自己的不要使用默认的22端口
3. 如果可以的话重新增加个用户，然后修改禁止root远程登录
      **
修改ssh端口的详细步骤（centos7）：
**
**step1 修改/etc/ssh/sshd_config**
vi /etc/ssh/sshd_config
#Port 22         //这行去掉#号，防止配置不好以后不能远程登录，还得去机房修改，等修改以后的端口能使用以后在注释掉
Port 20000      //下面添加这一行

**step2 修改firewall配置**
firewall添加想要修改的ssh端口：

firewall-cmd --zone=public --add-port=20000/tcp --permanent (permanent是保存配置，不然下次重启以后这次修改无效)

reload firewall:
firewall-cmd --reload
查看添加端口是否成功，如果添加成功则会显示yes，否则no
firewall-cmd --zone=public --query-port=20000/tcp

**step3 修改SELinux**
使用以下命令查看当前SElinux 允许的ssh端口：
semanage port -l | grep ssh

添加20000端口到 SELinux
semanage port -a -t ssh_port_t -p tcp 20000

然后确认一下是否添加进去
semanage port -l | grep ssh
如果成功会输出
ssh_port_t                    tcp    20000, 22

**step4 重启ssh**
systemctl restart sshd.service

**step5 测试新端口的ssh连接**
测试修改端口以后的ssh连接，如果成功则将step1里面的port 22 重新注释掉

时光，浓淡相宜，人心，远近相安

分类: [Linux](https://www.cnblogs.com/waslost/category/683799.html)
标签: [centos7 ssh](https://www.cnblogs.com/waslost/tag/centos7%20ssh/)

 [好文要顶](Centos7%20修改SSH%20端口%20-%20superltj%20-%20博客园.md#)  [关注我](Centos7%20修改SSH%20端口%20-%20superltj%20-%20博客园.md#)  [收藏该文](Centos7%20修改SSH%20端口%20-%20superltj%20-%20博客园.md#)  [![icon_weibo_24.png](Centos7%20修改SSH%20端口%20-%20superltj%20-%20博客园.md#)  [![wechat.png](Centos7%20修改SSH%20端口%20-%20superltj%20-%20博客园.md#)

 [![sample_face.gif](../_resources/373280fde0d7ed152a0f7f06df3f3ad4.gif)](http://home.cnblogs.com/u/waslost/)

 [superltj](http://home.cnblogs.com/u/waslost/)
 [关注 - 0](http://home.cnblogs.com/u/waslost/followees)
 [粉丝 - 0](http://home.cnblogs.com/u/waslost/followers)

 [+加关注](Centos7%20修改SSH%20端口%20-%20superltj%20-%20博客园.md#)

0

0

posted on
2015-04-27 11:26
 [superltj](https://www.cnblogs.com/waslost/) 阅读(
5043
) 评论(
0

) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=4459664)  [收藏](https://www.cnblogs.com/waslost/p/4459664.html#)

[刷新评论](Centos7%20修改SSH%20端口%20-%20superltj%20-%20博客园.md#)[刷新页面](https://www.cnblogs.com/waslost/p/4459664.html#)[返回顶部](https://www.cnblogs.com/waslost/p/4459664.html#top)

注册用户登录后才能发表评论，请 [登录](Centos7%20修改SSH%20端口%20-%20superltj%20-%20博客园.md#) 或 [注册](Centos7%20修改SSH%20端口%20-%20superltj%20-%20博客园.md#)，[访问](http://www.cnblogs.com/)网站首页。

[【推荐】超50万VC++源码: 大型组态工控、电力仿真CAD与GIS源码库！](http://www.ucancode.com/index.htm)

[【免费】要想入门学习Linux系统技术，你应该先选择一本适合自己的书籍](https://www.linuxprobe.com/chapter-00.html)

[【前端】SpreadJS表格控件，可嵌入应用开发的在线Excel](https://www.grapecity.com.cn/developer/spreadjs?utm_source=cnblogs&utm_medium=blogpage&utm_term=bottom&utm_content=SpreadJS&utm_campaign=community)

[【直播】如何快速接入微信支付功能](https://cloud.tencent.com/developer/edu/major-100005?fromSource=gwzcw.1312543.1312543.1312543#course-1274)

[![24442-20180914091419057-283402001.jpg](../_resources/35e9a81ae061a5119e7f6a5ee00445af.jpg)](https://cloud.tencent.com/act/special/rav?fromSource=gwzcw.1312547.1312547.1312547)

**最新IT新闻**:
· [周鸿祎详解三六零回A股 百亿定增将构筑新利润增长点](https://news.cnblogs.com/n/608201/)
· [同程艺龙上线VR订房 可360度无死角看房](https://news.cnblogs.com/n/608200/)
· [网易否认因游戏业下滑裁员：正大规模招聘中](https://news.cnblogs.com/n/608199/)
· [中秋国庆的火车票，你抢到了吗？揭露黄牛背后那些事](https://news.cnblogs.com/n/608164/)
· [云米陈小平创业4年身家16亿元 敲钟前感谢雷军方洪波](https://news.cnblogs.com/n/608190/)
» [更多新闻...](http://news.cnblogs.com/)

[![24442-20180916205959082-1265433055.jpg](../_resources/7e9aff57df0d1c64747b0d9a0462d3f8.jpg)](http://clickc.admaster.com.cn/c/a113319,b2799157,c1705,i0,m101,8a1,8b3,h)

**最新知识库文章**:
· [为什么说 Java 程序员必须掌握 Spring Boot ？](https://kb.cnblogs.com/page/606682/)
· [在学习中，有一个比掌握知识更重要的能力](https://kb.cnblogs.com/page/606645/)
· [如何招到一个靠谱的程序员](https://kb.cnblogs.com/page/603663/)
· [一个故事看懂“区块链”](https://kb.cnblogs.com/page/573614/)
· [被踢出去的用户](https://kb.cnblogs.com/page/603697/)
» [更多知识库文章...](https://kb.cnblogs.com/)

### 公告

昵称：[superltj](https://home.cnblogs.com/u/waslost/)
园龄：[5年4个月](https://home.cnblogs.com/u/waslost/)
粉丝：[0](https://home.cnblogs.com/u/waslost/followers/)
关注：[0](https://home.cnblogs.com/u/waslost/followees/)
[+加关注](Centos7%20修改SSH%20端口%20-%20superltj%20-%20博客园.md#)

### 导航

- [博客园](https://www.cnblogs.com/)
- [首页](https://www.cnblogs.com/waslost/)

-

- [联系](https://msg.cnblogs.com/send/superltj)

-

- [管理](https://i.cnblogs.com/)

|     |     |     |
| --- | --- | --- |
| [<](Centos7%20修改SSH%20端口%20-%20superltj%20-%20博客园.md#) | 2018年9月 | [>](Centos7%20修改SSH%20端口%20-%20superltj%20-%20博客园.md#) |

日
一
二
三
四
五
六
26
27
28
29
30
31
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
1
2
3
4
5
6

### 统计

- 随笔 - 1
- 文章 - 0
- 评论 - 0
- 引用 - 0

### 搜索

### 常用链接

- [我的随笔](https://www.cnblogs.com/waslost/p/)
- [我的评论](https://www.cnblogs.com/waslost/MyComments.html)
- [我的参与](https://www.cnblogs.com/waslost/OtherPosts.html)
- [最新评论](https://www.cnblogs.com/waslost/RecentComments.html)
- [我的标签](https://www.cnblogs.com/waslost/tag/)

### 我的标签

- [centos7 ssh](https://www.cnblogs.com/waslost/tag/centos7%20ssh/)(1)

### 随笔分类

- [android](https://www.cnblogs.com/waslost/category/683800.html)
- [Linux(1)](https://www.cnblogs.com/waslost/category/683799.html)

### 随笔档案

- [2015年4月 (1)](https://www.cnblogs.com/waslost/archive/2015/04.html)

### 阅读排行榜

- [1. Centos7 修改SSH 端口(5043)](https://www.cnblogs.com/waslost/p/4459664.html)

Powered by:[博客园](https://www.cnblogs.com/)Copyright © superltj