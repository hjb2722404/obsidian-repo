漫画：什么是B-树？

##  漫画：什么是B-树？

 *2017-07-05*  *玻璃猫*  [算法与数据结构](https://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079363&idx=1&sn=7c2209e6b84f344b60ef4a056e5867b4&chksm=f1748ee6c60307f084fe9eeff012a27b5b43855f48ef09542fe6e56aab6f0fc5378c290fc4fc&scene=21##)

**> 来自：> 梦见> （微信号：dreamsee321）**

[640.webp](../_resources/3feab68be93779d3a0b4475fd2c11319.webp)
[640.webp](../_resources/2aee917222245c5d891b9dc5d227e0a6.webp)
[640.webp](../_resources/d01eb3ebd1c04e161a90a0b5d35dd1c6.webp)
[640.webp](../_resources/af75802dff3f759db5d9a56d0f43a507.webp)

————————————

[640.webp](../_resources/48fb7859ea018b3588705476636ed13f.webp)
[640.webp](../_resources/db7954f373c82e4e795172a5877d1589.webp)
[640.webp](../_resources/2567b48572a3eb557da1cebb4bf0347a.webp)
[640.webp](../_resources/6609eca162f9ec0aaf50ac61cea0c9a5.webp)
[640.webp](../_resources/bc8297652962edf6268fc924deb72259.webp)
[640.webp](../_resources/fa0d94b194be4b139bd8716bebb1d18e.webp)
[640.webp](../_resources/a1f571f21ddf05781d540aa9388ae3d8.webp)
[640.webp](../_resources/618a48e071afd7a2cd772cff12a2bffc.webp)
[640.webp](../_resources/03c204abc2a8c14ae302db857caff88c.webp)

————————————

[640.webp](../_resources/1f06ca8e828fce5d7d4112b8783faad6.webp)
[640.webp](../_resources/ed8eca1a0f69e11e14b162538aad230b.webp)
[640.webp](../_resources/13f7edae6ae8af18e80158a3799e33aa.webp)
[640.webp](../_resources/3937e4d5e9bbe0ad0f99870f94c641cc.webp)
[640.webp](../_resources/54b57bf7c31995b6aacea8c286e24f1b.webp)
[640.webp](../_resources/2311ccda0b8d4dbe83b612e2f4963b01.webp)
[640.webp](../_resources/2ba7c4762b8828a23f803c2f6ec5dedc.webp)
[640.webp](../_resources/f65380ed221aff2a3015b13c52b380c2.webp)

[640.webp](../_resources/dfee4af99b9ad213d32d6c19f28e4b3b.webp)
[640.webp](../_resources/1b9a53f3d4f7a100878fe8d2e9ebaf9b.webp)
[640.webp](../_resources/e5382541d63fe707fe70c9606cefdb2d.webp)
[640.webp](../_resources/c521754aaed075e2d13ee3c6705b208b.webp)
[640.webp](../_resources/f118b4f1e977fe5dd7b0523de8067407.webp)
[640.webp](../_resources/efcab3a01541876b2cde8b1d4e927efb.webp)

**二叉查找树的结构：**

[640.webp](../_resources/f6705dd8bd092daf37a4c4613752206f.webp)

**第1次磁盘IO：******

[640.webp](../_resources/db673527ef6f6729a301ad1127b5f579.webp)

**第2次磁盘IO：**

[640.webp](../_resources/a10ecffbc49dbeeb0d326854ebf13cfc.webp)

**第3次磁盘IO：**

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**第4次磁盘IO：**

[640.webp](../_resources/862c1e3d9301aad297f6bdfeea51c393.webp)

[640.webp](../_resources/9ac5ec4fb7f1faf0217ef6f882c3ffe6.webp)

[640.webp](../_resources/458775717edf4dba080f4c4d4b8fb9b6.webp)

[640.webp](../_resources/6cae0121232d4d4b257cc7686e886fa6.webp)
[640.webp](../_resources/4a872e7497aae64e69ed7a29725ce1d6.webp)

**下面来具体介绍一下B-树（Balance Tree），一个m阶的B树具有如下几个特征：**

1.根结点至少有两个子女。

2.每个中间节点都包含k-1个元素和k个孩子，其中 m/2 <= k <= m

3.每一个叶子节点都包含k-1个元素，其中 m/2 <= k <= m

4.所有的叶子结点都位于同一层。

5.每个节点中的元素从小到大排列，节点当中k-1个元素正好是k个孩子包含的元素的值域分划。

[640.webp](../_resources/14a63a94f54628bfc812b6b306be9461.webp)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**第1次磁盘IO：**

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**在内存中定位（和9比较）：**

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**第2次磁盘IO：**
**
**
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**在内存中定位（和2，6比较）：**

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

第3次磁盘IO：

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**在内存中定位（和3，5比较）：**

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

自顶向下查找4的节点位置，发现4应当插入到节点元素3，5之间。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

节点3，5已经是两元素节点，无法再增加。父亲节点 2， 6 也是两元素节点，也无法再增加。根节点9是单元素节点，可以升级为两元素节点。于是**拆分**节点3，5与节点2，6，让根节点9升级为两元素节点4，9。节点6独立为根节点的第二个孩子。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

自顶向下查找元素11的节点位置。

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

删除11后，节点12只有一个孩子，不符合B树规范。因此找出12,13,15三个节点的中位数13，取代节点12，而节点12自身下移成为第一个孩子。（这个过程称为**左旋**）

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

> 系列文章阅读

> 《> [> 漫画：什么是跳跃表？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079341&idx=1&sn=f318b7eb864e96661530955567d630ce&chksm=f1748f08c603061e39179745f06a8a567b2f58f8b19a78ab25ec83da666359284ee53c4022aa&scene=21#wechat_redirect)> 》

> 《> [> 漫画：什么是动态规划？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079324&idx=1&sn=b9ea93c3e30b3f85f3175d201b296ef3&chksm=f1748f39c603062ff669ea3507463cfeaa2a7c8aebbe6a03770229afc00614e40df9d7dc148a&scene=21#wechat_redirect)> 》

> 《> [> 漫画算法：最小栈的实现](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652078906&idx=1&sn=404f7c747511a8700b929bb88774c09c&chksm=f17488dfc60301c9d647b3cab401fb801474caaf013b70ab255f483c43abee7216545c334a0c&scene=21#wechat_redirect)> 》

* * *

●本文编号420，以后想阅读这篇文章直接输入420即可。
●输入m获取文章目录
**推荐↓↓↓**

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
**程序猿**

******更多推荐**：******《**[**18个技术类微信公众号**](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079281&idx=3&sn=619507aa23588c863dc63b7fccb3d80d&chksm=f1748f54c60306421da767ac84959dace23382ac2b3d1cac8bd41203509b8df604f4c8c5a70b&scene=21#wechat_redirect)**》******

涵盖：程序人生、算法与数据结构、黑客技术与网络安全、大数据技术、前端开发、Java、Python、Web开发、安卓开发、iOS开发、C/C++、.NET、Linux、数据库、运维等。