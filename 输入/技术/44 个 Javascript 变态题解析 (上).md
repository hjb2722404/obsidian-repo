44 个 Javascript 变态题解析 (上)

## 44 个 Javascript 变态题解析 (上)

*2016-07-01*  [前端大全]()
（点击上方公众号，可快速关注）

> 作者：xiaoyu2er
> 链接：> https://github.com/xiaoyu2er/blog/issues/1

原题来自: javascript-puzzlers（http://javascript-puzzlers.herokuapp.com/）

读者可以先去做一下感受感受. 当初笔者的成绩是 21/44…

当初笔者做这套题的时候不仅怀疑智商, 连人生都开始怀疑了….

不过, 对于基础知识的理解是深入编程的前提. 让我们一起来看看这些变态题到底变态不变态吧!

**第1题**

> ["1", "2", "3"].map(parseInt)

知识点:

- Array/map
- Number/parseInt
- JavaScript parseInt

首先, map接受两个参数, 一个回调函数 callback, 一个回调函数的this值

其中回调函数接受三个参数 currentValue, index, arrary;

而题目中, map只传入了回调函数–parseInt.

其次, parseInt 只接受两个两个参数 string, radix(基数).

> 可选。表示要解析的数字的基数。该值介于 2 ~ 36 之间。

> 如果省略该参数或其值为 0，则数字将以 10 为基础来解析。如果它以 “0x” 或 “0X” 开头，将以 16 为基数。

> 如果该参数小于 2 或者大于 36，则 parseInt() 将返回 NaN。

所以本题即问

> parseInt> (> '1'> ,>   > 0> );
> parseInt> (> '2'> ,>   > 1> );
> parseInt> (> '3'> ,>   > 2> );

首先后两者参数不合法.

所以答案是 [1, NaN, NaN]

**第2题**

> [typeof null, null instanceof Object]

两个知识点:

- Operators/typeof
- Operators/instanceof
- Operators/instanceof(中)

typeof 返回一个表示类型的字符串.

instanceof 运算符用来检测 constructor.prototype 是否存在于参数 object 的原型链上.

这个题可以直接看链接… 因为 typeof null === 'object' 自语言之初就是这样….

typeof 的结果请看下表:

> type         result
> Undefined>   >   > "undefined"
> Null>         > "object"
> Boolean>     >   > "boolean"
> Number>       > "number"
> String>       > "string"
> Symbol>       > "symbol"
> Host>   > object>   > Implementation> -> dependent
> Function>     > "function"
> Object>       > "object"

所以答案 [object, false]

**第3题**

> [ [3,2,1].reduce(Math.pow), [].reduce(Math.pow) ]

知识点:

- Array/Reduce

arr.reduce(callback[, initialValue])

reduce接受两个参数, 一个回调, 一个初始值.

回调函数接受四个参数 previousValue, currentValue, currentIndex, array

需要注意的是 If the array is empty and no initialValue was provided, TypeError would be thrown.

所以第二个表达式会报异常. 第一个表达式等价于 Math.pow(3, 2) => 9; Math.pow(9, 1) =>9

答案 an error

**第4题**

> var>   > val>   > =>   > 'smtg'> ;

> console> .> log> (> 'Value is '>   > +>   > (> val>   > ===>   > 'smtg'> )>   > ?>   > 'Something'>   > :>   > 'Nothing'> );

两个知识点:

- Operators/Operator_Precedence
- Operators/Conditional_Operator

简而言之 + 的优先级 大于 ?

所以原题等价于 'Value is true' ? 'Somthing' : 'Nonthing' 而不是 'Value is' + (true ? 'Something' : 'Nonthing')

答案 'Something'

**第5题**

> var>   > name>   > =>   > 'World!'> ;
> (> function>   > ()>   > {
>     > if>   > (> typeof>   > name>   > ===>   > 'undefined'> )>   > {
>         > var>   > name>   > =>   > 'Jack'> ;
>         > console> .> log> (> 'Goodbye '>   > +>   > name> );
>     > }>   > else>   > {
>         > console> .> log> (> 'Hello '>   > +>   > name> );
>     > }
> })();

这个相对简单, 一个知识点:

- Hoisting

在 JavaScript中， functions 和 variables 会被提升。变量提升是JavaScript将声明移至作用域 scope (全局域或者当前函数作用域) 顶部的行为。

这个题目相当于

> var>   > name>   > =>   > 'World!'> ;
> (> function>   > ()>   > {
>     > var>   > name> ;
>     > if>   > (> typeof>   > name>   > ===>   > 'undefined'> )>   > {
>         > name>   > =>   > 'Jack'> ;
>         > console> .> log> (> 'Goodbye '>   > +>   > name> );
>     > }>   > else>   > {
>         > console> .> log> (> 'Hello '>   > +>   > name> );
>     > }
> })();

