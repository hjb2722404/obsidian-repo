vue项目学习：22-组件的递归调用_simoon's的博客-CSDN博客_vue组件递归调用

# ![1.png](../_resources/72c68b2d4b409a357128dcf86205ce26.png)vue项目学习：22-组件的递归调用

![original.png](../_resources/8f19bb4e9750fc1d08da69d6a9ac56cd.png)

[simoonQian](https://me.csdn.net/weixin_40814356)  2018-05-11 17:00:58  ![articleReadEyes.png](../_resources/c4360f77d43b7f3fdc7b1e070f32dfd4.png)  8234  ![tobarCollect.png](../_resources/5dad7f82dd0d8ba01fecbf11a059a7cd.png)  收藏  3

分类专栏：  [web前端](https://blog.csdn.net/weixin_40814356/category_7556691.html)
版权
![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/4610646f4b5123c546ef85f64652c5a9.png)
很多的场景会有这样的层级组件。通常后台给的数据结构如下：
1
list: [{
2
title:  '成人票',
3
children: [{
4
title:  '成人三馆联票'
5
},
6
{
7
title:  '成人四馆联票',
8
children: [{
9
title:  '成人四馆联票（一）'
10
}]
11
}]
12
},
13
{
14
title:  '学生票'
15
},
16
{
17
title:  '儿童票'
18
},
19
{
20
title:  '军人票'
21
}]
这种情况下怎么写？
![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/40b9ee5102bf44dc4118eaa26511015f.png)
![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/567ff402d429de9281bb4669ce576c92.png)
重点来了：
社么是组件的递归调用呢？
其实就是在组件自身调用自己的组件。
![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/7afa3c8aac48166543cf023111ab7671.png)

[(L)](https://blog.csdn.net/cold___play)  [吴声子夜歌的博客](https://blog.csdn.net/cold___play)

![readCountWhite.png](../_resources/3e3aca5207987068ff7d043b84c8ba85.png) 930