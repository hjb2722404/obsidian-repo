5分钟读懂JavaScript预编译 - 知乎专栏·「技术放肆聊」

# 5分钟读懂JavaScript预编译

1 年前 · 来自专栏 [技术放肆聊](https://www.zhihu.com/column/skrteam)

>  大家都知道JavaScript是解释型语言，既然是解释型语言，就是编译一行，执行一行，那又何来预编译一说呢?脚本执行js引擎都做了什么呢？今天我们就来看看吧。


## **1-JavaScript运行三部曲**

1. 1语法分析
2. 2预编译
3. 3解释执行

语法分析很简单，就是引擎检查你的代码有没有什么低级的语法错误； 解释执行顾名思义便是执行代码了； 预编译简单理解就是在内存中开辟一些空间，存放一些变量与函数 ；

## **2-JS预编译什么时候发生**

预编译到底什么时候发生? 误以为预编译仅仅发生在script内代码块执行前 这倒并没有错 预编译确确实实在script代码内执行前发生了 但是它大部分会发生在函数执行前

## **3-实例分析**

先来区分理解一下这2个概念： 变量声明 var … 函数声明 function(){}

	<script>
	var a = 1;
	console.log(a);
	function test(a) {
	  console.log(a);
	  var a = 123;
	  console.log(a);
	  function a() {}
	  console.log(a);
	  var b = function() {}
	  console.log(b);
	  function d() {}
	}
	var c = function (){
	console.log("I at C function");
	}
	console.log(c);
	test(2);
	</script>

## **分析过程如下：**

1. 1页面产生便创建了GO全局对象（Global Object）（也就是window对象）；
2. 2第一个脚本文件加载；
3. 3脚本加载完毕后，分析语法是否合法；
4. 4开始预编译 查找变量声明，作为GO属性，值赋予undefined； 查找函数声明，作为GO属性，值赋予函数体；

## **预编译**

	//抽象描述
	    GO/window = {
	        a: undefined,
	        c: undefined，
	        test: function(a) {
	            console.log(a);
	            var a = 123;
	            console.log(a);
	            function a() {}
	            console.log(a);
	            var b = function() {}
	            console.log(b);
	            function d() {}
	        }
	    }

## **解释执行代码（直到执行调用函数test(2)语句）**

	//抽象描述
	    GO/window = {
	        a: 1,
	        c: function (){
	            console.log("I at C function");
	        }
	        test: function(a) {
	            console.log(a);
	            var a = 123;
	            console.log(a);
	            function a() {}
	            console.log(a);
	            var b = function() {}
	            console.log(b);
	            function d() {}
	        }
	    }

## **执行函数test()之前，发生预编译**

1. 1创建AO活动对象（Active Object）；
2. 2查找形参和变量声明，值赋予undefined；
3. 3实参值赋给形参；
4. 4查找函数声明，值赋予函数体；

## **预编译之前面1、2两小步如下：**

	//抽象描述
	    AO = {
	        a:undefined,
	        b:undefined,
	    }

## **预编译之第3步如下：**

	//抽象描述
	        AO = {
	            a:2,
	            b:undefined,
	        }

## **预编译之第4步如下：**

	//抽象描述
	    AO = {
	        a:function a() {},
	        b:undefined
	        d:function d() {}
	    }

## **执行test()函数时如下过程变化：**

	//抽象描述
	    AO = {
	        a:function a() {},
	        b:undefined
	        d:function d() {}
	    }
	    --->
	    AO = {
	        a:123,
	        b:undefined
	        d:function d() {}
	    }
	    --->
	    AO = {
	        a:123,
	        b:function() {}
	        d:function d() {}
	    }

## **执行结果：**

![](data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='843' height='494'></svg>)

## **注意：**

预编译阶段发生变量声明和函数声明，没有初始化行为（赋值），匿名函数不参与预编译 ； 只有在解释执行阶段才会进行变量初始化 ；

## **预编译(函数执行前)**

1. 1创建AO对象（Active Object）
2. 2查找函数形参及函数内变量声明，形参名及变量名作为AO对象的属性，值为undefined
3. 3实参形参相统一，实参值赋给形参
4. 4查找函数声明，函数名作为AO对象的属性，值为函数引用

## **预编译(脚本代码块script执行前)**

1. 1查找全局变量声明（包括隐式全局变量声明，省略var声明），变量名作全局对象的属性，值为undefined
2. 2查找函数声明，函数名作为全局对象的属性，值为函数引用

## **预编译小结**

- • 预编译两个小规则

1. 1函数声明整体提升-(具体点说，无论函数调用和声明的位置是前是后，系统总会把函数声明移到调用前面）
2. 2变量 声明提升-(具体点说，无论变量调用和声明的位置是前是后，系统总会把声明移到调用前，注意仅仅只是声明，所以值是undefined）

- • 预编译前奏

1. 1imply global 即任何变量，如果未经声明就赋值，则此变量就位全局变量所有。(全局域就是Window)
2. 2一切声明的全局变量，全是window的属性； var a = 12;等同于Window.a = 12;

- • 函数预编译发生在函数执行前一刻。

![](data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='900' height='500'></svg>)

发布于 2019-01-23
[JavaScript](https://www.zhihu.com/topic/19552521)