所以答案是 'Goodbye Jack'

**第6题**

var  END  =  Math.pow(2,  53);
var  START  =  END  -  100;
var  count  =  0;
for (var i = START; i <= END; i++) {
    count++;
}
console.log(count);

一个知识点:

- Infinity

在 JS 里, Math.pow(2, 53) == 9007199254740992 是可以表示的最大值. 最大值加一还是最大值. 所以循环不会停.

**第7题**

> var>   > ary>   > =>   > [> 0> ,> 1> ,> 2> ];
> ary> [> 10> ]>   > =>   > 10> ;

> ary> .> filter> (> function> (> x> )>   > {>   > return>   > x>   > ===>   > undefined> ;});

答案是 []

看一篇文章理解稀疏数组

- 译 JavaScript中的稀疏数组与密集数组
- Array/filter

我们来看一下 Array.prototype.filter 的 polyfill:

> if>   > (> !> Array> .> prototype> .> filter> )>   > {

>   > Array> .> prototype> .> filter>   > =>   > function> (> fun> /*, thisArg*/> )>   > {

>     > 'use strict'> ;
>

>     > if>   > (> this>   > ===>   > void>   > 0>   > ||>   > this>   > ===>   > null> )>   > {

>       > throw>   > new>   > TypeError> ();
>     > }
>
>     > var>   > t>   > =>   > Object> (> this> );
>     > var>   > len>   > =>   > t> .> length>   > >>>>   > 0> ;
>     > if>   > (> typeof>   > fun>   > !==>   > 'function'> )>   > {
>       > throw>   > new>   > TypeError> ();
>     > }
>
>     > var>   > res>   > =>   > [];

>     > var>   > thisArg>   > =>   > arguments> .> length>   > >=>   > 2>   > ?>   > arguments> [> 1> ]>   > :>   > void>   > 0> ;

>     > for>   > (> var>   > i>   > =>   > 0> ;>   > i>   > <>   > len> ;>   > i> ++> )>   > {

>       > if>   > (> i>   > in>   > t> )>   > {>   > // 注意这里!!!
>         > var>   > val>   > =>   > t> [> i> ];

>         > if>   > (> fun> .> call> (> thisArg> ,>   > val> ,>   > i> ,>   > t> ))>   > {

>           > res> .> push> (> val> );
>         > }
>       > }
>     > }
>
>     > return>   > res> ;
>   > };
> }

我们看到在迭代这个数组的时候, 首先检查了这个索引值是不是数组的一个属性, 那么我们测试一下。

> 0>   > in>   > ary> ;>   > =>>   > true
> 3>   > in>   > ary> ;>   > =>>   > false
> 10>   > in>   > ary> ;>   > =>>   > true

也就是说 从 3 – 9 都是没有初始化的’坑’!, 这些索引并不存在与数组中. 在 array 的函数调用的时候是会跳过这些’坑’的.

**第8题**

> var>   > two>    =>   > 0.2
> var>   > one>    =>   > 0.1
> var>   > eight>   > =>   > 0.8
> var>   > six>    =>   > 0.6

> [> two>   > ->   > one>   > ==>   > one> ,>   > eight>   > ->   > six>   > ==>   > two> ]

- JavaScript的设计缺陷?浮点运算：0.1 + 0.2 != 0.3

IEEE 754标准中的浮点数并不能精确地表达小数

那什么时候精准, 什么时候不经准呢? 笔者也不知道…

答案 [true, false]

**第9题**

> function>   > showCase> (> value> )>   > {
>     > switch> (> value> )>   > {
>     > case>   > 'A'> :
>         > console> .> log> (> 'Case A'> );
>         > break> ;
>     > case>   > 'B'> :
>         > console> .> log> (> 'Case B'> );
>         > break> ;
>     > case>   > undefined:
>         > console> .> log> (> 'undefined'> );
>         > break> ;
>     > default> :
>         > console> .> log> (> 'Do not know!'> );
>     > }
> }
> showCase> (> new>   > String> (> 'A'> ));

两个知识点:

- Statements/switch
- String

switch 是严格比较, String 实例和 字符串不一样.

> var>   > s_prim>   > =>   > 'foo'> ;
> var>   > s_obj>   > =>   > new>   > String> (> s_prim> );
>
> console> .> log> (> typeof>   > s_prim> );>   > // "string"
> console> .> log> (> typeof>   > s_obj> );>   > // "object"
> console> .> log> (> s_prim>   > ===>   > s_obj> );>   > // false

答案是 'Do not know!'

