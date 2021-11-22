从一个简单例子来理解js引用类型指针的工作方式 - vajoy - 博客园

#   [从一个简单例子来理解js引用类型指针的工作方式](https://www.cnblogs.com/vajoy/p/3703859.html)

posted @ 2014-05-02 11:51 [vajoy](https://www.cnblogs.com/vajoy/)  阅读(6555)  评论(26) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=3703859) [收藏](从一个简单例子来理解js引用类型指针的工作方式%20-%20vajoy%20-%20博客园.md#)



上面的例子看似简单，但结果并不好了解，很容易把人们给想绕了——“a.x不是指向对象a了么？为啥log(a.x)是undefined?”、“b.x不是应该跟a.x是一样的么？为啥log出来居然有2个对象”

当然各位可以先自行理解一下，若能看出其中的原因和工作机理自然就无须继续往下看啦。

下面来分析下这段简单代码的工作步骤，从而进一步理解js引用类型“赋值”的工作方式。

首先是
**var a = {n:1};  **
**var b = a;**
在这里a指向了一个对象{n:1}（我们姑且称它为对象A），b指向了a所指向的对象，也就是说，在这时候a和b都是指向对象A的：
![b109c0332270c9e4d53bf8a46ff2ba07.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231101511.jpg)
这一步很好理解，接着继续看下一行非常重要的代码：
**a.x = a = {n:2};**
我们知道js的赋值运算顺序永远都是从右往左的，不过由于“.”是优先级最高的运算符，所以这行代码先“计算”了a.x。
这时候发生了这个事情——a指向的对象{n:1}新增了属性x（虽然这个x是undefined的）：
![d98082fa9a868ac7fa78f952645f19ee.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231101516.jpg)
从图上可以看到，由于b跟a一样是指向对象A的，要表示A的x属性除了用a.x，自然也可以使用b.x来表示了。
接着，依循“从右往左”的赋值运算顺序先执行 a={n:2} ，这时候，a指向的对象发生了改变，变成了新对象{n:2}（我们称为对象B）：
![1992921b87c66f9f58c0fe8a243baa04.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231101524.jpg)
接着继续执行 a.x=a，很多人会认为这里是“对象B也新增了一个属性x，并指向对象B自己”

但实际上并非如此，由于一开始js已经先计算了a.x，便已经解析了这个a.x是对象A的x，所以在同一条公式的情况下再回来给a.x赋值，也不会说重新解析这个a.x为对象B的x。

所以 a.x=a 应理解为对象A的属性x指向了对象B:
![a9464818f1aef13a01abe0d86a993b38.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231101532.jpg)

那么这时候结果就显而易见了。当**console.log(a.x)**的时候，a是指向对象B的，但对象B没有属性x。没关系，当查找一个对象的属性时，JavaScript 会向上遍历原型链，直到找到给定名称的属性为止。但当查找到达原型链的顶部 - 也就是 Object.prototype - 仍然没有找到指定的属性B.prototype.x，自然也就输出undefined；

而在**console.log(b.x)**的时候，由于b.x表示对象A的x属性，该属性是指向对象B，自然也输出了[object Object]了，注意这里的[object Object]可不是2个对象的意思，对象的字符串形式，是隐式调用了Object对象的toString()方法，形式是："[object Object]"。所以[object Object]表示的就只是一个对象罢了:)

以上纯粹为个人对js引用类型工作方式的理解，若有不对的地方请指出谢谢 :)

[(L)](从一个简单例子来理解js引用类型指针的工作方式%20-%20vajoy%20-%20博客园.md#)
分类: [JS](https://www.cnblogs.com/vajoy/category/558864.html)

 [«](https://www.cnblogs.com/vajoy/p/3687419.html) 上一篇： [仿京东首页商品分类底部色标随鼠标移动特效](https://www.cnblogs.com/vajoy/p/3687419.html)

 [»](https://www.cnblogs.com/vajoy/p/3705126.html) 下一篇： [图解js中常用的判断浏览器窗体、用户屏幕可视区域大小位置的方法](https://www.cnblogs.com/vajoy/p/3705126.html)