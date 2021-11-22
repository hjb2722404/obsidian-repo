计算机浮点数运算误差与解决误差的算法 - chenhuan001 - 博客园

# 1.  浮点数IEEE 754表示方法

要搞清楚float累加为什么会产生误差，必须先大致理解float在机器里怎么存储的，这里只介绍一下组成
![20140815191211006](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201231114523.gif)

由上图可知(摘在[2])， 浮点数由： 符号位 + 指数位 + 尾数部分， 三部分组成。由于机器中都是由二进制存储的，那么一个10进制的小数如何表示成二进制。例如: 8.25转成二进制为1000.01, 这是因为 1000.01 = 1*2^3 + 0*2^2 + 0*2^1 + 0*2^0 + 0*2^-1 + 2*2^-2 = 1000.01.

（2）float的**有效位数是6-7位**，这是为什么呢？因为位数部分只有23位，所以最小的精度为1*2^-23 在10^-6和10^-7之间，接近10^-7, [[3]](http://stackoverflow.com/questions/4610999/how-to-calculate-double-float-precision)中也有解释

那么为什么float累加会产生误差呢，主要原因在于两个浮点数累加的过程。

# 2. 两个浮点数相加的过程

两浮点数X，Y进行加减运算时，必须按以下几步执行：
（1）对阶，使两数的小数点位置对齐，小的阶码向大的阶码看齐。
（2）尾数求和，将对阶后的两尾数按定点加减运算规则求和(差)。
（3）规格化，为增加有效数字的位数，提高运算精度，必须将求和(差)后的尾数规格化。
（4）舍入，为提高精度，要考虑尾数右移时丢失的数值位。
（5）判断结果，即判断结果是否溢出。
关键就在与**对阶**这一步骤，由于float的有效位数只有7位有效数字，如果一个大数和一个小数相加时，会产生很大的误差，因为尾数得截掉好多位。例如：
123 + 0.00023456 = 1.23*10^2 + 0.000002 * 10^2 = 123.0002
那么此时就会产生0.00003456的误差，如果累加多次，则误差就会进一步加大。
那么怎么解决这种误差呢？

# [Kahan summation algorithm](https://en.wikipedia.org/wiki/Kahan_summation_algorithm)

[![copycode.gif](计算机浮点数运算误差与解决误差的算法%20-%20chenhuan001%20-%20博客园.md#)
function KahanSum(input)
var
sum =
0.0

var
c =
0.0

//
A running compensation for lost low-order bits.

for
i =
1
to input.length
do

var
y = input[i] - c
//
So far, so good: c is zero.

var
t = sum + y
//
Alas, sum is big, y small, so low-order digits of y are lost.
c = (t - sum) - y
//

(t - sum) cancels the high-order part of y; subtracting y recovers negative (low part of y)

sum = t
//

Algebraically, c should always be zero. Beware overly-aggressive optimizing compilers!

next i
//
Next time around, the lost low part will be added to y in a fresh attempt.

return
sum
[![copycode.gif](计算机浮点数运算误差与解决误差的算法%20-%20chenhuan001%20-%20博客园.md#)
例子：
1.
[![copycode.gif](计算机浮点数运算误差与解决误差的算法%20-%20chenhuan001%20-%20博客园.md#)
y =
3.14159
-
0
y = input[i] -
c
t
=
10000.0
+
3.14159
=
10003.14159
But only six digits are retained.
=
10003.1
Many digits have been lost!
c
= (
10003.1
-
10000.0
) -
3.14159
This must be evaluated
as
written! =
3.10000
-
3.14159
The assimilated part of y recovered, vs. the original full y.
= -.
0415900
Trailing zeros shown because
this

is
six-
digit arithmetic.
sum
=
10003.1
Thus, few digits
from
input(i) met those of sum.
[![copycode.gif](计算机浮点数运算误差与解决误差的算法%20-%20chenhuan001%20-%20博客园.md#)
2.
[![copycode.gif](计算机浮点数运算误差与解决误差的算法%20-%20chenhuan001%20-%20博客园.md#)
y =
2.71828

- -.

0415900
The shortfall
from
the previous stage gets included.
=
2.75987
It
is
of a size similar to y: most digits meet.
t
=
10003.1
+
2.75987
But few meet the digits of sum.
=
10005.85987
And the result
is
rounded
=
10005.9
To six digits.
c
= (
10005.9
-
10003.1
) -
2.75987
This extracts whatever went
in
.
=
2.80000
-
2.75987
In
this

case
, too much.
= .
040130
But no matter, the excess would be subtracted off next time.
sum
=
10005.9
Exact result
is

10005.85987
,
this

is
correctly rounded to
6
digits.
[![copycode.gif](计算机浮点数运算误差与解决误差的算法%20-%20chenhuan001%20-%20博客园.md#)