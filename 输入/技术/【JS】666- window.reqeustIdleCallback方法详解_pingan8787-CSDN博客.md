![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy9keTlDWGVaTGxDVnNoRmJGNFNPaWFDZ0g4NEN2NndxdHdudThaYndKbU04b3RBWjdnaWNiRlplVU1leWE5YVJsdVZCSGlhM2FGc2JRVElBUlJyNkthcjI3US82NDA?x-oss-process=image/format,png)

> 它和 requestAnimationFrame 一样吗？

最初我以为这个函数就是和实现动画的 requestAnimationFrame 拥有相同的行为，因为它们的使用方法非常类似，但实际使用后发现它们的差别还是蛮大的。本文主要对这个神秘的函数进行一些说明和分析。

### 定义和用法

首先来看一下它的定义和用法，MDN是这样定义它的：

> 这是一个实验中的功能，window.requestIdleCallback() 将一个（即将）在浏览器空闲时间执行的函数加入队列，这使得开发者在主事件循环中可以执行低优先级工作，而不影响对延迟敏感的事件，如动画和输入响应。

通过这个定义，我们发现它的执行时机在浏览器的“空闲”状态，那么怎样定义这个状态呢？

浏览器每一帧都需要完成这些任务：

1.  处理用户交互
    
2.  JS执行
    
3.  一帧的开始，处理视窗变化、页面滚动等
    
4.  requestAnimationFrame(rAF)
    
5.  重排(layout)
    
6.  绘制(draw)
    

在这些步骤完成后，如果时间消耗还没超过16ms，则浏览器还有余力去处理其他的任务，我们在 reqeustIdleCallback 中传入的回调将在此时执行；相反，如果时间消耗太大，则回调不执行，任务会顺延到下个帧浏览器空闲的时候再执行。而如果浏览器一直都很忙，那任务就会一再被推迟，很可能需要消耗大量时间后才得到执行。为了解决这个问题，可以在注册任务的时候提供一个 timeout 参数指定超时时间，在超时时间之内，该任务会被优先放在浏览器的执行队列中。

下面来看下它的用法：

```null
  timeRemaining: () => number type Tick = (deadline: Dealine) => void;type Options = { timeout: number }; type RequestIdleCallback = (tick: Tick, options?: Options) => number ```

一个常见的用法是，当有剩余时间或者timeout发生时执行一些任务，通常将任务保存在一个队列中便于进行调度。

```null
const tick = function(deadline) {const remaining = deadline.timeRemaining();  while (remaining > 0 || didTimeout) {const currentTask = taskQueue.shift();  requestIdleCallback(tick, { timeout: 500 });requestIdleCallback(tick, { timeout: 500 });```

### reqeustIdleCallback 的执行行为

requestAnimationFrame 大家经常拿来实现动画，因为它是一个“靠谱的”函数，如果页面没有阻塞，那么这个函数每16ms左右调用一次；requestIdleCallback 则不同，它的执行间隔是不固定的，取决于浏览器此时正在执行的任务，下面举几个例子来看下。

我们简单地在页面中注册 requestIdleCallback，先不提供timeout参数

```null
const tick = function(deadline) {const remaining = deadline.timeRemaining();  requestIdleCallback(tick);requestIdleCallback(tick);```

场景一，页面中同时使用 requestAnimationFrame 函数循环注册一个事件，使页面发生重绘。

```null
const cutiePie = document.querySelector('.cutie-pie');  cutiePie.style.transform = `translate(${1 - Math.random() * 100}px, 0)`;  requestAnimationFrame(t);requestAnimationFrame(t);```

![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy85YUtPQWJNRVE1cXN1VThtRkNhdGliSU5IUmtBOThUR3J0aWMxSkxFWnZzYURRMDFWUVhNWVZTeWE1UENXbmliMm5Kb3lyTEpUZW1pY1dRc0tlNWliY2phM1hnLzY0MA?x-oss-process=image/format,png)

通过时间轴查看 requestIdleCallback 在 requestAnimationFrame、重排和绘制之后执行，执行间隔和 requestAnimationFrame 相应，在16ms左右，这符合上文提到的每一帧中浏览器执行任务的顺序。

