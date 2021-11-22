与Promise血脉相连的async/await - 掘金

[(L)](https://juejin.im/user/272334612599629)  [limingru](https://juejin.im/user/272334612599629)  [![](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMyIgaGVpZ2h0PSIxNCIgdmlld0JveD0iMCAwIDIzIDE0Ij4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHBhdGggZmlsbD0iIzU5OURGRiIgZD0iTTMgMWgxN2EyIDIgMCAwIDEgMiAydjhhMiAyIDAgMCAxLTIgMkgzYTIgMiAwIDAgMS0yLTJWM2EyIDIgMCAwIDEgMi0yeiIvPgogICAgICAgIDxwYXRoIGZpbGw9IiNGRkYiIGQ9Ik0zIDRoMnY3SDN6TTggNmgybDIgNWgtMnoiLz4KICAgICAgICA8cGF0aCBmaWxsPSIjRkZGIiBkPSJNMTQgNmgtMmwtMiA1aDJ6TTMgOWg1djJIM3pNMTUgM2g1djJoLTV6TTE4IDVoMnYxaC0yek0xOCA4aDJ2MWgtMnpNMTYgNmg0djJoLTR6TTE1IDloNXYyaC01eiIvPgogICAgPC9nPgo8L3N2Zz4K)](https://juejin.im/book/5c90640c5188252d7941f5bb/section/5c9065385188252da6320022)

2018年02月28日  阅读 8916
与Promise血脉相连的async/await

> async/await是JavaScript为了解决异步问题而提出的一种解决方案，许多人将其称为异步的终极解决方案。JavaScript的发展也经历了回调、Promise、async/await三个阶段，本篇文章记录了我自己对于async/await的理解。因为async/await的使用离不开Promise，如果对于Promise不熟悉的话，可以看下这篇介绍：> [> 前端萌新眼中的Promise及使用](https://juejin.im/post/6844903567321464846)> 。

### 一、async/await的具体使用规则

在我们处理异步的时候，比起回调函数，Promise的then方法会显得较为简洁和清晰，但是在处理多个彼此之间相互依赖的请求的时候，就会显的有些累赘。这时候，用async和await更加优雅，后面会详情说明。

async/await使用规则一：凡是在前面添加了async的函数在执行后都会自动返回一个Promise对象
例子：
async  function  test() {
}

let  result =  test()
console.log(result) //即便代码里test函数什么都没返回，我们依然打出了Promise对象
复制代码
async/await使用规则二：await必须在async函数里使用，不能单独使用
错误的例子：
function  test() {
let  result = await Promise.resolve('success')
console.log(result)
}

test() //执行以后会报错
复制代码
正确的例子：
async  test() {
let  result = await Promise.resolve('success')
console.log(result)
}
test()
复制代码

async/await使用规则三：await后面需要跟Promise对象，不然就没有意义，而且await后面的Promise对象不必写then，因为await的作用之一就是获取后面Promise对象成功状态传递出来的参数。

正确的例子：
function  fn() {
return  new Promise((resolve, reject) => {
setTimeout(() => {
resolve('success')
})
})
}

async  test() {
let  result = await fn() //因为fn会返回一个Promise对象
console.log(result) //这里会打出Promise成功后传递过来的'success'
}

test()
复制代码
没有意义的例子（不会报错）：
async  test() {
let  result = await 123
console.log(result)
}

test()
复制代码

### 二、async/await的错误处理方式

关于错误处理，如规则三所说，await可以直接获取到后面Promise成功状态传递的参数，但是却捕捉不到失败状态。在这里，我们通过给包裹await的async函数添加then/catch方法来解决，因为根据规则一，async函数本身就会返回一个Promise对象。

一个包含错误处理的完整的async/await例子：
let  promiseDemo = new Promise((resolve, reject) => {
setTimeout(() => {
let  random = Math.random()
if  (random >= 0.5) {
resolve('success')
}  else  {
reject('failed')
}
}, 1000)
})

async  function  test() {
let  result = await promiseDemo
return  result //这里的result是promiseDemo成功状态的值，如果失败了，代码就直接跳到下面的catch了
}

test().then(response => {
console.log(response)
}).catch(error => {
console.log(error)
})

复制代码

上面的代码需要注意两个地方，一是async函数需要主动return一下，如果Promise的状态是成功的，那么return的这个值就会被下面的then方法捕捉到；二是，如果async函数有任何错误，都被catch捕捉到！

### 三、同步与异步

在async函数中使用await，那么await这里的代码就会变成同步的了，意思就是说只有等await后面的Promise执行完成得到结果才会继续下去，await就是等待，这样虽然避免了异步，但是它也会阻塞代码，所以使用的时候要考虑周全。

比如下面的代码：
function  fn(name) {
return  new Promise((resolve, reject) => {
setTimeout(() => {
resolve(`${name}成功`)
}, 1000)
})
}

async  function  test() {
let  p1 = await fn('小红')
let  p2 = await fn('小明')
let  p3 = await fn('小华')
return  [p1, p2, p3]
}

test().then(result => {
console.log(result)
}).catch(result => {
console.log(result)
})
复制代码

这样写虽然是可以的，但是这里await会阻塞代码，每个await都必须等后面的fn()执行完成才会执行下一行代码，所以test函数执行需要3秒。如果不是遇到特定的场景，最好还是不要这样用。

### 三、一个小测试

写到这里，突然想起Promise的代码执行顺序也是挺需要注意的。
请看下面的代码，执行完以后打出的数字的顺序是怎样的呢？
console.log(1)
let  promiseDemo = new Promise((resolve, reject) => {
console.log(2)
setTimeout(() => {
let  random = Math.random()
if  (random >= 0.2) {
resolve('success')
console.log(3)
}  else  {
reject('failed')
console.log(3)
}
}, 1000)
})

async  function  test() {
console.log(4)
let  result = await promiseDemo
return  result
}

test().then(result => {
console.log(5)
}).catch((result) => {
console.log(5)
})

console.log(6)
复制代码
答案是：1 2 4 6 3 5

### 四、一个适合使用async/await的业务场景

在前端编程中，我们偶尔会遇到这样一个场景：我们需要发送多个请求，而后面请求的发送总是需要依赖上一个请求返回的数据。对于这个问题，我们既可以用的Promise的链式调用来解决，也可以用async/await来解决，然而后者会更简洁些。

使用Promise链式调用来处理：
function  request(time) {
return  new Promise((resolve, reject) => {
setTimeout(() => {
resolve(time)
}, time)
})
}

request(500).then(result => {
return  request(result + 1000)
}).then(result => {
return  request(result + 1000)
}).then(result => {
console.log(result)
}).catch(error => {
console.log(error)
})
复制代码
使用async/await的来处理：
function  request(time) {
return  new Promise((resolve, reject) => {
setTimeout(() => {
resolve(time)
}, time)
})
}

async  function  getResult() {
let  p1 = await request(500)
let  p2 = await request(p1 + 1000)
let  p3 = await request(p2 + 1000)
return  p3
}

getResult().then(result => {
console.log(result)
}).catch(error => {
console.log(error)
})
复制代码
相对于使用then不停地进行链式调用， 使用async/await会显的更加易读一些。

### 五、在循环中使用await

如果在是循环中使用await，就需要牢记一条：必须在async函数中使用。
在for...of中使用await:
let  request = (time) => {
return  new Promise((resolve) => {
setTimeout(() => {
resolve(time)
}, time)
})
}

let  times  = [1000, 500, 2000]
async  function  test() {
let  result = []
for  (let  item of  times) {
let  temp = await request(item)
result.push(temp)
}
return  result
}

test().then(result => {
console.log(result)
}).catch(error => {
console.log(error)
})
复制代码

上面就是我今天关于async/await理解的记录，笔者作为一只程序员生活只有半年，以上内容估计还有错误之处，如果掘金上的朋友有看到，还望不吝指出！谢谢您的观看！