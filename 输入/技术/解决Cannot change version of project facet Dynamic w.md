解决Cannot change version of project facet Dynamic web module to 2.5 - steveguoshao的专栏 - CSDN博客

#   [解决Cannot change version of project facet Dynamic web module to 2.5](http://blog.csdn.net/steveguoshao/article/details/38414145)

.

 2014-08-07 10:44  176859人阅读    [评论](http://blog.csdn.net/steveguoshao/article/details/38414145#comments)(30)    [收藏](解决Cannot%20change%20version%20of%20project%20facet%20Dynamic%20w.md#)    [举报](http://blog.csdn.net/steveguoshao/article/details/38414145#report)

 .

 ![category_icon.jpg](../_resources/760c5ec8c68b26ded5d32a15a75b0d4b.jpg)  分类：

   Java*（85）*  ![arrow_triangle _down.jpg](../_resources/f4957b54c1e7e28871f863560acc9791.jpg)

[作者同类文章](http://blog.csdn.net/steveguoshao/article/category/1073874)*X*

     开发工具*（55）*  ![arrow_triangle _down.jpg](../_resources/f4957b54c1e7e28871f863560acc9791.jpg)

[作者同类文章](http://blog.csdn.net/steveguoshao/article/category/1073873)*X*

 .

版权声明：本文为博主原创文章，未经博主允许不得转载。

我们用Eclipse创建Maven结构的web项目的时候选择了Artifact Id为maven-artchetype-webapp，由于这个catalog比较老，用的servlet还是2.3的，而一般现在至少都是2.5，在Project Facets里面修改Dynamic web module为2.5的时候就会出现Cannot change version of project facet Dynamic web module to 2.5，如图：

![SouthEast.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231115719.jpg)
其实在右边可以看到改到2.5需要的条件以及有冲突的facets，解决这个问题的步骤如下：
1.把Servlet改成2.5，打开项目的web.xml，改之前：

**[html]**  [view plain](http://blog.csdn.net/steveguoshao/article/details/38414145#)  [copy](http://blog.csdn.net/steveguoshao/article/details/38414145#)

 [print](http://blog.csdn.net/steveguoshao/article/details/38414145#)[?](http://blog.csdn.net/steveguoshao/article/details/38414145#)

1. <!DOCTYPE web-app PUBLIC
2.  "-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN"
3.  "http://java.sun.com/dtd/web-app_2_3.dtd" >
4.
5. <web-app>
6.   <display-name>Archetype Created Web Application</display-name>
7. </web-app>

改后：

**[html]**  [view plain](http://blog.csdn.net/steveguoshao/article/details/38414145#)  [copy](http://blog.csdn.net/steveguoshao/article/details/38414145#)

 [print](http://blog.csdn.net/steveguoshao/article/details/38414145#)[?](http://blog.csdn.net/steveguoshao/article/details/38414145#)

1. <?xml version="1.0" encoding="UTF-8"?>
2. <web-app version="2.5"
3.     xmlns="http://java.sun.com/xml/ns/javaee"
4.     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
5.     xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
6.     http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd">
7.
8.   <display-name>Archetype Created Web Application</display-name>
9. </web-app>

2.修改项目的设置，在Navigator下打开项目.settings目录下的org.eclipse.jdt.core.prefs

**[html]**  [view plain](http://blog.csdn.net/steveguoshao/article/details/38414145#)  [copy](http://blog.csdn.net/steveguoshao/article/details/38414145#)

 [print](http://blog.csdn.net/steveguoshao/article/details/38414145#)[?](http://blog.csdn.net/steveguoshao/article/details/38414145#)

1. eclipse.preferences.version=1
2. org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
3. org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
4. org.eclipse.jdt.core.compiler.compliance=1.5
5. org.eclipse.jdt.core.compiler.problem.assertIdentifier=error
6. org.eclipse.jdt.core.compiler.problem.enumIdentifier=error
7. org.eclipse.jdt.core.compiler.problem.forbiddenReference=warning
8. org.eclipse.jdt.core.compiler.source=1.5

把1.5改成1.6

**[html]**  [view plain](http://blog.csdn.net/steveguoshao/article/details/38414145#)  [copy](http://blog.csdn.net/steveguoshao/article/details/38414145#)

 [print](http://blog.csdn.net/steveguoshao/article/details/38414145#)[?](http://blog.csdn.net/steveguoshao/article/details/38414145#)

1. eclipse.preferences.version=1
2. org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
3. org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.6
4. org.eclipse.jdt.core.compiler.compliance=1.6
5. org.eclipse.jdt.core.compiler.problem.assertIdentifier=error
6. org.eclipse.jdt.core.compiler.problem.enumIdentifier=error
7. org.eclipse.jdt.core.compiler.problem.forbiddenReference=warning
8. org.eclipse.jdt.core.compiler.source=1.6

打开org.eclipse.wst.common.component

**[html]**  [view plain](http://blog.csdn.net/steveguoshao/article/details/38414145#)  [copy](http://blog.csdn.net/steveguoshao/article/details/38414145#)

 [print](http://blog.csdn.net/steveguoshao/article/details/38414145#)[?](http://blog.csdn.net/steveguoshao/article/details/38414145#)

1. <?xml version="1.0" encoding="UTF-8"?>
2. <project-modules id="moduleCoreId" project-version="1.5.0">
3.     <wb-module deploy-name="test">

4.         <wb-resource deploy-path="/" source-path="/target/m2e-wtp/web-resources"/>

5.         <wb-resource deploy-path="/" source-path="/src/main/webapp" tag="defaultRootSource"/>

6.         <wb-resource deploy-path="/WEB-INF/classes" source-path="/src/main/java"/>

7.         <wb-resource deploy-path="/WEB-INF/classes" source-path="/src/main/resources"/>

8.         <property name="context-root" value="test"/>
9.         <property name="java-output-path" value="/test/target/classes"/>
10.     </wb-module>
11. </project-modules>

把project-version="1.5.0"改成project-version="1.6.0"

**[html]**  [view plain](http://blog.csdn.net/steveguoshao/article/details/38414145#)  [copy](http://blog.csdn.net/steveguoshao/article/details/38414145#)

 [print](http://blog.csdn.net/steveguoshao/article/details/38414145#)[?](http://blog.csdn.net/steveguoshao/article/details/38414145#)

1. <?xml version="1.0" encoding="UTF-8"?>
2. <project-modules id="moduleCoreId" project-version="1.6.0">
3.     <wb-module deploy-name="test">

4.         <wb-resource deploy-path="/" source-path="/target/m2e-wtp/web-resources"/>

5.         <wb-resource deploy-path="/" source-path="/src/main/webapp" tag="defaultRootSource"/>

6.         <wb-resource deploy-path="/WEB-INF/classes" source-path="/src/main/java"/>

7.         <wb-resource deploy-path="/WEB-INF/classes" source-path="/src/main/resources"/>

8.         <property name="context-root" value="test"/>
9.         <property name="java-output-path" value="/test/target/classes"/>
10.     </wb-module>
11. </project-modules>

打开org.eclipse.wst.common.project.facet.core.xml

**[html]**  [view plain](http://blog.csdn.net/steveguoshao/article/details/38414145#)  [copy](http://blog.csdn.net/steveguoshao/article/details/38414145#)

 [print](http://blog.csdn.net/steveguoshao/article/details/38414145#)[?](http://blog.csdn.net/steveguoshao/article/details/38414145#)

1. <?xml version="1.0" encoding="UTF-8"?>
2. <faceted-project>
3.   <fixed facet="wst.jsdt.web"/>
4.   <installed facet="java" version="1.5"/>
5.   <installed facet="jst.web" version="2.3"/>
6.   <installed facet="wst.jsdt.web" version="1.0"/>
7. </faceted-project>

把<installed facet="java" version="1.5"/>改成<installed facet="java" version="1.6"/>，把  <installed facet="jst.web" version="2.3"/>改成  <installed facet="jst.web" version="2.5"/>

**[html]**  [view plain](http://blog.csdn.net/steveguoshao/article/details/38414145#)  [copy](http://blog.csdn.net/steveguoshao/article/details/38414145#)

 [print](http://blog.csdn.net/steveguoshao/article/details/38414145#)[?](http://blog.csdn.net/steveguoshao/article/details/38414145#)

1. <?xml version="1.0" encoding="UTF-8"?>
2. <faceted-project>
3.   <fixed facet="wst.jsdt.web"/>
4.   <installed facet="java" version="1.6"/>
5.   <installed facet="jst.web" version="2.5"/>
6.   <installed facet="wst.jsdt.web" version="1.0"/>
7. </faceted-project>

都改好之后在打开看看，已经把Dynamic web module改成了2.5

![SouthEast.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231115725.jpg)

好了，大功搞成，这是一种解决办法，但是治标不治本，更高级的就是自定义catalog，然后安装到本地，再创建的时候啥都有了，比如把现在流行的s(struts2)sh，ssi，s(springmvc)sh 创建catalog，包括包结构，部分代码啥的都有，下次写吧。

[(L)](http://blog.csdn.net/steveguoshao/article/details/38414145#)[(L)](http://blog.csdn.net/steveguoshao/article/details/38414145#)[(L)](http://blog.csdn.net/steveguoshao/article/details/38414145#)[(L)](http://blog.csdn.net/steveguoshao/article/details/38414145#)[(L)](http://blog.csdn.net/steveguoshao/article/details/38414145#)[(L)](http://blog.csdn.net/steveguoshao/article/details/38414145#).

顶

71

踩

2

 .

[解决Cannot change version of project facet Dynamic w](解决Cannot%20change%20version%20of%20project%20facet%20Dynamic%20w.md#)

 [解决Cannot change version of project facet Dynamic w](解决Cannot%20change%20version%20of%20project%20facet%20Dynamic%20w.md#)

- 上一篇[Non-terminating decimal expansion; no exact representable decimal result](http://blog.csdn.net/steveguoshao/article/details/38271821)

- 下一篇[Maven使用Cargo实现自动化部署](http://blog.csdn.net/steveguoshao/article/details/38469713)

 .

####

  相关文章推荐

- *•*  [Maven使用Cargo实现自动化部署](http://blog.csdn.net/steveguoshao/article/details/38469713)

- *•*  [Cannot change version of project facet Dynamic Web Module to 2.5 问题的解决方法](http://blog.csdn.net/jueshengtianya/article/details/12388755)

- *•*  [eclipse web module版本问题：Cannot change version of project facet Dynamic Web Module to 2.5.](http://blog.csdn.net/u013887254/article/details/50864761)

- *•*  [Project facet jst.web.jstl has not been defined.](http://blog.csdn.net/han_huayi/article/details/47610675)

- *•*  [Maven下解决Cannot change version of project facet Dynamic Web module to 3.0](http://blog.csdn.net/runfarther/article/details/49587153)

- *•*  [Eclipse-JEE解决Cannot change version of project facet Dynamic web module to 2.4](http://blog.csdn.net/zxygww/article/details/50954444)

- *•*  [Jquery超简单遮罩层实现代码](http://blog.csdn.net/tolcf/article/details/38712343)

- *•*  [JQuery 遮罩层(mask)实现代码](http://blog.csdn.net/zheng963/article/details/45245485)

- *•*  [Cannot change version of project facet Dynamic Web Module to 2.5](http://blog.csdn.net/fuxiaohui/article/details/17496797)

- *•*  [Cannot change version of project facet Dynamic Web Module to 3.1 （Eclipse Maven唯一解决方案）](http://blog.csdn.net/penker_zhao/article/details/40589375)