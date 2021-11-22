漫画：什么是B+树？

##  漫画：什么是B+树？

 *2017-07-12*  *玻璃猫*  [算法与数据结构](https://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079392&idx=1&sn=6eb4012f9652749f0317ff32bf1df0cf&chksm=f1748ec5c60307d350c7eef45c30238e98c5bf66b4e046caf63c3f01d8ba780822c5af7dc53e&scene=21##)

**> 来自：> 梦见> （微信号：dreamsee321）**

在上一篇漫画中，我们介绍了B-树的原理和应用，没看过的小伙伴们可以点击下面的链接：《[漫画：什么是B-树？》](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079363&idx=1&sn=7c2209e6b84f344b60ef4a056e5867b4&chksm=f1748ee6c60307f084fe9eeff012a27b5b43855f48ef09542fe6e56aab6f0fc5378c290fc4fc&scene=21#wechat_redirect)

这一次我们来介绍B+树。

—————————————————

[640.webp](../_resources/c6e10bfa6320c7f1208842c452fb41a3.webp)
[640.webp](../_resources/85cbce2ab260c378abf4f7ef7f08bf67.webp)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**一个m阶的B树具有如下几个特征：******

1.根结点至少有两个子女。

2.每个中间节点都包含k-1个元素和k个孩子，其中 m/2 <= k <= m

3.每一个叶子节点都包含k-1个元素，其中 m/2 <= k <= m

4.所有的叶子结点都位于同一层。

5.每个节点中的元素从小到大排列，节点当中k-1个元素正好是k个孩子包含的元素的值域分划。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**一个m阶的B+树具有如下几个特征：******

1.有k个子树的中间节点包含有k个元素（B树中是k-1个元素），每个元素不保存数据，只用来索引，所有数据都保存在叶子节点。

2.所有的叶子结点中包含了全部元素的信息，及指向含这些元素记录的指针，且叶子结点本身依关键字的大小自小而大顺序链接。

3.所有的中间节点元素都同时存在于子节点，在子节点元素中是最大（或最小）元素。

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

B-树中的卫星数据（Satellite Information）：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

B+树中的卫星数据（Satellite Information）：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

需要补充的是，在数据库的聚集索引（Clustered Index）中，叶子节点直接包含卫星数据。在非聚集索引（NonClustered Index）中，叶子节点带有指向卫星数据的指针。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

第一次磁盘IO：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

第二次磁盘IO：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

第三次磁盘IO：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**B-树的范围查找过程**
**
**
自顶向下，查找到范围的下限（3）：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

中序遍历到元素6：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

中序遍历到元素8：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

中序遍历到元素9：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

中序遍历到元素11，遍历结束：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**B+树的范围查找过程**
**
**
自顶向下，查找到范围的下限（3）：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

通过链表指针，遍历到元素6, 8：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

通过链表指针，遍历到元素9, 11，遍历结束：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**B+树的特征：******

1.有k个子树的中间节点包含有k个元素（B树中是k-1个元素），每个元素不保存数据，只用来索引，所有数据都保存在叶子节点。

2.所有的叶子结点中包含了全部元素的信息，及指向含这些元素记录的指针，且叶子结点本身依关键字的大小自小而大顺序链接。

3.所有的中间节点元素都同时存在于子节点，在子节点元素中是最大（或最小）元素。

**B+树的优势：******

1.单一节点存储更多的元素，使得查询的IO次数更少。

2.所有查询都要查找到叶子节点，查询性能稳定。

3.所有叶子节点形成有序链表，便于范围查询。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**> 系列文章阅读**

> 《> [> 漫画：什么是跳跃表？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079341&idx=1&sn=f318b7eb864e96661530955567d630ce&chksm=f1748f08c603061e39179745f06a8a567b2f58f8b19a78ab25ec83da666359284ee53c4022aa&scene=21#wechat_redirect)> 》

> 《> [> 漫画：什么是动态规划？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079324&idx=1&sn=b9ea93c3e30b3f85f3175d201b296ef3&chksm=f1748f39c603062ff669ea3507463cfeaa2a7c8aebbe6a03770229afc00614e40df9d7dc148a&scene=21#wechat_redirect)> 》

> 《> [> 漫画算法：最小栈的实现](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652078906&idx=1&sn=404f7c747511a8700b929bb88774c09c&chksm=f17488dfc60301c9d647b3cab401fb801474caaf013b70ab255f483c43abee7216545c334a0c&scene=21#wechat_redirect)> 》

> 《> [> 漫画：什么是B-树？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079363&idx=1&sn=7c2209e6b84f344b60ef4a056e5867b4&chksm=f1748ee6c60307f084fe9eeff012a27b5b43855f48ef09542fe6e56aab6f0fc5378c290fc4fc&scene=21#wechat_redirect)> 》

* * *

●本文编号423，以后想阅读这篇文章直接输入423即可。
●输入m获取文章目录
**推荐↓↓↓**

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

******************************************大数据技术******************************************

**更多推荐：****《**[**18个技术类微信公众号**](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079281&idx=3&sn=619507aa23588c863dc63b7fccb3d80d&chksm=f1748f54c60306421da767ac84959dace23382ac2b3d1cac8bd41203509b8df604f4c8c5a70b&scene=21#wechat_redirect)**》******

涵盖：程序人生、算法与数据结构、黑客技术与网络安全、大数据技术、前端开发、Java、Python、Web开发、安卓开发、iOS开发、C/C++、.NET、Linux、数据库、运维等。

 [ 内容转载自公众号             ![梦见](../_resources/c7522e4f02e964ffa7106aceb09552a4.jpg)         梦见     了解更多](https://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079392&idx=1&sn=6eb4012f9652749f0317ff32bf1df0cf&chksm=f1748ec5c60307d350c7eef45c30238e98c5bf66b4e046caf63c3f01d8ba780822c5af7dc53e&scene=21##)