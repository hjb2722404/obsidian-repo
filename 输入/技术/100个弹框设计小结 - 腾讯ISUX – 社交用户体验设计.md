100个弹框设计小结 - 腾讯ISUX – 社交用户体验设计

![87b790c7b73f488fc5725e3a44b3902e.png](../_resources/e9222d11bd5156ddcded48349ffde126.png)
![2d4be75f6d7427437161492aae5c10ec.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/9854991454319c4df70077e123f7c266.png)

# 100个弹框设计小结

##

JHong
最近2年一直在做WebApp相关项目，设计过上百个弹框，其中总结了一些心得，将透过以下文章介绍弹框在Web上的各种应用﹑技巧及表现。

## 什么是弹框?

弹框是一种交互方式，用作提醒，做决定或者解决某个任务。弹框一般包含一个蒙版，一个主体及一个关闭入口，常见于网页及移动端。其好处是让用户更聚焦，且不用离开当前页面，更快更容易完成任务。由于弹框与当下流行的卡片式设计在表现形式上十分接近，同时弹框也逐渐承载了更多功能性需求，不再是简单的内容堆砌，因此弹框设计正在被越来越多设计师关注。![d280ba047ebc910aedc5fa99ee6bd18a.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/42f6ba4cce47ee354092cc00008e143a.png)

## 弹框尺寸怎么定?

在真正着手设计一个弹框时, 第一个遇到的问题就是弹框的尺寸到底要定多大。市面上各种各样尺寸的屏幕分辨率，如果你希望以**一个尺寸适配所有屏幕分辨率**，那可以参考以下数据。

2016年5月中国市场主流电脑分辨率统计Top 5 (资料来源自百度统计)
![c09a587f929f182f638c50e4441de60a.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/7bfb4fdc3e739c9ee3c0d4da90af0661.png)

从上图得知市面上最小的屏幕是1024×768,因此只要保证在这个尺寸放得下, 其他尺寸也肯定没有问题。弹框的宽度一般不会太宽，1000px通常是足够有余的。高度的话，以Windows为例，去掉系统底部功能条的高度及浏览器的高度后，可以得出:

768px – 约60~100px(浏览器高度) – 40px(系统底部工具栏高度) = 约620px
![2da5d368053b33bc61b4c1abcc3e38fa.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/83af29a0573f556b2b7b2400a49b6c40.png)

弹框高度控制在620px以内，可以避免在小屏幕下滚动一点点才能看全整个弹框的尴尬情况。假设弹框本身有滚动条，页面因为超出一屏又有一个全局滚动条，那整个滚动体验就会变得很差。因此从体验角度及开发成本来看，我们一般会把弹框控制在620px高以内，而根据经验所得，这个尺寸内的弹框占了90%场景。

![c543853068632252942d815759ef97e7.png](../_resources/39e287a70e5555b9e2661899f656e216.png)
由于屏幕的尺寸愈来愈大，有时候为了在大屏幕下有更好的视觉表现，对于一些较复杂的弹框，可以选择做2种尺寸适配。拿以下2个例子为例:
Marvel的新建项目弹框中，在大屏幕下，弹框尺寸为640px(宽)x760px(高);

在小屏幕下，选项及Icon则会缩小，弹框尺寸变成了640px(宽)x620px(高)![5be13c1b87d08acd538a766dd6f7cac9.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/ce63776c963027951a667c9776861f91.png)

InVision的升级弹框中，在大屏幕下，列表的行距比较宽松，弹框尺寸为1100px(宽)x800px(高);
在小屏幕下，列表的高度则减小，弹框尺寸为1100px(宽)x630px(高)。
![71f003f1b543e90a399134c07ec42569.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/d7465014e790151b0eab1bc7bf96911b.png)
当然，也可以按屏幕尺寸拉伸面板的尺寸。这裡处理的方法很多，总而言之如果弹框尺寸做得大，就要想好兼容方案，相对设计及开发成本也会增加。

## 弹框的使用场景

