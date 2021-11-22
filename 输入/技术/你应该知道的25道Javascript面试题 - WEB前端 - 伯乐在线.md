你应该知道的25道Javascript面试题 - WEB前端 - 伯乐在线

# 你应该知道的25道Javascript面试题

分享到：[(L)](http://www.jiathis.com/share?uid=1745061)[14]()

本文作者： [伯乐在线](http://web.jobbole.com/) - [韩子迟](http://www.jobbole.com/members/hanzichi) 。未经作者许可，禁止转载！

欢迎加入伯乐在线[作者团队](http://group.jobbole.com/category/feedback/writer-team/)。

题目来自 [25 Essential JavaScript Interview Questions](http://www.toptal.com/javascript/interview-questions)。闲来无事，正好切一下。

# 一

* * *

What is a potential pitfall with using `typeof bar === "object"` to determine if bar is an object? How can this pitfall be avoided?

老生常谈的问题，用 `typeof` 是否能准确判断一个对象变量，答案是否定的，`null` 的结果也是 object，`Array` 的结果也是 object，有时候我们需要的是 “纯粹” 的 object 对象。

如何规避这个问题？

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7 | var  obj  =  {};<br>*// 1*<br>console.log((obj  !==  null)  &  (typeof obj  ===  "object")  &&  (toString.call(obj)  !==  "[object Array]"));<br>*// 2*<br>console.log(Object.prototype.toString.call(obj)  ===  "[object Object]"); |

# 二

* * *

What will the code below output to the console and why?

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | (function(){<br>  var  a  =  b  =  3;<br>})();<br>console.log("a defined? "  +  (typeof  a  !==  'undefined'));<br>console.log("b defined? "  +  (typeof  b  !==  'undefined')); |

这题不难，IIFE 中的赋值过程其实是（赋值过程从右到左）：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4 | (function(){<br>  b  =  3;<br>  var  a  =  b;<br>})(); |

接下去就不难了，a 是局部变量，b 是全局变量。

# 三

* * *

What will the code below output to the console and why?

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13 | var  myObject  =  {<br>    foo:  "bar",<br>    func:  function()  {<br>        var  self  =  this;<br>        console.log("outer func:  this.foo = "  +  this.foo);<br>        console.log("outer func:  self.foo = "  +  self.foo);<br>        (function()  {<br>            console.log("inner func:  this.foo = "  +  this.foo);<br>            console.log("inner func:  self.foo = "  +  self.foo);<br>        }());<br>    }<br>};<br>myObject.func(); |

前面两个输出没有问题，都是 bar，问题出在后面两个。用了 IIFE 后，匿名函数内的 this 其实已经指到了 window，所以第三个输出 this.foo 其实是 window.foo，而全局对象并没有 foo 这个 key，所以输出 undefined，而第四个输出，因为 self 引用了 myObject，所以还是 bar。

# 四

* * *

What is the significance of, and reason for, wrapping the entire content of a JavaScript source file in a function block?

为什么要用 IIFE？
简单来说就是为了能模块化，创建私有变量等等，很多类库（比如 jQuery）都用了这样的写法。

可以参考我以前翻译的一篇文章 [详解javascript立即执行函数表达式（IIFE）](http://www.cnblogs.com/zichi/p/4401755.html)

# 五

* * *

What is the significance, and what are the benefits, of including ‘use strict’ at the beginning of a JavaScript source file?

严格模式下进行 Javascript 开发有啥好处？

这个就不展开来了，可以参考阮一峰老师的 [Javascript 严格模式详解](http://www.ruanyifeng.com/blog/2013/01/javascript_strict_mode.html) 或者自行谷歌百度。

# 六

* * *

Consider the two functions below. Will they both return the same thing? Why or why not?

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14 | function  foo1()<br>{<br>  return  {<br>      bar:  "hello"<br>  };<br>}<br>function  foo2()<br>{<br>  return<br>  {<br>      bar:  "hello"<br>  };<br>} |

执行以上两个函数，会返回相同的东西吗？

不会，第二个函数会返回 `undefined`。这是由于 Javascript 的封号插入机制决定的，如果某行代码，return 关键词后没有任何东西了，将会自动插入一个封号，显然 foo2 函数中，当 return 后被插入一个封号后，尽管后面的语句不符合规定，但是因为没有执行到，所以也不会报错了。没有 return 任何东西的函数，默认返回 undefined。

所以很多 Javascript 规范建议把 { 写在一行中，而不是另起一行。

# 七

* * *

What is NaN? What is its type? How can you reliably test if a value is equal to NaN?

NaN 是什么鬼？typeof 的结果是？如果一个变量的值是 NaN，怎么确定？
NaN 是 ‘not a number’ 的缩写，表示 “不是一个数字”，通常会在运算过程中产生：

|     |     |
| --- | --- |
| 1<br>2 | console.log('abc'  /  4);<br>console.log(4  *  'a'); |

虽然它 “不是一个数字”，但是 NaN 的 typeof 结果却是 number：

|     |     |
| --- | --- |
| 1   | console.log(typeof  (4  *  'a'));  *// number* |

NaN 和任何变量都不相等，包括 NaN 自己：

|     |     |
| --- | --- |
| 1   | console.log(NaN  ===  NaN);  *// false* |

判断一个变量是不是 NaN 可以用 `isNaN()` 函数，但是这 [并不是一个完美的函数](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/isNaN#Confusing_special-case_behavior)，有些时候用 `value !== value` 似乎更准确，幸运的是，ES6 已经有 `Number.isNaN()` 方法，将比 `isNaN()` 准确的多。

# 八

* * *

What will the code below output? Explain your answer.

|     |     |
| --- | --- |
| 1<br>2 | console.log(0.1  +  0.2);<br>console.log(0.1  +  0.2  ==  0.3); |

上面代码的输出结果是什么？

这个问题正好我之前研究过，有兴趣的可以参考下 [【0.1 + 0.2 = 0.30000000000000004】该怎样理解？](http://www.cnblogs.com/zichi/p/5034201.html)，看懂了还有兴趣的可以看下这篇 [玉伯的一道课后题题解（关于 IEEE 754 双精度浮点型精度损失）](http://www.cnblogs.com/zichi/p/5043540.html)

# 九

* * *

Discuss possible ways to write a function `isInteger(x)` that determines if `x` is an integer.

写一个方法 isInterger(x)，可以用来判断一个变量是否是整数。

ES6 中自带了 `Number.isInteger()` 方法。但是目前 ES5 中没有自带的方法，可以把一个数去掉小数点后和原数进行比较，判断是否相等，那么问题就演变成如何对一个数进行取整了。

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8 |  var  a  =  -1.2223;<br> console.log(a  ^  0);  *// -1*<br> console.log(a  \|  0);  *// -1*<br> console.log(a  >  0);  *// -1*<br> console.log(Math.round(a));  *// -1*<br> console.log(Math.floor(a));  *// -2*<br> console.log(Math.ceil(a));  *// -1* |

# 十

* * *

In what order will the numbers 1-4 be logged to the console when the code below is executed? Why?

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | (function()  {<br>    console.log(1);<br>    setTimeout(function(){console.log(2)},  1000);<br>    setTimeout(function(){console.log(3)},  0);<br>    console.log(4);<br>})(); |

以上代码的输出结果是？

这题不难，只要知道 Javascript 是单线程的语言， 一些异步事件是在主体 js 执行完之后执行即可，所以主体的 1、4 先输出，而后是 3、2，没有问题，因为 3 的定时设置比 2 早。

具体可以参考我之前的文章 [从setTimeout谈JavaScript运行机制](http://www.cnblogs.com/zichi/p/4604053.html)

# 十一

* * *

Write a simple function (less than 80 characters) that returns a boolean indicating whether or not a string is a palindrome.

判断一个字符串是不是回文。

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4 | function  isPalindrome(str)  {<br>    str  =  str.replace(/W/g,  '').toLowerCase();<br>    return  (str  ==  str.split('').reverse().join(''));<br>} |

这里想到一个进阶题，求字符串最长回文子串，可以参考 [求最长回文子串 – leetcode 5. Longest Palindromic Substring](http://www.cnblogs.com/zichi/p/4753930.html)

# 十二

* * *

Write a `sum` method which will work properly when invoked using either syntax below.

|     |     |
| --- | --- |
| 1<br>2 | console.log(sum(2,3));   *// Outputs 5*<br>console.log(sum(2)(3));  *// Outputs 5* |

写一个 sum 方法，使得以上代码得到预期结果。这题可以参考我以前的文章 [汤姆大叔的6道javascript编程题题解](http://www.cnblogs.com/zichi/p/4362292.html) 中的最后一题，理论上此题更简单，因为它没要求能扩展（比如 sum(2)(3)(4)），甚至可以这样：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7 | function  sum(x)  {<br>  if  (arguments.length  ==  2)  {<br>    return  arguments[0]  +  arguments[1];<br>  }  else  {<br>    return  function(y)  {  return  x  +  y;  };<br>  }<br>} |

或者这样：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7 | function  sum(x,  y)  {<br>  if  (y  !==  undefined)  {<br>    return  x  +  y;<br>  }  else  {<br>    return  function(y)  {  return  x  +  y;  };<br>  }<br>} |

# 十三

* * *

Consider the following code snippet:

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | for  (var  i  =  0;  i  <  5;  i++)  {<br>  var  btn  =  document.createElement('button');<br>  btn.appendChild(document.createTextNode('Button '  +  i));<br>  btn.addEventListener('click',  function(){  console.log(i);  });<br>  document.body.appendChild(btn);<br>} |

(a) What gets logged to the console when the user clicks on “Button 4” and why?
(b) Provide one or more alternate implementations that will work as expected.
点击 ‘Button 4′ 后输出什么？如何使得输出能跟预期相同？

答案是输出 5，事实上点击任意的 button，输出都是 5。因为循环结束后，i 值变成了 5。如何改，使得输出分别是 0, 1, 2, 3, 4？用闭包在内存中保存变量，可以参考我之前的文章 [这10道javascript笔试题你都会么](http://www.cnblogs.com/zichi/p/4359786.html) 中的第 8 题。

# 十四

* * *

What will the code below output to the console and why?

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | var  arr1  =  "john".split('');<br>var  arr2  =  arr1.reverse();<br>var  arr3  =  "jones".split('');<br>arr2.push(arr3);<br>console.log("array 1: length="  +  arr1.length  +  " last="  +  arr1.slice(-1));<br>console.log("array 2: length="  +  arr2.length  +  " last="  +  arr2.slice(-1)); |

上面代码输出是？

这道题我答错了，忽略了 reverse() 方法的一个要重性质，reverse() 方法执行的结果并不是创建一个副本，而是在原数组上直接操作，并返回该数组的引用。

知道了这一点，该题也就迎刃而解了。arr2 其实和 arr1 引用了同一个对象，所以在 arr2 上的操作也会同时反映到 arr1 上。

# 十五

* * *

What will the code below output to the console and why ?

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | console.log(1  +  "2"  +  "2");<br>console.log(1  +  +"2"  +  "2");<br>console.log(1  +  -"1"  +  "2");<br>console.log(+"1"  +  "1"  +  "2");<br>console.log(  "A"  -  "B"  +  "2");<br>console.log(  "A"  -  "B"  +  2); |

以上代码输出什么？

+”2″ 能将字符串 “2″ 转换成整数 2，-”2″ 同理，而两个变量进行 “+” 运算时，如果都是数字和字符串，则分别进行数字相加和字符串拼接，如果一个是数字一个是字符串，则将数字转为字符串，如果是 “-” 运算呢？则将字符串转为数字。

“A” – “B” 会返回 NaN，因为 “A” 和 “B” 无法转成数字进行运算，这里不要以为 “A” 和 “B” 能转为 ASCII码 进行运算（不要和 C 语言搞混了）。而 NaN 和字符串相加，会转成 “NaN” 和字符串去拼接，NaN 和任何数字相加结果还是 NaN。

# 十六

* * *

The following recursive code will cause a stack overflow if the array list is too large. How can you fix this and still retain the recursive pattern?

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10 | var  list  =  readHugeList();<br>var  nextListItem  =  function()  {<br>    var  item  =  list.pop();<br>    if  (item)  {<br>        *// process the list item...*<br>        nextListItem();<br>    }<br>}; |

以上代码可能会由于递归调用导致栈溢出，如何规避这个问题？
首先，任何递归都可以用迭代来代替，所以改写成迭代方式肯定没有问题。
而原文给的解答令人深思：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10 | var  list  =  readHugeList();<br>var  nextListItem  =  function()  {<br>    var  item  =  list.pop();<br>    if  (item)  {<br>        *// process the list item...*<br>        setTimeout(  nextListItem,  0);<br>    }<br>}; |

利用 setTimeout 的异步性质，完美地去除了这个调用栈。
如果你还是摸不着头脑，简单举个栗子：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13 | var  list  =  [0,  1];<br>var  nextListItem  =  function()  {<br>    var  item  =  list.pop();<br>    if  (item)  {<br>      nextListItem();<br>    }<br>    console.log(item);<br>};<br>nextListItem(); |

上面的代码会依次输出 0 和 1，因为程序中形成了一个调用栈，1 被压到了栈底，最后出栈。
把程序改成这样：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14 | var  list  =  [0,  1];<br>var  nextListItem  =  function()  {<br>    var  item  =  list.pop();<br>    if  (item)  {<br>        *// process the list item...*<br>        setTimeout(  nextListItem,  0);<br>    }<br>    console.log(item);<br>};<br>nextListItem(); |

这回就是 1 和 0 了，因为 setTimeout 的回调只有当主体的 js 执行完后才会去执行，所以先输出了 1，自然也就没有栈这一说法了。
事实上，并不是所有递归都能这样改写，如果下一次递归调用依赖于前一次递归调用返回的值，就不能这么改了。

# 十七

* * *

What is a “closure” in JavaScript? Provide an example.
谈谈闭包。

以前也写过几篇文章，可以参考下 [闭包初窥](http://www.cnblogs.com/zichi/p/4563435.html) 以及 [闭包拾遗 & 垃圾回收机制](http://www.cnblogs.com/zichi/p/4568756.html)。

# 十八

* * *

What will be the output of the following code:

|     |     |
| --- | --- |
| 1<br>2<br>3 | for  (var  i  =  0;  i  <  5;  i++)  {<br>  setTimeout(function()  {  console.log(i);  },  i *  1000  );<br>} |

Explain your answer. How could the use of closures help here?
以上代码输出什么？如何能输出期望值？
很显然，输出都是 5。这题和第十三题有些类似，用立即执行函数+闭包即可。

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | for  (var  i  =  0;  i  <  5;  i++)  {<br>  !function(i)  {<br>    setTimeout(function()  {  console.log(i);  },  i *  1000  );<br>  }(i)<br>} |

还有种优雅的解法，使用 [bind](http://www.cnblogs.com/zichi/p/4357023.html)：

|     |     |
| --- | --- |
| 1<br>2<br>3 | for(var  i  =  0;  i  <  5;  i++)  {<br>  setTimeout(console.log.bind(console,  i),  i *  1000);<br>} |

# 十九

* * *

What would the following lines of code output to the console?

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4 | console.log("0 \|\| 1 = "+(0  \|\|  1));<br>console.log("1 \|\| 2 = "+(1  \|\|  2));<br>console.log("0 & 1 = "+(0  &&  1));<br>console.log("1 & 2 = "+(1  &&  2)); |

以上代码输出什么？

`||` 和 `&&` 是短路运算符。先说说 ||，如果前面变量值为 false（包括 0、null、undefined、flase、空字符串等等），则返回后面变量值，否则返回前面变量值。&& 恰恰相反，如果前面变量为 false，则返回前面变量值，否则返回后面变量值。

注意不要和位运算操作符 `|` 以及 `&` 搞混淆了。

# 二十

* * *

What will be the output when the following code is executed? Explain.

|     |     |
| --- | --- |
| 1<br>2 | console.log(false  ==  '0')<br>console.log(false  ===  '0') |

`==` 和 `===` 的区别， 后者是全等，只有两个值完全相同（或者两个对象引用相同）时，才会返回 true，而前者在比较时会进行隐式的转换。

# 二十一

* * *

What is the output out of the following code? Explain your answer.

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8 | var  a={},<br>    b={key:'b'},<br>    c={key:'c'};<br>a[b]=123;<br>a[c]=456;<br>console.log(a[b]); |

一道有趣的题目，答案是 456。

我们知道，Javascript 中对象的 key 值，一定会是一个 string 值，如果不是，则会隐式地进行转换。当执行到 `a[b]=123]` 时，b 并不是一个 string 值，将 b 执行 toString() 方法转换（得到 “[object Object]“），a[c] 也是相同道理。所以代码其实可以看做这样执行：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11 | var  a={},<br>    b={key:'b'},<br>    c={key:'c'};<br>*// a[b]=123;*<br>a["[object Object]"]=123;<br>*// a[c]=456;*<br>a["[object Object]"]=456;<br>console.log(a["[object Object]"]); |

这样就一目了然了。

# 二十二

* * *

What will the following code output to the console:

|     |     |
| --- | --- |
| 1   | console.log((function  f(n){return  ((n  >  1)  ?  n *  f(n-1)  :  n)})(10)); |

输出什么？
其实可以写成这样，清楚些：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | var  ans  =  (function  f(n){<br>  return  ((n  >  1)  ?  n *  f(n-1)  :  n)<br>})(10);<br>console.log(ans); |

其实就是一个立即执行函数+递归，求个阶乘而已（10!）。给立即执行函数加了个名字 f，方便在递归里调用，其实完全可以用 `arguments.callee` 代替：

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | var  ans  =  (function(n){<br>  return  ((n  >  1)  ?  n *  arguments.callee(n-1)  :  n)<br>})(10);<br>console.log(ans); |

# 二十三

* * *

Consider the code snippet below. What will the console output be and why?

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | (function(x)  {<br>    return  (function(y)  {<br>        console.log(x);<br>    })(2)<br>})(1); |

输出什么？
显然是 1，闭包，能引用函数外的变量。
改成这样呢？

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | (function(y)  {<br>    return  (function(y)  {<br>        console.log(y);<br>    })(2)<br>})(1); |

# 二十四

* * *

What will the following code output to the console and why:

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11 | var  hero  =  {<br>    _name:  'John Doe',<br>    getSecretIdentity:  function  (){<br>        return  this._name;<br>    }<br>};<br>var  stoleSecretIdentity  =  hero.getSecretIdentity;<br>console.log(stoleSecretIdentity());<br>console.log(hero.getSecretIdentity()); |

What is the issue with this code and how can it be fixed.

执行第一次输出时，this 指向了 window，如何规避这个问题？用 bind 绑定 this 指向，具体可以参考 [ECMAScript 5(ES5)中bind方法简介备忘](http://www.cnblogs.com/zichi/p/4357023.html)，注意低版本 IE 的兼容。

|     |     |
| --- | --- |
| 1   | var  stoleSecretIdentity  =  hero.getSecretIdentity.bind(hero); |

# 二十五

* * *

Create a function that, given a DOM Element on the page, will visit the element itself and all of its descendents (not just its immediate children). For each element visited, the function should pass that element to a provided callback function.

The arguments to the function should be:

- a DOM element
- a callback function (that takes a DOM element as its argument)

遍历 DOM 树，不难，深度优先搜索即可。

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7 | function  Traverse(p_element,p_callback)  {<br>   p_callback(p_element);<br>   var  list  =  p_element.children;<br>   for  (var  i  =  0;  i  <  list.length;  i++)  {<br>       Traverse(list[i],p_callback);  *// recursive call*<br>   }<br>} |

这道题可以拓展，先序遍历 DOM树，中序遍历，甚至后序遍历的结果是？具体可以参考前文 [二叉树三种遍历的递归和迭代解法](http://www.cnblogs.com/zichi/p/4807752.html)，都是树，原理是一样一样的。

 **  2 赞  ** 11 收藏  [** 3 评论](http://web.jobbole.com/84723/#article-comment)

         [(L)](http://www.jiathis.com/share?uid=1745061)

### 关于作者：[韩子迟](http://www.jobbole.com/members/hanzichi)

[![05df877198790535ab4571ff37fdcd04.jpg](../_resources/2caf0052dbc5f78b7c4b04299ddff188.jpg)](http://www.jobbole.com/members/hanzichi)

  http://www.cnblogs.com/zichi/     [** 个人主页](http://www.jobbole.com/members/hanzichi) · [** 我的文章](http://web.jobbole.com/author/hanzichi/) · [** 2](http://www.jobbole.com/members/hanzichi/reputation/) · [**](http://www.cnblogs.com/zichi/) [**](http://weibo.com/hanzichi) [**](https://github.com/hanzichi)

[![8224bdd2a4eea37c62dc2b989d6e6a11.jpg](../_resources/4f75e589bcebbeb294db9deada378836.jpg)](http://blog.jobbole.com/84342/?utm_source=web.jobbole.com&utm_medium=articleBanner&utm_content=2015.12.26)