什么是A*寻路算法？

#  什么是A*寻路算法？

 *2017-09-10*  *玻璃猫*  [算法与数据结构](https://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079616&idx=1&sn=4f1344d07dc1d2f74bcb654b09810ead&chksm=f1748de5c60304f347758d39a5751031414e5c0fc2f758d3e3c638cacc42589953050c1eb817&scene=21##)

**> 来自：梦见（微信号：dreamsee321）**

[640.webp](../_resources/93ff206337cfe934622f91798740a9b7.webp)

[640.webp](../_resources/6383949b759461006fb86c2daefded7b.webp)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

比如像这样子：

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

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**第一步：把起点放入OpenList**

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**第二步：找出OpenList中F值最小的方格，即唯一的方格Node(1,2)作为当前方格，并把当前格移出OpenList，放入CloseList。代表这个格子已到达并检查过了。**

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**第三步：找出当前格上下左右所有可到达的格子，看它们是否在OpenList当中。如果不在，加入OpenList，计算出相应的G、H、F值，并把当前格子作为它们的“父亲节点”。**

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**图中，每个格子的左下方数字是G，右下方是H，左上方是F。**

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**Round2 ~ 第一步：**找出OpenList中F值最小的方格，即方格Node(2,2)作为当前方格，并把当前格移出OpenList，放入CloseList。代表这个格子已到达并检查过了。****

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**Round2 ~ **第二步：找出当前格上下左右所有可到达的格子，看它们是否在OpenList当中。如果不在，加入OpenList，计算出相应的G、H、F值，并把当前格子作为它们的“父亲节点”。****

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**为什么这一次OpenList只增加了两个新格子呢？因为Node(3,2)是墙壁，自然不用考虑，而Node(1,2)在CloseList当中，说明已经检查过了，也不用考虑。**

**Round3 ~ 第一步：**找出OpenList中F值最小的方格。由于这时候多个方格的F值相等，任意选择一个即可，比如Node(2,3)作为当前方格，并把当前格移出OpenList，放入CloseList。代表这个格子已到达并检查过了。****

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**Round3 ~ **第二步：找出当前格上下左右所有可到达的格子，看它们是否在OpenList当中。如果不在，加入OpenList，计算出相应的G、H、F值，并把当前格子作为它们的“父亲节点”。****

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**剩下的就是以前面的方式继续迭代，直到OpenList中出现终点方格为止。这里就仅用图片简单描述了，方格中数字表示F值：**

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

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
public Node aStarSearch(Node start, Node end) {
   // 把起点加入 open list
   openList.add(start);
   //主循环，每一轮检查一个当前方格节点
   while (openList.size() > 0) {
       // 在OpenList中查找 F值最小的节点作为当前方格节点
       Node current = findMinNode();
       // 当前方格节点从open list中移除
       openList.remove(current);
       // 当前方格节点进入 close list
       closeList.add(current);
       // 找到所有邻近节点
       List<Node> neighbors = findNeighbors(current);
       for (Node node : neighbors) {
           if (!openList.contains(node)) {
               //邻近节点不在OpenList中，标记父亲、G、H、F，并放入OpenList
               markAndInvolve(current, end, node);
           }
       }
       //如果终点在OpenList中，直接返回终点格子
       if (find(openList, end) != null) {
           return find(openList, end);
       }
   }
   //OpenList用尽，仍然找不到终点，说明终点不可到达，返回空
   return null;
}

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)

**几点说明：**
1.这里对于A*寻路的描述做了很大的简化。实际场景中可能会遇到斜向移动、特殊地形等等因素，有些时候需要对OpenList中的方格进行重新标记。
2.截图中的小游戏可不是小灰开发的，而是一款经典的老游戏，有哪位小伙伴玩过吗？
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

> 《> [> 漫画：什么是布隆算法？](http://mp.weixin.qq.com/s?__biz=MzI2NjA3NTc4Ng==&mid=2652079596&idx=1&sn=b66a30e0a803ba6514f174b4c3157e40&chksm=f1748e09c603071fc0f4599b6a497ee1ac0f8e114e5782134d2981d486cb4541c9c6ebefa892&scene=21#wechat_redirect)> 》

* * *

●本文编号463，以后想阅读这篇文章直接输入463即可
●输入m获取到文章目录
**推荐↓↓↓**

![](../_resources/bed7781074b6ef20a69762ddaec6093c.png)
**大数据技术**

更多推荐**《**[**18个技术类公众微信**](https://mp.weixin.qq.com/s?__biz=MzIxNjA5MTM2MA==&mid=2652433904&idx=2&sn=71bb42696ab0b9e47bb60d5750022151&chksm=8c62127fbb159b69f0838c9f47786f0ef615cd0f918ded865361f44b5d8ddde122f46f5e5f34&scene=21#wechat_redirect)**》**

涵盖：程序人生、算法与数据结构、黑客技术与网络安全、大数据技术、前端开发、Java、Python、Web开发、安卓开发、iOS开发、C/C++、.NET、Linux、数据库、运维等。