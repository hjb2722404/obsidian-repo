Docker 删除镜像 - 点滴记录，积流成河！ - CSDN博客

原

# Docker 删除镜像

2017年09月14日 15:11:12[不知道取啥昵称](https://me.csdn.net/winy_lm)阅读数：72938标签：[docker](http://so.csdn.net/so/search/s.do?q=docker&t=blog)更多

个人分类：[Docker](https://blog.csdn.net/winy_lm/article/category/7170718)

本以为删除镜像会很简单，但是删除过程中并不是那么顺利。

**1. 查询镜像**
![Center](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108135638.png)

现在想删除第一个，ID为 99f85991949f 的镜像。

[77980529](../_resources/5a653a672504267fc71294f903d21b57.bin)![Center](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108135644.png)

从上面看出，需要先停到ID为 67*** 的容器。

**2. 查询容器**
![Center](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108135647.png)

**3. 先删除容器**
![Center](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108135653.png)

上面可以看出，容器已经删除。

**4. 删除镜像**
![Center](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108135657.png)

**注意点：**
**1. 删除前需要保证容器是停止的  stop**
**2. 需要注意删除镜像和容器的命令不一样。 docker rmi ID  ,其中 容器(rm)  和 镜像(rmi)**
**3. 顺序需要先删除容器**