漫画：什么是Bitmap算法？

#  漫画：什么是Bitmap算法？

 *2017-08-06*  *玻璃猫*  [算法与数据结构](https://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079503&idx=1&sn=d6216eaa566e03077eea4ad5a8fcd526&chksm=f1748e6ac603077c8badc4cb392c9d0f63015da049f9b6f881ac39ebfeb4a0c39f2175dec400&scene=21##) 算法与数据结构

**> 来自：梦见（微信号：dreamsee321）**

[640.webp](../_resources/93ff206337cfe934622f91798740a9b7.webp)

[640.webp](../_resources/ac906bacc8e04c9bd81889a427ac48ca.webp)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

两个月之前——

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

为满足用户标签的统计需求，小灰利用Mysql设计了如下的表结构，每一个维度的标签都对应着Mysql表的一列：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

要想统计所有90后的程序员该怎么做呢？
用一条求交集的SQL语句即可：

**Select count（distinct Name） as 用户数 from table whare age = '90后' and Occupation = '程序员' ;**

要想统计所有使用苹果手机或者00后的用户总合该怎么做？
用一条求并集的SQL语句即可：

**Select count（distinct Name） as 用户数 from table whare Phone = '苹果' or age = '00后' ;**

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

两个月之后——
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

———————————————

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

1. 给定长度是10的bitmap，每一个bit位分别对应着从0到9的10个整型数。此时bitmap的所有位都是0。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

2. 把整型数4存入bitmap，对应存储的位置就是下标为4的位置，将此bit置为1。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

3. 把整型数2存入bitmap，对应存储的位置就是下标为2的位置，将此bit置为1。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

4. 把整型数1存入bitmap，对应存储的位置就是下标为1的位置，将此bit置为1。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

5. 把整型数3存入bitmap，对应存储的位置就是下标为3的位置，将此bit置为1。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

要问此时bitmap里存储了哪些元素？显然是4,3,2,1，一目了然。
Bitmap不仅方便查询，还可以去除掉重复的整型数。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

1. 建立用户名和用户ID的映射：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

2. 让每一个标签存储包含此标签的所有用户ID，每一个标签都是一个独立的Bitmap。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

3. 这样，实现用户的去重和查询统计，就变得一目了然：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

1. 如何查找使用苹果手机的程序员用户？

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

2. 如何查找所有男性或者00后的用户？

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**几点说明：**
1. 本文的灵感来源于京东金融数据部张洪雨同学的项目经历，感谢这位大神的技术分享。
2. 该项目最初的技术选型并非Mysql，而是内存数据库hana。本文为了便于理解，把最初的存储方案写成了Mysq数据库。
—————END—————
**> 系列文章：**

> 《> [> 漫画：什么是一致性哈希？](https://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079424&idx=1&sn=777240c3f0a9cfabab5e270e9964774d&chksm=f1748ea5c60307b3253507d6e9af713ab473063536dee6671603af7fcb8fc373ce188188af39&scene=21#wechat_redirect)> 》

> 《> [> 漫画：什么是B+树？](https://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079392&idx=1&sn=6eb4012f9652749f0317ff32bf1df0cf&chksm=f1748ec5c60307d350c7eef45c30238e98c5bf66b4e046caf63c3f01d8ba780822c5af7dc53e&scene=21#wechat_redirect)> 》

> 《> [> 漫画：什么是B-树？](https://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079363&idx=1&sn=7c2209e6b84f344b60ef4a056e5867b4&chksm=f1748ee6c60307f084fe9eeff012a27b5b43855f48ef09542fe6e56aab6f0fc5378c290fc4fc&scene=21#wechat_redirect)> 》

> 《> [> 漫画：什么是跳跃表？](https://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079341&idx=1&sn=f318b7eb864e96661530955567d630ce&chksm=f1748f08c603061e39179745f06a8a567b2f58f8b19a78ab25ec83da666359284ee53c4022aa&scene=21#wechat_redirect)> 》

> 《> [> 漫画：什么是动态规划？](https://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079324&idx=1&sn=b9ea93c3e30b3f85f3175d201b296ef3&chksm=f1748f39c603062ff669ea3507463cfeaa2a7c8aebbe6a03770229afc00614e40df9d7dc148a&scene=21#wechat_redirect)> 》

> 《> [> 漫画：当程序猿遇上智力测试题](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652078928&idx=2&sn=140652324d1ed1169417d190e47355c5&chksm=f17488b5c60301a34c9217061edb99625e4f3153fc2b428c81e5fabcbc9fb5c77237e863fa7b&scene=21#wechat_redirect)> 》

> 《> [> 漫画：判断 2 的乘方](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652078923&idx=1&sn=58c80ea0de09a0d92f505b02a2f4bde1&chksm=f17488aec60301b81ad41ea6d93cb726438267197672238d716e7d265a6a0f5ff18dbf58842c&scene=21#wechat_redirect)> 》

> 《> [> 漫画算法：最小栈的实现](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652078906&idx=1&sn=404f7c747511a8700b929bb88774c09c&chksm=f17488dfc60301c9d647b3cab401fb801474caaf013b70ab255f483c43abee7216545c334a0c&scene=21#wechat_redirect)> 》

> 《> [> 漫画：什么是大数据？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652078761&idx=1&sn=64e408c944a5eb2e788be2dd280c53c8&chksm=f174894cc603005a557e4ffebd78b97f7015255ff90bb22ed5c4bbb40b11a795656b7eaec599&scene=21#wechat_redirect)> 》

> 《> [> 漫画算法：无序数组排序后的最大相邻差值](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079495&idx=1&sn=460f3900e0897d683c37c7554b51c2ff&chksm=f1748e62c6030774a249dd5c392814400a4b09f06b11e524e584ed19ae1a8135051f39a61445&scene=21#wechat_redirect)> 》

* * *

●本文编号440，以后想阅读这篇文章直接输入440即可。
●输入m获取到文章目录
**推荐↓↓↓**

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
**Python编程**

更多推荐**《**[**18个技术类公众微信**](https://mp.weixin.qq.com/s?__biz=MzIxNjA5MTM2MA==&mid=2652433904&idx=2&sn=71bb42696ab0b9e47bb60d5750022151&chksm=8c62127fbb159b69f0838c9f47786f0ef615cd0f918ded865361f44b5d8ddde122f46f5e5f34&scene=21#wechat_redirect)**》**

涵盖：程序人生、算法与数据结构、黑客技术与网络安全、大数据技术、前端开发、Java、Python、Web开发、安卓开发、iOS开发、C/C++、.NET、Linux、数据库、运维等。