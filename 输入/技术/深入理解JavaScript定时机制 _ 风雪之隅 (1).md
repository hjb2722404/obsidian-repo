深入理解JavaScript定时机制 | 风雪之隅

# 23 Sep 09 [深入理解JavaScript定时机制](http://www.laruence.com/2009/09/23/1089.html)

[(L)](https://plus.google.com/share?app=110&url=http%3A%2F%2Fwww.laruence.com%2F2009%2F09%2F23%2F1089.html)

- 本文地址: http://www.laruence.com/2009/09/23/1089.html
- 转载文章

转帖地址:http://www.9demo.com/archives/341
容易欺骗别人感情的JavaScript定时器

JavaScript的setTimeout与setInterval是两个很容易欺骗别人感情的方法,因为我们开始常常以为调用了就会按既定的方式执行, 我想不少人都深有同感, 例如

setTimeout(function()  {  alert('你好!');},  0);setInterval(callbackFunction,  100);

认为setTimeout中的问候方法会立即被执行,因为这并不是凭空而说,而是JavaScript API文档明确定义第二个参数意义为隔多少毫秒后,回调方法就会被执行. 这里设成0毫秒,理所当然就立即被执行了.

同理对setInterval的callbackFunction方法每间隔100毫秒就立即被执行深信不疑!
但随着JavaScript应用开发经验不断的增加和丰富,有一天你发现了一段怪异的代码而百思不得其解:

div.onclick =  function(){  setTimeout(function()  { document.getElementById('inputField').focus();  },  0);};

既然是0毫秒后执行,那么还用setTimeout干什么, 此刻, 坚定的信念已开始动摇.
直到最后某一天 , 你不小心写了一段糟糕的代码:

setTimeout(function()  {  while  (true)  {  }},  100);setTimeout(function()  {  alert('你好!');},  200);setInterval(callbackFunction,  200);

第一行代码进入了死循环,但不久你就会发现,第二,第三行并不是预料中的事情,alert问候未见出现,callbacKFunction也杳无音讯!

这时你彻底迷惘了,这种情景是难以接受的,因为改变长久以来既定的认知去接受新思想的过程是痛苦的,但情事实摆在眼前,对JavaScript真理的探求并不会因为痛苦而停止,下面让我们来展开JavaScript线程和定时器探索之旅!

拔开云雾见月明
出现上面所有误区的最主要一个原因是:潜意识中认为,JavaScript引擎有多个线程在执行,JavaScript的定时器回调函数是异步执行的.
而事实上的,JavaScript使用了障眼法,在多数时候骗过了我们的眼睛,这里背光得澄清一个事实:
JavaScript引擎是单线程运行的,浏览器无论在什么时候都只且只有一个线程在运行JavaScript程序.
JavaScript引擎用单线程运行也是有意义的,单线程不必理会线程同步这些复杂的问题,问题得到简化.
那么单线程的JavaScript引擎是怎么配合浏览器内核处理这些定时器和响应浏览器事件的呢?
下面结合浏览器内核处理方式简单说明.

浏览器内核实现允许多个线程异步执行,这些线程在内核制控下相互配合以保持同步.假如某一浏览器内核的实现至少有三个常驻线程:javascript引擎线程,界面渲染线程,浏览器事件触发线程,除些以外,也有一些执行完就终止的线程,如Http请求线程,这些异步线程都会产生不同的异步事件,下面通过一个图来阐明单线程的JavaScript引擎与另外那些线程是怎样互动通信的.虽然每个浏览器内核实现细节不同,但这其中的调用原理都是大同小异.

[![jstimer.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/fd645f93e5a6efb255e8540ada0b479b.jpg)](http://laruence-wordpress.stor.sinaapp.com/uploads/jstimer.jpg)

Js线程图示

由图可看出,浏览器中的JavaScript引擎是基于事件驱动的,这里的事件可看作是浏览器派给它的各种任务,这些任务可以源自JavaScript引擎当前执行的代码块,如调用setTimeout添加一个任务,也可来自浏览器内核的其它线程,如界面元素鼠标点击事件,定时触发器时间到达通知,异步请求状态变更通知等.从代码角度看来任务实体就是各种回调函数,JavaScript引擎一直等待着任务队列中任务的到来.由于单线程关系,这些任务得进行排队,一个接着一个被引擎处理.

上图t1-t2..tn表示不同的时间点,tn下面对应的小方块代表该时间点的任务,假设现在是t1时刻,引擎运行在t1对应的任务方块代码内,在这个时间点内,我们来描述一下浏览器内核其它线程的状态.

t1时刻:
GUI渲染线程:

该线程负责渲染浏览器界面HTML元素,当界面需要重绘(Repaint)或由于某种操作引发回流(reflow)时,该线程就会执行.本文虽然重点解释JavaScript定时机制,但这时有必要说说渲染线程,因为该线程与JavaScript引擎线程是互斥的,这容易理解,因为JavaScript脚本是可操纵DOM元素,在修改这些元素属性同时渲染界面,那么渲染线程前后获得的元素数据就可能不一致了.

在JavaScript引擎运行脚本期间,浏览器渲染线程都是处于挂起状态的,也就是说被”冻结”了.

所以,在脚本中执行对界面进行更新操作,如添加结点,删除结点或改变结点的外观等更新并不会立即体现出来,这些操作将保存在一个队列中,待JavaScript引擎空闲时才有机会渲染出来.

GUI事件触发线程:

JavaScript脚本的执行不影响html元素事件的触发,在t1时间段内,首先是用户点击了一个鼠标键,点击被浏览器事件触发线程捕捉后形成一个鼠标点击事件,由图可知,对于JavaScript引擎线程来说,这事件是由其它线程异步传到任务队列尾的,由于引擎正在处理t1时的任务,这个鼠标点击事件正在等待处理.

定时触发线程:

注意这里的浏览器模型定时计数器并不是由JavaScript引擎计数的,因为JavaScript引擎是单线程的,如果处于阻塞线程状态就计不了时,它必须依赖外部来计时并触发定时,所以队列中的定时事件也是异步事件.

由图可知,在这t1的时间段内,继鼠标点击事件触发后,先前已设置的setTimeout定时也到达了,此刻对JavaScript引擎来说,定时触发线程产生了一个异步定时事件并放到任务队列中, 该事件被排到点击事件回调之后,等待处理.

同理, 还是在t1时间段内,接下来某个setInterval定时器也被添加了,由于是间隔定时,在t1段内连续被触发了两次,这两个事件被排到队尾等待处理.

可见,假如时间段t1非常长,远大于setInterval的定时间隔,那么定时触发线程就会源源不断的产生异步定时事件并放到任务队列尾而不管它们是否已被处理,但一旦t1和最先的定时事件前面的任务已处理完,这些排列中的定时事件就依次不间断的被执行,这是因为,对于JavaScript引擎来说,在处理队列中的各任务处理方式都是一样的,只是处理的次序不同而已.

t1过后,也就是说当前处理的任务已返回,JavaScript引擎会检查任务队列,发现当前队列非空,就取出t2下面对应的任务执行,其它时间依此类推,由此看来:
如果队列非空,引擎就从队列头取出一个任务,直到该任务处理完,即返回后引擎接着运行下一个任务,在任务没返回前队列中的其它任务是没法被执行的.
相信您现在已经很清楚JavaScript是否可多线程,也了解理解JavaScript定时器运行机制了,下面我们来对一些案例进行分析:
案例1:setTimeout与setInterval

setTimeout(function()  {  /* 代码块... */  setTimeout(arguments.callee,  10);},  10);setInterval(function(){  /*代码块... */},  10);

这两段代码看一起效果一样,其实非也,第一段中回调函数内的setTimeout是JavaScript引擎执行后再设置新的setTimeout定时, 假定上一个回调处理完到下一个回调开始处理为一个时间间隔,理论两个setTimeout回调执行时间间隔>=10ms .第二段自setInterval设置定时后,定时触发线程就会源源不断的每隔十秒产生异步定时事件并放到任务队列尾,理论上两个setInterval回调执行时间间隔<=10.

案例2:ajax异步请求是否真的异步?
很多同学朋友搞不清楚,既然说JavaScript是单线程运行的,那么XMLHttpRequest在连接后是否真的异步?

其实请求确实是异步的,不过这请求是由浏览器新开一个线程请求(参见上图),当请求的状态变更时,如果先前已设置回调,这异步线程就产生状态变更事件放到JavaScript引擎的处理队列中等待处理,当任务被处理时,JavaScript引擎始终是单线程运行回调函数,具体点即还是单线程运行onreadystatechange所设置的函数.

 分享到：  [(L)](http://www.laruence.com/2009/09/23/1089.html#)  [(L)](http://www.laruence.com/2009/09/23/1089.html#)  [(L)](http://www.laruence.com/2009/09/23/1089.html#)  [(L)](http://www.laruence.com/2009/09/23/1089.html#)[20](http://www.laruence.com/2009/09/23/1089.html#)

## Related Posts:

- [深入理解PHP7内核之zval](http://www.laruence.com/2018/04/08/3170.html)
- [2012年1月全球www网站技术报告](http://www.laruence.com/2012/01/07/2453.html)
- [深入理解PHP原理之Session Gc的一个小概率Notice](http://www.laruence.com/2011/03/29/1949.html)
- [深入理解PHP原理之对象(一)](http://www.laruence.com/2010/05/18/1482.html)
- [Javascript原型链和原型的一个误区](http://www.laruence.com/2010/05/13/1462.html)
- [IE下var的重要性的又一佐证](http://www.laruence.com/2010/01/21/1254.html)
- [关于Javascript的俩个有趣的探讨](http://www.laruence.com/2009/09/27/1123.html)
- [深入理解Javascript之this关键字](http://www.laruence.com/2009/09/08/1076.html)
- [正确使用JS中的正则](http://www.laruence.com/2009/08/09/1036.html)
- [Javascript作用域原理](http://www.laruence.com/2009/05/28/863.html)

Tags: [javascript](http://www.laruence.com/tag/javascript), [setinterval](http://www.laruence.com/tag/setinterval), [settimeout](http://www.laruence.com/tag/settimeout), [单线程](http://www.laruence.com/tag/%e5%8d%95%e7%ba%bf%e7%a8%8b), [原理](http://www.laruence.com/tag/%e5%8e%9f%e7%90%86), [定时器](http://www.laruence.com/tag/%e5%ae%9a%e6%97%b6%e5%99%a8)

Filed in [Js/CSS](http://www.laruence.com/category/jscss), [转载](http://www.laruence.com/category/%e8%bd%ac%e8%bd%bd)