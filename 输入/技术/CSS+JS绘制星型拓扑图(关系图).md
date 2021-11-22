# CCS+JS绘制星型拓扑图（关系图）

## 1. 需求

业务上，有时候需要展示与某一特定目标关联的其它相关元素，可能会用关系图来表示（专业名称为星型网络拓扑图），如下：

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021145623.gif)

一般来说，像`d3.js`或 `Echarts` 这些库都会有相应的实现，可以直接引用它们的API来实现。

但是，如果工程中只有这一处使用这种图表，不想因为这一个需求就引入一整个库，或者不想承受这些库所带来的性能开销（canvas绘图非常耗性能）,那可以考虑本文将要介绍的这种使用`纯CSS+原生JS` 的方案尝试一下。

## 2. 需求分析

对于整个需求，我们可以分为两部分：

* 中间的目标元素
  * 它由内外两层圈组成
  * 外圈带有渐变，内层是虚线边框
  * 外圈逆时针旋转， 外层逆时针旋转
* 周围的关联元素
  * 与目标元素之间有连线
  * 均匀分布在目标元素周围

下面就分步骤来分别实现这两个需求

## 3. 目标元素

### 环形渐变

一开始，能想到的方案是外层一个正方形，然后设置一定宽度的边框，边框`border-image` 属性设置为一个渐变色，但是经过尝试，边框的渐变色无法达到预期的均匀分布的效果，故放弃，采取`外圆-内圆=环形` 的方案。

1. 首先我们有一个外层盒子
2. 然后里面有一个内层盒子，内层盒子比外层盒子稍小
3. 然后外层盒子设置一个背景色并利用圆角边框属性裁剪为圆形，
4. 内层盒子设置背景色为白色并利用圆角边框属性裁剪为圆形
5. 通过定位将内层盒子放在合适的位置，形成一个环，代码与效果如下：

```html
<div class="outer-box">
	<div class="inner-box"></div>
</div>

<style>

  .outer-box {
    width: 200px;
    height:200px;
    position: relative;
    border-radius: 50% 50%;
    background: blue;
  }
  
  .inner-box {
    width: 180px;
    height: 180px;
    position: absolute;
    left:10px;
    top:10px;
    background-color: [[fff]];
    border-radius: 50% 50%;
  }

</style>
```

效果如下：

![image-20201021093154274](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021145644.png)

外部圆环就出来了。

这里的关键点是

但是这个圆环要是一个均匀分布的渐变色， 即使设置外层盒子`background-image`属性为一个渐变色，也达不到需求所要的效果，怎么办呢？

仔细观察需求，其实是一组渐变色在圆环上顺着时针方向重复了四次。那假设组成这组渐变的四个颜色点分别是#1，#2，#3，#4，它们在圆环上其实是像下面这样排列的：

![image-20201021093835538](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021145652.png)

既然这样，我们完全可以把它们分成四份，每一份的背景色都是由 #1、#2、#3、#4组成的渐变，只不过渐变的方向不同而已。那我们就在外层盒子中再放入四个小盒子，每个盒子大小占外层盒子的四分之一，然后设置同样的渐变色不同的渐变方向：

```html
<div class="outer-box">
  <div class="left-top"></div>
  <div class="right-top"></div>
  <div class="left-bottom"></div>
  <div class="right-bottom"></div>
  <div class="inner-box"></div>
</div>

<style>
	.left-top, .right-top, .left-bottom, .right-bottom {
    width: 100px;
    height: 100px;
    position: absolute;
  }
   .left-top {
     background: linear-gradient(to top right, [[C3DDFF]] 25%, [[F1f7ff]] 100%, [[78B3FF]] 75%, [[98C5FF]] 100%);
     top:0;
     left:0;
  }

  .right-top {
    background: linear-gradient(to bottom right, [[C3DDFF]] 25%, [[F1f7ff]] 100%, [[78B3FF]] 75%, [[98C5FF]] 100%);
    top:0;
    left:100px;
  }
  .left-bottom {
    background: linear-gradient(to left top, [[C3DDFF]] 25%, [[F1f7ff]] 100%, [[78B3FF]] 75%, [[98C5FF]] 100%);
    left:0;
    top:100px;
  }
  .right-bottom {
    background: linear-gradient(to left bottom, [[C3DDFF]] 25%, [[F1f7ff]] 100%, [[78B3FF]] 75%, [[98C5FF]] 100%);
    left: 100px;
    top: 100px;
  }
</style>
```



