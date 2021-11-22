JavaScript中setTimeout的那些事儿_javascript技巧_脚本之家

# JavaScript中setTimeout的那些事儿

*转载*  发布时间：2016年11月14日 10:27:25   投稿：lijiao

JavaScript中setTimeout的那些事儿到底有什么？setTimeout单线程、延迟时间等，感兴趣的小伙伴们可以参考一下

[![phpcn_0508.gif](../_resources/29b7ae36f4f6389f1d4d1456c18aeb0a.gif)](http://www.php.cn/course.html?ad51)

**一、setTimeout那些事儿之单线程**
一直以来，大家都在说Javascript是单线程，浏览器无论在什么时候，都且只有一个线程在运行JavaScript程序。
但是，不知道大家有疑问没——就是我们在编程过程中的setTimeout(类似的还有setInterval、Ajax)，不是异步执行的吗？！！
例如：
[?](http://www.jb51.net/article/97224.htm#)
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object]  [object Object][object Object][object Object][object Object]

[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
运行代码，打开chrome调试器，得如下结果
 ![20161114102028334.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108145330.jpg)
这个结果很容易理解，因为我setTimeout里的内容是在100ms后执行的嘛，当然是先输出a，再输出c，100ms后再输出setTimeout里的b嘛。
咦，那Javascript这不就不是单线程了嘛，这不就可以实现多线程了？！！
其实，不是的。setTimeout没有打破JavaScript的单线程机制，它其实还是单线程。
为什么这么说呢，那就得理解setTimeout到底是个怎么回事。
请看下面的代码，猜结果:
[?](http://www.jb51.net/article/97224.htm#)
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object]  [object Object][object Object][object Object][object Object]

[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object]  [object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
看了上面的代码，猜猜输出的结果是多少呢？1000毫秒？
我们打开chrome调试器，见下图
![20161114102106172.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108145334.jpg)
纳尼，怎么不是1000毫秒呢？！！！
我们再看看下面的代码：
[?](http://www.jb51.net/article/97224.htm#)
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object]  [object Object][object Object][object Object][object Object]

[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
运行代码后！
怎么一直刷新，浏览器卡死了呢，并且没有alert！！
按道理，即使我while无限循环，在1秒后也得alert一下啊。
种种问题皆一个原因，**JavaScript是单线程 **。
要记住JavaScript是单线程，setTimeout没有实现多线程，它背后的真相是这样滴：
JavaScript引擎是单线程运行的,浏览器无论在什么时候都只且只有一个线程在运行JavaScript程序。

浏览器的内核是多线程的，它们在内核控制下相互配合以保持同步，一个浏览器至少实现三个常驻线程：JavaScript引擎线程，GUI渲染线程，浏览器事件触发线程。

***JavaScript引擎**是基于事件驱动单线程执行的，JavaScript引擎一直等待着任务队列中任务的到来，然后加以处理，浏览器无论什么时候都只有一个JavaScript线程在运行JavaScript程序。

***GUI渲染线程**负责渲染浏览器界面，当界面需要重绘（Repaint）或由于某种操作引发回流(Reflow)时,该线程就会执行。但需要注意，GUI渲染线程与JavaScript引擎是互斥的，当JavaScript引擎执行时GUI线程会被挂起，GUI更新会被保存在一个队列中等到JavaScript引擎空闲时立即被执行。

***事件触发线程**，当一个事件被触发时该线程会把事件添加到待处理队列的队尾，等待JavaScript引擎的处理。这些事件可来自JavaScript引擎当前执行的代码块如setTimeout、也可来自浏览器内核的其他线程如鼠标点击、Ajax异步请求等，但由于JavaScript的单线程关系所有这些事件都得排队等待JavaScript引擎处理（当线程中没有执行任何同步代码的前提下才会执行异步代码）。

so,通过以上讲解，以上种种问题迎刃而解。
**二、setTimeout那些事儿之延迟时间为0
**
当setTimeout的延迟时间为0时，大家想想它会怎么执行呢？
例如下面的代码：
[?](http://www.jb51.net/article/97224.htm#)
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object]  [object Object][object Object][object Object][object Object]

[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
运行代码结果如下：
![20161114102358823.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108145339.jpg)

假设你已经知道Javascript单线程的运行原理了。那么，可能会有这样的疑问：setTimeout的时间为0，都没加到处理队列的末尾，怎么会晚执行呢？不应该立即执行吗？

我的理解是，就算setTimeout的时间为0，但是它仍然是setTimeout啊，原理是不变的。所以会将其加入到队列末尾，0秒后执行。

况且，经过查找资料发现，setTimeout有一个最小执行时间，当指定的时间小于该时间时，浏览器会用最小允许的时间作为setTimeout的时间间隔，也就是说即使我们把setTimeout的毫秒数设置为0，被调用的程序也没有马上启动。

 这个最小的时间间隔是多少呢？

这和浏览器及操作系统有关。在John Resig的《Javascript忍者的秘密》一书中提到–Browsers all have a 10ms minimum delay on OSX and a(approximately) 15ms delay on Windows.（在苹果机上的最小时间间隔是10毫秒，在Windows系统上的最小时间间隔大约是15毫秒），另外，MDC中关于setTimeout的介绍中也提到，Firefox中定义的最小时间间隔（DOM_MIN_TIMEOUT_VALUE）是10毫秒，HTML5定义的最小时间间隔是4毫秒。

说了这么多，setTimeout的延迟时间为0，看来没什么意义嘛，都是放在队列后执行嘛。
非也，天生我材必有用，就看你怎么用咯。抛砖迎玉下。
1、可以用setTimeout的延迟时间为0，模拟动画效果哦。
详情请见下代码：
[?](http://www.jb51.net/article/97224.htm#)
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object]  [object Object][object Object][object Object][object Object]

[object Object][object Object][object Object]
[object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object]  [object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object]  [object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]  [object Object][object Object][object Object]
[object Object]  [object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]  [object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
由于是动画，所以想看其效果，还请各位看官运行下代码哦。

代码第19行中，利用setTimeout，在每一次render执行完成（给高度递增1）后，由于Javascript是单线程，且setTimeout里的匿名函数会在render执行完成后，再执行render。所以可以实现动画效果。

2、可以用setTimeout的延迟时间为0，实现捕获事件哦。
当我们点击子元素时，我们可以利用setTimeout的特性，来模拟捕获事件。
请见如下代码：
[?](http://www.jb51.net/article/97224.htm#)
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object]  [object Object][object Object][object Object][object Object]

[object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object][object Object][object Object]

[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
 执行代码，点击粉红色方块，输出结果：
![20161114102621853.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108145345.jpg)
**三、setTimeout那些事儿之this**
说到this，对于它的理解就是：this是指向函数执行时的当前对象，倘若没有明确的当前对象，它就是指向window的。
好了，那么我们来看看下面这段代码：
[?](http://www.jb51.net/article/97224.htm#)
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object][object Object][object Object]

[object Object][object Object]  [object Object][object Object][object Object]  [object Object][object Object][object Object][object Object]

[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
通过chrome调试器，查看输出结果：
![20161114102721192.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108145349.jpg)
咦，它怎么输出的是”!!”呢？不应该是obj里的”monkey”吗？！！
这是因为setTimeout中所执行函数中的this，永远指向window。
不对吧，那上面代码中的setTimeout(this.print,1000)里的this.print怎么指向的是obj呢？！！
注意哦，我这里说的是“延迟执行函数中的this”，而不是setTimeout调用环境下的this。
**什么意思？**
setTimeout(this.print,1000)，这里的this.print中的this就是调用环境下的；

而this.print=function(){console.log(this.name);}，这个匿名函数就是setTimeout延迟执行函数，其中的this.name也就是延迟执行函数中的this啦。

嘿嘿，这下明白了吧。
[?](http://www.jb51.net/article/97224.htm#)
1
2
3
4
5
6
7
8
9
10
11
[object Object]  [object Object]
[object Object]  [object Object]
[object Object][object Object]
[object Object][object Object][object Object]
[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]  [object Object]
咦，那有个疑问，比如我想在setTimeout延迟执行函数中的this指向调用的函数呢，而不是window？！！我们该怎么办呢。
常用的方法就是利用that。
that？
对，that。利用闭包的知识，让that保证你传进去的this，是你想要的。
详情见下:
[?](http://www.jb51.net/article/97224.htm#)
1
2
3
4
5
6
7
8
9
10
11
[object Object]  [object Object]
[object Object]  [object Object]
[object Object]
[object Object]  [object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object]
[object Object]  [object Object]
还有一种方法就是，利用bind。
如下:
[?](http://www.jb51.net/article/97224.htm#)
1
2
3
4
5
6
7
8
9
10
[object Object]  [object Object]
[object Object]  [object Object]
[object Object][object Object]
[object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object]
[object Object]
[object Object]  [object Object]
以上就是本文的全部内容，希望对大家的学习有所帮助，也希望大家多多支持脚本之家。

![jb51ewm.png](../_resources/d2e7ad3bfb3fa62c3e0a8487560771c9.png)
微信公众号搜索 “ 脚本之家 ” ，选择关注
程序猿的那些事、送书等活动等着你
Measure
Measure