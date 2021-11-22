js中i++与++i的区别

# js中i++与++i的区别

运算符

#### 导语

在javascript中，我们常常搞不懂i与i的区别，今天我们就来简单说一下。

#### i++的例子:

1
* * *

2    var i=1;
* * *

3    console.log(i); // 输出1
* * *

4
* * *

5    var a=i++;
* * *

6    console.log(i); //输出2
* * *

7    console.log(a); //输出1
* * *

8
* * *

#### ++i的例子：

1
* * *

2    var i=1;
* * *

3    console.log(i);
* * *

4
* * *

5    var a=++i;
* * *

6    console.log(i); //输出2
* * *

7    console.log(a); //输出2
* * *

8
* * *

#### 解释

我们通过两个例子，可以看出其中不同，当使用i赋值给a后，a的值为1，而使用i赋值给a后，a的值为2，而两例中i最终都为2
可见：

- 使用i++时，i先将自身的值赋值给变量a，然后再自增1
- 使用++i时，i先将自身的值自增1,再将自增后的值赋值给变量a

#### 原理：

##### 运算符优先级

- 我们知道，++作为后置递增时，优先级为16，而作为前置递增时，优先级为15
- =作为赋值运算符时，优先级为3
- 所以，++会优先于=而执行

##### ++运算符前置与后置的区别

我们看看MDN上对该运算符的说明：

> If used postfix, with operator after operand (for example, x++), then it returns the value before incrementing.

> If used prefix with operator before operand (for example, ++x), then it returns the value after incrementing.

简单翻译：
> 如果该运算符作为后置操作符，则返回它递增之前的值；
> 如果该运算符作为前置操作符，则返回它递增之后的值
所以，我们就知道， ++运算符会返回一个值，如果前置，则返回操作对象递增之后的值，如果后置，则返回操作对象递增之前的值。
当`var a = i++`时，实际上做了如下操作
1    i=1
* * *

2    j=i;
* * *

3    i=i+1;
* * *

4    a=j;
* * *

5
* * *

而`var a = ++i`时，实际上做了如下操作
1    i=1
* * *

2    j=i+1;
* * *

3    i=i+1
* * *

4    a=j;
* * *

5
* * *

#### 拓展

设i=1，a = (i++)+(i++)+(++i)
那么a的值是？
我们可以将该运算简化为：
1
* * *

2    var i =1;
* * *

3
* * *

4    b=function(){
* * *

5
* * *

6        var j;
* * *

7        j=i;
* * *

8        i=i+1; //2
* * *

9
* * *

10
* * *

11        return j; //1
* * *

12
* * *

13    };
* * *

14
* * *

15    c=function(){
* * *

16
* * *

17        var m;
* * *

18        m=i; //2
* * *

19        i=i+1; //3
* * *

20
* * *

21        retrun m; //2
* * *

22
* * *

23    };
* * *

24
* * *

25    d=function(){
* * *

26
* * *

27        var n;
* * *

28        n=i+1; //4
* * *

29        i=i+1; //4
* * *

30
* * *

31        return n; //4
* * *

32
* * *

33    }
* * *

34
* * *

35    var a = b + c +d;
* * *

36
* * *

37    a=1+2+4=7;
* * *

38
* * *

所以当i=1，a = (i++)+(i++)+(++i)=1+2+4=7
[markdownFile.md](../_resources/1283165aaef4519dd3fb4dc915e02a3c.bin)