可以看到效果如下：

![image-20201021094538015](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021145659.png)

可是，由于`border-radius` 只作用于边框，边框变性后并不影响内容的展示，所以我们发现四个小盒子其实没有形成圆环，我们有两种方案解决这个问题：

方案一：利用`overflow`属性

```css
.outer-box {
	width: 200px;
  height:200px;
  position: relative;
  border-radius: 50% 50%
  background: blue;
	ovarflow: hidden;
}
```

方案二： 利用`clip-path`，可以不再使用圆角边框

```css
.outer-box {
            width: 200px;
            height:200px;
            position: relative;
            clip-path: circle(50% at 50% 50%); 
            background: blue;
        }
```

完成后效果如下：



![image-20201021095505154](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021145705.png)



可以看到，外层圆环基本成型。再给它加上小圆点，就完全符合需求了：

```html
<div class="outer-box">
  <div class="left-top">
    <div class="litle-circle"></div>
  </div>
  <div class="right-top">
    <div class="litle-circle"></div>
  </div>
  <div class="left-bottom">
    <div class="litle-circle"></div>
  </div>
  <div class="right-bottom">
    <div class="litle-circle"></div>
  </div>
  <div class="inner-box"></div>
</div>

<style>
	 .litle-circle {
     width:10px;
     height: 10px;
     background-color: [[4094FF]];
     clip-path: circle(50% at 50% 50%);
  }
  .left-top .litle-circle {
    margin-top:90px;
    margin-left: 0;
  }
  .right-top .litle-circle {
    margin-top: 0;
    margin-left: 0;
  }

  .left-bottom .litle-circle {
    margin-top:90px;
    margin-left: 90px;
  }
  .right-bottom .litle-circle {
    margin-left: 90px;
    margin-top: 0;
  }
</style>
```

最终环形渐变如下：

![image-20201021095904920](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021145711.png)



然后让它动起来，就是添加一个动画效果：

```css
.outer-box {
  width: 200px;
  height:200px;
  position: relative;
  clip-path: circle(50% at 50% 50%);
  background: blue;
  animation: spin 6s linear infinite;
}

@keyframes spin{
  to {
    transform: rotate(-1turn);
  }
}
```

其中，`-1turn` 表示逆时针旋转一周。

效果如下

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021145717.gif)

### 内部圈

然后添加内部转动的圈，这个内部圈可以加到内部盒子里：

```html
<div class="inner-box">
  <div class="inner-rotate-box">
  </div>
</div>

<style>
	.inner-rotate-box {
    width: 150px;
    height: 150px;
    left:15px;
    top: 15px;
    position:absolute;
    border:4px dashed blue;
    border-radius: 50% 50%;
    box-sizing: border-box;
  }
</style>
```

主要是利用`border:4px dashed blue` 给它设置一个虚线边框

效果：

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021145723.gif)

我们发现内层是跟着外层转动的，而需求时内层要与外层相反，顺时针旋转，我们通过设置动画参数来让它反向旋转：

```css
.inner-rotate-box {
	animation: spin 12s linear infinite;
  animation-direction: reverse;
}
```

我们发现，其实没有效果，那是因为它的外层盒子`inner-box` 还是跟着`outer-box`一起旋转的，我们给它的外层盒子也加上反向旋转：

```··css
.inner-box {
  animation: inherit;
  animation-direction: reverse;
}
```

通过继承`outer-box`的动画并进行反向运动，可以抵消`outer-box`带给`inner-box`的旋转动画，这时看起来`inner-box`就像是没有在旋转一样，而它内部的旋转盒子又是与外层盒子反向旋转的，就能实现内外相反运动的效果：

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021145733.gif)

接着，我们再给内层旋转的圆添加一层点状虚线圈：

```html

<div class="inner-box">
  <div class="inner-rotate-box"></div>
  <div class="inner-dotted-box"></div>          
</div>

<style>
	.inner-dotted-box {
    width: 154px;
    height:154px;
    position:absolute;
    top:13px;
    left:13px;
    border: 2px dotted [[B5D5FF]];
    border-radius: 50% 50%;
    box-sizing: border-box;
  }
</style>
```

这里关键点有两个：

