走进AngularJs(四)自定义指令----（中） - 吕大豹 - 博客园

#   [走进AngularJs(四)自定义指令----（中）](https://www.cnblogs.com/lvdabao/p/3398044.html)

　　上一篇简单介绍了自定义一个指令的几个简单参数，restrict、template、templateUrl、replace、transclude，这几个理解起来相对容易很多，因为它们只涉及到了表现，而没有涉及行为。这一篇将继续学习ng自定义指令的几个重量级参数，了解了它们之后我们的custom directive将不光能“看”，还要能“动”。开始~

## 理解compile和link

　　不知大家有没有这样的感觉，自己定义指令的时候跟写jQuery插件有几分相似之处，都是先预先定义好页面结构及监听函数，然后在某个元素上调用一下，该元素便拥有了特殊的功能。区别在于，jQuery的侧重点是DOM操作，而ng的指令中除了可以进行DOM操作外，更注重的是数据和模板的绑定。jQuery插件在调用的时候才开始初始化，而ng指令在页面加载进来的时候就被编译服务($compile)初始化好了。

　　在指令定义对象中，有compile和link两个参数，它们是做什么的呢？从字面意义上看，编译、链接，貌似太抽象了点。其实可大有内涵，为了在自定义指令的时候能正确使用它们，现在有必要了解一下ng是如何编译指令的。上一篇我有列了一下指令的执行流程，但仅仅列1234有点太对不起观众了，故在此详细分析一下。此知识点相当重要。

### 指令的解析流程详解

　　我们知道ng框架会在页面载入完毕的时候，根据ng-app划定的作用域来调用$compile服务进行编译，这个$compile就像一个大总管一样，清点作用域内的DOM元素，看看哪些元素上使用了指令(如<div ng-modle=”m”></div>)，或者哪些元素本身就是个指令(如<mydierc></mydirec>)，或者使用了插值指令( {{}}也是一种指令，叫interpolation directive)，$compile大总管会把清点好的财产做一个清单，然后根据这些指令的优先级(priority)排列一下，真是个细心的大总管哈~大总管还会根据指令中的配置参数(template，place，transclude等)转换DOM，让指令“初具人形”。

　　然后就开始按顺序执行各指令的compile函数，注意此处的compile可不是大总管$compile，人家带着$是土豪，此处执行的compile函数是我们指令中配置的，compile函数中可以访问到DOM节点并进行操作，其主要职责就是进行DOM转换，每个compile函数执行完后都会返回一个link函数，这些link函数会被大总管汇合一下组合成一个合体后的link函数，为了好理解，我们可以把它想象成葫芦小金刚，就像是进行了这样的处理

