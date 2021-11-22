漫画：什么是SHA系列算法？

#  漫画：什么是SHA系列算法？

 *2017-10-15*  *玻璃猫*  [算法与数据结构](https://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079697&idx=1&sn=15ea587f8fe46ceffc13d8a1659580c7&chksm=f1748db4c60304a29618626c97479c7fcdb2d68230911f1d73b8dd2874ef8f60a3068fc6d0f3&scene=21##)

**> 来自：梦见（微信号：dreamsee321）**

[640.webp](../_resources/8ec8a46cba708ab1ba526c14d9d77ed6.webp)

[640.webp](../_resources/42f13fdc93514e1ac2fd936319893f60.webp)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**SHA-1**
SHA-1算法可以从明文生成160bit的信息摘要，示例如下：
给定明文：      abcd
SHA-1摘要：   81FE8BFE87576C3ECB22426F8E57847382917ACF
SHA-1 与 MD5的主要区别是什么呢？
**1.摘要长度不同**。

MD5的摘要的长度尽128bit，SHA-1摘要长度160bit。多出32bit意味着什么呢？不同明文的碰撞几率降低了2^32 = 324294967296倍。

**2.性能略有差别**
SHA-1生成摘要的性能比MD5略低。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**SHA-2**
SHA-2是一系列SHA算法变体的总称，其中包含如下子版本：
SHA-256：可以生成长度256bit的信息摘要。
SHA-224：SHA-256的“阉割版”，可以生成长度224bit的信息摘要。
SHA-512：可以生成长度512bit的信息摘要。
SHA-384：SHA-512的“阉割版”，可以生成长度384bit的信息摘要。
显然，信息摘要越长，发生碰撞的几率就越低，破解的难度就越大。但同时，耗费的性能和占用的空间也就越高。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

明文：        abcd
MD5摘要：
e2fc714c4727ee9395f324cd2e7f331f
SHA-256摘要：
88d4266fd4e6338d13b845fcf289579d209c897823b9217da3e161936f031589
合成摘要：
e2fc714c4727ee93209c897823b9217da3e161936f031589

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

我们先来回顾一下MD5算法的核心过程，没看过的小伙伴们可以点击这个链接：

[漫画：什么是MD5算法？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079663&idx=1&sn=430d0033f60b2b394ba6c48ebc34b403&chksm=f1748dcac60304dc7ef9959e5c6ebd54f859c62279e1c0660cc808285575e70dcd9f0f52cc89&scene=21#wechat_redirect)

简而言之，MD5把128bit的信息摘要分成A，B，C，D四段（Words），每段32bit，在循环过程中交替运算A，B，C，D，最终组成128bit的摘要结果。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

再看一下SHA-1算法，核心过程大同小异，主要的不同点是把160bit的信息摘要分成了A，B，C，D，E五段。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

再看一下SHA-2系列算法，核心过程更复杂一些，把信息摘要分成了A，B，C，D，E，F，G，H八段。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

其中SHA-256的每一段摘要长度是32bit，SHA-512的每一段摘要长度是64bit。SHA-224和SHA-384则是在前两者生成结果的基础上做出裁剪。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

几点补充：
SHA家族的最新成员SHA-3已经于2015年问世。关于SHA-3的细节，有兴趣的小伙伴们可以查询资料进一步学习。
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

> 《> [> 漫画：什么是Bitmap算法？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079503&idx=1&sn=d6216eaa566e03077eea4ad5a8fcd526&chksm=f1748e6ac603077c8badc4cb392c9d0f63015da049f9b6f881ac39ebfeb4a0c39f2175dec400&scene=21#wechat_redirect)> 》

> 《> [> 漫画：Bitmap算法 进阶篇](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079561&idx=1&sn=cc27bccbf3b0a89aec7bc4ee16d5a9eb&chksm=f1748e2cc603073a9895b61451b29f0b817d9d965e61ecb7949269de5ded277768011496384c&scene=21#wechat_redirect)> 》

> 《> [> 什么是A*寻路算法？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079616&idx=1&sn=4f1344d07dc1d2f74bcb654b09810ead&chksm=f1748de5c60304f347758d39a5751031414e5c0fc2f758d3e3c638cacc42589953050c1eb817&scene=21#wechat_redirect)> 》

> 《> [> 漫画：当程序员遇上智力题（第四季）](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079638&idx=1&sn=88bc93fcb866c5514f31370708c9ad4f&chksm=f1748df3c60304e5d705a0696ea70959abf419535e5cd5a32e22bc72085c9a62a4b7564f6fdc&scene=21#wechat_redirect)> 》

> 《> [> 漫画：什么是Base64算法？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079659&idx=2&sn=2764ddde0d69306add749ccd81dc4e1c&chksm=f1748dcec60304d8594f6cb70d8d5bbd928766e75bfbbb1b8bd34b5ac0c2608b96b35791de1c&scene=21#wechat_redirect)> 》

> 《> [> 漫画：什么是MD5算法？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079663&idx=1&sn=430d0033f60b2b394ba6c48ebc34b403&chksm=f1748dcac60304dc7ef9959e5c6ebd54f859c62279e1c0660cc808285575e70dcd9f0f52cc89&scene=21#wechat_redirect)> 》

> 《> [> 漫画：如何破解MD5算法？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079682&idx=1&sn=0d3092063651f2d5c1269109f2751e34&chksm=f1748da7c60304b147392be2d8d822936928245896a6376a13412ba4e356a9d99e314887140e&scene=21#wechat_redirect)> 》

* * *

●本文编号489，以后想阅读这篇文章直接输入489即可
●输入m获取文章目录
**推荐↓↓↓**

**![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)**
**黑客技术与网络安全**

**更多推荐****《**[**18个技术类微信公众号**](https://mp.weixin.qq.com/s?__biz=MzIxNjA5MTM2MA==&mid=2652433904&idx=2&sn=71bb42696ab0b9e47bb60d5750022151&chksm=8c62127fbb159b69f0838c9f47786f0ef615cd0f918ded865361f44b5d8ddde122f46f5e5f34&scene=21#wechat_redirect)**》**

涵盖：程序人生、算法与数据结构、黑客技术与网络安全、大数据技术、前端开发、Java、Python、Web开发、安卓开发、iOS开发、C/C++、.NET、Linux、数据库、运维等。