JavaScript 的 API 设计原则

##  JavaScript 的 API 设计原则

 *2016-06-25*  [前端大全]()

（点击上方公众号，可快速关注）
****
> 作者：> 卖烧烤夫斯基
> 链接：> http://www.cnblogs.com/constantince/p/5580003.html

**前言**

本篇博文来自一次公司内部的前端分享，从多个方面讨论了在设计接口时的原则，总共包含了七个大块。系卤煮自己总结的一些经验教训。同时也参考了一些文章，地址会在后面贴出来。很难做到详尽充实，如果有好的建议或者不对的地方，还望不吝赐教斧正。

**一、接口的流畅性**

好的接口是流畅易懂的，他主要体现如下几个方面：

**1.简单**

操作某个元素的css属性，下面是原生的方法:

> document.querySelectorAll('#id').style.color = 'red';

封装之后

> function>   > a> (> selector> ,>   > color> )>   > {

>   > document> .> querySelectorAll> (> selector> )[> 0> ].> style> .> color>  = > color

> }
> a> (> '#a'> ,>   > 'red'> );

从几十个字母长长的一行到简简单单的一个函数调用，体现了api简单易用

**2.可阅读性**

a(‘#a’, ‘red’)是个好函数，帮助我们简单实用地改变某个元素，但问题来了，如果第一次使用改函数的人来说会比较困惑，a函数是啥函数，没有人告诉他。开发接口有必要知道一点，人都是懒惰的，从颜色赋值这个函数来说，虽然少写了代码，但是增加了记忆成本。每次做这件事情的时候都需要有映射关系。 a—->color. 如果是简单的几个无所谓，但是通常一套框架都有几十甚至上百的api，映射成本增加会使得程序员哥哥崩溃。 我们需要的就是使得接口有意义，下面我们改写一下a函数：

> function>   > letSomeElementChangeColor> (> selector> ,>   > color> )>   > {
>   > document> .> querySelectorAll> (> selector> ,>   > color> );
> }

letSomeElementChangeColor相对于a来说被赋予了语言意义，任何人都会知道它的意义

**3.减少记忆成本**

我们刚刚的函数也是这样的它太长了letSomeElementChangeColor虽然减少了映射成本，但是增加了记忆成本。要知道，包括学霸在内，任何人都不喜欢被单词。原生获取dom的api也同样有这个问题 document.getElementsByClassName； document.getElementsByName; document.querySelectorAll;这些api给人的感觉就是单词太长了，虽然他给出的意义是很清晰，然而这种做法是建立在牺牲简易性的基础上进行的。于是我们又再次改写这个之前函数

> function>   > setColor> (> selector> ,>   > color> )>   > {
>   > xxxxxxxxxxxx
> }>

在意义不做大的变化前提下，缩减函数名称。使得它易读易记易用；

**4.可延伸**

所谓延伸就是指函数的使用像流水一样按照书写的顺序执行形成执行链条:

> document> .> getElementById> (> 'id'> ).> style> .> color>  = > 'red'> ;
> document> .> getElementById> (> 'id'> ).> style> .> fontSize>  = > '12px'> ;

> document> .> getElementById> (> 'id'> ).> style> .> backgourdColor>  = > 'pink'> ;

用我们之前的之前的方法是再次封装两个函数 setFontSize, setbackgroundColor; 然后执行它们 setColor(‘id’, ‘red’);setFontSiez(‘id’, ’12px’); setbackgroundColor(‘id’, ‘pink’); 显然，这样的做法没有懒出境界来；id元素每次都需要重新获取，影响性能，失败；每次都需要添加新的方法 失败 每次还要调用这些方法，还是失败。下面我们将其改写为可以延伸的函数 首先将获取id方法封装成对象,然后再对象的每个方法中返回这个对象：

> function>   > getElement> (> selector> )>   > {

>   > this> .> style>  = > document> .> querySelecotrAll> (> selector> ).> style> ;

> }
>
> getElement> .> prototype> .> color>  = > function> (> color> )>   > {
>   > this> .> style> .> color>  = > color> ;
>   > return>   > this> ;
> }
> getElement> .> prototype> .> background>  = > function> (> bg> )>   > {
>   > this> .> style> .> backgroundColor>  = > color> ;
>   > return>   > this> ;
> }
> getElement> .> prototype> .> fontSize>  = > function> (> size> )>   > {
>   > this> .> style> .> fontSize>  = > size> ;
>   > return>   > this> ;
> }
>
> //调用
> var>   > el>  = > new>   > getElement> (> '#id'> )

> el> .> color> (> 'red'> ).> background> (> 'pink'> ).> fontSize> (> '12px'> );

简单、流畅、易读后面我们会在参数里面讲到如何继续优化。所以，大家都比较喜欢用jquery的api，虽然一个$符号并不代表任何现实意义，但简单的符号有利于我们的使用。它体现了以上的多种原则，简单，易读，易记，链式写法，多参处理。

nightmare:

> document> .> getElementById> (> 'id'> ).> style> .> color>  = > 'red'> ;
> document> .> getElementById> (> 'id'> ).> style> .> fontSize>  = > '12px'> ;

> document> .> getElementById> (> 'id'> ).> style> .> backgourdColor>  = > 'pink'> ;

dream:

> $('id').css({color:'red', fontSize:'12px', backgroundColor:'pink'})

**二、一致性**

**1.接口的一致性**

相关的接口保持一致的风格，一整套 API 如果传递一种熟悉和舒适的感觉，会大大减轻开发者对新工具的适应性。 命名这点事：既要短，又要自描述，最重要的是保持一致性 “在计算机科学界只有两件头疼的事：缓存失效和命名问题” — Phil Karlton 选择一个你喜欢的措辞，然后持续使用。选择一种风格，然后保持这种风格。

Nightware:

> setColor> ,
> letBackGround
> changefontSize
> makedisplay

dream:

> setColor> ;
> setBackground> ;
> setFontSize
> set> .........

尽量地保持代码风格和命名风格，使人读你的代码像是阅读同一个人写的文章一样。

**三、参数的处理**

**1.参数的类型**

判断参数的类型为你的程序提供稳定的保障

> //我们规定，color接受字符串类型
> function>   > setColor> (> color> )>   > {
>   > if> (> typeof > color>  !== > 'string'> )>   > return> ;
> dosomething
> }

**2.使用json方式传参**

使用json的方式传值很多好处，它可以给参数命名，可以忽略参数的具体位置，可以给参数默认值等等 比如下面这种糟糕的情况:

> function fn(param1, param2...............paramN)

你必须对应地把每一个参数按照顺序传入，否则你的方法就会偏离你预期去执行，正确的方法是下面的做法。

> function>   > fn> (> json> )>   > {
> //为必须的参数设置默认值
>    > var>   > default>  = > extend> ({
>   > param> : > 'default'> ,
>   > param1> : > 'default'
>   > ......
>    > },> json> )
> }

这段函数代码，即便你不传任何参数进来，他也会预期运行。因为在声明的时候，你会根据具体的业务决定参数的缺省值。

**四、可扩展性**

软件设计最重要的原则之一：永远不修改接口，指扩展它！可扩展性同时会要求接口的职责单一，多职责的接口很难扩展。 举个栗子：

> //需要同时改变某个元素的字体和背景
> // Nightmare:
> function>   > set> (> selector> ,>   > color> )>   > {

>   > document> .> querySelectroAll> (> selector> ).> style> .> color>  = > color> ;

>   > document> .> querySelectroAll> (> selector> ).> style> .> backgroundColor>  = > color> ;

> }
>
> //无法扩展改函数，如果需要再次改变字体的大小的话，只能修改此函数，在函数后面填加改变字体大小的代码
>
> //Dream
> function>   > set> (> selector> ,>   > color> )>   > {
>   > var>   > el>  = > document> .> querySelectroAll> (> selector> );
>   > el> .> style> .> color>  = > color> ;
>   > el> .> style> .> backgroundColor>  = > color> ;
>   > return>   > el> ;
> }
>
> //需要设置字体、背景颜色和大小
> function>   > setAgain>   > (> selector> ,>   > color> ,>   > px> )>   > {
>   > var>   > el>  = > set> (> selector> ,>   > color> )
>   > el> .> style> .> fontSize>  = > px> ;
>   > return>   > el> ;
> }

以上只是简单的添加颜色，业务复杂而代码又不是你写的时候，你就必须去阅读之前的代码再修改它，显然是不符合开放-封闭原则的。修改后的function是返回了元素对象，使得下次需要改变时再次得到返回值做处理。

**2.this的运用**

可扩展性还包括对this的以及call和apply方法的灵活运用：

> function>   > sayBonjour> ()>   > {
>   > alert> (> this> .> a> )
> }
>
> obj> .> a>  = > 1> ;
> obj> .> say>  = > sayBonjour> ;
> obj> .> say> ();> //1
> //or
> sayBonjour> .> call> ||> apply> (> obj> );> //1

**五、对错误的处理**

**1.预见错误**

可以用 类型检测 typeof 或者try…catch。 typeof 会强制检测对象不抛出错误，对于未定义的变量尤其有用。

**2.抛出错误**

大多数开发者不希望出错了还需要自己去找带对应得代码，最好方式是直接在console中输出，告诉用户发生了什么事情。我们可以用到浏览器的输出api:console.log/warn/error。你还可以为自己的程序留些后路: try…catch。

> function>   > error>   > (> a> )>   > {
>   > if> (> typeof>   > a>  !== > 'string'> )>   > {
>     > console> .> error> (> 'param a must be type of string'> )
>   > }
> }
>
> function>   > error> ()>   > {
>   > try>   > {
>     > // some code excucete here maybe throw wrong
>   > }> catch> (> ex> )>   > {
>     > console> .> wran> (> ex> );
>   > }
> }

**六、可预见性**

可预见性味程序接口提供健壮性，为保证你的代码顺利执行，必须为它考虑到非正常预期的情况。我们看下不可以预见的代码和可预见的代码的区别用之前的setColor

> //nighware
> function>   > set> (> selector> ,>   > color> )>   > {

>   > document> .> getElementById> (> selector> ).> style> .> color>  = > color> ;

> }
>
> //dream
> zepto> .> init>  = > function> (> selector> ,>   > context> )>   > {
>   > var>   > dom
>   > // If nothing given, return an empty Zepto collection
>   > if>   > (> !> selector> )>   > return>   > zepto> .> Z> ()
>   > // Optimize for string selectors
>   > else>   > if>   > (> typeof > selector>  == > 'string'> )>   > {
>     > selector>  = > selector> .> trim> ()
>     > // If it's a html fragment, create nodes from it
>     > // Note: In both Chrome 21 and Firefox 15, DOM error 12
>     > // is thrown if the fragment doesn't begin with <

>     > if>   > (> selector> [> 0> ]>  == > '<'>  && > fragmentRE> .> test> (> selector> ))

>       > dom>  = > zepto> .> fragment> (> selector> ,>   > RegExp> .$> 1> ,>   > context> ),>   > selector>  = > null

>     > // If there's a context, create a collection on that context first, and select

>     > // nodes from there

>     > else>   > if>   > (> context>  !== > undefined> )>   > return>   > $(> context> ).> find> (> selector> )

>     > // If it's a CSS selector, use it to select nodes.
>     > else>   > dom>  = > zepto> .> qsa> (> document> ,>   > selector> )
>   > }
>   > // If a function is given, call it when the DOM is ready

>   > else>   > if>   > (> isFunction> (> selector> ))>   > return>   > $(> document> ).> ready> (> selector> )

>   > // If a Zepto collection is given, just return it

>   > else>   > if>   > (> zepto> .> isZ> (> selector> ))>   > return>   > selector

>   > else>   > {
>     > // normalize array if an array of nodes is given

>     > if>   > (> isArray> (> selector> ))>   > dom>  = > compact> (> selector> )

>     > // Wrap DOM nodes.
>     > else>   > if>   > (> isObject> (> selector> ))
>       > dom>  = > [> selector> ],>   > selector>  = > null
>     > // If it's a html fragment, create nodes from it
>     > else>   > if>   > (> fragmentRE> .> test> (> selector> ))

>       > dom>  = > zepto> .> fragment> (> selector> .> trim> (),>   > RegExp> .$> 1> ,>   > context> ),>   > selector>  = > null

>     > // If there's a context, create a collection on that context first, and select

>     > // nodes from there

>     > else>   > if>   > (> context>  !== > undefined> )>   > return>   > $(> context> ).> find> (> selector> )

>     > // And last but no least, if it's a CSS selector, use it to select nodes.

>     > else>   > dom>  = > zepto> .> qsa> (> document> ,>   > selector> )
>   > }
>   > // create a new Zepto collection from the nodes found
>   > return>   > zepto> .> Z> (> dom> ,>   > selector> )
> }

以上是zepto的源码，可以看见，作者在预见传入的参数时做了很多的处理。其实可预见性是为程序提供了若干的入口，无非是一些逻辑判断而已。zepto在这里使用了很多的是非判断，同时导致了代码的冗长，不适合阅读。总之，可预见性真正需要你做的事多写一些对位置实物的参数。把外部的检测改为内部检测。是的使用的人用起来舒心放心开心。呐！做人嘛最重要的就是海森啦。

**七、注释和文档的可读性**

一个最好的接口是不需要文档我们也会使用它，但是往往接口量一多和业务增加，接口使用起来也会有些费劲。所以接口文档和注释是需要认真书写的。注释遵循简单扼要地原则，给多年后的自己也给后来者看：

> //注释接口，为了演示PPT用
> function>   > commentary> ()>   > {
>   > //如果你定义一个没有字面意义的变量时，最好为它写上注释：a：没用的变量，可以删除
>   > var>   > a> ;
>
>   > //在关键和有歧义的地方写上注释，犹如画龙点睛：路由到hash界面后将所有的数据清空结束函数
>   > return>   > go> .> Navigate> (> 'hash'> ,>   > function> (){
>     > data> .> clear> ();
>   > });
> }

**最后**

推荐markdown语法书写API文档，github御用文档编写语法。简单、快速，代码高亮、话不多说上图

![0.png](../_resources/133d5d4f6b417fe6e6e42021c8fbbd76.png)

卤煮在此也推荐几个在线编辑的网站。诸君可自行前往练习使用。

https://www.zybuluo.com/mdeditor

http://mahua.jser.me/

参考博文

- 前端头条-javascript的api设计原则（http://top.css88.com/archives/814）

【今日微信公号推荐↓】
![640.jpg](../_resources/189cdc0e730a487279084a1e622df5dd.jpg)

更多推荐请看**《**[值得关注的技术和设计公众号](http://mp.weixin.qq.com/s?__biz=MzAxODE2MjM1MA==&mid=402186355&idx=1&sn=72be66e2caaaebb3cc436b2f5fb6ee0c&scene=21#wechat_redirect)**》**

其中推荐了包括**技术**、**设计**、**极客 **和 **IT相亲**相关的热门公众号。技术涵盖：Python、Web前端、Java、安卓、iOS、PHP、C/C++、.NET、Linux、数据库、运维、大数据、算法、IT职场等。点击《[值得关注的技术和设计公众号](http://mp.weixin.qq.com/s?__biz=MzAxODE2MjM1MA==&mid=402186355&idx=1&sn=72be66e2caaaebb3cc436b2f5fb6ee0c&scene=21#wechat_redirect)》，发现精彩！

![640.jpg](../_resources/8619af60e2e6b27dc06250c838f2647d.jpg)