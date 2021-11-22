Promise详解与实现（Promise/A+规范）

# Promise详解与实现（Promise/A+规范）

[[webp](../_resources/f30b16d2553f9bc4cb9c417e98ed091b.webp)](https://www.jianshu.com/u/b6e4a21c5ab1)

[Brolly](https://www.jianshu.com/u/b6e4a21c5ab1)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='274'%3e%3cpath d='M751.144277 307.2l-123.016533-238.933333h159.778133a81.92 81.92 0 0 1 59.1872 25.258666l160.256 167.492267A27.306667 27.306667 0 0 1 987.620011 307.2h-236.475734z m270.506667 111.547733L640.927744 946.039467a27.306667 27.306667 0 0 1-48.128-24.234667L766.504277 375.466667h-56.388266l-170.5984 590.165333a27.306667 27.306667 0 0 1-52.462934 0.034133L315.500544 375.466667H259.112277l174.523734 545.5872a27.306667 27.306667 0 0 1-48.128 24.302933L5.160277 418.747733A27.306667 27.306667 0 0 1 27.346944 375.466667H999.464277a27.306667 27.306667 0 0 1 22.152534 43.281066zM18.301611 261.0176L178.557611 93.525333A81.92 81.92 0 0 1 237.744811 68.266667h159.744L274.506411 307.2H38.030677a27.306667 27.306667 0 0 1-19.729066-46.1824zM453.877077 68.266667h117.896534l122.9824 238.933333H330.894677l122.9824-238.933333z' data-evernote-id='157' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*12018.01.13 20:13:33字数 804阅读 17,699

### 1.什么是Promise?

> Promise是JS异步编程中的重要概念，异步抽象处理对象，是目前比较流行Javascript异步编程解决方案之一

### 2.对于几种常见异步编程方案

- 回调函数
- 事件监听
- 发布/订阅
- Promise对象

#### 这里就拿回调函数说说

1.对于回调函数 我们用Jquery的ajax获取数据时 都是以回调函数方式获取的数据

	$.get(url, (data) => {
	    console.log(data)
	)
	123

2.如果说 当我们需要发送多个异步请求 并且每个请求之间需要相互依赖 那这时 我们只能 以嵌套方式来解决 形成 "回调地狱"

	$.get(url, data1 => {
	    console.log(data1)
	    $.get(data1.url, data2 => {
	        console.log(data1)
	    })
	})
	123456

> 这样一来，在处理越多的异步逻辑时，就需要越深的回调嵌套，这种编码模式的问题主要有以下几个：

- 代码逻辑书写顺序与执行顺序不一致，不利于阅读与维护。
- 异步操作的顺序变更时，需要大规模的代码重构。
- 回调函数基本都是匿名函数，bug 追踪困难。
- 回调函数是被第三方库代码（如上例中的 ajax ）而非自己的业务代码所调用的，造成了 IoC 控制反转。

#### Promise 处理多个相互关联的异步请求

1.而我们Promise 可以更直观的方式 来解决 "回调地狱"

	const request = url => {
	    return new Promise((resolve, reject) => {
	        $.get(url, data => {
	            resolve(data)
	        });
	    })
	};

	// 请求data1
	request(url).then(data1 => {
	    return request(data1.url);
	}).then(data2 => {
	    return request(data2.url);
	}).then(data3 => {
	    console.log(data3);
	}).catch(err => throw new Error(err));
	12345678910111213141516

2.相信大家在 vue/react 都是用axios fetch 请求数据 也都支持 Promise API

	import axios from 'axios';
	axios.get(url).then(data => {
	   console.log(data)
	})
	1234

> Axios 是一个基于 promise 的 HTTP 库，可以用在浏览器和 node.js 中。

### 3.Promise使用

#### 1.Promise 是一个构造函数， new Promise 返回一个 promise对象 接收一个excutor执行函数作为参数, excutor有两个函数类型形参resolve reject

	const promise = new Promise((resolve, reject) => {
	       // 异步处理
	       // 处理结束后、调用resolve 或 reject
	});

	12345

#### 2.promise相当于一个状态机

promise的三种状态

- pending
- fulfilled
- rejected

1.promise 对象初始化状态为 pending
2.当调用resolve(成功)，会由pending => fulfilled
3.当调用reject(失败)，会由pending => rejected
> 注意promsie状态 只能由 pending => fulfilled/rejected, 一旦修改就不能再变

#### 3.promise对象方法

1.then方法注册 当resolve(成功)/reject(失败)的回调函数

	// onFulfilled 是用来接收promise成功的值
	// onRejected 是用来接收promise失败的原因
	promise.then(onFulfilled, onRejected);
	123

> then方法是异步执行的
2.resolve(成功) onFulfilled会被调用

	const promise = new Promise((resolve, reject) => {
	   resolve('fulfilled'); // 状态由 pending => fulfilled
	});
	promise.then(result => { // onFulfilled
	    console.log(result); // 'fulfilled'
	}, reason => { // onRejected 不会被调用

	})
	12345678

3.reject(失败) onRejected会被调用

	const promise = new Promise((resolve, reject) => {
	   reject('rejected'); // 状态由 pending => rejected
	});
	promise.then(result => { // onFulfilled 不会被调用

	}, reason => { // onRejected
	    console.log(rejected); // 'rejected'
	})
	12345678

4.promise.catch
> 在链式写法中可以捕获前面then中发送的异常,

	promise.catch(onRejected)
	相当于
	promise.then(null, onRrejected);

	// 注意
	// onRejected 不能捕获当前onFulfilled中的异常
	promise.then(onFulfilled, onRrejected);

	// 可以写成：
	promise.then(onFulfilled)
	       .catch(onRrejected);
	1234567891011

#### 4.promise chain

> promise.then方法每次调用 都返回一个新的promise对象 所以可以链式写法

	function taskA() {
	    console.log("Task A");
	}
	function taskB() {
	    console.log("Task B");
	}
	function onRejected(error) {
	    console.log("Catch Error: A or B", error);
	}

	var promise = Promise.resolve();
	promise
	    .then(taskA)
	    .then(taskB)
	    .catch(onRejected) // 捕获前面then方法中的异常
	123456789101112131415

#### 5.Promise的静态方法

1.Promise.resolve 返回一个fulfilled状态的promise对象

	Promise.resolve('hello').then(function(value){
	    console.log(value);
	});

	Promise.resolve('hello');
	// 相当于
	const promise = new Promise(resolve => {
	   resolve('hello');
	});
	123456789

2.Promise.reject 返回一个rejected状态的promise对象

	Promise.reject(24);
	new Promise((resolve, reject) => {
	   reject(24);
	});
	1234

3.Promise.all 接收一个promise对象数组为参数
> 只有全部为resolve才会调用 通常会用来处理 多个并行异步操作

	const p1 = new Promise((resolve, reject) => {
	    resolve(1);
	});

	const p2 = new Promise((resolve, reject) => {
	    resolve(2);
	});

	const p3 = new Promise((resolve, reject) => {
	    reject(3);
	});

	Promise.all([p1, p2, p3]).then(data => {
	    console.log(data); // [1, 2, 3] 结果顺序和promise实例数组顺序是一致的
	}, err => {
	    console.log(err);
	});
	1234567891011121314151617

4.Promise.race 接收一个promise对象数组为参数
> Promise.race 只要有一个promise对象进入 FulFilled 或者 Rejected 状态的话，就会继续进行后面的处理。

	function timerPromisefy(delay) {
	    return new Promise(function (resolve, reject) {
	        setTimeout(function () {
	            resolve(delay);
	        }, delay);
	    });
	}
	var startDate = Date.now();

	Promise.race([
	    timerPromisefy(10),
	    timerPromisefy(20),
	    timerPromisefy(30)
	]).then(function (values) {
	    console.log(values); // 10
	});
	12345678910111213141516

### 4. Promise 代码实现

	/**
	 * Promise 实现 遵循promise/A+规范
	 * Promise/A+规范译文:
	 * https://malcolmyu.github.io/2015/06/12/Promises-A-Plus/#note-4
	 */

	// promise 三个状态
	const PENDING = "pending";
	const FULFILLED = "fulfilled";
	const REJECTED = "rejected";

	function Promise(excutor) {
	    let that = this; // 缓存当前promise实例对象
	    that.status = PENDING; // 初始状态
	    that.value = undefined; // fulfilled状态时 返回的信息
	    that.reason = undefined; // rejected状态时 拒绝的原因
	    that.onFulfilledCallbacks = []; // 存储fulfilled状态对应的onFulfilled函数
	    that.onRejectedCallbacks = []; // 存储rejected状态对应的onRejected函数

	    function resolve(value) { // value成功态时接收的终值
	        if(value instanceof Promise) {
	            return value.then(resolve, reject);
	        }

	        // 为什么resolve 加setTimeout?
	        // 2.2.4规范 onFulfilled 和 onRejected 只允许在 execution context 栈仅包含平台代码时运行.
	        // 注1 这里的平台代码指的是引擎、环境以及 promise 的实施代码。实践中要确保 onFulfilled 和 onRejected 方法异步执行，且应该在 then 方法被调用的那一轮事件循环之后的新执行栈中执行。

	        setTimeout(() => {
	            // 调用resolve 回调对应onFulfilled函数
	            if (that.status === PENDING) {
	                // 只能由pedning状态 => fulfilled状态 (避免调用多次resolve reject)
	                that.status = FULFILLED;
	                that.value = value;
	                that.onFulfilledCallbacks.forEach(cb => cb(that.value));
	            }
	        });
	    }

	    function reject(reason) { // reason失败态时接收的拒因
	        setTimeout(() => {
	            // 调用reject 回调对应onRejected函数
	            if (that.status === PENDING) {
	                // 只能由pedning状态 => rejected状态 (避免调用多次resolve reject)
	                that.status = REJECTED;
	                that.reason = reason;
	                that.onRejectedCallbacks.forEach(cb => cb(that.reason));
	            }
	        });
	    }

	    // 捕获在excutor执行器中抛出的异常
	    // new Promise((resolve, reject) => {
	    //     throw new Error('error in excutor')
	    // })
	    try {
	        excutor(resolve, reject);
	    } catch (e) {
	        reject(e);
	    }
	}

	/**
	 * resolve中的值几种情况：
	 * 1.普通值
	 * 2.promise对象
	 * 3.thenable对象/函数
	 */

	/**
	 * 对resolve 进行改造增强 针对resolve中不同值情况 进行处理
	 * @param  {promise} promise2 promise1.then方法返回的新的promise对象
	 * @param  {[type]} x         promise1中onFulfilled的返回值
	 * @param  {[type]} resolve   promise2的resolve方法
	 * @param  {[type]} reject    promise2的reject方法
	 */
	function resolvePromise(promise2, x, resolve, reject) {
	    if (promise2 === x) {  // 如果从onFulfilled中返回的x 就是promise2 就会导致循环引用报错
	        return reject(new TypeError('循环引用'));
	    }

	    let called = false; // 避免多次调用
	    // 如果x是一个promise对象 （该判断和下面 判断是不是thenable对象重复 所以可有可无）
	    if (x instanceof Promise) { // 获得它的终值 继续resolve
	        if (x.status === PENDING) { // 如果为等待态需等待直至 x 被执行或拒绝 并解析y值
	            x.then(y => {
	                resolvePromise(promise2, y, resolve, reject);
	            }, reason => {
	                reject(reason);
	            });
	        } else { // 如果 x 已经处于执行态/拒绝态(值已经被解析为普通值)，用相同的值执行传递下去 promise
	            x.then(resolve, reject);
	        }
	        // 如果 x 为对象或者函数
	    } else if (x != null && ((typeof x === 'object') || (typeof x === 'function'))) {
	        try { // 是否是thenable对象（具有then方法的对象/函数）
	            let then = x.then;
	            if (typeof then === 'function') {
	                then.call(x, y => {
	                    if(called) return;
	                    called = true;
	                    resolvePromise(promise2, y, resolve, reject);
	                }, reason => {
	                    if(called) return;
	                    called = true;
	                    reject(reason);
	                })
	            } else { // 说明是一个普通对象/函数
	                resolve(x);
	            }
	        } catch(e) {
	            if(called) return;
	            called = true;
	            reject(e);
	        }
	    } else {
	        resolve(x);
	    }
	}

	/**
	 * [注册fulfilled状态/rejected状态对应的回调函数]
	 * @param  {function} onFulfilled fulfilled状态时 执行的函数
	 * @param  {function} onRejected  rejected状态时 执行的函数
	 * @return {function} newPromsie  返回一个新的promise对象
	 */
	Promise.prototype.then = function(onFulfilled, onRejected) {
	    const that = this;
	    let newPromise;
	    // 处理参数默认值 保证参数后续能够继续执行
	    onFulfilled =
	        typeof onFulfilled === "function" ? onFulfilled : value => value;
	    onRejected =
	        typeof onRejected === "function" ? onRejected : reason => {
	            throw reason;
	        };

	    // then里面的FULFILLED/REJECTED状态时 为什么要加setTimeout ?
	    // 原因:
	    // 其一 2.2.4规范 要确保 onFulfilled 和 onRejected 方法异步执行(且应该在 then 方法被调用的那一轮事件循环之后的新执行栈中执行) 所以要在resolve里加上setTimeout
	    // 其二 2.2.6规范 对于一个promise，它的then方法可以调用多次.（当在其他程序中多次调用同一个promise的then时 由于之前状态已经为FULFILLED/REJECTED状态，则会走的下面逻辑),所以要确保为FULFILLED/REJECTED状态后 也要异步执行onFulfilled/onRejected

	    // 其二 2.2.6规范 也是resolve函数里加setTimeout的原因
	    // 总之都是 让then方法异步执行 也就是确保onFulfilled/onRejected异步执行

	    // 如下面这种情景 多次调用p1.then
	    // p1.then((value) => { // 此时p1.status 由pedding状态 => fulfilled状态
	    //     console.log(value); // resolve
	    //     // console.log(p1.status); // fulfilled
	    //     p1.then(value => { // 再次p1.then 这时已经为fulfilled状态 走的是fulfilled状态判断里的逻辑 所以我们也要确保判断里面onFuilled异步执行
	    //         console.log(value); // 'resolve'
	    //     });
	    //     console.log('当前执行栈中同步代码');
	    // })
	    // console.log('全局执行栈中同步代码');
	    //

	    if (that.status === FULFILLED) { // 成功态
	        return newPromise = new Promise((resolve, reject) => {
	            setTimeout(() => {
	                try{
	                    let x = onFulfilled(that.value);
	                    resolvePromise(newPromise, x, resolve, reject); // 新的promise resolve 上一个onFulfilled的返回值
	                } catch(e) {
	                    reject(e); // 捕获前面onFulfilled中抛出的异常 then(onFulfilled, onRejected);
	                }
	            });
	        })
	    }

	    if (that.status === REJECTED) { // 失败态
	        return newPromise = new Promise((resolve, reject) => {
	            setTimeout(() => {
	                try {
	                    let x = onRejected(that.reason);
	                    resolvePromise(newPromise, x, resolve, reject);
	                } catch(e) {
	                    reject(e);
	                }
	            });
	        });
	    }

	    if (that.status === PENDING) { // 等待态
	        // 当异步调用resolve/rejected时 将onFulfilled/onRejected收集暂存到集合中
	        return newPromise = new Promise((resolve, reject) => {
	            that.onFulfilledCallbacks.push((value) => {
	                try {
	                    let x = onFulfilled(value);
	                    resolvePromise(newPromise, x, resolve, reject);
	                } catch(e) {
	                    reject(e);
	                }
	            });
	            that.onRejectedCallbacks.push((reason) => {
	                try {
	                    let x = onRejected(reason);
	                    resolvePromise(newPromise, x, resolve, reject);
	                } catch(e) {
	                    reject(e);
	                }
	            });
	        });
	    }
	};

	/**
	 * Promise.all Promise进行并行处理
	 * 参数: promise对象组成的数组作为参数
	 * 返回值: 返回一个Promise实例
	 * 当这个数组里的所有promise对象全部变为resolve状态的时候，才会resolve。
	 */
	Promise.all = function(promises) {
	    return new Promise((resolve, reject) => {
	        let done = gen(promises.length, resolve);
	        promises.forEach((promise, index) => {
	            promise.then((value) => {
	                done(index, value)
	            }, reject)
	        })
	    })
	}

	function gen(length, resolve) {
	    let count = 0;
	    let values = [];
	    return function(i, value) {
	        values[i] = value;
	        if (++count === length) {
	            console.log(values);
	            resolve(values);
	        }
	    }
	}

	/**
	 * Promise.race
	 * 参数: 接收 promise对象组成的数组作为参数
	 * 返回值: 返回一个Promise实例
	 * 只要有一个promise对象进入 FulFilled 或者 Rejected 状态的话，就会继续进行后面的处理(取决于哪一个更快)
	 */
	Promise.race = function(promises) {
	    return new Promise((resolve, reject) => {
	        promises.forEach((promise, index) => {
	           promise.then(resolve, reject);
	        });
	    });
	}

	// 用于promise方法链时 捕获前面onFulfilled/onRejected抛出的异常
	Promise.prototype.catch = function(onRejected) {
	    return this.then(null, onRejected);
	}

	Promise.resolve = function (value) {
	    return new Promise(resolve => {
	        resolve(value);
	    });
	}

	Promise.reject = function (reason) {
	    return new Promise((resolve, reject) => {
	        reject(reason);
	    });
	}

	/**
	 * 基于Promise实现Deferred的
	 * Deferred和Promise的关系
	 * - Deferred 拥有 Promise
	 * - Deferred 具备对 Promise的状态进行操作的特权方法（resolve reject）
	 *
	 *参考jQuery.Deferred
	 *url: http://api.jquery.com/category/deferred-object/
	 */
	Promise.deferred = function() { // 延迟对象
	    let defer = {};
	    defer.promise = new Promise((resolve, reject) => {
	        defer.resolve = resolve;
	        defer.reject = reject;
	    });
	    return defer;
	}

	/**
	 * Promise/A+规范测试
	 * npm i -g promises-aplus-tests
	 * promises-aplus-tests Promise.js
	 */

	try {
	  module.exports = Promise
	} catch (e) {
	}

	123456789101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899100101102103104105106107108109110111112113114115116117118119120121122123124125126127128129130131132133134135136137138139140141142143144145146147148149150151152153154155156157158159160161162163164165166167168169170171172173174175176177178179180181182183184185186187188189190191192193194195196197198199200201202203204205206207208209210211212213214215216217218219220221222223224225226227228229230231232233234235236237238239240241242243244245246247248249250251252253254255256257258259260261262263264265266267268269270271272273274275276277278279280281282283284285286287288289290291292293294295296

### Promise测试

	npm i -g promises-aplus-tests
	promises-aplus-tests Promise.js
	12

### 相关知识参考资料

[ES6-promise](https://link.jianshu.com/?t=http%3A%2F%2Fes6.ruanyifeng.com%2F%23docs%2Fpromise)

[Promises/A+规范-英文](https://link.jianshu.com/?t=https%3A%2F%2Fpromisesaplus.com%2F)

[Promises/A+规范-翻译1](https://link.jianshu.com/?t=https%3A%2F%2Fsegmentfault.com%2Fa%2F1190000002452115)

[Promises/A+规范-翻译-推荐](https://link.jianshu.com/?t=https%3A%2F%2Fmalcolmyu.github.io%2F2015%2F06%2F12%2FPromises-A-Plus%2F%23note-4)

[JS执行栈](https://link.jianshu.com/?t=https%3A%2F%2Fwww.cnblogs.com%2Fmqliutie%2Fp%2F4422247.html)

[Javascript异步编程的4种方法](https://link.jianshu.com/?t=http%3A%2F%2Fwww.ruanyifeng.com%2Fblog%2F2012%2F12%2Fasynchronous%25EF%25BC%25BFjavascript.html)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='2422'%3e%3cpath d='M728.064 343.943529c-17.648941-2.891294-23.552-20.239059-26.503529-28.912941V104.026353C701.560471 46.200471 654.396235 0 595.425882 0c-53.007059 0-97.28 40.478118-106.134588 89.569882-29.997176 184.862118-138.541176 255.457882-217.630118 280.937412a26.142118 26.142118 0 0 0-18.130823 24.877177v560.067764c0 19.817412 16.022588 35.84 35.84 35.84h535.973647c56.018824-11.565176 94.328471-31.804235 120.892235-86.738823l120.832-416.105412c23.552-75.173647-14.757647-147.395765-100.231529-144.564706h-238.772706z m-571.813647 31.744H76.619294C35.358118 375.687529 0 410.383059 0 450.861176v462.426353c0 43.369412 32.406588 78.004706 76.619294 78.004706h79.631059c27.708235 0 50.115765-22.407529 50.115765-50.115764V425.863529a50.115765 50.115765 0 0 0-50.115765-50.115764z' data-evernote-id='151' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

24人点赞*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='64 64 896 896' focusable='false' class='js-evernote-checked' data-icon='right' width='1em' height='1em' fill='currentColor' aria-hidden='true' data-evernote-id='2426'%3e%3cpath d='M765.7 486.8L314.9 134.7A7.97 7.97 0 0 0 302 141v77.3c0 4.9 2.3 9.6 6.1 12.6l360 281.1-360 281.1c-3.9 3-6.1 7.7-6.1 12.6V883c0 6.7 7.7 10.4 12.9 6.3l450.8-352.1a31.96 31.96 0 0 0 0-50.4z' data-evernote-id='2427' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='2431'%3e%3cpath d='M771.413333 668.728889c-18.773333 3.015111-25.031111 20.878222-28.16 29.866667v217.884444c0 59.733333-49.948444 107.52-112.412444 107.52a115.427556 115.427556 0 0 1-112.412445-92.558222c-31.857778-190.919111-146.830222-263.850667-230.627555-290.133334a27.420444 27.420444 0 0 1-19.228445-26.168888V37.944889C268.572444 17.066667 285.582222 0 306.631111 0h567.864889c59.335111 11.946667 99.953778 32.824889 128 89.543111l128.113778 429.909333c24.974222 77.653333-15.644444 152.291556-106.211556 149.276445H771.413333z m-605.866666-32.824889H81.180444C37.546667 635.904 0 600.064 0 558.250667V80.611556C0 35.84 34.360889 0 81.180444 0H165.546667c29.297778 0 53.077333 23.779556 53.077333 53.077333v529.749334a53.077333 53.077333 0 0 1-53.077333 53.077333z' data-evernote-id='130' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

[*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='2436'%3e%3cpath d='M178.390055 120.591045C111.268624 120.591045 56.888889 174.401955 56.888889 240.556383V903.97778C56.888889 970.302855 111.097977 1024 178.390055 1024h545.731364c67.121431 0 121.558049-53.81091 121.558049-120.02222V240.613265c0-66.268192-54.209088-120.02222-121.558049-120.02222H178.390055z m455.117432 301.136319H269.06087a30.147761 30.147761 0 0 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z m303.18409 301.136318a30.318409 30.318409 0 0 1-30.375291-30.318409V180.317742c0-66.268192-53.81091-120.02222-121.330519-120.022219H329.697688a30.147761 30.147761 0 0 1 0-60.23864l454.946784 0.056882C885.326618 0.113765 967.009987 80.887013 967.009987 180.602155v511.943118a30.318409 30.318409 0 0 1-30.31841 30.318409z m-303.18409-120.47728H269.06087a30.147761 30.147761 0 1 1 0-60.238641h364.503499a30.147761 30.147761 0 0 1 0 60.238641z' data-evernote-id='141' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*日记本](https://www.jianshu.com/nb/5937765)

*![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' fill='currentColor' aria-hidden='true' focusable='false' class='js-evernote-checked' data-evernote-id='2442'%3e%3cpath d='M232.727273 579.87878833C271.28679 579.87878833 302.545455 548.62012233 302.545455 510.06060633 302.545455 471.50108933 271.28679 440.24242433 232.727273 440.24242433 194.167756 440.24242433 162.909091 471.50108933 162.909091 510.06060633 162.909091 548.62012233 194.167756 579.87878833 232.727273 579.87878833ZM512 579.87878833C550.559516 579.87878833 581.818182 548.62012233 581.818182 510.06060633 581.818182 471.50108933 550.559516 440.24242433 512 440.24242433 473.440484 440.24242433 442.181818 471.50108933 442.181818 510.06060633 442.181818 548.62012233 473.440484 579.87878833 512 579.87878833ZM791.272727 579.87878833C829.832243 579.87878833 861.090909 548.62012233 861.090909 510.06060633 861.090909 471.50108933 829.832243 440.24242433 791.272727 440.24242433 752.713211 440.24242433 721.454545 471.50108933 721.454545 510.06060633 721.454545 548.62012233 752.713211 579.87878833 791.272727 579.87878833Z' data-evernote-id='161' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)*

"小礼物走一走，来简书关注我"
还没有人赞赏，支持一下

[[webp](../_resources/8b6c2b5c50831f8edcfb8896d9e217b1.webp)](https://www.jianshu.com/u/b6e4a21c5ab1)

[Brolly](https://www.jianshu.com/u/b6e4a21c5ab1)web前端开发人员
总资产2 (约0.28元)共写了1.4W字获得32个赞共20个粉丝