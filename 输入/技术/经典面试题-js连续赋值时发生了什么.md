# js经典面试题-连续赋值时发生了什么

## 题目

```javascript
var a = {n:1};
var b = a;
a.x = a = {n:2}

console.log(a); // ?
console.log(b); // ?
console.log(a.x) // ?
```

## 考点分析

* 连续赋值的解析是从左到右的
* 连续赋值的运算是从右到左的
* 引用类型变量二次赋值时有一个重新绑定的过程
* 对于引用类型，栈内存里存储的是一个堆内存的指针地址，堆内存里存的才是实际的数据





## 解题过程

1. 前两条语句都是变量绑定声明语句，没什么好说的，关键在于第三条语句`a.x=a={n:2}`.

2. 这条语句的解析时是从左至右的：
   1. 先访问`a.x`属性，此时对象`a` 上没有这个属性，则自动创建一个
   2. 访问`a`
3. 连等运算是从右向左的：即相当于 `a.x = (a={n:2})`;
   1. 先将`n:2`与对象`a`进行绑定，在此之前标识符`a`会先解除与`{n:1}`的绑定，这条赋值计算有返回值，返回值是`{n:2}`的堆内存地址
   2. 在`a`发生重新绑定前，`a.x`其实已经挂起，等待着右边的计算结果，而此时内存中，`a.x`还引用的是之前的内存块`{n:1}`
   3. 将右边计算的结果（即第1条计算的返回值）赋值给`a.x`（其实是`{n:1}.x`）；
4. 最后，再次访问问题中的三个变量（使用console函数）时，
   1. `a` 为 `{n:2}`
   2. `b` 为 `{n:1, x: {n:2}}`
   3. `a.x` 此时才真正指向重新绑定后的`a`，即 `{n:2}.x` ，为`undefined`;

### 堆栈内存运行示意（近似）

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021152436.png)

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021152441.png)

![003](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021152448.png)



![004](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021152454.png)

![005](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021152503.png)

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021152510.png)

![007](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021152515.png)

![008](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021152519.png)

![009](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021152523.png)

![010](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021152528.png)