在设计时发现经常会遇到一种情况，到底是用弹框还是用页面来承载内容呢?如果了解到弹框的特性后，其实不难分辨什么时候使用那个表现手法更适合。
弹框特性:
– 较页面轻，可以更快回到之前的页面
– 相对独立，可以完全不影响页面的布局
– 适合解决简单，一次性的操作
以下列出了一些较适合使用弹框的场景及案例:

### 1.新手引导

第一感觉是非常重要的。Google+及Carbonmade的新手引导采用了弹框，配上漂亮的插图。这种处理手法美观，不影响页面布局，卡片式的表现手法还能贯穿网页及移动的一致体验。

![d21a6f955c9e61a966c8263a21ae0f01.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/a72cfb56038b4248e5d9aab46102ecf6.png)
Google Photos的新手引导更结合了微动画，效果非常惊艳，让人过目不忘。
![2dd8c98f4c1190203a9ee06f91717ce2.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/b80b8feec1c66786561470a4cb086de6.gif)

### 2.选择器

选择器的特点是用一个内滚区域来承载一个很长的页面，而该内滚区域的高度是可以根据浏览器的高度拉伸的。其好处是除了能放下很长的页面，同时能保留一些操作一直停留在屏幕上。这裡可以选择性的为弹框设置一个最大及最小高度，但要注意的是必须把背景锁定，否则出现2条滚动条的体验是很糟糕的。以QQ公众平台的图文选择器为例:

![bf6f62e97d9a408bc50c35269f34f807.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/b217da1a78003f7090246ebc5e5fbfe3.gif)
Flickr的图片选择器。
![fa333bce6d9a6c08a60b54adf2822c0e.png](../_resources/0015adfea8be3ef67785206d04abee69.png)

### 3.任务

有时候某些任务只是一些简单的操作，并不特地需要一个页面来表现，弹框是一个很好的方法。
Duolingo用插图和icon等视觉元素来丰富任务弹框的表现形式，减轻枯燥感。
![404b2891c98b6b0d1c482dee19d2a5b1.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/44810c2c362cabe0a1cf4e85c7a258ad.png)
Trello的任务弹框虽然信息较多，但好处是能快速切换到不同的任务，增加效率。
![b85000a57515d55c80d1e938b4f9542b.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/330fc0cd1841ceee1ee0d441aec43bf1.png)

### 4.提示

提示是最基础的弹框应用，设计时需记往保持统一性。视觉上的统一性: 颜色，间距，文案风格等。交互的统一性: 主要操作是左边还是右边按钮，关闭是点击蒙版还是点击叉叉。

腾讯企点的提示弹框整理
![2977082d864b8de8a4d43184068fe643.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/21bbdee5d216fd115cead75b93901966.png)

## 几个容易被忽视的弹框细节

### 1.背景锁定与滚动条引起的抖动问题

浏览网页时经常会发现弹框出现后，滚动鼠标时，蒙版下面的页面还是可以滚动的，其实这些滚动都是没必要的，因为弹框的原意就是要聚焦用户的注意力。
因此我们要做的是 – 背景锁定(从技术角度其实是暂时性干掉滚动条)。
![a9affe3b4dc02ce6570d5a706074c810.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/d59ffd74c7595cc2c2e48a6ae540864d.gif)
从前端同学扒出其技术原理如下：
当Dialog弹框出现的时候，根元素overflow:hidden.
![3399219f2e6f8093f7d1e9a75794af47.png](../_resources/3a692c38bb7272c0526b17492044b42f.png)

此时，由于页面滚动条从有到无，页面会晃动，这样糟糕的体验显然是不能容忍了，于是，对<body>元素进行处理，右侧增加一个滚动条宽度（假设宽度是widthScrollbar）的透明边框。

![71fd75059d3744afeee124d2ed08fb50.png](../_resources/bf5e6b79bdb96b61a509be675902ef4a.png)
Dialog隐藏的时候再把滚动条放开。
![75ad48f77bdd9f2b716bad7ce3606296.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/1b46d2f35ce5f31e579f82ac7f1f590b.gif)

### 2.避免弹框上再弹出弹框

要尽量避免在弹框上再弹一层弹框，2层蒙版会让用户觉得负担很重。可以改用轻量弹框或重新把交互梳理。
![ab212f99507605bc2bf346a10658c8e2.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/e3593f37020acd1677cc231e7c69bb24.gif)

