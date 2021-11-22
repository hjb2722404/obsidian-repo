微任务、宏任务、同步、异步、Promise、Async、await - 鬼小妞 - 博客园

- [1. 事件轮询（Event Loop）](https://www.cnblogs.com/jiangyuzhen/p/11064408.html#1_Event_Loop_16)
    - [js实现异步的具体解决方案](https://www.cnblogs.com/jiangyuzhen/p/11064408.html#js_28)
    - [什么叫轮询？](https://www.cnblogs.com/jiangyuzhen/p/11064408.html#_34)
- [2. 宏任务和微任务](https://www.cnblogs.com/jiangyuzhen/p/11064408.html#2__44)
    - [概念](https://www.cnblogs.com/jiangyuzhen/p/11064408.html#_46)
    - [宏任务](https://www.cnblogs.com/jiangyuzhen/p/11064408.html#_96)
    - [微任务](https://www.cnblogs.com/jiangyuzhen/p/11064408.html#_125)
    - [例题](https://www.cnblogs.com/jiangyuzhen/p/11064408.html#_149)
        - [EXP1: 在主线程上添加宏任务与微任务](https://www.cnblogs.com/jiangyuzhen/p/11064408.html#EXP1__151)
        - [EXP2: 在微任务中创建微任务](https://www.cnblogs.com/jiangyuzhen/p/11064408.html#EXP2__189)
        - [EXP3: 宏任务中创建微任务](https://www.cnblogs.com/jiangyuzhen/p/11064408.html#EXP3__226)
        - [EXP4：微任务队列中创建的宏任务](https://www.cnblogs.com/jiangyuzhen/p/11064408.html#EXP4_267)
    - [总结](https://www.cnblogs.com/jiangyuzhen/p/11064408.html#_304)

> 这篇博文仅为个人理解，文章内提供一些更加权威的参考，如有片面及错误，欢迎指正

# 1. 事件轮询（Event Loop）

[什么是 Event Loop？ - 阮一峰](http://www.ruanyifeng.com/blog/2013/10/event_loop.html)

[事件轮询（Event Loop） - 《你不懂JS：异步与性能》](https://www.bookstack.cn/read/You-Dont-Know-JS-async-performance/ch1.2.md)

[【推荐】详解JavaScript中的Event Loop（事件循环）机制](https://zhuanlan.zhihu.com/p/33058983)

Javascript的宿主环境中共通的一个“线程”（一个“不那么微妙”的异步玩笑，不管怎样）是，他们都有一种机制：在每次调用JS引擎时，可以*随着时间的推移*执行你的程序的多个代码块儿，这称为“事件轮询（Event Loop）”。

换句话说，JS引擎对 时间 没有天生的感觉，反而是一个任意JS代码段的按需执行环境。是它周围的环境在不停地安排“事件”（JS代码的执行）。

## js实现异步的具体解决方案

- 同步代码直接执行
- 异步函数到了指定时间再放到异步队列
- 同步执行完毕，异步队列轮询执行。

## 什么叫轮询？

精简版：当第一个异步函数执行完之后，再到异步队列监视。一直不断循环往复，所以叫事件轮询。

详细版：js引擎遇到一个异步事件后并不会一直等待其返回结果，而是会将这个事件挂起，继续执行执行栈中的其他任务。当一个异步事件返回结果后，js会将这个事件加入与当前执行栈不同的另一个队列，我们称之为事件队列。被放入事件队列不会立刻执行其回调，而是等待当前执行栈中的所有任务都执行完毕， 主线程处于闲置状态时，主线程会去查找事件队列是否有任务。如果有，那么主线程会从中取出排在第一位的事件，并把这个事件对应的回调放入执行栈中，然后执行其中的同步代码…，如此反复，这样就形成了一个无限的循环。这就是这个过程被称为“事件循环（Event Loop）”的原因。

事实上，事件轮询与宏任务和微任务密切相关。

# 2. 宏任务和微任务

## 概念

[微任务、宏任务与Event-Loop](https://juejin.im/post/5b73d7a6518825610072b42b#heading-3)

在一个事件循环中，异步事件返回结果后会被放到一个任务队列中。然而，根据这个异步事件的类型，这个事件实际上会被对应的宏任务队列或者微任务队列中去。并且在当前执行栈为空的时候，主线程会 查看微任务队列是否有事件存在。如果不存在，那么再去宏任务队列中取出一个事件并把对应的回到加入当前执行栈；如果存在，则会依次执行队列中事件对应的回调，直到微任务队列为空，然后去宏任务队列中取出最前面的一个事件，把对应的回调加入当前执行栈…如此反复，进入循环。

我们只需记住当当前执行栈执行完毕时会立刻先处理所有微任务队列中的事件，然后再去宏任务队列中取出一个事件。同一次事件循环中，微任务永远在宏任务之前执行。
在当前的微任务没有执行完成时，是不会执行下一个宏任务的。
所以就有了那个经常在面试题、各种博客中的代码片段：

	setTimeout(_ => console.log(4))
	
	new Promise(resolve => {
	  resolve()
	  console.log(1)
	}).then(_ => {
	  console.log(3)
	})
	
	console.log(2)

setTimeout就是作为宏任务来存在的，而Promise.then则是具有代表性的微任务，上述代码的执行顺序就是按照序号来输出的。
所有会进入的异步都是指的事件回调中的那部分代码
也就是说new Promise在实例化的过程中所执行的代码都是同步进行的，而then中注册的回调才是异步执行的。
在同步代码执行完成后才回去检查是否有异步任务完成，并执行对应的回调，而微任务又会在宏任务之前执行。
所以就得到了上述的输出结论1、2、3、4。
+部分表示同步执行的代码

	+setTimeout(_ => {
	
	- console.log(4)
	
	+})
	
	+new Promise(resolve => {
	+  resolve()
	+  console.log(1)
	+}).then(_ => {
	
	- console.log(3)
	
	+})
	
	+console.l

本来setTimeout已经先设置了定时器（相当于取号），然后在当前进程中又添加了一些Promise的处理（临时添加业务）。
所以进阶的，即便我们继续在Promise中实例化Promise，其输出依然会早于setTimeout的宏任务：如EXP2

## 宏任务

分类：

| #   | 浏览器 | Node |
| --- | --- | --- |
| I/O | ✅   | ✅   |
| setTimeout | ✅   | ✅   |
| setInterval | ✅   | ✅   |
| setImmediate | ❌   | ✅   |
| requestAnimationFrame | ✅   | ❌   |

特性：
1. 宏任务所处的队列就是宏任务队列
2. 第一个宏任务队列中只有一个任务：执行主线程上的JS代码；如果遇到上方表格中的异步任务，会创建出一个新的宏任务队列，存放这些异步函数执行完成后的回调函数。
3. 宏任务队列可以有多个
4. 宏任务中可以创建微任务，但是在宏任务中创建的微任务不会影响当前宏任务的执行。(EXP3)
5. 当一个宏任务队列中的任务全部执行完后，会查看是否有微任务队列，如果有就会优先执行微任务队列中的所有任务，如果没有就查看是否有宏任务队列

## 微任务

分类：

| #   | 浏览器 | Node |
| --- | --- | --- |
| process.nextTick | ❌   | ✅   |
| MutationObserver | ✅   | ❌   |
| Promise.then catch finally | ✅   | ✅   |

特性：
1. 微任务所处的队列就是微任务队列
2. 在上一个宏任务队列执行完毕后，如果有微任务队列就会执行微任务队列中的所有任务
3. new promise((resolve)=>{ 这里的函数在当前队列直接执行 }).then( 这里的函数放在微任务队列中执行 )
4. 微任务队列上创建的微任务，仍会阻碍后方将要执行的宏任务队列 (EXP2)
5. 由微任务创建的宏任务，会被丢在异步宏任务队列中执行 (EXP4)

## 例题

### EXP1: 在主线程上添加宏任务与微任务

执行顺序：主线程 => 主线程上创建的微任务 => 主线程上创建的宏任务

	console.log('-------start--------');
	
	setTimeout(() => {
	  console.log('setTimeout');  // 将回调代码放入另一个宏任务队列
	}, 0);
	
	new Promise((resolve, reject) => {
	  for (let i = 0; i < 5; i++) {
	    console.log(i);
	  }
	  resolve()
	}).then(()=>{
	  console.log('Promise实例成功回调执行'); // 将回调代码放入微任务队列
	})
	
	console.log('-------e[[NEWLINE]]

结果：

	-------start--------
	0
	1
	2
	3
	4
	-------end--------
	Promise实例成功回调执行
	setTimeout

由EXP1，我们可以看出，当JS执行完主线程上的代码，会去检查在主线程上创建的微任务队列，执行完微任务队列之后才会执行宏任务队列上的代码

### EXP2: 在微任务中创建微任务

执行顺序：主线程 => 主线程上创建的微任务1 => 微任务1上创建的微任务2 => 主线程上创建的宏任务

	setTimeout(_ => console.log(4))
	
	new Promise(resolve => {
	  resolve()
	  console.log(1)
	}).then(_ => {
	  console.log(3)
	  Promise.resolve().then(_ => {
	    console.log('before timeout')
	  }).then(_ => {
	    Promise.resolve().then(_ => {
	      console.log('also before timeout')
	    })
	  })
	})
	
	console.log(2)

结果：

	1
	2
	3
	before timeout
	also before timeout
	4

由EXP1，我们可以看出，在微任务队列执行时创建的微任务，还是会排在主线程上创建出的宏任务之前执行

### EXP3: 宏任务中创建微任务

执行顺序：主线程 => 主线程上的宏任务队列1 => 宏任务队列1中创建的微任务

	// 宏任务队列 1
	setTimeout(() => {
	  // 宏任务队列 2.1
	  console.log('timer_1');
	  setTimeout(() => {
	    // 宏任务队列 3
	    console.log('timer_3')
	  }, 0)
	  new Promise(resolve => {
	    resolve()
	    console.log('new promise')
	  }).then(() => {
	    // 微任务队列 1
	    console.log('promise then')
	  })
	}, 0)
	
	setTimeout(() => {
	  // 宏任务队列 2.2
	  console.log('timer_2')
	}, 0)
	
	console.log('========== Sync queue ==========')
	
	// 执行顺序：主线程（宏任务队列 1）=> 宏任务队列 2 => 微任务队列 1 => 宏任务队列 3

结果：

	========== Sync queue ==========
	timer_1
	new promise
	promise then[[NEWLINE]]timer_2
	timer_3

### EXP4：微任务队列中创建的宏任务

执行顺序：主线程 => 主线程上创建的微任务 => 主线程上创建的宏任务 => 微任务中创建的宏任务
异步宏任务队列只有一个，当在微任务中创建一个宏任务之后，他会被追加到异步宏任务队列上（跟主线程创建的异步宏任务队列是同一个队列）

	// 宏任务1
	new Promise((resolve) => {
	  console.log('new Promise(macro task 1)');
	  resolve();
	}).then(() => {
	  // 微任务1
	  console.log('micro task 1');
	  setTimeout(() => {
	    // 宏任务3
	    console.log('macro task 3');
	  }, 0)
	})
	
	setTimeout(() => {
	  // 宏任务2
	  console.log('macro task 2');
	}, 1000)
	
	console.log('========== Sync queue(macro task 1) ==========');

结果：

	========== Sync queue(macro task 1) ==========
	micro task 1
	macro task 3
	macro task 2[[NEWLINE]][[NEWLINE]]记住，如果把[[NEWLINE]]setTimeout(() => { // 宏任务2 console.log('macro task 2'); }, 1000)改为立即执行setTimeout(() => { // 宏任务2 console.log('macro task 2'); }, 0)[[NEWLINE]]那么它会在macro task 3之前执行，因为定时器是过多少毫秒之后才会加到事件队列里

##

## 总结

微任务队列优先于宏任务队列执行，微任务队列上创建的宏任务会被后添加到当前宏任务队列的尾端，微任务队列中创建的微任务会被添加到微任务队列的尾端。只要微任务队列中还有任务，宏任务队列就只会等待微任务队列执行完毕后再执行。

最后上一张几乎涵盖基本情况的例图和例子
![](https://ws1.sinaimg.cn/large/a71efaafly1g232hxfbhrj21350h9406.jpg)

	console.log('======== main task start ========');
	new Promise(resolve => {
	  console.log('create micro task 1');
	  resolve();
	}).then(() => {
	  console.log('micro task 1 callback');
	  setTimeout(() => {
	    console.log('macro task 3 callback');
	  }, 0);
	})
	
	console.log('create macro task 2');
	setTimeout(() => {
	  console.log('macro task 2 callback');
	  new Promise(resolve => {
	    console.log('create micro task 3');
	    resolve();
	  }).then(() => {
	    console.log('micro task 3 callback');
	  })
	  console.log('create macro task 4');
	  setTimeout(() => {
	    console.log('macro task 4 callback');
	  }, 0);
	}, 0);
	
	new Promise(resolve => {
	  console.log('create micro task 2');
	  resolve();
	}).then(() => {
	  console.log('micro task 2 callback');
	})
	
	console.log('======== main task end ========');

结果：
``
======== main task start ========
create micro task 1
create macro task 2
create micro task 2
======== main task end ========
micro task 1 callback
micro task 2 callback
macro task 2 callback
create micro task 3
create macro task 4
micro task 3 callback
macro task 3 callback
macro task 4 callback

> 一旦遇到await 就立刻让出线程,阻塞后面的代码
> 等候之后,对于await来说分两种情况

- > 不是promise 对象
- > 是promise对象

**> 如果不是promise,await会阻塞后面的代码,先执行async外面的同步代码,同步代码执行完毕后,在回到async内部,把promise的东西,作为await表达式的结果**

**> 如果它等到的是一个 promise 对象，await 也会暂停async后面的代码，先执行async外面的同步代码，等着 Promise 对象 fulfilled，然后把 resolve 的参数作为 await 表达式的运算结果。**

**> 如果一个 Promise 被传递给一个 await 操作符，await 将等待 Promise 正常处理完成并返回其处理结果。**

**> 具体参考> [https://www.cnblogs.com/fangdongdemao/p/10262209.html> ，但博客里的代码运行结果需要重新试一下**

第三题

	async function async1() {
	    console.log( 'async1 start' )
	    await async2()
	    console.log( 'async1 end' )
	}
	async function async2() {
	    console.log( 'async2' )
	}
	async1()
	console.log( 'script start' )
	
	执行结果

async1 start
async2
script start
async1 end

第四题

	        async function async1() {
	            console.log( 'async1 start' )
	            await async2()
	            console.log( 'async1 end' )
	        }
	        async function async2() {
	            console.log( 'async2' )
	        }
	        console.log( 'script start' )
	        setTimeout( function () {
	            console.log( 'setTimeout' )
	        }, 0 )
	        async1();
	        new Promise( function ( resolve ) {
	            console.log( 'promise1' )
	            resolve();
	        } ).then( function () {
	            console.log( 'promise2' )
	        } )
	        console.log( 'script end' )[[NEWLINE]]

**如果一个 Promise 被传递给一个 await 操作符，await 将等待 Promise 正常处理完成并返回其处理结果。**
打印结果为
script start
async1 start
async2
promise1
script end
async1 end
promise2
setTimeout

仔细看此例子：，区分await后执行promise和非promise的区别，
[![copycode.gif](微任务、宏任务、同步、异步、Promise、Async、await%20-%20鬼小妞%20-%20博客园%20(1).md#)
async function t1 () {
console.log(1)
console.log(2)new Promise( function ( resolve ) {
console.log( 'promise3' )
resolve();
} ).then( function () {
console.log( 'promise4' )
} )
await new Promise( function ( resolve ) {
console.log( 'b' )
resolve();
} ).then( function () {
console.log( 't1p' )
} )
console.log(3)
console.log(4)new Promise( function ( resolve ) {
console.log( 'promise5' )
resolve();
} ).then( function () {
console.log( 'promise6' )
} )
}
setTimeout( function () {
console.log( 'setTimeout' )
}, 0 )
async function t2() {
console.log(5)
console.log(6)
await Promise.resolve().then(() => console.log('t2p'))
console.log(7)
console.log(8)
}
t1()new Promise( function ( resolve ) {
console.log( 'promise1' )
resolve();
} ).then( function () {
console.log( 'promise2' )
} )
t2()
console.log('end');
[![copycode.gif](微任务、宏任务、同步、异步、Promise、Async、await%20-%20鬼小妞%20-%20博客园%20(1).md#)

控制台输出结果：
![1040528-20190622143005461-1238319419.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/44bac00ff0a3337eecf8474e306230da.png)

记住，await之后的代码必须等await语句执行完成后（包括微任务完成），才能执行后面的，也就是说，**只有运行完await语句，才把await语句后面的全部代码加入到微任务行列**，所以，在遇到await promise时，必须等await promise函数执行完毕才能对await语句后面的全部代码加入到微任务中，所以，

在等待await Promise.then微任务时，
1.运行其他同步代码，
2.等到同步代码运行完，开始运行await promise.then微任务，
3.await promise.then微任务完成后，把await语句后面的全部代码加入到微任务行列，
4.根据微任务队列，先进后出执行微任务

await 语句是同步的，await语句后面全部代码才是异步的微任务，
![1040528-20190622144653266-1461049333.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/3019f88d7ca19de04e7b60e6695c3976.png)
所以：
![1040528-20190622145500862-2049545975.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/78826903d27a54da458bfb05c300375f.png)