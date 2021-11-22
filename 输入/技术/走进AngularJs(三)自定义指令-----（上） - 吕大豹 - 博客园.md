走进AngularJs(三)自定义指令-----（上） - 吕大豹 - 博客园

#   [走进AngularJs(三)自定义指令-----（上）](https://www.cnblogs.com/lvdabao/p/3391634.html)

## 一、有感而发的一些话

　　在学习ng之前有听前辈说过，angular上手比较难，初学者可能不太适应其语法以及思想。随着对ng探索的一步步深入，也确实感觉到了这一点，尤其是框架内部的某些执行机制，其复杂程度并非是我现在的功力能够理解的，只能是知其皮毛。我现在学习的途径是官方文档 + AngularJS在github上的中文粗译版（https://github.com/basestyle/angularjs-cn）+ 网上搜到的一些文章。鉴于本人资质平平以前也只用过jQuery，目前只能做到理解ng的API文档，相关特性的使用方式。故博客的主要内容也就是记载一些我的理解与应用，对ng框架内部的机制只做必要的了解，暂不深入探究。

　　智商捉急，就到这里~

　　接下来聊聊angular的指令机制。angular通过指令的方式实现了HTML的扩展，增强后的HTML就好比是究极进化后的暴龙兽，不仅长相焕然一新，同时也获得了很多强大的技能。更厉害的是，你还可以自定义指令，这就意味着HTML标签的范围可以扩展到无穷大，ng赋予了你造物主的能力。作为angular的精华之一，指令相关的知识也很多，本篇开始探索自定义指令的方方面面。为了不让我的篇幅再拉那么长，我识趣的在标题后面加了（上），你懂的。

## 二、指令的编译过程及命名方式

　　在开始自定义指令之前，我们有必要了解一下指令在框架中的执行流程。这部分内容我没有自己研究，只是照搬了别人的说法：
1. 浏览器得到 HTML 字符串内容，解析得到 DOM 结构。
2. ng 引入，把 DOM 结构扔给 $compile 函数处理：
　　　　①   找出 DOM 结构中有变量占位符
　　　　②   匹配找出 DOM 中包含的所有指令引用
　　　　③   把指令关联到 DOM
　　　　④   关联到 DOM 的多个指令按权重排列
　　　　⑤   执行指令中的 compile 函数（改变 DOM 结构，返回 link 函数）
　　　　⑥   得到的所有 link 函数组成一个列表作为 $compile 函数的返回
　　3. 执行 link 函数（连接模板的 scope）。

　　这里注意区别一下$compile和compile，前者是ng内部的编译服务，后者是指令中的编译函数，两者发挥作用的范围不同。compile和link函数息息相关又有所区别，这个在后面会讲。了解执行流程对后面的理解会有帮助。

　　在这里我小小的多嘴一下，有些人可能会问，angular不就是一个js框架吗，怎么还能跟编译扯上呢，又不是像C++那样的高级语言。其实此编译非彼编译，ng编译的工作是解析指令啦，绑定监听器啦，替换模板中的变量啦这些。因为工作方式很像高级语言编辑中的递归、堆栈过程，所以起名为编译，不要疑惑。

　　指令的几种使用方式如下：
　　作为标签：<my-dir></my-dir>
　　作为属性：<span my-dir="exp"></span>
　　作为注释：<!-- directive: my-dir exp -->
　　作为类名：<span class="my-dir: exp;"></span>
　　其实常用的就是作为标签和属性，下面两种用法目前还没见过，姑且留个印象。我们自定义的指令就是要支持这样的用法。

　　关于自定义指令的命名，你可以随便怎么起名字都行，官方是推荐用[命名空间-指令名称]这样的方式，像ng-controller。不过你可千万不要用ng-前缀了，防止与系统自带的指令重名。另外一个需知道的地方，指令命名时用驼峰规则，使用时用-分割各单词。如：定义myDirective，使用时像这样：<my-directive>。

## 三、自定义指令的配置参数