* 这里的虚线是点状虚线，所有边框样式用`dotted`;
* 这里和上面的`inner-rotate-box` 都要设置`box-sizing` 为`border-box`， 以便使我们的位置计算更为精确；

效果如下：

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021145740.gif)

最后，我们把内容添加上，注意，内容盒子要和旋转盒子和点状虚线盒子同级，直接放在内层盒子里，原因是我们上面说过的，内层盒子`inner-box`通过与外层盒子反向旋转抵消了旋转，而看起来就像是没有旋转一样，内容只有放在它里面，才不会跟着旋转。

```html
<div class="inner-box">
  <div class="inner-rotate-box"></div>
  <div class="inner-dotted-box"></div>
  <div class="inner-content">
    目标内容
  </div>        
</div>

<style>
	.inner-content {
    width: 120px;
    height: 120px;
    position: absolute;
    top: 30px;
    left: 30px;
    display: flex;
    justify-content: center;
    align-items: center;
  }

</style>
```

效果如下：

![](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021145748.gif)

下面是整个目标元素的实现代码，可供参考：

```httml
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>双层圆环反向圆周运动示例</title>
    <style>
        .outer-box {
            width: 200px;
            height:200px;
            position: relative;
            clip-path: circle(50% at 50% 50%);
            border-radius: 50% 50%;
            background: blue;
            animation: spin 6s linear infinite;
        }
        
        .inner-box {
            width: 180px;
            height: 180px;
            position: absolute;
            left:10px;
            top:10px;
            background-color: [[fff]];
            border-radius: 50% 50%;
            animation: inherit;
            animation-direction: reverse;
        }

        .left-top, .right-top, .left-bottom, .right-bottom {
            width: 100px;
            height: 100px;
            position: absolute;
        }
        .left-top {
            background: linear-gradient(to top right, [[C3DDFF]] 25%, [[F1f7ff]] 100%, [[78B3FF]] 75%, [[98C5FF]] 100%);
            top:0;
            left:0;
        }

        .right-top {
            background: linear-gradient(to bottom right, [[C3DDFF]] 25%, [[F1f7ff]] 100%, [[78B3FF]] 75%, [[98C5FF]] 100%);
            top:0;
            left:100px;
        }
        .left-bottom {
            background: linear-gradient(to left top, [[C3DDFF]] 25%, [[F1f7ff]] 100%, [[78B3FF]] 75%, [[98C5FF]] 100%);
            left:0;
            top:100px;
        }
        .right-bottom {
            background: linear-gradient(to left bottom, [[C3DDFF]] 25%, [[F1f7ff]] 100%, [[78B3FF]] 75%, [[98C5FF]] 100%);
            left: 100px;
            top: 100px;
        }
        .litle-circle {
            width:10px;
            height: 10px;
            background-color: [[4094FF]];
            clip-path: circle(50% at 50% 50%);
        }
        .left-top .litle-circle {
            margin-top:90px;
            margin-left: 0;
        }
        .right-top .litle-circle {
            margin-top: 0;
            margin-left: 0;
        }
        .left-bottom .litle-circle {
            margin-top:90px;
            margin-left: 90px;
        }
        .right-bottom .litle-circle {
            margin-left: 90px;
            margin-top: 0;
        }
        .inner-rotate-box {
            width: 150px;
            height: 150px;
            left:15px;
            top: 15px;
            position: absolute;
            border:4px dashed blue;
            border-radius: 50% 50%;
            box-sizing: border-box;
            animation: spin 12s linear infinite;
            animation-direction: reverse;
        }
        
        .inner-dotted-box {
            width: 154px;
            height:154px;
            position:absolute;
            top:13px;
            left:13px;
            border: 2px dotted [[B5D5FF]];
            border-radius: 50% 50%;
            box-sizing: border-box;
        }

        .inner-content {
            width: 120px;
            height: 120px;
            position: absolute;
            top: 30px;
            left: 30px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        @keyframes spin{
            to {
                transform: rotate(-1turn);
            }
        }

    </style>
</head>
<body>
    <div class="outer-box">
        <div class="left-top">
            <div class="litle-circle"></div>
        </div>
        <div class="right-top">
            <div class="litle-circle"></div>
        </div>
        <div class="left-bottom">
            <div class="litle-circle"></div>
        </div>
        <div class="right-bottom">
            <div class="litle-circle"></div>
        </div>
        <div class="inner-box">
            <div class="inner-rotate-box"></div>
            <div class="inner-dotted-box"></div>
            <div class="inner-content">
                目标内容
            </div>        
        </div>
    </div>
</body>
</html>
```



