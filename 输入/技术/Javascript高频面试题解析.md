Javascript高频面试题解析

##  Javascript高频面试题解析

小小张 [前端工匠]()**
![640.gif](../_resources/b22baf540aec824845bf4c57d376d6d7.gif)

![640.jpg](../_resources/83f1b22f5e7341b54da080f4886d9a5a.jpg)
本文中讲解的面试题
![640.jpg](../_resources/a46583a65b0806f4654090af96a65114.jpg)
说说对闭包的认识,它解决了什么问题?
跨域问题有哪些处理方式?
for...in 和 for...of的区别?
new一个对象, 这个过程中发生了什么?
js的防抖和节流是什么?
数组中常用的方法有哪些?
怎么判断一个object是否是数组?
继承有哪些方式?
说说js中call,apply,bind之间的关系?
你了解promise吗?

### 文章篇幅较长, 建议收藏或者关注公众号, 方便日后翻阅

说说你对闭包的认识

> “请讲一下你对闭包的认识”——这道题几乎是前端面试必问的问题，今天我试着总结一下如何优雅的回答这道题

##### 什么是闭包

一句话解释:
能够读取其他函数内部变量的函数。
稍全面的回答：

在js中变量的作用域属于函数作用域, 在函数执行完后,作用域就会被清理,内存也会随之被回收,但是由于闭包函数是建立在函数内部的子函数, 由于其可访问上级作用域,即使上级函数执行完, 作用域也不会随之销毁, 这时的子函数(也就是闭包),便拥有了访问上级作用域中变量的权限,即使上级函数执行完后作用域内的值也不会被销毁。

这里涉及到对函数作用域的认识: js变量分为全局变量和局部变量;函数内部可以直接读取全局变量,而在函数外部自然无法读取函数内的局部变量

##### 闭包解决了什么问题

1. 可以读取函数内部的变量
2. 让这些变量的值始终保持在内存中。不会在函数调用后被清除
可以通过下面的代码来帮助理解上面所说的：

`functionaddCounter() {[[NEWLINE]]let counter = 0[[NEWLINE]]const myFunction = function () {[[NEWLINE]] counter = counter + 1[[NEWLINE]]return counter[[NEWLINE]] }[[NEWLINE]]return myFunction[[NEWLINE]] }[[NEWLINE]]const increment = addCounter()[[NEWLINE]]const c1 = increment()[[NEWLINE]]const c2 = increment()[[NEWLINE]]const c3 = increment()[[NEWLINE]]console.log('increment:', c1, c2, c3);[[NEWLINE]]// increment: 1 2 3[[NEWLINE]]`

在这段代码中`increment`实际上就是闭包函数`myFunction`, 它一共运行了三次，第一次的值是1，第二次的值是2，第三次的值是3。这证明了，函数`addCounter`中的局部变量`counter`一直保存在内存中，并没有在`addCounter`调用后被自动清除。

##### 闭包的应用场景

在开发中, 其实我们随处可见闭包的身影, 大部分前端 JavaScript 代码都是“事件驱动”的,即一个事件绑定的回调方法; 发送ajax请求成功|失败的回调;setTimeout的延时回调;或者一个函数内部返回另一个匿名函数,这些都是闭包的应用。

下面是具体应用的栗子：
1. > 老掉牙的取正确值问题

`for (var i = 0; i < 10; i++) {[[NEWLINE]] setTimeout(function () {[[NEWLINE]]console.log(i) //10个10[[NEWLINE]] }, 1000)[[NEWLINE]] }[[NEWLINE]]`

怎么取到每一次循环的正确值呢? 闭包这样用:

`for (var i = 0; i < 10; i++) {[[NEWLINE]] ((j) => {[[NEWLINE]] setTimeout(function () {[[NEWLINE]]console.log(j) //1-10[[NEWLINE]] }, 1000)[[NEWLINE]] })(i)[[NEWLINE]] }[[NEWLINE]]`

声明了10个自执行函数，保存当时的值到内部
> 2.使用闭包模拟私有变量
私有变量在java里使用private声明就可以了, 但是在js中还没有，但是我们可以使用闭包模拟实现。

