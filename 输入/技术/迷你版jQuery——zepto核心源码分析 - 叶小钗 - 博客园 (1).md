迷你版jQuery——zepto核心源码分析 - 叶小钗 - 博客园

# 迷你版jQuery——zepto核心源码分析

# 前言

zepto号称迷你版jQuery，并且成为移动端dom操作库的首选
事实上zepto很多时候只是借用了jQuery的名气，保持了与其基本一致的API，其内部实现早已面目全非！
艾伦分析了jQuery，小钗暂时没有那个本事分析jQuery，这里就恬不知耻说说自己对zepto的源码理解，希望对各位有用
首先zepto的出现其实还是很讨巧的，他看见了巨人jQuery在移动浪潮来临时的转身慢、牵挂多的问题
马上搞出了一套轻量级类jQuery框架代码，核心代码1000行不到，快速占领了移动端的市场，所以天下武学无坚不摧，为快不破啊！！！
也如艾伦所言，jQuery狭义的讲其实就是dom操作库
zepto将这点发扬光大，并且抛弃了浏览器兼容的包袱，甚至CSS3的前缀都不给加，这些因素造就了zepto小的事实，于是我们开始学习他吧
此文只是个人对zepto的粗浅理解，有误请提出

# 核心组成

zepto现在也采用了模块拆分，这样读起来其实代码十分清晰，门槛也低了很多，整个zepto核心模块保持在900行以内
我们说他很好的发扬了dom库特点便是因为这900行基本在干dom操作的活
核心模块有以下部分组成：

### ① 闭包变量、工具类方法定义

这个部分主要为后面服务，比如说什么isFunction/isPlainObject/children
其中有一个比较特别的变量是
zepto = {};
这个变量贯穿始终，也是zepto与jQuery很不一样的地方，jQuery是一个类，会创建一个个实例，而zepto本身就只是一个对象......

### ② zepto与jQuery的$

zepto第二阶段干的事情便是定义了一个类
$ = function(selector, context){
return zepto.init(selector, context)
}
而我们开始便说了zepto只是一个对象，而zepto.init也仅仅是返回了一个类数组的东西，于是我们这里便看到了zepto与jQuery的惊人差异
第一观感是zepto没有类操作！我们使用$('')的操作返回的也是zepto的实例
$对于zepto来说仅仅是一个方法，zepto却使用了非正规手法返回了实例......
![251535118381584.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231165937.png)
![251535173221408.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231165942.png)

从这里看整个zepto其实和jQuery就差距大了，zepto的方法返回了一个Object的实例，而jQuery的方法返回了一个Object的实例，而jQuery的返回的是真资格的jQuery对象

而从后面看其实zepto也是返回的一个实例但是与jQuery的实现有所不同，那么zepto是怎么实现实例返回的呢？

### ③ zepto与jQuery的$.fn

