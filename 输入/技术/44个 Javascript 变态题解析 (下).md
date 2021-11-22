44个 Javascript 变态题解析 (下)

##  44个 Javascript 变态题解析 (下)

 *2016-07-03*  [前端大全]()

（点击上方公众号，可快速关注）
****
> 作者：xiaoyu2er
> 链接：> https://github.com/xiaoyu2er/blog/issues/3
****
承接上篇 44个 Javascript 变态题解析 (上)

**第23题**

> [1 < 2 < 3, 3 < 2 < 1]

这个题也还可以.

这个题会让人误以为是 2 > 1 && 2 < 3 其实不是的.

这个题等价于

> 1>  < > 2>  => > true> ;
>   > true>  < > 3>  =>  > 1>  < > 3>  => > true> ;
>   > 3>  < > 2>  => > false> ;
>   > false>  < > 1>  => > 0>  < > 1>  => > true> ;

答案是 [true, true]

**第24题**

> // the most classic wtf
> 2>  == > [[[> 2> ]]]

这个题我是猜的. 我猜的 true, 至于为什么…..

both objects get converted to strings and in both cases the resulting string is "2" 我不能信服…

**第25题**

> 3.toString> ()
> 3..toString> ()
> 3...toString> ()

这个题也挺逗, 我做对了 :) 答案是 error, '3', error

你如果换一个写法就更费解了

> var>   > a>  = > 3> ;
> a> .> toString> ()

这个答案就是 '3';

为啥呢?

因为在 js 中 1.1, 1., .1 都是合法的数字. 那么在解析 3.toString 的时候这个 . 到底是属于这个数字还是函数调用呢? 只能是数字, 因为3.合法啊!

**第26题**

> (> function> (){
>   > var>   > x>  = > y>  = > 1> ;
> })();
> console> .> log> (> y> );
> console> .> log> (> x> );

答案是 1, error

y 被赋值到全局. x 是局部变量. 所以打印 x 的时候会报 ReferenceError

**第27题**

> var>   > a>  = /> 123> /> ,
>     > b>  = /> 123> /> ;
> a>  == > b
> a>  === > b

即使正则的字面量一致, 他们也不相等.

答案 false, false

**第28题**

> var>   > a>  = > [> 1> ,>   > 2> ,>   > 3> ],
>     > b>  = > [> 1> ,>   > 2> ,>   > 3> ],
>     > c>  = > [> 1> ,>   > 2> ,>   > 4> ]
> a>  ==  > b
> a>  === > b
> a>  >   > c
> a>  <   > c

字面量相等的数组也不相等.

数组在比较大小的时候按照字典序比较

答案 false, false, false, true

**第29题**

> var>   > a>  = > {},>   > b>  = > Object> .> prototype> ;

> [> a> .> prototype>  === > b> ,>   > Object> .> getPrototypeOf> (> a> )>  === > b> ]

知识点:

- Object/getPrototypeOf

只有 Function 拥有一个 prototype 的属性. 所以 a.prototype 为 undefined.

而 Object.getPrototypeOf(obj) 返回一个具体对象的原型(该对象的内部[[prototype]]值)

答案 false, true

**第30题**
**
**
> function>   > f> ()>   > {}

> var>   > a>  = > f> .> prototype> ,>   > b>  = > Object> .> getPrototypeOf> (> f> );

> a>  === > b

f.prototype is the object that will become the parent of any objects created with new f while Object.getPrototypeOf returns the parent in the inheritance hierarchy.

f.prototype 是使用使用 new 创建的 f 实例的原型. 而 Object.getPrototypeOf 是 f 函数的原型.

请看:

> a>  === > Object> .> getPrototypeOf> (> new>   > f> ())>   > // true
> b>  === > Function> .> prototype>   > // true

答案 false

**31**

> function>   > foo> ()>   > {>   > }
> var>   > oldName>  = > foo> .> name> ;
> foo> .> name>  = > "bar"> ;
> [> oldName> ,>   > foo> .> name> ]

答案 ['foo', 'foo']

知识点:

- Function/name

因为函数的名字不可变.

**第32题**

> "1 2 3".replace(/\d/g, parseInt)

知识点:

- String/replace#Specifying_a_function_as_a_parameter

str.replace(regexp|substr, newSubStr|function)

