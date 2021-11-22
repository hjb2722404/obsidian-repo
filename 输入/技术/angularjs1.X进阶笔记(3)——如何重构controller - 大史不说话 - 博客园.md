angularjs1.X进阶笔记(3)——如何重构controller - 大史不说话 - 博客园

#   [angularjs1.X进阶笔记(3)——如何重构controller](https://www.cnblogs.com/dashnowords/p/10125707.html)

目录

- [一. 结构拆分](https://www.cnblogs.com/dashnowords/p/10125707.html#%E4%B8%80-%E7%BB%93%E6%9E%84%E6%8B%86%E5%88%86)
- [二.基本代码优化](https://www.cnblogs.com/dashnowords/p/10125707.html#%E4%BA%8C%E5%9F%BA%E6%9C%AC%E4%BB%A3%E7%A0%81%E4%BC%98%E5%8C%96)

> 本篇是内部培训交流会的摘要总结。
**> 培训PPT**> 和**> 示例代码**> 已托管至我的github仓库：

> [https://github.com/dashnowords/blogs/tree/master/Demo/rebuild-angularjs-controller

## 一. 结构拆分

1. 小型项目
通过**子路由**实现拆分分层，父级控制器控制共享模块，提供公共能力，子级分管自己的模块，父子级之间通过消息机制进行通讯。
![1354575-20181216093850052-223477476.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173356.png)
1. 中型项目
通过**组合视图**实现模块划分，组合视图共享同一个路由地址，分管不同的模块，组合视图之间需要通过父级控制器（或组合视图的根控制器）来实现通讯。
![1354575-20181216093909746-648528125.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173402.png)
1. 大型项目
通过**视图组件指令**，**业务模块指令**来进行更细粒度的模块拆分，模块通信依然建议通过消息机制来进行。
![1354575-20181216093931483-885599304.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173419.png)

## 二.基本代码优化

1. 业务逻辑代码
封装Service，通过依赖注入在Controller中或指令中使用。
2. 数据加工代码
建议使用表达性更强的通用工具库`underscore.js`或`lodash.js`提升效率，精简代码。
3. DOM操作
建议学习和习惯Angular**数据驱动**的主导思想，通过数据来启用或消除DOM操作，具体的执行需要通过自定义指令进行实现。

分类: [Angular系列](https://www.cnblogs.com/dashnowords/category/1256271.html)
标签: [angularjs](https://www.cnblogs.com/dashnowords/tag/angularjs/)

 [好文要顶](angularjs1.X进阶笔记(3)——如何重构controller%20-%20大史不说话%20-%20博客园.md#)  [关注我](angularjs1.X进阶笔记(3)——如何重构controller%20-%20大史不说话%20-%20博客园.md#)  [收藏该文](angularjs1.X进阶笔记(3)——如何重构controller%20-%20大史不说话%20-%20博客园.md#)  [![icon_weibo_24.png](angularjs1.X进阶笔记(3)——如何重构controller%20-%20大史不说话%20-%20博客园.md#)  [![wechat.png](angularjs1.X进阶笔记(3)——如何重构controller%20-%20大史不说话%20-%20博客园.md#)

 [![20180717203409.png](../_resources/090742f14c2ba796a99d0c7fe10f86eb.jpg)](https://home.cnblogs.com/u/dashnowords/)

 [大史不说话](https://home.cnblogs.com/u/dashnowords/)
 [关注 - 3](https://home.cnblogs.com/u/dashnowords/followees/)
 [粉丝 - 191](https://home.cnblogs.com/u/dashnowords/followers/)

 [+加关注](angularjs1.X进阶笔记(3)——如何重构controller%20-%20大史不说话%20-%20博客园.md#)

 0

 0

 [«](https://www.cnblogs.com/dashnowords/p/10123696.html) 上一篇： [【Angular专题】——（2）【译】Angular中的ForwardRef](https://www.cnblogs.com/dashnowords/p/10123696.html)

 [»](https://www.cnblogs.com/dashnowords/p/10127926.html) 下一篇： [目录](https://www.cnblogs.com/dashnowords/p/10127926.html)

posted @ 2018-12-16 09:40 [大史不说话](https://www.cnblogs.com/dashnowords/)  阅读(377)  评论(0) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=10125707) [收藏](angularjs1.X进阶笔记(3)——如何重构controller%20-%20大史不说话%20-%20博客园.md#)