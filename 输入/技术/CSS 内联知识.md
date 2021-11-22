# CSS 内联知识

1.内联布局模型

-   在一个内联布局中，由混合的递归的文本流和[内联级框](https://www.wolai.com/m5VJW2DBsebAvbggA7uWse)组成了[块容器](https://www.wolai.com/hykj5YfNGMGbXp9CMYcajn)中的内联[格式化上下文](https://www.wolai.com/c2nhaWJQEYvgRHz8syfrdU)，通过将它们分割成一堆[行框](https://www.wolai.com/iSDgCz34h7FV8qvMJsJEmu)，并在每个行框中将文本（[运行的文本](https://www.wolai.com/cF2GXSPuDrZmYGbHZBM3zo)）和框（[内联框](https://www.wolai.com/qUYW9ZBQoJwo8iWzoLSpD8)）相互对齐来布局

-   任何直接包含[内联级别的](https://www.wolai.com/7cCzxYJf16y8E8ZkZ8rDkS)内容的块容器都会建立内联格式化上下文来布局其内容

-   块容器的【内容边缘】构成了每个参与内联格式化上下文的内联内容的[包含块](https://www.wolai.com/519tdn17UNo1M7zFV6pXtk)

-   块容器会生成一个[根内联框](https://www.wolai.com/jRyGdxWFKHHfNETgTZtUCS)

-   在内联格式化上下文中，内容会沿着[内联轴](https://www.wolai.com/9dqF449zT9BScuUthZrvMn)排列。

-   当一个[内联框](https://www.wolai.com/qUYW9ZBQoJwo8iWzoLSpD8)超过了一个[行框](https://www.wolai.com/iSDgCz34h7FV8qvMJsJEmu)的[逻辑宽度](https://www.wolai.com/bKPcP6Gt6xFrqX5GyPq1qW) 或包含强制换行符时，会将其拆分成几个[碎片](https://www.wolai.com/kPRovDbYvtNJx6xCczzGsr)，将其分区跨多个行框。

-   内联格式化上下文由一堆行框组成，行框没有间隔地堆叠，它们从不重叠

-   一般情况下，行框的逻辑宽度等于其包含块的内容框的逻辑宽度，不过，浮动框或初始字母框可以出现在包含块的边和行框的边之间。

-   在行框中，[内联级框](https://www.wolai.com/m5VJW2DBsebAvbggA7uWse)可以以不同的方式沿[块轴](https://www.wolai.com/pquzuJt9x8rgwVV5Neq6HL)对齐: 它们的上下边缘可以对齐，文本的基线也可以对齐

-   行框的[逻辑高度](https://www.wolai.com/gtT6RiAssL72PBZKVgZYxf)会适配它的内容，这种适配是由`line-height`  和 ` text-edge`  控制的， 

2. 行框内布局

  1. 计算行框内每个[内联级框](https://www.wolai.com/m5VJW2DBsebAvbggA7uWse)的[布局边界](https://www.wolai.com/suutub59S5VNcrzLrorLF1)：

-     对于[原子级内联框： ](https://www.wolai.com/pUQmALpsL65iKfmVmpWC4W)，如[替换元素](https://www.wolai.com/vrZzXMChUwctAKmAnKS6rD)和内联块: 是它们的外边距框

-     对于根内联框和带有` text-edge:leading`的内联框，是来自于它们所使用的行高，忽略任何边距/边框/填充

-     对于其他内联框:这来自于它们的文本边缘度量，并包括任何边距/边框/填充

  2. 内联级框按照  ` dominant-baseline` 和 ` vertical-align`  在块轴上对齐

  3. 行框的逻辑高度被计算为精确地包括其所有内联级别框的对齐布局边界。

  4. [根内联框](https://www.wolai.com/jRyGdxWFKHHfNETgTZtUCS)的对齐子树和具有与行框相对垂直对齐值的框相对于行框对齐。

绘制顺序

一般按照在文档内的顺序绘制，此时`z-index` 属性一般不适用。

3. 基线与对齐度量

不同的书写系统具有不同的基线

基线与度量

CSS使用以下基于文本的度量作为内联布局函数的基线，如对齐、框大小和初始字母布局：

-       `alphabetic`： 用于书写拉丁语、西里尔语、希腊语和许多其他文字，对应于它们的大多数(但不是全部)字符的底部

-       `cap-height ` : 对应拉丁、西里尔、希腊语等语言中的大写字母

-       `x-height`:  对应于拉丁文、西里尔文、希腊文等的小写字母(如m， л， α)的顶部

-       `x-middle`: 对应于字母高度基线和x高度基线之间的中间值。

-       `ideographic-over`： 对应日文(韩文/韩文/假名)文字的行距设计边缘

-       `ideographic-under`  : 对应日文(韩文/韩文/假名)文字设计边的下行距

-       `central` : 对应表意文字中心基线，位于表意文字下方基线和表意文字上方基线之间

-       `ideographic-ink-under`: 对应日中文字(韩文/韩文/假名)文字的横过墨边

-       `hanging` : 对应于悬挂基线，在藏文和类似的单一制文字中，顶部边缘较强但不是绝对的，似乎是悬挂基线

-       `math`  : 对应于用于设计数学字符的中心基线.

-       `text-over` : 对应于作为每个[CSS2]内联内容框的跨行边缘使用的度量

-       `text-under` : 对应于作为每个[CSS2]内联内容框的下划线边缘使用的度量

-       `em-over` : 对应一个归一化的概念上升，以确保`em-over`和`em-under`之间的`1em`

-       `em-under`: 对应于一个归一化的概念下降，以确保`em-over`和`em-under`之间的`1em。`

一般来说，这些指标来自适当的字体，但是如果它们丢失了，或者需要从一个框而不是文本中导出，它们必须被合成

 度量的上升和下降

CSS假设每种字体都有一个字体指标，它指定了一个高于基线的特征高度(称为上升度量)和一个低于基线的特征深度(称为下降度量)，CSS使用这个指标来在内联格式上下文中布局文本和框

行间距度量

字体格式可以允许使用字体推荐的行间距或外部领先度量。这个度量被称为行间距度量，当`line-height:normal`时，可以被纳入行框逻辑高度的计算中

 字形和方框的基线

假设每个字体、字形和内联级别的框都有一个基线坐标，表示基线在块轴上的位置。这些基线的集合称为它的基线集。来自该集合的基线用于在其对齐上下文中对齐方框或符号，称为其对齐基线;用于对齐其内部内容的基线称为主导基线

对于单个字形，基线集从字体基线表派生。对于内联框，它从其第一个可用字体派生，而不管该框实际上是否包含来自该字体的任何符号

对于其他框，它的基线集名义上是根据它所参与的基线-源和格式上下文的规则从其内容派生出来的

对于没有设置基线的原子内联框，它的对齐基线是从它的边距框合成的

4. 基线对齐

CSS格式化上下文通常通过对齐框的边缘来定位内容，而内联布局则通过使用它们的基线来对齐框在块轴上的位置

`dominant-baseline` 用来指定框的[主导基线](https://www.wolai.com/38Q5y1jYKuu5X4hoyunLWS)

 `vertical-align` 指定内联级框的基线类型、基线首选项和对齐移位

`baseline-source` 当一个内联级别的框有多个可能的基线信息源(例如多行内联块或内联flex容器)时，该属性指定是首选对齐第一个基线集还是最后一个基线集，指示框的基线对齐首选项

`alignment-baseline` 此属性指定框的对齐基线:用于在应用框的对齐后位移(如果适用)之前对齐框的基线

`baseline-shift` 属性指定了方框对齐后的移位

`line-height` 此属性指定首选行高度:在计算行框高度时使用的内联框的逻辑高度。


