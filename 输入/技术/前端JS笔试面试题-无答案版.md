# 前端JS笔试面试题

[TOC]

## 笔试部分

### Q： 下面有关javascript内部对象的描述，正确的有？（多选）

1. History 对象包含用户（在浏览器窗口中）访问过的 URL
2. Location 对象包含有关当前 URL 的信息
3. Window 对象表示浏览器中打开的窗口
4. Navigator 对象包含有关浏览器的信息

### Q：以下哪个是错误的（单选）

1. iframe是用来在网页中插入第三方页面，早期的页面使用iframe主要是用于导航栏这种很多页面都相同的部分，这样在切换页面的时候避免重复下载
2. iframe的创建比一般的DOM元素慢了1-2个数量级
3. iframe标签会阻塞页面的的加载
4. iframe本质是动态语言的Incude机制和利用ajax动态填充内容

###  Q： 写出以下程序的输出结果，为什么？

```javascript
(function() {

    var x=foo();

    var foo=function foo() {
        return "foobar"
    };
    return x;
})();
```

### Q：有完成以下代码， 使其输出结果与注释中的一样（忽略时区信息）

```javascript
var d = new Date('2018-05-09');
//在下面编写代码
d.setDate(40);

console.log(d)//   Sat Jun 09 2018 xxxxx (xxxx)

```

### Q：以下程序输出什么，为什么？

```javascript
function Foo(){
	'use strict'
	console.log(this.location);
}
Foo();
```

### Q：请写出以下程序的输出结果

```javascript
console.log(typeof Date.now());
```

### Q：在 javascript 中，用于阻止默认事件的默认操作的方法是？

### Q：在标准的 JavaScript 中， Ajax 异步执行调用基于下面哪一项机制才能实现(单选)，并写出选择该项的理由

1. Event和callback
2. 多线程操作
3. 多CPU核
4. Deferral和promise

### Q：请写出可以匹配以下16进制颜色值中任意一个的正则表达式

```css
[[ffbbad]]
[[Fc01DF]]
[[FFF]]
[[ffE]]
```

### Q：请写出正则表达式，匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)

### Q：请输出以下程序的执行结果

```javascript
console.log(Function.prototype.__proto__.__proto__ === null);
```

### Q：请写出以下程序的执行结果

```javascript
var a =[1,2,3];
var b = a.slice(0,1);
b.push(4);
console.log(a, b)
```

### Q：请写出以下程序的输出结果

```javascript
var a = 10;
var obj = {
  a: 20,
  fn: function(a){
    this.a += 5;
    let b = 3;
    function fn(a) {
      this.a += 2;
      a += b;
      console.log(this.a + a);
    };
    return fn;
  }
};

var fn = obj.fn(a);
fn(3);
fn(5);
fn(obj.a);
```

### Q：以下程序输出什么，为什么？

```javascript
var tmp = new Date();

function f() {
  console.log(tmp);
  if (false) {
    var tmp = "hello world";
    console.log(tmp);
  }
  console.log(tmp);
}

f();
```

### Q：请写出以下程序的执行结果，为什么？

```javascript
a = 1;
console.log(window.a);

let b = 1;
console.log(window.b);
```

### Q：请在下方列出var与let的区别

### Q：假设当前网址是`http://foouser:barpassword@www.wrox.com:80/WileyCDA/?q=javascript#contents` 请写出以下属性的值：

* `localtion.hash`
* `location.search`
* `location.pathname`
* `location.origin`
* `location.username`

### Q：请写一个方法来判断一个任意值是否为文本节点

### Q  请写一个方法来判断一个对象是否为可迭代对象

### Q： 请使用正则写一个可以过滤文本中所有的`script`标签的函数

### Q：请写出以下程序的输出结果

```javascript
let [foo, , , ,[[bar], ,baz]] = [1,2,3,4,[['a','b'], 'e', {a:1}]];
console.log(foo);
console.log(bar);
console.log(baz);
```

### Q： 请编写一个方法，实现给出任意一个数组，可以去重后返回

### Q： 请完成 `flatten` 方法

```javascript
function flatten(arr){
	
}
var arr = flatten([1,2,[3,4,[5,6,[7,[8]]]]]);
console.log(arr);
// 输出： [ 1, 2, 3, 4, 5, 6, 7, 8 ]
```

### Q： 请实现一个可兼容所有浏览器的DOM事件监听函数

### Q：请完成以下程序：