`var counter = (function () {[[NEWLINE]]var privateCounter = 0;[[NEWLINE]][[NEWLINE]]functionchangeBy(val) {[[NEWLINE]] privateCounter += val[[NEWLINE]] }[[NEWLINE]]return {[[NEWLINE]]increment: function () {[[NEWLINE]] changeBy(1)[[NEWLINE]] },[[NEWLINE]]decrement: function () {[[NEWLINE]] changeBy(-1)[[NEWLINE]] },[[NEWLINE]]value: function () {[[NEWLINE]]return privateCounter[[NEWLINE]] }[[NEWLINE]] }[[NEWLINE]] })();[[NEWLINE]] counter.value() //0[[NEWLINE]] counter.increment() //1[[NEWLINE]] counter.increment() //2[[NEWLINE]] counter.decrement() //1[[NEWLINE]]`

匿名函数已经定义就立即执行, 创建出一个词法环境包含`counter.increment`、`counter.decrement`、`counter.value`三个方法,还包含了两个私有项:`privateCounter`变量和`changeBy`函数。这两个私有项无法在匿名函数外部直接访问，必须通过匿名包装器返回的对象的三个公共函数访问。

##### 闭包的缺点

1. 由于闭包会是的函数中的变量都被保存到内存中,滥用闭包很容易造成内存消耗过大,导致网页性能问题。解决方法是在退出函数之前，将不再使用的局部变量全部删除。

2. 闭包可以使得函数内部的值可以在函数外部进行修改。所有，如果你把父函数当作对象（object）使用，把闭包当作它的公用方法（Public Method），把内部变量当作它的私有属性（private value），这时一定要小心，不要随便改变父函数内部变量的值。

跨域问题有哪些处理方式

##### 跨域解决方案

1. 通过jsonp跨域
2. 跨域资源共享（CORS）
3. nodejs中间件代理跨域
4. nginx反向代理中设置proxy_cookie_domain

##### Ⅰ.通过jsonp跨域

通常为了减轻web服务器的负载，我们把`js`、`css`，`img`等静态资源分离到另一台独立域名的服务器上，在html页面中再通过相应的标签从不同域名下加载静态资源，而被浏览器允许，基于此原理，我们可以通过动态创建script，再请求一个带参网址实现跨域通信。

1. 原生实现

` <script>[[NEWLINE]]var script = document.createElement('script');[[NEWLINE]] script.type = 'text/javascript';[[NEWLINE]][[NEWLINE]]// 传参一个回调函数名给后端，方便后端返回时执行这个在前端定义的回调函数[[NEWLINE]] script.src = 'http://www.daxihong.com:8080/login?user=admin&callback=jsonCallback';[[NEWLINE]]document.head.appendChild(script);[[NEWLINE]][[NEWLINE]]// 回调执行函数[[NEWLINE]]functionjsonCallback(res) {[[NEWLINE]] alert(JSON.stringify(res));[[NEWLINE]] }[[NEWLINE]] </script>[[NEWLINE]]`

服务器端返回如下(返回即执行全局函数)
`jsonCallback({"status": 0, "user": "admin"})[[NEWLINE]]`

2. jquery方式实现

`$.ajax({[[NEWLINE]]url: 'http://www.domain2.com:8080/login',[[NEWLINE]]type: 'get',[[NEWLINE]]dataType: 'jsonp', // 请求方式为jsonp[[NEWLINE]] jsonpCallback: "handleCallback", // 自定义回调函数名[[NEWLINE]] data: {}[[NEWLINE]]});[[NEWLINE]]`

##### Ⅱ.跨域资源共享（CORS）

CORS是一个W3C标准，全称是"跨域资源共享"（Cross-origin resource sharing）跨域资源共享 CORS 详解。看名字就知道这是处理跨域问题的标准做法。CORS有两种请求，简单请求和非简单请求。

- 简单请求

只要同时满足以下两大条件,就属于简单请求:
1. 请求方法是以下三种方法之一:

- `HEAD`
- `GET`
- `POST`

1. HTTP请求头的信息不超出以下几种字段：

- Accept
- Accept-Language
- Content-Language
- Last-Event-ID
- Content-Type：只限于三个值application/x-www-form-urlencoded、multipart/form-data、text/plain

> 如果是简单请求, 后端处理即可, 前端什么也不用干; 这里注意的是如果前端要带cookie, 前端也需要单独设置

- 原生ajax (前端)

`var xhr = new XMLHttpRequest();[[NEWLINE]]// 前端设置是否带cookie[[NEWLINE]]xhr.withCredentials = true;[[NEWLINE]]...[[NEWLINE]]`

- jquery (前端)

`$.ajax({[[NEWLINE]] ...[[NEWLINE]] xhrFields: {[[NEWLINE]]withCredentials: true// 前端设置是否带cookie[[NEWLINE]] },[[NEWLINE]]crossDomain: true, // 会让请求头中包含跨域的额外信息，但不会含cookie[[NEWLINE]] ...[[NEWLINE]]});[[NEWLINE]]`

