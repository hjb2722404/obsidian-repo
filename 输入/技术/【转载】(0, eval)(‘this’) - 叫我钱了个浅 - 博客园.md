##   (0, eval)(‘this’)

var window = this || (0, eval)('this')
在avalon源码中有这么一行代码，var window = this很容易理解

这里复习一下**Global Object**:

Global Object代表一个全局对象，js中不允许存在独立的函数，变量和常量，它们都是Global Object 的属性和方法，包括内置的属性和方法
但是Global Object实际并不存在，它是由window充当这个角色，并且这个过程是在js首次加载时进行的

在一个页面中，首次载入js代码时会创建一个全局执行环境，这个全局执行环境的作用域链实际上只有一个对象，即全局对象（window），并用this来引用全局对象。

那么，(0, eval)(‘this’)是什么？有什么用呢？什么情况下会执行呢？

(0, eval)('this')

- 先从语法上来解读：

这里用了逗号操作符，逗号操作符总会返回表达式中的最后一项，所以0在这里基本上没有什么用，换成其他任意数值均可
然后通过”()”来立即执行这个表达式，返回eval
为eval传入’this’字符串，然后被当做实际的ECMAScript语句来解析

- 这个表达式的作用：

因为在严格模式下，匿名函数中的this为undefined
![012050575781860.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201218154553.png)
为了防止在严格模式下window变量被赋予undefined，使用(0, eval)(‘this’)就可以把this重新指向window对象
![012051490325007.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201218154600.png)

- 原理？？

(0, eval)？？这个执行完以后是什么呢？
答案是eval
那么和eval(“this”)就没有区别了呀，那么
![012052353757516.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201218154606.png)
又怎么解释呢？

**这里要提出一个间接eval调用和直接eval调用的概念

**

- 间接eval调用：
```
  (1, eval)('...')
  (eval, eval)('...')
  (1 ? eval : 0)('...')
  (__ = eval)('...')var e = eval; e('...')
  (function(e) { e('...') })(eval)
  (function(e) { return e })(eval)('...')
  (function() { arguments[0]('...') })(eval)this.eval('...')this['eval']('...')
  [eval][0]('...')
  eval.call(this, '...')
  eval('eval')('...')
  [![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)](#)
```
- 直接eval调用：

```
eval('...')
(eval)('...')
(((eval)))('...')
(function() { return eval('...') })()
eval('eval("...")')

(function(eval) { return eval('...'); })(eval) with({ eval: eval }) eval('...') with(window) eval('...')
```
[![copycode.gif](【转载】(0,%20eval)(‘this’)%20-%20叫我钱了个浅%20-%20博客园.md#)
看了以上这些例子就可以明白了，(0, eval)(‘this’)是间接的eval调用，那么直接和间接调用之后的区别是什么呢？

eval(); // <-- 调用括号左边的表达式 — "eval" — 计算出一个引用 (eval)(); // <-- 调用括号左边的表达式 — "(eval)" — 计算出一个引用 (((eval)))(); // <-- 调用括号左边的表达式 — "(((eval)))" — 计算出一个引用 (1,eval)(); // <-- 调用括号左边的表达式 — "(1, eval)" — 计算出一个值 (eval = eval)(); // <-- 调用括号左边的表达式 — "(eval = eval)" — 计算出一个值

可以看出，**间接调用计算出来的是一个值，而不是引用**

如ECMAScript所说，这是因为两个操作符 - （例子(1,eval)里的）逗号操作符和(例子(eval=eval)里的)等号操作符-对它的操作数执行了GetValue。因此，(1,eval)和(eval = eval)计算出一个值，而eval 和 (eval)计算出的是一个引用。

****且间接调用是在全局范围内执行执行代码的。
![012059290009051.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201218154736.png)

****

就像你所看到的，第一个调用，是一个直接调用，方法中的this值是obj的引用（返回"obj.foo"），第二个调用，通过逗号表达式对它的操作数执行了GetValue，让this的值指向了全局对象

讲到这里，再回来看看(0, eval)('this')，是不是就不难理解，其实这里的this就是指向全局对象
这样在es5的严格模式下，也能获得全局对象的引用，而不是undefined了

更多EVAL的详细内容可以在这里找到：[http://www.oschina.net/translate/global-eval-what-are-the-optionshttp://www.oschina.net/translate/global-eval-what-are-the-options

- 这里补充一点：

　　　严格模式下，外部访问不到eval()中创建的任何变量或函数，为eval赋值也会导致错误
　　![012101547351228.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201218173740.png)

- 参考文章：

[global-eval-what-are-the-options](http://www.oschina.net/translate/global-eval-what-are-the-options)

[indirect-function-call-in-javascript](http://stackoverflow.com/questions/5161502/indirect-function-call-in-javascript/5161574#5161574)

----------------------------------------------
