Java中BigInteger方法总结

# Java中BigInteger方法总结

 [这是朕的江山](https://www.jianshu.com/u/6109b23b7ee6)  [关注]()
2016.05.15 22:50* 字数 374 阅读 7332评论 0喜欢 1

大数相乘这个点，在java里算是比较冷门的知识了吧，我一开始也没当回事，然而今年腾讯实习生春招笔试题告诉我实在是too young，在编程题里就有一道大数相乘的题目，结果当时我就懵逼了。现在补一下吧。

BigInteger不是基本数据类型之一，它其实更像String,是Java里的一个类，然而它的初始化方式却没有String那么方便可以直接赋值，而是跟其他自定义的类一样，要调用它的构造器进行初始化。这个类的取值范围原则上是没有上限的，取决于你的计算机的内存，它的构造器有以下几种：

![700.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141937.png)
BigInteger构造器
这里面最好用的应该是BigInger(String val)这个构造器吧，可以直接将十进制的字符串格式变成大整数，举例：
BigInteger a=new BigInteger(“2222222222222222”);

既然不是基本数据类型，所以大数的加减乘除也不能使用+、-、*、/这些运算符号，Java也没有对这些运算符号进行重定义，取而代之的是用一些方法来代替，比如add()、subtract（）、mutiply()、divide（）这四种方法，它们的使用举例如下：

![390.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141944.png)
BigInteger使用举例
那么来总结一下BigInteger为我们提供的常用的方法：

	BigInteger abs()  返回大整数的绝对值
	BigInteger add(BigInteger val) 返回两个大整数的和
	BigInteger and(BigInteger val)  返回两个大整数的按位与的结果
	BigInteger andNot(BigInteger val) 返回两个大整数与非的结果
	BigInteger divide(BigInteger val)  返回两个大整数的商
	double doubleValue()   返回大整数的double类型的值
	float floatValue()   返回大整数的float类型的值
	BigInteger gcd(BigInteger val)  返回大整数的最大公约数
	int intValue() 返回大整数的整型值
	long longValue() 返回大整数的long型值
	BigInteger max(BigInteger val) 返回两个大整数的最大者
	BigInteger min(BigInteger val) 返回两个大整数的最小者
	BigInteger mod(BigInteger val) 用当前大整数对val求模
	BigInteger multiply(BigInteger val) 返回两个大整数的积
	BigInteger negate() 返回当前大整数的相反数
	BigInteger not() 返回当前大整数的非
	BigInteger or(BigInteger val) 返回两个大整数的按位或
	BigInteger pow(int exponent) 返回当前大整数的exponent次方
	BigInteger remainder(BigInteger val) 返回当前大整数除以val的余数
	BigInteger leftShift(int n) 将当前大整数左移n位后返回
	BigInteger rightShift(int n) 将当前大整数右移n位后返回
	BigInteger subtract(BigInteger val)返回两个大整数相减的结果
	byte[] toByteArray(BigInteger val)将大整数转换成二进制反码保存在byte数组中
	String toString() 将当前大整数转换成十进制的字符串形式
	BigInteger xor(BigInteger val) 返回两个大整数的异或

That's all.