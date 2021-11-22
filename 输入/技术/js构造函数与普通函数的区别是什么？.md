js构造函数与普通函数的区别是什么？

# js构造函数与普通函数的区别是什么？

[![v2-4779309dd032100940ce09351952a6ea_l.jpg](../_resources/4779309dd032100940ce09351952a6ea.jpg)](https://www.zhihu.com/people/xue-chang-23-82)

[学长](https://www.zhihu.com/people/xue-chang-23-82)
web前端

## 构造函数

命名：帕斯卡 （首字母大写，后面每一个单词首字母大写）
调用：需要new关键词调用 构造函数
功能：创建对象

例如：

	function Person(name,age){
	  this.name = name;
	  this.age = age;
	}
	var per = new Person("学长",24)

	console.log(per.name);
	console.log(per.age);

## 普通函数

命名：驼峰命名法 （首字母小写，后面每一个单词首字母大写）
调用：直接调用
目的：实现一些小功能
例如：

	function myEat(){
	  console.log("我饿了，我要吃饭，哈哈哈哈哈");
	}

	myEat();

编辑于 2018-09-02
[ JavaScript](https://www.zhihu.com/topic/19552521)
[ Web 开发](https://www.zhihu.com/topic/19550516)
[ 前端学习](https://www.zhihu.com/topic/20175968)