场景二，我们在场景一的基础上停止动画，

![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy85YUtPQWJNRVE1cXN1VThtRkNhdGliSU5IUmtBOThUR3I4NFBnUVc0cEVoNzllMDlrMGxqMjVGZVB0Q2JpYWRpYWhDRHY0bE9QbDc3MFRyaWMybDM2YzlwbXcvNjQw?x-oss-process=image/format,png)

此时页面完全静止，重排和绘制都停止了，但是浏览器仍然在注册 requestIdleCallback 并执行其回调，执行间隔在50ms左右，并没有以类似 requestAnimationFrame 的16ms间隔执行。

场景三，在场景一和场景二的基础上，页面分别不定时执行一个超过16ms的任务。

![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy85YUtPQWJNRVE1cXN1VThtRkNhdGliSU5IUmtBOThUR3JER1E4RUc0ZlhpY2RpYnVvam8ycjB6ckVPOFZlWUsyaWF0VFFYYm1YQ09VaWFpYkdHOVRjODVMbEpXdy82NDA?x-oss-process=image/format,png)
 ![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy85YUtPQWJNRVE1cXN1VThtRkNhdGliSU5IUmtBOThUR3JTVWxGTzNNNzA5RkRDbk9RS29BSWc3dDBNN1JMdDhZZGlhallrQVZTSHB1aDluVWlhMDllQnU3QS82NDA?x-oss-process=image/format,png)

从上面两个场景可以看出，无论页面处于动态还是静止，如果有任务执行时间过长，则这一帧中 requestIdleCallback 不会被执行，而是被延迟到下一帧。

场景四，上面的情形都没有附加timeout参数，现在我们在场景二静止的页面中给 requestIdleCallback 加上timeout参数再看看：

```null
const tick = function(deadline) {const remaining = deadline.timeRemaining();  requestIdleCallback(tick, {timeout: 500});requestIdleCallback(tick, {timeout: 500});```

![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy85YUtPQWJNRVE1cXN1VThtRkNhdGliSU5IUmtBOThUR3JMQ2V2NmliWTFkU2liZmhzNUpVa0pJVE9ocDlpYkdXNkZLQkd2bUI5ZkYxUlFZYmJrRmR0cnVvUFEvNjQw?x-oss-process=image/format,png)

执行间隔变到5-20ms左右，变得相当混乱，原因可能是浏览器增加了额外的工作检验任务是否已经超时，可见附加timeout属性想让它变得“靠谱”是要付出代价的，其调用频率将大幅上升。

通过以上分析，我们得知 requestAnimationFrame 的执行规律符合上文对浏览器空闲时间的描述，如果一帧中任务的执行时间超过了一定的时间（粗略估计在20ms左右），则任务会顺延到下一帧中执行。那利用它进行卡顿监控是否可行呢？即收集两次执行回调的间隔以判断有无消耗时间较长的任务阻塞线程。首先如果不加timeout参数是不可行的，试想如果页面每一帧执行时间都在20ms左右，则我们注册的任务会持续被顺延，而此时页面并不卡顿（fps还在50左右），但是如果添加了timeout参数，则这个函数的调用频率大幅提高，甚至比 requestAnimationFrame 还要频繁，然后结合其兼容性来看，综合性能可能还不如后者。

### 最长执行时间

如果 requestIdleCallback 的执行阻塞线程太久，就可能发生卡顿了，每一帧中requestIdleCallback 回调的最长的执行时间是50ms（这是建议的，但是你也可以做坏事），即回调中`deadline.timeRemaining()`的最大值小于50，这个阈值是RAIL模型定义的。

通常人类对100ms以内的延迟无感，而一旦超过这个阈值，则可能感觉到卡顿(jank)。下表中列举了一些延迟时间和用户体验的对应关系：

