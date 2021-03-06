Webkit是如何加载网页的

##  Webkit是如何加载网页的


> 作者：陈文（@Aaron陈文）
> 链接：http://www.cnblogs.com/aaronjs/archive/2012/06/29/2570328.html

在WebKit渲染网页之前，它需要将页面和所有引用的资源加载完毕。其中会涉及到不同层面的工作。在本文中，我将重点关注WebCore（WebKit中主要渲染组件）是如何在加载过程中发挥作用的。

WebKit包含两条加载流水线，其中一条负责将文档加载到frames当中，另一条负责加载其他资源（比如图片、脚本一类）。下图描述了两条流水线中涉及的主要对象。

![0.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132619.jpg)

**加载Frames**

FrameLoader负责将文档加载到frames当中，当点击链接时，FrameLoader会创建一个新的DocumentLoader对象，并置于“policy”状态，接着就等待WebKit客户端决定该如何处理这次加载。通常，客户端会告诉FrameLoader将加载操作视为一次导航（而不是一次加载阻塞）

一旦客户端告诉FrameLoader将加载视作导航，FrameLoader将DocumentLoader置于“provisional”状态，此时将开始网络请求并等待结论：这个网络请求最终是下载一个文件还是一份可解析的文档。

DocumentLoader接下来会创建MainResourceLoader对象，它的作用是与浏览器所运行的系统所提供的网络库打交道，网络库通过ResourceHandle接口提供。将MainResourceLoader和DocumentLoader分离开主要有两个目的：(1) MainResourceLoader处理ResourceHandle回调过程与DocumentLoader分离。(2) MainResourceLoader对象的生命周期与DocumentLoader的生命周期解耦（DocumentLoader的生命周期与Document对象绑定在一起）。

一旦加载系统通过网络获得足够多信息，以便把文档进行呈现，FrameLoader将DocumentLoader置于“committed”状态，这时Frame对象就要显示这个新加载的文档了。

**加载子资源**

网页不仅仅由HTML组成。我们还需要加载其中的图片、脚本等等。DocLoader对象就来负责加载这些资源（注意DocLoader和DocumentLoader名字很像，但是分工是不同的）。

我们以加载图片为例。为了加载一张图片，DocLoader首先询问Cache是否已经有该图片的副本（以CachedImage对象存在）。如果存在，DocLoader则可快速响应。为了更加高效，Cache经常在内存中保存解码之后的图片数据，这样避免解码两次。

如果图片没有在Cache中，Cache会创建一个CachedImage对象来表示这个图片。CachedImage对象让Loader对象来发起网络请求，Loader会创建SubresourceLoader来做这个事情。SubresourceLoader所扮演的角色与刚刚介绍的MainResourceLoader的角色类似。

**改进点**

WebKit加载流水线当中有很多需要改进的地方。FrameLoader过于复杂，除了加载frame以外还承担了很多其他工作。比如，FrameLoader有好几个名为“load”的方法，很容混淆。它来负责创建窗口，看上去和加载frame没有什么关系。另外，加载流水线的若干阶段没有必要像现在耦合的这么紧，层次划分也不合理，存在不同层次的对象互相访问，比如：MainResourceLoader将获取到的字节直接丢给FrameLoader而不是DocumentLoader。

如果研究了上面的图，你会发现Cache只会被子资源利用。主要资源的加载并没有得到WebKit内存缓存的支持。如果能够统一这两个加载过程，那么主资源的加载性能也会得到提升。一直以来我们都在不断优化性能来让页面加载的越来越快。