　　下面是定义一个标准指令的示例，可配置的参数包括以下部分：
[![copycode.gif](走进AngularJs(三)自定义指令-----（上）%20-%20吕大豹%20-%20博客园.md#)

myModule.directive('namespaceDirectiveName', function factory(injectables) { var directiveDefinitionObject = {

restrict: string,//指令的使用方式，包括标签，属性，类，注释 priority: number,//指令执行的优先级 template: string,//指令使用的模板，用HTML字符串的形式表示 templateUrl: string,//从指定的url地址加载模板 replace: bool,//是否用模板替换当前元素，若为false，则append在当前元素上 transclude: bool,//是否将当前元素的内容转移到模板中 scope: bool or object,//指定指令的作用域 controller: function controllerConstructor($scope, $element, $attrs, $transclude){...},//定义与其他指令进行交互的接口函数 require: string,//指定需要依赖的其他指令 link: function postLink(scope, iElement, iAttrs) {...},//以编程的方式操作DOM，包括添加监听器等 compile: function compile(tElement, tAttrs, transclude){ return: {

pre: function preLink(scope, iElement, iAttrs, controller){...},
post: function postLink(scope, iElement, iAttrs, controller){...}
}
}//编程的方式修改DOM模板的副本，可以返回链接函数 }; return directiveDefinitionObject;
});
[![copycode.gif](走进AngularJs(三)自定义指令-----（上）%20-%20吕大豹%20-%20博客园.md#)

         看上去好复杂的样子啊~定义一个指令需要这么多步骤嘛？当然不是，你可以根据自己的需要来选择使用哪些参数。事实上priority和compile用的比较少，template和templateUrl又是互斥的，两者选其一即可。所以不必紧张，接下来分别学习一下这些参数，我将先从一个简单的例子开始。为了易于理解和我以后翻看的时候还能看明白，我尽量使用有语义的命名，而不是像test1，test2这样。

         例子的代码如下：
[![copycode.gif](走进AngularJs(三)自定义指令-----（上）%20-%20吕大豹%20-%20博客园.md#)
var app = angular.module('MyApp', [], function(){console.log('here')});
app.directive('sayHello',function(){ return {
restrict : 'E',
template : '<div>hello</div>' };
})
[![copycode.gif](走进AngularJs(三)自定义指令-----（上）%20-%20吕大豹%20-%20博客园.md#)
         然后在页面中，我们就可以使用这个名为sayHello的指令了，它的作用就是输出一个hello单词。像这样使用：
<say-hello></say-hello>
         这样页面就会显示出hello了，看一下生成的代码：

 　　![28002258-8c5b73721271480481e7e139b977eba1.jpg](../_resources/f37799b7b33d6d7aec878fb60d42e145.jpg)

         稍稍解释一下我们用到的两个参数，restirct用来指定指令的使用类型，其取值及含义如下：

|     |     |     |
| --- | --- | --- |
| **取值** | **含义** | **使用示例** |
| E   | 标签  | <my-menu title=*Products*></my-menu> |
| A   | 属性  | <div my-menu=*Products*></div> |
| C   | 类   | <div class="my-menu":*Products*></div> |
| M   | 注释  | <!--directive:my-menu Products--> |

         默认值是A。也可以使用这些值的组合，如EA，EC等等。我们这里指定为E，那么它就可以像标签一样使用了。如果指定为A，我们使用起来应该像这样：
<div say-hello></div>

         从生成的代码中，你也看到了template的作用，它就是描述你的指令长什么样子，这部分内容将出现在页面中，即该指令所在的模板中，既然是模板中，template的内容中也可以使用ng-modle等其他指令，就像在模板中使用一样。

　　在上面生成的代码中，我们看到了<div>hello</div>外面还包着一层<say-hello>标签，如果我们不想要这一层多余的东西了，replace就派上用场了，在配置中将replace赋值为true，将得到如下结构：

 　　![28002411-fb80a95a93864f348596ff974a83c712.jpg](../_resources/32f071f158a3897031286f9893090711.jpg)

         replace的作用正如其名，将指令标签替换为了temple中定义的内容。不写的话默认为false。

         上面的template未免也太简单了，如果你的模板HTML较复杂，如自定义一个ui组件指令，难道要拼接老长的字符串？当然不需要，此时只需用templateUrl便可解决问题。你可以将指令的模板单独命名为一个html文件，然后在指令定义中使用templateUrl指定好文件的路径即可，如：

templateUrl : ‘helloTemplate.html’

         系统会自动发一个http请求来获取到对应的模板内容。是不是很方便呢，你不用纠结于拼接字符串的烦恼了。如果你是一个追求完美的有考虑性能的工程师，可能会发问：那这样的话岂不是要牺牲一个http请求？

         这也不用担心，因为ng的模板还可以用另外一种方式定义，那就是使用<script>标签。使用起来如下：
<script type="text/ng-template" id="helloTemplate.html">
<div>hello</div>
</script>
         你可以把这段代码写在页面头部，这样就不必去请求它了。在实际项目中，你也可以将所有的模板内容集中在一个文件中，只加载一次，然后根据id来取用。

         接下来我们来看另一个比较有用的配置：transclude，定义是否将当前元素的内容转移到模板中。看解释有点抽象，不过亲手试试就很清楚了，看下面的代码：

[![copycode.gif](走进AngularJs(三)自定义指令-----（上）%20-%20吕大豹%20-%20博客园.md#)
app.directive('sayHello',function(){ return {
restrict : 'E',
template : '<div>hello，<b ng-transclude></b></div>',
replace : true,
transclude : true };
})
[![copycode.gif](走进AngularJs(三)自定义指令-----（上）%20-%20吕大豹%20-%20博客园.md#)

         指定了transclude为true，并且template修改了一下，加了一个<b>标签，并在上面使用了ng-transclude指令，用来告诉指令把内容转移到的位置。那我们要转移的内容是什么呢？请看使用指令时的变化：

<say-hello>美女</say-hello>
         内容是什么你也看到了哈~在运行的时候，美女将会被转移到<b>标签中，原来此配置的作用就是——乾坤大挪移！看效果：

 　　![28010402-a510b99eb47f42e1ac07002fe7051207.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107133848.jpg)

         这个还是很有用的，因为你定义的指令不可能老是那么简单，只有一个空标签。当你需要对指令中的内容进行处理时，此参数便大有可用。

## 四、结束

　　看前面写的两篇，感觉篇幅太长了，可能会有人耐不住性子看完，故本篇先介绍几个比较简单的参数，先拿软的来捏一捏，更复杂的用法还在后头。我们将真正用一下自定义指令，起码也搞个像样的ui组件出来，这样才算是学会了。

　　今天爬香山回来，累的够呛，时辰不早，收工睡觉~

分类: [javascript相关](https://www.cnblogs.com/lvdabao/category/536798.html)
标签: [AngularJs](https://www.cnblogs.com/lvdabao/tag/AngularJs/)

 [好文要顶](走进AngularJs(三)自定义指令-----（上）%20-%20吕大豹%20-%20博客园.md#)  [关注我](走进AngularJs(三)自定义指令-----（上）%20-%20吕大豹%20-%20博客园.md#)  [收藏该文](走进AngularJs(三)自定义指令-----（上）%20-%20吕大豹%20-%20博客园.md#)  [![icon_weibo_24.png](走进AngularJs(三)自定义指令-----（上）%20-%20吕大豹%20-%20博客园.md#)  [![wechat.png](走进AngularJs(三)自定义指令-----（上）%20-%20吕大豹%20-%20博客园.md#)

 [![20160420115610.png](../_resources/e90e52e09e21f5356770cbeea7241522.jpg)](https://home.cnblogs.com/u/lvdabao/)

 [吕大豹](https://home.cnblogs.com/u/lvdabao/)
 [关注 - 24](https://home.cnblogs.com/u/lvdabao/followees/)
 [粉丝 - 1720](https://home.cnblogs.com/u/lvdabao/followers/)

 [+加关注](走进AngularJs(三)自定义指令-----（上）%20-%20吕大豹%20-%20博客园.md#)

 [«](https://www.cnblogs.com/lvdabao/p/3383240.html) 上一篇： [为jQuery的$.ajax设置超时时间](https://www.cnblogs.com/lvdabao/p/3383240.html)

 [»](https://www.cnblogs.com/lvdabao/p/3398044.html) 下一篇： [走进AngularJs(四)自定义指令----（中）](https://www.cnblogs.com/lvdabao/p/3398044.html)

posted @ 2013-10-28 01:07 [吕大豹](https://www.cnblogs.com/lvdabao/)  阅读(13571)  评论(17) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=3391634) [收藏](走进AngularJs(三)自定义指令-----（上）%20-%20吕大豹%20-%20博客园.md#)