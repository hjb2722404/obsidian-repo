CSS 中重要的层叠概念

##  CSS 中重要的层叠概念

SHERlocked93 [小生方勤]()**

最近在项目中遇到了一个问题，menu-bar 希望始终显示在最上面，而在之后的元素都显示在它之下，当时设置了 z-index 也没有效果，不知道什么原因。
因此找了一下 css 有关层叠方面的资料，解决了这个问题，这里记录一下~

我们知道 HTML 元素是排列在三维坐标系中的，x 为水平位置，y 为垂直位置，z 为屏幕由内向外方向的位置，我们在看屏幕的时候是沿着z 轴方向从外向内的；由此，元素在用户视角就形成了层叠的关系，某个元素可能覆盖了其他元素也可能被其他元素覆盖；

![640.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/c9f78187499dc7efacb4c025a6ca1d9b.jpg)

那么这里有几个重要的概念：**层叠上下文** (堆叠上下文, Stacking Context)、**层叠等级** (层叠水平, Stacking Level)、**层叠顺序** (层叠次序, 堆叠顺序, Stacking Order)、**z-index。**

## 1. 层叠上下文 (Stacking Context)

文章<关于z-index 那些你不知道的事>有一个很好的比喻，这里引用一下；
可以想象一张桌子，上面有一堆物品，这张桌子就代表着一个层叠上下文。 如果在第一张桌子旁还有第二张桌子，那第二张桌子就代表着另一个层叠上下文。

现在想象在第一张桌子上有四个小方块，他们都直接放在桌子上。 在这四个小方块之上有一片玻璃，而在玻璃片上有一盘水果。 这些方块、玻璃片、水果盘，各自都代表着层叠上下文中一个不同的层叠层，而这个层叠上下文就是桌子。

每一个网页都有一个默认的层叠上下文。 这个层叠上下文（桌子）的根源就是 `<html></html>`。 html标签中的一切都被置于这个默认的层叠上下文的一个层叠层上（物品放在桌子上）。

当你给一个定位元素赋予了除 `auto` 外的 z-index 值时，你就创建了一个新的层叠上下文，其中有着独立于页面上其他层叠上下文和层叠层的层叠层， 这就相当于你把另一张桌子带到了房间里。

![640.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/4bc838636f253d1c57abf747f8781b18.png)

层叠上下文1 (Stacking Context 1)是由文档根元素形成的， 层叠上下文2和3 (Stacking Context 2, 3) 都是层叠上下文1 (Stacking Context 1) 上的层叠层。 他们各自也都形成了新的层叠上下文，其中包含着新的层叠层。

在层叠上下文中，其子元素按照上面解释的规则进行层叠。形成层叠上下文的方法有：

- 根元素 `<html></html>`
- `position`值为 `absolute|relative`，且 `z-index`值不为 `auto`
- `position` 值为 `fixed|sticky`
- `z-index` 值不为 `auto` 的flex元素，即：父元素 `display:flex|inline-flex`
- `opacity` 属性值小于 `1` 的元素
- `transform` 属性值不为 `none`的元素
- `mix-blend-mode` 属性值不为 `normal` 的元素
- `filter`、 `perspective`、 `clip-path`、 `mask`、 `mask-image`、 `mask-border`、 `motion-path` 值不为`none` 的元素
- `perspective` 值不为 `none` 的元素
- `isolation` 属性被设置为 `isolate` 的元素
- `will-change` 中指定了任意 CSS 属性，即便你没有直接指定这些属性的值
- `-webkit-overflow-scrolling` 属性被设置 `touch`的元素

总结:
1. 层叠上下文可以包含在其他层叠上下文中，并且一起组建了一个有层级的层叠上下文
2. 每个层叠上下文完全独立于它的兄弟元素，当处理层叠时只考虑子元素，这里类似于BFC
3. 每个层叠上下文是自包含的：当元素的内容发生层叠后，整个该元素将会**在父级叠上下文**中按顺序进行层叠

## 2. 层叠等级 (Stacking Level)

**层叠等级** (层叠水平, Stacking Level) 决定了同一个层叠上下文中元素在z轴上的显示顺序的**概念**；

- 普通元素的层叠等级优先由其所在的层叠上下文决定
- 层叠等级的比较只有在同一个层叠上下文元素中才有意义
- 在同一个层叠上下文中，层叠等级描述定义的是该层叠上下文中的元素在Z轴上的上下顺序

注意，层叠等级并不一定由 z-index 决定，只有定位元素的层叠等级才由 z-index 决定，其他类型元素的层叠等级由层叠顺序、他们在HTML中出现的顺序、他们的父级以上元素的层叠等级一同决定，详细的规则见下面层叠顺序的介绍。

## 3. z-index

> 在 CSS 2.1 中, 所有的盒模型元素都处于三维坐标系中。 除了我们常用的横坐标和纵坐标， 盒模型元素还可以沿着"z 轴"层叠摆放， 当他们相互覆盖时， z 轴顺序就变得十分重要。

z-index 只适用于定位的元素，对非定位元素无效，它可以被设置为正整数、负整数、0、auto，如果一个定位元素没有设置 z-index，那么默认为auto；

元素的 z-index 值只在同一个层叠上下文中有意义。如果父级层叠上下文的层叠等级低于另一个层叠上下文的，那么它 z-index 设的再高也没用。所以如果你遇到 z-index 值设了很大，但是不起作用的话，就去看看它的父级层叠上下文是否被其他层叠上下文盖住了。

## 4. 层叠顺序 (Stacking Order)

**层叠顺序** (层叠次序, 堆叠顺序, Stacking Order) 描述的是元素在同一个层叠上下文中的顺序**规则**，从层叠的底部开始，共有七种层叠顺序，如图：

![640.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/5c155f6b68e7282785871a6da2d9cb1c.jpg)

## Vue 相关文章输出计划

最近总有朋友问我 Vue 相关的问题，因此接下来我会输出 10 篇 Vue 相关的文章，希望对大家有一定的帮助。
1. Vuex 注入 Vue 生命周期的过程（完成）
2. 学习 Vue 源码的必要知识储备（完成）
3. 浅析 Vue 响应式原理（完成）
4. 新老 VNode 进行 patch 的过程
5. 如何开发功能组件并上传 npm
6. 从这几个方面优化你的 Vue 项目
7. 从 Vue-Router 设计讲前端路由发展
8. 在项目中如何正确的使用 Webpack
9. Vue 服务端渲染
10. Axios 与 Fetch 该如何选择
建议你关注我的公众号，第一时间就可以接收最新的文章。
![640.png](../_resources/c3a9b01552db160754310b344943abc4.png)
如果你想加群交流，可以扫码自动拉你入群：
![640.jpg](../_resources/0981f6e2d3f9f4daee4f8c70e41879d3.jpg)

[ 文章转载自公众号 ![前端下午茶](../_resources/3781f9329ccaaba04df03a592f939c13.jpg)** 前端下午茶 **](https://mp.weixin.qq.com/s?__biz=Mzg5NDEyMzA2NQ==&mid=2247483929&idx=1&sn=8716c6754b9955b411d9ebaef5e51f67&chksm=c0252f4ff752a659d74dad97921ac0c3fd6b6ced933bc0b03bd12ad7e591a178d01190b9079f&mpshare=1&scene=1&srcid=0619WRNOcj2XdnXS1DloZX3N##)