- vue中使用axios (前端)

`axios.defaults.withCredentials = true[[NEWLINE]]`

- 后端node

可以借助`koa2-cors`快速实现

`const path = require('path')[[NEWLINE]]const Koa = require('koa')[[NEWLINE]]const koaStatic = require('koa-static')[[NEWLINE]]const bodyParser = require('koa-bodyparser')[[NEWLINE]]const router = require('./router')[[NEWLINE]]const cors = require('koa2-cors')[[NEWLINE]]const app = new Koa()[[NEWLINE]]const port = 9871[[NEWLINE]][[NEWLINE]]...[[NEWLINE]]// 处理cors[[NEWLINE]]app.use(cors({[[NEWLINE]]origin: function (ctx) {[[NEWLINE]]return'http://localhost:9099'[[NEWLINE]] },[[NEWLINE]]credentials: true,[[NEWLINE]]allowMethods: ['GET', 'POST', 'DELETE'],[[NEWLINE]]allowHeaders: ['t', 'Content-Type'][[NEWLINE]]}))[[NEWLINE]]// 路由[[NEWLINE]]app.use(router.routes()).use(router.allowedMethods())[[NEWLINE]]// 监听端口[[NEWLINE]]...[[NEWLINE]]`

##### Ⅲ.nodejs中间件代理跨域

**跨域原理**: 同源策略是浏览器的安全策略, 不是HTTP协议的一部分。服务器端调用HTTP接口只是使用HTTP协议， 不会执行js脚本, 不需要检验同源策略,也就不存在跨域问题。

**实现思路**：通过起一个代理服务器， 实现数据的转发，也可以通过设置cookieDomainRewrite参数修改响应头cookie中域名,实现当前域下cookie的写入

- 在vue框架下实现跨域

利用node + webpack + webpack-dev-server代理接口跨域。在开发环境下，由于vue渲染服务和接口代理服务都是webpack-dev-server同一个，所以页面与代理接口之间不再跨域，无须设置headers跨域信息了。后台可以不做任何处理。

`webpack.config.js`部分配置

`module.exports = {[[NEWLINE]]entry: {},[[NEWLINE]]module: {},[[NEWLINE]] ...[[NEWLINE]] devServer: {[[NEWLINE]]historyApiFallback: true,[[NEWLINE]]proxy: [{[[NEWLINE]]context: '/login',[[NEWLINE]]target: 'http://www.daxihong.com:8080', // 代理跨域目标接口[[NEWLINE]] changeOrigin: true,[[NEWLINE]]secure: false, // 当代理某些https服务报错时用[[NEWLINE]] cookieDomainRewrite: 'www.daxihong.com'// 可以为false，表示不修改[[NEWLINE]] }],[[NEWLINE]]noInfo: true[[NEWLINE]] }[[NEWLINE]]}[[NEWLINE]]`

#####

##### Ⅳ.nginx反向代理中设置

和使用node中间件跨域原理相似。前端和后端都不需要写额外的代码来处理， 只需要配置一下Ngnix

`server{[[NEWLINE]] # 监听9099端口[[NEWLINE]] listen 9099;[[NEWLINE]] # 域名是localhost[[NEWLINE]] server_name localhost;[[NEWLINE]] #凡是localhost:9099/api这个样子的，都转发到真正的服务端地址http://localhost:9871[[NEWLINE]] location ^~ /api {[[NEWLINE]] proxy_pass http://localhost:9871;[[NEWLINE]] }[[NEWLINE]]}[[NEWLINE]]`

对于跨域还有挺多方式可以实现， 这里就不一一列举了。

for...in 和 for...of的区别

1. for...of 是ES6新引入的特性，修复了ES5引入的for...in的不足
2. for...in 循环出的是key，for...of循环出的是value
3. for...of不能循环普通的对象，需要通过和Object.keys()搭配使用
4. 推荐在循环对象属性的时候，使用for...in,在遍历数组的时候的时候使用for...of

new一个对象，这个过程中发生了什么

####

`var obj = newObject("name","sansan");[[NEWLINE]]`

1. 创建一个新对象，如：var obj = {};
2. 新对象的_proto_属性指向构造函数的原型对象。
3. 将构造函数的作用域赋值给新对象。（也所以this对象指向新对象）
4. 执行构造函数内部的代码，将属性添加给obj中的this对象。
5. 返回新对象obj。

js的防抖和节流是什么

####

- 防抖: 在事件被触发n秒后再执行回调，如果在这n秒内又被触发，则重新计时。

