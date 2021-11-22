逐行分析jQuery源码奥秘 （三）-extend：JQ的继承方法[对象使用]

# 逐行分析jQuery源码奥秘 （三）-extend：JQ的继承方法[对象使用]

源码

### 简化版

	    jQuery.extend=jQuery.fn.extend=function(){

	        定义一些变量

	        if(){} 看是不是深拷贝的情况
	        if(){} 看参数正确不
	        if(){} 看是不是插件情况
	        for(){ 可能有多个对象的情况

	            if(){} 防止循环引用
	            if(){} 深拷贝
	            else if(){}  浅拷贝
	        }

	    };

### 完整版

1//静态方法和实例方法使用同一套实现
* * *

2//其中jQuery.extend为静态方法，例如调用时是：$.extend();
* * *

3//而jQuery.fn.extend是实例方法，是将extend方法添加到了jQuery.fn的原型里，调用时为:$.fn.extend();
* * *

4jQuery.extend = jQuery.fn.extend = function() {
* * *

5    var options, name, src, copy, copyIsArray, clone,
* * *

6    //要扩展到哪一个目标上，如果存在参数，在将第一个参数作为扩展目标，即将其他对象都扩展到该目标上，如果没有参数，则将{}作为目标。
* * *

7        target = arguments[0] || {},
* * *

8        i = 1,
* * *

9        length = arguments.length,
* * *

10        //判断是否深拷贝的标志
* * *

11        deep = false;
* * *

12
* * *

13    //看是不是深拷贝的情况
* * *

14    // Handle a deep copy situation
* * *

15    //如果第一个参数是布尔值，那就是深拷贝，则目标元素就变成参数中的第二项。
* * *

16    if ( typeof target === "boolean" ) {
* * *

17        deep = target; //将第一个参数赋值给deep
* * *

18        target = arguments[1] || {};
* * *

19        // skip the boolean and the target
* * *

20        i = 2;
* * *

21    }
* * *

22    //看参数正不正确
* * *

23    // Handle case when target is a string or something (possible in deep copy)

* * *

24    //如果目标元素不是对象并且目标元素不是函数，则将目标设置为{}
* * *

25    if ( typeof target !== "object" && !jQuery.isFunction(target) ) {
* * *

26        target = {}; // i=1
* * *

27    }
* * *

28    //看是不是插件的情况，即只有一个对象自变量，如果参数数量与i相等，即只有一个，那目标就是当前对象，$
* * *

29    // extend jQuery itself if only one argument is passed
* * *

30    if ( length === i ) { //i=1
* * *

31        target = this;
* * *

32        --i; // i=0 为for循环准备参数
* * *

33    }
* * *

34    //循环将其他对象挨个扩展到目标对象上
* * *

35    for ( ; i < length; i++ ) {
* * *

36        // Only deal with non-null/undefined values
* * *

37        //先将第i个参数（即当前参数）赋给options，如果当前参数不为null，
* * *

38        if ( (options = arguments[ i ]) != null ) {
* * *

39            // Extend the base object
* * *

40            //for...in循环遍历当前参数（对象）
* * *

41            //将目标对象的属性赋值给src变量，将当前对象的属性赋值给copy变量
* * *

42            for ( name in options ) {
* * *

43                src = target[ name ];
* * *

44                copy = options[ name ];
* * *

45
* * *

46                // Prevent never-ending loop
* * *

47                //防止循环引用，例如：$.extend(a,{name:a});
* * *

48                //即当前属性的值正好就是目标对象，就会引发循环引用，遇到这种情况，就跳过。
* * *

49                if ( target === copy ) {
* * *

50                    continue;
* * *

51                }
* * *

52                //深拷贝的实现
* * *

53                // Recurse if we're merging plain objects or arrays
* * *

54                //第一个参数是boolean值true 并且copy变量存在，即当前属性有值，并且（copy是纯粹的对象或者将copy是否数组的判断返回值赋给copyIsArray变量后该变量的值不为null

* * *

55                if ( deep && copy && ( jQuery.isPlainObject(copy) || (copyIsArray = jQuery.isArray(copy)) ) ) {

* * *

56                    //如果copy变量是数组
* * *

57                    if ( copyIsArray ) {
* * *

58                        //设置copyIsArray为false，为下一次循环的默认值
* * *

59                        copyIsArray = false;
* * *

60                        //给clone赋值
* * *

61                        //如果scr存在并且也是数组，则clone=src，避免覆盖原有属性
* * *

62                        //否则clone=[]空数组
* * *

63                        clone = src && jQuery.isArray(src) ? src : [];
* * *

64                    //如果copy不是数组
* * *

65                    } else {
* * *

66
* * *

67                        //如果src存在且它是一个纯粹的对象，则clone=src;避免覆盖原有属性
* * *

68                        //否则clone = {}空对象
* * *

69                        clone = src && jQuery.isPlainObject(src) ? src : {};
* * *

70                    }
* * *

71                    //调用自身以递归的方式来拷贝对象属性
* * *

72                    // Never move original objects, clone them
* * *

73                    target[ name ] = jQuery.extend( deep, clone, copy );
* * *

74
* * *

75                // Don't bring in undefined values
* * *

76                //浅拷贝的实现 默认deep为false,走这条线
* * *

77                //如果copy有值
* * *

78                } else if ( copy !== undefined ) {
* * *

79                    //目标对象的name属性的值等于copy的值
* * *

80                    target[ name ] = copy;
* * *

81                }
* * *

82            }
* * *

83        }
* * *

84    }
* * *

85    //返回扩展后的目标对象
* * *

86
* * *

87    // Return the modified object
* * *

88    return target;
* * *

89};
* * *

90
* * *

### 知识点

#### $.extend()与$.fn.extend()

- 当只写一个对象自变量的时候，JQ中扩展插件的形式，例如：

	    $.extend({ //扩展工具方法

	        aaa:function(){
	            alert(1);
	        },

	    });

	      $.aaa(); //函数调用 ：alert(1)

	    $.fn.extend( //扩展JQ实例方法

	        bbb:function(){
	            alert(2);
	        }

	    );

	    $().bbb(); //对象实例调用：alert(2);

- 当写多个对象自变量的时候，后面的对象都是扩展到第一个对象上面

	var a={};

	$.extend(a,{name:"hello"},{age:30});

	console.log(a); // {name:"hello",age:30}

- 还可以做深拷贝 和 浅拷贝

	var a={},a1={};
	var b={name:"hello"};
	var c = {name:{age:30}};

	$.extend(a,b);
	$.extend(a1,c);

	a.name = "hi";
	a1.name.age=20;

	alert(b.name); //hi
	alert(c.name.age); //20 浅拷贝的方式

	$.extend(true,a1,c);
	a1.name.age =40;
	alert(c.name.age); // 30 深拷贝的方式

[markdownFile.md](../_resources/3ccfcf7291e1e9732c4f7c9ef3170bda.bin)