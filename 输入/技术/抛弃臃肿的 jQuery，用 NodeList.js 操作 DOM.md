抛弃臃肿的 jQuery，用 NodeList.js 操作 DOM

##  抛弃臃肿的 jQuery，用 NodeList.js 操作 DOM

 原创  *2016-07-18*  *伯乐专栏/袁璋*  [前端大全]()

（点击上方公众号，可快速关注）
****
> 原文：Edwin Reynoso
> 译文：伯乐在线 - yuanzhang
> 链接：http://web.jobbole.com/86576/

近年来，jQuery 已经成为 web（开发） 中实际意义上的 JavaScript 库。它解决了许多跨浏览器的不兼容性问题，同时添加了一层受欢迎的语法糖用于客户端的脚本编写。它将 DOM 操作这一大痛处进行了抽象，但是自它出现以来，原生浏览器 API 已经有了显著改善并且也许你并不需要 jQuery的想法开始被人们所接受。

下列是一些原因：

1. jQuery 包含很多你并不需要或不会使用到的功能（因此略显臃肿）。
2. jQuery 很多人来说太过纷繁。通常体积较小的库可以更好的完成特定任务。
3. 就 DOM 操作而言，浏览器 API 如今可以做大多数 jQuery 可以做的事。
4. 浏览器 API 现在更加同步，例如，使用 addEventListener 而非 attachEvent。

**那么还有什么问题呢？**

目前的问题是使用普通的（或原始的）JavaScript 进行 DOM 操作同 jQuery 一样令人厌烦。因为你不得不读写多余的代码，并且处理浏览器中无用的 NodeList 。

让我们先看看 MDN 的描述，什么是 NodeList：

> NodeList 对象是节点集合，如 Node.childNodes 和 document.querySelectorAll 方法的返回值。

以及有时会出现的动态 NodeLists （令人困惑的）：

> 在一些场景下，NodeList 是一个动态集合，也就是说在 DOM 上的操作都会反射到这个集合中。例如，Node.childNodes 就是动态的。

这是个问题因为你无法分辨哪些是动态的，哪些是静态的。除非你移除 NodeList 中的每个节点并检查该 NodeList 是否为空。如果是空的那你拿到的就是一个动态的 NodeList （这并不是个好主意）。

浏览器也没有提供任何有效的办法来操作这些 NodeList 对象。

例如，很不巧这些节点没法通过 forEach 来循环：

> var>   > nodes>  = > document> .> querySelectorAll> (> 'div'> );
> nodes> .> forEach> (> function> (> node> )>   > {
>   > // do something
> });
> // Error: nodes.forEach is not a function

所以你不得不这么干：

> var>   > nodes>  = > document> .> querySelectorAll> (> 'div'> );

> for> (> var>   > i>  = > 0> ,>   > l>  = > nodes> .> length> ;>   > i>  &> lt> ;>   > l> ;>   > i> ++> )>   > {

>   > var>   > node>  = > nodes> [> i> ];
>   > // do something
> }

你甚至只能 “hack” 一下：

> [].> forEach> .> call> (> document> .> querySelectorAll> (> 'div'> ),>   > function> (> node> )>   > {

>     > // do something
> });

浏览器的原生 NodeList 只有一个方法：item。该方法根据下标从 NodeList 返回一个节点。当我们可以通过像数组那样（使用 array[index]）获取到该节点时，这个方法完全无用：

> var>   > nodes>  = > document> .> querySelectorAll> (> 'div'> );
> nodes> .> item> (> 0> )>  === > nodes> [> 0> ];>   > // true

NodeList.js 便应运而生——为了让使用浏览器原生 API 进行 DOM 操作同使用 jQuery 操作一样简单，但压缩后仅为 4k。

**解决方案**

我创建了 NodeList.js ，因为我一直在使用原生 DOM API，而我想让它们更加简洁，以便我在写代码时能去掉很多冗余部分（例如 for 循环）。

NodeList.js 是原生 DOM API 的一个封装，它让你在操作节点数组（也就是我的 NodeList）时像操作单个节点一样。相比浏览器的原生 NodeList 对象，这给你带来了更多的实用性。

如果听上去觉得不错，就到 GitHub 下载官方 repo 并跟随以下教程。

使用：

选择 DOM 节点很简单：

> $$(> selector> );>   > // returns my NodeList

这个方法底层实用的是 querySelectorAll(selector)。

**但它如何与 jQuery 竞争呢？**

很高兴你这么问。让我们对比一下 Vanilla JS，jQuery 和 NodeList.js 。

比如我们现在有三个按钮：

> <> button> ></> button> >
> <> button> ></> button> >
> <> button> ></> button> >

让我们把每个按钮的内容改为 “Click Me”：

原生 JS:

> var>   > buttons>  = > document> .> querySelectorAll> (> 'button'> );>   > // returns browser's useless NodeList

