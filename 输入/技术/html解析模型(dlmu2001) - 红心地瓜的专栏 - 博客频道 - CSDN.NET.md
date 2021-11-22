html解析模型(dlmu2001) - 红心地瓜的专栏 - 博客频道 - CSDN.NET

# [html解析模型(dlmu2001)](http://blog.csdn.net/dlmu2001/article/details/6001029)

.

标签： [html](http://www.csdn.net/tag/html)[construction](http://www.csdn.net/tag/construction)[tree](http://www.csdn.net/tag/tree)[token](http://www.csdn.net/tag/token)[脚本](http://www.csdn.net/tag/%e8%84%9a%e6%9c%ac)[api](http://www.csdn.net/tag/api)

2010-11-10 19:16  4093人阅读  [评论](http://blog.csdn.net/dlmu2001/article/details/6001029#comments)(0)  [收藏](html解析模型(dlmu2001)%20-%20红心地瓜的专栏%20-%20博客频道%20-%20CSDN.NET.md#)  [举报](http://blog.csdn.net/dlmu2001/article/details/6001029#report)

.
![category_icon.jpg](../_resources/760c5ec8c68b26ded5d32a15a75b0d4b.jpg)  分类：

WebKit内核源代码分析*（16）*  ![arrow_triangle _down.jpg](../_resources/f4957b54c1e7e28871f863560acc9791.jpg)

.
版权声明：本文为博主原创文章，未经博主允许不得转载。
![parsing-model-overview.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141343.png)

   如上是html解析模型图，如图所示，html解析模型的输入是unicode字符流，经过tokenization和tree construction两个阶段，输出Document对象。

一般情况下，Tokenization阶段处理的数据来自网络，但它也可以来自于运行在用户代理上的脚本，比如，使用document.wrinte()这样的API。

Tokenizer和tree construction状态都只有一套，但是tree construction是可重入的，tree construction阶段在处理一个token的时候，tokenizer可能得以继续，导致在第一个token没有完成之前，其它的token被释放并处理。

…
<script>
Document.write(‘<p>’);
</script>
…
比如，如上的代码，tree construction阶段在处理”script”结束标签的时候，会被要求处理”p”起始标签。
.
.