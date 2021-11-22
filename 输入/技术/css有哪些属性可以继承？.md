css有哪些属性可以继承？

# 大家好，我是IT修真院深圳分院第04期学员，一枚正直善良的web程序员。

# **今天给大家分享一下，修真院官网 js任务中可能会使用到的知识点：**

## css有哪些属性可以继承？

* * *

## 1.背景介绍

在我们深入探讨继承之前，有必要先理解文档树。所有的HTMl文档都是树，文档树由HTML元素组成,文档树和家族树类似，也有祖先、后代、父亲、孩子、兄弟
![6583758-7ecc913f7d7fee18.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134200.png)
![6583758-71b483b5f4e8919d.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134204.png)
祖先指任意相连，但是在文档树上部的元素。
![6583758-0d2ea2e94d98413e.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134207.png)
后代指任意相连，但是在文档树下部的元素。
![6583758-56c7a70ef5e19c0c.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134211.png)
父辈指相连并且直接在该元素上部的元素。
![6583758-276885673453bba6.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134214.png)
子辈指相连并且直接在该元素下部的元素。
![6583758-40c3f6a074f952b0.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134217.png)
兄弟指与其他元素共享一个父辈的元素。
除此之外还有必要先知道CSS的规则，CSS规则告诉浏览器如何去渲染HTML页面上的特定元素。
![6583758-a00bb23741120e53.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108134223.png)
1:选择器“选择”受此规则影响的HTML页面上的元素。
2:声明部分是由一对大括号以及其中任意内容组成的容器。
3:声明告诉浏览器如何去渲染页面上被选中的元素。
4:属性告诉你选中元素的样式外观。
5:值是你希望给属性设置准确的样式。

* * *

## 2.知识剖析

现在我们可以进入正题了。
css样式表继承指的是，特定的css属性向下传递到后代元素
为了看到继承的实际应用，我们将使用下面的HTML代码。
注意: em元素在 p元素的内部。
我们也使用CSS代码。注意：em元素未指定样式。
在浏览器中， p元素和 em元素同时变红。
但是为什么em元素会变红？其并没有设置颜色样式。
因为em元素继承了p元素的颜色属性。
继承是网页开发者更加轻松，否则我们就要对所以的子孙元素指定属性。
CSS文件大小将会大大增加，变得更难创建与维护，同时降低了下载速度。

* * *

## 3.常见问题

是否所以的CSS属性都可以继承呢？
非也！并非所以的CSS属性都支持继承。
如果每个CSS属性都继承，对于作者而言，反而会让事情更糟。
开发人员需要将子孙元素不需要的CSS属性一个一个地“关掉”。
我们可以设想下，如果默认状态下，border属性是可以继承的...
然后我们将border属性应用于p元素，结果？
结果在p里面em元素也有了红色边框。
幸运的是，边框是非继承的，所以em元素是没有边框的。
通常来说，仅仅那些使我们工作轻松的属性是继承的。

* * *

## 4.解决方案

那么有哪些属性可以自动继承呢

### 有继承性的属性：

        1、字体系列属性
        font：组合字体
        font-family：规定元素的字体系列
        font-weight：设置字体的粗细
        font-size：设置字体的尺寸
        font-style：定义字体的风格
        font-variant：设置小型大写字母的字体显示文本，这意味着所有的小写字母均会被转换为
        大写，但是所有使用小型大写字体的字母与其余文本相比，其字体尺寸更小。
        font-stretch：允许你使文字变宽或变窄。所有主流浏览器都不支持。
        font-size-adjust：为某个元素规定一个 aspect 值，字体的小写字母 "x" 的高度与
        "font-size" 高度之间的比率被称为一个字体的 aspect 值。这
        样就可以保持首选字体的 x-height。
2、文本系列属性
        text-indent：文本缩进
        text-align：文本水平对齐
        line-height：行高
        word-spacing：增加或减少单词间的空白（即字间隔）
        letter-spacing：增加或减少字符间的空白（字符间距）
        text-transform：控制文本大小写
        direction：规定文本的书写方向
        color：文本颜色
3、元素可见性：visibility
        4、表格布局属性：caption-side、border-collapse、border-spacing、
        empty-cells、table-layout
        5、列表属性：list-style-type、list-style-image、list-style-position、list-style
        6、生成内容属性：quotes
        7、光标属性：cursor
        8、页面样式属性：page、page-break-inside、windows、orphans
        9、声音样式属性：speak、speak-punctuation、speak-numeral、speak-header、
        speech-rate、volume、voice-family、pitch、pitch-range、
        stress、richness、、azimuth、elevation

### 所有元素可以继承的属性：

1、元素可见性：visibility、opacity        2、光标属性：cursor

###  内联元素可以继承的属性:

1、字体系列属性        2、除text-indent、text-align之外的文本系列属性

### 块级元素可以继承的属性:

1、text-indent、text-align

### 无继承的属性

        1、display
        2、文本属性：vertical-align：
        text-decoration：
        text-shadow：
        white-space：
        unicode-bidi：
        3、盒子模型的属性:宽度、高度、内外边距、边框等
        4、背景属性：背景图片、颜色、位置等
        5、定位属性：浮动、清除浮动、定位position等
        6、生成内容属性:content、counter-reset、counter-increment
        7、轮廓样式属性:outline-style、outline-width、outline-color、outline
        8、页面样式属性:size、page-break-before、page-break-after
继承中比较特殊的几点
1、a 标签的字体颜色不能被继承
1、h1-h6标签字体的大下也是不能被继承的
因为它们都有一个默认值

* * *

## 5.编码实战

font-size的继承是如何实现的？
实例一:像素
p 元素设置了14px的font-size大小。
改像素值（14px）重写了浏览器默认的font-size大小。在这个新值被后代继承了。
实例二:百分比p 元素设置了85%的font-size大小。 p { font-size:85%;}
 浏览器默认的font-size大小和百分比值被用来生成计算后的值。在这个新值被后代继承了。
实例三:em单位
p 元素设置了0.85em的font-size大小。
浏览器默认的font-size和em值（.85em）被用来生成计算后的值。在这个新值被后代继承了。

* * *

## 6.扩展思考

开发者如何使用继承书写高效的CSS代码。
例如，你可以设置color，font-size和font-family在body元素上。
这些属性会被继承到所有后代元素上。
然后你可以重写你需要的属性值，制定性的颜色值
新的font-family值
以及需要的font-size值。

* * *

## 7.参考文献

参考一：[CSS之继承详解](https://link.jianshu.com/?t=https%3A%2F%2Fwww.slideshare.net%2Fzhangxinxu%2Fcss-4863848)

* * *

## 8.更多讨论

1.如何让input元素继承字体属性？
答：可以使用inherif属性来继承父级的样式。
2.如何让两个使用相同类名的元素具有不同的效果?
答：可以使用伪类选择器，比如nth-child(X),使父元素下具体第X个元素修改样式。
3.什么情况下应该继承特征？
答：在子元素都可以使用相同的字体，颜色，就可以在父元素写想相同的样式。

* * *

![](https://upload.jianshu.io/videos/cover_imgs/null?imageView2/1/w/90/h/90)
css有哪些属性可以继承？

# 感谢大家观看！

# 今天的分享就到这里啦，欢迎大家点赞、转发、留言、拍砖!

Measure
Measure