| 时间范围 | 用户体验 |
| --- | --- |
| 0-16ms | 页面是丝滑的，每秒绘制60帧，即16ms每帧，其中包括浏览器绘制的时间(Raster和GPU等的时间消耗)，生成一帧的时间在10ms左右 |
| 0-100ms | 在此期间对用户的交互作出响应，用户感觉是立即得到结果，否则就会认为没有立即得到反馈 |
| 100-1000ms | 被用户理解为一项连续而自然的任务，就像加载页面或者改变视图 |
| 1000ms以上 | 用户对正在执行的任务失去关注 |
| 10000ms以上 | 用户感到沮丧，很可能放弃正在执行的任务，而且他们可能不会再回来了 |

试想在某种理想情况下，浏览器开始执行 requestIdleCallback 中的回调任务，同时用户立即输入一些文字，此时浏览器在处理回调任务，输入事件被挂起，等回调执行完成后，用户输入事件对应的回调得到执行(oninput, onchange等)，最后发生layout和repaint，用户输入的内容才能出现在屏幕上。以上这一切都要在100ms之内完成，RAIL模型将其分为了两段，每一段50ms，分别用于处理两个阶段的任务，具体见下图：

![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy85YUtPQWJNRVE1cXN1VThtRkNhdGliSU5IUmtBOThUR3IxUUlNZDdFVFZCTW9ZdXc4Z1BpYmg1N3dwQVg3b04xanJmczJqZ1hTdnozaWExSmJFNlNmQjB2dy82NDA?x-oss-process=image/format,png)

longtask的定义也是基于此模型，它表示执行时间50ms以上的任务，阻塞线程50ms以上可能引起交互时间延迟，造成紊乱的动画和滚动，在performance面板中任务右上角有一个清晰的角标。

### 使用建议

基于此API的特殊性，提供一些使用建议：

1.  只在低优先级的任务中使用它，因为你无法控制它的执行时机。比如给后台发送一些不怎么重要的监控数据，或者进行某种页面检查。
    
2.  不要在其中修改DOM元素，因为它在一个任务周期的layout结束之后才执行，如果你修改了DOM，则会再次引发重排，这会对性能产生一定的影响。推荐的做法是创建一个documentFragment保存对dom的修改，并注册requestAnimationFrame来应用这些修改。
    
3.  不在其中执行难以预测执行时间的任务，比如以Promise的形式执行某个接口请求。
    
4.  只在必需的时候使用timeout选项，浏览器会花费额外的开销在检查是否超时上，产生一些性能损失。
    

### React如何polyfill

React16.6之后在任务调度中意图使用 requestIdleCallback 这个函数，但是它的兼容性并不好，Safari、安卓8.1以下、IE等都是重灾区，所以React做了一个Polyfill，它是怎么做的呢？这里简要介绍下 React16.13.1 中实现的步骤。

React维护了两个小顶堆taskQueue和timerQueue，前者保存等待被调度的任务，后者保存调度中的任务，它们的排列依据分别是任务的超时时间和过期时间。到达超时时间的任务会从timerQueue移动到taskQueue中，而在过期时间之内taskQueue中的任务期望得到执行，React调度的核心主要是以下几点：1. 何时把超时的任务从timerQueue转移到taskQueue；2. taskQueue中任务的执行时机，以及后续任务的衔接；3. 何时暂停执行任务，把资源回交给浏览器。

使用 unstable\_scheduleCallback 注册任务的时候可以提供两个参数，delay表示任务的超时时长，timeout表示任务的过期时长（如果没有指定，根据优先程度任务会被分配默认的timeout时长）。如果没有提供delay，则任务被直接放到taskQueue中等待处理；如果提供了delay，则任务被放置在timerQueue中，此时如果taskQueue为空，且当前任务在timerQueue的堆顶（当前任务的超时时间最近），则使用 requestHostTimeout 启动定时器（setTimeout），在到达当前任务的超时时间时执行 handleTimeout ，此函数调用 advanceTimers 将timerQueue中的任务转移到taskQueue中，此时如果taskQueue没有开启执行则调用 requestHostCallback 启动它，否则继续递归地执行 handleTimeout 处理下一个timerQueue中的任务。

那么taskQueue如何启动呢？在支持 MessageChannel 的环境中是利用它来实现的：

