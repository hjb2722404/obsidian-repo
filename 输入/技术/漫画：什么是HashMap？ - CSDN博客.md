漫画：什么是HashMap？ - CSDN博客

# 漫画：什么是HashMap？

  原创   2017年11月20日 00:00:00

-

 .

**> 来自：程序员小灰（微信号：chengxuyuanxiaohui）**

![640.jpg](../_resources/960cb5f0be9a51d54849a0ea83c6320c.jpg)

![640.jpg](../_resources/9264a170d7037d2b7896e88b1e5c657f.jpg)

![640.jpg](../_resources/07ca932c46f48b7a113b3c44bbc6acd1.jpg)

![0.jpg](../_resources/fb7736baab3fe519195f2a0419e625d6.jpg)

————————————

![0.jpg](../_resources/0faf06fd08f0dc0653fa31a509c3cf5f.jpg)

![0.jpg](../_resources/36ed06babecd181030a7954506d0b20e.jpg)

![0.jpg](../_resources/82facb5b9ba1bb86a96a35e868959873.jpg)

![0.jpg](../_resources/0d55a15ec998e30756d904ab8038e88d.jpg)

![0.jpg](../_resources/15a35b6c82570330327707dcf8b3857b.jpg)

![0.jpg](../_resources/f6d23c13b9d6cb30f6ad8ef92a2bf408.jpg)

众所周知，HashMap是一个用于存储Key-Value键值对的集合，每一个键值对也叫做**Entry**。这些个键值对（Entry）分散存储在一个数组当中，这个数组就是HashMap的主干。

HashMap数组每一个元素的初始值都是Null。

![0.png](../_resources/9ca7e8eb5ecf7a7c2e45f90177d785f0.png)

对于HashMap，我们最常使用的是两个方法：**Get **和 **Put**。

**1.Put方法的原理**

调用Put方法的时候发生了什么呢？

比如调用 hashMap.put("apple", 0) ，插入一个Key为“apple"的元素。这时候我们需要利用一个哈希函数来确定Entry的插入位置（index）：

**index =  Hash（“apple”）**

假定最后计算出的index是2，那么结果如下：

![0.png](../_resources/f50984206aae3ccf1c92c12c0c0f0329.png)

但是，因为HashMap的长度是有限的，当插入的Entry越来越多时，再完美的Hash函数也难免会出现index冲突的情况。比如下面这样：

![0.png](../_resources/3dde167de3deaa02ea6d002d47fdfea7.png)

这时候该怎么办呢？我们可以利用**链表**来解决。

HashMap数组的每一个元素不止是一个Entry对象，也是一个链表的头节点。每一个Entry对象通过Next指针指向它的下一个Entry节点。当新来的Entry映射到冲突的数组位置时，只需要插入到对应的链表即可：

![0.png](../_resources/89b55c75205cfb87f8bbd21f27d846dc.png)

需要注意的是，新来的Entry节点插入链表时，使用的是“头插法”。至于为什么不插入链表尾部，后面会有解释。

2.Get方法的原理

使用Get方法根据Key来查找Value的时候，发生了什么呢？

首先会把输入的Key做一次Hash映射，得到对应的index：

index =  Hash（“apple”）

由于刚才所说的Hash冲突，同一个位置有可能匹配到多个Entry，这时候就需要顺着对应链表的头节点，一个一个向下来查找。假设我们要查找的Key是“apple”：

![0.png](../_resources/6ff928d2047b013e869056ad3bf6ad66.png)

第一步，我们查看的是头节点Entry6，Entry6的Key是banana，显然不是我们要找的结果。

第二步，我们查看的是Next节点Entry1，Entry1的Key是apple，正是我们要找的结果。

之所以把Entry6放在头节点，是因为HashMap的发明者认为，**后插入的Entry被查找的可能性更大**。

![0.jpg](../_resources/4b73408e5ece3f14bd3e1bccb263db89.jpg)

![0.jpg](../_resources/9017f7aae615eeb617759ccbb2e46714.jpg)

![0.jpg](../_resources/3f97176564611edcb10850a861c8e4c7.jpg)

![0.jpg](../_resources/822832e73301572304cbde2265c7c47d.jpg)

![0.jpg](../_resources/4f9dd3c53bb1ba6a27dce61493b8b390.jpg)

![0.jpg](../_resources/822832e73301572304cbde2265c7c47d.jpg)

![0.jpg](../_resources/42223f295e5e19aa86073f71ad7f3ec6.jpg)

![0.jpg](../_resources/822832e73301572304cbde2265c7c47d.jpg)

![0.jpg](../_resources/26cc31e5623bc658fa5ff5bbef3cd1ae.jpg)

