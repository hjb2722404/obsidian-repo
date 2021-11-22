前段时间，在排查一个问题的时候，遇到了一个有点令人困惑的情况，有下面这两段代码：
----------------------------------------

```text
const a = new Array(99999);
a[99998] = undefined;

const b = new Array(99999);
b[99999] = undefined;
```

我们通过 `node --inspect-brk` 来分别运行这两段代码，在代码运行的最开始和结束的时候分别task heap snapshot，分析对应的内存占用信息如下：

![](https://pic4.zhimg.com/v2-24f09759c25912d8dc5e847e244f000f_b.jpg)
![](https://pic2.zhimg.com/v2-68a22c42323fe1b72e41538d5dde8a3d_b.jpg)

可以发现第二段代码的内存占用明显要小于第一段，那么问题就出现在这个 `99999` 的越界赋值上面。

在V8代码（**[v8/src/objects/js-array.h#L19](https://link.zhihu.com/?target=https%3A//github.com/v8/v8/blob/master/src/objects/js-array.h%23L19)**）中有很明确的标注，数组有两种模式，快数组和慢数组，在数组初始化时，默认的存储方式为快数组（**[v8/src/objects/js-objects.h#L317](https://link.zhihu.com/?target=https%3A//github.com/v8/v8/blob/master/src/objects/js-objects.h%23L317)**），其内存占用是连续的，而慢数组会使用HashTable来进行数据存储。 另外数组会分为压紧（**Packed**）的和有洞的（**Holey**）两种，例如 `['a', 'b', 'c']` 这样的数组长度为3，数组索引0、1、2均有值，那么就认为是Packed；而对于 `['a',,,'d']` 这样的数组，长度为4，但是索引1、2位置并没有进行初始化赋值，那么就认为是Holey。当数组出现了较大空洞的时候，内存明显是被浪费了。

V8中对于大型空洞数组进行了优化，在V8博客（**[https://v8.dev/blog/fast-properties](https://link.zhihu.com/?target=https%3A//v8.dev/blog/fast-properties%23elements-or-array-indexed-properties)**）中进行说明了这一点，对于非常大的Holey数组来说，FixedArray会造成内存浪费，所以会使用字典来节约内存，也就是会使用慢数组模式。

使用v8-debug分别对最开始的两段代码进行调试：

![](https://pic2.zhimg.com/v2-45805ff25a4ba739fd65930e18bea761_b.jpg)
![](https://pic4.zhimg.com/v2-e777e7f1865e172d6d55ae4ff0aaf89b_b.jpg)

可以很明显的看到，第一个数组为FixedArray，而第二个数组为Dictionary，那么为什么只有第二个数组转换为了字典模式呢？

在V8中JSArray是继承于JSObject的，所以当设置属性的时候，会依次执行 `Object::SetProperty` 、 `Object::AddDataProperty` 、 `JSObject::AddDataElement` 、 `ShouldConvertToSlowElements` ,回到V8代码中，`ShouldConvertToSlowElements`这个方法，它是用来判断是否将一个数组转换为慢模式（Dictionary）（**[v8/src/objects/js-objects-inl.h#L794](https://link.zhihu.com/?target=https%3A//github.com/v8/v8/blob/master/src/objects/js-objects-inl.h%23L794)**）：

![](https://pic2.zhimg.com/v2-1f86f13c6367efd921b3fe880b50e609_b.jpg)

从上面的代码可以看到，当设置 `99998` 的时候，索引小于当前容量的时候，返回值为false，也就是不进行转换。 而当设置 `99999` 这个索引的值的时候，因为超出了原来的FixedArray容量，那么就会进行扩容，扩容的算法（**[v8/src/objects/js-objects.h#L540](https://link.zhihu.com/?target=https%3A//github.com/v8/v8/blob/4b9b23521e6fd42373ebbcb20ebe03bf445494f9/src/objects/js-objects.h%23L540)**）为容量 + 容量 /2 + 16，那么原来 99999 的容量就会扩容放大到 15万。

![](https://pic2.zhimg.com/v2-660fd6edf1db58682753787c577bd395_b.jpg)

然后会执行 `GetFastElementsUsage` 来获取原来的数组中非空洞（**[v8/src/objects/js-objects.cc#L4725](https://link.zhihu.com/?target=https%3A//github.com/v8/v8/blob/4b9b23521e6fd42373ebbcb20ebe03bf445494f9/src/objects/js-objects.cc%23L4725)**）的元素数量，乘以 `kPreferFastElementsSizeFactor(值为3)` 与 `kEntrySize (值为2)` ，与新的容量长度进行对比，如果小于新的容量长度，那么就转换为慢数组。

最开始的第二段代码中，非空洞元素数量为0，计算后的乘积也为0，因此小于15万的新数组长度，于是数组转换为了慢数组，使用了Dictionary进行数据的存储，从而节省了大量的内存。

（本篇内容来自阿里巴巴淘系技术 洗剑）

——————————————————————————————————————

阿里巴巴集团淘系技术部官方账号。淘系技术部是阿里巴巴新零售技术的王牌军，支撑淘宝、天猫核心电商以及淘宝直播、闲鱼、躺平、阿里汽车、阿里房产等创新业务，服务9亿用户，赋能各行业1000万商家。我们打造了全球领先的线上新零售技术平台，并作为核心技术团队保障了11次双十一购物狂欢节的成功。

点击下方主页关注我们，你将收获更多来自阿里一线工程师的技术实战技巧&成长经历心得。另，不定期更新最新岗位招聘信息和简历内推通道，欢迎各位以最短路径加入我们。

[阿里巴巴淘系技术​www.zhihu.com![](https://pic2.zhimg.com/v2-227b5ef96dc4d1b3a45f7233dfb987e1_ipico.jpg)
](https://www.zhihu.com/org/a-li-ba-ba-tao-xi-ji-zhu)