```null
const channel = new MessageChannel();const port = channel.port2;channel.port1.onmessage = performWorkUntilDeadline;requestHostCallback = function(callback) {```

在上面的代码中，port1收到message后开始执行 performWorkUntilDeadline，此时处于一帧绘制结束、下一帧即将开始之际，这个函数先依据当前的时间戳估算出该帧的过期时间（deadline默认是在当前时间戳的基础上加5ms），然后调用flushWork，这个函数在taskQueue中任务执行之前重置一些状态，再进行一波性能分析，接着它调用了 workLoop 执行taskQueue中的任务。

终于可以执行我们注册的任务了！但在执行任务之前，还要做一件事，就是调用我们上面提到过的 advanceTimers，将timerQueue中超时的任务转移到taskQueue中。此时我们终于可以在5ms的时间分片里执行taskQueue中的任务了，每执行完一项任务，都会执行一下advanceTimers拉取超时任务，然后如果此时还没到达分片的时间阈值，则继续执行下一项任务直至到达deadline。此时如果taskQueue中还有任务，则调用上文提到的 requestHostCallback 继续在下一帧的5ms间隙里执行任务直到任务穷尽；如果没有更多任务了，则检查timerQueue中是否有任务，有则使用 requestHostTimeout 启动定时器，没有则任务完全结束。

上面所说的时间分片很好地将浏览器绘制之后的空闲时间利用起来了，看到这里是不是很像我们的 requestIdleCallback 呢？5ms时间分片在有频繁交互、重绘的页面确实是不错的选择，但如果页面基本是静态的，可以将一个时间分片拉长吗？在 React 源码中确实是对此进行了考虑的，这里利用了一个支持度不算太高的BOM API `navigator.scheduling.isInputPending`, 它表示用户的输入是否被挂起，也就是我们上文提到的用户输入没有及时得到反馈。如果页面没有发生交互，且不需要重绘（needsPaint === false，这是程序内的一个全局变量），则React会把时间分片提升到300ms（maxYieldInterval），虽然这个时间远超反应延迟，但是taskQueue中每一项任务执行完成后都会去检测有没有用户交互和重绘，如果有则立即把资源回交给浏览器，所以不用担心会因此发生卡顿。

整个过程的大致图解如下：

![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy85YUtPQWJNRVE1cXN1VThtRkNhdGliSU5IUmtBOThUR3J1NW1iM05XZGlhY0FSbHpBd2ZISFEyZGliNkFRZWtuWXpVdnA0dzl5Q3ZhVTRYNExGeUo1SEdVUS82NDA?x-oss-process=image/format,png)

### 参考

1.  Making the Most of Idle Moments with requestIdleCallback(): https://www.afasterweb.com/2017/11/20/utilizing-idle-moments/
    
2.  Measure performance with the RAIL model: https://web.dev/rail/
    
3.  requestIdleCallback和requestAnimationFrame详解: https://www.jianshu.com/p/2771cb695c81
    
4.  requestIdleCallback and requestAnimationFrame: https://www.programmersought.com/article/49591734065/)
    

![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X2dpZi91c3lUWjg2TURpY2dxakxxMFVTRjZpY2liZldpYUxTVjhiejE3Y0Jqdlh5bFU3ZHo5bUlNUDdsVUY1ME9FMmdGcmxaRFFsSXlXdkdjVWlhcHJxOTJmcTh0Z1hnLzY0MA?x-oss-process=image/format,png)