> for> (> var>   > i>  = > 0> ,>   > l>  = > buttons> .> length> ;>   > i>  &> lt> ;>   > l> ;>   > i> ++> )>   > {

>   > buttons> [> i> ].> textContent>  = > 'Click Me'> ;
> }

jQuery:

> $('button').text('Click Me');

NodeList.js:

> $$('button').textContent = 'Click Me';

我们可以看到 NodeList.js 实际上把 NodeList 当做了单一节点。也就是说，我们引用了一个 NodeList 并只是设置它的 textContent 属性为 “Click Me” 而已。随后 NodeList.js 将为我们设置 NodeList 中的每一个节点。 棒极了，对吧？

如果我们想要使用jQuery 中的方法链，可以按下面这样做，它会返回一个 NodeList 的引用：

> $$('button').set('textContent', 'Click Me');

现在我们来给每个按钮添加一个 click 事件监听：

Vanilla JS:

> var>   > buttons>  = > document> .> querySelectorAll> (> 'button'> );>   > // returns browser's useless NodeList

> for> (> var>   > i>  = > 0> ,>   > l>  = > buttons> .> length> ;>   > i>  &> lt> ;>   > l> ;>   > i> ++> )>   > {

>   > buttons> [> i> ].> addEventListener> (> 'click'> ,>   > function> ()>   > {

>     > this> .> classList> .> add> (> 'clicked'> );
>   > });
> }

jQuery:

> $(> 'button'> ).> on> (> 'click'> ,>   > function> ()>   > {
>   > $(> this> ).> addClass> (> 'click'> );
>   > // or mix jQuery with native using `classList`:
>   > this> .> classList> .> add> (> 'clicked'> );
> });

NodeList.js:

> $$(> 'button'> ).> addEventListener> (> 'click'> ,>   > function> ()>   > {
>   > this> .> classList> .> add> (> 'clicked'> );
> });

好的，jQuery 的on 方法很不错。 我的库使用了浏览器的原生 DOM API（因此是 addEventListener），但这并不妨碍我们为这个方法创建一个别名：

> $$.> NL> .> on>  = > $$.> NL> .> addEventListener> ;
>
> $$(> 'button'> ).> on> (> 'click'> ,>   > function> ()>   > {
>   > this> .> classList> .> add> (> 'clicked'> );
> });

漂亮！而且这个确切地演示了添加自定义方法的方式：

