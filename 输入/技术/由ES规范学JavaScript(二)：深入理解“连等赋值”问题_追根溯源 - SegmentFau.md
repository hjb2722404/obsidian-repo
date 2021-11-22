由ES规范学JavaScript(二)：深入理解“连等赋值”问题_追根溯源 - SegmentFault 思否

 [  ![7baeb8129e97cf8e4daf5c7af91955b7.jpg](../_resources/aaad4254fe6b596a66aa0a5969ca5ffd.jpg)    **manxisuo**](https://segmentfault.com/u/manxisuo)

- 10.6k

- [(L)](https://github.com/manxisuo)

[(L)](https://segmentfault.com/a/1190000004224719#comment-area)

#   [由ES规范学JavaScript(二)：深入理解“连等赋值”问题](https://segmentfault.com/a/1190000004224719)

[es5](https://segmentfault.com/t/es5)[javascript](https://segmentfault.com/t/javascript)

 发布于 2015-12-30

![e23db5d03f090dac18cca396fd53c483.jpg](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

有这样一个热门问题：

	var a = {n: 1};
	var b = a;
	a.x = a = {n: 2};
	alert(a.x); *// --> undefined*
	alert(b.x); *// --> {n: 2}*

其实这个问题很好理解，关键要弄清下面两个知识点：

- JS引擎对**赋值表达式**的处理过程
- 赋值运算的**右结合性**

## 一. 赋值表达式

形如
` A = B`
的表达式称为**赋值表达式**。其中A和B又分别可以是表达式。B可以是任意表达式，但是A必须是一个**左值**。
所谓左值，就是可以被赋值的表达式，在ES规范中是用内部类型**引用(Reference)**描述的。例如：

- 表达式`foo.bar`可以作为一个左值，表示对foo这个对象中bar这个名称的引用；
- 变量`email`可以作为一个左值，表示对当前执行环境中的环境记录项envRec中email这个名称的引用；
- 同样地，函数名`func`可以做左值，然而函数调用表达式`func(a, b)`不可以。

那么JS引擎是怎样计算一般的赋值表达式` A = B`的呢？简单地说，按如下步骤：
1. 计算表达式A，得到一个引用`refA`；
2. 计算表达式B，得到一个值`valueB`；
3. 将`valueB`赋给`refA`指向的名称绑定；
4. 返回`valueB`。

## 二. 结合性

所谓结合性，是指表达式中同一个运算符出现多次时，是左边的优先计算还是右边的优先计算。
赋值表达式是右结合的。这意味着：
`A1 = A2 = A3 = A4`
等价于
`A1 = (A2 = (A3 = A4))`

## 三. 连等的解析

好了，有了上面两部分的知识。下面来看一下JS引擎是怎样运算连等赋值表达式的。
以下面的式子为例：
`Exp1 = Exp2 = Exp3 = Exp4`
首先根据右结合性，可以转换成
`Exp1 = (Exp2 = (Exp3 = Exp4))`
然后，我们已经知道对于单个赋值运算，JS引擎总是先计算左边的操作数，再计算右边的操作数。所以接下来的步骤就是：
1. 计算Exp1，得到Ref1；
2. 计算Exp2，得到Ref2；
3. 计算Exp3，得到Ref3；
4. 计算Exp4，得到Value4。
现在变成了这样的：
`Ref1 = (Ref2 = (Ref3 = Value4))`
接下来的步骤是：
1. 将Value4赋给Exp3；
2. 将Value4赋给Exp2；
3. 将Value4赋给Exp1；
4. 返回表达式最终的结果Value4。
注意：这几个步骤体现了右结合性。
总结一下就是：
> 先**> 从左到右**> 解析各个引用，然后计算最右侧的表达式的值，最后把值**> 从右到左**> 赋给各个引用。

## 四. 问题的解决

现在回到文章开头的问题。
首先前两个var语句执行完后，`a`和`b`都指向同一个对象`{n: 1}`(为方便描述，下面称为对象N1)。然后来看
`a.x = a = {n: 2};`

根据前面的知识，首先依次计算表达式`a.x`和`a`，得到两个引用。其中`a.x`表示对象N1中的x，而`a`相当于`envRec.a`，即当前环境记录项中的a。所以此时可以写出如下的形式：

`[[N1]].x = [[encRec]].a = {n: 2};`
其中，`[[]]`表示引用指向的对象。
接下来，将`{n: 2}`赋值给`[[encRec]].a`，即将`{n: 2}`绑定到当前上下文中的名称`a`。
接下来，将**同一个**`{n: 2}`赋值给`[[N1]].x`，即将`{n: 2}`绑定到N1中的名称`x`。
由于`b`仍然指向`N1`，所以此时有
`b <=> N1 <=> {n: 1, x: {n: 2}}`
而`a`被重新赋值了，所以
`a <=> {n: 2}`
并且
`a === b.x`

## 五. 最后的最后

如果你明白了上面所有的内容，应该会明白`a.x = a = {n:2};`与`b.x = a = {n:2};`是完全等价的。因为在解析`a.x`或`b.x`的那个`时间点`。`a`和`b`这两个名称指向同一个对象，就像C++中同一个对象可以有多个引用一样。而在这个`时间点`之后，不论是`a.x`还是`b.x`，其实早就不存在了，它已经变成了`那个内存中的对象.x`了。

最后用一张图表示整个表达式的运算过程：
![2e5b696c68d7af197e9ba9f4e5bbb377.jpg](../_resources/87be84bb45c3c94f74d247d384b29e0d.jpg)

## 六. 参考文档

[11.13.1 Simple Assignment ( = )](http://es5.github.io/#x11.13.1)

![e23db5d03f090dac18cca396fd53c483.jpg](../_resources/b4491705564909da7f9eaf749dbbfbb1.gif)

阅读 13.3k  更新于 2017-02-11

本作品系 原创， [采用《署名-非商业性使用-禁止演绎 4.0 国际》许可协议](https://creativecommons.org/licenses/by-nc-nd/4.0/)

* * *

 [![7baeb8129e97cf8e4daf5c7af91955b7.jpg](../_resources/aaad4254fe6b596a66aa0a5969ca5ffd.jpg)](https://segmentfault.com/u/manxisuo)

#####   [manxisuo](https://segmentfault.com/u/manxisuo)

- 10.6k

- [(L)](https://github.com/manxisuo)