[1\. JavaScript 重温系列（22篇全）](http://mp.weixin.qq.com/s?__biz=MjM5MDc4MzgxNA%3D%3D&chksm=b1c224ea86b5adfc10c3aa1841be3879b9360d671e98cc73391c2490246f1348857b9821d32c&idx=1&mid=2458453187&scene=21&sn=a69b4d7d991867a07a933f86e66b9f55#wechat_redirect)  

[2\. ECMAScript 重温系列（10篇全）](http://mp.weixin.qq.com/s?__biz=MjM5MDc4MzgxNA%3D%3D&chksm=b1c224e086b5adf6dad41a0d36b77a9bfb4bc9f0d29a816266b3e28c892e54274967dbce380b&idx=1&mid=2458453193&scene=21&sn=e5392cb77bc17c9e94b6c826b5f52a83#wechat_redirect)  

[3\. JavaScript设计模式 重温系列（9篇全）](http://mp.weixin.qq.com/s?__biz=MjM5MDc4MzgxNA%3D%3D&chksm=b1c224e386b5adf554ab928cdeaf7ee16dbb2d895be17f2a12a59054a75b913470ca7649bbc7&idx=1&mid=2458453194&scene=21&sn=e7f0734b04484bee5e10a85a7cbb85c1#wechat_redirect)

4. [正则 / 框架 / 算法等 重温系列（16篇全）](http://mp.weixin.qq.com/s?__biz=MjM5MDc4MzgxNA%3D%3D&chksm=b1c224e286b5adf432850f82db18cc8647d639836798cf16b478d9a6f7c81df87c6da5257684&idx=1&mid=2458453195&scene=21&sn=1e0c8b7ea8ddc207b523ec0a636a5254#wechat_redirect)

5. [Webpack4 入门（上）](http://mp.weixin.qq.com/s?__biz=MjM5MDc4MzgxNA%3D%3D&chksm=b1c2251f86b5ac09dbbbb7c8e1d80c6cbd793a523cdfa690f8734def57812e616b9906aeec79&idx=1&mid=2458453302&scene=21&sn=904e40a421024ea0d394e9850b674012#wechat_redirect)|| [Webpack4 入门（下）](http://mp.weixin.qq.com/s?__biz=MjM5MDc4MzgxNA%3D%3D&chksm=b1c2251e86b5ac08464872cd880811423e0d1bbcebbe11dcac9d99fa38c5332c089c06d65d95&idx=1&mid=2458453303&scene=21&sn=422f2b5e22c3b0e91a8353ee7e53fed9#wechat_redirect)

6. [MobX 入门（上）](http://mp.weixin.qq.com/s?__biz=MjM5MDc4MzgxNA%3D%3D&chksm=b1c2264c86b5af5aa7300a04d55efead6223e310d68e10222cd3577a25c783d3429f00767960&idx=1&mid=2458453605&scene=21&sn=0a506769d5eeb7953f676e93fb4d18eb#wechat_redirect) ||  [MobX 入门（下）](http://mp.weixin.qq.com/s?__biz=MjM5MDc4MzgxNA%3D%3D&chksm=b1c2264086b5af5611524eedb0d409afe86d859dce6ceff1c17ddab49d353c385e45611a73fa&idx=1&mid=2458453609&scene=21&sn=f0c22e82f2537204d9b173161bae6b82#wechat_redirect)

7. [70+篇原创系列汇总](http://mp.weixin.qq.com/s?__biz=MjM5MDc4MzgxNA%3D%3D&chksm=b1c224dd86b5adcbd98189315e60de6a0106993690b69927cc1c1f19fd8f591fefce4e3db51f&idx=2&mid=2458453236&scene=21&sn=daf00392f960c115463c5aaf980620b4#wechat_redirect)

![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy9keTlDWGVaTGxDWDRFaWF5a2liWVpQb1NJTTBCU3pMTXpzYnlGU3VsMjdrRGRYaFdGRHJjQUd6dWt5aWFsTkRnaExtaWNqdU9QRGlhVUdiM2RuMW85WjZkdzd3LzY0MA?x-oss-process=image/format,png)

回复“**加群**”与大佬们一起交流学习~

点击“**阅读原文**”查看70+篇原创文章

![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9tbWJpei5xcGljLmNuL21tYml6X3BuZy9keTlDWGVaTGxDWFZMUXBVcmliNkZQMnViTHY0eFFyM08xWWljN0UzNlNDR05aOTJJMlRJYm95NzlXS1dURWpJaWE0NVNiZmNKWjFLazdnOWpWUUsxYWtUUS82NDA?x-oss-process=image/format,png)

点这，与大家一起分享本文吧~