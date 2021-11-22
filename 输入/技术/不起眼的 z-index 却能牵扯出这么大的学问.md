不起眼的 z-index 却能牵扯出这么大的学问

##  不起眼的 z-index 却能牵扯出这么大的学问

 *2016-05-05*  [前端大全]()

（点击上方公众号，可快速关注）

> 作者：北风吹雪
> 链接：http://www.cnblogs.com/bfgis/p/5440956.html

z-index在日常开发中算是一个比较常用的样式，一般理解就是设置标签在z轴先后顺序，z-index值大的显示在最前面，小的则会被遮挡，是的，z-index的实际作用就是这样。

但是你真的了解z-index吗？你知道它有什么特性吗？这里先抛出几个名词：“层叠顺序（stacking order）”，“层叠上下文（stacking context）”，“层叠水平（stacking level）”。

先说一下z-index的基本用法：

z-index可以设置成三个值：

- auto，默认值。当设置为auto的时候，当前元素的层叠级数是0，同时这个盒不会创建新的层级上下文（除非是根元素，即<html>）；
- <integer>。指示层叠级数，可以使负值，同时无论是什么值，都会创建一个新的层叠上下文；
- inherit。父元素继承

z-index只在定位元素中起作用，举栗子：
```
> <style>
>     > #box1> {
>         > background> :>   > blue> ;
>         > width> :>   > 200px> ;
>         > height> :>   > 200px> ;
>     > }
>     > #box2> {
>         > background> :>   > yellow> ;
>         > width> :>   > 200px> ;
>         > height> :>   > 200px> ;
>         > margin-top> :> -100px> ;
>     > }
>
> </style>
> <div > id> => "box1"> ></div>
> <div > id> => "box2"> ></div>
```
我们希望box1要显示在box2上面，可能这时候有同学会说，给box1加一个z-index大于0的值就可以了，这样是不对的，如图:

![0.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/1d7e9c07565dbb9ae6a35137290012b5.png)

box2遮挡了box1，即使box1设置z-index值再大也白搭，前面说了z-index只在定位元素（position=static除外，因为元素默认就是static，相当于没用position样式）中作用，也是就z-index要配合position一起使用。感兴趣的可以亲自验证一下，这里只抛砖引玉。

**层叠顺序对绝对元素的Z轴顺序**

层叠顺序其实不是z-index独有的，每个元素都有层叠顺序，元素渲染的先后顺序跟它有很大关系，总之当元素发生层叠时，元素的层级高的会优先显示在上面，层级一样的则会根据dom的先后顺序进行渲染，后面的会覆盖前面的。文字再多可能也没有一张图来的直接，下面这张图是“七阶层叠水平”（网上盗的，很经典的一张图）

![0.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/f9e2ec60f8e4b76ca7d4d00383d3e0db.jpg)

再举个栗子，这里还是拿刚才那个栗子来说，在不用z-index的前提下，利用css层叠顺序解决遮挡问题，代码修改如下
```
> <style>
>     > #box1> {
>         > background> :>   > blue> ;
>         > width> :>   > 200px> ;
>         > height> :>   > 200px> ;
>         > display> :> inline-block> ;
>     > }
>     > #box2> {
>         > background> :>   > yellow> ;
>         > width> :>   > 200px> ;
>         > height> :>   > 200px> ;
>         > margin-top> :> -100px> ;
>     > }
>
> </style>
> <div > id> ="box1"></div>
> <div > id> ="box2"></div>
```
这里只做了细微的修改，就是给box1加了一个display:inline-block;的样式，这里解释一下，首先box1和box2发生了层叠，然后box默认为块级元素，即display：block，从七阶图中看出，display：block的元素的层叠水平低于display：inline-block的元素，所以浏览器就将box2渲染到box1上面，如图：

![0.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/a1db61eb24de7f199e0b5b1f578bd771.png)

灵活的运用七阶图可以让你的代码尽可能的减少z-index的使用。因为多个人开发同一个系统，如果过多的用z-index，很有可能会出现冲突，即遮挡问题，一般来说z-index使用10以内的数值就足够了。

**重点：层叠上下文**

先说一下如果创建层叠上下文，css创建层叠上下文的方法有很多，但是常用的也就够那么几种

1. 定位元素中z-index不等于auto的会为该元素创建层叠上下文
2. html根元素默认会创建层叠上下文（这是一个特例，知道就行）
3. 元素的opacity不等于1会创建层叠上下文
4. 元素的transform不等于none会创建层叠上下文

还有其它方式创建层叠上下文，这里就不做介绍了，上面四中是开发中常用到的。

那么知道怎么创建层叠上下文之后，问题的关键来了，层叠上下文有什么用呢？

