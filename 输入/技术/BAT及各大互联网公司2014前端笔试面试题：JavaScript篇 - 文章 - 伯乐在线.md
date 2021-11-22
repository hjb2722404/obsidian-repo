BAT及各大互联网公司2014前端笔试面试题：JavaScript篇 - 文章 - 伯乐在线

原文出处： [Ico_Coco 的博客（@CHoK__Coco_mAm）](http://www.cnblogs.com/coco1s/p/4029708.html)

很多面试题是我自己面试BAT亲身经历碰到的。整理分享出来希望更多的前端er共同进步吧，不仅适用于求职者，对于巩固复习前端基础更是大有裨益。
而更多的题目是我一路以来收集的，也有往年的，答案不确保一定正确，如有错误或有更好的解法，还请斧正。
前面几题是会很基础，越下越有深度。
附上第二篇：[BAT及各大互联网公司2014前端笔试面试题–Html,Css篇](http://blog.jobbole.com/78740)
前面几题是会很基础，越下越有深度。

# **初级Javascript：**

**1.JavaScript是一门什么样的语言，它有哪些特点？**
没有标准答案。
**2.JavaScript的数据类型都有什么？**
基本数据类型：String,boolean,Number,Undefined, Null
引用数据类型：Object(Array,Date,RegExp,Function)
那么问题来了，如何判断某变量是否为数组数据类型？

- 方法一.判断其是否具有“数组性质”，如slice()方法。可自己给该变量定义slice方法，故有时会失效
- 方法二.obj instanceof Array 在某些IE版本中不正确
- 方法三.方法一二皆有漏洞，在ECMA Script5中定义了新方法Array.isArray(), 保证其兼容性，最好的方法如下：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | if(typeof  Array.isArray==="undefined")<br>{<br>  Array.isArray  =  function(arg){<br>        return  Object.prototype.toString.call(arg)==="[object Array]"<br>    };<br>} |

**3.已知ID的Input输入框，希望获取这个输入框的输入值，怎么做？(不使用第三方框架)**

JavaScript

|     |     |
| --- | --- |
| 1   | document.getElementById(“ID”).value |

**4.希望获取到页面中所有的checkbox怎么做？(不使用第三方框架)**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8 | var  domList  =  document.getElementsByTagName(‘input’)<br>var  checkBoxList  =  [];<br>var  len  =  domList.length;　　*//缓存到局部变量*<br>while  (len--)  {　　*//使用while的效率会比for循环更高*<br>　　if  (domList[len].type  ==  ‘checkbox’)  {<br>    　　checkBoxList.push(domList[len]);<br>　　}<br>} |

**5.设置一个已知ID的DIV的html内容为xxxx，字体颜色设置为黑色(不使用第三方框架)**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3 | var  dom  =  document.getElementById(“ID”);<br>dom.innerHTML  =  “xxxx”<br>dom.style.color  =  “#000” |

**6.当一个DOM节点被点击时候，我们希望能够执行一个函数，应该怎么做？**

- 直接在DOM里绑定事件：<div onclick=”test()”></div>
- 在JS里通过onclick绑定：xxx.onclick = test
- 通过事件添加进行绑定：addEventListener(xxx, ‘click’, test)

那么问题来了，Javascript的事件流模型都有什么？

- “事件冒泡”：事件开始由最具体的元素接受，然后逐级向上传播
- “事件捕捉”：事件由最不具体的节点先接收，然后逐级向下，一直到最具体的
- “DOM事件流”：三个阶段：事件捕捉，目标阶段，事件冒泡

**7.什么是Ajax和JSON，它们的优缺点。**
Ajax是异步JavaScript和XML，用于在Web页面中实现异步数据交互。
优点：

- 可以使得页面不重载全部内容的情况下加载局部内容，降低数据传输量
- 避免用户不断刷新或者跳转页面，提高用户体验

缺点：

- 对搜索引擎不友好（
- 要实现ajax下的前后退功能成本较大
- 可能造成请求数的增加
- 跨域问题限制

JSON是一种轻量级的数据交换格式，ECMA的一个子集
优点：轻量级、易于人的阅读和编写，便于机器（JavaScript）解析，支持复合数据类型（数组、对象、字符串、数字）
** 8.看下列代码输出为何？解释原因。**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3 | var  a;<br>alert(typeof  a);  *// undefined*<br>alert(b);  *// 报错* |

解释：Undefined是一个只有一个值的数据类型，这个值就是“undefined”，在使用var声明变量但并未对其赋值进行初始化时，这个变量的值就是undefined。而b由于未声明将报错。注意未申明的变量和声明了未赋值的是不一样的。

** 9.看下列代码,输出什么？解释原因。**

JavaScript

|     |     |
| --- | --- |
| 1<br>2 | var  a  =  null;<br>alert(typeof  a);  *//object* |

解释：null是一个只有一个值的数据类型，这个值就是null。表示一个空指针对象，所以用typeof检测会返回”object”。
** 10.看下列代码,输出什么？解释原因。**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9 | var  undefined;<br>undefined  ==  null;  *// true*<br>1  ==  true;   *// true*<br>2  ==  true;   *// false*<br>0  ==  false;  *// true*<br>0  ==  '';     *// true*<br>NaN  ==  NaN;  *// false*<br>[]  ==  false;  *// true*<br>[]  ==  ![];   *// true* |

- undefined与null相等，但不恒等（===）
- 一个是number一个是string时，会尝试将string转换为number
- 尝试将boolean转换为number，0或1
- 尝试将Object转换成number或string，取决于另外一个对比量的类型
- 所以，对于0、空字符串的判断，建议使用 “===” 。“===”会先判断两边的值类型，类型不匹配时为false。

那么问题来了，看下面的代码，输出什么，foo的值为什么？

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3 | var  foo  =  "11"+2-"1";<br>console.log(foo);<br>console.log(typeof  foo); |

执行完后foo的值为111，foo的类型为String。
** 11.看代码给答案。**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | var  a  =  new  Object();<br>a.value  =  1;<br>b  =  a;<br>b.value  =  2;<br>alert(a.value); |

答案：2（考察引用数据类型细节）

**12.已知数组var stringArray = [“This”, “is”, “Baidu”, “Campus”]，Alert出”This is Baidu Campus”。**

答案：alert(stringArray.join(“”))
已知有字符串foo=”get-element-by-id”,写一个function将其转化成驼峰表示法”getElementById”。

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8 | function  combo(msg){<br>    var  arr=msg.split("-");<br>    for(var  i=1;i<arr.length;i++){<br>        arr[i]=arr[i].charAt(0).toUpperCase()+arr[i].substr(1,arr[i].length-1);<br>    }<br>    msg=arr.join("");<br>    return  msg;<br>} |

(考察基础API)
13.var numberArray = [3,6,2,4,1,5]; （考察基础API）
1) 实现对该数组的倒排，输出[5,1,4,2,6,3]
2) 实现对该数组的降序排列，输出[6,5,4,3,2,1]

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8 | function  combo(msg){<br>    var  arr=msg.split("-");<br>    for(var  i=1;i<arr.length;i++){<br>        arr[i]=arr[i].charAt(0).toUpperCase()+arr[i].substr(1,arr[i].length-1);<br>    }<br>    msg=arr.join("");<br>    return  msg;<br>} |

