JavaScript中Constructor的陷阱与技巧 - 知乎专栏·「What Matters」

# JavaScript中Constructor的陷阱与技巧

6 个月前 · 来自专栏 [What Matters](https://www.zhihu.com/column/what-matters)
本文代码可运行在 node.js v13.9.0上，其它版本请读者自行检查。

一般创建新对象时，我们使用 **{...}** 语法就足够了：
`const cat = {  name: 'Tom'};const mouse = {  name: 'Jerry',};`

但当对象创建的逻辑比较复杂，且需要复用这些逻辑以创建更多类似的对象时，我们倾向于使用 **Constructor函数** 进行封装。一个 **Constructor函数** 看起来和普通的函数区别不大，只是前者的函数名习惯上以大写字母开头，以区别于普通函数：

`function Animal(name) {  *// your logic goes here***}`
然后需要在创建 Animal 对象的地方，使用 new 操作符进行调用：
`const pig = new Animal("Piggy");`

### 第一个陷阱，忘了使用 new 怎么办？

对于以下函数：
`function Animal(name) {  this.name;}`

首先要知道，若使用 **new Animal()** 调用，则函数内 **this** 指向的是新创建的对象；若使用 Animal() 调用，则 **this** 遵循普通函数的 this 定义(比如在浏览器中指向 window 对象)。

解决这个问题，通常有两个办法：
1. 1借助 ***instanceof*** 操作符，因为 new 调用中 ***this*** ，是构造函数创建的实例。

`function Animal(name) {  if (!(this instanceof Animal)) {    *// 如果当成普通方法调用***    *// 则返回一个new调用的对象***    return new Animal(name);  }  this.name;}`

2. 使用新语法中引入的 ***[new.target](https://link.zhihu.com/?target=http%3A//new.target)  ***。如果是 new 调用，则函数内 ***[new.target](https://link.zhihu.com/?target=http%3A//new.target)*** 指向构造函数；否则其值为 undefined。

`function Animal(name) {  if (!new.target) {    return new Animal(name);  }  this.name;}`

要注意的是，***new*** 在这里是一个**虚拟对象**，任何其它对 ***new*** 的使用都会报错：

`function Animal(name) {  if (!new.target) {    return new Animal(name);  }  console.log(new.abc); *// 报错***  new.xyz = 3;*// 报错***  this.name;}`

### 二、对构造函数进行 bind 操作会发生什么？

我们对函数进行 ***bind*** 操作，可以返回一个绑定的固定 ***this*** 的新函数。那么，对一个构造函数进行 ***bind*** 操作，再使用 ***new*** 调用，会发生什么？：

`function Animal(name) {  this.name = name;}const bound = Animal.bind({hello: 'world'});*// animal 是什么？***const animal = new bound('Tom');`

你可能会以为，此时的 animal 像下面这样(因为 ***this*** 绑定给了 ***bind*** 的第一个参数上)：
`const animal = {  name: 'Tom',  hello: 'world'};`

下面是在开发工具中调试的结果：

![](data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='646' height='332'></svg>)

我们看到，只有一个 ***name*** 属性。
结论是，***bind 操作不能改变构造函数内的 this。***函数使用 new 调用后，其内部的 ***this*** 永远都指向新创建的那个对象。
关于 bind 函数，我在公众号上有两篇深入探讨的文章，感兴趣可以看看：

[ECMAScript Bound Functions (Function.prototype.bind) 笔记(一)​mp.weixin.qq.com![18c7af096e7703c9a1c62800b7cd2490.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108145311.jpg)](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s/soAWbndILE6gR3020LO_Aw)[ECMAScript Bound Functions (Function.prototype.bind) 笔记(二)​mp.weixin.qq.com![6405669fa560872232a52759233af963.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108145315.jpg)](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s/RWTZBg0yZhKvTUOnzJS_0g)

### 三、构造函数内return语句的影响

如果我们在构造函数内显式调用了 return 语句：
`function Animal(name) {  this.name = name;  return 1;}`

**new** 调用的实际返回值就要视情况而定。如果返回的是一个基础类型(primitive types，如数字、布尔、null等)，则 **new** 调用不受影响；否则，**new** 调用返回的是 **return** 的对象。

`function Animal(name) {  this.name = name;  return 1;}*// 此时 animal 是 {name: 'Tom'}***const animal = new Animal('Tom');`

`function Animal(name) {  this.name = name;  return {hello: 'world'}}*// 此时 animal 是 {hello: 'world'}***const animal = new Animal('Tom');`

* * *

文章参考：

1. 1[Constructor, operator "new"](https://link.zhihu.com/?target=https%3A//javascript.info/constructor-new)

2. 2[You can detect when `new` is used to call a function](https://link.zhihu.com/?target=https%3A//twitter.com/joelnet/status/1237415451925381120%3Fs%3D20)

发布于 03-13
[JavaScript](https://www.zhihu.com/topic/19552521)
[JavaScript 编程](https://www.zhihu.com/topic/20052034)
[前端开发](https://www.zhihu.com/topic/19550901)