10段代码打通 JS 学习的任督二脉 - WEB前端 - 伯乐在线

# 10段代码打通 JS 学习的任督二脉

2015/10/28 · [JavaScript](http://web.jobbole.com/category/javascript-2/) · [4 评论](http://web.jobbole.com/83992/#article-comment) · [Javascript](http://web.jobbole.com/tag/javascript/)

分享到：[(L)](http://www.jiathis.com/share?uid=1745061)[15]()

本文作者： [伯乐在线](http://web.jobbole.com/) - [亚里士朱德](http://www.jobbole.com/members/yalishizhude) 。未经作者许可，禁止转载！

欢迎加入伯乐在线 [专栏作者](http://blog.jobbole.com/99322)。
**前言**

为了node.js做准备，js的基本功还是很重要的。所以正值1024程序员节的时候所以找了些题目，整理了一下知识点。这篇文章感觉代码太多，难免枯燥，所以文章最后留了个 **彩蛋**给读者。

* * *

# 简单回调

## 代码

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16 | function  foo(){<br>    console.log(this.a);<br>}<br>function  doFoo(fn){<br>    fn();<br>}<br>function  doFoo2(o){<br>    o.foo();<br>}<br>var  obj  =  {<br>    a:  2,<br>    foo:  foo<br>};<br>var  a  =  "I'm an a";<br>doFoo(obj.foo);<br>doFoo2(obj); |

## 分析

在Javascript中，this指向函数 **执行时的当前对象，而非声明环境有**。
执行doFoo的时候执行环境就是doFoo函数，执行环境为全局。
执行doFoo2时是在对象内部调用函数，this指针指向该对象。

## 结果

JavaScript

|     |     |
| --- | --- |
| 1<br>2 | I'm  an  a<br>2 |

# 用apply改变函数作用域

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14 | function  foo(somthing){<br>    console.log(this.a,  somthing);<br>}<br>function  bind(fn,  obj){<br>    return  function(){<br>        return  fn.apply(obj,  arguments);<br>    }<br>}<br>var  obj  =  {<br>    a:2<br>}<br>var  bar  =  bind(foo,  obj);<br>var  b  =  bar(3);<br>console.log(b); |

## 分析

apply、call、bind都有个作用就是改变作用域，这里用apply将foo函数的作用域指向obj对象，同时传入参数。

再简单分析一下bind函数内部的嵌套，执行bind函数的时候返回的是一个匿名函数，所以执行bar(3)的时候实际上是执行的bind内部的匿名函数，返回的是之前传入的foo函数的执行结果。

函数没有返回值的情况下默认返回undefined。

## 结果

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3 | 2  3<br>undefined |

# new关键字

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | function  foo(a,b){<br>    this.val  =  a+b;<br>}<br>var  bar  =  foo.bind(null,  'p1');<br>var  baz  =  new  bar('p2');<br>console.log(baz.val); |

## 分析

bind函数的第一个参数为null代表作用域不变，后面的不定参数将会和函数本身的参数按次序进行绑定，绑定之后执行函数只能从未绑定的参数开始传值。

## 结果

JavaScript

|     |     |
| --- | --- |
| 1<br>2 | p1p2 |

# 自执行函数

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8 | function  foo(){<br>    console.log(this.a);<br>}<br>var  a  =  2;<br>var  o  =  {a:3,foo:foo};<br>var  p  =  {a:4};<br>(p.foo=o.foo)(); |

## 分析

经常可以看到这样的代码

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4 | (function(){<br>    *//...*<br>})() |

这种代码通常是创建一个立即执行的函数同时避免污染全局变量。

很少有人去关注赋值语句执行之后会返回什么结果，其实就是返回当前值。也就是说当括号内执行完赋值之后，返回的是o对象中的foo函数。函数的执行环境中有一个a对象，嗯，就是它了~

## 答案

JavaScript

|     |     |
| --- | --- |
| 1<br>2 | 2   |

# 变量属性

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | var  a  =  [];<br>a[0]  =  1;<br>a['foobar']  =  2;<br>console.log(a.length);<br>console.log(a.foobar); |

## 分析

当一个变量被声明后，扩充其属性并不会改变原数据类型。

## 结果

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3 | 1<br>2 |

# 精度问题

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4 | var  a  =  'foo';<br>a[1]  =  'O';<br>console.log(0.1+0.2==0.3\|\|a); |

## 分析

当操作小数时请小心，js的小数计算并不精确，所以上面的判断是false。
字符串变量是常量。

## 结果

JavaScript

|     |     |
| --- | --- |
| 1<br>2 | foo |

# 命名提升

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9 | foo();<br>var  foo  =  0;<br>function  foo(){<br>    console.log(1);<br>}<br>foo  =  function(){<br>    console.log(2);<br>}; |

## 分析

声明的变量和命名函数都会被提升到代码的最前面，只不过声明的变量的赋值语句在代码中的位置不变。所以上面这段代码应该被理解为：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10 | var  foo;<br>function  foo(){<br>    console.log(1);<br>}<br>foo();<br>foo  =  0;<br>foo  =  function(){<br>    console.log(2);<br>}; |

## 结果

JavaScript

|     |     |
| --- | --- |
| 1<br>2 | 1   |

## 思考

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11 | foo();<br>var  foo  =  0;<br>function  foo(){<br>    console.log(1);<br>}<br>foo();<br>foo  =  function(){<br>    console.log(2);<br>};<br>foo(); |

上面代码的结果：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3 | 1<br>报错 |

# 作用域

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12 | foo();<br>var  a  =  true;<br>if(a){<br>    function  foo(){<br>        console.log('a');<br>    }<br>}  else  {<br>    function  foo(){<br>        console.log('b');<br>    }<br>} |

## 分析

javascript并不是以代码段为作用域，而是以函数。
再根据命名提升的原则，所以这段代码应该是这样的：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12 | function  foo(){<br>    console.log('a');<br>}<br>function  foo(){<br>    console.log('b');<br>}<br>foo();<br>var  a  =  true;<br>if(a){<br>}  else  {<br>} |

## 结果

JavaScript

|     |     |
| --- | --- |
| 1<br>2 | b   |

# 闭包陷阱

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | for(var  i=1;i&lt;=5;i++){<br>    setTimeout(function(){<br>        console.log(i);<br>    },  i*1000);<br>} |

## 分析

闭包有个重要的作用就是，在内层函数引用外层函数定义的变量时，外层函数的变量不会被会被持久化。
这里有个隐藏陷阱就是for循环结束之后i仍然自增了1。

## 结果

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | 6<br>6<br>6<br>6<br>6 |

# 伪闭包

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10 | function  foo(){<br>    console.log(a);<br>}<br>function  bar  ()  {<br>    var  a  =  3;<br>    foo();<br>}<br>var  a  =  2;<br>bar(); |

## 分析

闭包是函数的嵌套定义，而不是函数的嵌套调用。

## 结果

JavaScript

|     |     |
| --- | --- |
| 1<br>2 | 2   |

## 思考

如何输出3？

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10 | function  bar  ()  {<br>    function  foo(){<br>        console.log(a);<br>    }<br>    var  a  =  3;<br>    foo();<br>}<br>var  a  =  2;<br>bar(); |

# 彩蛋

光说不练假把式~
一周月内将下题正确答案发送至我邮箱内（邮箱地址请参考博客），将获得本年度我阅读过最优秀的关于AngularJS的电子书一本。

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7 | var  Obj  =  {<br>    name:  'zdl',<br>    do:  function(){<br>        console.log(this.name);<br>    }<br>} |

**写个对象a继承Obj的方法（不使用new）。**

加入伯乐在线专栏作者。扩大知名度，还能得赞赏！详见《[招募专栏作者](http://blog.jobbole.com/99322)》

>
**> 打赏支持作者写出更多好文章，谢谢！**
>   > [*> *>  打赏作者](http://web.jobbole.com/83992/#rewardbox)>

 **  2 赞  ** 24 收藏  [** 4 评论](http://web.jobbole.com/83992/#article-comment)

         [(L)](http://www.jiathis.com/share?uid=1745061)

### 关于作者：[亚里士朱德](http://www.jobbole.com/members/yalishizhude)

[![2b1d2ac0667d91e75cac9139946c808f.jpg](../_resources/2bdd780d99efe12f2e8d1dc7922a8536.jpg)](http://www.jobbole.com/members/yalishizhude)

  JSP工程师，多年大型国际项目开发经验。WEB前端工程师，擅长PC端以及移动端开发。js全栈工程师，熟悉node.js、mongoDB。开发者头条top10专栏作者慕课网签约讲师个人博客：yalishizhude.github.io     [** 个人主页](http://www.jobbole.com/members/yalishizhude) · [** 我的文章](http://web.jobbole.com/author/yalishizhude/) · [** 9](http://www.jobbole.com/members/yalishizhude/reputation/) · [**](http://yalishizhude.github.io/) [**](http://weibo.com/arisjutle) [**](http://web.jobbole.com/83992/#) [**](https://github.com/yalishizhude)

[![bfdcef89jw1f26ttffec8j20h802sjs4.jpg](../_resources/958071c3d359a2900309b8a6874b7a5d.jpg)](http://web.jobbole.com/85383/?utm_source=web.jobbole.com&utm_medium=rightBanner&utm_content=2016.3.23)