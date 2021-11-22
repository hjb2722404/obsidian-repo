8张图让你一步步看清 async/await 和 promise 的执行顺序 | Fundebug博客 - 一行代码搞定BUG监控 - 网站错误监控|JS错误监控|资源加载错误|网络请求错误|小程序错误监控|Java异常监控|监控报警|Source Map|用户行为|可视化重现

# [8张图让你一步步看清 async/await 和 promise 的执行顺序](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/)

**摘要：** 面试必问。

- 原文：[8张图帮你一步步看清 async/await 和 promise 的执行顺序](https://segmentfault.com/a/1190000017224799)
- 作者：[ziwei3749](https://segmentfault.com/u/ziwei3749)

**[Fundebug](https://www.fundebug.com/)经授权转载，版权归原作者所有。**

### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E4%B8%BA%E4%BB%80%E4%B9%88%E5%86%99%E8%BF%99%E7%AF%87%E6%96%87%E7%AB%A0%EF%BC%9F)为什么写这篇文章？

说实话，关于js的异步执行顺序，宏任务、微任务这些，或者async/await这些慨念已经有非常多的文章写了。
但是怎么说呢，简单来说，业务中很少用async，不太懂async呢。
研究了一天，感觉懂了，所手痒想写一篇 ，哈哈。
毕竟自己学会的知识，如果连表达清楚都做不到，怎么能指望自己用好它呢？

### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E6%B5%8B%E8%AF%95%E4%B8%80%E4%B8%8B%E8%87%AA%E5%B7%B1%E6%9C%89%E6%B2%A1%E6%9C%89%E5%BF%85%E8%A6%81%E7%9C%8B)测试一下自己有没有必要看

所以我写这个的文章，主要还是交流学习，如果您已经清楚了eventloop/async/await/promise这些东西呢，可以 break 啦
有说的不对的地方，欢迎留言讨论，
那么还是先通过一道题自我检测一下，是否有必要继续看下去把。
其实呢，这是去年一道烂大街的「今日头条」的面试题。
我觉得这道题的关键，不仅是说出正确的打印顺序，更重要的能否说清楚每一个步骤，为什么这样执行。

|     |
| --- |
| async  function  async1() {<br> console.log("async1 start");<br> await async2();<br> console.log("async1 end");<br>}<br>async  function  async2() {<br> console.log("async2");<br>}<br>console.log("script start");<br>setTimeout(function() {<br> console.log("setTimeout");<br>}, 0);<br>async1();<br>new  Promise(function(resolve) {<br> console.log("promise1");<br>resolve();<br>}).then(function() {<br> console.log("promise2");<br>});<br>console.log("script end"); |

> 注：因为是一道前端面试题，所以答案是以浏览器的eventloop机制为准的，在node平台上运行会有差异。

|     |
| --- |
| script start<br>async1 start<br>async2<br>promise1<br>script end<br>promise2<br>async1 end<br>setTimeout |

如果你发现运行结果跟自己想的一样，可以选择跳过这篇文章啦，
或者如果你有兴趣看看俺俩的理解有没有区别，可以跳到后面的 「画图讲解的部分」

### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E9%9C%80%E8%A6%81%E5%85%B7%E5%A4%87%E7%9A%84%E5%89%8D%E7%BD%AE%E7%9F%A5%E8%AF%86)需要具备的前置知识

- promise的使用经验
- 浏览器端的eventloop

不过如果是对 ES7 的 async 不太熟悉，是没关系的哈，因为这篇文章会详解 async。
那么如果不具备这些知识呢，推荐几篇我觉得讲得比较清楚的文章

- [《10分钟理解JS引擎的执行机制》](https://segmentfault.com/a/1190000012806637)：这是我之前写的讲解eventloop的文章，我觉得还算清晰，但是没涉及 async
- [《理解 JavaScript 的 async/await》](https://segmentfault.com/a/1190000007535316)：这是我读过的讲async await最清楚的文章
- [《ECMAScript 6 入门 - Promise 对象》](http://es6.ruanyifeng.com/#docs/promise)：promise就推荐阮一峰老师的ES6吧，不过不熟悉 promise 的应该较少啦。

## [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E4%B8%BB%E8%A6%81%E5%86%85%E5%AE%B9)主要内容

### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E7%AC%AC1%E9%83%A8%E5%88%86%EF%BC%9A%E5%AF%B9%E4%BA%8Easync-await%E7%9A%84%E7%90%86%E8%A7%A3)第1部分：对于async await的理解

我推荐的那篇文章，对 async/await 讲得更详细。不过我希望自己能更加精炼的帮你理解它们这部分，主要会讲解 3 点内容

- async 做一件什么事情？
- await 在等什么？
- await 等到之后，做了一件什么事情？
- async/await 比 promise有哪些优势？（回头补充）

#### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#async-%E5%81%9A%E4%B8%80%E4%BB%B6%E4%BB%80%E4%B9%88%E4%BA%8B%E6%83%85%EF%BC%9F)async 做一件什么事情？

**带 async 关键字的函数，它使得你的函数的返回值必定是 promise 对象**
也就是
如果async关键字函数返回的不是promise，会自动用Promise.resolve()包装
如果async关键字函数显式地返回promise，那就以你返回的promise为准
这是一个简单的例子，可以看到 async 关键字函数和普通函数的返回值的区别

|     |
| --- |
| async  function  fn1(){<br> return  123<br>}<br>function  fn2(){<br> return  123<br>}<br>console.log(fn1())<br>console.log(fn2())<br>Promise {<resolved>: 123}<br>123 |

所以你看，async 函数也没啥了不起的，以后看到带有 async 关键字的函数也不用慌张，你就想它无非就是把return值包装了一下，其他就跟普通函数一样。
关于async关键字还有那些要注意的？

- 在语义上要理解，async表示函数内部有异步操作
- 另外注意，一般 await 关键字要在 async 关键字函数的内部，await 写在外面会报错。

#### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#await-%E5%9C%A8%E7%AD%89%E4%BB%80%E4%B9%88%EF%BC%9F)await 在等什么？

**await等的是右侧「表达式」的结果**
也就是说，
右侧如果是函数，那么函数的return值就是「表达式的结果」
右侧如果是一个 ‘hello’ 或者什么值，那表达式的结果就是 ‘hello’

|     |
| --- |
| async  function  async1() {<br> console.log( 'async1 start' )<br> await async2()<br> console.log( 'async1 end' )<br>}<br>async  function  async2() {<br> console.log( 'async2' )<br>}<br>async1()<br>console.log( 'script start' ) |

这里注意一点，可能大家都知道await会让出线程，阻塞后面的代码，那么上面例子中， ‘async2’ 和 ‘script start’ 谁先打印呢？
是从左向右执行，一旦碰到await直接跳出, 阻塞async2()的执行？
还是从右向左，先执行async2后，发现有await关键字，于是让出线程，阻塞代码呢？
**实践的结论是，从右向左的。先打印async2，后打印的script start**
之所以提一嘴，是因为我经常看到这样的说法，「一旦遇到await就立刻让出线程，阻塞后面的代码」
这样的说法，会让我误以为，await后面那个函数， async2()也直接被阻塞呢。

#### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#await-%E7%AD%89%E5%88%B0%E4%B9%8B%E5%90%8E%EF%BC%8C%E5%81%9A%E4%BA%86%E4%B8%80%E4%BB%B6%E4%BB%80%E4%B9%88%E4%BA%8B%E6%83%85%EF%BC%9F)await 等到之后，做了一件什么事情？

那么右侧表达式的结果，就是await要等的东西。
等到之后，对于await来说，分2个情况

- 不是promise对象
- 是promise对象

**如果不是 promise , await会阻塞后面的代码，先执行async外面的同步代码，同步代码执行完，再回到async内部，把这个非promise的东西，作为 await表达式的结果**

**如果它等到的是一个 promise 对象，await 也会暂停async后面的代码，先执行async外面的同步代码，等着 Promise 对象 fulfilled，然后把 resolve 的参数作为 await 表达式的运算结果。**

### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E7%AC%AC2%E9%83%A8%E5%88%86%EF%BC%9A%E7%94%BB%E5%9B%BE%E4%B8%80%E6%AD%A5%E6%AD%A5%E7%9C%8B%E6%B8%85%E5%AE%8F%E4%BB%BB%E5%8A%A1%E3%80%81%E5%BE%AE%E4%BB%BB%E5%8A%A1%E7%9A%84%E6%89%A7%E8%A1%8C%E8%BF%87%E7%A8%8B)第2部分：画图一步步看清宏任务、微任务的执行过程

我们以开篇的经典面试题为例，分析这个例子中的宏任务和微任务。

|     |
| --- |
| async  function  async1() {<br> console.log("async1 start");<br> await async2();<br> console.log("async1 end");<br>}<br>async  function  async2() {<br> console.log("async2");<br>}<br>console.log("script start");<br>setTimeout(function() {<br> console.log("setTimeout");<br>}, 0);<br>async1();<br>new  Promise(function(resolve) {<br> console.log("promise1");<br>resolve();<br>}).then(function() {<br> console.log("promise2");<br>});<br>console.log("script end"); |

先分享一个我个人理解的宏任务和微任务的慨念，在我脑海中宏任务和为微任务如图所示

[![2018-12-10-01.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/47e415bb079ddcb2926bc7cfeedc3a70.png)](https://image.fundebug.com/2018-12-10-01.png)

也就是「宏任务」、「微任务」都是队列。
一段代码执行时，会先执行宏任务中的同步代码，

- 如果执行中遇到setTimeout之类宏任务，那么就把这个setTimeout内部的函数推入「宏任务的队列」中，下一轮宏任务执行时调用。
- 如果执行中遇到promise.then()之类的微任务，就会推入到「当前宏任务的微任务队列」中，在本轮宏任务的同步代码执行都完成后，依次执行所有的微任务1、2、3

下面就以面试题为例子，分析这段代码的执行顺序。
每次宏任务和微任务发生变化，我都会画一个图来表示他们的变化。

#### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E7%9B%B4%E6%8E%A5%E6%89%93%E5%8D%B0%E5%90%8C%E6%AD%A5%E4%BB%A3%E7%A0%81-console-log-%E2%80%98script-start%E2%80%99)直接打印同步代码 console.log(‘script start’)

|     |
| --- |
| // 首先是2个函数声明，虽然有async关键字，但不是调用我们就不看。然后首先是打印同步代码<br>console.log('script start') |

[![2018-12-10-02.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/54972a0849f7ea8cb9fbb399ccb27779.png)](https://image.fundebug.com/2018-12-10-02.png)

#### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E5%B0%86setTimeout%E6%94%BE%E5%85%A5%E5%AE%8F%E4%BB%BB%E5%8A%A1%E9%98%9F%E5%88%97)将setTimeout放入宏任务队列

默认所包裹的代码，其实可以理解为是第一个宏任务，所以这里是宏任务2

[![2018-12-10-03.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/814e9323bc833655d9ea6ecbfdf567cb.png)](https://image.fundebug.com/2018-12-10-03.png)

#### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E8%B0%83%E7%94%A8async1%EF%BC%8C%E6%89%93%E5%8D%B0-%E5%90%8C%E6%AD%A5%E4%BB%A3%E7%A0%81-console-log-%E2%80%98async1-start%E2%80%99)调用async1，打印 同步代码 console.log( ‘async1 start’ )

我们说过看到带有async关键字的函数，不用害怕，它的仅仅是把return值包装成了promise，其他并没有什么不同的地方。所以就很普通的打印 console.log( ‘async1 start’ )

[![2018-12-10-04.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/0cbb3c9d23c36310b33308ca5ec16cdf.png)](https://image.fundebug.com/2018-12-10-04.png)

#### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E5%88%86%E6%9E%90%E4%B8%80%E4%B8%8B-await-async2)分析一下 await async2()

前文提过await，1.它先计算出右侧的结果，2.然后看到await后，中断async函数

- 先得到await右侧表达式的结果。执行async2()，打印同步代码console.log(‘async2’), 并且return Promise.resolve(undefined)
- await后，中断async函数，先执行async外的同步代码

目前就直接打印 console.log(‘async2’)

[![2018-12-10-05.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/c7bf1c0d72d01cf2554a412f22f638e0.png)](https://image.fundebug.com/2018-12-10-05.png)

#### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E8%A2%AB%E9%98%BB%E5%A1%9E%E5%90%8E%EF%BC%8C%E8%A6%81%E6%89%A7%E8%A1%8Casync%E4%B9%8B%E5%A4%96%E7%9A%84%E4%BB%A3%E7%A0%81)被阻塞后，要执行async之外的代码

执行new Promise()，Promise构造函数是直接调用的同步代码，所以 console.log( ‘promise1’ )

[![2018-12-10-06.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/bdb8c252496927d1ae765adc4b35c746.png)](https://image.fundebug.com/2018-12-10-06.png)

#### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E4%BB%A3%E7%A0%81%E8%BF%90%E8%A1%8C%E5%88%B0promise-then)代码运行到promise.then()

代码运行到promise.then()，发现这个是微任务，所以暂时不打印，只是推入当前宏任务的微任务队列中。
**注意：这里只是把promise2推入微任务队列，并没有执行。微任务会在当前宏任务的同步代码执行完毕，才会依次执行**

[![2018-12-10-07.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/1c12daee20ef6dab1be4098244715098.png)](https://image.fundebug.com/2018-12-10-07.png)

#### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E6%89%93%E5%8D%B0%E5%90%8C%E6%AD%A5%E4%BB%A3%E7%A0%81-console-log-%E2%80%98script-end%E2%80%99)打印同步代码 console.log(‘script end’)

没什么好说的。执行完这个同步代码后，「async外的代码」终于走了一遍
下面该回到 await 表达式那里，执行await Promise.resolve(undefined)了

[![2018-12-10-08.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/d35fdb73ad39413de46177c729874989.png)](https://image.fundebug.com/2018-12-10-08.png)

#### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E5%9B%9E%E5%88%B0async%E5%86%85%E9%83%A8%EF%BC%8C%E6%89%A7%E8%A1%8Cawait-Promise-resolve-undefined)回到async内部，执行await Promise.resolve(undefined)

这部分可能不太好理解，我尽量表达我的想法。
对于 await Promise.resolve(undefined) 如何理解呢？

根据 [MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/await) 原话我们知道

**如果一个 Promise 被传递给一个 await 操作符，await 将等待 Promise 正常处理完成并返回其处理结果。**
在我们这个例子中，就是Promise.resolve(undefined)正常处理完成，并返回其处理结果。那么await async2()就算是执行结束了。
目前这个promise的状态是fulfilled，等其处理结果返回就可以执行await下面的代码了。
那何时能拿到处理结果呢？
回忆平时我们用promise，调用resolve后，何时能拿到处理结果？是不是需要在then的第一个参数里，才能拿到结果。
（调用resolve时，会把then的参数推入微任务队列，等主线程空闲时，再调用它）
所以这里的 await Promise.resolve() 就类似于

|     |
| --- |
| Promise.resolve(undefined).then((undefined) => {<br>}) |

把then的第一个回调参数 (undefined) => {} 推入微任务队列。
then执行完，才是await async2()执行结束。
await async2()执行结束，才能继续执行后面的代码
如图

[![2018-12-10-09.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/cb4fe66db40df96269876f338be4458f.png)](https://image.fundebug.com/2018-12-10-09.png)

此时当前宏任务1都执行完了，要处理微任务队列里的代码。
微任务队列，先进选出的原则，

- 执行微任务1，打印promise2
- 执行微任务2，没什么内容..

但是微任务2执行后，await async2()语句结束，后面的代码不再被阻塞，所以打印
console.log(‘async1 end’)

#### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E5%AE%8F%E4%BB%BB%E5%8A%A11%E6%89%A7%E8%A1%8C%E5%AE%8C%E6%88%90%E5%90%8E-%E6%89%A7%E8%A1%8C%E5%AE%8F%E4%BB%BB%E5%8A%A12)宏任务1执行完成后,执行宏任务2

宏任务2的执行比较简单，就是打印
console.log(‘setTimeout’)

### [(L)](https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/#%E8%A1%A5%E5%85%85%E5%9C%A8%E4%B8%8D%E5%90%8C%E6%B5%8F%E8%A7%88%E5%99%A8%E4%B8%8A%E7%9A%84%E6%B5%8B%E8%AF%95%E7%BB%93%E6%9E%9C)补充在不同浏览器上的测试结果

谷歌浏览器，目前是版本是「版本 71.0.3578.80（正式版本） （64 位）」 Mac操作系统

[![2018-12-10-10.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/4822b041996bf6c99d70132c62340c77.png)](https://image.fundebug.com/2018-12-10-10.png)

Safari浏览器的测试结果

[![2018-12-10-11.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/756e47d4912172d90b1bc70fe4eced6d.png)](https://image.fundebug.com/2018-12-10-11.png)

火狐浏览器的测试结果

[![2018-12-10-12.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/c88a30ad4f9c36a7a0115dbeff558579.png)](https://image.fundebug.com/2018-12-10-12.png)

如果不理解可以留言，有错误的话也欢迎指正。

### 关于Fundebug

[Fundebug](https://www.fundebug.com/)专注于JavaScript、微信小程序、微信小游戏、支付宝小程序、React Native、Node.js和Java线上应用实时BUG监控。 自从2016年双十一正式上线，Fundebug累计处理了40亿+错误事件，付费客户有阳光保险、达令家、核桃编程、荔枝FM、微脉等众多品牌企业。欢迎大家[免费试用](https://www.fundebug.com/team/create)！

[![wechat_slogan.png](../_resources/3f157d749dc36f62483a7b2f7ff908c5.png)](https://static.fundebug.cn/wechat_slogan.png)

### 版权声明

转载时请注明作者**[Fundebug](https://blog.fundebug.com/)**以及本文地址：

**https://blog.fundebug.com/2018/12/10/understand-async-await-and-promise-by-8-pictures/**

您的用户遇到BUG了吗？

[体验Demo](https://www.fundebug.com/demo)  [免费使用](https://www.fundebug.com/team/create)