我们知道jQuery的$.fn指向的是jQuery.prototype的原型对象，而zepto的fn就是一个简单对象
$.fn = {};
zepto的第三部分便是扩展函数，我们使用的函数，我们使用的的方法事实上都是其静态方法，与原型链一毛钱关系都没有
以上便是zepto核心模块的实现，很干净的实现，仅仅是dom操作，不涉及事件或者Ajax操作，简单来说zepto的实现是这个样子的
1 var zepto = {}, $;
2 3 zepto.init = function (selector, context) {
4 var domArr = [];
5 //这个__proto__是系统级变量，我觉得zepto不该重置 ，但是不重置的话实例便找不到方法了！！！
6 domArr.__proto__ = $.fn
7 domArr.selector = selector;
8 //一些列操作
9 return domArr;
10 };
11 12 $ = function (selector, context) {
13 return zepto.init(selector, context);
14 };
15 16 $.fn = {
17 addClass: function () { },
18 attr: function () { }
19 };
这里有段非常关键的代码是：
domArr.__proto__ = $.fn；
如果是没有这段代码的话， domArr便是属于array的实例，便不能使用$.fn中的方法了，但是他这里重置了__proto__的指向所以就能用了
PS：由于IE是不认这个属性的，所以IE必定会报错
由于这里的改下，本来domArr也会有一些变化：
1 dom.__proto__.constructor
2 function Array() { [native code] }
3 4 dom.__proto__.constructor
5 function Object() { [native code] }
6 7 zepto.Z = function(dom, selector) {
8 dom = dom || []
9 dom.__proto__ = $.fn
10 dom.selector = selector || ''
11 return dom
12 }
13 //最后加上一句：
14 zepto.Z.prototype = $.fn
如此一来，我们所有的$方法返回的东西其实就变成了zepto.Z的实例了，这里的实现原理其实也有点绕口：
构造函数zepto.Z 包含一个原型 $.fn（zepto.Z的prototype被重写了）
原型$.fn具有一个Constructor回值构造函数zepto.Z（这里由于其粗暴的干法其实直接指向了Object，这里关系其实已经丢失）
比较不正经的是居然是通过重写__proto__实现，感觉怪怪的，好了核心模块介绍结束，我们便进入入口函数的解析了

## 分解$方法

$是zepto的入口，具有两个参数selector选择器与context选择范围，这里看着是两个参数，事实上各个参数不同会造成不同的实现

方法相当于一个黑盒子，用户会根据自己的想法获得自己想要的结果，这也会导致方法相当于一个黑盒子，用户会根据自己的想法获得自己想要的结果，这也会导致的实现变得复杂：

1 $('div');
2 //=> all DIV elements on the page
3 $('#foo');
4 //=> element with ID "foo"
5 6 // create element:
7 $("<p>Hello</p>");
8 //=> the new P element
9 // create element with attributes:
10 $("<p />", {
11 text: "Hello",
12 id: "greeting",
13 css: { color: 'darkblue' }
14 });
15 //=> <p id=greeting style="color:darkblue">Hello</p>
16 17 // execute callback when the page is ready:
18 $(function ($) {
19 alert('Ready to Zepto!')
20 });
我们现在来分析其每一种实现

### 选择器

zepto主要干的事情还是做dom选择，这里包括标签选择、id选择、类选择等，少了sizzle的复杂，直接使用了querySelectorAll的实现真的很偷懒

PS：同一个页面出现相关相同id的话querySelectorAll会出BUG，这个大家要小心处理！！！
这里筛选的流程是：
① 执行$(selector)方法
② 执行zepto.init(selector)方法，init里面的逻辑就有点小复杂了
判断selector是不是一个字符串，这里需要是干净的字符串，并且context为undefined（这里差距不大，了不起是查找范围的问题）
③ 经过上述逻辑处理，高高兴兴进入zepto.qsa(document, selector)逻辑
这里的逻辑比较简单直接调用判断下选择器的类型（id/class/标签）就直接使用对应的方法获取元素即可
![ContractedBlock.gif](../_resources/1c53668bcee393edac0d7b3b3daff1ae.gif)View Code

### 创建元素

$方法的第二大功能便是创建元素了，比如我们这里的
$("<p>Hello</p>");
这里依旧会经过zepto.init的处理，判断是否具有尖括号(<)，有的话便会进入神奇的fragment逻辑创建文档碎片
dom = zepto.fragment(selector, RegExp.$1, context)
这里有一个正则表达式对传入的html进行解析，目标是标签名
PS：zepto对p标签的解析也会出问题，不建议使用
zepto.fragment = function(html, name, properties) {}
到fragment方法时，会传入html和那么并且会有相关属性，但是我们一般不这样干，仅仅希望创建DOM
![ContractedBlock.gif](../_resources/1c53668bcee393edac0d7b3b3daff1ae.gif)View Code
里面的逻辑各位自己去看，我这里不多说了，还是很简单的，大概的想法是
创建一个空的div元素，将字符串装载，然后遍历div的子元素，最后返回一个node的集合数组，这个也就是我们实际需要的......
这个样子，创建标签或者selector选择器得到的结果是一致的
其它逻辑大同小异，我们直接就过了，zepto核心入口逻辑就到此结束了......