使用场景:
1. 给按钮加函数防抖防止表单多次提交。
2. 对于输入框连续输入进行AJAX验证时，用函数防抖能有效减少请求次数。
简单的防抖(debounce)代码:

`functiondebounce(fn, wait) {[[NEWLINE]]var timeout = null;[[NEWLINE]]returnfunction () {[[NEWLINE]]if (timeout !== null) clearTimeout(timeout)[[NEWLINE]] timeout = setTimeout(fn, wait)[[NEWLINE]] }[[NEWLINE]] }[[NEWLINE]]// 处理函数[[NEWLINE]]functionhandle() {[[NEWLINE]]console.log(Math.random())[[NEWLINE]] }[[NEWLINE]]//滚动事件[[NEWLINE]]window.addEventListener('scroll', debounce(handle, 2000));[[NEWLINE]]`

- 节流: 就是指连续触发事件但是在 n 秒中只执行一次函数。节流会稀释函数的执行频率。

`functionthrottle(func, delay) {[[NEWLINE]]var prev = Date.now();[[NEWLINE]]returnfunction () {[[NEWLINE]]var context = this;[[NEWLINE]]var args = arguments;[[NEWLINE]]var now = Date.now();[[NEWLINE]]if (now - prev >= delay) {[[NEWLINE]] func.apply(context, args);[[NEWLINE]] prev = Date.now();[[NEWLINE]] }[[NEWLINE]] }[[NEWLINE]] }[[NEWLINE]][[NEWLINE]]functionhandle() {[[NEWLINE]]console.log(Math.random());[[NEWLINE]] }[[NEWLINE]]window.addEventListener('scroll', throttle(handle, 2000));[[NEWLINE]]`

**
**
**区别：**

函数节流不管事件触发有多频繁，都会保证在规定时间内一定会执行一次真正的事件处理函数，而函数防抖只是在最后一次事件后才触发一次函数。比如在页面的无限加载场景下，我们需要用户在滚动页面时，每隔一段时间发一次 Ajax 请求，而不是在用户停下滚动页面操作时才去请求数据。这样的场景，就适合用节流技术来实现。

数组中常用的方法有哪些

> 开发中数组的使用场景非常多, 这里就简单整理总结一些常用的方法;从改变原有数据的方法、不改变原有数组的方法以及数据遍历的方法三方面总结。

- 改变原有数组的方法：（9个）

1. splice() 添加/删除数组元素

`let a = [1, 2, 3, 4, 5, 6, 7];[[NEWLINE]]let item = a.splice(0, 3); // [1,2,3][[NEWLINE]]console.log(a); // [4,5,6,7][[NEWLINE]]// 从数组下标0开始，删除3个元素[[NEWLINE]]let item1 = a.splice(0,3,'添加'); // [4,5,6][[NEWLINE]]console.log(a); // ['添加',7][[NEWLINE]]// 从数组下标0开始，删除3个元素，并添加元素'添加'[[NEWLINE]]`

2. sort() 数组排序

`var array = [10, 1, 3, 4,20,4,25,8];[[NEWLINE]]// 升序 a-b < 0 a将排到b的前面，按照a的大小来排序的[[NEWLINE]] array.sort(function(a,b){[[NEWLINE]]return a-b;[[NEWLINE]] });[[NEWLINE]]console.log(array); // [1,3,4,4,8,10,20,25];[[NEWLINE]]// 降序[[NEWLINE]] array.sort(function(a,b){[[NEWLINE]]return b-a;[[NEWLINE]] });[[NEWLINE]]console.log(array); // [25,20,10,8,4,4,3,1];[[NEWLINE]]`

1. pop() 删除一个数组中的最后的一个元素
2. shift() 删除数组的第一个元素
3. push() 向数组的末尾添加元素
4. unshift()向数组开头添加元素
5. reverse()

`let a = [1,2,3];[[NEWLINE]] a.pop(); // 3, 返回被删除的元素[[NEWLINE]]console.log(a); // [1,2][[NEWLINE]] a.shift(); // 1[[NEWLINE]]console.log(a); // [2][[NEWLINE]] a.push("末尾添加"); // 2 ,返回数组长度[[NEWLINE]]console.log(a) ; [2,"末尾添加"][[NEWLINE]] a.unshift("开头添加"); // 3[[NEWLINE]]console.log(a); //["开头添加", 2, "末尾添加"][[NEWLINE]] a.reverse(); // ["末尾添加", 2, "开头添加"][[NEWLINE]]console.log(a) // ["末尾添加", 2, "开头添加"][[NEWLINE]]`