### 3.蒙版增强品牌感

过去我们对蒙版颜色可能没有仔细关注过，也许颜色不是纯黑#000，就是纯白#fff。其实蒙版的颜色及透明度可以再深入搭配的，例如产品是蓝色调性的可以在黑色中混入一点蓝色，产品是轻盈的可以用白色或淡灰色，或者尝试用没那么深的颜色搭配高一点透明度等等，根据产品的调性设计出一个适合产品气质的蒙版。

Tumblr的蒙版颜色採用了它的品牌色rgba(54,70,93,.95)
![8e6e1638bf5dc5fbfb2c32f59d819794.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/85d100c364b937012895cb888bf001db.png)
Twitch的蒙版颜色在黑色中混入了一点紫色rgba(32,28,43,.9)，与它的品牌色相符。
![f48b6ef822add2306e3881d12779b6b9.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/d260c27608e09cb6e8666b3b4d1d7bf2.png)

## 對弹框的其他思考

### 未来的趋势

移动在影响著人们生活，也同时引领著设计趋势，这些年产品都在追求多终端的一致性，早已衍生出自适应网页设计(Responsive Web Design)的布局解决方案，因此网页设计也日趋移动化。可以想像将会有一大波移动上的体验会搬到网页设计上，如弹框中包含多个层级，透过左上角返回的交互体验，更灵动及细腻的动画效果等。

![248c840a11e3df1df5fa79fd5e9d93c5.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/c6736bbae268cd06a943243ef939ca37.gif)

视觉表现方面，之前也提到过，将会有更多产品会为了在大屏幕下有更好的视觉效果做出针对性的设计。而随著产品愈来愈追求简洁，UI也变得愈来愈轻盈，甚至透明。弹框也许不再需要用一个框框去包住主体。市面上已经有不少产品使用这种手法，以整个屏幕来取代框框。

这些也许是未来的一个趋势, 让我们拭目以待。
Squarespace的登录弹框
![e18972e125f847e471d6e4202a1968d4.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/e359fb847891f940d5a2b5422859bc2f.png)
Evernote的修改标签弹框
![42e513d6690386f896876abec38710a8.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/ef60a63a78baf7c0a758f38e09a42aca.png)

### 扩展阅读

5 essential ux rules for dialog design
http://babich.biz/5-essential-ux-rules-for-dialog-design/

![ff83d6c323299401ef08fe51978d1da9.jpg](../_resources/8945f80f084f5062a63afebda994c4d1.jpg)
JHong
7 hours前

[交互设计](https://isux.tencent.com/category/id)[视觉设计](https://isux.tencent.com/category/vd)

[上一篇](https://isux.tencent.com/flexbox.html)

[0](https://isux.tencent.com/100%e4%b8%aa%e5%bc%b9%e6%a1%86%e8%ae%be%e8%ae%a1%e5%b0%8f%e7%bb%93.html#comment-form)

0

### 相关推荐

- [![b5c352bab805c146ced4c9cdbf4061a0.png](../_resources/6b3342f07cb65c4bd09938cb382fdfac.png)](https://isux.tencent.com/the-new-isux.html)
- [![6891e5c136c857a0496cdc72940a39cb.jpg](../_resources/dc68765d7c60393e19ecfab20f0c0194.jpg)](https://isux.tencent.com/join-isux-creating-notes.html)
- [![133709255cc3c3704a3867f5152d69a4.png](../_resources/5f0fea7bcb96eb6ead0c3ca0dcc7e8aa.png)](https://isux.tencent.com/%e8%85%be%e4%ba%91%e9%a9%be%e9%9b%be-%e8%85%be%e8%ae%af%e4%ba%91%e5%93%81%e7%89%8c%e9%87%8d%e5%a1%91-brand-new-identity-for-tencent-cloud.html)

## 留下你的想法吧

###

![88b0361b7294e35dbea3a026e4ac9d60.png](../_resources/0fb9ed3620f35edae9aa6e5fb3a11844.png)

[发布]()