```javascript
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=3, minimum-scale=1, user-scalable=no">
    <title>canvas存为图片</title>
    <script>
        window.onload = function() {
            draw();
            var dlButton = document.getElementById("downloadImageBtn");
            bindButtonEvent(dlButton, "click", saveAsLocalImage);
        };
        function draw(){
            var canvas = document.getElementById("thecanvas");
            var ctx = canvas.getContext("2d");
            // 绘制一个边长为100的正方形，并填充为透明度50%的黑色,位置随意
            
            
            ctx.fillText("canvas图片下载", 50, 50);
        }

        function bindButtonEvent(element, type, handler)
        {
            if(element.addEventListener) {
                element.addEventListener(type, handler, false);
            } else {
                element.attachEvent('on'+type, handler);
            }
        }

        function saveAsLocalImage () {
            var myCanvas = document.getElementById("thecanvas");
            // 完成该方法，使其可以将canvas内容下载到本地
        }
    </script>
</head>
<body bgcolor="[[E6E6FA]]">
<div>
    <canvas width=200 height=200 id="thecanvas"></canvas>
    <button id="downloadImageBtn">下载为图片</button>
</div>
</body>
</html>
```



### Q：请实现`getCommonAncestor`方法，返回任意两个DOM节点的最近的公共祖先节点

```javascript
function getCommonAncestor (nodeA, nodeB) {
        
}
```

### Q ：请实现`Person` 方法，使其可以通过如下方式被调用

```javascript
var xiaoming  = Person('xiaoming', 23);
xiaoming.name().age();
// 输出：
// xiaoming
// 23
```

### Q 请使用高阶函数分贝完成以下需求

```javascript
var arr = [
	{
		id:1, 
		name: '张三',
    score: 80
	},
  {
		id:2, 
		name: '李四',
    score: 60
	},
  {
		id:3, 
		name: '王五',
    score: 75
	},
  {
		id:4, 
		name: '陈六',
    score: 80
	},
  {
		id:5, 
		name: '鬼脚七',
    score: 80
	},
];


```

1. 返回一个字符串，字符串中是所有score为80的人的ID和名称，如`1-张三`，用逗号分隔。
2. 计算所有人得分的总和

### Q： 列出JS中常见的错误类型，其中哪些是早期错误，并写一个示例程序，抛出一个错误并捕获

### Q： 写出以下程序的执行结果

```javascript
async function async1() {
	console.log('async1 start');
	await async2();
	console.log('async1 end');
}
async function async2() {
	console.log('async2');
}
console.log('script start');
setTimeout(function() {
	console.log('setTimeout');
}, 0)
async1();
new Promise(function(resolve) {
	console.log('promise1');
	resolve();
}).then(function() {
	console.log('promise2');
});
console.log('script end');
```

### Q：`<script>`标签的`async`属性与`defer`属性之间的异同

### Q：请写出以下程序的执行结果，为什么？

```javascript
var  a = ['a1','a2']
var b = a
[0,1].slice(1)
console.log(b)
```

### Q：请写出以下程序的执行结果，为什么

```javascript
{ // 外层块
  let x = "outer";
  { // 内层块
    console.log(x);
    var refX1 = function () { return x };
    console.log(refX1());
    const x = "inner";
    console.log(x);
    var refX2 = function () { return x };
    console.log(refX2());
  }
}
```

### Q： 请完成 `parseQuery` 方法，要求必须使用正则

```javascript
var parseQuery = function (query){
 
}

var obj = parseQuery("name=1&age=2");
console.log(obj); //{ name: '1', age: '2' }
```

### Q：请完成 `concatWithSort`  方法：

```javascript
var arr1 = ["A1", "A2", "B1", "B2", "C1", "C2", "D1", "D2"];
var arr2 = ["A", "B", "C", "D"];

function concatWithSort(arr1, arr2) {
  
}

var arr = concatWithSort(arr1, arr2);
console.log(arr); //  [ 'A1', 'A2', 'A', 'B1', 'B2', 'B', 'C1', 'C2', 'C', 'D1', 'D2', 'D' ]
```

### Q：以下代码，请使用至少两种不同方法实现`a`与`b`的值互换，要求不使用临时变量，并给出解题思路

```javascript
var a = 1;
var b = 2;
```

## 面试部分

### Q：请简述前后端分离架构的优缺点

### Q： 请简述前端都有哪些安全问题，怎么解决

### Q： **浏览器缓存读取规则**

### Q： 简述浏览器的工作流程

### Q： **cookie 和 token 都存放在 header 中，为什么不会劫持 token？**

### Q：**介绍模块化发展历程**