**第10题**

> function>   > showCase2> (> value> )>   > {
>     > switch> (> value> )>   > {
>     > case>   > 'A'> :
>         > console> .> log> (> 'Case A'> );
>         > break> ;
>     > case>   > 'B'> :
>         > console> .> log> (> 'Case B'> );
>         > break> ;
>     > case>   > undefined:
>         > console> .> log> (> 'undefined'> );
>         > break> ;
>     > default> :
>         > console> .> log> (> 'Do not know!'> );
>     > }
> }
> showCase2> (> String> (> 'A'> ));

解释:

String(x) does not create an object but does return a string, i.e. typeof String(1) === "string"

还是刚才的知识点, 只不过 String 不仅是个构造函数 直接调用返回一个字符串哦.

答案 'Case A'

**第11题**

> function>   > isOdd> (> num> )>   > {
>     > return>   > num>   > %>   > 2>   > ==>   > 1> ;
> }
> function>   > isEven> (> num> )>   > {
>     > return>   > num>   > %>   > 2>   > ==>   > 0> ;
> }
> function>   > isSane> (> num> )>   > {
>     > return>   > isEven> (> num> )>   > ||>   > isOdd> (> num> );
> }

> var>   > values>   > =>   > [> 7> ,>   > 4> ,>   > '13'> ,>   > -> 9> ,>   > Infinity> ];

> values> .> map> (> isSane> );

一个知识点

- Arithmetic_Operators#Remainder

此题等价于

> 7>   > %>   > 2>   > =>>   > 1
> 4>   > %>   > 2>   > =>>   > 0
> '13'>   > %>   > 2>   > =>>   > 1
> -> 9>   > % %>   > 2>   > => -> 1
> Infinity>   > %>   > 2>   > =>>   > NaN

需要注意的是 余数的正负号随第一个操作数.

答案 [true, true, true, false, false]

**第12题**

> parseInt> (> 3> ,>   > 8> )
> parseInt> (> 3> ,>   > 2> )
> parseInt> (> 3> ,>   > 0> )

第一个题讲过了, 答案 3, NaN, 3

**第13题**

> Array.isArray( Array.prototype )

一个知识点:

- Array/prototype

一个鲜为人知的实事: Array.prototype => [];

答案: true

**第14题**

> var>   > a>   > =>   > [> 0> ];
> if>   > ([> 0> ])>   > {
>   > console> .> log> (> a>   > ==>   > true> );
> }>   > else>   > {
>   > console> .> log> (> "wut"> );
> }

- JavaScript-Equality-Table

答案: false

**第15题**

> []==[]

== 是万恶之源, 看上图

答案是 false

**第16题**

> '5'>   > +>   > 3
> '5'>   > ->   > 3

两个知识点:

- Arithmetic_Operators#Addition
- Arithmetic_Operators#Subtraction

+ 用来表示两个数的和或者字符串拼接, -表示两数之差.

请看例子, 体会区别:

> >>   > '5'>   > +>   > 3
> '53'
> >>   > 5>   > +>   > '3'
> '53'
> >>   > 5>   > ->   > '3'
> 2
> >>   > '5'>   > ->   > 3
> 2
> >>   > '5'>   > ->   > '3'
> 2

也就是说 - 会尽可能的将两个操作数变成数字, 而 + 如果两边不都是数字, 那么就是字符串拼接.

答案是 '53', 2

**第17题**

> 1 + - + + + - + 1

这里应该是(倒着看)

> 1>   > +>   > (> a> )>   =>>   > 2
> a>   > = ->   > (> b> )>   > =>>   > 1
> b>   > = +>   > (> c> )>   > => -> 1
> c>   > = +>   > (> d> )>   > => -> 1
> d>   > = +>   > (> e> )>   > => -> 1
> e>   > = +>   > (> f> )>   > => -> 1
> f>   > = ->   > (> g> )>   > => -> 1
> g>   > = +>   > 1>    =>>   > 1

所以答案 2

**第18题**

> var>   > ary>   > =>   > Array> (> 3> );
> ary> [> 0> ]> => 2
> ary> .> map> (> function> (> elem> )>   > {>   > return>   > '1'> ;>   > });

稀疏数组. 同第7题.

题目中的数组其实是一个长度为3, 但是没有内容的数组, array 上的操作会跳过这些未初始化的’坑’.

所以答案是 ["1", undefined × 2]

这里贴上 Array.prototype.map 的 polyfill.

