记录：js删除数组中某一项或几项的几种方法 - Joans - 博客园

# 记录：js删除数组中某一项或几项的几种方法 - Joans - 博客园

[记录：js删除数组中某一项或几项的几种方法](https://www.cnblogs.com/Joans/p/3981122.html)
1:js中的splice方法
　　splice(index,len,[item])    注释：该方法会改变原始数组。
splice有3个参数，它也可以用来**替换/删除/添加**数组内某一个或者几个值
index:数组开始下标        len: 替换/删除的长度       item:替换的值，删除操作的话 item为空
如：arr = ['a','b','c','d']
**删除 ----  item不设置**
arr.splice(1,1)   //['a','c','d']         删除起始下标为1，长度为1的一个值，len设置的1，如果为0，则数组不变
arr.splice(1,2)  //['a','d']          删除起始下标为1，长度为2的一个值，len设置的2
**替换 ---- item为替换的值**

arr.splice(1,1,'ttt')        //['a','ttt','c','d']         替换起始下标为1，长度为1的一个值为‘ttt’，len设置的1

arr.splice(1,2,'ttt')        //['a','ttt','d']         替换起始下标为1，长度为2的两个值为‘ttt’，len设置的1

**添加 ----  len设置为0，item为添加的值**

arr.splice(1,0,'ttt')        //['a','ttt','b','c','d']         表示在下标为1处添加一项‘ttt’

看来还是splice最方便啦
2：delete       delete删除掉数组中的元素后，会把该下标出的值置为undefined,**数组的长度不会变**
如：delete arr[1]  //['a', ,'c','d']     中间出现两个逗号，数组长度不变，有一项为undefined

还有其他几种自定义方法，参考[这里](http://www.cnblogs.com/qiantuwuliang/archive/2010/09/01/1814706.html)

Measure
Measure