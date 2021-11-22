ES6，Array.from()函数的用法 - 白色的海 - 博客园

#   [ES6，Array.from()函数的用法](https://www.cnblogs.com/kongxianghai/p/7417210.html)

ES6为Array增加了from函数用来将其他对象转换成数组。
当然，其他对象也是有要求，也不是所有的，可以将两种对象转换成数组。
1.部署了Iterator接口的对象，比如：Set，Map，Array。
2.类数组对象，什么叫类数组对象，就是一个对象必须有length属性，没有length，转出来的就是空数组。

**转换map**
将Map对象的键值对转换成一个一维数组。
实际上转换出来的数组元素的序列是key1,value1,key2,value2,key3,value3.....
const map1 = new Map();
map1.set('k1', 1);
map1.set('k2', 2);
map1.set('k3', 3);
console.log('%s', Array.from(map1))
结果：
k1,1,k2,2,k3,3

**转换set**
将Set对象的元素转换成一个数组。
const set1 = new Set();
set1.add(1).add(2).add(3)
console.log('%s', Array.from(set1))
结果
1,2,3

**转换字符串**
可以吧ascii的字符串拆解成一个数据，也可以准确的将unicode字符串拆解成数组。
console.log('%s', Array.from('hello world'))
console.log('%s', Array.from('\u767d\u8272\u7684\u6d77'))
结果：
h,e,l,l,o, ,w,o,r,l,d
白,色,的,海

**类数组对象**
一个类数组对象必须要有length，他们的元素属性名必须是数值或者可以转换成数值的字符。
注意：属性名代表了数组的索引号，如果没有这个索引号，转出来的数组中对应的元素就为空。
console.log('%s', Array.from({ 0: '0', 1: '1', 3: '3',
length:4}))
结果：
0,1,,3

如果对象不带length属性，那么转出来就是空数组。
console.log('%s', Array.from({ 0: 0, 1: 1}))
结果就是空数组。

对象的属性名不能转换成索引号时。
console.log('%s', Array.from({
a: '1',
b: '2',
length:2}))
结果也是空数组

**Array.from可以接受三个参数**
我们看定义：
Array.from(arrayLike[, mapFn[, thisArg]])
arrayLike：被转换的的对象。
mapFn：map函数。
thisArg：map函数中this指向的对象。

**第二个参数，map函数**
用来对转换中，每一个元素进行加工，并将加工后的结果作为结果数组的元素值。
console.log('%s', Array.from([1, 2, 3, 4, 5], (n) => n + 1))
结果：
上面的map函数实际上是给数组中的每个数值加了1。
2,3,4,5,6

**第三个参数，map函数中this指向的对象**
该参数是非常有用的，我们可以将被处理的数据和处理对象分离，将各种不同的处理数据的方法封装到不同的的对象中去，处理方法采用相同的名字。
在调用Array.from对数据对象进行转换时，可以将不同的处理对象按实际情况进行注入，以得到不同的结果，适合解耦。
这种做法是模板设计模式的应用，有点类似于依赖注入。
[![copycode.gif](ES6，Array.from()函数的用法%20-%20白色的海%20-%20博客园.md#)
let diObj = {
handle: function(n){ return n + 2 }
}
console.log('%s', Array.from(
[1, 2, 3, 4, 5], function (x){ return  this.handle(x)
}, diObj))
[![copycode.gif](ES6，Array.from()函数的用法%20-%20白色的海%20-%20博客园.md#)
结果：
3,4,5,6,7

End

标签: [javascript](https://www.cnblogs.com/kongxianghai/tag/javascript/)

 [好文要顶](ES6，Array.from()函数的用法%20-%20白色的海%20-%20博客园.md#)  [关注我](ES6，Array.from()函数的用法%20-%20白色的海%20-%20博客园.md#)  [收藏该文](ES6，Array.from()函数的用法%20-%20白色的海%20-%20博客园.md#)  [![icon_weibo_24.png](ES6，Array.from()函数的用法%20-%20白色的海%20-%20博客园.md#)  [![wechat.png](ES6，Array.from()函数的用法%20-%20白色的海%20-%20博客园.md#)

 [![20130606192558.png](../_resources/a4978892569544cbf26cc27b7dbef4f9.png)](https://home.cnblogs.com/u/kongxianghai/)

 [白色的海](https://home.cnblogs.com/u/kongxianghai/)
 [关注 - 19](https://home.cnblogs.com/u/kongxianghai/followees/)
 [粉丝 - 179](https://home.cnblogs.com/u/kongxianghai/followers/)

 [+加关注](ES6，Array.from()函数的用法%20-%20白色的海%20-%20博客园.md#)

 5

 0

 [«](https://www.cnblogs.com/kongxianghai/p/7382140.html) 上一篇： [ES6，扩展运算符的用途](https://www.cnblogs.com/kongxianghai/p/7382140.html)

 [»](https://www.cnblogs.com/kongxianghai/p/7474295.html) 下一篇： [ES6，Array.of()函数的用法](https://www.cnblogs.com/kongxianghai/p/7474295.html)

posted @ 2017-08-23 12:08 [白色的海](https://www.cnblogs.com/kongxianghai/)  阅读(32889)  评论(3) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=7417210) [收藏](ES6，Array.from()函数的用法%20-%20白色的海%20-%20博客园.md#)