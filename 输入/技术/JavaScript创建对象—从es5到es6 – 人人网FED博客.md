JavaScript创建对象—从es5到es6 – 人人网FED博客

# [人人网FED博客](https://fed.renren.com/)

## 专注于前端技术

# JavaScript创建对象—从es5到es6

[2017年8月7日](https://fed.renren.com/2017/08/07/js-oop-es52es6/)  [Dolanf](https://fed.renren.com/author/dolanf/)

本文主要讲述了使用JavaScript创建对象的几种方式，分别是传统的Object构造函数、对象字面量、工厂模式、构造函数模式、原型模式、组合模式，以及es6的class定义类。然后从babel的角度探究es5与es6创建对象的区别。

## 1.创建对象的几种方式

es6出现之前，ECMAScript中是没有类的概念的，对象的实例化都是通过调用function声明的构造函数实现。es6出现之后，才有了使用class定义类的方式。以下介绍几种js中创建对象的方式：

### （1）Object构造函数和对象字面量

在早期js开发中，很多开发者会使用Object构造函数的方式来创建一个对象，通过调用Object构造函数new一个Object对象，然后再给这个对象的每一个属性和方法进行赋值，代码如下所示：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | var  person  =  new  Object();<br>person.age  =  22;<br>person.name  =  'Dolanf';<br>person.code  =  function()  {<br>  console.log(‘hello world！’);<br>}; |

后来出现了对象字面量的写法，由于使用对象字面量创建对象的写法简单直观，所以Object构造函数写法渐渐被对象字面量的写法所取代，对象字面量是通过在一个大括号里面使用键值对的方式表示每一个属性和方法，每一个键值对之间使用逗号隔开，代码如下所示：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7 | var  person  =  {<br>    age:  22,<br>    name:  'Dolanf',<br>    code:  function()  {<br>         console.log('hello world!');<br>    }<br>} |

虽然对象字面量简单直观，但是上面两种方法都存在一个共同的问题：当需要创建很多很多个Person对象的时候，只能一个一个去创建，每一个对象的方法和属性都需要单独写，这使得代码没有丝毫复用性可言，违背了对象封装的特性。于是乎，工厂模式就随之出现了。

### （2）工厂模式

工厂模式通过将对象的创建封装到一个方法中，再通过在调用该方法时传入参数而实现对象的实例化，解决了以上提到的产生大量重复代码的问题，如下所示：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13 | function  createPerson(age,  name)  {<br>    var  o  =  new  Object();<br>    o.age  =  age;<br>    o.name  =  name;<br>    o.code  =  function()  {<br>         console.log('hello world!');<br>    };<br>    return  o;<br>}<br>var  person1  =  createPerson(11,  '小白');<br>var  person2  =  createPerson(12,  '小黑'); |

但是工厂模式也存在一个不足，就是通过该方法创建的对象的构造函数全都是Object，没有辨识度。没有办法通过构造函数辨别一个对象到底是Person还是Dog，亦或是Cat。于是乎，为了解决这个问题，就引入了构造函数模式。

### （3）构造函数模式

构造函数模式就是通过定义一个function函数，然后通过this给对象的属性和方法进行赋值。当我们实例化对象时，只需在该函数前面加一个new关键字就可以了。

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10 | function  Person(age,  name)  {<br>    this.age  =  age;<br>    this.name  =  name;<br>    this.code  =  function()  {<br>         console.log('hello world!');<br>    };<br>}<br>var  person1  =  new  Person(11,  '小白');<br>var  person2  =  new  Person(12,  '小黑'); |

构造函数模式解决了工厂模式中的对象识别问题，通过：

JavaScript

|     |     |
| --- | --- |
| 1   | console.log(person1 instanceof  Person);  *// true* |

可以看出person1能成功被识别为一个Person对象。

但是，构造函数模式也同样存在一个缺点，就是构造函数里的属性和方法在每个对象上都要实例化一遍，包括对象共用的属性和方法，这样就造成了代码的复用性差的问题。所以大多数人会考虑将构造函数模式和原型模式组合起来使用。在这里先介绍一下原型模式。

### （4）原型模式

原型模式是通过将所有的属性和方法都定义在其prototype属性上，达到这些属性和方法能被所有的实例所共享的目的。代码如下所示：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10 | function  Person(age,  name)  {<br>    Person.prototype.age  =  age;<br>    Person.prototype.name  =  name;<br>    Person.prototype.code  =  function()  {<br>         console.log('hello world！');<br>    };<br>}<br>var  person1  =  new  Person();<br>var  person2  =  new  Person(); |

当然，这种方法在项目开发中是没有人会使用的，因为当一个对象上的属性改变时，所有对象上的属性也会随之改变，这是非常不切实际的。至于原型模式的原理，会在下一篇的原型链中解释。在这里提及原型模式是为了介绍以下的构造函数+原型组合模式：

### （5）构造函数+原型组合模式

组合模式是将构造函数模式和原型模式结合在一起，继承了它们优点的同时又避免了各自的缺点。它将具有各自特点的属性和方法定义在构造函数中，将实例间共享的属性和方法定义在prototype上，成为了在es6出现之前使用最普遍的一种创建对象模式。

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15 | function  Person(age,  name)  {<br>    this.age  =  age;<br>    this.name  =  name;<br>    this.cry  =  function()  {<br>         console.log(name  +  'is crying!!! T^T');<br>    }<br>}<br>Person.prototype  =  {<br>    constructor:  Person,<br>    sayName:  function()  {<br>        console.log(this.name);<br>    }<br>}<br>var  person1  =  new  Person(11,  '小白');<br>var  person2  =  new  Person(12,  '小黑'); |

### （6）class定义类

当然，前面讲的都是浮云，现在大家都用class定义类啦，class的出现就是为了让定义类能更加简单。回到上面的Person构造函数上，我们现在将其改造成使用class定义的方式：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14 | class  Person{<br>    constructor(age,  name)  {<br>        this.age  =  age;<br>        this.name  =  name;<br>        this.cry  =  function()  {<br>         console.log(name  +  'is crying!!! T^T');<br>        }<br>    }<br>    sayName()  {<br>        console.log(this.name);<br>    }<br>}<br>var  person1  =  new  Person(11,  '小白');<br>var  person2  =  new  Person(12,  '小黑'); |

使用class定义类跟上面的构造函数+原型组合模式有一些相似之处，但又有所区别。
class定义的类上有个constructor方法，这就是构造方法，该方法会返回一个实例对象，this代表的就是实例对象，这跟上边的构造函数模式很类似。
此外，class上的方法都是定义在prototype上的，这又跟原型模式有一些相似之处，这个class里的sayName等价于

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3 | Person.protorype.sayName  =  function()  {<br>    console.log(this.name);<br>} |

虽然class定义的类跟es5中的构造函数+原型组合模式很相似，但是他们还是存在不少区别的，下面对比如下：

## 2.es5与es6定义对象的区别

1）class的构造函数必须使用new进行调用，普通构造函数不用new也可执行。
2）class不存在变量提升，es5中的function存在变量提升。
3）class内部定义的方法不可枚举，es5在prototype上定义的方法可以枚举。
为什么会存在以上这些区别呢？下面使用babel将es6转化成es5看看它的实现过程就知道了。

## 3.es6中class转化为es5

下面将讲述使用babel将以上的class定义Person类转换成使用es5实现：
**es6代码：**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14 | class  Person{<br>    constructor(age,  name)  {<br>        this.age  =  age;<br>        this.name  =  name;<br>        this.cry  =  function()  {<br>         console.log(name  +  'is crying!!! T^T');<br>        }<br>    }<br>    sayName()  {<br>        console.log(this.name);<br>    }<br>}<br>var  person1  =  new  Person(11,  '小白');<br>var  person2  =  new  Person(12,  '小黑'); |

**使用babel转化成的es5后的代码：**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21<br>22<br>23<br>24<br>25<br>26<br>27<br>28<br>29<br>30<br>31<br>32<br>33<br>34<br>35<br>36<br>37<br>38<br>39<br>40<br>41<br>42<br>43<br>44<br>45<br>46<br>47<br>48<br>49<br>50<br>51<br>52<br>53<br>54 | 'use strict';  *// es6中class使用的是严格模式*<br>*// 处理class中的方法*<br>var  _createClass  =  function  ()  {<br>   function  defineProperties(target,  props)  {<br>      for  (var  i  =  0;  i  <  props.length;  i++)  {<br>         var  descriptor  =  props[i];<br>         *// 默认不可枚举*<br>         descriptor.enumerable  =  descriptor.enumerable  \|\|  false;<br>         descriptor.configurable  =  true;<br>         if  ("value"  in  descriptor)  descriptor.writable  =  true;<br>         Object.defineProperty(target,  descriptor.key,  descriptor);<br>      }<br>   }<br>   return  function  (Constructor,  protoProps,  staticProps)  {<br>      if  (protoProps)  defineProperties(Constructor.prototype,  protoProps);<br>      if  (staticProps)  defineProperties(Constructor,  staticProps);<br>      return  Constructor;<br>   };<br>}();<br>*// 对构造函数进行判定*<br>function  _classCallCheck(instance,  Constructor)  {<br>   if  (!(instance instanceof  Constructor))  {<br>      throw  new  TypeError("Cannot call a class as a function");<br>   }<br>}<br>*// class Person转换为 es5的function*<br>var  Person  =  function  ()  {<br>    function  Person(age,  name)  {<br>        *// 调用了_classCallCheck检查Person是否为构造函数*<br>        _classCallCheck(this,  Person);<br>        this.age  =  age;<br>        this.name  =  name;<br>        this.cry  =  function  ()  {<br>            console.log(name  +  'is crying!!! T^T');<br>        };<br>    }<br>    *// 调用_createClass处理定义在class中的方法。*<br>    _createClass(Person,  [{<br>        key:  'sayName',<br>        value:  function  sayName()  {<br>            console.log(this.name);<br>        }<br>    }]);<br>    return  Person;<br>}();<br>var  person1  =  new  Person(11,  '小白');<br>var  person2  =  new  Person(12,  '小黑'); |

这里我将转换后的代码格式化并加上了一些注释。
从以上代码可以看出，class主要是通过两个函数实现：_createClass和_classCallCheck。
所以为什么会存在上述区别呢：
**1）class的构造函数必须使用new进行调用，普通构造函数不用new也可执行。**

class中的constructor会直接转化为function构造函数，然后在function中通过 _classCallCheck的检查该function是否是一个Constructor。因为有_classCallCheck检查必须是instanceof Constructor，所以class必须使用new进行调用。

**2）class不存在变量提升，es5中的function存在变量提升。 **
class转变成了函数表达式进行声明，因为是函数表达式声明的，所以class不存在变量提升。
**3）class内部定义的方法不可枚举，es5在prototype上定义的方法可以枚举。 **

class中定义的方法会传入 _createClass中，然后 Object.defineProperty将其定义在Constructor.prototype上。所以class中的方法都是定义在Constructor.prototype上的。

由于defineProperties中的

JavaScript

|     |     |
| --- | --- |
| 1   | descriptor.enumerable  =  descriptor.enumerable  \|\|  false; |

将属性的 enumerable默认为false，所以class中定义的方法不可枚举。
浏览量: 3,568

- [← 用AE + bodymovin制作html动画](https://fed.renren.com/2017/08/06/ae-bodymovin/)
- [HTML/CSS/JS编码规范 →](https://fed.renren.com/2017/08/20/html-css-js-code-specification/)

目录: [基础技术](https://fed.renren.com/category/basic/)

Tags: [class](https://fed.renren.com/tag/class/), [javascript](https://fed.renren.com/tag/javascript/), [对象创建](https://fed.renren.com/tag/%e5%af%b9%e8%b1%a1%e5%88%9b%e5%bb%ba/)

### 发表评论

电子邮件地址不会被公开。 必填项已用*标注
评论
姓名 *
电子邮件 *
站点

![ee441ea10b3325c7b63868513a6b881d.png](../_resources/9f82cc615fa3431cb20899dd7dff2b90.png)

###   近期文章

- [Chrome 66禁止声音自动播放之后](https://fed.renren.com/2018/05/13/audio-auto-play/)
- [用CSS Houdini画一片星空](https://fed.renren.com/2018/04/22/css-houdini/)
- [Vue实现内部组件轮播切换效果](https://fed.renren.com/2018/04/06/vue-component-slider/)
- [SVG导航下划线光标跟随效果](https://fed.renren.com/2018/03/31/svg-animate/)
- [怎么画一条0.5px的边（更新）](https://fed.renren.com/2018/03/24/half-of-one-px/)

###   近期评论

- [跨境电商导航](http://123.adoncn.com/)发表在《[前端本地文件操作与上传](https://fed.renren.com/2017/11/25/local-file-manage-upload/#comment-1238)》
- frwer发表在《[前端本地文件操作与上传](https://fed.renren.com/2017/11/25/local-file-manage-upload/#comment-1236)》
- jffun发表在《[巧用JS位运算](https://fed.renren.com/2018/03/06/js-bit-algorithm/#comment-1219)》
- *{display:none;}发表在《[Chrome 66禁止声音自动播放之后](https://fed.renren.com/2018/05/13/audio-auto-play/#comment-1218)》
- EthanXie发表在《[Vue实现内部组件轮播切换效果](https://fed.renren.com/2018/04/06/vue-component-slider/#comment-1045)》

###   文章归档

- [2018年五月](https://fed.renren.com/2018/05/)
- [2018年四月](https://fed.renren.com/2018/04/)
- [2018年三月](https://fed.renren.com/2018/03/)
- [2018年二月](https://fed.renren.com/2018/02/)
- [2018年一月](https://fed.renren.com/2018/01/)
- [2017年十二月](https://fed.renren.com/2017/12/)
- [2017年十一月](https://fed.renren.com/2017/11/)
- [2017年十月](https://fed.renren.com/2017/10/)
- [2017年九月](https://fed.renren.com/2017/09/)
- [2017年八月](https://fed.renren.com/2017/08/)
- [2017年七月](https://fed.renren.com/2017/07/)
- [2017年六月](https://fed.renren.com/2017/06/)
- [2017年五月](https://fed.renren.com/2017/05/)
- [2017年四月](https://fed.renren.com/2017/04/)
- [2017年三月](https://fed.renren.com/2017/03/)
- [2017年二月](https://fed.renren.com/2017/02/)
- [2017年一月](https://fed.renren.com/2017/01/)

###   分类目录

- [基础技术](https://fed.renren.com/category/basic/)
- [框架组件](https://fed.renren.com/category/components/)
- [页面优化](https://fed.renren.com/category/optimization/)

###   功能

- [注册](https://fed.renren.com/wp-login.php?action=register)
- [登录](https://fed.renren.com/wp-login.php)
- [文章RSS](https://fed.renren.com/feed/)
- [评论RSS](https://fed.renren.com/comments/feed/)