> $$.> NL> .> myNewMethod>  = > function> ()>   > {
>   > // loop through each node with a for loop or use forEach:

>   > this> .> forEach> (> function> (> element> ,>   > index> ,>   > nodeList> )>   > {...}

>   > // where `this` is the NodeList being manipulated
> }

**NodeList.js 中的数组方法**

NodeList.js 确实继承自 Array.prototype，但不是直接继承，因为一些方法被修改了以便在NodeList（节点数组）上使用它们时更加合理。

Push 和 Unshift

例如： push 和 unshift 方法只能接收节点（Node）作为参数，否则它们会抛出错误：

> var>   > nodes>  = > $$(> 'body'> );
> nodes> .> push> (> document> .> documentElement> );

> nodes> .> push> (> 1> );>   > // Uncaught Error: Passed arguments must be a Node

push 和 unshift 都会返回 NodeList 以便使用方法链，也就是说这与 JavaScript 的原生方法 Array#push 或 Array#unshift 不同，原生方法会接收任何参数并返回 Array （操作后）的新长度。如果确实想要 NodeList 的长度，只需要使用 length 属性即可。

这些方法都会像 JavaScript 的原生 Array 方法一样更改 NodeList。

Concat

concat 方法可接收以下参数：

- Node
- NodeList (包括浏览器原生的和 NodeList.js 的)
- HTMLCollection
- Node 数组
- NodeList 数组
- HTMLCollection 数组

concat 是一个 递归方法，所以节点数组可以随意嵌套且会被扁平化（译注：Array#reduce 数组扁平化）。但是如果传递的数组不是 Node， NodeList 或HTMLCollection ，则会抛出一个 Error。

同 JavaScript 的 Array#concat 方法一样，concat 也会返回一个新的 NodeList 。

Pop, Shift, Map, Slice, Filter

pop 和 shift 方法都可接收一个可选参数，指定从 NodeList 中 pop 或 shift 的节点数量。这点与 JavaScript 的原生方法 Array#pop 或 Array#shift 不同，原生方法始终会从数组中 pop 或 shift 一个元素并忽略所传递的参数。

对于map 方法，当映射的值都为 Node 时会返回 NodeList`， 否则返回映射值对应的数组。

而 slice 和 filter 方法表现得像真实数组中的一样，也会返回 NodeList。

由于 NodeList.js 不直接继承自 Array.prototype ， 所以如果有方法在 NodeList.js 加载后被添加到 Array.prototype中，那么该方法将不会被继承。

更多关于 NodeList.js 数组方法的详情，请看这里。

**特殊方法**

NodeList.js 有四个独特的方法，以及一个叫做 owner 的属性，该属性等价于 jQuery 的 prevObject 属性。

get 和 set 方法

有一些元素与普通元素不同，拥有独特的属性（例如 标签的 href 属性）。这就是为什么 $$(‘a’).href 会返回 undefined —— 因为该属性不是 NodeList 中的每个元素都会继承的。所以我们将使用 get方法 来访问那些属性：

> $$(> 'a'> ).> get> (> 'href'> );>   > // returns array of href values

set method 方法用来设置各元素的那些属性：

> $$('a').set('href', 'https://sitepoint.com/');

set 方法也会返回 NodeList 以方便使用方法链。我们可以在类似于 textContent 的属性上使用这个方法（以下方法等效）：

> $$(> 'button'> ).> textContent>  = > 'Click Me'> ;

> $$(> 'button'> ).> set> (> 'textContent'> ,>   > 'Click Me'> );>   > // returns NodeList so you can method chain

我们在一次调用中设置多个属性：

> $$('button').set({ textContent: 'Click Me', onclick: function() {...} });

以上所有操作可在任意属性上执行，例如 style :

> $$(> 'button'> ).> style> ;>   >  // this returns an `Array` of `CSSStyleDeclaration`

> $$(> 'button'> ).> style> .> set> (> 'color'> ,>   > 'white'> );

> $$(> 'button'> ).> style> .> set> ({>   > color> : > 'white'> ,>   > background> : > 'lightblue'>   > });

call 方法

call 方法 允许你调用元素上那些独特的方法（例如 video 元素上的 pause 方法）：

> $$('video').call('pause'); // returns NodeList back to allow Method Chaining

item 方法

item 方法 等价于 jQuery 的 eq 方法。该方法返回一个 NodeList（仅包含下标参数所对应的节点）：

> $$('button').item(1); // returns NodeList containing the single Node at index 1

owner 属性

owner 属性 等价于 jQuery 的 preObject。

> var>   > btns>  = > $$(> 'button'> );>
> btns> .> style> .> owner>  === > btns> ;>   > // true

btns.style 返回一个样式数组，而owner则返回映射 style 的NodeList。

**NodeList.js 兼容性**

NodeList.js 兼容所有主流的新浏览器，如下表所示。

| Browser | Version |
| --- | --- |
| FireFox | 6+  |
| Safari | 5.0.5+ |
| Chrome | 6+  |
| IE  | 9+  |
| Opera | 11.6+ |

**结论**

现在我们终于能使用一个令人满意的 NodeList 对象了。

仅 4k 的压缩文件，你就可以获得上述的所有功能，还有更多功能可以在 NodeList.js 的 GitHub 源进行了解。

由于 NodeList.js 依赖于浏览器，因此不需要任何的更新。无论浏览器何时添加新方法/属性到 DOM 元素上，你都可以通过 NodeList.js 使用那些方法/属性。这就意味着你唯一需要担心的就是被浏览器弃用的方法。这些（方法）通常是使用频率很低的，毕竟我们不能逆着大流而上。

那么你怎么看呢？你会考虑使用这个库么？它是否缺少一些重要的功能呢？很乐意听到你的评论。

****

**译者简介 **（ [点击 → 加入专栏作者](http://mp.weixin.qq.com/s?__biz=MzAxODE2MjM1MA==&mid=402764500&idx=1&sn=cfcc178c7718d548b7cdc04758502bd9&scene=21#wechat_redirect) ）

* * *

yuanzhang：#Java 开发#js
![0.png](../_resources/11dacd0e0c804fa8852c549e16b1b660.png)
****打赏支持作者写出更多好文章，谢谢！****

* * *

【今日微信公号推荐↓】
![640.jpg](../_resources/189cdc0e730a487279084a1e622df5dd.jpg)

更多推荐请看**《**[值得关注的技术和设计公众号](http://mp.weixin.qq.com/s?__biz=MzAxODE2MjM1MA==&mid=402186355&idx=1&sn=72be66e2caaaebb3cc436b2f5fb6ee0c&scene=21#wechat_redirect)**》**

其中推荐了包括**技术**、**设计**、**极客 **和 **IT相亲**相关的热门公众号。技术涵盖：Python、Web前端、Java、安卓、iOS、PHP、C/C++、.NET、Linux、数据库、运维、大数据、算法、IT职场等。点击《[值得关注的技术和设计公众号](http://mp.weixin.qq.com/s?__biz=MzAxODE2MjM1MA==&mid=402186355&idx=1&sn=72be66e2caaaebb3cc436b2f5fb6ee0c&scene=21#wechat_redirect)》，发现精彩！

![640.jpg](../_resources/8619af60e2e6b27dc06250c838f2647d.jpg)