> Array> .> prototype> .> map>   > =>   > function> (> callback> ,>   > thisArg> )>   > {

>
>         > var>   > T> ,>   > A> ,>   > k> ;
>
>         > if>   > (> this>   > ==>   > null> )>   > {

>             > throw>   > new>   > TypeError> (> ' this is null or not defined'> );

>         > }
>
>         > var>   > O>   > =>   > Object> (> this> );
>         > var>   > len>   > =>   > O> .> length>   > >>>>   > 0> ;
>         > if>   > (> typeof>   > callback>   > !==>   > 'function'> )>   > {

>             > throw>   > new>   > TypeError> (> callback>   > +>   > ' is not a function'> );

>         > }
>         > if>   > (> arguments> .> length>   > >>   > 1> )>   > {
>             > T>   > =>   > thisArg> ;
>         > }
>         > A>   > =>   > new>   > Array> (> len> );
>         > k>   > =>   > 0> ;
>         > while>   > (> k>   > <>   > len> )>   > {
>             > var>   > kValue> ,>   > mappedValue> ;
>             > if>   > (> k>   > in>   > O> )>   > {
>                 > kValue>   > =>   > O> [> k> ];

>                 > mappedValue>   > =>   > callback> .> call> (> T> ,>   > kValue> ,>   > k> ,>   > O> );

>                 > A> [> k> ]>   > =>   > mappedValue> ;
>             > }
>             > k> ++> ;
>         > }
>         > return>   > A> ;
>     > };

**第19题**

> function>   > sidEffecting> (> ary> )>   > {
>   > ary> [> 0> ]>   > =>   > ary> [> 2> ];
> }
> function>   > bar> (> a> ,> b> ,> c> )>   > {
>   > c>   > =>   > 10
>   > sidEffecting> (> arguments> );
>   > return>   > a>   > +>   > b>   > +>   > c> ;
> }
> bar> (> 1> ,> 1> ,> 1> )

这是一个大坑, 尤其是涉及到 ES6语法的时候

知识点:

- Functions/arguments

首先 The arguments object is an Array-like object corresponding to the arguments passed to a function.

也就是说 arguments 是一个 object, c 就是 arguments[2], 所以对于 c 的修改就是对 arguments[2] 的修改.

所以答案是 21.

然而!!!!!!

当函数参数涉及到 any rest parameters, any default parameters or any destructured parameters 的时候, 这个 arguments 就不在是一个 mapped arguments object 了…..

请看:

> function>   > sidEffecting> (> ary> )>   > {
>   > ary> [> 0> ]>   > =>   > ary> [> 2> ];
> }
> function>   > bar> (> a> ,> b> ,> c> => 3> )>   > {
>   > c>   > =>   > 10
>   > sidEffecting> (> arguments> );
>   > return>   > a>   > +>   > b>   > +>   > c> ;
> }
> bar> (> 1> ,> 1> ,> 1> )

答案是 12 !!!!

请读者细细体会!!

**第20题**

> var>   > a>   > =>   > 111111111111111110000> ,
>     > b>   > =>   > 1111> ;
> a>   > +>   > b> ;

答案还是 111111111111111110000. 解释是 Lack of precision for numbers in JavaScript affects both small and big numbers. 但是笔者不是很明白……………. 请读者赐教!

**第21题**

> var>   > x>   > =>   > [].> reverse> ;
> x> ();

这个题有意思!

知识点:

- Array/reverse

The reverse method transposes the elements of the calling array object in place, mutating the array, and returning a reference to the array.

也就是说 最后会返回这个调用者(this), 可是 x 执行的时候是上下文是全局. 那么最后返回的是 window.

答案是 window

**第22题**

> Number> .> MIN_VALUE>   > >>   > 0

今天先到这里, 下次我们来看后22个题!

【今日微信公号推荐↓】
![640.jpg](../_resources/e8b18bdd54df872b80aac238915fc83a.jpg)

更多推荐请看**《**[值得关注的技术和设计公众号](http://mp.weixin.qq.com/s?__biz=MzAxODE2MjM1MA==&amp;mid=402186355&amp;idx=1&amp;sn=72be66e2caaaebb3cc436b2f5fb6ee0c&amp;scene=21#wechat_redirect)**》**

其中推荐了包括**技术**、**设计**、**极客 **和 **IT相亲**相关的热门公众号。技术涵盖：Python、Web前端、Java、安卓、iOS、PHP、C/C++、.NET、Linux、数据库、运维、大数据、算法、IT职场等。点击《[值得关注的技术和设计公众号](http://mp.weixin.qq.com/s?__biz=MzAxODE2MjM1MA==&amp;mid=402186355&amp;idx=1&amp;sn=72be66e2caaaebb3cc436b2f5fb6ee0c&amp;scene=21#wechat_redirect)》，发现精彩！

![640.jpg](../_resources/8619af60e2e6b27dc06250c838f2647d.jpg)