## fn的实现

fn中包含了zepto的很多功能，要一一说明就多了去了，首先由$扩展开始说
除了原型扩展外还为$包含了很多静态方法，比如什么uuid，isFunction，然后就开始了原型链扩展之路
$.fn与zepto.Z.prototype指向的是同一空间，这里达到了是扩展原型链的效果
![251546067445839.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231165948.png)
这里抽2个常用API来看看，比如这里的attr
attr: function(name, value){
var result
return (typeof name == 'string' && value === undefined) ?
(this.length == 0 || this[0].nodeType !== 1 ? undefined :
(name == 'value' && this[0].nodeName == 'INPUT') ? this.val() :

(!(result = this[0].getAttribute(name)) && name in this[0]) ? this[0][name] : result

) :
this.each(function(idx){
if (this.nodeType !== 1) return
if (isObject(name)) for (key in name) setAttribute(this, key, name[key])

else setAttribute(this, name, funcArg(this, value, idx, this.getAttribute(name)))

})
},
function setAttribute(node, name, value) {
value == null ? node.removeAttribute(name) : node.setAttribute(name, value)
}
我们看到他这里直接将其转换为了元素DOM操作，没有什么好说的，只是如果value不为undefined时，里面有一个循环为属性赋值的动作
再看这里的html接口
html: function(html){
return arguments.length === 0 ?
(this.length > 0 ? this[0].innerHTML : null) :
this.each(function(idx){
var originHtml = this.innerHTML
$(this).empty().append( funcArg(this, html, idx, originHtml) )
})
},
function funcArg(context, arg, idx, payload) {
return isFunction(arg) ? arg.call(context, idx, payload) : arg
}
这里其实是先将this清空，然后装载新的dom结构，这里与设置innerHTML有所不同，append会执行其中的js，设置innerHTML不会执行
剩下的接口有兴趣的朋友自己去看吧，zepto这里实现还是比较简单的。

这里值得一说的是，一些API你直接去看可能看不懂，这个时候就动手写写，实现相同的功能，然后对代码进行重构，最后重构下来代码和他写的就差不多了，这里并不是代码难，而是他那种写法不太好看。

# 事件实现

一个稍微成熟点的框架或者说稍微成熟点的团队，一般会对原生的一些东西进行封装，原因是他们可能需要扩展非常典型的例子便是事件与settimeout

以setTimeout为例，在webapp中每次view的切换应该清理所有的settimeout，但是我们知道clearTimeout()是必须传入id的，所以我们不能这么干

现在回到javascript事件这块，最初事件的出现可能仅仅是为了做浏览器兼容
那么现在我们依旧会使用zepto提供的事件主要原因就是其扩展的一些功能，比如委托与命名空间等，最重要的还是事件句柄移除
javascript事件的移除很是严苛，要求必须与之一致的参数，比如：
el.addEventListerner(type, fn, capture);
el.removeEventListerner(type, fn, capture);
两者参数需要完全一致，而我们的fn很多时候就是个匿名函数甚至是对象，很多时候定义后句柄引用就丢了，我们根本没法将其保持一致
这个时候这个句柄便无法释放，所以我们需要对事件进行封装，我们这里便进入zepto event的实现，学习这个还是看入口点

## 事件注册