**14.输出今天的日期，以YYYY-MM-DD的方式，比如今天是2014年9月26日，则输出2014-09-26**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11 | var  d  =  new  Date();<br>*// 获取年，getFullYear()返回4位的数字*<br>var  year  =  d.getFullYear();<br>*// 获取月，月份比较特殊，0是1月，11是12月*<br>var  month  =  d.getMonth()  +  1;<br>*// 变成两位*<br>month  =  month  <  10  ?  '0'  +  month  :  month;<br>*// 获取日*<br>var  day  =  d.getDate();<br>day  =  day  <  10  ?  '0'  +  day  :  day;<br>alert(year  +  '-'  +  month  +  '-'  +  day); |

**15.将字符串”<tr><td>{$id}</td><td>{$name}</td></tr>”中的{$id}替换成10，{$name}替换成Tony （使用正则表达式）**

答案：”<tr><td>{$id}</td><td>{$id}_{$name}</td></tr>”.replace(/{\$id}/g, ’10’).replace(/{\$name}/g, ‘Tony’);

**16.为了保证页面输出安全，我们经常需要对一些特殊的字符进行转义，请写一个函数escapeHtml，将<, >, &, “进行转义**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14 | function  escapeHtml(str)  {<br>return  str.replace(*/[<>”&]/g*,  function(match)  {<br>    switch  (match)  {<br>                   case  “<”:<br>                      return  “&lt;”;<br>                   case  “>”:<br>                      return  “&gt;”;<br>                   case  “&”:<br>                      return  “&amp;”;<br>                   case  “\””:<br>                      return  “&quot;”;<br>      }<br>  });<br>} |