1. ES6: copyWithin() 指定位置的成员复制到其他位置

`let a = ['zhang', 'wang', 'zhou', 'wu', 'zheng'];[[NEWLINE]]// 1位置开始被替换, 2位置开始读取要替换的 5位置前面停止替换[[NEWLINE]] a.copyWithin(1, 2, 5);[[NEWLINE]]// ["zhang", "zhou", "wu", "zheng", "zheng"][[NEWLINE]]`

1. ES6: fill() 填充数组

`['a', 'b', 'c'].fill(7)[[NEWLINE]]// [7, 7, 7][[NEWLINE]]['a', 'b', 'c'].fill(7, 1, 2)[[NEWLINE]]// ['a', 7, 'c'][[NEWLINE]]`

以上是9种会改变原数组的方法, 接下来是6种常用的不会改变原数组的方法

- 不改变原数组的方法(6种)

1. join() 数组转字符串

`let a= ['hello','world'];[[NEWLINE]]let str2=a.join('+'); // 'hello+world'[[NEWLINE]]`

1. cancat 合并两个或多个数组

`let a = [1, 2, 3];[[NEWLINE]]let b = [4, 5, 6];[[NEWLINE]]//连接两个数组[[NEWLINE]]let newVal=a.concat(b); // [1,2,3,4,5,6][[NEWLINE]]`

1. ES6扩展运算符...合并数组

`let a = [2, 3, 4, 5][[NEWLINE]]let b = [ 4,...a, 4, 4][[NEWLINE]]console.log(a,b);[[NEWLINE]]//[2, 3, 4, 5] [4,2,3,4,5,4,4][[NEWLINE]]`

1. indexOf() 查找数组是否存在某个元素，返回下标

`let a=['啦啦',2,4,24,NaN][[NEWLINE]]console.log(a.indexOf('啦')); // -1[[NEWLINE]]console.log(a.indexOf('啦啦')); // 0[[NEWLINE]]`

1. ES7 includes() 查找数组是否包含某个元素 返回布尔
1. > indexOf方法不能识别NaN
2. > indexOf方法检查是否包含某个值不够语义化，需要判断是否不等于-1，表达不够直观

`let a=['OB','Koro1',1,NaN];[[NEWLINE]] a.includes(NaN); // true 识别NaN[[NEWLINE]] a.includes('Koro1',100); // false 超过数组长度 不搜索[[NEWLINE]] a.includes('Koro1',-3); // true 从倒数第三个元素开始搜索[[NEWLINE]]`

1. slice() 浅拷贝数组的元素
> 字符串也有一个slice() 方法是用来提取字符串的，不要弄混了。

`let a = [{name: 'OBKoro1'}, {name: 'zhangsan'}];[[NEWLINE]]let b = a.slice(0,1);[[NEWLINE]]console.log(b, a);[[NEWLINE]]// [{"name":"OBKoro1"}] [{"name":"OBKoro1"}][[NEWLINE]] a[0].name='改变原数组';[[NEWLINE]]console.log(b,a);[[NEWLINE]]// [{"name":"改变原数组"}] [{"name":"改变原数组"}][[NEWLINE]]`

- 遍历方法

    1. forEach:按升序为数组中含有效值的每一项执行一次回调函数。
> 1.无法中途退出循环，只能用return退出本次回调，进行下一次回调.
> 2.它总是返回 undefined值,即使你return了一个值。

2. every 检测数组所有元素是否都符合判断条件
> 如果数组中检测到**> 有一个元素不满足, 则整个表达式返回false**> ,且元素不会再进行检测

`functionisBigEnough(element, index, array) {[[NEWLINE]]return element >= 10; // 判断数组中的所有元素是否都大于10[[NEWLINE]]}[[NEWLINE]][12, 5, 8, 130, 44].every(isBigEnough); // false[[NEWLINE]][12, 54, 18, 130, 44].every(isBigEnough); // true[[NEWLINE]]// 接受箭头函数写法[[NEWLINE]][12, 5, 8, 130, 44].every(x => x >= 10); // false[[NEWLINE]][12, 54, 18, 130, 44].every(x => x >= 10); // true[[NEWLINE]]`

3. some 数组中的是否有满足判断条件的元素
> 如果**> 有一个元素满足条件，则表达式返回true**> , 剩余的元素不会再执行检测
1. filter 过滤原始数组，返回新数组
2. map 对数组中的每个元素进行处理，返回新的数组
3. reduce 为数组提供累加器，合并为一个值
> reduce() 方法对累加器和数组中的每个元素（从左到右）应用一个函数，最终合并为一个值。