如果replace函数传入的第二个参数是函数, 那么这个函数将接受如下参数

- match 首先是匹配的字符串
- p1, p2 …. 然后是正则的分组
- offset match 匹配的index
- string 整个字符串

由于题目中的正则没有分组, 所以等价于问

> parseInt> (> '1'> ,>   > 0> )
> parseInt> (> '2'> ,>   > 2> )
> parseInt> (> '3'> ,>   > 4> )

答案: 1, NaN, 3

**第33题**

> function>   > f> ()>   > {}
> var>   > parent>  = > Object> .> getPrototypeOf> (> f> );
> f> .> name>   > // ?
> parent> .> name>   > // ?
> typeof>   > eval> (> f> .> name> )>   > // ?
> typeof>   > eval> (> parent> .> name> )>   > //  ?

先说以下答案 'f', 'Empty', 'function', error 这个答案并不重要…..

这里第一小问和第三小问很简单不解释了.

第二小问笔者在自己的浏览器测试的时候是 '', 第四问是 'undefined'

所以应该是平台相关的. 这里明白 parent === Function.prototype 就好了.

**第34题**

> var>   > lowerCaseOnly>  =  /^> [> a> -> z> ]> +> $> /> ;
> [> lowerCaseOnly> .> test> (> null> ),>   > lowerCaseOnly> .> test> ()]

知识点:

- RegExp/test

这里 test 函数会将参数转为字符串. 'nul', 'undefined' 自然都是全小写了

答案: true, true

**第35题**

> [,,,].> join> (> ", "> )

[,,,] => [undefined × 3]

因为javascript 在定义数组的时候允许最后一个元素后跟一个,, 所以这是个长度为三的稀疏数组(这是长度为三, 并没有 0, 1, 2三个属性哦)

答案: ", , "

**第36题**

> var>   > a>  = > {> class> : > "Animal"> ,>   > name> : > 'Fido'> };
> a> .> class

这个题比较流氓.. 因为是浏览器相关, class是个保留字(现在是个关键字了)

所以答案不重要, 重要的是自己在取属性名称的时候尽量避免保留字. 如果使用的话请加引号 a['class']

**第37题**

> var a = new Date("epoch")

知识点:

- Date
- Date/parse

简单来说, 如果调用 Date 的构造函数传入一个字符串的话需要符合规范, 即满足 Date.parse 的条件.

另外需要注意的是 如果格式错误 构造函数返回的仍是一个Date 的实例 Invalid Date.

答案 Invalid Date

**第38题**

> var>   > a>  = > Function> .> length> ,
>     > b>  = > new>   > Function> ().> length
> a>  === > b

我们知道一个function(Function 的实例)的 length 属性就是函数签名的参数个数, 所以 b.length == 0.

另外 Function.length 定义为1……

所以不相等…….答案 false

**第39题**

> var>   > a>  = > Date> (> 0> );
> var>   > b>  = > new>   > Date> (> 0> );
> var>   > c>  = > new>   > Date> ();
> [> a>  === > b> ,>   > b>  === > c> ,>   > a>  === > c> ]

还是关于Date 的题, 需要注意的是

- 如果不传参数等价于当前时间.
- 如果是函数调用 返回一个字符串.

答案 false, false, false

**第40题**

> var>   > min>  = > Math> .> min> (),>   > max>  = > Math> .> max> ()
> min>  < > max

知识点:

- Math/min
- Math/max

有趣的是, Math.min 不传参数返回 Infinity, Math.max 不传参数返回 -Infinity :laughing:

答案: false

**第41题**

> function>   > captureOne> (> re> ,>   > str> )>   > {
>   > var>   > match>  = > re> .> exec> (> str> );
>   > return>   > match>  && > match> [> 1> ];
> }
> var>   > numRe>   = > /num=(\d+)/i> g> ,
>     > wordRe>  = > /word=(\w+)/i> ,
>     > a1>  = > captureOne> (> numRe> ,>   > "num=1"> ),
>     > a2>  = > captureOne> (> wordRe> ,>   > "word=1"> ),
>     > a3>  = > captureOne> (> numRe> ,>   > "NUM=2"> ),
>     > a4>  = > captureOne> (> wordRe> ,>   > "WORD=2"> );
> [> a1>  === > a2> ,>   > a3>  === > a4> ]

