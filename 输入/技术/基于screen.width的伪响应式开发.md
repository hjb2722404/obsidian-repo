基于screen.width的伪响应式开发

##  基于screen.width的伪响应式开发

 *2016-06-13*  [前端大全]()

（点击上方公众号，可快速关注）
****
> 作者：> 张鑫旭（@张鑫旭）

> 链接：> http://www.zhangxinxu.com/wordpress/2016/06/pseudo-response-layout-base-on-screen-width/

**一、站在用户的角度看问题**

一个用户，访问一个web页面的真实场景是怎样的呢？

下面是某用户访问某站点的一个场景：

1. 小明打开了自己的电脑，访问了鑫空间-鑫生活；
2. 小明体内洪荒之力无法控制，疯狂拖动浏览器改变其宽度感受页面布局变化；
3. 卧槽，发现页面居然是响应式的，不由得感叹：实现的够骚气！

![0.jpg](../_resources/aab8c256462b22a662444d9f554c8586.jpg)

很显然，小明要么是雷蜜胡粉心碎抓狂，要不就是前端开发职业病发作难耐。作为真实的用户是不会把浏览器刻意缩小去体验的，你想想看你平时上网的时候，会把浏览器窗口拉到很小吗？怕是嫌屏幕小，恨不得显示器大到铺满办公桌吧~~

**二、回到传统的响应式开发**

传统的响应式实现往往基于基于media query查询，例如：

> @> media screen > and>   > (> max> -> width> : > 480px> )>   > {
>     > /* 窄屏下 */
> }

这是基于CSS的布局控制，因此，当我们缩小浏览器窗口，可以即时看到布局变化。但是，这种实现在我看来，除了让总监大人可以方便体验窄屏效果外，就然并卵了！ 而反倒是有可能增加了额外的资源消耗和开发成本。

@media可以即时控制宽窄布局，很自然地，我们的JS逻辑也要一并跟上。假如说，PC和mobile有很多不同的交互逻辑，我们的HTML是同一套，当我们在响应PC和Mobile零界点不停变换的时候，我们的JS逻辑是不是也要跟着即时变化！

这就导致问题来了，CSS浏览器渲染，本身即时响应。但JS且不一样，我们必须实时监测是PC宽度还是Mobile宽度，同时PC的click事件和Mobile的touch事件可能就在同一个元素上搞基了，也蛮累心的。为了我们自己省心，我们就可能去限制设计师再做响应式设计的时候，两者差异不要太大。我去，技术已经不是帮助产品设计体验升级，而是去制约设计了，贵司的设计师好惨！

还有一个问题就是资源消耗的问题，拿网站头图举例，PC的头图可能是张大大的长图，Mobile是个方方的图片。即时响应也就意味着这两个图都可能会被加载。

那有没有什么办法既能满足响应式的需求，同时我们开发这边不要那么烦心呢？

试试使用screen.width来做伪响应式开发。

**三、screen.width伪响应式开发**

首先要了解下不会说谎的screen.width，screen.width顾名思义就是屏幕的宽度，对，屏幕的宽度，与显示器宽度没有任何关系，就算你把显示器宽度缩小到芝麻糊那么大，screen.width还是不会变。

在“CSSOM视图模式相关整理”一文中有过介绍，IE9以及以上浏览器才支持。

由于screen.width不会说谎，我们就可以瞬间确定用户实现的宽屏设备还是窄屏设备，而@media screen的宽度是浏览器的可用宽度，很容易就被用户欺骗的。

关于screen.width可能的疑问

1. IE7/IE8怎么办？

请问，移动端浏览器会是IE7/IE8吗？明摆着如果不支持screen.width就是PC设备啊。如果有1000和1200的响应结点，按小的来，使用这么挫浏览器的用户的显示器很大概率不会是大屏。

2. 手机如果横着访问会怎样？

根据我在自己手机上的测试，你手机横过来还是竖过来，screen.width都是你屏幕竖着浏览时候的宽度。好比肾6，你横竖浏览，此时screen.width都是375px;

