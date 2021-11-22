漫画：什么是AES算法？

#  漫画：什么是AES算法？

 *2017-10-19*  *玻璃猫*  [算法与数据结构](https://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079704&idx=1&sn=cf89c1dba85c195b03873287d84044d3&chksm=f1748dbdc60304ab0fcad99eee0002f2f83c3a175b57d072a4e7ddb0f87b5b46f38307e56510&scene=21##)

**> 来自：程序员小灰（微信号：chengxuyuanxiaohui）**
**> 作者：玻璃猫**

[640.webp](../_resources/a45168ee4f0031a5dc0225032ac3b269.webp)

[640.webp](../_resources/4555391d851c4df4203a7d7cb7c08d4f.webp)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

假设有一个发送方在向接收方发送消息。如果没有任何加密算法，接收方发送的是一个明文消息：“我是小灰”

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

如果消息被中间人截获到，即使中间人无法篡改消息，也可以窥探到消息的内容，从而暴露了通信双方的私密。
因此我们不再直接传送明文，而改用对称加密的方式传输密文，画风就变成了下面这样：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

具体工作的步骤如下：
1.发送方利用密钥123456，加密明文“我是小灰”，加密结果为TNYRvx+SNjZwEK+ZXFEcDw==。
2.发送方把加密后的内容TNYRvx+SNjZwEK+ZXFEcDw==传输给接收方。
3.接收方收到密文TNYRvx+SNjZwEK+ZXFEcDw==，利用密钥123456还原为明文“我是小灰”。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**1.密钥**
密钥是AES算法实现加密和解密的根本。对称加密算法之所以对称，是因为这类算法对明文的加密和解密需要使用**同一个密钥**。
AES支持三种长度的密钥：
**128位，192位，256位**
平时大家所说的AES128，AES192，AES256，实际上就是指的AES算法对不同长度密钥的使用。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**2.填充**
要想了解填充的概念，我们先要了解AES的**分组加密**特性。
什么是分组加密呢？我们来看看下面这张图：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

AES算法在对明文加密的时候，并不是把整个明文一股脑加密成一整段密文，而是把明文拆分成一个个独立的明文块，每一个铭文块长度128bit。
这些明文块经过AES加密器的复杂处理，生成一个个独立的密文块，这些密文块拼接在一起，就是最终的AES加密结果。
但是这里涉及到一个问题：

假如一段明文长度是196bit，如果按每128bit一个明文块来拆分的话，第二个明文块只有64bit，不足128bit。这时候怎么办呢？就需要对明文块进行**填充**（Padding）。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**NoPadding：
**
不做任何填充，但是要求明文必须是16字节的整数倍。
**PKCS5Padding**（默认）**：
**
如果明文块少于16个字节（128bit），在明文块末尾补足相应数量的字符，且每个字节的值等于缺少的字符数。

比如明文：{1,2,3,4,5,a,b,c,d,e},缺少6个字节，则补全为{1,2,3,4,5,a,b,c,d,e**,6,6,6,6,6,6**}

**ISO10126Padding：
**
如果明文块少于16个字节（128bit），在明文块末尾补足相应数量的字节，最后一个字符值等于缺少的字符数，其他字符填充随机数。

比如明文：{1,2,3,4,5,a,b,c,d,e},缺少6个字节，则可能补全为{1,2,3,4,5,a,b,c,d,e**,5,c,3,G,$,6**}

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**3.模式**
AES的工作模式，体现在把明文块加密成密文块的处理过程中。AES加密算法提供了五种不同的工作模式：
CBC、ECB、CTR、CFB、OFB
模式之间的主题思想是近似的，在处理细节上有一些差别。我们这一期只介绍各个模式的基本定义。
**CBC模式：**
电码本模式    Electronic Codebook Book
**ECB模式（默认）：**
密码分组链接模式    Cipher Block Chaining
**CTR模式：**
计算器模式    Counter
**CFB模式：**
密码反馈模式    Cipher FeedBack
**OFB模式：**
输出反馈模式    Output FeedBack

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

1. kgen.init传入的第一个参数128决定了密钥的长度是**128bit**。

2. Cipher.getInstance("AES/CBC/NoPadding")决定了AES选择的填充方式是**NoPadding**，工作模式是**CBC**模式。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

几点补充：
1.我们在调用封装好的AES算法时，表面上使用的Key并不是真正用于AES加密解密的密钥，而是用于生成真正密钥的“种子”。
2.填充明文时，如果明文长度原本就是16字节的整数倍，那么除了NoPadding以外，其他的填充方式都会填充一组额外的16字节明文块。
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

> 《> [> 漫画：如何做一款比吃鸡还厉害的游戏](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079698&idx=1&sn=e592d80b84d455d327d9f6aaa05757a7&chksm=f1748db7c60304a1b8f1e197b46efb861698547d9a1bf8c92eebf4b9b8d0c6e5011adcdcfe93&scene=21#wechat_redirect)> 》

* * *

●本文编号493，以后想阅读这篇文章直接输入493即可
●输入m获取文章目录
**推荐↓↓↓**

**![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)**
**黑客技术与网络安全**

**更多推荐****《**[**18个技术类微信公众号**](https://mp.weixin.qq.com/s?__biz=MzIxNjA5MTM2MA==&mid=2652433904&idx=2&sn=71bb42696ab0b9e47bb60d5750022151&chksm=8c62127fbb159b69f0838c9f47786f0ef615cd0f918ded865361f44b5d8ddde122f46f5e5f34&scene=21#wechat_redirect)**》**

涵盖：程序人生、算法与数据结构、黑客技术与网络安全、大数据技术、前端开发、Java、Python、Web开发、安卓开发、iOS开发、C/C++、.NET、Linux、数据库、运维等。