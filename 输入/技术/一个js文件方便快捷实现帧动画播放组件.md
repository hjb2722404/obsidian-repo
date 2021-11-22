一个js文件方便快捷实现帧动画播放组件

# 一个js文件方便快捷实现帧动画播放组件

 [![96](../_resources/dc7a30dd59d87be6d42665c730501987.jpg)](https://www.jianshu.com/u/74e1066d516a)

 [淳晨风](https://www.jianshu.com/u/74e1066d516a)  [**关注]()
 2018.07.03 14:19  字数 359  阅读 488评论 0喜欢 4

在开发游戏时候，更多的是核心玩法的化简，通过代码来一步步实现功能。而动画可以让游戏在效果上锦上添花。

通常做一个精灵的动画有很多的方式，但弊端就是比较耗时。而一些小配角在游戏看来无关重要的，那我们就可以通过简单的方式来实现动画，让他们能够直接动起来。这样就不用再耗费时间去做clip的动画了。

话不多说，直接上代码，先准备素材。在[爱给网](http://www.aigei.com/game/)上找到自己想要的素材就可以了，然后再通过TexturePacker来把图片合并减少图片所占容量。

![2267455-38eb817de19c4ce4.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107130219.png)
蜡笔小新跑动图片
之后就创建AnimateScript.js文件了。

#### 属性声明：

![2267455-37165ef9bf6b785f.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107130236.png)
属性声明
为了让大家自己手动打代码熟悉，故只贴上代码截图，毕竟整份文件代码数不多。

#### 初始化与基本逻辑：

![2267455-93e917c395904512.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107130323.png)
onLoad加载

#### 循环播放与单次播放动画方法：

![2267455-69c0f66923e54d73.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107130339.png)
循环播放

![2267455-a5b8a53cd12f1eac.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107130426.png)
单次播放

#### 利用updata(dt)实现动画逻辑控制：

![2267455-5e97832f8b0592de.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107130436.png)
动画实现
通过这一个js文件，就可以挂在节点上轻松实现动画的播放了。

![2267455-9eba57c93894155b.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107130457.png)
节点挂载脚本
这样只要把相关的图片拖进SpriteFrames里面就可以了，这样只要有动画的图片就可以方便快捷实现帧动画了。

![2267455-fa41d3d00895f241.gif](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107130507.gif)
最终动画效果