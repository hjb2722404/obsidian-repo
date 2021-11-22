JS 数组克隆方法总结 - Z-DL - 博客园

# [JS 数组克隆方法总结](https://www.cnblogs.com/z-dl/p/8257355.html)

## ES5 方法总结

1.slice
let arr = [2,4,434,43]
let arr1= arr.slice()

arr[0] = 'a'console.log(arr,arr1) // [ 2, 4, 434, 43 ]console.log(arr1 === arr) // false

2. 遍历数组
[![copycode.gif](JS%20数组克隆方法总结%20-%20Z-DL%20-%20博客园.md#)
Array.prototype.clone = function(){
let a=[]; for(let i=0,l=this.length;i<l;i++) {
a.push(this[i]);
} return a;
}
let arr = ['aaa','bbb','ccc','wwwww','ddd']
let arr2 = arr.clone()
console.log(arr2)
console.log( arr2 === arr )
[![copycode.gif](JS%20数组克隆方法总结%20-%20Z-DL%20-%20博客园.md#)
3. concat()
[![copycode.gif](JS%20数组克隆方法总结%20-%20Z-DL%20-%20博客园.md#)

Array.prototype.clone=function(){ return [].concat(this); //或者 return this.concat();}

let arr = ['aaa','asss']
let arr1 = arr.clone()
arr[0] = 123console.log(arr,arr1)
[![copycode.gif](JS%20数组克隆方法总结%20-%20Z-DL%20-%20博客园.md#)

## ES6 方法总结

1. Object.assign() 浅复制，也可以实现数组的克隆
let arr = ['sdsd',123,123,123]
let arr1 = []
Object.assign(arr1,arr)

arr[1] = 'aaaa'console.log(arr,arr1) // [ 'sdsd', 'aaaa', 123, 123 ] [ 'sdsd', 123, 123, 123 ]

 2. 扩展运算符
const a1 = [1, 2];// 写法一const a2 = [...a1];
a1[0] = 'aaa'console.log(a1,a2)

 [好文要顶](JS%20数组克隆方法总结%20-%20Z-DL%20-%20博客园.md#)  [关注我](JS%20数组克隆方法总结%20-%20Z-DL%20-%20博客园.md#)  [收藏该文](JS%20数组克隆方法总结%20-%20Z-DL%20-%20博客园.md#)  [![icon_weibo_24.png](JS%20数组克隆方法总结%20-%20Z-DL%20-%20博客园.md#)  [![wechat.png](JS%20数组克隆方法总结%20-%20Z-DL%20-%20博客园.md#)

 [![20180104145100.png](../_resources/8f3198bceb918e1dd28cbd16319fe7e5.jpg)](http://home.cnblogs.com/u/z-dl/)

 [Z-DL](http://home.cnblogs.com/u/z-dl/)
 [关注 - 3](http://home.cnblogs.com/u/z-dl/followees)
 [粉丝 - 5](http://home.cnblogs.com/u/z-dl/followers)

 [+加关注](JS%20数组克隆方法总结%20-%20Z-DL%20-%20博客园.md#)

 0

 0

[«](https://www.cnblogs.com/z-dl/p/8252258.html) 上一篇：[JS String对象的方法总结（ES5 与 ES6） 一](https://www.cnblogs.com/z-dl/p/8252258.html)

[»](https://www.cnblogs.com/z-dl/p/8258055.html) 下一篇：[JS String对象的方法总结（ES5 与 ES6） 二](https://www.cnblogs.com/z-dl/p/8258055.html)

posted @ 2018-01-10 10:42  [Z-DL](https://www.cnblogs.com/z-dl/) 阅读(10737) 评论(0) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=8257355)  [收藏](https://www.cnblogs.com/z-dl/p/8257355.html#)