`// 数组求和[[NEWLINE]]let sum = [0, 1, 2, 3].reduce(function (a, b) {[[NEWLINE]]return a + b;[[NEWLINE]]}, 0);[[NEWLINE]]// 6[[NEWLINE]]// 将二维数组转化为一维 将数组元素展开[[NEWLINE]]let flattened = [[0, 1], [2, 3], [4, 5]].reduce([[NEWLINE]](a, b) => a.concat(b),[[NEWLINE]] [][[NEWLINE]]);[[NEWLINE]]// [0, 1, 2, 3, 4, 5][[NEWLINE]]`

7. ES6：find()& findIndex() 根据条件找到数组成员
> 这两个方法都可以识别NaN,弥补了indexOf的不足.

`[1, 4, -5, 10,NaN].find((n) =>Object.is(NaN, n));[[NEWLINE]]// 返回元素NaN[[NEWLINE]][1, 4, -5, 10].findIndex((n) => n < 0);[[NEWLINE]]// 返回索引2[[NEWLINE]]`

8. ES6 keys()&values()&entries() 遍历键名、遍历键值、遍历键名+键值

`for (let index of ['a', 'b'].keys()) {[[NEWLINE]]console.log(index);[[NEWLINE]]}[[NEWLINE]]// 0[[NEWLINE]]// 1[[NEWLINE]]for (let elem of ['a', 'b'].values()) {[[NEWLINE]]console.log(elem);[[NEWLINE]]}[[NEWLINE]]// 'a'[[NEWLINE]]// 'b'[[NEWLINE]]for (let [index, elem] of ['a', 'b'].entries()) {[[NEWLINE]]console.log(index, elem);[[NEWLINE]]}[[NEWLINE]]// 0 "a"[[NEWLINE]]// 1 "b"[[NEWLINE]]`

怎么判断一个object是否是数组

####

- 方法一

使用 Object.prototype.toString 来判断是否是数组

`functionisArray(obj){[[NEWLINE]]returnObject.prototype.toString.call( obj ) === '[object Array]';[[NEWLINE]]}[[NEWLINE]]`

这里使用call来使 toString 中 this 指向 obj。进而完成判断

- 方法二

使用 原型链 来完成判断

`functionisArray(obj){[[NEWLINE]]return obj.__proto__ === Array.prototype;[[NEWLINE]]}[[NEWLINE]]`

> 基本思想: 实例如果是某个构造函数构造出来的那么 它的`__proto__`> 是指向构造函数的 `prototype`> 属性

- 方法3

利用JQuery,  利用JQuery isArray 的实现其实就是方法1。
`functionisArray(obj){[[NEWLINE]]return $.isArray(obj)[[NEWLINE]]}[[NEWLINE]]`

####

继承有哪些方式

####

- ES6中的class继承
- 原型继承
- 构造继承
- 寄生组合式继承
- 实例继承

简单介绍一下前两种方式, 后面几种继承方式大家可以自行上网查找.
1. ES6中的class继承

`classAnimal{[[NEWLINE]]constructor(name) {[[NEWLINE]]this.name = name;[[NEWLINE]] };[[NEWLINE]] eat() {[[NEWLINE]]console.log(this.name + '正在吃东西');[[NEWLINE]] };[[NEWLINE]]}[[NEWLINE]]//继承动物类[[NEWLINE]]classCatextendsAnimal{[[NEWLINE]] catchMouse(){[[NEWLINE]]console.log(`${this.name}正在捉老鼠`);[[NEWLINE]] }[[NEWLINE]]}[[NEWLINE]]var cat= new Cat('Tom猫');[[NEWLINE]]cat.catchMouse();// Tom猫正在捉老鼠[[NEWLINE]]`

细心的同学可能会发现, 在Cat 类中没有构造函数, 这里有一个小的知识点，就是ES6的继承方法中如果子类没有写构造函数的话就一般默认添加构造。举个例子。

`classCatextendsAnimal{[[NEWLINE]]}[[NEWLINE]]// 等同于[[NEWLINE]]classCatextendsAnimal{[[NEWLINE]]constructor(name) {[[NEWLINE]]super(name);[[NEWLINE]]//super作为函数调用时，代表父类的构造函数。[[NEWLINE]] }[[NEWLINE]]}[[NEWLINE]]`

**> 注意**> ：如果我写了构造函数但是没有写super的话，或者super方法的参数不对等等，编译器都会报错。

1. 原型继承