[![copycode.gif](走进AngularJs(四)自定义指令----（中）%20-%20吕大豹%20-%20博客园.md#)
//合体后的link函数function AB(){
A(); //子link函数 B(); //子link函数}
[![copycode.gif](走进AngularJs(四)自定义指令----（中）%20-%20吕大豹%20-%20博客园.md#)

　　接下来进入link阶段，合体后的link函数被执行。所谓的链接，就是把view和scope链接起来。链接成啥样呢？就是我们熟悉的数据绑定，通过在DOM上注册监听器来动态修改scope中的数据，或者是使用$watchs监听 scope中的变量来修改DOM，从而建立双向绑定。由此也可以断定，葫芦小金刚可以访问到scope和DOM节点。

　　不要忘了我们在定义指令中还配置着一个link参数呢，这么多link千万别搞混了。那这个link函数是干嘛的呢，我们不是有葫芦小金刚了嘛？那我告诉你，其实它是一个小三。此话怎讲？compile函数执行后返回link函数，但若没有配置compile函数呢？葫芦小金刚自然就不存在了。正房不在了，当然就轮到小三出马了，大总管$compile就把这里的link函数拿来执行。这就意味着，配置的link函数也可以访问到scope以及DOM节点。值得注意的是，compile函数通常是不会被配置的，因为我们定义一个指令的时候，大部分情况不会通过编程的方式进行DOM操作，而更多的是进行监听器的注册、数据的绑定。所以，小三名正言顺的被大总管宠爱~

　　听完了大总管、葫芦小金刚和小三的故事，你是不是对指令的解析过程比较清晰了呢？不过细细推敲，你可能还是会觉得情节生硬，有些细节似乎还是没有透彻的明白，所以还需要再理解下面的知识点：

### compile和link的区别

　　其实在我看完官方文档后就一直有疑问，为什么监听器、数据绑定不能放在compile函数中，而偏偏要放在link函数中？为什么有了compile还需要link？就跟你质疑我编的故事一样，为什么最后小三被宠爱了？所以我们有必要探究一下，compile和link之间到底有什么区别。好，正房与小三的PK现在开始。

         首先是性能。举个例子：
[![copycode.gif](走进AngularJs(四)自定义指令----（中）%20-%20吕大豹%20-%20博客园.md#)
<ul>  <li ng-repeat="a in array">  <input ng-modle=”a.m” />  </li></ul>
[![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)](#)

         我们的观察目标是ng-repeat指令。假设一个前提是不存在link。大总管$compile在编译这段代码时，会查找到ng-repeat，然后执行它的compile函数，compile函数根据array的长度复制出n个<li>标签。而复制出的<li>节点中还有<input>节点并且使用了ng-modle指令，所以compile还要扫描它并匹配指令，然后绑定监听器。每次循环都做如此多的工作。而更加糟糕的一点是，我们会在程序中向array中添加元素，此时页面上会实时更新DOM，每次有新元素进来，compile函数都把上面的步骤再走一遍，岂不是要累死了，这样性能必然不行。

         现在扔掉那个假设，在编译的时候compile就只管生成DOM的事，碰到需要绑定监听器的地方先存着，有几个存几个，最后把它们汇总成一个link函数，然后一并执行。这样就轻松多了，compile只需要执行一次，性能自然提升。

         另外一个区别是能力。尽管compile和link所做的事情差不多，但它们的能力范围还是不一样的。比如正房能管你的存款，小三就不能。小三能给你初恋的感觉，正房却不能。

         我们需要看一下compile函数和link函数的定义：

function compile(tElement, tAttrs, transclude) { ... }function link(scope, iElement, iAttrs, controller) { ... }

         这些参数都是通过依赖注入而得到的，可以按需声明使用。从名字也容易看出，两个函数各自的职责是什么，compile可以拿到transclude，允许你自己编程管理乾坤大挪移的行为。而link中可以拿到scope和controller，可以与scope进行数据绑定，与其他指令进行通信。两者虽然都可以拿到element，但是还是有区别的，看到各自的前缀了吧？compile拿到的是编译前的，是从template里拿过来的，而link拿到的是编译后的，已经与作用域建立了关联，这也正是link中可以进行数据绑定的原因。

　　正房与小三的区别就是性能和能力两个关键字，简记为性能力，我想你永远都不会忘记了吧，真相就是如此的赤裸裸啊~哈哈

　　我暂时只能理解到这个程度了。实在不想理解这些知识的话，只要简单记住一个原则就行了：如果指令只进行DOM的修改，不进行数据绑定，那么配置在compile函数中，如果指令要进行数据绑定，那么配置在link函数中。

## 无奈的结束

　　理解指令的处理流程以及compile和link的区别，花费了我大量的时间。资料太少了，官方文档翻来覆去看，最后理解到了这个程度，但总觉得还是差那么一点，没有100%理解到位。今天太困了，就记录到此处吧，以后有了新的理解再做补充。

　　其实这篇的标题我想写（下）的，直接把scope、require、controller一并介绍完毕，现在看来是不可能了，因为这几个参数也是需要重点理解的，这样下去篇幅又hold不住了。这里就当是预报好了。。。囧。。。以前觉得没有附图和代码示例的博客不是好博客，现在反倒觉得要码出这么多字来，也是需要下功夫的。

分类: [javascript相关](https://www.cnblogs.com/lvdabao/category/536798.html)
标签: [AngularJs](https://www.cnblogs.com/lvdabao/tag/AngularJs/)

 [好文要顶](走进AngularJs(四)自定义指令----（中）%20-%20吕大豹%20-%20博客园.md#)  [关注我](走进AngularJs(四)自定义指令----（中）%20-%20吕大豹%20-%20博客园.md#)  [收藏该文](走进AngularJs(四)自定义指令----（中）%20-%20吕大豹%20-%20博客园.md#)  [![icon_weibo_24.png](走进AngularJs(四)自定义指令----（中）%20-%20吕大豹%20-%20博客园.md#)  [![wechat.png](走进AngularJs(四)自定义指令----（中）%20-%20吕大豹%20-%20博客园.md#)

 [![20160420115610.png](../_resources/e90e52e09e21f5356770cbeea7241522.jpg)](https://home.cnblogs.com/u/lvdabao/)

 [吕大豹](https://home.cnblogs.com/u/lvdabao/)
 [关注 - 24](https://home.cnblogs.com/u/lvdabao/followees/)
 [粉丝 - 1720](https://home.cnblogs.com/u/lvdabao/followers/)

 [+加关注](走进AngularJs(四)自定义指令----（中）%20-%20吕大豹%20-%20博客园.md#)

 [«](https://www.cnblogs.com/lvdabao/p/3391634.html) 上一篇： [走进AngularJs(三)自定义指令-----（上）](https://www.cnblogs.com/lvdabao/p/3391634.html)

 [»](https://www.cnblogs.com/lvdabao/p/3407424.html) 下一篇： [走进AngularJs(五)自定义指令----（下）](https://www.cnblogs.com/lvdabao/p/3407424.html)

posted @ 2013-10-30 22:40 [吕大豹](https://www.cnblogs.com/lvdabao/)  阅读(7191)  评论(7) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=3398044) [收藏](走进AngularJs(四)自定义指令----（中）%20-%20吕大豹%20-%20博客园.md#)