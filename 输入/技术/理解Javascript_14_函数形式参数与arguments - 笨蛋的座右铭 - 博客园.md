理解Javascript_14_函数形式参数与arguments - 笨蛋的座右铭 - 博客园

# [(L)](https://www.cnblogs.com/fool/archive/2010/10/19/1855261.html)[理解Javascript_14_函数形式参数与arguments](https://www.cnblogs.com/fool/archive/2010/10/19/1855261.html)

在'执行模型详解'的'函数执行环境'一节中对arguments有了些许的了解，那么让我们深入的分析一下函数的形式参数与arguments的关系。
注：在阅读本博文前请先阅读《理解javascript_13_执行模型详解》
注：本文的部分内容是自已的一些推论，并无官文文档作依据，如有错误之后，还望指正。

**生涩的代码**
我们先来看一段比较生涩的代码：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11 | function say(msg,other,garbage){<br>    alert(arguments[1]);//world<br>    var other = 'nice to meet you!';<br>    var msg;<br>    alert(arguments.length);<br>    alert(msg);//hello<br>    alert(other);//nice to meet you!<br>    alert(arguments[1]);//nice to meet you!<br>    alert(garbage);//undefined<br>}<br>say('hello','world'); |

　　你能正确的解释代码的执行结果吗？思考一下.

　　我想代码运行的结果，应该会和你的想象有很大的出入吧！为什么msg正常输出为hello，而不是undefined呢？函数定义的参数和函数内部定义的变量重复了会发生什么呢？arguments和函数定义时的参数有什么关系呢？让我们来一一解答：

**简单的内存图**
![2010101901333790.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231120653.png)
注：虚线表示的是曾经引用的指向。

**解答**

　　首先，我们来了解两个概念,形式参数和实际参数。形式参数指的是定义方法时所明确指定的参数，由于Javascript语言的灵活性，javascript并不要求方法调用时，所传递的参数个数与形式参数一致.而javascript实际调用时所传递的参数就是实际参数。arguments指的就是实际参数。从say方法中可以看出，say定义了三个形式参数，而实际调用时只传递了两个值。因此arguments.length的值为2,而不是3.接着我们来看一下arguments的特殊行为，个人感觉arguments会将所有的实际参数都当作对象来看待，对于基本数据类型的实际参数则会转换为其对应的对象类型。这是根据在函数内定义与形式参数同名的变量并赋值，arguments对应的值会跟着改变来判断的。

接着我们来分析一下构建say方法执行上下文的过程，由于逻辑比较复杂，这里我写一些'伪代码'来进行说明：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21<br>22<br>23 | function say(msg,other,garbage){<br>    //先对函数声明的变量进行'预解析',内部执行流程，它是是不可见的<br>    var msg = undefined;<br>    var other = undefined;<br>    var garbage = undefined;<br>    //再对函数内部定义的变量进行'预解析'<br>    var other = undefined;//很明显，此时这个定义已经无意义了。<br>    var msg = undefined;//无意义<br>    //对实际参数进行赋值操作<br>    msg = new String('hello');//arguments的会将所有实际参数当作对象看待<br>    other = new String('world');<br>    //正式进入函数代码部分<br>    alert(arguments[1]);//world<br>    other = 'nice to meet you!';<br>    //var msg;这个已经被预解析了，因此不会再执行<br>    alert(arguments.length);//2<br>    alert(msg);//hello<br>    alert(other);//nice to meet you!<br>    alert(arguments[1]);//nice to meet you!<br>    alert(garbage);//undefined<br>} |

这段代码已经可以解释一面的所有的问题了。我就不多说了。
唯一强调的一点是在内部用var定义与形式参数同名的变量是无意义的，因为在程序'预解析'后，会将它们看作为同一个变量。

**其它**

关于arguments还有很多特性，我在《[伪数组](http://www.cnblogs.com/fool/archive/2010/10/09/1846966.html)》一文中提到也提到了arguments,有兴趣的读者可以去看一下。arguments的实际应用你还可以参考一下这一篇文章 ：

|     |     |
| --- | --- |
| 1   | <a  href="http://www.gracecode.com/archives/2551/">http://www.gracecode.com/archives/2551/</a> |

好了，也就这么多了。希望大家能多多指正，多提意见吧。

分类:  [javascript](https://www.cnblogs.com/fool/category/264215.html)

标签:  [理解Javascript](https://www.cnblogs.com/fool/tag/%E7%90%86%E8%A7%A3Javascript/)

[好文要顶](http://loadhtml/#)  [关注我](http://loadhtml/#)  [收藏该文](http://loadhtml/#)  [![icon_weibo_24.png](../_resources/c5fd93bfefed3def29aa5f58f5173174.png)](http://loadhtml/#)  [![wechat.png](../_resources/24de3321437f4bfd69e684e353f2b765.png)](http://loadhtml/#)

[![u138960.jpg](../_resources/2d8d26fec0f219c4f97382556221c3af.jpg)](https://home.cnblogs.com/u/fool/)

[笨蛋的座右铭](https://home.cnblogs.com/u/fool/)
[关注 - 3](https://home.cnblogs.com/u/fool/followees/)
[粉丝 - 175](https://home.cnblogs.com/u/fool/followers/)

[+加关注](http://loadhtml/#)
5
0

[«](https://www.cnblogs.com/fool/archive/2010/10/17/1853813.html)  上一篇：  [超越Jquery_01_isPlainObject分析与重构](https://www.cnblogs.com/fool/archive/2010/10/17/1853813.html)

[»](https://www.cnblogs.com/fool/archive/2010/10/19/1855265.html)  下一篇：  [理解Javascript_15_作用域分配与变量访问规则,再送个闭包](https://www.cnblogs.com/fool/archive/2010/10/19/1855265.html)

posted @ 2010-10-19 01:49   [笨蛋的座右铭](https://www.cnblogs.com/fool/)  阅读(3278)  评论(10)   [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=1855261)   [收藏](http://loadhtml/#)