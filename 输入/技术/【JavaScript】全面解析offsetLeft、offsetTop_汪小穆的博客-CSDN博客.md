# 【JavaScript】全面解析offsetLeft、offsetTop

)

 分类专栏：  [JavaScript](https://blog.csdn.net/w390058785/category_7192723.html)

 [版权]()

前言：偏移量，很多动画效果的实现都是通过去改变偏移量的改变来实现的，但是你真的完全了解offsetLeft，offsetTop吗？

###

### 一、第一个小例子

![70](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201218174122.png)

①第一个例子中，三个div的上一级的定位元素都是body，body是最外层的定位元素，三个div获取到的offsetLeft值跟offsetTop值都是相对于body的偏移量。

### 二、第二个小例子（给box1添加相对定位）



②第二个例子中，box1加上了相对定位，这时候box2，box3的上一级定位元素不再是body了，这时他们获取到的offsetLeft值跟offsetTop值都是相对于box1的偏移量。而box1的上一级定位元素还是body，所以他的偏移量还是相对于body的。

### 三、第三个小例子（给box1，box2添加相对定位）



![70](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201218174134.png)

③第三个例子中，box1跟box2都加上了相对定位，这时候，box3的上一级定位元素变成是box2，box2的上一级定位元素是box1，box1的上一级定位元素还是body。**所以这时候就出现了。三个div的偏移量都为100；**

### 四、解析

通过上面的三个例子不难看出，offsetLeft值跟offsetTop值的获取跟父级元素没关系，而是跟其上一级的定位元素(除position:static;外的所有定位如fixed,relative,absolute)有关系。

### 五、扩展(在第三个例子中，假如我想获取到box3到浏览器窗口的偏移量，该怎么去获取呢？)

思路很简单，就是把元素本身的偏移量跟所有上级定位元素的偏移量都加起来就可以了，问题又来了，假如我们不知道他有几个上级定位元素呢？

其实也不难。js不但提供了offsetLeft、offsetTop方法，还提供了offsetParent（获取上一级定位元素对象）的方法。所以现在我们只需封装一个函数就可以了。



运用程序中



运行结果为：
![70](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201218174139.png)