知识点:

- RegExp/exec

通俗的讲

因为第一个正则有一个 g 选项 它会‘记忆’他所匹配的内容, 等匹配后他会从上次匹配的索引继续, 而第二个正则不会

举个例子

> var>   > myRe>  = > /ab*/g> ;
> var>   > str>  = > 'abbcdefabh'> ;
> var>   > myArray> ;
> while>   > ((> myArray>  = > myRe> .> exec> (> str> ))>  !== > null> )>   > {
>   > var>   > msg>  = > 'Found '>  + > myArray> [> 0> ]>  + > '. '> ;
>   > msg>  += > 'Next match starts at '>  + > myRe> .> lastIndex> ;
>   > console> .> log> (> msg> );
> }
> // Found abb. Next match starts at 3
> // Found ab. Next match starts at 9

所以 a1 = ‘1’; a2 = ‘1’; a3 = null; a4 = ‘2’

答案 [true, false]

**第42题**

> var>   > a>  = > new>   > Date> (> "2014-03-19"> ),
>     > b>  = > new>   > Date> (> 2014> ,>   > 03> ,>   > 19> );

> [> a> .> getDay> ()>  === > b> .> getDay> (),>   > a> .> getMonth> ()>  === > b> .> getMonth> ()]

这个….

> JavaScript inherits 40 years old design from C: days are 1-indexed in C’s struct tm, but months are 0 indexed. In addition to that, getDay returns the 0-indexed day of the week, to get the 1-indexed day of the month you have to use getDate, which doesn’t return a Date object.

> a> .> getDay> ()
> 3
> b> .> getDay> ()
> 6
> a> .> getMonth> ()
> 2
> b> .> getMonth> ()
> 3

都是套路!

答案 [false, false]

**第43题**

> if>   > (> 'http://giftwrapped.com/picture.jpg'> .> match> (> '.gif'> ))>   > {

>   > 'a gif file'
> }>   > else>   > {
>   > 'not a gif file'
> }

知识点:

- String/match

String.prototype.match 接受一个正则, 如果不是, 按照 new RegExp(obj) 转化. 所以 . 并不会转义
那么 /gif 就匹配了 /.gif/

答案: 'a gif file'

**第44题**

> function>   > foo> (> a> )>   > {
>     > var>   > a> ;
>     > return>   > a> ;
> }
> function>   > bar> (> a> )>   > {
>     > var>   > a>  = > 'bye'> ;
>     > return>   > a> ;
> }
> [> foo> (> 'hello'> ),>   > bar> (> 'hello'> )]

在两个函数里, a作为参数其实已经声明了, 所以 var a; var a = 'bye' 其实就是 a; a ='bye'

所以答案 'hello', 'bye'

全部结束!

**总结**

由于笔者水平有限, 如果解释有误, 还望指出 :smile:

通过整理, 笔者发现绝大部分题目都是因为自己对于基础知识或者说某个 API 的参数理解偏差才做错的.

笔者的重灾区在原型那一块, 所以这次被虐和整理还是很有意义呀.

笔者相信 坚实的基础是深入编程的前提. 所以基础书还是要常看啊 :hamster:

最后这些变态题现在看看还变态嘛?

【今日微信公号推荐↓】
![640.jpg](../_resources/189cdc0e730a487279084a1e622df5dd.jpg)

更多推荐请看**《**[值得关注的技术和设计公众号](http://mp.weixin.qq.com/s?__biz=MzAxODE2MjM1MA==&mid=402186355&idx=1&sn=72be66e2caaaebb3cc436b2f5fb6ee0c&scene=21#wechat_redirect)**》**

其中推荐了包括**技术**、**设计**、**极客 **和 **IT相亲**相关的热门公众号。技术涵盖：Python、Web前端、Java、安卓、iOS、PHP、C/C++、.NET、Linux、数据库、运维、大数据、算法、IT职场等。点击《[值得关注的技术和设计公众号](http://mp.weixin.qq.com/s?__biz=MzAxODE2MjM1MA==&mid=402186355&idx=1&sn=72be66e2caaaebb3cc436b2f5fb6ee0c&scene=21#wechat_redirect)》，发现精彩！

![640.jpg](../_resources/8619af60e2e6b27dc06250c838f2647d.jpg)