3. PC浏览器如何测试？
测试的话不是缩小浏览器宽度，而是打开控制台，进入手机模式，此时，screen.width也会跟着一起变哦~记得刷新下页面~

![0.png](../_resources/a3f81192f19e3e95f5d31c83d4966ba1.png)

只要我们确认了用户的屏幕尺寸，我们就可以在一开始就确定我们的页面布局以及所需要的交互，例如，可以在标签内放入这么一段内联script:

> (> function> (> doc> ,>   > win> )>   > {

>     > var>   > screenWidth>  = > 0> ,>   > size>  = > 'M'> ,>   > root>  = > doc> .> documentElement> ;

>     > if>   > (> window> .> screen>  & > screen> .> width> )>   > {
>         > screenWidth>  = > screen> .> width> ;
>         > if>   > (> screenWidth>  > > 1920> )>   > {
>             > // 超大屏，例如iMac
>             > size>  = > 'L'> ;
>         > }>   > else>   > if>   > (> screenWidth>   > // 小屏，如手机
>             > size>  = > 'S'> ;
>         > }
>     > }
>     > // 标记CSS
>     > root> .> className>  = > size> ;
>     > // 标记JS
>     > win> .> SIZE>  = > size> ;>
> })(> document> ,>   > window> );

上面的脚本在页面加载的一开始，就确定了是大屏，普通屏还是小屏，然后再执行响应的渲染和脚本执行。您可以根据自己实际项目，修改上面的size变量。

于是乎，我们无论是CSS渲染还是JS逻辑处理，都是1条线下来，完全没有@media screen即时切换而不得已耦合在一起的JS逻辑处理。

![0.png](../_resources/32abc61a1ee90f357a2b06c8a07bfd05.png)

典型的伪响应式代码如下：

> .> S>   > .> example>   > {
>   > /* 移动端的样式 */
> }

> if>   > (> window> .> SIZE>  == > 'S'> )>   > {
>   > // 移动端的处理
> }>   > else>   > {
>   > // 桌面端的处理
> }

考虑到真实的用户使用场景，基于screen.width的伪响应式开发对用户而言，没有任何区别，该什么设备看到的还是那个设备该有的样子；但是，对于开发人员，也就是我们前端开发自己而言，那就不一样了，一条故事线下来，逻辑清晰，处理轻松，设计师把PC和Mobile涉及的差异再明显，我也能从容应对，对吧，if{} else{}里面互不干扰，好轻松~

**四、结语**

本文并不是否决基于media queries的响应式处理，只是提供另外的一个解决问题的思路。如果你的PC和Mobile的有很多不同的逻辑处理，试试这种一棒子打死的“响应式”策略。

然后，本文的策略是经过真实目前在线的有一定分量的项目验证过的，同事认同，Boss认同（除了缩小屏幕没法体验手机），自己跳开了很多坑，更加认同。有机会，你也不妨试试。

【今日微信公号推荐↓】
![640.jpg](../_resources/e8b18bdd54df872b80aac238915fc83a.jpg)

更多推荐请看**《**[值得关注的技术和设计公众号](http://mp.weixin.qq.com/s?__biz=MzAxODE2MjM1MA==&mid=402186355&idx=1&sn=72be66e2caaaebb3cc436b2f5fb6ee0c&scene=21#wechat_redirect)**》**

其中推荐了包括**技术**、**设计**、**极客 **和 **IT相亲**相关的热门公众号。技术涵盖：Python、Web前端、Java、安卓、iOS、PHP、C/C++、.NET、Linux、数据库、运维、大数据、算法、IT职场等。点击《[值得关注的技术和设计公众号](http://mp.weixin.qq.com/s?__biz=MzAxODE2MjM1MA==&mid=402186355&idx=1&sn=72be66e2caaaebb3cc436b2f5fb6ee0c&scene=21#wechat_redirect)》，发现精彩！

![640.jpg](../_resources/8619af60e2e6b27dc06250c838f2647d.jpg)