
# WebKit内核源代码分析(四)

红心地瓜（[tomorrow.cyz@gmail.com](http://blog.csdn.net/dlmu2001/article/details/6363380mailto:tomorrow.cyz@gmail.com)）

摘要：本文介绍WebCore中Loader模块是如何加载资源的，分主资源和派生资源分析loader模块的类关系。
关键词：WebKit,Loader,Network,ResouceLoader,SubresourceLoader

## 一、类结构及接口

Loader模块是Network模块的客户。Network模块提供指定资源的获取和上传功能，获取的资源可能来自网络、本地文件或者缓存。对不同HTTP实现的适配会在Network层完成，所以Loader接触到的基本上是同OS和HTTP实现无关的Network层接口。

![0_13037833003H2d.gif.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132913.jpg)

如上是Loader和NetWork之间的类关系图，ResourceHandleClient是ResourceHandle的客户，它定义一系列虚函数，这些虚函数是ResouceHandle的回调，继承类实现这些接口。

ResouceHandleClient的接口同网络传输过程息息相关，一般为某一个网络事件对应的回调。下面是其中的一些接口。
//一般情况下，在发起网络请求前调用，可以设置特定的Http
头部，比如user agent等，在重定向请求的时候，也会自动调
用
void willSendRequest(ResourceHandle*, ResourceRequest&, const
ResourceResponse&)
//上传数据的时候，在TCP wrtie事件的时候，向对方发送数据的
时候调用，loader可以根据这个回调显示上传进度。
void didSendData(ResourceHandle*, unsigned long long
/*bytesSent*/, unsigned long long /*totalBytesToBeSent*/)
//收到第一个响应包，此时至少http的部分头部已经解析（如
status code），loader根据响应的头部信息判断请求是否成功
等。
void didReceiveResponse(ResourceHandle*,
const  ResourceResponse&)
//收到HTTP响应数据，类似tcp的read事件，来http响应数据
了，Network的设计机制是来一段数据上传一段数据。
void didReceiveData(ResourceHandle*, const char*, int,
 int /*lengthReceived*/)
    //加载完成，数据来齐。
void didFinishLoading(ResourceHandle*, double /*finishTime*/)
//加载失败
void didFail(ResourceHandle*, const ResourceError&)
//要求用户鉴权
void didReceiveAuthenticationChallenge(ResourceHandle*,
const AuthenticationChallenge&)

WebCore把要加载的资源分成两类，一类是主资源，比如HTML页面，或者下载项，一类是派生资源，比如HTML页面中内嵌的图片或者脚本链接。这两类资源对于回调的处理有很大的不同，比如，同样是下载失败，主资源可能需要向用户报错，派生资源比如页面中的一张图下载失败，可能就是图不显示或者显示代替说明文字而已，不向用户报错。因此有了MainResourceLoader和SubresourceLoader之分。它们的公共基类ResourceLoader则完成一些两种资源下载都需要完成的操作，比如通过回调将加载进程告知上层应用。

ResourceLoader通过ResourceNotifier类将回调传导到FrameLoaderClient类。

![0_1303783292D3Dd.gif.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132922.png)

主资源的加载是立刻发起的，而派生资源则可能会为了优化网络，在队列中等待(这里的立刻发起是loader层面的，不是Network层面的)。ResourceScheduler这个类就是用来管理资源加载的调度。主要调度对象就是派生资源，会根据host来影响资源加载的先后顺序。

主资源和派生资源的加载还有一个区别，主资源目前是没有缓存的，而派生资源是有缓存机制的。这里的缓存指的是Resouce Cache，用于保存原始数据（比如CSS，JS等），以及解码过的图片数据，通过Resource Cache可以节省网络请求和图片解码的时候。不同于Page Cache，Page Cache存的是DOM树和Render树的[数据结构](http://lib.csdn.net/base/31)，用来在前进后退的时候快速显示页面。

## 二、加载流程

    下图是加载html页面时，一个正常的加载流程。

![0_1303783309ypO0.gif.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132929.png)

## 三、主资源加载过程

1.       DocumentLoader调用MainResourceLoader::load向loader发起请求
2.       调用MainResourceLoader::loadNow
3.       调用MainResourceLoader::willSendRequest

4.       调用ResourceLoader::willSendRequest,将callback通过ResourceNotifier传导给FrameLoaderClient。Client可以在回调中操作ResourceRequest，比如设置请求头部。

5.       调用PolicyChecker::checkNavigationPolicy过滤掉重复请求等
6.       loader调用ResourceHandle::create向Network发起加载请求

7.       收到第一个HTTP响应数据包,Network回调MainResourceLoader::didReceiveResponse，主要处理HTTP头部。

8.       调用PolicyChecker::  checkContentPolicy,并最终通过FrameLoaderClient的dispatchDecidePolicyForMIMEType判断是否为下载请求（存在"Content-Disposition"http头部）

9.       调用MainResourceLoader::continueAfterContentPolicy，根据ResourceResponse检测是否发生错误。

10.  调用ResourceLoader::didReceiveResponse，将callback通过ResourceNotifier传导给FrameLoaderClient。

11.  收到HTTP体部数据，调用MainResourceLoader::didReceiveData

12.  调用ResourceLoader::didReceiveData，将callback通过ResourceNotifier传导给FrameLoaderClient

13.  调用MainResourceLoader::addData
14.  调用DocumentLoader::receivedData
15.  调用DocumentLoader::commitLoad

16.  调用FrameLoader::commitProvisionalLoad，FrameLoader从provisional状态跃迁到Committed状态

17.  调用FrameLoaderClientQt::committedLoad

18.  调用DocumentLoader::commitData，启动Writer对象来处理数据（DocumentWriter::setEncoding，DocumentWriter::addData）

19.  调用DocumentWriter::addData
20.  调用DocumentParser::appendByte
21.  调用DecodedDataDocumentParser::appendBytes对文本编码进行解码
22.  调用HTMLDocumentParser::append，进行HTML解析
23.  数据来齐，调用MainResourceLoader::didFinishLoading
24.  调用FrameLoader::finishedLoading
25.  调用DocumentLoader::finishedLoading
26.  调用FrameLoader::finishedLoadingDocument，启动writer对象接收剩余数据，重复19-22进行解析
27.  调用DocumentWriter::end结束接收数据（调用Document::finishParsing）
28.  调用HTMLDocumentParser::finish

## 四、派生资源加载流程

  在派生资源的加载中，SubresourceLoader更多起到的是一个转发的作用，通过它的client（SubresourceLoaderClient类）来完成操作。

![0_13037832788a8B.gif.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132936.png)

   各个加载阶段的处理在SubresourceLoaderClient的派生类CachedResourceRequest,Loader,IconLoader中完成。Client会创建SubresourceLoader。

请求发起阶段，ResourceLoadScheduler负责对SubresourceLoader进行调度。

![0_1303783318LKfk.gif.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132942.png)

   Document类会创建CachedResourceLoader类的对象m_cachedResourceLoader,这个类(对象)提供了对Document的派生资源的访问接口requestImage，requestCSSStyleSheet，requestUserCSSStyleSheet，requestScript，requestFont，requestXSLStyleSheet，requestLinkPrefetch。为了实现这些接口，CachedResourceLoader需要创建CachedResourceRequest对象来发起请求。

一般情况下，一个Document拥有一个CachedResourceLoader类实例。

MemoryCache类则对提供缓存条目的管理，可以方便地进行add，remove，缓存淘汰等。具体的缓存条目则是通过CachedResource类存储，MemoryCache类维护了一个HashMap存储所有缓存条目。

HashMap <String,CachedResource> m_resources;

CachedResourceRequest依赖于CachedResource,在CacheResourceRequest的构造函数中，会传入CachedResource对象作为参数。CachedResource既存储响应体部，也存储同cache相关的头部。在发起请求前，会检查是否有cache的validator，在收到响应的时候，则需要更新对应的头部。CachedResource类实现了RFC2616中的缓存一节。实际上CachedResource类真正完成了同网络的通信。CachedResource类根据申请的资源类型派生出不同的子类。

![0_1303783334ayOh.gif.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132948.png)

     CachedResource类的使用者必须是CachedResourceClient,在这个类中维护了CachedResourceClient类的集合m_clients。每一个Client通过addClient和removeClient将自己加入到该类的Client集合中。CachedResourceClientWalker则提供了CachedResouceClient的一个遍历接口。当数据来齐的时候，CachedResource类会通过CachedResouceClient::notifyFinished接口通知使用者。

下图是Image元素对应的几个类关系。

![0_1303783343js22.gif.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105132954.png)

下面以image为例分析其加载过程

1.       解析html页面的时候，解析到img标签，调用HTMLImageElement::create创建HTMLImageElement对象，该对象包含HTMLImageLoader对象m_imageLoader

2.       解析到img的href属性，调用ImageLoader::updateFromElementIgnoringPreviousError
3.       调用ImageLoader::updateFromElement
4.       调用CachedResourceLoader::requestImage

5.       调用CachedResourceLoader::requestResource( 根据缓存的情况确定是否可以从缓存获取，或者需要revalidate，或者需要直接从网络获取)

6.       调用CachedResourceLoader::loadResource
7.       根据Resource的类型调用createResource创建对应的CachedResource
8.       调用MemoryCache::add在cache中查找是否有对应的cache条目，如果没有创建之
9.       调用CachedImage::load
10.  调用CachedResource::load
11.  调用CachedResourceLoader::load
12.  调用CachedResourceRequest::load
13.  创建CachedResourceRequest对象，它将作为SubresourceLoader的client
14.  调用ResourceLoaderScheduler::scheduleSubresourceLoad
15.  调用SubresourceLoader::create
16.  ResourceLoadScheduler::requestTimerFired
17.  调用ResourceLoader::start
18.  调用ResourceHandle::create发起请求
19.  收到HTTP响应头部，调用ResourceLoader::didReceiveResponse
20.  调用SubresourceLoader::didiReceiveResponse

21.  调用CachedResourceRequest::didReceiveResponse处理响应头部，特别是同缓存相关的头部，比如304的status code

22.  调用ResourceLoader::didReceiveResponse
23.  收到体部数据，调用ResourceLoader::didReceiveData
24.  调用SubresourceLoader::didReceiveData
25.  调用ResourceLoader::didReceiveData
26.  调用ResourceLoader::addData将数据存储到SharedBuffer里面
27.  调用CachedResourceRequest::didReceiveData
28.  数据来齐,调用ResourceLoader::didFinishLoading
29.  调用SubresourceLoader::didFinishLoading
30.  调用CachedResourceRequest::didFinishLoading
31.  调用CachedResource::finish
32.  调用CachedResourceLoader::loadDone
33.  调用CachedImage::data，创建对应的Image对象，解码