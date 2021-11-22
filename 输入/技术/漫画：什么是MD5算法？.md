漫画：什么是MD5算法？

#  漫画：什么是MD5算法？

 *2017-09-30*  *玻璃猫*  [算法与数据结构](https://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079663&idx=1&sn=430d0033f60b2b394ba6c48ebc34b403&chksm=f1748dcac60304dc7ef9959e5c6ebd54f859c62279e1c0660cc808285575e70dcd9f0f52cc89&scene=21##)

**> 来自：梦见（微信号：dreamsee321）**

[640.webp](../_resources/d6a9e738a9860ecf3e6a64ad9e37a8b2.webp)

[640.webp](../_resources/a8aca09a9c7ace0bd8f68cc244d4bc29.webp)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

摘要哈希生成的正确姿势是什么样呢？分三步：
1.收集相关业务参数，在这里是金额和目标账户。当然，实际应用中的参数肯定比这多得多，这里只是做了简化。
2.按照规则，把参数名和参数值拼接成一个字符串，同时把给定的**密钥**也拼接起来。之所以需要密钥，是因为攻击者也可能获知拼接规则。
3.利用MD5算法，从原文生成哈希值。MD5生成的哈希值是128位的二进制数，也就是32位的十六进制数。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

第三方支付平台如何验证请求的签名？同样分三步：
1.发送方和请求方约定相同的字符串拼接规则，约定相同的密钥。
2.第三方平台接到支付请求，按规则拼接业务参数和密钥，利用MD5算法生成Sign。

3.用第三方平台自己生成的Sign和请求发送过来的Sign做对比，如果两个Sign值一模一样，则签名无误，如果两个Sign值不同，则信息做了篡改。这个过程叫做**验签**。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**MD5算法底层原理：**
简单概括起来，MD5算法的过程分为四步：**处理原文**，**设置初始值**，**循环加工，拼接结果**。
**第一步:处理原文**

首先，我们计算出原文长度(bit)对512求余的结果，如果不等于448，就需要填充原文使得原文对512求余的结果等于448。填充的方法是第一位填充1，其余位填充0。填充完后，信息的长度就是512*N+448。

之后，用剩余的位置（512-448=64位）记录原文的真正长度，把长度的二进制值补在最后。这样处理后的信息长度就是512*(N+1)。
**第二步:设置初始值**

MD5的哈希结果长度为128位，按每32位分成一组共4组。这4组结果是由4个初始值A、B、C、D经过不断演变得到。MD5的官方实现中，A、B、C、D的初始值如下（16进制）：

A=0x01234567
B=0x89ABCDEF
C=0xFEDCBA98
D=0x76543210
**第三步:循环加工**
这一步是最复杂的一步，我们看看下面这张图，此图代表了单次A,B,C,D值演变的流程。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

图中，A，B，C，D就是哈希值的四个分组。每一次循环都会让旧的ABCD产生新的ABCD。一共进行多少次循环呢？由处理后的原文长度决定。
假设处理后的原文长度是M
主循环次数 = **M / 512**
每个主循环中包含 **512 / 32 * 4 = 64** 次 子循环。
上面这张图所表达的就是**单次子循环**的流程。
下面对图中其他元素一一解释：
**1.绿色F**
图中的绿色F，代表非线性函数。官方MD5所用到的函数有四种：
F(X, Y, Z) =(X&Y) | ((~X) & Z)
G(X, Y, Z) =(X&Z) | (Y & (~Z))
H(X, Y, Z) =X^Y^Z
I(X, Y, Z)=Y^(X|(~Z))
在主循环下面64次子循环中，F、G、H、I 交替使用，第一个16次使用F，第二个16次使用G，第三个16次使用H，第四个16次使用I。
**2.红色“田”字**
很简单，红色的田字代表相加的意思。
**3.Mi**

Mi是第一步处理后的原文。在第一步中，处理后原文的长度是512的整数倍。把原文的每512位再分成16等份，命名为M0~M15，每一等份长度32。在64次子循环中，每16次循环，都会交替用到M1~M16之一。

**4.Ki**
一个常量，在64次子循环中，每一次用到的常量都是不同的。
**5.黄色的<<<S**
左移S位，S的值也是常量。
“流水线”的最后，让计算的结果和B相加，取代原先的B。新ABCD的产生可以归纳为：
新A = 原d
新B = b+((a+F(b,c,d)+Mj+Ki)<<<s)
新C = 原b
新D = 原c
总结一下主循环中的64次子循环，可以归纳为下面的四部分：
       **第一轮：**
       FF(a,b,c,d,M0,7,0xd76aa478）     s[0]=7,   K[0] = 0xd76aa478
　　FF(a,b,c,d,M1,12,0xe8c7b756）   s[1]=12,  K[1] = 0xe8c7b756
　　FF(a,b,c,d,M2,17,0x242070db)
　　FF(a,b,c,d,M3,22,0xc1bdceee)
　　FF(a,b,c,d,M4,7,0xf57c0faf)
　　FF(a,b,c,d,M5,12,0x4787c62a)
　　FF(a,b,c,d,M6,17,0xa8304613）
　　FF(a,b,c,d,M7,22,0xfd469501）
　　FF(a,b,c,d,M8,7,0x698098d8）
　　FF(a,b,c,d,M9,12,0x8b44f7af)
　　FF(a,b,c,d,M10,17,0xffff5bb1）
　　FF(a,b,c,d,M11,22,0x895cd7be)
　　FF(a,b,c,d,M12,7,0x6b901122）
　　FF(a,b,c,d,M13,12,0xfd987193）
　　FF(a,b,c,d,M14,17, 0xa679438e)
　　FF(a,b,c,d,M15,22,0x49b40821）
　　**第二轮：**
　　GG(a,b,c,d,M1,5,0xf61e2562）
　　GG(a,b,c,d,M6,9,0xc040b340）
　　GG(a,b,c,d,M11,14,0x265e5a51）
　　GG(a,b,c,d,M0,20,0xe9b6c7aa)
　　GG(a,b,c,d,M5,5,0xd62f105d)
　　GG(a,b,c,d,M10,9,0x02441453）
　　GG(a,b,c,d,M15,14,0xd8a1e681）
　　GG(a,b,c,d,M4,20,0xe7d3fbc8）
　　GG(a,b,c,d,M9,5,0x21e1cde6）
　　GG(a,b,c,d,M14,9,0xc33707d6）
　　GG(a,b,c,d,M3,14,0xf4d50d87）
　　GG(a,b,c,d,M8,20,0x455a14ed)
　　GG(a,b,c,d,M13,5,0xa9e3e905）
　　GG(a,b,c,d,M2,9,0xfcefa3f8）
　　GG(a,b,c,d,M7,14,0x676f02d9）
　　GG(a,b,c,d,M12,20,0x8d2a4c8a)
　　**第三轮：**
　　HH(a,b,c,d,M5,4,0xfffa3942）
　　HH(a,b,c,d,M8,11,0x8771f681）
　　HH(a,b,c,d,M11,16,0x6d9d6122）
　　HH(a,b,c,d,M14,23,0xfde5380c)
　　HH(a,b,c,d,M1,4,0xa4beea44）
　　HH(a,b,c,d,M4,11,0x4bdecfa9）
　　HH(a,b,c,d,M7,16,0xf6bb4b60）
　　HH(a,b,c,d,M10,23,0xbebfbc70）
　　HH(a,b,c,d,M13,4,0x289b7ec6）
　　HH(a,b,c,d,M0,11,0xeaa127fa)
　　HH(a,b,c,d,M3,16,0xd4ef3085）
　　HH(a,b,c,d,M6,23,0x04881d05）
　　HH(a,b,c,d,M9,4,0xd9d4d039）
　　HH(a,b,c,d,M12,11,0xe6db99e5）
　　HH(a,b,c,d,M15,16,0x1fa27cf8）
　　HH(a,b,c,d,M2,23,0xc4ac5665）
　　**第四轮：**
　　Ⅱ（a,b,c,d,M0,6,0xf4292244）
　　Ⅱ（a,b,c,d,M7,10,0x432aff97）
　　Ⅱ（a,b,c,d,M14,15,0xab9423a7）
　　Ⅱ（a,b,c,d,M5,21,0xfc93a039）
　　Ⅱ（a,b,c,d,M12,6,0x655b59c3）
　　Ⅱ（a,b,c,d,M3,10,0x8f0ccc92）
　　Ⅱ（a,b,c,d,M10,15,0xffeff47d)
　　Ⅱ（a,b,c,d,M1,21,0x85845dd1）
　　Ⅱ（a,b,c,d,M8,6,0x6fa87e4f)
　　Ⅱ（a,b,c,d,M15,10,0xfe2ce6e0)
　　Ⅱ（a,b,c,d,M6,15,0xa3014314）
　　Ⅱ（a,b,c,d,M13,21,0x4e0811a1）
　　Ⅱ（a,b,c,d,M4,6,0xf7537e82）
　　Ⅱ（a,b,c,d,M11,10,0xbd3af235）
　　Ⅱ（a,b,c,d,M2,15,0x2ad7d2bb)
　　Ⅱ（a,b,c,d,M9,21,0xeb86d391）
**第四步:拼接结果**
这一步就很简单了，把循环加工最终产生的A，B，C，D四个值拼接在一起，转换成字符串即可。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

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

* * *

●本文编号480，以后想阅读这篇文章直接输入480即可
●输入m获取文章目录
**推荐↓↓↓**

**![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)**
**黑客技术与网络安全**

**更多推荐****《**[**18个技术类微信公众号**](https://mp.weixin.qq.com/s?__biz=MzIxNjA5MTM2MA==&mid=2652433904&idx=2&sn=71bb42696ab0b9e47bb60d5750022151&chksm=8c62127fbb159b69f0838c9f47786f0ef615cd0f918ded865361f44b5d8ddde122f46f5e5f34&scene=21#wechat_redirect)**》**

涵盖：程序人生、算法与数据结构、黑客技术与网络安全、大数据技术、前端开发、Java、Python、Web开发、安卓开发、iOS开发、C/C++、.NET、Linux、数据库、运维等。