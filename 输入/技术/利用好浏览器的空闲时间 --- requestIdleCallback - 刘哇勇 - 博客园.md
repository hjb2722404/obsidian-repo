_字数：682，预计阅读时间：3min_

### 页面流畅与 FPS

页面是一帧一帧绘制出来的，当每秒绘制的帧数（FPS）达到 60 时，页面是流畅的，小于这个值时，用户会感觉到卡顿。

1s 60帧，所以每一帧分到的时间是 1000/60 ≈ 16 ms。所以我们书写代码时力求不让一帧的工作量超过 16ms。

### Frame

那么浏览器每一帧都需要完成哪些工作？

[![](https://user-images.githubusercontent.com/3783096/51423451-4a5f1f80-1bfb-11e9-8c0a-597f0d52f4c0.png)
](https://user-images.githubusercontent.com/3783096/51423451-4a5f1f80-1bfb-11e9-8c0a-597f0d52f4c0.png)  
_浏览器一帧内的工作_

通过上图可看到，一帧内需要完成如下六个步骤的任务：

*   处理用户的交互
*   JS 解析执行
*   帧开始。窗口尺寸变更，页面滚去等的处理
*   rAF
*   布局
*   绘制

### requestIdleCallback

上面六个步骤完成后没超过 16 ms，说明时间有富余，此时就会执行 `requestIdleCallback` 里注册的任务。

[![](https://user-images.githubusercontent.com/3783096/51231779-9b72d780-199f-11e9-8e65-eb9df90921ce.png)
](https://user-images.githubusercontent.com/3783096/51231779-9b72d780-199f-11e9-8e65-eb9df90921ce.png)  
_`requestIdleCallback` 在浏览器一帧内的位置示意_

从上图也可看出，和 `requestAnimationFrame` 每一帧必定会执行不同，`requestIdleCallback` 是捡浏览器空闲来执行任务。

如此一来，假如浏览器一直处于非常忙碌的状态，`requestIdleCallback` 注册的任务有可能永远不会执行。此时可通过设置 `timeout` （见下面 API 介绍）来保证执行。

#### API

```js
var handle = window.requestIdleCallback(callback[, options])
```

*   `callback: ()`：回调即空闲时需要执行的任务，接收一个 [`IdleDeadline`](https://developer.mozilla.org/en-US/docs/Web/API/IdleDeadline) 对象作为入参。其中 `IdleDeadline` 对象包含：
    *   `didTimeout`，布尔值，表示任务是否超时，结合 `timeRemaining` 使用。
    *   `timeRemaining()`，表示当前帧剩余的时间，也可理解为留给任务的时间还有多少。
*   `options`：目前 options 只有一个参数
    *   `timeout` 。表示超过这个时间后，如果任务还没执行，则强制执行，不必等待空闲。

#### 示例

```js
requestIdleCallback(myNonEssentialWork, { timeout: 2000 });
function myNonEssentialWork (deadline) {
  // 如果帧内有富余的时间，或者超时
  while ((deadline.timeRemaining() > 0 || deadline.didTimeout) &&
         tasks.length > 0)
    doWorkIfNeeded();
  if (tasks.length > 0)
    requestIdleCallback(myNonEssentialWork);
}
```

超时的情况，其实就是浏览器很忙，没有空闲时间，此时会等待指定的 `timeout` 那么久再执行，通过入参 `dealine` 拿到的 `didTmieout` 会为 `true`，同时 `timeRemaining ()` 返回的也是 0。超时的情况下如果选择继续执行的话，肯定会出现卡顿的，因为必然会将一帧的时间拉长。

#### cancelIdleCallback

与 `setTimeout` 类似，返回一个唯一 id，可通过 `cancelIdleCallback` 来取消任务。

### 总结

一些低优先级的任务可使用 `requestIdleCallback` 等浏览器不忙的时候来执行，同时因为时间有限，它所执行的任务应该尽量是能够量化，细分的微任务（micro task）。

因为它发生在一帧的最后，此时页面布局已经完成，所以不建议在 `requestIdleCallback` 里再操作 DOM，这样会导致页面再次重绘。DOM 操作建议在 rAF 中进行。同时，操作 DOM 所需要的耗时是不确定的，因为会导致重新计算布局和视图的绘制，所以这类操作不具备可预测性。

Promise 也不建议在这里面进行，因为 Promise 的回调属性 Event loop 中优先级较高的一种微任务，会在 `requestIdleCallback` 结束时立即执行，不管此时是否还有富余的时间，这样有很大可能会让一帧超过 16 ms。

### 参考

*   [requestAnimationFrame Scheduling For Nerds](https://medium.com/@paul_irish/requestanimationframe-scheduling-for-nerds-9c57f7438ef4)
*   [Rendering Performance](https://developers.google.com/web/fundamentals/performance/rendering/)
*   [你应该知道的requestIdleCallback](https://juejin.im/post/5ad71f39f265da239f07e862)
*   [MDN window.requestIdleCallback()](https://developer.mozilla.org/en-US/docs/Web/API/Window/requestIdleCallback)
*   [Using requestIdleCallback](https://developers.google.com/web/updates/2015/08/using-requestidlecallback)

![](https://licensebuttons.net/l/by-nc-sa/3.0/88x31.png)
 **CC BY-NC-SA 署名-非商业性使用-相同方式共享**

posted @ 2019-03-27 23:20  [刘哇勇](https://www.cnblogs.com/Wayou/)  阅读(2806)  评论()  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=10611995)  收藏