## 4. 关联元素

对于关联元素，则相对复杂一点，我们要考虑的是：

* 关联元素个数不定，可能很少，也可能很多，所以少的时候就要大一点，多的时候就要小一点，这就需要计算关联元素的宽度，又由于都是圆形展示，所以都是一个正方形盒子裁切成圆形
* 关联元素要围绕目标元素均匀分布
* 关联元素与目标元素之间要有连线

基于以上几个点，我们设计了如下算法：

### 4.1  容器区块划分

我们把整个外层容器设计成一个正方形，然后使用水平平分线、垂直平分线和两条对角线将它划分为8个区块，加上这几条线本身切割形成的8条线也算一个区块，总共16个区块：

![image-20201021140215357](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021145758.png)

### 4.2  根据数量计算关联元素尺寸、弧度及角度

根据关联元素的数量，计算关联元素的尺寸、弧度和角度

即如果有N个关联元素，并且N> 2, 则我们认为可以将N个元素分别绘制到容器上半部分和下半部分，即将所有元素平分到两个数组里，如果是奇数个，则上半部分的数组里就多一个。

```javascript
const rowLength = Math.ceil(this.unitRelations.length / 2); // 向上取整
const row1 = [];
const row2 = [];
for (let j = 0; j < this.unitRelations.length; j++) {
j < rowLength ? row1.push(j) : row2.push(j);
}
```

然后计算它的尺寸，就是看元素所在那半部分一共有几个元素，然后设置一定的间隔距离，用整个容器的宽度减去它们之间的间隔的总和，再除以这半部分的元素个数，就获得了它的尺寸，当然，我们这里还需要设置一个最大尺寸，防止它的尺寸太大，在视觉上显得比目标元素还要重要。

```javascript
const maxSize = 100;
const originalSize = this.graphWidth / rowLength;
const gap = originalSize / 10; // 间隔设置为元素无间隔平分区域时的大小的十分之一
const size = (this.graphWidth - gap * (rowLength - 1)) / rowLength;
const result = size > maxSize ? maxSize : size;
```

然后计算出每个元素平均的弧度和角度：

```javascript
const baseRadian = parseInt(360 / this.unitRelations.length); // 每一份的基本弧度
const radian = 30 + baseRadian * i; // 获得旋转弧度，我们将起始点设置为30度
const minRadian = this.isInRow([1, 3, 5, 7], this.getBlockIndex(radian)) ? radian % 45 : 45 - radian % 45;
const angle = minRadian * Math.PI / 180; // 获得弧度相应的角度
```

这里，`minRadian` 其实是用来计算当前元素参与位置计算时它的实际弧度，由于我们要用直角三角形的三角函数来计算它的位置，所以它的基础弧度要小于45度，而它处在不同区块时，用来计算的弧度也是不一样的：

* 如果它处于1/3/5/7区块，则参与计算的弧度就是它取模后的弧度
* 如果它处于2/4/6/8区块，则参与计算的弧度是它的弧度取模后与45的插值

如图：

![image-20201021142717579](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021145805.png)

分别落在第3和第4区块内的两个元素，第3区块参与计算的弧度就是它弧度取模后的德尔塔1，而第4区块的元素参与计算的弧度实际上是取模后的弧度德尔塔2与区块弧度45之间的差值德尔塔3。

有了元素尺寸和参与计算的角度，我们又有容器的宽高， 根据上图，我们很容易就可计算出元素距容器左边和上边的距离，这样元素的位置就确定了。

具体计算过程需要用到三角函数，可以自行计算。

### 边框吸附

注意上图，我们之所以能够对元素位置进行计算，还用到了一个技巧，就是边框吸附，我们默认关联元素时吸附在外层容器边框上的，当然，根据其所处区块不同，其吸附的边有可能是上、下、左、右其中一边，

代码如下：

