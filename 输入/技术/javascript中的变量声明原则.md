javascript中的变量声明原则

# javascript中的变量声明原则

javascript
变量声明
1、最小全局变量原则：每一个变量都只应该在其作用域中使用，以避免全局污染和命名冲突；
2、最好的定义变量的方法是显式地使用“var”关键字来定义；
3、通过var关键字声明的变量是无法被“delete”操作符删除的，而没有用var关键字声明的变量是可以被“delete”操作符删除的
4、一种通用的全局对象访问方式：

	var global = (function(){

	    return this;

	}());

5、尽可能少地使用单var定义变量模式（即袋子模式），多使用盒子模式；
袋子模式：

	var a=1,
	    b=2,
	    c=3;

盒子模式：

	var a=1;
	var b=2;
	var c=3;

6、所有未初始化但声明的变量的初始值是undefined
7、由于javascript是顺序解析的，所以为了避免混乱，最好预先使用var声明所有你要用到的变量
[markdownFile.md](../_resources/30165dfe09583635d0d17798a1a66692.bin)