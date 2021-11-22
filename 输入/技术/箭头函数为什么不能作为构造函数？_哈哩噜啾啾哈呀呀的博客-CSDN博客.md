箭头函数为什么不能作为构造函数？_哈哩噜啾啾哈呀呀的博客-CSDN博客

# 箭头函数为什么不能作为构造函数？

 ![original.png](../_resources/b249bfd5f16517851c298da1f3d78336.png)

 [哈哩噜啾啾哈呀呀](https://me.csdn.net/weixin_42798473)  2020-04-04 22:47:03  ![articleReadEyes.png](../_resources/8641dfdb0ca157cac9ce789182fe77a1.png)  2345  [![tobarCollect.png](../_resources/3e7c8f7db9a8bbfcaf5f35d2673ef659.png)  收藏   7]()

 分类专栏：  [code随手笔记](https://blog.csdn.net/weixin_42798473/category_9870609.html)

 [版权]()

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' style='display: none%3b' class='js-evernote-checked' data-evernote-id='1634'%3e %3cpath stroke-linecap='round' d='M5%2c0 0%2c2.5 5%2c5z' id='raphael-marker-block' style='-webkit-tap-highlight-color: rgba(0%2c 0%2c 0%2c 0)%3b' class='js-evernote-checked' data-evernote-id='1635'%3e%3c/path%3e %3c/svg%3e)

>

> 在电话面试中，被问到箭头函数和普通函数的区别。这是常见面试题，我就按照我的理解回答常见答案：写法更简洁，没有this指向，this来自上下文，**> 不能作为构造函数**> ，这时候面试官追问，**> 为什么箭头函数不能作为构造函数？**

>

我之前对于这个问题的理解是，构造函数需要this这个对象，用于接收传来的参数，以及在构造函数最后将这个this return出去。箭头函数没有this，所以不能作为构造函数。

>

> 由于紧张，我的回答逻辑比较混乱，当然答案也不完全对，所以答的很不好，面试官对我的回答不太满意。继续追问，**那箭头函数能被new么？**不能作为构造函数肯定不能new啊，但我当时有点懵，想了一下才回答，应该不能吧。。。面试官看我犹豫，继续追问，**> 那箭头函数有原型函数么？**

>

其实整个过程面试官都是在引导我，但我由于当天面试状态特别差（也是第一次收到沟通电话同时就开始面试的），所以整个交流过程语无伦次，紧张异常，所以回答特别差，电话里就知道自己挂了。

现在回来复盘，打算从这个问题开始引申，将相关概念进行细致理解，概念解释都来自MDN。

整个问题大致包括以下几个概念：

1. 箭头函数
2. 构造函数
3. new运算符
4. 原型链

# 箭头函数

>

> **> [> 箭头函数表达式](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/Arrow_functions)> **的语法比> [> 函数表达式](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/function)> 更简洁，并且没有自己的> [> this](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/this)> ，> [> arguments](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/arguments)> ，> [> super](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/super)> 或> [> new.target](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/new.target)> 。箭头函数表达式更适用于那些本来需要匿名函数的地方，并且它不能用作构造函数。

>

从mdn的文档中可以看到：

- 没有单独的this
- 不绑定arguments
- 箭头函数不能用作构造器，和 new一起用会抛出错误
- 箭头函数没有prototype属性

。。。

这都是和普通函数或者构造函数的区别，我们可以通过打印箭头函数和构造函数来查看区别。

	function Fun(a) {
	    this.a = a;
	}
	
	let fun = (b) => {
	    this.b = b;
	}
	
	console.dir(Fun);
	console.log(Fun.a);
	console.dir(fun);
	console.log(fun.b);

- 1
- 2
- 3
- 4
- 5
- 6
- 7
- 8
- 9
- 10
- 11
- 12

![format,png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231115605.png)
 ![format,png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231115608.png)

- 从上面的运行结果也可以看到箭头函数与构造函数相比，缺少了很多东西，比如：caller，arguments，prototype，但同时也可以看到，箭头函数是有__proto__属性的，所以箭头函数本身是存在原型链的，他也是有自己的构造函数的，但是原型链到箭头函数这一环就停止了，因为它自己没有prototype属性，没法让他的实例的__proto__属性指向，所以箭头函数也就无法作为构造函数。
- 同时我们可以看到，由于箭头函数没有自己的this指针，通过 call() 或 apply() 方法调用一个函数时，只能传递参数，不能绑定this，所以call()和apply()的第一个参数会被忽略。

* * *

MDN的介绍中的有一句**箭头函数表达式更适用于那些本来需要匿名函数的地方**，那么

## 匿名函数能作为构造函数么？

这里可以做一个简单的测试代码

	*// 定义构造函数*
	function Fun(a){
	    this.a = a
	}
	*// 定义匿名函数并赋予变量*
	let fun = function(b){
	    this.b = b;
	}
	*// 对构造函数实例化*
	let f1 = new Fun(1);
	let f2 = new fun(2);
	
	*// 打印结果*
	console.dir(Fun);
	console.dir(f1);
	console.log(f1.a);
	console.dir(fun);
	console.dir(f2);
	console.log(f2.b);

- 1
- 2
- 3
- 4
- 5
- 6
- 7
- 8
- 9
- 10
- 11
- 12
- 13
- 14
- 15
- 16
- 17
- 18
- 19

![format,png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231115613.png)
 ![format,png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231115617.png)

从执行结果可以看出，两个函数结果，除了变量（name，a，b）不同外，函数结构没有任何区别，所以答案是**可以**。

- 匿名函数因为被赋值给了一个变量，所以在这里可以被看作是普通函数，在这个案例中普通函数和构造函数没有区别

 [javascript中 ”匿名函数赋值给变量“与“直接命名函数”有什么不同？](https://zhidao.baidu.com/question/556156293313421132.html)

- **构造函数和普通函数不是通过函数名首字母的大小写来区分的，而是通过调用方式来区分的，即new运算符，首字母大写只是约定的习惯。**

 [JS 中构造函数和普通函数的区别](https://blog.csdn.net/weixin_41796631/article/details/82939585)

# 构造函数和new运算符

从以上可以看出，构造函数可以说是和new运算符搭配使用的，所以可以通过new运算符的运行过程来看看构造函数

>

> [> new 运算符](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/new)> 创建一个用户定义的对象类型的实例或具有构造函数的内置对象的实例。new 关键字会进行如下的操作：

>
1. > 创建一个空的简单JavaScript对象（即{}）；
2. > 链接该对象（即设置该对象的构造函数）到另一个对象 ；
3. > 将步骤1新创建的对象作为this的上下文 ；
4. > 如果该函数没有返回对象，则返回this。
>

	function Fun(a){
	    this.a = a;
	}
	
	let fun = new Fun(1);
	
	{*// new的执行过程*
	var this = {} *//定义一个空的this变量*
	this.__proto__ = Fun.prototype *//将实例对象的_proto_属性指向构造函数的原型*
	Fun(1).call(this) *//将实参带入构造函数，并将构造函数this的指向改为创建的this对象。*
	return this *//返回这个刚创建的this对象，并赋值给fun变量。*
	}
	*// 一般情况下，构造函数内不写返回值，返回这个this对象，*
	*// 但是用户可以选择主动返回对象，来覆盖正常的对象创建步骤*

- 1
- 2
- 3
- 4
- 5
- 6
- 7
- 8
- 9
- 10
- 11
- 12
- 13
- 14

由此可以再一次看出，如果箭头函数能作为构造函数，能够使用new运算符，那么整个过程中，无论是this对象，prototype属性还是call()函数进行this绑定都无法处理，所以对箭头函数使用new运算符会抛出Error

# 箭头函数有原型函数么？

![format,png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231115622.png)
这里的原型函数应该就是指构造函数的显示原型属性，或者更准确的说法是**箭头函数有它的构造函数么？**

>

- > 所有的引用类型都有__ proto __属性
- > 只有函数对象有prototype属性
- > 所有的引用类型的__ proto __属性值均指向它的构造函数的prototype的属性值
- > 当试图得到一个对象的某个属性时，如果这个对象本身没有这个属性，那么会去他的__ proto __(即它的构造函数的prototype）中寻找

>

所以显然**箭头函数是有构造函数的**，但特别的是，它作为一个函数，它是没有prototype属性的。