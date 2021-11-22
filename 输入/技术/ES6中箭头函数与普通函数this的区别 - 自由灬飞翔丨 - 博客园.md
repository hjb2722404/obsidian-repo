ES6中箭头函数与普通函数this的区别 - 自由灬飞翔丨 - 博客园

# [ES6中箭头函数与普通函数this的区别](https://www.cnblogs.com/freelyflying/p/6978126.html)

**普通函数中的this:**
1. this总是代表它的直接调用者, 例如 obj.func ,那么func中的this就是obj
2.在默认情况(非严格模式下,未使用 'use strict'),没找到直接调用者,则this指的是 window
3.在严格模式下,没有直接调用者的函数中的this是 undefined
4.使用call,apply,bind(ES5新增)绑定的,this指的是 绑定的对象
**箭头函数中的this**
默认指向在定义它时,它所处的对象,而不是执行时的对象, 定义它的时候,可能环境是window（即继承父级的this）;
下面通过一些例子来研究一下 this的一些使用场景
**示例1**
1
2
3
4
5
6
7
8
9
10
[object Object]
[object Object][object Object]  [object Object]
[object Object][object Object][object Object]  [object Object]
[object Object][object Object][object Object]  [object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]

结果是：window
匿名函数,定时器中的函数,由于没有默认的宿主对象,所以默认this指向window
问题: 如果想要在setTimeout中使用这个对象的引用呢?
用一个 变量提前把正确的 this引用保存 起来, 我们通常使用that = this, 或者 _this = this来保存我们需要的this指针!
1
2
3
4
5
6
7
8
9
10
11
12
13
[object Object]
[object Object][object Object]  [object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object][object Object]  [object Object]

[object Object][object Object]  [object Object][object Object][object Object][object Object]

[object Object][object Object][object Object]  [object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]

**示例2**
1
2
3
4
5
6
7
8
9
10
11
12
13
14
[object Object]
[object Object]  [object Object]
[object Object][object Object]
[object Object][object Object][object Object]  [object Object]
[object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object]
[object Object]
[object Object]
[object Object]  [object Object]
[object Object]

结果是：2  4  8  8
<1> 12行代码调用
val变量在没有指定对象前缀,默认从函数中找,找不到则从window中找全局变量
即 val *=2 就是 window.val *= 2
this.val默认指的是 obj.val ;因为 dbl()第一次被obj直接调用
<2>14行代码调用
func() 没有任何前缀,类似于全局函数,即  window.func调用,所以
第二次调用的时候, this指的是window, val指的是window.val
第二次的结果受第一次的影响
**示例3.在严格模式下的this**
1
2
3
4
5
6
7
[object Object]
[object Object][object Object]  [object Object]
[object Object][object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]
结果是：undefined
**示例4.箭头函数中的this**
1
2
3
4
5
6
7
8
9
10
[object Object]
[object Object][object Object]  [object Object]
[object Object][object Object][object Object]  [object Object]
[object Object][object Object]
[object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object]
[object Object]
　此时的this是定义它的对象，即继承父级的this,父级中的this指的是obj,而非window
**示例5**
1
2
3
4
5
6
7
8
9
10
11
12
13
14
[object Object]
[object Object][object Object]  [object Object]
[object Object][object Object][object Object]  [object Object]
[object Object][object Object]  [object Object]
[object Object][object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]
结果：都是obj
f1继承父级this指代的obj，不管f1有多层箭头函数嵌套，都是obj.
**示例6**
1
2
3
4
5
6
7
8
9
10
11
12
13
14
[object Object]
[object Object][object Object]  [object Object]
[object Object][object Object][object Object]  [object Object]
[object Object][object Object]  [object Object][object Object]  [object Object]
[object Object][object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object][object Object][object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object][object Object]
[object Object]
结果：window,window
第一个this：f1调用时没有宿主对象，默认是window
第二个this:继承父级的this,父级的this指代的是window.

分类: [javascript](https://www.cnblogs.com/freelyflying/category/862554.html)

 [好文要顶](ES6中箭头函数与普通函数this的区别%20-%20自由灬飞翔丨%20-%20博客园.md#)  [关注我](ES6中箭头函数与普通函数this的区别%20-%20自由灬飞翔丨%20-%20博客园.md#)  [收藏该文](ES6中箭头函数与普通函数this的区别%20-%20自由灬飞翔丨%20-%20博客园.md#)  [![icon_weibo_24.png](ES6中箭头函数与普通函数this的区别%20-%20自由灬飞翔丨%20-%20博客园.md#)  [![wechat.png](ES6中箭头函数与普通函数this的区别%20-%20自由灬飞翔丨%20-%20博客园.md#)

 [![20160803174831.png](../_resources/1ed042731250a6a77d754427c1beddc0.jpg)](http://home.cnblogs.com/u/freelyflying/)

 [自由灬飞翔丨](http://home.cnblogs.com/u/freelyflying/)
 [关注 - 1](http://home.cnblogs.com/u/freelyflying/followees)
 [粉丝 - 6](http://home.cnblogs.com/u/freelyflying/followers)

 [+加关注](ES6中箭头函数与普通函数this的区别%20-%20自由灬飞翔丨%20-%20博客园.md#)

 0

 0

[«](https://www.cnblogs.com/freelyflying/p/6931064.html) 上一篇：[微信小程序学习笔记](https://www.cnblogs.com/freelyflying/p/6931064.html)

[»](https://www.cnblogs.com/freelyflying/p/7008072.html) 下一篇：[php类中的$this，static，const，self这几个关键字使用方法](https://www.cnblogs.com/freelyflying/p/7008072.html)

posted @ 2017-06-10 11:02  [自由灬飞翔丨](https://www.cnblogs.com/freelyflying/) 阅读(12713) 评论(1) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=6978126)  [收藏](https://www.cnblogs.com/freelyflying/p/6978126.html#)