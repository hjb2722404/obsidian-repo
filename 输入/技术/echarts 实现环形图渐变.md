echarts 实现环形图渐变

# echarts 实现环形图渐变

> echarts 原生是不支持弧形渐变的，本文只是取巧，利用线性渐变 `linear`>  实现视觉上的弧形渐变。适用于以弧中点划分，两侧颜色是对称的情况。而对于严格意义上的弧形渐变（从起点到终点渐变）是不适用的。

环形图是 echarts 中 pie 图的一个变种，echarts 官方对于 pie 图的颜色渐变只支持两种：
1. linear 线性渐变
与 css 3 的 Linear Gradients 相似，即向下/向上/向左/向右/角度方向渐变，类似与射线
2. radial 镜像渐变
与 css 3 的 Radial Gradients 相似，即从圆心向外一圈圈渐变出去，类似与太阳辐射

## 渐变颜色属性

本文实现的弧形渐变是利用线性渐变的实现的，动手前需要了解到 `itemStyle.color` 属性的配置与其子属性表示的意义，可以参考 [echarts 配置文档 series-pie::itemStyle::color](http://echarts.baidu.com/option.html#series-pie.itemStyle.color)。主要了解这几个属性：

1. `type`：渐变类型，支持 `linear`/`radial`

2. `x`, `y`, `x2`, `y2`：向量坐标，即渐变开始的起点坐标 (x, y)，与结束坐标 (x2, y2)，会影响到 `colorStops` 中对图表的着色，需要注意的是值的范围在 0 ～ 1 之间

3. `colorStops`：色彩过程，值为元素是`{ offset: PERCENTAGE, color: COLOR }`的数组，每个元素表示在什么位置是什么颜色（如，在 30% 的位置是红色，`{ offset: 0.3, color: 'red' }`）

## 实现流程

实现过程主要分为以下几个步骤：
1. 确定环形图旋转展开的起始位置 Ps
2. 确定渐变颜色，0% 处的颜色即起点/终点的颜色，100% 处的颜色即弧线中点的颜色
3. 将环形图看成是一个圆 O，圆心为 O0，圆心坐标为 (x0, y0)，半径 R
根据上边向量坐标值范围的规定（必须在 0～1 之间），可以确定圆心坐标 (x0, y0) = (0.5, 0.5)，半径 R = 0.5
4. 将圆 O 置入 echarts 的 linear 渐变坐标系中
5. 计算圆上点 Ps 的坐标 (xs, ys)
6. 根据你的数据 val（如占比 62%，val === 62）确定弧度 α
val / 100 = α / 2π，即 α = (val * π) / 50
7. 确定渐变向量的起点 Ms 与其坐标 (x, y)

以 Ps 为起点沿环形图展开方向（如顺时针）旋转弧度 α 后得到的圆上点 Pe，Ms 为线段 PsPe 的中垂线 L 与 PsPe 的交点。此处中垂线一定是穿过圆心O0的

8. 确定渐变向量的终点 Me 及其坐标 (x2, y2)
Me 为中垂线 L 与弧线 PsPe 的交点

以上过程建议在实现时通过纸笔画出坐标系进行坐标求解，过程需要考虑占比大于等于 50 与小于 50 的 两种情况，前者即弧度 α < π，后者即 α > π。具体求解坐标的过程为高中数学内容。

以下是以 Ps 为环形图起点， Pe 为环形图终点在 echarts 的 linear gradients 坐标系中构造出的环形图结构（也可以参考 [GeoGebra](https://ggbm.at/gshazKRF) 上本人绘制的坐标系统），只需要计算出向量 MsMe 的起/终点坐标即可。相关代码参考 [linear 实现伪弧形渐变](http://gallery.echartsjs.com/editor.html?c=xB1oW7WWbQ)

![1164552-40b4f5400ea19a9e.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108140153.png)
坐标系统

## 软件推荐

强烈推荐 [GeoGebra](https://www.geogebra.org/) 数学绘图软件，可在线作图
