js async/await - 码农1213 - 博客园

#   [js async/await](https://www.cnblogs.com/bear-blogs/p/10423759.html)

**一、async**

带async关键字的函数，是声明异步函数，返回值是promise对象，如果async关键字函数返回的不是promise，会自动用Promise.resolve()包装。

async function test() { return  'test'}
test();
返回值为 Promise {<resolved>: "test"}。
**二、await**
await等待右侧表达式的结果，这个结果是promise对象或者其他值。
如果它等到的不是一个 promise 对象，那 await 表达式的运算结果就是它等到的东西。

如果它等到的是一个 promise 对象，await 就忙起来了，它会阻塞后面的代码，等着 promise 对象 resolve，然后得到 resolve 的值，作为 await 表达式的运算结果。

[![copycode.gif](js%20async_await%20-%20码农1213%20-%20博客园.md#)
function test() { return  new Promise(resolve => {
setTimeout(() => resolve("test"), 2000);
});
}const result = await test();
console.log(result);
console.log('end')
[![copycode.gif](js%20async_await%20-%20码农1213%20-%20博客园.md#)
由于test()造成的阻塞，console.log('end')会等到两秒后执行
所以为了避免造成阻塞，await 必须用在 async 函数中，async 函数调用不会造成阻塞。
[![copycode.gif](js%20async_await%20-%20码农1213%20-%20博客园.md#)
function test() { return  new Promise(resolve => {
setTimeout(() => resolve("test"), 2000);
});
}async function test2() { const result = await test();
console.log(result);
}
test2();
console.log('end');
[![copycode.gif](js%20async_await%20-%20码农1213%20-%20博客园.md#)
先执行console.log('end')，两秒后执行console.log('test')
如果await用在普通函数中，会报错，如下：
![1342059-20190220230218955-581865214.jpg](../_resources/9f10998f268a7ab36a7144c630fefb21.jpg)
**三、async/await的执行顺序**
遇到await会阻塞后面的代码，先执行async外面的同步代码，同步代码执行完，再回到async内部，继续执行await后面的代码。以下面的代码分析：
[![copycode.gif](js%20async_await%20-%20码农1213%20-%20博客园.md#)
 async function test1() {
console.log('start test1');
console.log(await test2());
console.log('end test1');
} async function test2() {
console.log('test2'); return await 'return test2 value' }
test1();
console.log('start async');
setTimeout(() => {
console.log('setTimeout');
}, 0); new Promise((resolve, reject) => {
console.log('promise1');
resolve();
}).then(() => {
console.log('promise2');
});
console.log('end async');
[![copycode.gif](js%20async_await%20-%20码农1213%20-%20博客园.md#)
执行的结果
![1342059-20190223175623763-1877681879.jpg](../_resources/bcf69cf105c7463af6eab7db0651b30d.jpg)
**·** 首先执行宏任务，执行test1函数，执行console.log('statr test1')
**·** 遇到await，先执行右边test2中的console.log('test2')，中断了后面的代码，执行test1外面的同步代码
**·** 执行console.log('start async');
**·** 遇到setTimeout，推到到下个宏任务队列中
**·** 执行Promise里面的同步代码console.log('promise1')
**·** 运行到promise().then，发现是promise对象，推到微任务队列中
**·** 执行console.log('end async')

**·** test1外面的同步代码执行结束后，回到test1中，console.log(await test2())执行完成后返回Promise {<resolved>: "return test2 value"}，是promise对象，推到微任务队列中

**·** 此时第一个宏任务结束，执行所有的微任务，因为微任务队列先进先出，所以先执行console.log('promise2')，后执行console.log('return test2 value')

**·** 执行test2完成后，后面的代码不再阻塞，执行console.log('end test1');
**·** 执行下个宏任务，即执行console.log('setTimeout');
补充下有关宏任务和微任务的知识

宏任务和微任务都是队列，宏任务有script、setTimeout、setInterval等，微任务有Promise.then catch finally、process.nextTick等，宏任务和微任务的关系如下：

![1342059-20190223175144031-1985250723.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108145557.jpg)
先执行第一个宏任务，执行结束后，执行所有的微任务，然后执行下个宏任务。
**四、async/await的优缺点**
1. 优点
相对于promise，async/await处理 then 的调用链，代码要清晰很多，几乎和同步代码一样
2. 缺点
滥用 await 可能会导致性能问题，因为 await 会阻塞代码
**五、处理reject**
1. try/catch
[![copycode.gif](js%20async_await%20-%20码农1213%20-%20博客园.md#)
 async function fn() { try { await  new Promise((resolve, reject) => {
setTimeout(() => {
reject('err3');
}, 1000);
})
} catch (err){
alert(err)
}
}
fn()
[![copycode.gif](js%20async_await%20-%20码农1213%20-%20博客园.md#)
2. catch
[![copycode.gif](js%20async_await%20-%20码农1213%20-%20博客园.md#)
 async function fn() { await  new Promise((resolve, reject) => {
setTimeout(() => {
reject('err');
}, 1000);
})
}
fn().catch(alert)
[![copycode.gif](js%20async_await%20-%20码农1213%20-%20博客园.md#)

参考：
1. https://segmentfault.com/a/1190000007535316
2. https://segmentfault.com/a/1190000017224799
3. https://www.cnblogs.com/wangziye/p/9566454.html

分类: [js](https://www.cnblogs.com/bear-blogs/category/1382052.html)

 [好文要顶](js%20async_await%20-%20码农1213%20-%20博客园.md#)  [关注我](js%20async_await%20-%20码农1213%20-%20博客园.md#)  [收藏该文](js%20async_await%20-%20码农1213%20-%20博客园.md#)  [![icon_weibo_24.png](js%20async_await%20-%20码农1213%20-%20博客园.md#)  [![wechat.png](js%20async_await%20-%20码农1213%20-%20博客园.md#)

 [![20180304221921.png](../_resources/9285fd95d41681c6e7586a8256ce4570.jpg)](https://home.cnblogs.com/u/bear-blogs/)

 [码农1213](https://home.cnblogs.com/u/bear-blogs/)
 [关注 - 0](https://home.cnblogs.com/u/bear-blogs/followees/)
 [粉丝 - 2](https://home.cnblogs.com/u/bear-blogs/followers/)

 [+加关注](js%20async_await%20-%20码农1213%20-%20博客园.md#)

 0

 0

 [«](https://www.cnblogs.com/bear-blogs/p/10389840.html) 上一篇： [css Flex布局](https://www.cnblogs.com/bear-blogs/p/10389840.html)

 [»](https://www.cnblogs.com/bear-blogs/p/10448095.html) 下一篇： [读《JavaScript权威指南》笔记（二）](https://www.cnblogs.com/bear-blogs/p/10448095.html)

posted @ 2019-02-23 18:42 [码农1213](https://www.cnblogs.com/bear-blogs/)  阅读(14136)  评论(3) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=10423759) [收藏](js%20async_await%20-%20码农1213%20-%20博客园.md#)