**17.foo = foo||bar ，这行代码是什么意思？为什么要这样写？**
答案：if(!foo) foo = bar; //如果foo存在，值不变，否则把bar的值赋给foo。
短路表达式：作为”&&”和”||”操作符的操作数表达式，这些表达式在进行求值时，只要最终的结果已经可以确定是真或假，求值过程便告终止，这称之为短路求值。
**18.看下列代码，将会输出什么?**(变量声明提升)

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | var  foo  =  1;<br>function(){<br>    console.log(foo);<br>    var  foo  =  2;<br>    console.log(foo);<br>} |

答案：输出undefined 和 2。上面代码相当于：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7 | var  foo  =  1;<br>function(){<br>    var  foo;<br>    console.log(foo);  *//undefined*<br>    foo  =  2;<br>    console.log(foo);  *// 2;   *<br>} |

函数声明与变量声明会被JavaScript引擎隐式地提升到当前作用域的顶部，但是只提升名称不会提升赋值部分。
**19.用js实现随机选取10–100之间的10个数字，存入一个数组，并排序。**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9 | var  iArray  =  [];<br>funtion getRandom(istart,  iend){<br>        var  iChoice  =  istart  -  iend  +1;<br>        return  Math.floor(Math.random()  *  iChoice  +  istart;<br>}<br>for(var  i=0;  i<10;  i++){<br>        iArray.push(getRandom(10,100));<br>}<br>iArray.sort(); |

**20.把两个数组合并，并删除第二个元素。**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4 | var  array1  =  ['a','b','c'];<br>var  bArray  =  ['d','e','f'];<br>var  cArray  =  array1.concat(bArray);<br>cArray.splice(1,1); |

**21.怎样添加、移除、移动、复制、创建和查找节点（原生JS，实在基础，没细写每一步）**
1）创建新节点
createDocumentFragment()    //创建一个DOM片段
createElement()   //创建一个具体的元素
createTextNode()   //创建一个文本节点
2）添加、移除、替换、插入
appendChild()      //添加
removeChild()      //移除
replaceChild()      //替换
insertBefore()      //插入
3）查找
getElementsByTagName()    //通过标签名称
getElementsByName()     //通过元素的Name属性的值
getElementById()        //通过元素Id，唯一性

**22.有这样一个URL：http://item.taobao.com/item.htm?a=1&b=2&c=&d=xxx&e，请写一段JS程序提取URL中的各个GET参数(参数名和参数个数不确定)，将其按key-value形式返回到一个json结构中，如{a:’1′, b:’2′, c:”, d:’xxx’, e:undefined}。**

答案：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9 | function  serilizeUrl(url)  {<br>    var  result  =  {};<br>    url  =  url.split("?")[1];<br>    var  map  =  url.split("&");<br>    for(var  i  =  0,  len  =  map.length;  i  <  len;  i++)  {<br>        result[map[i].split("=")[0]]  =  map[i].split("=")[1];<br>    }<br>    return  result;<br>} |

**23.正则表达式构造函数var reg=new RegExp(“xxx”)与正则表达字面量var reg=//有什么不同？匹配邮箱的正则表达式？**
**答案：当使用RegExp()构造函数的时候，不仅需要转义引号（即\”表示”），并且还需要双反斜杠（即\\表示一个\）。使用正则表达字面量的效率更高。 **
**邮箱**的正则匹配：

JavaScript

|     |     |
| --- | --- |
| 1   | var  regMail  =  /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((.[a-zA-Z0-9_-]{2,3}){1,2})$/; |

**24.看下面代码，给出输出结果。**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | for(var  i=1;i<=3;i++){<br>  setTimeout(function(){<br>      console.log(i);<br>  },0);<br>}; |

答案：4 4 4。
原因：Javascript事件处理器在线程空闲之前不会运行。追问，如何让上述代码输出1 2 3？

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9 | for(var  i=1;i<=3;i++){<br>   setTimeout((function(a){  *//改成立即执行函数*<br>       console.log(a);<br>   })(i),0);<br>};<br>1           *//输出*<br>2<br>3 |

**25.写一个function，清除字符串前后的空格。（兼容所有浏览器）**
使用自带接口trim()，考虑兼容性：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9 | if  (!String.prototype.trim)  {<br> String.prototype.trim  =  function()  {<br> return  this.replace(/^\s+/,  "").replace(/\s+$/,"");<br> }<br>}<br>*// test the function *<br>var  str  =  " \t\n test string ".trim();<br>alert(str  ==  "test string");  *// alerts "true"* |

26.Javascript中callee和caller的作用？
答案：
caller是返回一个对函数的引用，该函数调用了当前函数；
callee是返回正在被执行的function函数，也就是所指定的function对象的正文。

**那么问题来了？**如果一对兔子每月生一对兔子；一对新生兔，从第二个月起就开始生兔子；假定每对兔子都是一雌一雄，试问一对兔子，第n个月能繁殖成多少对兔子？（使用callee完成）

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16 | var  result=[];<br>function  fn(n){  *//典型的斐波那契数列*<br>   if(n==1){<br>        return  1;<br>   }else  if(n==2){<br>           return  1;<br>   }else{<br>        if(result[n]){<br>                return  result[n];<br>        }else{<br>                *//argument.callee()表示fn()*<br>                result[n]=arguments.callee(n-1)+arguments.callee(n-2);<br>                return  result[n];<br>        }<br>   }<br>} |

# **中级Javascript：**

**1.实现一个函数clone，可以对JavaScript中的5种主要的数据类型（包括Number、String、Object、Array、Boolean）进行值复制**

- 考察点1：对于基本数据类型和引用数据类型在内存中存放的是值还是指针这一区别是否清楚
- 考察点2：是否知道如何判断一个变量是什么类型的
- 考察点3：递归算法的设计

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21<br>22<br>23<br>24<br>25<br>26<br>27<br>28<br>29<br>30<br>31<br>32<br>33<br>34 | *// 方法一：*<br>Object.prototype.clone  =  function(){<br>        var  o  =  this.constructor  ===  Array  ?  []  :  {};<br>        for(var  e  in  this){<br>                o[e]  =  typeof  this[e]  ===  "object"  ?  this[e].clone()  :  this[e];<br>        }<br>        return  o;<br>}<br>*//方法二：*<br>  */***<br>*     * 克隆一个对象*<br>*     * @param Obj*<br>*     * @returns*<br>*     */*<br>    function  clone(Obj)  {<br>        var  buf;<br>        if  (Obj instanceof  Array)  {<br>            buf  =  [];                    *//创建一个空的数组 *<br>            var  i  =  Obj.length;<br>            while  (i--)  {<br>                buf[i]  =  clone(Obj[i]);<br>            }<br>            return  buf;<br>        }else  if  (Obj instanceof  Object){<br>            buf  =  {};                   *//创建一个空对象 *<br>            for  (var  k  in  Obj)  {           *//为这个对象添加新的属性 *<br>                buf[k]  =  clone(Obj[k]);<br>            }<br>            return  buf;<br>        }else{                         *//普通变量直接赋值*<br>            return  Obj;<br>        }<br>    } |

**2.如何消除一个数组里面重复的元素？**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20 | var  arr=[1,2,3,3,4,4,5,5,6,1,9,3,25,4];<br>        function  deRepeat(){<br>            var  newArr=[];<br>            var  obj={};<br>            var  index=0;<br>            var  l=arr.length;<br>            for(var  i=0;i<l;i++){<br>                if(obj[arr[i]]==undefined)<br>                  {<br>                    obj[arr[i]]=1;<br>                    newArr[index++]=arr[i];<br>                  }<br>                else  if(obj[arr[i]]==1)<br>                  continue;<br>            }<br>            return  newArr;<br>        }<br>        var  newArr2=deRepeat(arr);<br>        alert(newArr2);  *//输出1,2,3,4,5,6,9,25* |

**3.小贤是一条可爱的小狗(Dog)，它的叫声很好听(wow)，每次看到主人的时候就会乖乖叫一声(yelp)。从这段描述可以得到以下对象：**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8 | function  Dog()  {<br>       this.wow  =  function()  {<br>               alert(’Wow’);<br>      }<br>       this.yelp  =  function()  {<br>              this.wow();<br>      }<br>} |

小芒和小贤一样，原来也是一条可爱的小狗，可是突然有一天疯了**(MadDog)，一看到人就会每隔半秒叫一声(wow)地不停叫唤(yelp)。请根据描述，按示例的形式用代码来实。**（继承，原型，setInterval）

答案：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15 | function  MadDog()  {<br>    this.yelp  =  function()  {<br>          var  self  =  this;<br>          setInterval(function()  {<br>                self.wow();<br>          },  500);<br>      }<br>}<br>MadDog.prototype  =  new  Dog();<br>*//for test*<br>var  dog  =  new  Dog();<br>dog.yelp();<br>var  madDog  =  new  MadDog();<br>madDog.yelp(); |

**4.下面这个ul，如何点击每一列的时候alert其index?（**闭包）

XHTML

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | <ul id=”test”><br><li>这是第一条</li><br><li>这是第二条</li><br><li>这是第三条</li><br></ul> |

答案：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21 | *// 方法一：*<br>var  lis=document.getElementById('2223').getElementsByTagName('li');<br>for(var  i=0;i<3;i++)<br>{<br>    lis[i].index=i;<br>    lis[i].onclick=function(){<br>        alert(this.index);<br>    };<br>}<br>*//方法二：*<br>var  lis=document.getElementById('2223').getElementsByTagName('li');<br>for(var  i=0;i<3;i++)<br>{<br>    lis[i].index=i;<br>    lis[i].onclick=(function(a){<br>        return  function()  {<br>            alert(a);<br>        }<br>    })(i);<br>} |

**5.编写一个JavaScript函数，输入指定类型的选择器(仅需支持id，class，tagName三种简单CSS选择器，无需兼容组合选择器)可以返回匹配的DOM节点，需考虑浏览器兼容性和性能。**

/*** @param selector {String} 传入的CSS选择器。* @return {Array}*/
答案：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21<br>22<br>23<br>24<br>25<br>26<br>27<br>28<br>29<br>30<br>31<br>32<br>33<br>34<br>35<br>36<br>37<br>38<br>39<br>40<br>41<br>42<br>43<br>44<br>45<br>46<br>47<br>48<br>49<br>50<br>51<br>52<br>53<br>54<br>55<br>56<br>57 | var  query  =  function(selector)  {<br>                var  reg  =  */^(#)?(\.)?(\w+)$/i*mg;<br>                var  regResult  =  reg.exec(selector);<br>                var  result  =  [];<br>                *//如果是id选择器*<br>                if(regResult[1])  {<br>                    if(regResult[3])  {<br>                        if(typeof  document.querySelector  ===  "function")  {<br>                            result.push(document.querySelector(regResult[3]));<br>                        }<br>                        else  {<br>                            result.push(document.getElementById(regResult[3]));<br>                        }<br>                    }<br>                }<br>                *//如果是class选择器*<br>                else  if(regResult[2])  {<br>                    if(regResult[3])  {<br>                        if(typeof  document.getElementsByClassName  ===  'function')  {<br>                            var  doms  =  document.getElementsByClassName(regResult[3]);<br>                            if(doms)  {<br>                                result  =  converToArray(doms);<br>                            }<br>                        }<br>                        *//如果不支持getElementsByClassName函数*<br>                        else  {<br>                            var  allDoms  =  document.getElementsByTagName("*")  ;<br>                            for(var  i  =  0,  len  =  allDoms.length;  i  <  len;  i++)  {<br>                                if(allDoms[i].className.search(new  RegExp(regResult[2]))  >  -1)  {<br>                                    result.push(allDoms[i]);<br>                                }<br>                            }<br>                        }<br>                    }<br>                }<br>                *//如果是标签选择器*<br>                else  if(regResult[3])  {<br>                    var  doms  =  document.getElementsByTagName(regResult[3].toLowerCase());<br>                    if(doms)  {<br>                        result  =  converToArray(doms);<br>                    }<br>                }<br>                return  result;<br>            }<br>            function  converToArray(nodes){<br>                  var  array  =  null;<br>                  try{<br>                        array  =  Array.prototype.slice.call(nodes,0);*//针对非IE浏览器         *<br>                  }catch(ex){<br>                      array  =  new  Array();<br>                      for(  var  i  =  0  ,len  =  nodes.length;  i  <  len  ;  i++  )  {<br>                          array.push(nodes[i])<br>                      }<br>                  }<br>                  return  array;<br>          } |

**6.请评价以下代码并给出改进意见。**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12 | if(window.addEventListener){<br>    var  addListener  =  function(el,type,listener,useCapture){<br>        el.addEventListener(type,listener,useCapture);<br>  };<br>}<br>else  if(document.all){<br>    addListener  =  function(el,type,listener){<br>        el.attachEvent("on"+type,function(){<br>          listener.apply(el);<br>      });<br>   }<br>} |

评价：

- 不应该在if和else语句中声明addListener函数，应该先声明；
- 不需要使用window.addEventListener或document.all来进行检测浏览器，应该使用能力检测；
- 由于attachEvent在IE中有this指向问题，所以调用它时需要处理一下

改进如下：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13 | function  addEvent(elem,  type,  handler){<br>　　if(elem.addEventListener){<br>　　　　elem.addEventListener(type,  handler,  false);<br>　　}else  if(elem.attachEvent){<br>　　　　elem['temp'  +  type  +  handler]  =  handler;<br>　　　　elem[type  +  handler]  =  function(){<br>　　　　elem['temp'  +  type  +  handler].apply(elem);<br>　　};<br>　　elem.attachEvent('on'  +  type,  elem[type  +  handler]);<br>  }else{<br>　　elem['on'  +  type]  =  handler;<br>　　}<br>} |

**7.给String对象添加一个方法，传入一个string类型的参数，然后将string的每个字符间价格空格返回，例如：**
**addSpace(“hello world”) // -> ‘h e l l o  w o r l d’**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3 | String.prototype.spacify  =  function(){<br>      return  this.split('').join(' ');<br>    }; |

接着上述问题答案提问，1）直接在对象的原型上添加方法是否安全？尤其是在Object对象上。(这个我没能答出？希望知道的说一下。)　2）函数声明与函数表达式的区别？

答案：在js中，解析器在向执行环境中加载数据时，对函数声明和函数表达式并非是一视同仁的，解析器会率先读取函数声明，并使其在执行任何代码之前可用（可以访问），至于函数表达式，则必须等到解析器执行到它所在的代码行，才会真正被解析执行。

**8.定义一个log方法，让它可以代理console.log的方法。**
可行的方法一：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5 | function  log(msg)　{<br>    console.log(msg);<br>}<br>log("hello world!")  *// hello world!* |

如果要传入多个参数呢？显然上面的方法不能满足要求，所以更好的方法是：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3 | function  log(){<br>    console.log.apply(console,  arguments);<br>}; |

到此，追问apply和call方法的异同。
答案：

对于apply和call两者在作用上是相同的，即是调用一个对象的一个方法，以另一个对象替换当前对象。将一个函数的对象上下文从初始的上下文改变为由 thisObj 指定的新对象。

但两者在参数上有区别的。对于第一个参数意义都一样，但对第二个参数： apply传入的是一个参数数组，也就是将多个参数组合成为一个数组传入，而call则作为call的参数传入（从第二个参数开始）。 如 func.call(func1,var1,var2,var3)对应的apply写法为：func.apply(func1,[var1,var2,var3]) 。

**9.在Javascript中什么是伪数组？如何将伪数组转化为标准数组？**
答案：

伪数组（类数组）：无法直接调用数组方法或期望length属性有什么特殊的行为，但仍可以对真正数组遍历方法来遍历它们。典型的是函数的argument参数，还有像调用getElementsByTagName,document.childNodes之类的,它们都返回NodeList对象都属于伪数组。可以使用Array.prototype.slice.call(fakeArray)将数组转化为真正的Array对象。

假设接第八题题干，我们要给每个log方法添加一个”(app)”前缀，比如’hello world!’ ->'(app)hello world!’。方法如下：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6 | function  log(){<br>      var  args  =  Array.prototype.slice.call(arguments);  *//为了使用unshift数组方法，将argument转化为真正的数组*<br>      args.unshift('(app)');<br>      console.log.apply(console,  args);<br>    }; |

**10.对作用域上下文和this的理解，看下列代码：**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12 | var  User  =  {<br>  count:  1,<br>  getCount:  function()  {<br>    return  this.count;<br>  }<br>};<br>console.log(User.getCount());  *// what?*<br>var  func  =  User.getCount;<br>console.log(func());  *// what?* |

问两处console输出什么？为什么？
答案是1和undefined。
func是在winodw的上下文中被执行的，所以会访问不到count属性。

继续追问，那么如何确保Uesr总是能访问到func的上下文，即正确返回1。正确的方法是使用Function.prototype.bind。兼容各个浏览器完整代码如下：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10 | Function.prototype.bind  =  Function.prototype.bind  \|\|  function(context){<br>   var  self  =  this;<br>   return  function(){<br>      return  self.apply(context,  arguments);<br>   };<br>}<br>var  func  =  User.getCount.bind(User);<br>console.log(func()); |

**11.原生JS的window.onload与Jquery的$(document).ready(function(){})有什么不同？如何用原生JS实现Jq的ready方法？**

window.onload()方法是必须等到页面内包括图片的所有元素加载完毕后才能执行。
$(document).ready()是DOM结构绘制完毕后就执行，不必等到加载完毕。

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21<br>22<br>23<br>24<br>25<br>26<br>27<br>28<br>29<br>30<br>31<br>32<br>33<br>34<br>35<br>36<br>37<br>38<br>39<br>40<br>41<br>42 | */**<br>* * 传递函数给whenReady()*<br>* * 当文档解析完毕且为操作准备就绪时，函数作为document的方法调用*<br>* */*<br>var  whenReady  =  (function()  {               *//这个函数返回whenReady()函数*<br>    var  funcs  =  [];             *//当获得事件时，要运行的函数*<br>    var  ready  =  false;          *//当触发事件处理程序时,切换为true*<br>    *//当文档就绪时,调用事件处理程序*<br>    function  handler(e)  {<br>        if(ready)  return;       *//确保事件处理程序只完整运行一次*<br>        *//如果发生onreadystatechange事件，但其状态不是complete的话,那么文档尚未准备好*<br>        if(e.type  ===  'onreadystatechange'  &&  document.readyState  !==  'complete')  {<br>            return;<br>        }<br>        *//运行所有注册函数*<br>        *//注意每次都要计算funcs.length*<br>        *//以防这些函数的调用可能会导致注册更多的函数*<br>        for(var  i=0;  i<funcs.length;  i++)  {<br>            funcs[i].call(document);<br>        }<br>        *//事件处理函数完整执行,切换ready状态, 并移除所有函数*<br>        ready  =  true;<br>        funcs  =  null;<br>    }<br>    *//为接收到的任何事件注册处理程序*<br>    if(document.addEventListener)  {<br>        document.addEventListener('DOMContentLoaded',  handler,  false);<br>        document.addEventListener('readystatechange',  handler,  false);            *//IE9+*<br>        window.addEventListener('load',  handler,  false);<br>    }else  if(document.attachEvent)  {<br>        document.attachEvent('onreadystatechange',  handler);<br>        window.attachEvent('onload',  handler);<br>    }<br>    *//返回whenReady()函数*<br>    return  function  whenReady(fn)  {<br>        if(ready)  {  fn.call(document);  }<br>        else  {  funcs.push(fn);  }<br>    }<br>})(); |

如果上述代码十分难懂，下面这个简化版：

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16 | function  ready(fn){<br>    if(document.addEventListener)  {        *//标准浏览器*<br>        document.addEventListener('DOMContentLoaded',  function()  {<br>            *//注销事件, 避免反复触发*<br>            document.removeEventListener('DOMContentLoaded',arguments.callee,  false);<br>            fn();            *//执行函数*<br>        },  false);<br>    }else  if(document.attachEvent)  {        *//IE*<br>        document.attachEvent('onreadystatechange',  function()  {<br>            if(document.readyState  ==  'complete')  {<br>                document.detachEvent('onreadystatechange',  arguments.callee);<br>                fn();        *//函数执行*<br>            }<br>        });<br>    }<br>}; |

12.（设计题）想实现一个对页面某个节点的拖曳？如何做？（使用原生JS）
回答出概念即可，下面是几个要点
1. 给需要拖拽的节点绑定mousedown, mousemove, mouseup事件
2. mousedown事件触发后，开始拖拽
3. mousemove时，需要通过event.clientX和clientY获取拖拽位置，并实时更新位置
4. mouseup时，拖拽结束
5. 需要注意浏览器边界的情况
**13.**

[![171232302169311](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107175636.png)](http://jbcdn2.b0.upaiyun.com/2014/10/a2e3bf5eab2f56af1010d2d0153ed19d.png)

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20<br>21<br>22<br>23<br>24<br>25<br>26<br>27<br>28<br>29<br>30<br>31<br>32<br>33<br>34<br>35<br>36<br>37<br>38<br>39<br>40<br>41<br>42<br>43<br>44<br>45<br>46 | function  setcookie(name,value,days){  *//给cookie增加一个时间变量*<br>　　var  exp  =  new  Date();<br>　　exp.setTime(exp.getTime()  +  days*24*60*60*1000);  *//设置过期时间为days天*<br>　　document.cookie  =  name  +  "="+  escape  (value)  +  ";expires="  +  exp.toGMTString();<br>}<br>function  getCookie(name){<br>　　var  result  =  "";<br>　　var  myCookie  =  ""+document.cookie+";";<br>　　var  searchName  =  "+name+"=";<br>　　var startOfCookie = myCookie.indexOf(searchName);<br>　　var endOfCookie;<br>　　if(satrtOfCookie != -1){<br>　　　　startOfcookie += searchName.length;<br>　　　　endOfCookie = myCookie.indexOf(";",startOfCookie);<br>　　　　result = (myCookie.substring(startOfCookie,endOfCookie));<br>　　}<br>　　return result;<br>}<br>(function(){<br>　　var oTips = document.getElementById('tips');//假设tips的id为tips<br>　　var page = {<br>　　check: function(){//检查tips的cookie是否存在并且允许显示<br>　　　　var tips = getCookie('tips');<br>　　　　if(!tips \|\| tips == 'show') return true;//tips的cookie不存在<br>　　　　if(tips == "never_show_again") return false;<br>　　},<br>　　hideTip: function(bNever){<br>　　　　if(bNever) setcookie('tips', 'never_show_again', 365);<br>　　　　oTips.style.display = "none";//隐藏<br>　　},<br>　　showTip: function(){<br>　　oTips.style.display = "inline";*//显示，假设tips为行级元素*<br>　　},<br>　　init:  function(){<br>　　　　var  _this  =  this;<br>　　　　if(this.check()){<br>　　　　_this.showTip();<br>　　　　setcookie('tips',  'show',  1);<br>　　}<br>　　oTips.onclick  =  function(){<br>　　　　_this.hideTip(true);<br>　　};<br>　　}<br>　　};<br>  page.init();<br>})(); |

**14.说出以下函数的作用是？空白区域应该填写什么？**

JavaScript

|     |     |
| --- | --- |
| 1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br>13<br>14<br>15<br>16<br>17<br>18<br>19<br>20 | *//define *<br>(function(window){<br>    function  fn(str){<br>        this.str=str;<br>    }<br>    fn.prototype.format  =  function(){<br>        var  arg  =  ______;<br>        return  this.str.replace(_____,function(a,b){<br>             return  arg[b]\|\|"";<br>      });<br>    }<br>    window.fn  =  fn;<br>})(window);<br>*//use*<br>(function(){<br>    var  t  =  new  fn('<p><a href="{0}">{1}</a><span>{2}</span></p>');<br>    console.log(t.format('http://www.alibaba.com','Alibaba','Welcome'));<br>})(); |

答案：访函数的作用是使用format函数将函数的参数替换掉{0}这样的内容，返回一个格式化后的结果：
第一个空是：arguments
第二个空是：/\{(\d+)\}/ig
** 15.用面向对象的Javascript来介绍一下自己。（没答案哦亲，自己试试吧）**
答案： 对象或者Json都是不错的选择哦，
觉得题目还ok的亲点个推荐哦，题量会不断增加。
你可能会感兴趣：[BAT及各大互联网公司2014前端笔试面试题–Html,Css篇](http://blog.jobbole.com/?p=78740)
暂且贴出我做出答案的部分。有时间把未做出答案也贴出来。针对文中各题，如有更好的解决方法或者错误之处，各位亲务必告知我，误人子弟实乃罪过。
觉得题目还ok的亲点个推荐哦，题量会不断增加。

拿高薪，还能扩大业界知名度！优秀的开发工程师看过来 ->《[高薪招募讲师](http://blog.jobbole.com/99511/)》

 **  3 赞  ** 27 收藏  [** 13 评论](http://blog.jobbole.com/78738/#article-comment)

         [(L)](http://www.jiathis.com/share?uid=1745061)