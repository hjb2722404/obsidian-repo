Ant-Design-Vue中关于Table组件的使用 - 菜小牛 - 博客园

#   [Ant-Design-Vue中关于Table组件的使用](https://www.cnblogs.com/cirry/p/12459729.html)

**1. 如何自定义表格列头：**

<a-table :columns="columns" :dataSource="dataSource">  <span slot="customTitle"><a-icon type="smile-o"/>Name</span></a-table>

[![copycode.gif](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)
const columns = [
{

dataIndex: 'name',　　　　// 自定义列表头，则不能设置title属性 align: 'left', slots: { title: 'customTitle'}　　// 在这里定义一个slots属性，并设置一个title属性

}
]
[![copycode.gif](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)
页面将会渲染为如下：
![1950998-20200310233018559-325456302.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173755.png)

**2.如何设置自定义单行样式**
[![copycode.gif](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)

<a-table :columns="columns" :dataSource="dataSource">  <span slot="action" slot-scope="record, index">　// 这里传入的值分别是：record：当前行的原始数据，index：当前行的索引 <a @click="handleEdit(record.key)">编辑</a>  </span></a-table>

[![copycode.gif](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)

[![copycode.gif](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)
const columns = [
{
title: '菜单名称' dataIndex: 'name',　　// dataIndex的值对应的是，列数据在数据项中对应的 key
key: 'name',　　　　　// 如果dataIndex属性值唯一，则可以不设置key属性
align: 'left',
},
{
title: '操作',
　　　 key: 'action'
dataIndex: 'action',

width: '30%',  scopedSlots: { customRender: 'action' },  //这一行自定义渲染这一列 align: 'center' }

]
[![copycode.gif](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)
页面展示如下：
![1950998-20200310233450488-744841655.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173751.png)
** 3.如何设置表头，页脚和边框线？**
[![copycode.gif](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)

<template>  <a-table :columns="columns" :dataSource="data" bordered>　　// 这里添加bordered属性，就可以添加上边框线  <template slot="name" slot-scope="text">  <a href="javascript:;">{{text}}</a>  </template>  <template slot="title" slot-scope="currentPageData">　　// slot="title"就可以设置页头了，'title'改为其他值则没有页头 Header--{{currentPageData}}　　　　// 这里打印一下currentData，看下是啥值

 </template>
<template slot="footer"> Footer </template>　　// 跟上同理
 </a-table>
</template>
[![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)](#)
[![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)](#)
const columns = [　　// columns中并没有定义页头和页脚的相关代码
{
title: 'Name',
dataIndex: 'name',
scopedSlots: { customRender: 'name' },
},
{
title: 'Cash Assets',
className: 'column-money',
dataIndex: 'money',
},
{
title: 'Address',
dataIndex: 'address',
},
];
[![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)](#)
页面显示就结果如下：
![1950998-20200311000350662-1940831083.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173804.png)
** 4.表格如何树形展示数据：**
[![copycode.gif](../_resources/51e409b11aa51c150090697429a953ed.gif)](#)

<a-table :columns="columns" :dataSource="dataSource" childrenColumnName="qq"　　// 这里可以选择子节点的属性名，一般都为'children',这里我设置为'qq',试下效果

:rowSelection="rowSelection">　　// rowSelection是列表可选择的时候的配置项，后面介绍，带有此选项表格前就会出现可选择的checkbox <span slot="customTitle"><a-icon type="smile-o"  /> Name</span>  <span slot="action" slot-scope="text, record, index">  <a @click="handleEdit(record.key)">编辑</a>  </span></a-table>

[![copycode.gif](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)
[![copycode.gif](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)
const columns = [
{
dataIndex: 'name',
key: 'name',
align: 'left',
slots: { title: 'customTitle'}
},
{
title: '操作',
dataIndex: 'action',
width: '30%',
scopedSlots: { customRender: 'action' },
align: 'center' }
]
const dataSource = [
{
key: 1,
name: 'John Brown sr.',
age: 60,
address: 'New York No. 1 Lake Park',
qq: [　　　　　　　　　　　　//这里我把子节点的key，改为qq了 {
key: 11,
name: 'John Brown',
age: 42,
address: 'New York No. 2 Lake Park' }
]
},
{
key: 2,
name: 'Joe Black',
age: 32,
address: 'Sidney No. 1 Lake Park' }
]
[![copycode.gif](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)

页面显示效果如下：（显示正确）
![1950998-20200311002155843-521330791.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107173816.png)
** 5.自定义筛选菜单：（下面的代码都太多了，有必要在点开看吧，有详细的注释）**
![ContractedBlock.gif](../_resources/1c53668bcee393edac0d7b3b3daff1ae.gif)View Code

**6.如何自定义可以编辑单行的表格？**
![ContractedBlock.gif](../_resources/1c53668bcee393edac0d7b3b3daff1ae.gif)View Code

**7.如何定义可展开的table？**
![ContractedBlock.gif](../_resources/1c53668bcee393edac0d7b3b3daff1ae.gif)View Code

**8.最后来一个带分页的表格**
[![copycode.gif](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)

<template>  <a-table :rowSelection="rowSelection" :columns="columns" :dataSource="data" :pagination="ipagination"/></template><script> const columns = [

{itle: 'Name',dataIndex: 'name'},
{title: 'Age',dataIndex: 'age'},
{title: 'Address',dataIndex: 'address'}
]
const data = [] for (let i =  0; i <  46; i++) {
data.push({
key: i,
name: `Edward King ${i}`,
age: 32,
address: `London, Park Lane no. ${i}`
})
}
export default {
data () { return {
data,
columns ipagination: {
current: 1,
pageSize: 10,
total: data.length,
showSizeChanger: true,
showQuickJumper: true,

pageSizeOptions: ['10','20','30'], //这里注意只能是字符串，不能是数字 showTotal: (total, range) => `显示${range[0]}-${range[1]}条，共有 ${total}条`

}
}
}
}</script>
[![copycode.gif](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)
 9.建议看官方组件案列中的，自定义选择项案例，看完弄懂，表格的基本使用没有问题了。大家使用的时候遇到了什么问题可以来沟通一下啊。。。
作者：[Cirry](http://www.cnblogs.com/cirry/)
出处：http://www.cnblogs.com/cirry/
本文版权归作者和博客园共有，欢迎转载，但未经作者同意必须在文章页面给出原文连接，否则保留追究法律责任的权利。

分类: [Ant-Design-Vue](https://www.cnblogs.com/cirry/category/1666515.html)

 [好文要顶](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)  [关注我](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)  [收藏该文](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)  [![icon_weibo_24.png](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)  [![wechat.png](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)

 [![20200224150102.png](../_resources/2b5e3bae17eeed498dabe1ca7f491c43.jpg)](https://home.cnblogs.com/u/cirry/)

 [菜小牛](https://home.cnblogs.com/u/cirry/)
 [关注 - 5](https://home.cnblogs.com/u/cirry/followees/)
 [粉丝 - 2](https://home.cnblogs.com/u/cirry/followers/)

 [+加关注](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)

 4

 1

 [«](https://www.cnblogs.com/cirry/p/12402375.html) 上一篇： [CSS3学习笔记](https://www.cnblogs.com/cirry/p/12402375.html)

 [»](https://www.cnblogs.com/cirry/p/12483131.html) 下一篇： [[Antd-vue] Warning: You cannot set a form field before rendering a field associated with the value.](https://www.cnblogs.com/cirry/p/12483131.html)

posted @ 2020-03-11 00:23 [菜小牛](https://www.cnblogs.com/cirry/)  阅读(9688)  评论(4) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=12459729) [收藏](Ant-Design-Vue中关于Table组件的使用%20-%20菜小牛%20-%20博客园.md#)