在ES6之前，也有很多继承的方法，其中一个很常用的方法就是使用原型继承。其基本方法就是一个父类的实例赋值给子类的原型。这个继承方式是通过`__proto__`建立和子类之间的原型链，当子类的实例需要使用父类的属性和方法的时候，可以通过`__proto__`一级级向上找；

`functionAnimal(name) {[[NEWLINE]]this.name = name;[[NEWLINE]]}[[NEWLINE]][[NEWLINE]]Animal.prototype.eat= function () {[[NEWLINE]]console.log(this.name + '正在吃东西')[[NEWLINE]]};[[NEWLINE]]functionCat(furColor){[[NEWLINE]]this.furColor = furColor ;[[NEWLINE]]};[[NEWLINE]]Cat.prototype = new Animal();[[NEWLINE]]let tom = new Cat('black');[[NEWLINE]]console.log(tom)[[NEWLINE]]`

**> 缺点**> : 1. 子类实例时，无法向父类构造函数传参。2. 父类的私有属性被所有实例共享

call、apply、bind之间的关系

> 这又是一个面试经典问题, 也是ES5中众多坑中的一个，在 ES6 中可能会极大避免 this 产生的错误，但是为了一些老代码的维护，最好还是了解一下 this 的指向和 call、apply、bind 三者的区别.

bind,apply,call三者都可以用来改变`this`的指向, 下面分别对他们进行比较分析:

##### apply 和 call

- 二者都是Function对象的方法, 每个函数都能调用
- 二者的第一个参数都是你要指定的执行上下文
- apply 和 call 的区别是: call 方法接受的是若干个参数列表，而 apply 接收的是一个包含多个参数的数组。

`var a ={[[NEWLINE]]name : "Cherry",[[NEWLINE]]fn : function (a,b) {[[NEWLINE]]console.log( a + b)[[NEWLINE]] }[[NEWLINE]]}[[NEWLINE]]var b = a.fn;[[NEWLINE]]b.apply(a,[1,2]) // 3[[NEWLINE]]b.call(a, 4,5,6) // 15[[NEWLINE]]`

我们常常使用的验证是否是数组(前提是toString()方法没有被重写过):

`functionisArray(obj){[[NEWLINE]]returnObject.prototype.toString.call(obj) === '[object Array]' ;[[NEWLINE]]}[[NEWLINE]]`

#####

##### bind 与 apply、call区别

`var a ={[[NEWLINE]]name : "Cherry",[[NEWLINE]]fn : function (a,b) {[[NEWLINE]]console.log( a + b)[[NEWLINE]] }[[NEWLINE]] }[[NEWLINE]]var b = a.fn;[[NEWLINE]] b.bind(a,1,2)(); // 3[[NEWLINE]]`

我们发现`bind()`方法还需要调用一次; 是由于 `bind()`方法创建一个新的函数,我们必须手动去调用。

##### bind,apply,call的共同和不同点：

- 三者都可以用来改变`this`的指向
- 三者第一个参数都是this要指向的对象，也就是想指定的上下文，上下文就是指调用函数的那个对象。（点前的那个对象，没有就是全局window）
- 三者都可以传参，但是apply是数组，而call是有顺序的传入
- bind 是返回对应函数，便于稍后调用；apply 、call 则是立即执行

Promise

> 前端面试过程中，基本都会问到 Promise，如果你足够幸运，面试官问的比较浅，仅仅问 Promise 的使用方式，那么恭喜你。事实上，大多数人并没有那么幸运, 很多面试官在promise这块都是由浅入深的提问.

了解Promise吗?
Promise 解决了什么问题？
Promise 如何使用？
Promise 常用的方法有哪些？它们的作用是什么？
Promise 在事件循环中的执行过程是怎样的？

##### 1. 了解Promise吗?

所谓Promise，简单说就是一个容器，里面保存着某个未来才会结束的事件的结果。从语法上说，Promise 是一个对象，从它可以获取异步操作的消息。Promise 提供统一的 API，各种异步操作都可以用同样的方法进行处理，让开发者不用再关注于时序和底层的结果。Promise的状态具有不受外界影响和不可逆两个特点。

###### 2.Promise 解决了什么问题?

Promise解决了回调地狱的问题, 提高代码的可读性以及解决信任度问题. 传统的回调有五大信任问题:
1. 调用回调过早
2. 调用回调过晚(或者没有被调用)
3. 调用回调次数过多或过少
4. 未能传递所需的环境和参数
5. 涂掉可能出现的错误和异常

###### 3. Promise 如何使用?

