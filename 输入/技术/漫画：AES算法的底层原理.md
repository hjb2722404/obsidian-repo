漫画：AES算法的底层原理

#  漫画：AES算法的底层原理

 *2017-10-26*  *玻璃猫*  [算法与数据结构](https://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079721&idx=1&sn=14051d02671a63b88ebc9025cfad8455&chksm=f1748d8cc603049a3f1ca982e5ec7d29a8f7a5cf6cd88aadf0c8167c37401f7f8ece66828511&scene=21##)

**> 来自：程序员小灰（微信号：chengxuyuanxiaohui）**
**> 作者：玻璃猫**

上一次为大家介绍了AES算法的基本概念，没看过的小伙伴可以点击下面的链接：《[漫画：什么是AES算法？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079704&idx=1&sn=cf89c1dba85c195b03873287d84044d3&chksm=f1748dbdc60304ab0fcad99eee0002f2f83c3a175b57d072a4e7ddb0f87b5b46f38307e56510&scene=21#wechat_redirect)》

我们是有追求的程序员，不能知其然不知其所以然。这一次，我来给大家讲一讲AES算法的**底层原理**。

[640.webp](../_resources/ede90faa58cef45f11a1de1dfc60d574.webp)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

上一期我们已经对AES的总体加密流程进行了介绍，在这里我们重新梳理一下：
1.把明文按照128bit拆分成若干个明文块。
2.按照选择的填充方式来填充最后一个明文块。
3.每一个明文块利用AES加密器和密钥，加密成密文块。
4.拼接所有的密文块，成为最终的密文结果。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

具体分成多少轮呢？
初始轮（Initial Round）  1次
普通轮（Rounds）          N次
最终轮（Final Round）   1次
上一期我们提到，AES的Key支持三种长度：AES128，AES192，AES256。Key的长度决定了AES加密的轮数。
除去初始轮，各种Key长度对应的轮数如下：
AES128：10轮
AES192：12轮
AES256：14轮
不同阶段的Round有不同的处理步骤。
初始轮只有一个步骤：
加轮密钥（AddRoundKey）
普通轮有四个步骤：
字节代替（SubBytes）
行移位（ShiftRows）
列混淆（MixColumns）
加轮密钥（AddRoundKey）
最终轮有三个步骤：
字节代替（SubBytes）
行移位（ShiftRows）
加轮密钥（AddRoundKey）

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**1.字节替代（SubBytes）**
****
**![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)**

首先需要说明的是，16字节的明文块在每一个处理步骤中都被排列成4X4的二维数组。

所谓字节替代，就是把明文块的每一个字节都替代成另外一个字节。替代的依据是什么呢？依据一个被称为**S盒**（Subtitution Box）的16X16大小的二维常量数组。

假设明文块当中a[2,2] = 5B（一个字节是两位16进制），那么输出值b[2,2] = S[5][11]。
**2.行移位（ShiftRows）**

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

这一步很简单，就像图中所描述的：
第一行不变
第二行循环左移**1**个字节
第三行循环左移**2**个字节
第四行循环左移**3**个字节
**3.列混淆（MixColumns）**
****
**![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)**

这一步，输入数组的每一列要和一个名为修补矩阵（fixed matrix）的二维常量数组做矩阵相乘，得到对应的输出列。
**4.加轮密钥（AddRoundKey）**
****
**![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)**

这一步是唯一利用到密钥的一步，128bit的密钥也同样被排列成4X4的矩阵。
让输入数组的每一个字节a[i,j]与密钥对应位置的字节k[i,j]异或一次，就生成了输出值b[i,j]。
需要补充一点，加密的每一轮所用到的密钥并不是相同的。这里涉及到一个概念：扩展密钥（KeyExpansions）。
**扩展密钥（KeyExpansions）**
AES源代码中用长度 4 * 4 *（10+1） 字节的数组W来存储所有轮的密钥。W{0-15}的值等同于原始密钥的值，用于为初始轮做处理。
后续每一个元素W[i]都是由W[i-4]和W[i-1]计算而来，直到数组W的所有元素都赋值完成。

W数组当中，W{0-15}用于初始轮的处理，W{16-31}用于第1轮的处理，W{32-47}用于第2轮的处理 ......一直到W{160-175}用于最终轮（第10轮）的处理。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**1.ECB模式**
ECB模式（Electronic Codebook Book）是最简单的工作模式，在该模式下，每一个明文块的加密都是完全独立，互不干涉的。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

这样的好处是什么呢？
1.简单
2.有利于并行计算
缺点同样也很明显：
相同的明文块经过加密会变成相同的密文块，因此安全性较差。
2.CBC模式
CBC模式（Cipher Block Chaining）引入了一个新的概念：初始向量IV（Initialization Vector）。
IV是做什么用的呢？它的作用和MD5的“加盐”有些类似，目的是防止同样的明文块始终加密成同样的密文块。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

从图中可以看出，CBC模式在每一个明文块加密前会让明文块和一个值先做异或操作。IV作为初始化变量，参与第一个明文块的异或，后续的每一个明文块和它**前一个明文块所加密出的密文块**相异或。

这样以来，相同的明文块加密出的密文块显然是不一样的。
CBC模式的好处是什么呢？
安全性更高
坏处也很明显：
1.无法并行计算，性能上不如ECB
2.引入初始化向量IV，增加复杂度。

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

> 《> [> 漫画：什么是MD5算法？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079663&idx=1&sn=430d0033f60b2b394ba6c48ebc34b403&chksm=f1748dcac60304dc7ef9959e5c6ebd54f859c62279e1c0660cc808285575e70dcd9f0f52cc89&scene=21#wechat_redirect)> 》

> 《> [> 漫画：如何破解MD5算法？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079682&idx=1&sn=0d3092063651f2d5c1269109f2751e34&chksm=f1748da7c60304b147392be2d8d822936928245896a6376a13412ba4e356a9d99e314887140e&scene=21#wechat_redirect)> 》

> 《> [> 漫画：什么是SHA系列算法？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079697&idx=1&sn=15ea587f8fe46ceffc13d8a1659580c7&chksm=f1748db4c60304a29618626c97479c7fcdb2d68230911f1d73b8dd2874ef8f60a3068fc6d0f3&scene=21#wechat_redirect)> 》

> 《> [> 漫画：什么是AES算法？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079704&idx=1&sn=cf89c1dba85c195b03873287d84044d3&chksm=f1748dbdc60304ab0fcad99eee0002f2f83c3a175b57d072a4e7ddb0f87b5b46f38307e56510&scene=21#wechat_redirect)> 》

* * *

●本文编号498，以后想阅读这篇文章直接输入498即可
●输入m获取文章目录
**推荐↓↓↓**

**![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)**
**黑客技术与网络安全**

**更多推荐****《**[**18个技术类微信公众号**](https://mp.weixin.qq.com/s?__biz=MzIxNjA5MTM2MA==&mid=2652433904&idx=2&sn=71bb42696ab0b9e47bb60d5750022151&chksm=8c62127fbb159b69f0838c9f47786f0ef615cd0f918ded865361f44b5d8ddde122f46f5e5f34&scene=21#wechat_redirect)**》**

涵盖：程序人生、算法与数据结构、黑客技术与网络安全、大数据技术、前端开发、Java、Python、Web开发、安卓开发、iOS开发、C/C++、.NET、Linux、数据库、运维等。