这里一定要结合前面那张七阶图，最下面那一层background便是是建立在层叠上下文的基础上的，也就是说在层叠上下文中，所有的元素都会渲染在该元素的层叠上下文背景和边框上面；在block盒子、float盒子等不存在层级上下文的元素中，子元素设置z-index为负值的时候，那么子元素会被父元素遮挡。说了可能不太好理解，举个栗子消化一下：
```
> <style>
>     > #box1> {
>         > position> :>   > relative> ;
>         > width> :>   > 200px> ;
>         > height> :>   > 200px> ;
>         > background> :>   > blue> ;
>     > }
>     > #box2> {
>         > position> :>   > relative> ;
>         > z-index> :> -1> ;
>         > width> :>   > 100px> ;
>         > height> :>   > 100px> ;
>         > background> :>   > yellow> ;
>     > }
> </style>
>
> <div > id> => "box1"> >
>       > <div > id> => "box2"> ></div>
> </div>
```
这里，box并没有创建层叠上下文，当子元素box2设置z-index:-1时，box2所在的层叠上下文是根元素，即html根标签，根据七阶图可以看出，box2会渲染在html标签上面，普通盒子box1(z-index:auto)下面，所以box2被遮挡了。如图所示：

![0.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/bc9a5dc68507405a7d6b49f871e8559c.png)

那么怎么解决这个问题呢？相信大家已经知道这里该怎么处理了吧，是的，为box1建立一个层叠上下文，那么box1中的元素无论z-index是负的多少，都会显示在box1的背景之上，如图：

![0.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/f5bad7892d07e2afbf35e263e3ed1b61.png)

这里我用了前面说的的第一种方式去创建层叠上下文，即定位元素中z-index不为auto的元素会建立层叠上下文，可能有的同学开始纳闷了，box1的z-index小于box2的z-index，为什么box2缺显示在box1的上面呢？呵呵，这正对应了七阶图的层叠水平的关系，不明白的再仔细揣摩一下七阶图。

· 层叠水平仅在直接父级层叠上下文中进行比较，即层叠上下文A中的子元素的层叠水平不会和另一个层叠上下文中的子元素进行比较。举个例子
```
> <style>
>     > #box1> {
>         > z-index> :>   > 10> ;
>         > position> :>   > relative> ;
>         > width> :>   > 200px> ;
>         > height> :>   > 200px> ;
>         > background> :>   > green> ;
>     > }
>     > #box1_1> {
>         > position> :>   > relative> ;
>         > z-index> :>   > 100> ;
>         > width> :>   > 100px> ;
>         > height> :>   > 100px> ;
>         > background> :>   > blue> ;
>     > }
>     > #box2> {
>         > position> :>   > relative> ;
>         > z-index> :>   > 11> ;
>         > width> :>   > 200px> ;
>         > height> :>   > 200px> ;
>         > background> :>   > red> ;
>         > margin-top> :>   > -150px> ;
>     > }
> </style>
>
> <div > id> => "box1"> >
>     > <div > id> => "box1_1"> >>
>     > </div>
> </div>
>
> <div > id> => "box2"> >
>
> </div>
```
层叠上下文box1中的子元素box2设置z-index为100，而层叠上下文box2的z-index只有11，而实际的渲染效果却是，box2在box1和box1_1的上面，这就应了上面那就话，层叠水平仅在元素的第一个父级层叠上下文中进行，即层叠上下文A中的子元素的层叠水平不会和另一个层叠上下文中的子元素进行比较，也就是活box1_1的z-index对于他的父级层叠上下文之外的元素没有任何影响。这里box2和box1在同一个层叠上下文中（html根元素会默认创建层叠上下文），所以它们两个会进行层叠水平的比较，box2的z-index大于box1的z-index，所以我们看到的也就是下面这样，box2遮挡了box1，不在乎box1中的子元素z-index是多少，如图：

![0.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/2b5c07862f2ef1799a3bdb2b0bf30e11.png)

这里我对z-index的理解也就讲述完毕了，大概就说了以下这几点内容：

1. z-index仅在定位元素（position不等于static）中有效
2. 七阶层叠水平图
3. z-index层叠水平的比较仅限于父级层叠上下文中

其次需要注意以下几点：

1. 在开发中尽量避免层叠上下文的多层嵌套，因为层叠上下文嵌套过多的话容易产生混乱，如果对层叠上下文理解不够的话是不好把控的。
2. 非浮层元素（对话框等）尽量不要用z-index（通过层叠顺序或者dom顺序或者通过层叠上下文进行处理）
3. z-index设置数值时尽量用个位数

用了一晚上的时间整理了这篇文章，就连我自己对z-index也有了更加深刻的理解，希望对你也有帮助。如有错误 欢迎指正

【今日微信公号推荐↓】
![640.jpg](../_resources/e8b18bdd54df872b80aac238915fc83a.jpg)

更多推荐请看**《**[值得关注的技术和设计公众号](http://mp.weixin.qq.com/s?__biz=MzAxODE2MjM1MA==&mid=402186355&idx=1&sn=72be66e2caaaebb3cc436b2f5fb6ee0c&scene=21#wechat_redirect)**》**

其中推荐了包括**技术**、**设计**、**极客 **和 **IT相亲**相关的热门公众号。技术涵盖：Python、Web前端、Java、安卓、iOS、PHP、C/C++、.NET、Linux、数据库、运维、大数据、算法、IT职场等。点击《[值得关注的技术和设计公众号](http://mp.weixin.qq.com/s?__biz=MzAxODE2MjM1MA==&mid=402186355&idx=1&sn=72be66e2caaaebb3cc436b2f5fb6ee0c&scene=21#wechat_redirect)》，发现精彩！

![0.jpg](../_resources/1bd0e98589fe1541b49e3f092b2aa96f.jpg)
**点击阅读原文，了解野狗**

 [阅读原文]()