![0.jpg](../_resources/f4774f24338d75a2fe0543d58a3b9280.jpg)

————————————

![0.jpg](../_resources/eb0a33df6a9d5ca4e5a03ae99d657353.jpg)

![0.jpg](../_resources/f24bf1fafe0cd246483e8e4bfab1beb0.jpg)

![0.jpg](../_resources/2df5969a95e54bf9d8d749772b898350.jpg)

![0.jpg](../_resources/68d7ab77b04cffc5cea5100b9b461dab.jpg)

![0.jpg](../_resources/99ea4425de06c9b7defd5bb19d236437.jpg)

之前说过，从Key映射到HashMap数组的对应位置，会用到一个Hash函数：

**index =  Hash（“apple”）**

如何实现一个尽量均匀分布的Hash函数呢？我们通过利用Key的HashCode值来做某种运算。

![0.jpg](../_resources/f6005033f59b83f94d99f591467ad7b1.jpg)

**index =  HashCode（**Key**） % Length ?**

![0.jpg](../_resources/f7d095120c41b300a66ea351996d9c63.jpg)

如何进行位运算呢？有如下的公式（Length是HashMap的长度）：

**index =  HashCode（**Key**） &  （**Length **- 1） **
**
**
下面我们以值为“book”的Key来演示整个过程：

1.计算book的hashcode，结果为十进制的3029737，二进制的101110001110101110 1001。

2.假定HashMap长度是默认的16，计算Length-1的结果为十进制的15，二进制的1111。

3.把以上两个结果做**与运算**，101110001110101110 1001 & 1111 = 1001，十进制是9，所以 index=9。

可以说，Hash算法最终得到的index结果，完全取决于Key的Hashcode值的最后几位。

![0.jpg](../_resources/e61ef973fdda34bccf3a2028a2e0c411.jpg)

![0.jpg](../_resources/7ccbac01cd0b52f34c07f283a91b065c.jpg)

假设HashMap的长度是10，重复刚才的运算步骤：

![0.png](../_resources/7425ef68c55b259aaf0cf479a52a5e2a.png)

单独看这个结果，表面上并没有问题。我们再来尝试一个新的HashCode  101110001110101110**1011 **：

![0.png](../_resources/fc786535ce20a9205b6fdc52bbb48943.png)

让我们再换一个HashCode 101110001110101110 **1111 **试试  ：

![0.png](../_resources/285fe73e599aa0d78d77b776bb674b12.png)

是的，虽然HashCode的倒数第二第三位从0变成了1，但是运算的结果都是1001。也就是说，当HashMap长度为10的时候，有些index结果的出现几率会更大，而有些index结果永远不会出现（比如0111）！

这样，显然不符合Hash算法均匀分布的原则。

反观长度16或者其他2的幂，Length-1的值是所有二进制位全为1，这种情况下，index的结果等同于HashCode后几位的值。只要输入的HashCode本身分布均匀，Hash算法的结果就是均匀的。

![0.jpg](../_resources/e5c42c4138777744b4f5ff0935bea887.jpg)

![0.jpg](../_resources/72947fe0c7218ecb90272dc970ea0b14.jpg)

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

> 《> [> 漫画：AES算法的底层原理](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079721&idx=1&sn=14051d02671a63b88ebc9025cfad8455&chksm=f1748d8cc603049a3f1ca982e5ec7d29a8f7a5cf6cd88aadf0c8167c37401f7f8ece66828511&scene=21#wechat_redirect)> 》

> 《> [> 漫画：什么是红黑树？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079739&idx=1&sn=0d42abb857ffbaf7accf31020f7cffe1&chksm=f1748d9ec6030488a8188b550ea98efbfa8cb290265f120e7157fbb6781566525374c72e3457&scene=21#wechat_redirect)> 》

* * *

●本文编号2753，以后想阅读这篇文章直接输入2753即可
●输入m获取文章目录
**推荐↓↓↓**
![0.jpg](../_resources/2c707ec15902f85cfb0c58c78f54aa43.jpg)
**算法与数据结构**

******更多推荐****《**[**18个技术类微信公众号**](https://mp.weixin.qq.com/s?__biz=MzIxNjA5MTM2MA==&mid=2652433904&idx=2&sn=71bb42696ab0b9e47bb60d5750022151&chksm=8c62127fbb159b69f0838c9f47786f0ef615cd0f918ded865361f44b5d8ddde122f46f5e5f34&scene=21#wechat_redirect)**》******

涵盖：程序人生、算法与数据结构、黑客技术与网络安全、大数据技术、前端开发、Java、Python、Web开发、安卓开发、iOS开发、C/C++、.NET、Linux、数据库、运维等。