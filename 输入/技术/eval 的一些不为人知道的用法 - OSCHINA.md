eval 的一些不为人知道的用法 - OSCHINA

##   [eval 的一些不为人知道的用法](https://www.oschina.net/translate/global-eval-what-are-the-options)  已翻译 100%

 [天涯2012](https://my.oschina.net/sky000) 投递于 2013/03/29 17:14 (共 26 段, 翻译完成于 08-09)

阅读 8166

** 收藏 9

[** 评论 0](https://www.oschina.net/translate/global-eval-what-are-the-options#comments)

英文原文：[Global eval. What are the options?](http://perfectionkills.com/global-eval-what-are-the-options/)

 ** 顶  *0*

[![](../_resources/4af7000c57ebbf69230fc3806500911f.png)](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CD_kLG-k5X4HABJeI9gXRsongAZer1b5Y0tTL3bsKtMWKysIJEAEg6uC-HmCdAaABwIvS1QLIAQGpAvOidymZT4M-qAMBqgTqAU_QZ-088cRDzZ2EdiILWv58oE8kqdxYKhYUkZ8S5F7G1YNqg4EN8UN_feG8VAYUXkszDy2u16s9CcdatxP_GSszBFuICTSN98blpY4SRf99mbAM5HsAQ2zSQ8P7FVmkO0-6d9wnvJJWdFgRadVuYFUD-v9HM0GbX4kB_vX7cHuDLnZ3ldBGzDSfE0cPyo_xdFLoXs2u7loNMPzLL3ohO_lBECHMQzZU8S4C2vdSG_Q9ej2vOSHKV5sxRbhiaal0TRusRLijKwABmY4PZXjvMAwPLhaxO070uRJmHnA7nAID7DztX2ty8ZWW68AEm7nr-aICgAeo9K2qAagHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcB0ggHCIBhEAEYH7EJVFCZ7ISXaoKACgGYCwHICwHYEwKIFAE&ae=1&num=1&cid=CAASEuRoXCfBpbg1-LBMcFIdIdiLdA&sig=AOD64_3zoTUNbv6dlO1D_QHNjQMThwsXTw&client=ca-pub-7090564139599510&nb=19&adurl=https://www.yisu.com/hk/huodong.html%3Ff%3Dgoogle%26plan%3Doschina%26unit%3Dwenzigg%26keyword%3Doschinawz%26eyisu%3D35%26gclid%3DEAIaIQobChMIwbmlqZah6wIVF4S9Ch1RWQIcEAEYASAAEgLHQPD_BwE)

[亿速云香港云服务器免备案速度快](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CD_kLG-k5X4HABJeI9gXRsongAZer1b5Y0tTL3bsKtMWKysIJEAEg6uC-HmCdAaABwIvS1QLIAQGpAvOidymZT4M-qAMBqgTqAU_QZ-088cRDzZ2EdiILWv58oE8kqdxYKhYUkZ8S5F7G1YNqg4EN8UN_feG8VAYUXkszDy2u16s9CcdatxP_GSszBFuICTSN98blpY4SRf99mbAM5HsAQ2zSQ8P7FVmkO0-6d9wnvJJWdFgRadVuYFUD-v9HM0GbX4kB_vX7cHuDLnZ3ldBGzDSfE0cPyo_xdFLoXs2u7loNMPzLL3ohO_lBECHMQzZU8S4C2vdSG_Q9ej2vOSHKV5sxRbhiaal0TRusRLijKwABmY4PZXjvMAwPLhaxO070uRJmHnA7nAID7DztX2ty8ZWW68AEm7nr-aICgAeo9K2qAagHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcB0ggHCIBhEAEYH7EJVFCZ7ISXaoKACgGYCwHICwHYEwKIFAE&ae=1&num=1&cid=CAASEuRoXCfBpbg1-LBMcFIdIdiLdA&sig=AOD64_3zoTUNbv6dlO1D_QHNjQMThwsXTw&client=ca-pub-7090564139599510&nb=0&adurl=https://www.yisu.com/hk/huodong.html%3Ff%3Dgoogle%26plan%3Doschina%26unit%3Dwenzigg%26keyword%3Doschinawz%26eyisu%3D35%26gclid%3DEAIaIQobChMIwbmlqZah6wIVF4S9Ch1RWQIcEAEYASAAEgLHQPD_BwE)

[买服务器选亿速云服务器,轻松上云,CN2高速连接,ping值低可免费换IP,安全稳定,香港服务器售价29元](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CD_kLG-k5X4HABJeI9gXRsongAZer1b5Y0tTL3bsKtMWKysIJEAEg6uC-HmCdAaABwIvS1QLIAQGpAvOidymZT4M-qAMBqgTqAU_QZ-088cRDzZ2EdiILWv58oE8kqdxYKhYUkZ8S5F7G1YNqg4EN8UN_feG8VAYUXkszDy2u16s9CcdatxP_GSszBFuICTSN98blpY4SRf99mbAM5HsAQ2zSQ8P7FVmkO0-6d9wnvJJWdFgRadVuYFUD-v9HM0GbX4kB_vX7cHuDLnZ3ldBGzDSfE0cPyo_xdFLoXs2u7loNMPzLL3ohO_lBECHMQzZU8S4C2vdSG_Q9ej2vOSHKV5sxRbhiaal0TRusRLijKwABmY4PZXjvMAwPLhaxO070uRJmHnA7nAID7DztX2ty8ZWW68AEm7nr-aICgAeo9K2qAagHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcB0ggHCIBhEAEYH7EJVFCZ7ISXaoKACgGYCwHICwHYEwKIFAE&ae=1&num=1&cid=CAASEuRoXCfBpbg1-LBMcFIdIdiLdA&sig=AOD64_3zoTUNbv6dlO1D_QHNjQMThwsXTw&client=ca-pub-7090564139599510&nb=7&adurl=https://www.yisu.com/hk/huodong.html%3Ff%3Dgoogle%26plan%3Doschina%26unit%3Dwenzigg%26keyword%3Doschinawz%26eyisu%3D35%26gclid%3DEAIaIQobChMIwbmlqZah6wIVF4S9Ch1RWQIcEAEYASAAEgLHQPD_BwE)

[打开](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CD_kLG-k5X4HABJeI9gXRsongAZer1b5Y0tTL3bsKtMWKysIJEAEg6uC-HmCdAaABwIvS1QLIAQGpAvOidymZT4M-qAMBqgTqAU_QZ-088cRDzZ2EdiILWv58oE8kqdxYKhYUkZ8S5F7G1YNqg4EN8UN_feG8VAYUXkszDy2u16s9CcdatxP_GSszBFuICTSN98blpY4SRf99mbAM5HsAQ2zSQ8P7FVmkO0-6d9wnvJJWdFgRadVuYFUD-v9HM0GbX4kB_vX7cHuDLnZ3ldBGzDSfE0cPyo_xdFLoXs2u7loNMPzLL3ohO_lBECHMQzZU8S4C2vdSG_Q9ej2vOSHKV5sxRbhiaal0TRusRLijKwABmY4PZXjvMAwPLhaxO070uRJmHnA7nAID7DztX2ty8ZWW68AEm7nr-aICgAeo9K2qAagHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcB0ggHCIBhEAEYH7EJVFCZ7ISXaoKACgGYCwHICwHYEwKIFAE&ae=1&num=1&cid=CAASEuRoXCfBpbg1-LBMcFIdIdiLdA&sig=AOD64_3zoTUNbv6dlO1D_QHNjQMThwsXTw&client=ca-pub-7090564139599510&nb=8&adurl=https://www.yisu.com/hk/huodong.html%3Ff%3Dgoogle%26plan%3Doschina%26unit%3Dwenzigg%26keyword%3Doschinawz%26eyisu%3D35%26gclid%3DEAIaIQobChMIwbmlqZah6wIVF4S9Ch1RWQIcEAEYASAAEgLHQPD_BwE)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 24 16' data-evernote-id='36' class='js-evernote-checked'%3e%3cpath d='M10.90 4.69L10.90 5.57L3.17 5.57L3.17 7.22L3.17 7.22Q3.17 9.15 3.06 10.11L3.06 10.11L3.06 10.11Q2.95 11.07 2.58 11.92L2.58 11.92L2.58 11.92Q2.21 12.77 1.27 13.56L1.27 13.56L0.59 12.93L0.59 12.93Q2.29 11.82 2.29 8.66L2.29 8.66L2.29 4.69L6.11 4.69L6.11 2.95L7.00 2.95L7.00 4.69L10.90 4.69ZM23.00 7.34L23.00 8.22L12.80 8.22L12.80 7.34L17.55 7.34L17.55 5.53L15.12 5.53L15.12 5.53Q14.55 6.53 13.86 7.07L13.86 7.07L13.10 6.46L13.10 6.46Q14.44 5.46 14.95 3.33L14.95 3.33L15.84 3.55L15.84 3.55Q15.77 3.86 15.49 4.65L15.49 4.65L17.55 4.65L17.55 2.84L18.47 2.84L18.47 4.65L21.86 4.65L21.86 5.53L18.47 5.53L18.47 7.34L23.00 7.34ZM21.45 8.88L21.45 13.63L20.53 13.63L20.53 12.78L15.32 12.78L15.32 13.63L14.41 13.63L14.41 8.88L21.45 8.88ZM15.32 11.90L20.53 11.90L20.53 9.76L15.32 9.76L15.32 11.90Z'%3e%3c/path%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 15 15' data-evernote-id='34' class='js-evernote-checked'%3e%3cpath d='M3.25%2c3.25l8.5%2c8.5M11.75%2c3.25l-8.5%2c8.5'%3e%3c/path%3e%3c/svg%3e)

####  参与翻译 (6人) : [几点人](https://my.oschina.net/jidianren), [多多de棉花糖](https://my.oschina.net/syscde), [super0555](https://my.oschina.net/super0555), [赵亮-碧海情天](https://my.oschina.net/theforever), [crossgate9](https://my.oschina.net/tredbag), [姜鹏飞](https://my.oschina.net/coonooo)

 [** 打印](https://www.oschina.net/translate/global-eval-what-are-the-options?print)

 [仅中文](https://www.oschina.net/translate/global-eval-what-are-the-options?lang=chs)  [中英文对照](https://www.oschina.net/translate/global-eval-what-are-the-options?cmp)  [仅英文](https://www.oschina.net/translate/global-eval-what-are-the-options?lang=eng)

 **目录**

- [Eval如何工作](http://www.oschina.net/translate/global-eval-what-are-the-options#how_eval_works)

- [在全局空间中进行Eval调用](http://www.oschina.net/translate/global-eval-what-are-the-options#evaling_in_global_scope)

    - [间接eval调用原理.](http://www.oschina.net/translate/global-eval-what-are-the-options#indirect_eval_call_theory)

        - [间接eval调用示例.](http://www.oschina.net/translate/global-eval-what-are-the-options#indirect_eval_call_examples)

    - [间接eval调用练习.](http://www.oschina.net/translate/global-eval-what-are-the-options#indirect_eval_call_in_practice)

    - [window.execScript](http://www.oschina.net/translate/global-eval-what-are-the-options#windowexecscript)

    - [window.eval](http://www.oschina.net/translate/global-eval-what-are-the-options#windoweval)

        - [eval在webkit中的上下文](http://www.oschina.net/translate/global-eval-what-are-the-options#eval_context_in_webkit)

    - [new Function](http://www.oschina.net/translate/global-eval-what-are-the-options#new_function)

    - [setTimeout](http://www.oschina.net/translate/global-eval-what-are-the-options#settimeout)

    - [脚本插入](http://www.oschina.net/translate/global-eval-what-are-the-options#script_insertion)

- [使用](http://www.oschina.net/translate/global-eval-what-are-the-options#the_problem_with_geval_windowexecscript_eval)[`window.execScript || eval`](http://www.oschina.net/translate/global-eval-what-are-the-options#the_problem_with_geval_windowexecscript_eval)引发的问题

- [基于特征测试的途径](http://www.oschina.net/translate/global-eval-what-are-the-options#feature_testing_based_approach)

- [库中的全局eval调用](http://www.oschina.net/translate/global-eval-what-are-the-options#global_eval_in_libraries)

- [总结](http://www.oschina.net/translate/global-eval-what-are-the-options#summary)

 [David Flanagan](http://www.davidflanagan.com/)最近写了一篇 [关于Javascript中全局函数eval()](http://www.davidflanagan.com/2010/12/global-eval-in.html)的文章, 提供了一单行代码:

var geval = this.execScript || eval;

尽管这看起来简单美观，但我认为这不是最好的跨浏览器的解决方案。此外我也不建议大家使用它。在这个主题上思考了一下，我意识到在Javascript中实际上有几种在全局执行代码的方法。有些方法，比如间接eval，有些理解得不够透彻，它们的结果不是立即可见的。David向我指出评论中的一条：在那些那些实现它的人的圈子外"间接eval"不是一个被人熟知的东西。他说得对，在互联上确实充斥着无数对global感到困扰的主题。

怀着使这种情况得到改善的目的，我将复习“全局eval”，谈谈它们是如何工作，为什么这么工作。我也将解释上面提及的单行代码方案。

 [ ![101450_50.jpg](../_resources/1180b5cfb5d522ed117622103f3fad95.jpg)](https://my.oschina.net/coonooo)

 [姜鹏飞](https://my.oschina.net/coonooo)

翻译于 2013/08/01 10:01

 ** 顶
 1

###  eval是如何运转的

在开始之前，我们简单地将"global eval"定义为在全局作用域下运行eval。

关于"在全局作用域下eval代码"的争吵起因是**原生的eval函数在调用的作用域中运行代码**：

var x = 'outer';
(function() { var x = 'inner'; eval('x'); // "inner" })();

这一行为在ES3和ES5清楚地被定义如下：

>
>  [...]
>  初始化后的作用域链会包含调用者作用域链中的相同的对象，并保持相同的顺序。其中包括由语句和catch子句加入到调用者作用域链中的对象。
>  [...]
>

— [10.2.2 Eval Code](http://bclary.com/2004/11/07/#a-10.2.2) [ES3]

在ES5中更复杂，更有趣。eval函数的行为由两个因素决定：(1) 直接调用还是间接调用(译者注：使用call或apple函数)；（2）是否在strict模式下运行。不用担心你是否知道“间接调用”是什么，很快我们又会遇到他。当在非strict模式下运行eval函数时，其效果与ES3中的情况是相同的。

>
>  [...]
>  b. 设置与调用函数所处运行环境相同的词汇环境(Lexical Environment)
>  [...]
>

— [10.4.2 Entering Eval Code](http://ecma262-5.com/ELS5_HTML.htm#Section_10.4.2) [ES5]

 [ ![254143_50.jpg](../_resources/f8c6d7f7784da176fb6c8a28ad323f11.jpg)](https://my.oschina.net/tredbag)

 [crossgate9](https://my.oschina.net/tredbag)

翻译于 2013/07/20 23:22

 ** 顶
 2

###  在全局范围Eval’ing

因此本地的eval不允许执行全局的代码。怎么办呢？我们先看看一些选择，之后再提取出一个跨浏览器的解决方案。

####  间接 eval 调用理论

我以前在解释eval在 ES5中的行为时，提到过“间接eval调用”。间接调用非常有趣，这是因为在ES5中它实际上**以全局方式执行代码**。[对极了!](http://www.youtube.com/watch?v=EDkQZVJshgc) 但什么是——“间接eval调用”呢。间接eval调用只是任何非直接eval调用的eval调用而已。而直接eval调用的定义是：

>
>  对eval函数的直接调用，就是表示为一个调用表达式，它满足以下两个条件：
>
>  引用是调用表达式中的成员表达式的计算结果，它具有一个环境记录作为它的基础数值，它的引用名是"eval"。
>
>  以该引用为参数调用抽象操作GetValue的结果，是15.1.2.1中定义的标准的原生函数。
>

— [15.1.2.1.1  Eval的直接调用](http://ecma262-5.com/ELS5_HTML.htm#Section_15.1.2.1.1) [ES5]

 [ ![995742_50.jpg](../_resources/2b5acbfb52a096d1cffd8edd6c4aa17b.jpg)](https://my.oschina.net/super0555)

 [super0555](https://my.oschina.net/super0555)

翻译于 2013/08/04 17:52

 ** 顶
 2

这听起来可能有点神秘，但实际它非常简单。规范中试图说明的是eval('1+1')是一个直接调用，但(1,eval)('1+1')不是的。如果我们从语法上剖析第一个表达式——eval('1+1')，我们会看到它其实就是一个调用表达式，包含一个成员表达式，(eval) 后跟着参数 ('(1+1)')，其中成员表达式由“eval”标识符构成：

eval ( '1+1' )
|______|
Identifier
|______| |________|
MemberExpression Arguments
|__________________________|
CallExpression

这或多或少的，是一个直接调用的签名。ES3定义要稍微简单一点，这个定义与上面的图几乎一模一样：

>
>  “[…]任何非直接调用 (就是说，除了**> 显式地使用它的名字作为一个标识符，而这个标识符就是调用表达式中的成员表达式**> ) […]”
>

— [15.1.2.1 eval(x)](http://bclary.com/2004/11/07/#a-15.1.2.1) [ES3]

 [ ![995742_50.jpg](../_resources/2b5acbfb52a096d1cffd8edd6c4aa17b.jpg)](https://my.oschina.net/super0555)

 [super0555](https://my.oschina.net/super0555)

翻译于 2013/08/04 18:04

 ** 顶
 1

因此 eval('1+1')是直接eval调用，而(1,eval)('1+1')不是。由于后者不是直接调用，因此它是**间接eval调用**。让我们更详细的看看它：

( 1 , eval ) ( '1+1' ) |____| |_____| |_____| 常量 操作符 标识符 |_________________________| 表达式 |______________________________| 主要表达式 |______________________________| |________|

成员表达式 参数
|________________________________________________|
调用表达式

在上面的例子里，很显然参数（调用括号）之前的哪部分不只是由“eval”标识符组成。这是一个完整的其他类型的表达式，由逗号操作符，数字常量，然后才是"eval"标识符组成。1,eval - 基于逗号操作符运行的方式-仍然执行一个标准的内置的eval函数，不过整个表达式不再是直接调用了。因此它是 **间接eval调用**。 **一些间接调用的例子**

如果你仍然不能完全认识间接eval调用，那么看看下面这些例子：

(1, eval)('...')
(eval, eval)('...')
(1 ? eval : 0)('...')
(__ = eval)('...')var e = eval; e('...')
(function(e) { e('...') })(eval)
(function(e) { return e })(eval)('...')
(function() { arguments[0]('...') })(eval)this.eval('...')this['eval']('...')
[eval][0]('...')eval.call(this, '...')eval('eval')('...')
依据ES5，所有这些都是间接调用，且 **应当在全局范围内执行执行代码**。我愿意更详细地说明它们中的每一个，不过这将使这篇文章太过
冗长。
注意第5行var e = eval;e('...')。

 [ ![1049534_50.jpg](../_resources/ffde0a324f5161aee58afb132a8faf9c.jpg)](https://my.oschina.net/jidianren)

 [几点人](https://my.oschina.net/jidianren)

翻译于 2013/08/07 12:02

 ** 顶
 1

你可以看到这就是戴维的解决方法所做的 - var geval = window.execScript || eval。当执行geval的时候，geval标识符解析为一个全局的，内置的eval函数，不过整个表达式没有把"eval"当作调用表达式里的标识符。相反，是"geval"标识符**间接调用了eval**，然后全局性地执行代码。

不过后面我们将返回到这一行，现在让我们看看最后一行，这才是间接调用的非常重要的一点。

你是否注意到ES5定义说明调用表达式的eval**应当执行标准的、内置的函数**？这意味着根据上下文内容eval('1+1')**必定不是直接调用**。仅仅当eval真正地（不是重写或者隐含地）引用了标准的、内置的函数的时候，调用才被认为是直接调用。

eval = (function(eval) { return  function(expr) { return  eval(expr);
};

})(eval); eval('1+1'); // 它看前来像直接调用，不过实际上是间接调用。  // 这是因为`eval`解析为定制的函数，而不是标准的、内置的函数。

 [ ![1049534_50.jpg](../_resources/ffde0a324f5161aee58afb132a8faf9c.jpg)](https://my.oschina.net/jidianren)

 [几点人](https://my.oschina.net/jidianren)

翻译于 2013/08/07 12:08

 ** 顶
 1

既然我们已经看过了许多间接调用，那么看看几个**直接调用**如何？

eval('...')
(eval)('...')
(((eval)))('...')
(function() { return  eval('...') })() eval('eval("...")')

(function(eval) { return  eval('...'); })(eval) with({ eval: eval }) eval('...') with(window) eval('...')

看前来相当的直白，难道不是吗？

不过等一下，为什么认为(eval)('...')和(((eval)))('...')是直接调用呢？当然，它们并不遵守我们前面所建立的特性 - 调用表达式内部的成员表达式内的有"eval"标识符。这儿到底发生什么呢？难道是**eval两边的括号**让它成为间接调用的吗？

这个有点微妙的问题的答案就在ES5直接调用定义的第一段里 - 是这样一个事实：调用表达式里的 **"eval"应当是引用，而不是值**。在程序执行期间，eval('1+1')表达式里的eval只不过是一个引用，而且需要计算出一个值。一旦计算完成，这个值（最可能）是标准的、内置的函数对象。在前面已经分析的(1,eval)('1+1')间接调用里所发生的是(1,eval)表达式计算出一个值，而不是一个引用。由于它计算出的

不是引用，所以不能认为它是直接eval调用。

 [ ![1049534_50.jpg](../_resources/ffde0a324f5161aee58afb132a8faf9c.jpg)](https://my.oschina.net/jidianren)

 [几点人](https://my.oschina.net/jidianren)

翻译于 2013/08/07 12:12

 ** 顶
 1

但是(eval)('1+1')又如何呢？

认为(eval)是直接调用的原因是因为(eval)表达式**仍然计算出的是一个引用**，不是一个值。((eval)),(((eval)))等也是同样的。这种情况的出现是因为成组操作符-"("和")"-**不能计算自身的表达式**。如果传递引用给成组操作符-"("和")"-它仍然计算出一个引用，而不是一个值。

eval(); // <-- 调用括号左边的表达式 — "eval" — 计算出一个引用 (eval)(); // <-- 调用括号左边的表达式 — "(eval)" — 计算出一个引用 (((eval)))(); // <-- 调用括号左边的表达式 — "(((eval)))" — 计算出一个引用 (1,eval)(); // <-- 调用括号左边的表达式 — "(1, eval)" — 计算出一个值 (eval = eval)(); // <-- 调用括号左边的表达式 — "(eval = eval)" — 计算出一个值

如ECMAScript所说，这是因为两个操作符 - （例子(1,eval)里的）逗号操作符和(例子(eval=eval)里的)等号操作符-对它的操作数执行了GetValue。因此，(1,eval)和(eval = eval)计算出一个值，而eval 和 (eval)计算出的是一个引用。

现在希望已经弄清楚了(eval)('...')和(function(eval){ retuan eval('...')})(eval)是直接eval调用，而(1,eval)('...')和this.eval('...')不是直接调用的原因。

 [ ![1049534_50.jpg](../_resources/ffde0a324f5161aee58afb132a8faf9c.jpg)](https://my.oschina.net/jidianren)

 [几点人](https://my.oschina.net/jidianren)

翻译于 2013/08/07 12:19

 ** 顶
 1

 **实际中的间接eval调用**

我们身后有了间接eval调用的所有理论之后，让我们看看实际中的效果吧。我们已经知道ES5声明这样的调用在全局范围内执行代码。现在只剩下两件事情要考虑-ES3和现实。有趣的部分是从ES3开始的，它[允许间接eval调用抛出错误](http://bclary.com/2004/11/07/#a-15.1.2.1)。ES3不仅允许抛出错误，而且并不关心是否在全局范围内计算。

现实中又是怎么样呢？事实证明如今非常多的环境或多或少的 [遵循ES5的行为](http://bclary.com/2004/11/07/#a-15.1.2.1)：在全局范围内计算代码。但是不幸的是，并不是所有。

 [ ![1049534_50.jpg](../_resources/ffde0a324f5161aee58afb132a8faf9c.jpg)](https://my.oschina.net/jidianren)

 [几点人](https://my.oschina.net/jidianren)

翻译于 2013/08/07 12:21

 ** 顶
 1

IE8及其以前的IE版本在调用范围内执行代码，好像间接调用就是直接调用。一些Konqueror版本(到4.3版本)和Safari 3.2以及以前的Safari版本都像IE那样，在调用范围内执行代码。老的Opera(到9.27版本)甚至更糟，实际上是按照规格说明中所允许的那样只抛出错误。所有这一切都使得间接eval调用（自身）不是跨浏览器"全局eval"解决方案的了好候选者。在后续的几年里，这种情况仍然没有得到改善（当Opera处在9.27版本或者低于这个版本的时候，Safari处在3.2版本或者低于这个版本（可能出现在早期的iPhone里），接着其他"错误行为”的浏览器“消失了”）。

奇怪的是，目前，甚至最新的浏览器都偏离了ES5。例如Chrome9认为这是间接调用 -(funciton(eval) { returan eval('x');})(eval)-实际上它不是；eval是引用，它是调用表达式内部的成员表达式的一部分，并且执行一个标准的、内置的函数。

 [ ![1049534_50.jpg](../_resources/ffde0a324f5161aee58afb132a8faf9c.jpg)](https://my.oschina.net/jidianren)

 [几点人](https://my.oschina.net/jidianren)

翻译于 2013/08/07 12:29

 ** 顶
 1

 [1](https://www.oschina.net/translate/global-eval-what-are-the-options?lang=chs&p=1)  [2](https://www.oschina.net/translate/global-eval-what-are-the-options?lang=chs&p=2)  [3](https://www.oschina.net/translate/global-eval-what-are-the-options?lang=chs&p=3)  [>](https://www.oschina.net/translate/global-eval-what-are-the-options?lang=chs&p=2)

本文中的所有译文仅用于学习和交流目的，转载请务必注明文章译者、出处、和本文链接。

我们的翻译工作遵照 [CC 协议](http://zh.wikipedia.org/wiki/Wikipedia:CC)，如果我们的工作有侵犯到您的权益，请及时联系我们。