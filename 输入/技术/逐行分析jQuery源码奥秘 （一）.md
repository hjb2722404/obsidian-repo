逐行分析jQuery源码奥秘 （一）

# 逐行分析jQuery源码奥秘 （一）

源码

### 以jquery-2.0.3为例

## 整体框架提炼

	//匿名函数自执行
	/*
	    作用域限制在局部，防止命名冲突
	*/

	(function(){

	    (21,64) //定义了一些变量和函数 jQuery = function(){};

	    (96,283) // 给JQ对象添加一些方法和属性

	    (285,347) // extend：JQ的继承方法[对象使用]

	    (349,817) // jQuery.extend()扩展一些工具方法[静态方法，元素也可使用]

	    (877,2856) //Sizzle : 复杂选择器的实现

	    (2880,3042) //回调对象：对函数的统一管理

	    (3044,3183) //Defereed：延迟对象，对异步的统一管理

	    (3184,3295) // support :功能检测

	    (3308,3652) // data()：数据缓存

	    (3653,3797) //queue()：队列管理

	    (3803,4299) //attr(),prop(),val(),addClass()等，对元素属性的操作

	    (4300,5128) // on(),trigger()：事件操作相关方法

	    (5140,)

	    //暴露对外接口(8826行)
	    if ( typeof window === "object" && typeof window.document === "object" ) {
	    window.jQuery = window.$ = jQuery;
	}
	})(window);

## 逐行解读

### 注释

- jquery库的版本号
- 包含Sizzle.js
- 版权信息，所有者
- MIT软件许可证
- 最新更新时间
- 注释中的"#000"类的信息可以用来在jquery官网索引搜索框搜索详细信息

### 匿名函数自执行

#### 为什么要把window作为参数传入匿名函数

- 因为window是全局对象，而传入匿名函数就成了局部变量，js查找局部变量的速度比全局变量更快。
- 将window作为参数后，压缩源代码时更容易用缩写替换。

#### 为什么要传入undefined参数

- 避免函数外部的undefined被修改。

#### “use strict”

- 在严格模式下解析js代码，例如，变量必须用var声明，不允许八进制模式
- jquery不推荐使用严格模式

### 变量与函数定义

- rootjQuery：jquery的根目录-jQuery(document)
    - 赋予变量利于压缩
    - 定义为变量便于后期维护
- readList
    - DOM加载有关的变量
- core_strundefined
    - 字符串形式的undefined
    - 兼容性的判断：tpyeof undefined
- window子对象的变量存储
    - 缩写方便
    - 便于压缩

	// Use the correct document accordingly with window argument (sandbox)
	    location = window.location,
	    document = window.document,
	    docElem = document.documentElement,

- 防止jquery（$符号）命名冲突的私有变量

	// Map over jQuery in case of overwrite
	    _jQuery = window.jQuery,

	    // Map over the $ in case of overwrite
	    _$ = window.$,

- class2type = {},
    - $.type()方法会使用的变量
- jQuery主方法定义
    - 等于$(),jQuery()
    - 返回一个对象
    - 直接在内部初始化，使用时省去初始化操作（init方法）

	jQuery = function( selector, context ) {
	        // The jQuery object is actually just the init constructor 'enhanced'
	        return new jQuery.fn.init( selector, context, rootjQuery );
	    },

- 定义了很多正则，包括匹配数字的，匹配单词间距，匹配标签，匹配id防注入，匹配独立空标签，匹配ms前缀转驼峰等
- 转驼峰的回调函数
- DOM加载成功后的回调

[markdownFile.md](../_resources/83325878b84c9ff04040a0e072ad402c.bin)