```javascript
const { radian, opposite } = this.getBaseProperty(i);
            const block = this.getBlockIndex(radian);
            if (block === 1) {
                return {
                    top: this.graphWidth / 2 - opposite - width / 2,
                    left: 0
                };
            } else if (block === 2) {
                return {
                    top: 0,
                    left: this.graphWidth / 2 - opposite - width / 2
                };
            } else if (block === 3) {
                return {
                    top: 0,
                    left: this.graphWidth / 2 + opposite - width / 2
                };
            } else if (block === 4) {
                return {
                    left: this.graphWidth - width,
                    top: this.graphWidth / 2 - opposite - width / 2
                };
            } else if (block === 5) {
                return {
                    left: this.graphWidth - width,
                    top: this.graphWidth / 2 + opposite - width / 2
                };
            } else if (block === 6) {
                return {
                    left: this.graphWidth / 2 + opposite - width / 2,
                    top: this.graphWidth - width
                };
            } else if (block === 7) {
                return {
                    left: this.graphWidth / 2 - opposite - width / 2,
                    top: this.graphWidth - width
                };
            } else if (block === 8) {
                return {
                    left: 0,
                    top: this.graphWidth / 2 + opposite - width / 2
                };
            } else if (block === 1.5) {
                return {
                    left: 0,
                    top: 0
                };
            } else if (block === 2.5) {
                return {
                    left: this.graphWidth / 2 - width / 2,
                    top: 0
                };
            } else if (block === 3.5) {
                return {
                    left: this.graphWidth - width / 2,
                    top: 0
                };
            } else if (block === 4.5) {
                return {
                    left: this.graphWidth - width,
                    top: this.graphWidth / 2 - width / 2
                };
            } else if (block === 5.5) {
                return {
                    left: this.graphWidth - width / 2,
                    top: this.graphWidth - width
                };
            } else if (block === 6.5) {
                return {
                    left: this.graphWidth / 2 - width / 2,
                    top: this.graphWidth - width
                };
            } else if (block === 7.5) {
                return {
                    left: 0,
                    top: this.graphWidth - width
                };
            } else if (block === 8.5) {
                return {
                    left: 0,
                    top: this.graphWidth / 2 - width / 2
                };
            }
```

可以看到，不同的区块，其吸附的边不一样，具体表现就是直接设置其left为0或top为0，或者left为容器宽度减去元素尺寸或者容器高度（其实也就是容器宽度）减去元素尺寸等等；

### 连线

对于连线，我们设计为关联元素内部的一个绝对定位的元素：

```html
 <li v-for="(site, index) in unitRelations" :key="index" :style="getStyle(index)">
                            <div class="connector" :style="getConnectStyle(index)">
                                <span class="one" :style="getDirect(index)"></span>
                                <span class="two" :style="getDirect(index)"></span>
                                <p>{{ site.unitType }}</p>
                            </div>
                            <div class="site-info">
                                <p>{{ site.mediaName }} <br /> {{ site.siteName }}</p>
                            </div>
                        </li>
```

上面是`Vue`项目中应用的代码片段，其中类名为`connect`的元素就是连线。类名为`one`和`two`的两个元素就是需求中连线上不断运动的小点，这个很好实现，就不讲了，主要讲下连线的长度和角度计算。

连线默认其实就是关联元素中一个绝对定位的长方形，它的固定高度可以设为2-5像素（根据需要）来模拟一根线，然后初始高度就是元素的高度的一半位置，而水平偏移量则根据其所在不同区块而不同：如图

![image-20201021144644642](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021145812.png)

然后我们计算它的宽度，由于我们已经确定了关联元素的位置和角度，就可以直接根据元素位置的left值和top值，结合容器的宽高，利用三角函数，计算出元素圆心到目标元素圆心的连线距离，如图所示：

![image-20201021145043124](https://raw.githubusercontent.com/hjb2722404/myimg/master/20201021145822.png)

计算出连线长度后，上文所说的连线初始水平偏移量也就是它的长度（或负的长度，根据偏移方向不同），

然后将它旋转和关联元素一样的弧度，就可以了。



当然，关联元素的大小、位置算法还很基础，有兴趣的同学可以尝试更好的算法，比如各个元素的尺寸可以增加一定弹性系数，呈现出有大有小，近大远小的视觉效果，位置也可以不用吸附，而是根据区块内元素拥挤程度，适当调节某些元素的位置，有的可以离目标近点，有的可以离目标远一点。

由于这部分算法还不算最优，就补贴具体代码了，读者可以根据以上思路和关键点自行进行开发和算法优化。