简单来说使用zepto绑定事件一般是这样：
① $.on(type, fn)
② $.bind(type, fn)
③ $.click(fn)
④ ......
事实上，这些方式差距不大，特别是第二种只是做了一个语法糖，比如：
$.click = function (fn) {
return this.bind('click', fn);
}
事实上他还是调用的$.bind实现事件绑定，换个思维方式，其实整个zepto事件实现可以浓缩成这么几句话：
var eventSet = {
el: {fnType: []}
};
function on(type, fn) {}
function off(type, fn) {}
这个便是zepto事件核心代码......当然这里还差了一个trigger，这里便是与传统自建系统不一样的地方，他的触发是通过浏览器处理
这个是一个标准的发布订阅系统，我们对浏览器的操作会生产事件，这个时候浏览器会根据我们的行为通知对应的事件接收者处理事件
所有的绑定最终调用的皆是$.on，而on或者off的最终归宿为局部闭包add和remove方法
![ContractedBlock.gif](../_resources/1c53668bcee393edac0d7b3b3daff1ae.gif)View Code
这里的event可以是以空格分隔的字符串，一般情况下是单一的事件
event => 'mousedown touchstart'
event => 'click'
然后这里开始了处理逻辑：
① 参数处理
第一步当然是做参数处理，会修正参数，比如你没有传事件句柄，这里会给个默认的，然后开始循环绑定，因为我们使用$()返回的是一个数组
进入循环逻辑后，this与element便是真资格的dom元素了，未经雕琢，开始是对one的处理，我们不予关注，继续向下便进入第一个关键点
简单情况下我们的selector为undefined，所以这里错过了一个事件委托的重要逻辑，我们先不予理睬，再往下便进入了闭包方法add了
这个情况下selector与delegator为undefined，仅仅是前3个参数有效
![251604149008000.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231165954.png)
add在event事件中扮演了重要的角色
![ContractedBlock.gif](../_resources/1c53668bcee393edac0d7b3b3daff1ae.gif)View Code
第一段代码就很重要：
var id = zid(element)
function zid(element) {
return element._zid || (element._zid = _zid++)
}

这里的zid非常关键，这里的element为与原生对象，这里在上面加了一个_zid的属性，这个属性会跟随其由始至终，不会丢失，如果是zepto封装的dom对象的话，就很容易丢失，因为每次根据$()创建的dom都是新的，这个_zid放到原生属性上是很有意义的

第二个变量也很关键：
set = (handlers[id] || (handlers[id] = []))
我们所有绑定的事件以_zid为键值放在了外部闭包环境handlers对象中，每一个id对应的为一个数组，这个与绑定先后顺序相关
然后进入具体绑定逻辑：

完了这里会考虑是'mousedwon touchstart'的情况所以会有一个循环，我们这里由于只是click便不予理睬了，ready事件我们也直接忽略，进入逻辑后关键点来了

