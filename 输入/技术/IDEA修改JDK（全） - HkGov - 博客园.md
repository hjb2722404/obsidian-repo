IDEA修改JDK（全） - HkGov - 博客园

# [IDEA修改JDK（全）](https://www.cnblogs.com/hkgov/p/8074085.html)

解决:javac: 无效的目标发行版: 1.8
解决:项目JDK版本不对
解决:Jar包问题
1,"ctrl+shift+alt+s" , 打开project settings,确定项目的jdk和sdk是是否配置正确:
  1.1,project 下的project SDK,是否为项目需要的jdk:
![20170616113845624](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141647.png)
  1.2 确定SDK是否选中:
![20170616113908797](../_resources/046faa005c71c2ea68ce9109ce0ef7a5.png)
  1.3 language level不能比项目的jdk版本高:
![20170616114148379](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141652.png)
  1.4确定modules下dependencies配置的jdk是否正确:
![20170616113932487](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141655.png)
2, "run/dug configurations"  >>>需要运行的项目名称 >>>>>>runner  >>>>JRE配置是否正确:
![20170616114415350](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141700.png)

 3 , 按下 "ctrl + alt + s "  打开settings确定Java  compiler 的 Target bytecode version 是否选中项目需要的jdk版本:

![20170616114041612](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141704.png)
4, 确定D:\apache-maven-3.2.5\conf下的settings的jdk版本配置正确:

**[java]** view plain copy

1. <profile>
2.     <id>jdk-1.8</id>
3.
4.     <activation>
5.       <activeByDefault>true</activeByDefault>
6.       <jdk>1.8</jdk>
7.     </activation>
8.     <properties>
9.       <maven.compiler.source>1.8</maven.compiler.source>
10.       <maven.compiler.target>1.8</maven.compiler.target>

11.       <maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>

12.     </properties>
13.
14.     <repositories>
15.       <repository>
16.         <id>jdk17</id>
17.         <name>Repository for JDK 1.8 builds</name>
18.         <url>http://www.myhost.com/maven/jdk18</url>
19.         <layout>default</layout>
20.         <snapshotPolicy>always</snapshotPolicy>
21.       </repository>
22.     </repositories>
23.   </profile>

5, 确定pom.xml配置是否正确:

**[java]** view plain copy

1. <plugin>
2.    <groupId>org.apache.maven.plugins</groupId>
3.    <artifactId>maven-compiler-plugin</artifactId>
4.    <version>2.3.2</version>
5.    <configuration>
6.       <source>1.8</source>
7.       <target>1.8</target>
8.       <encoding>UTF-8</encoding>
9.    </configuration>
10. </plugin>

     我是死在最后一步的,公司的项目很多是依赖关系,部分还升级到jdk1.8版本,但是其中一个项目的还是1.7的!所以在编译到这个的时候一直提示 javac: 无效的目标发行版: 1.8, 恶心至极!

补充说明:经过一段时间的使用,我又发现了最根本的问题,直接修改pom.xml文件知识让你能够启动不报错而已! 它真正的原因是maven的runner的jre的环境依然在使用jdk1.7,所以才导致的冲突!只有在这里修改maven的runner的jre才能从本质上解决这个问题!

![Center](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141710.png)

吾生也有涯，而知也无涯。 个人博客：[www.hkgov.cn]()个人空间：[www.ccav9.cn]()

分类: [Java](https://www.cnblogs.com/hkgov/category/1077472.html)

标签: [IDEA](https://www.cnblogs.com/hkgov/tag/IDEA/), [配置](https://www.cnblogs.com/hkgov/tag/%E9%85%8D%E7%BD%AE/), [JDK版本](https://www.cnblogs.com/hkgov/tag/JDK%E7%89%88%E6%9C%AC/)

 [好文要顶](IDEA修改JDK（全）%20-%20HkGov%20-%20博客园.md#)  [关注我](IDEA修改JDK（全）%20-%20HkGov%20-%20博客园.md#)  [收藏该文](IDEA修改JDK（全）%20-%20HkGov%20-%20博客园.md#)  [![icon_weibo_24.png](IDEA修改JDK（全）%20-%20HkGov%20-%20博客园.md#)  [![wechat.png](IDEA修改JDK（全）%20-%20HkGov%20-%20博客园.md#)

 [![20170831161058.png](../_resources/ebe1390439dbc437bd69b6dbcd11340d.jpg)](http://home.cnblogs.com/u/hkgov/)

 [HkGov](http://home.cnblogs.com/u/hkgov/)
 [关注 - 4](http://home.cnblogs.com/u/hkgov/followees)
 [粉丝 - 22](http://home.cnblogs.com/u/hkgov/followers)

 [+加关注](IDEA修改JDK（全）%20-%20HkGov%20-%20博客园.md#)

 1

 0

[«](https://www.cnblogs.com/hkgov/p/7989202.html) 上一篇：[IntelliJ Idea 免费激活方法免激活码](https://www.cnblogs.com/hkgov/p/7989202.html)

[»](https://www.cnblogs.com/hkgov/p/8194468.html) 下一篇：[关于UML方法学图中类之间的关系:依赖,泛化,关联](https://www.cnblogs.com/hkgov/p/8194468.html)

posted @ 2017-12-20 15:41  [HkGov](https://www.cnblogs.com/hkgov/) 阅读(8013) 评论(0) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=8074085)  [收藏](https://www.cnblogs.com/hkgov/p/8074085.html#)