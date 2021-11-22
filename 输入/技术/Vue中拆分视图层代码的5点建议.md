Vue中拆分视图层代码的5点建议

# Vue中拆分视图层代码的5点建议

[![v2-31e47f21cb0d425f7dfdf801537157de_l.jpg](../_resources/7a33e6c8122ab1e5bf149e8af07cd5dc.jpg)](https://www.zhihu.com/org/hua-wei-yun-ji-zhu-zhai-ji-di)

[华为云开发者社区](https://www.zhihu.com/org/hua-wei-yun-ji-zhu-zhai-ji-di)


已认证的官方帐号

【小宅按】示例代码托管在：*[http://www.github.com/dashnowords/blogs...](https://link.zhihu.com/?target=http%3A//www.github.com/dashnowords/blogs)*

分享一篇尤大大演讲镇楼：*[「2019 JSConf.Asia - 尤雨溪」在框架设计中寻求平衡](https://zhuanlan.zhihu.com/p/76622839)*

## 一.框架的定位

框架通常只是一种设计模式的实现，它并不意味着你可以在开发中避免所有分层设计工作。

`SPA`框架几乎都是基于`MVC`或`MVVM`设计模式而建立起来的，这些模式都只是宏观的分层设计，当代码量开始随着项目增大而增多时，问题就会越来越多。许多企业内部的项目仍然在使用`angularjs1.X`，你会发现许多`controller`的体积大到令人发指，稍有经验的团队会利用好`angularjs1`构建的`controller`,`service`,`filter`以及路由和消息机制来完成基本的拆分和解耦，这已经能让他们的开发能力中等体量的项目，往往只有掌握了`angularjs1`玩法精髓——`directive`的队伍，才能够在应付大型项目时使代码保持足够的清晰度，当然这只是在代码形态和模块划分上的工作，相当于代码的骨骼，想要让业务逻辑本身更加清晰，就需要更高级的建模设计知识来对业务逻辑进行分层，例如**领域驱动模型**。如果你仍然在使用`angularjs1.x`的版本进行开发，可以参考*[【如何重构Controller】](https://link.zhihu.com/?target=https%3A//www.cnblogs.com/dashnowords/p/10125707.html)*进行基本的分层拆分设计。

有趣的是一些团队认为无法承载大型项目是`angularjs1.x`的原罪，与他们的开发水平无关，于是将希望寄托于拥有自动化工具加持的现代化`SPA`框架，然而如果有机会观察你就会发现，许多项目对新框架的使用方式和之前并没有本质的差别，只不过是把以前臃肿到不行的代码又换了一种形式塞进了前端工程里，然后借着`ES6`语法和新型框架本身的简洁性，开始沾沾自喜地认为这是自己重构的功劳。

请记住，如果不进行结构设计，即便使用最新版本的最热门的框架，写出来的代码依旧会是一团乱麻。

## 二. Vue开发中的script拆分优化

以`Vue`框架为例，在工程化工具和`vue-loader`的支撑下，主流的开发模式是基于`*.vue`这种单文件组件形态的。一个典型的`vue`组件包含如下几个部分：

	<template>
	  <!--视图模板-->
	</template>

	<script>
	   /*编写组件脚本*/
	   export default {
	       name:'component1'
	   }
	</script>

	<style>
	   /*编写组件样式*/
	</style>

`script`的部分通常包含有**交互逻辑**，**业务逻辑**，**数据转换**以及**DOM操作**，如果不加整理，很容易变得混乱不堪。`*.vue`文件的本质是View层代码，它应该尽可能轻量并包含与视图有关的信息，即**特性声明**和**事件分发**，其他的代码理论上都应该剥离出去，这样当项目体量增大后，维护起来就更容易聚焦关键信息，下面就如何进行脚本代码拆分提供一些思路，有一些可能是很基本的原则，为尽可能完整就放在一起，你并不需要从最开始就采纳所有的建议。

### 1.组件划分

这是View层减重的基础，将可共用的视图组件剥离出去，改为消息机制进行通信，甚至直接剥离出包含视图和业务代码的业务逻辑组件，都可以有效地拆分View层，降低代码的复杂度。

### 2.剥离业务逻辑代码

`script`中最大的一部分一般是业务逻辑，首先将业务逻辑代码剥离为独立的`[name].business.js`模块，这样做的直观好处就是减轻了View层，另一方面是解除了业务逻辑和页面之间的强绑定关系，如果其他页面也涉及到这块业务逻辑中的个别方法，就可以直接进行复用，最后就是当项目逐渐复杂，你决定引入`vuex`来进行状态管理时View层会相对更容易修改。

一段包含基本增删改查逻辑的组件大概是下面的样子：

	<script>
	   export default{
	       name:'XXX',
	       methods:{
	           handleClickCreate(){},
	           handleClickEdit(){},
	           handleClickRefresh(){},
	           handleClickDelete(){},
	           sendCreate(){},
	           sendEdit(){},
	           sendGetAll(){},
	           sendDelete(){}
	       }
	   }
	</script>

简易的剥离方式是将交互逻辑保留在视图层，将业务逻辑部分代码放在另一个模块中，然后利用`ES6`扩展运算符将其加入到组件实例的方法中，如下所示：

	<script>
	   import OrderBusiness from './Order.business.js';
	   export default{
	       name:'XXX',
	       methods:{
	           ...OrderBusiness,
	           handleClickCreate(){},
	           handleClickEdit(){},
	           handleClickRefresh(){},
	           handleClickDelete(){},
	       }
	   }
	</script>

这种方式只是一种形态上的模块化拆分，并没有对业务逻辑本身进行梳理。另一种方式是构建独立的业务逻辑服务，保留在View层中的代码很容易转换为使用`vuex`时的编码风格：

	<script>
	   import OrderBusiness from './Order.business.js';
	   export default{
	       name:'XXX',
	       methods:{
	           handleClickCreate(){
	               OrderBusiness.sendCreate();
	           },
	           handleClickEdit(){
	               OrderBusiness.sendEdit();
	           },
	           handleClickRefresh(){
	               OrderBusiness.sendGetAll();
	           },
	           handleClickDelete(){
	               OrderBusiness.sendDelete();
	           }
	       }
	   }
	</script>

笔者的建议是，前面三个示例随着项目体量的增长可以实现渐进式的修改。

### 3. 剥离数据转换代码

在前后端分离的开发模式下，前端所需要的数据支持需要从后端请求获得，但请求来的原始数据通常都是无法直接使用的，甚至有可能引发代码出错，例如时间可能是以时间戳形式传过来的，或者你的代码需要取用某个对象属性时，后台同学却在该属性上挂了一个默认值`NULL`等，另一方面，开发过程中的接口改动是无法避免的，所以在代码结构的设计上，应该尽可能将可能变化的部分聚合起来。

比较实用的做法就是为每一个接口建立一个`Transformer`函数，从后台请求来的数据先经过`Transformer`函数变换为前台能够流通使用的数据结构，并在必要的属性上添加适当的默认值防止报错，你可以尽情地在此使用`Lodash.js`等函数工具来加工和重组自己需要的数据，即使最初后台传给你的数据不需要加工，也可以保留一个透传函数或是模块说明以提醒其他协作开发者在面对这种场景时采用类似的做法，它的功能就是**为逻辑层提供直接可用的数据**。当前端代码越来越重时，`Transformer`和`Request`部分可以很方便地移动到中间层。

### 4. 善用computed和filters处理数据展示

对原始数据的转换并不能覆盖所有场景，这就需要在定制展示的场景中利用`computed`和`filters`，它们都可以用来在不改变数据的情况下更改展示结果，例如将数据中的0或1转换为`未完成`和`已完成`，或者是将时间戳和当前时间作比较后改为可读性更高的`刚刚`,`1分钟前`,`1小时前`,`1天前`等等，这些开发场景中是不能采用强行赋值来处理的，这是就可以使用计算属性`computed`或过滤器`filters`来处理，它们的区别是`computed`一般用于组件内部，不具有通用性，而`filters`一般用于可复用的场景，可以通过下面的形式来定义一个**展示效果为首字母大写**的全局过滤器：

	Vue.filter('capitalize', function (value) {
	 if (!value) return ''；
	 value = value.toString()；
	 return value.charAt(0).toUpperCase() + value.slice(1)；
	})

当项目中使用`vuex`来进行状态管理时，`computed`通常会等价替换为`state`中的`getter`。

### 5. 使用directive处理DOM操作

尽管`Vue`提供了`refs`这个接口来实现在逻辑层直接操作`DOM`，但我们应当尽可能避免将复杂的`DOM`操作放在这里，有时候页面上`DOM`变化的场景较多，将每个变化都使用数据驱动的方式显然是不合理的，这时就需要用到指令特性`directive`，它常用来补充实现一些业务逻辑无关的`DOM`变化（业务逻辑相关的变化大都通过数据绑定进行了自动关联）。`directive`的基本用法可以直接参考*[【官方指南】](https://link.zhihu.com/?target=https%3A//cn.vuejs.org/v2/guide/custom-directive.html)*，需要注意的是许多初级开发者都不太在意内存泄漏的问题，在`directive`的使用中需要格外注意这一点，通常我们会在`bind`事件钩子中绑定事件并使用属性持有这个监听函数，并在`unbind`钩子中解除对同一个监听函数的绑定，即使没有使用自定义指令，你也需要建立在必要时解绑监听器的编码习惯：

	Vue.directive('clickoutside',{
	     bind:function (el, binding){
	         //定义监听器
	         function handler(e) {
	             if (el.contains(e.target)) {
	                 return false;
	             }
	             if (binding.expression){
	                 binding.value(e);
	             }
	         }

	         el.__clickOutSide__ = handler;
	         document.addEventListener('click', handler);
	     },
	     unbind:function (el) {
	         document.removeEventListener('click',el.__clickOutSide__);
	         delete el.__clickOutSide__ ;
	     }
	 });

`demo`中提供了一个简单的`directive`示例，你可以用它来做练习。

[demo.rar](https://link.zhihu.com/?target=https%3A//bbs.huaweicloud.com/blogs/attachment%3Fid%3D9f4ef0d8bd7211e9b759fa163e330718)

[md原文.rar](https://link.zhihu.com/?target=https%3A//bbs.huaweicloud.com/blogs/attachment%3Fid%3D9f5341a4bd7211e9b759fa163e330718)

更多精彩内容，请滑至顶部点击右上角关注小宅哦~



* * *

来源：[华为云社区](https://link.zhihu.com/?target=https%3A//bbs.huaweicloud.com/blogs/9f4175eabd7211e9b759fa163e330718) 作者：大史不说话

编辑于 2019-08-13
[ JavaScript](https://www.zhihu.com/topic/19552521)
[ Vue.js](https://www.zhihu.com/topic/20022242)
[ 前端开发](https://www.zhihu.com/topic/19550901)