这里定义了一个handler对象，这个对象会存于handlers里面
var handler = parse(event)
handler.fn = fn
handler.sel = selector
function parse(event) {
var parts = ('' + event).split('.')
return {e: parts[0], ns: parts.slice(1).sort().join(' ')}
}
这里会解析event参数，取出其中的命名空间，比如:'click.ui'或者'click.namespace'
返回的对象，第一个是真正绑定的事件Type，第二个是其命名空间：
handler = {
e: 'click',
ns: ''//我这里为null }
后面再为handler对象扩展fn与selector属性，这里的fn尤其关键！！！
我们知道，绑定时若是使用的是匿名函数的话，其引用会丢失，但是这里就把他保持下来存到了handlers中，为后面off消除句柄提供了条件
下面会有段代码，处理mouse事件，用以模拟mouseenter, mouseleave，我们简单来看看其实现：
// emulate mouseenter, mouseleave
if (handler.e in hover) fn = function(e){
var related = e.relatedTarget
if (!related || (related !== this && !$.contains(this, related)))
return handler.fn.apply(this, arguments)
}
$.contains = function(parent, node) {
return parent !== node && parent.contains(node)
}
relatedTarget 事件属性返回与事件的目标节点相关的节点。
对于 mouseover 事件来说，该属性是鼠标指针移到目标节点上时所离开的那个节点。
对于 mouseout 事件来说，该属性是离开目标时，鼠标指针进入的节点。
对于其他类型的事件来说，这个属性没有用。
所以我们使用mouseenter，其实mousemove依旧一直在执行，只不过满足要求才会进入mouseleave绑定的回调
这里结束便进入事件绑定的真正逻辑，这里又为handler新增了一个proxy属性，将真实的事件回调封装了，封装的主要原因是做事件代理，事件代理一块我们先不关注
我们看到proxy将我们的回调fn（已经变成了callback），做一次封装，直接为element注册事件了，其影响会在触发时产生：
![ContractedBlock.gif](../_resources/1c53668bcee393edac0d7b3b3daff1ae.gif)View Code
触发事件时他这里首先会对事件参数event做一次封装返回，首先将三大事件对象进行新增接口
![251610223857498.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231165958.png)
这里重置的一个原因是处理stopImmediatePropagation不支持的浏览器
然后会执行真正的回调，这里会传入相关参数，并将作用域指向element，于是事件注册到事件定义第一阶段结束
不一样的是事件委托，比如：
el1.on('click', '#Div1', function (e) {
s = '';
});
具有selector参数后在add处便会处理不一致，会多出一段逻辑将真正的回调重置了
if (selector) delegator = function(e){
var evt, match = $(e.target).closest(selector, element).get(0)
if (match && match !== element) {
evt = $.extend(createProxy(e), {currentTarget: match, liveFired: element})

return (autoRemove || callback).apply(match, [evt].concat(slice.call(arguments, 1)))

}
}
这段代码也很经典，他的影响依旧发生在执行的时候（这里在add中依旧会被再次处理），首先这里比较关键的代码是
match = $(e.target).closest(selector, element).get(0)
这个会根据当前点击最深节点与selector选择器选择离他最近的parent节点，然后判断是否找到，这里条件还必须满足找到的不是当前元素
如果找到了，会对event参数做一次处理，为其重写currentTarget属性，让他指向与selector相关的节点（这点很关键）
function createProxy(event) {
var key, proxy = { originalEvent: event }
for (key in event)

if (!ignoreProperties.test(key) && event[key] !== undefined) proxy[key] = event[key]

return compatible(proxy, event)
}
这里可以看到，我们如果为document下面的三个元素绑定事件代理，每次点击几次便会执行几次事件，只不过会判断是否进入处理逻辑而已
这里举个div与span的例子，如果父级div（wrapper）下面分别为div和span绑定事件的话
$('#wrapper').on('click', '#span', fn);
$('#wrapper').on('click', '#div', fn);

这个事实上会为为wrapper绑定两个click事件，我们每次点击wrapper区域都会执行两次click事件，但是是否执行span或者div的事件，要看这里是否点击到了其子节点（e.target）

这里处理结束后会进入add方法，与刚刚的逻辑一致，我们便不予理睬了，只是事件代理的情况下event参数连续被compatible了，而原始的事件句柄也被包裹了两层

## 事件移除

事件绑定说完，事件移除便比较简单了，入口是off，统一处理存于闭包remove方法中
![ContractedBlock.gif](../_resources/1c53668bcee393edac0d7b3b3daff1ae.gif)View Code
代码比较简单，可以直接进入remove的逻辑
![251614529631370.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231170002.png)
这里有一点值得注意的是，这里的this指向的是原生dom，并且大家注意到里面的_zid，callback或者selector我们一般不使用
function remove(element, events, fn, selector, capture){
var id = zid(element)
;(events || '').split(/\s/).forEach(function(event){
findHandlers(element, event, fn, selector).forEach(function(handler){
delete handlers[id][handler.i]
if ('removeEventListener' in element)

element.removeEventListener(realEvent(handler.e), handler.proxy, eventCapture(handler, capture))

})
})
}
事件注册逻辑复杂，删除却只需要几行，在remove时，这里会根据元素的_zid然后调用findHandlers取出存于闭包handlers里面的事件对象
1 function findHandlers(element, event, fn, selector) {
2 event = parse(event)
3 if (event.ns) var matcher = matcherFor(event.ns)
4 return (handlers[zid(element)] || []).filter(function(handler) {
5 return handler
6 && (!event.e || handler.e == event.e)
7 && (!event.ns || matcher.test(handler.ns))
8 && (!fn || zid(handler.fn) === zid(fn))
9 && (!selector || handler.sel == selector)
10 })
11 }
这里有个非常巧妙的地方是我们可以根据之前的namespace取出我们注册的事件集合，比如：
![251615473389258.png](../_resources/fb526607bbce2fb4ef9e90af8f279d41.png)
findHandlers处理结束便进入最后的的句柄移除操作即可
![251616068853185.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231170006.png)

而这里能移除句柄的关键又是在于之前将事件句柄handler.proxy保存下来的原因，至此整个event逻辑结束，值得注意的是element的_zid标识还在，

至于trigger简单来说便是创建一个event事件对象然后dispatch，仅此而已

## 手势处理

zepto提供了一个touch库进行手势事件的补充，不得不说其中一个实现很有问题，会造成一些莫名其妙的BUG，但只是以代码实现来说还是很清晰的
zepto的touch库代码约150行，其实现方案是：

在载入zepto后为document绑定touchstart、touchmove、touchend事件，根据手指x、y值的位置判断方向从而触发tap、doubleTap、swipeLeft等事件，这里有几个令人不爽的地方：

① 一旦引入该库便在全局绑定事件，每次点击皆会触发无意义的tap事件
② 若是有人2B的重复引入了zepto事件，那么tap类型事件会触发两次，这个会产生BUG
③ zepto为了实现doubleTap等功能，2B的在touchend时候设置了一个settimeout，然后整个世界都充满翔了

由于setTimeout的抛出主干流程，导致其event参数失效，这个时候就算在tap中执行e.preventDefault()或者什么都是无效的，这个是导致zepto tap“点透”的罪魁祸首

所以我们若是仅仅为了某块区域的手势功能，完全没有必要引入zepto库，得不偿失的，我们可以以下面代码简单替换，再复杂的功能就没法了：
![ContractedBlock.gif](../_resources/1c53668bcee393edac0d7b3b3daff1ae.gif)View Code

# 其它

您可以考虑给小钗发个小额微信红包以资鼓励
![294743-20151106140817867-146017888.jpg](../_resources/6cf9b3d6726504c72171114667f23bb6.jpg)
上海-B站招聘靠谱前端（3年左右工作经验），喜欢二次元的小伙伴私聊！

posted on 2014-07-25 17:04 [叶小钗](http://www.cnblogs.com/yexiaochai/) 阅读(21152) 评论(16) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=3868133)  [收藏](http://www.cnblogs.com/yexiaochai/p/3868133.html#)

**评论:**

[#1楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#2994701)2014-07-25 17:16 | [笔端红翠](http://home.cnblogs.com/u/587238/)

竟然是刀狂剑痴 道友不容易啊。

[#2楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#2994715)[楼主] 2014-07-25 17:25 | [叶小钗](http://www.cnblogs.com/yexiaochai/)

[@](http://www.cnblogs.com/yexiaochai/p/3868133.html#2994701)笔端红翠
妹子好
http://pic.cnblogs.com/face/u294743.jpg?id=23185449

[#3楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#2994761)2014-07-25 18:02 | [清香白莲素还真](http://www.cnblogs.com/yang73137/)

我发现我的武力值越来越接近我的嘴炮了。

[#4楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#2994763)[楼主] 2014-07-25 18:04 | [叶小钗](http://www.cnblogs.com/yexiaochai/)

[@](http://www.cnblogs.com/yexiaochai/p/3868133.html#2994761)清香白莲素还真
原来此ID在你这里，最近还在看剧么，看金光吧，霹雳没落了，不好看
http://pic.cnblogs.com/face/u294743.jpg?id=23185449

[#5楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#2994778)2014-07-25 18:37 | [清香白莲素还真](http://www.cnblogs.com/yang73137/)

[#6楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#2994822)2014-07-25 21:02 | [bjtqti](http://www.cnblogs.com/afrog/)

天下武学无坚不摧，为快不破啊！！
http://pic.cnblogs.com/face/545140/20140705165158.png

[#7楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#2994826)[楼主] 2014-07-25 21:14 | [叶小钗](http://www.cnblogs.com/yexiaochai/)

[@](http://www.cnblogs.com/yexiaochai/p/3868133.html#2994822)bjtqti
天下武学无坚不摧，唯快不破啊！！
http://pic.cnblogs.com/face/u294743.jpg?id=23185449

[#8楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#2995406)2014-07-27 17:01 | [阿布都拉](http://home.cnblogs.com/u/598707/)

看你一篇博客， 胜读十年书！！！

[#9楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#2998983)2014-08-01 18:33 | [例维亚的杰洛特](http://www.cnblogs.com/scwlwj/)

顶一下，又顶一下
http://pic.cnblogs.com/face/525275/20140607093118.png

[#10楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#3025448)2014-09-10 09:23 | [方方和圆圆](http://www.cnblogs.com/diligenceday/)

加油哦@叶小钗
http://pic.cnblogs.com/face/497865/20150117172039.png

[#11楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#3025449)2014-09-10 09:23 | [方方和圆圆](http://www.cnblogs.com/diligenceday/)

[@](http://www.cnblogs.com/yexiaochai/p/3868133.html#2994715)叶小钗
妹子好，
http://pic.cnblogs.com/face/497865/20150117172039.png

[#12楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#3025450)2014-09-10 09:24 | [方方和圆圆](http://www.cnblogs.com/diligenceday/)

[@](http://www.cnblogs.com/yexiaochai/p/3868133.html#2994701)笔端红翠
妹子好
http://pic.cnblogs.com/face/497865/20150117172039.png

[#13楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#3040448)2014-10-09 12:30 | [王子秦](http://www.cnblogs.com/busicu/)

莫非楼主是妹子？我还一直以为是汉子
http://pic.cnblogs.com/face/521329/20130425113234.png

[#14楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#3091242)2014-12-22 11:37 | [刺头士](http://www.cnblogs.com/loveholly/)

"第一观感是zepto没有类操作！我们使用(′′)的操作返回的也是zepto的实例"博主这里是想表示(″)的操作返回的也是zepto的实例"博主这里是想表示('')返回的不是zepto的实例吧

[#15楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#3092872)[楼主] 2014-12-24 12:42 | [叶小钗](http://www.cnblogs.com/yexiaochai/)

[@](http://www.cnblogs.com/yexiaochai/p/3868133.html#3091242)刺头士
1
2
3
4
5
6
[object Object]  [object Object]
[object Object]  [object Object][object Object]  [object Object]
[object Object][object Object][object Object]
[object Object]
[object Object]
var o = {}
这个方式返回的是一个纯粹实例对象
但是如果设置了o.__proto__ = prototypeObj，便更new Function返回实例无他了，相当于new出来的
http://pic.cnblogs.com/face/u294743.jpg?id=23185449

[#16楼](http://www.cnblogs.com/yexiaochai/p/3868133.html#3186172)31861722015/5/18 13:34:36 2015-05-18 13:34 | [superlbr](http://home.cnblogs.com/u/758803/)

请教一个问题，我用chrome调试网页的时候发现，event listeners里DOMCONTENTLOADED有两个一模一样的document都指向同一个zepto文件，这个正常么？之前用tap事件，会促发两次，是不是跟这个有关？

Measure
Measure