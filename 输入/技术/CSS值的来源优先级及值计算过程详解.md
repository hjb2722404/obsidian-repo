# `CSS`值的来源、优先级及值计算过程详解

## 1. CSS值的来源

深入了解过`CSS` 的同学都知道，`CSS` 样式的来源有五种：

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201211152946.png)

当然，这是基于样式声明所在位置的不同来划分的。

而今天我们要讲的是`CSS`的**值**的来源，它同样有五种来源：

* 用户代理声明（浏览器默认样式值）
* 用户声明（使用者通过浏览器提供的接口设置的值）
* 作者声明（开发者声明的值）

上面三种是规范里规定的三种基础的值来源，还有两种扩展的值来源

* 过渡声明（通过`transition`设置的值）
* 动画声明（通过`animation` 设置的值）。

## 2. CSS值的计算过程

`CSS`在确定最终布局时所要使用的实际值时，实际上是经过了复杂的计算过程的，在这个计算过程中，涉及到了六种值类型，它们分别是：

1. 声明值：各种来源的样式表里对于属性声明的值；

2. 层叠值：同一个属性有多个声明值时产生层叠，这些声明值中获胜的值成为层叠值；

3. 指定值：为某个元素特别指定的值，大多数情况下，指定值就是层叠值，如果没有级联值，则就是指定值。

4. 计算值：对指定值的解析结果，比如 `em` 值会被解析为 `px` 值

5. 使用值： 是取得计算值后完成剩余计算后的值，它是文档布局中使用的绝对理论值，比如计算值`width:auto`计算完成后的使用值可能是绝地长度`120px`, 又比如计算值是百分比 `80%`，完成剩余计算后可能使用值是也是一个绝对像素值 `300px`；

6. 实际值：根据用户代理的处理能力调整后的最终值，比如如果使用值是`border-width:4.2px`,但是用户代理只能处理整数边框，所以实际值是`4px`,又比如字体大小的使用值是：`14.2px`，但是用户代理可能最终使用的是`14px`;

我们知道，`window`对象有一个成员方法`getComputedStyle` 方法可以用来获取某个元素的各个属性经过基本计算后的值，但是要注意，这个方法获取到的不一定是上面所说的`计算值`，有时候它返回的也可能是`使用值`。具体使用的时候要注意这两种值的差别。

## 3. 层叠值的确定规则

上文中提到，层叠值是同一个属性有多个声明时所产生的，它的结果是多个声明值根据某些规则进行博弈后最终胜出的那个值，那么这个博弈规则是什么呢？ 按照来源和权重优先级如下：

1. transition（过渡）
2. 用户代理重要声明
3. 用户重要声明
4.  作者重要声明 
5. 动画声明
6. 作者普通声明
7. 用户普通声明
8. 用户代理普通声明

> 所谓`xxx重要声明`就是在值后面加了 `!important` 标识的声明

也就是说，使用`transition` 属性声明的值是权重最高的值，它会打败其它所有的声明。接下来分别是加了 `!imporant` 的用户代理声明->用户声明->作者声明，再接下来是动画声明，所以在没有任何`!imporant`声明的情况下，动画声明的值是除了`transition`声明的指以外最高优先级的，接下来才是我们熟悉的 作者普通声明->用户普通声明->用户代理普通声明。

我们从下到上一个一个来比较验证。

### 用户普通声明 VS 用户代理普通声明

我们写下一个最基本的`html`:

`css-value-demo.html`

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <p>这是一个没有样式的P标签</p>
</body>
</html>
```

然后在浏览器里打开：

![image-20201211141440081](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201211152957.png)

然后我们从开发者工具中看下当前浏览器默认的字体样式：

![image-20201211141721531](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201211153002.png)

此时字号为`16px`，字体为`微软雅黑`。我们再打开浏览器的设置，找到外观设置：

![image-20201211141909161](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201211153008.png)

浏览器设置里的外观设置实际上就是浏览器留给用户用来设置样式的一个接口，用户如果在这里改变了样式，实际上页面就会应用用户的样式，就是我们说的用户声明，我们在这里修改字号为`20px`:

![image-20201211142156322](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201211153014.png)



再看页面：

![image-20201211142243763](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201211153019.png)



这里浏览器就应用了用户自定义的字号，说明**普通的用户声明>普通的用户代理声明**

### 作者普通声明 VS 用户普通声明

我们在刚才的`html`的基础上，为`p`标签加上作者样式：

```html
//...
<style>
p {
	font-size: 14px;
}
</style>
</head>
//...
```

再看页面

![image-20201211143014461](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201211153025.png)



可以得出：**作者普通声明 > 用户普通声明**

### 动画声明 VS 作者普通声明

继续在`style`标签中加一个字体动画

```css
<style>
 p {
            font-size: 14px;
            animation: to18 10s;
        }

        @keyframes to18 {
            25% {
                font-size: 15px;
            }
            50% {
                font-size: 16px;
            }
            75% {
                font-size: 17px;
            }
            100% {
                font-size: 18px;
            }
        }
</style>
```



![image-20201211143945935](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201211153031.png)



当然，此时查看元素样式的`computed`值时，由于字号是不断改变的，显示的就是你打开元素审查定位到该元素一瞬间时的字号大小，这里还没到`18px`， 但是也足以说明，**动画声明 > 作者普通声明**

###  作者重要声明 VS 动画声明

改样式：

```css
 p {
            font-size: 14px !important;
            animation: to18 10s;
        }

        @keyframes to18 {
            25% {
                font-size: 15px;
            }
            50% {
                font-size: 16px;
            }
            75% {
                font-size: 17px;
            }
            100% {
                font-size: 18px;
            }
        }
```



看页面

![image-20201211144429926](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201211153036.png)



神奇的事情发生了，动画没有了，字号一直保持`14px`不变了。由此我们得出： **作者重要声明 > 动画声明**

这里我们还得到开发中要特别注意的一个结论：

**带有重要标识的样式声明会阻止相关样式的动画变化**

### 用户重要声明  VS  作者重要声明

我们回到浏览器的设置界面，会发现有一个最小字号的设置，这个就是用户重要声明了，我们将其设置为`17px`，同时，我们将字号用户声明字号设置为`13px`，以方便观察结果

![image-20201211145249547](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201211153040.png)

再看页面：

![image-20201211145349252](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201211153045.png)

可以看到最终应用的是`17px`，虽然我们设置了重要作者样式为`14px`。

可以得到结论： **用户重要声明 > 作者重要声明**

### 用户代理重要声明 VS 作者重要声明

由于条件所限，我们无法去比较用户代理重要声明和用户重要声明，所以我们比较一下用户代理重要声明和作者重要声明

我们首先普及一个知识点，在`html`中，我们书写`li`标签，之所以前面会出现序号，是因为用户代理实现了一个名为`::marker`的伪元素，如下：

![image-20201211150616605](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201211153049.png)



这里，我们看到 `text-indent`属性就是一个用户代理重要声明，现在我们尝试在代码中对它设置一个作者重要声明：

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>css-lists-demo</title>
    <style>
        li::marker {
            text-indent: 3px !important; // 作者重要声明
        }
    </style>
</head>
<body>
    <ol>
        <li>lkjkljlkjlk</li>
        <li>lkjkljlkjlk</li>
        <li>lkjkljlkjlk</li>
    </ol>
</body>
</html>
```

看下效果：

![image-20201211150842571](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201211153054.png)

![image-20201211150900363](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201211153059.png)



我们看到，虽然在`Styles`面板下，用户代理的重要声明被删除，而应用了我们设置的作者重要声明（这里可能是开发者工具一个bug），但是在计算值(`coumputed`)面板中，最终却还是采用了用户代理重要声明。从页面观察来看，作者重要声明确实没有改变页面最终呈现效果。

由此，得出结论： **用户代理重要声明 > 作者重要声明**

### 过渡声明 VS 用户代理重要声明

这个我暂时还没找到可以用哪个标签的什么样式来测试，如果有朋友找到测试方法，请评论告知一下。