ES6规定，Promise对象是一个构造函数，用来生成Promise实例。下面代码创造了一个Promise实例。

`var promise = newPromise(function(resolve, reject) {[[NEWLINE]]// ... some code[[NEWLINE]][[NEWLINE]]if (/* 异步操作成功 */){[[NEWLINE]] resolve(value);[[NEWLINE]] } else {[[NEWLINE]] reject(error);[[NEWLINE]] }[[NEWLINE]]});[[NEWLINE]]`

Promise构造函数接受一个函数作为参数，该函数的两个参数分别是`resolve`和`reject`。它们是两个函数，由JavaScript引擎提供，不用自己部署。

`resolve`函数的作用是，将Promise对象的状态从“未完成”变为“成功”（即从`Pending`变为`Resolved`），在异步操作成功时调用，并将异步操作的结果，作为参数传递出去；`reject`函数的作用是，将Promise对象的状态从“未完成”变为“失败”（即从`Pending`变为`Rejected`），在异步操作失败时调用，并将异步操作报出的错误，作为参数传递出去。

##### 4. Promise 常用的方法有哪些？它们的作用是什么？

- Promise.prototype.then

Promise 实例具有`then`方法，也就是说，`then`方法是定义在原型对象`Promise.prototype`上的。它的作用是为 Promise 实例添加状态改变时的回调函数。`then`方法的第一个参数是`resolved`状态的回调函数，第二个参数（可选）是`rejected`状态的回调函数。

- Promise.prototype.catch

`Promise.prototype.catch`方法是`.then(null, rejection)`或`.then(undefined, rejection)`的别名，用于指定发生错误时的回调函数。

`getJSON('/posts.json').then(function(posts) {[[NEWLINE]]// ...[[NEWLINE]]}).catch(function(error) {[[NEWLINE]]// 处理 getJSON 和 前一个回调函数运行时发生的错误[[NEWLINE]]console.log('发生错误！', error);[[NEWLINE]]});[[NEWLINE]]`

上面代码中，`getJSON`方法返回一个 Promise 对象，如果该对象状态变为`resolved`，则会调用`then`方法指定的回调函数；如果异步操作抛出错误，状态就会变为`rejected`，就会调用`catch`方法指定的回调函数，处理这个错误。

- Promise.all

`Promise.all`方法用于将多个 Promise 实例，包装成一个新的 Promise 实例, 返回最先执行结束的 Promise 任务的结果，不管这个 Promise 结果是成功还是失败。

- Promise.race

`Promise.race`方法同样是将多个 Promise 实例，包装成一个新的 Promise 实例。如果全部成功执行，则以数组的方式返回所有 Promise 任务的执行结果。如果有一个 Promise 任务 `rejected`，则只返回 `rejected` 任务的结果。

##### 5. Promise 在事件循环中的执行过程是怎样的

`var promise = newPromise((resolve, reject)=>{[[NEWLINE]]console.log('我是promise任务');[[NEWLINE]] resolve('resolved')[[NEWLINE]] })[[NEWLINE]] promise.then(res =>{[[NEWLINE]]console.log(res)[[NEWLINE]] })[[NEWLINE]]console.log("我是同步任务");[[NEWLINE]] setTimeout(()=>{[[NEWLINE]]console.log("我是延时任务");[[NEWLINE]] }, 0)[[NEWLINE]]`

上面代码的执行顺序是: 我是promise任务、我是同步任务、resolved、我是延时任务。

Promise 新建后立即执行，立即 `resolve` 的 Promise 对象，是在本轮“事件循环”（event loop）的结束时,而不是在下一轮“事件循环”的开始时;setTimeout在下一轮“事件循环”开始时执行。

#### 总结

在面试中, 很多问题并没有真正的答案,至于知识点能掌握到什么样的程度,都需要靠自己不断的学习积累, 在开发中不断的使用也是加深对知识点理解的方式。由于个人精力有限，只是针对一些常遇到的面试题，做了一些浅显的答案解析，希望对大家有所帮助吧。

觉得本文对你有帮助？请分享给更多人

[ 文章转载自公众号 ![程序员成长指北](../_resources/167c7aac891654428f3e6f56c81356aa.jpg)** 程序员成长指北 **](https://mp.weixin.qq.com/s?__biz=Mzg5ODA5NTM1Mw==&mid=2247484066&idx=1&sn=8e48fdf23068a62846a73dfa108f6b1b&chksm=c0668334f7110a2216698b560210cc854b409a5eb239f3c165927912d5434883e78ba751a5cd&mpshare=1&scene=1&srcid=##)