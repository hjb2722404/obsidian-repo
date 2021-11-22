# 一、ARP协议

**ARP（Address Resolution Protocol）地址解析协议，将IP地址解析成MAC地址。**
IP地址在OSI模型第三层，MAC地址在OSI第二层，彼此不直接通信；
在通过以太网发生IP数据包时，先封装第三层（32位IP地址）和第二层（48位MAC地址）的报头；
但由于发送数据包时只知道目标IP地址，不知道其Mac地址，且不能跨越第二、三层，所以需要使用地址解析协议。
ARP工作流程分请求和响应：

![211606-20170108150556409-1909693335.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105113800.jpg)
![211606-20170108150637472-27847024.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105113745.jpg)

在dos窗口内“ping”某个域名抓取到的包：
![211606-20170108151007019-1474344520.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105113927.jpg)

# 二、IP协议

**IP（Internet Protocol）互联网协议，主要目的是使得网络间能够互相通信**，位于OSI第三层，负责跨网络通信的地址。
当以广播方式发送数据包的时候，是以MAC地址定位，并且需要电脑在同一子网络。
当不在同一子网络就需要路由发送，这时候就需要IP地址来定位。
![211606-20170108151835847-1890444145.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105113937.jpg)
同样在dos窗口内“ping”某个域名抓取到的包：
![211606-20170108152151550-1838136612.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105113945.jpg)

# 三、TCP协议

**TCP（Transmission Control Protocol）传输控制协议，一种面向连接、可靠、基于IP的传输层协议，主要目的是为数据提供可靠的端到端传输。**

在OSI模型的第四层工作，能够处理数据的顺序和错误恢复，最终保证数据能够到达其应到达的地方。
**1）标志位**
**SYN： 同步**，在建立连接时用来同步序号。SYN=1， ACK=0表示一个连接请求报文段。SYN=1，ACK=1表示同意建立连接。
**FIN： 终止**，FIN=1时，表明此报文段的发送端的数据已经发送完毕，并要求释放传输连接。
**ACK： 确认**，ACK = 1时代表这是一个确认的TCP包，取值0则不是确认包。
**DUP ACK：重复**，重复确认报文，有重复报文，一般是是丢包或延迟引起的，从这个报文看应该是丢包了。
**URG：紧急**，当URG=1时，表示报文段中有紧急数据，应尽快传送
**PSH：推送**，当发送端PSH=1时，接收端尽快的交付给应用进程
**RST：复位**，当RST=1时，表明TCP连接中出现严重差错，必须释放连接，再重新建立连接
**2）端口**
客户端与不同服务器建立连接时，源端口和目标端口可不同。
![211606-20170108153000019-104271558.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105113953.jpg)
**3）TCP三次握手**

![211606-20170108153431237-550061987.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114009.jpg)  ![211606-20170108154108675-541562868.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114019.jpg)

**4）TCP四次挥手**
TCP四次断开，例如关闭页面的时候就会断开连接。
![211606-20170108153513409-1177948716.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114025.jpg)
![211606-20170111100731525-297166498.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114032.png)
**5）TCP概念**
****1. 发送窗口****
无法简单的看出发送窗口的大小，发送窗口会由网络因素决定。发送窗口定义了一次发的字节，而MSS定义了这些字节通过多少个包发送。
**2. 拥塞窗口（cwnd）**
描述源端在拥塞控制情况下一次最多能发送的数据包的数量。
在发送方维护一个虚拟的拥塞窗口，并利用各种算法使它尽可能接近真实的拥塞点。
网络对发送窗口的限制，就是通过拥塞窗口实现的。
**3. 在途字节数（bytes in flight）**
已经发送出去，但尚未被确认的字节数。
在途字节数 = Seq + Len - Ack
其中Seq和Len来自上一个数据发送方的包，而Ack来自上一个数据接收方的包。
****4. 拥塞点（congestion point）****
发生拥塞时候的在途字节数就是该时刻的网络拥塞点。
先从Wireshark中找到一连串重传包中的第一个，再根据该Seq找到原始包最后计算该原始包发送时刻的在途字节数。
**5. 慢启动**
RFC建议初始拥塞窗口发送2、3、或4个MSS，如果发出去的包都能得到确认，则表明还没到拥塞点，可以收到n个确认增加n个MSS
![211606-20170117134442333-752057090.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114038.png)
**6. 拥塞避免**
慢启动持续一段时间后，拥塞窗口达到一个较大的值，就得放慢RFC建议在每个往返时间增加1个MSS，比如发了16个MSS全部确认，那么就增加到17个MSS
**7. 超时重传**
发出去的包在等待一段时间（RTO）后，没有收到确认，就只能重传了
![211606-20170111144956603-601786855.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114046.png)
**8. 快速重传（Fast Retransmit）**
不以时间驱动，而以数据驱动重传。如果包没有连续到达，就ACK最后那个可能被丢了的包，如果发送方连续收到3次相同的ACK，就重传。
![211606-20170111145318525-104172626.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114051.png)
**9. SACK（Selective Acknowledgment）**
选择性确认重传，ACK还是Fast Retransmit的ACK，SACK则是汇报收到的数据，在发送端就可以根据回传的SACK来知道哪些数据到了，哪些没有到。
![211606-20170111145339197-1519390389.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114056.png)
**10. 延迟确认（Delayed ACK）**
如果收到一个包后暂时没什么数据发给对方，那就延迟一段时间再确认。假如这段时间恰好有数据要发送，那数据和确认信息可以在一个包中发送。
**11. LSO**
LSO拯救CPU而出的创意，为了缓解CPU的压力，把它的一部分工作外包给了网卡，比如TCP的分段。
启用LSO之后，TCP层就可以把大于MSS的数据块直接传给网卡，让网卡负责分段。
比如“Seq=348586，Len=2776”，被网卡分为“Seq=348586，Len=1388”和“Seq=349974，Len=1388”两个包。
在发送端抓包相当于站在CPU角度，只看到一个分段前的大包，而接收端就可以看到两个包。
所以才会出现只见重传包，不见原始包的情况。
**12. Nagle算法**
在发出去的数据还没有被确认之前，假如又有小数据生成，那就把小数据收集起来，凑满一个MSS或等收到确认后再发送。
**13. Vegas算法**
通过监控网络状态来调整发包速度。
当网络状态良好时，数据包的RTT比较稳定，这时可以增大拥塞窗口；
当网络开始繁忙时，数据包开始排队，RTT就会变大，这时就减小拥塞窗口。
**6）选项字段**
**PTR（Pointer Record）**：指针记录，PTR记录解析IP地址到域名
**TTL（Time to live）**：
存活时间，限制数据包在网络中存在的时间，防止数据包不断的在IP互联网络上循环，初始值一般为64，每经过一个路由减去1。
通过TTL过滤运营商劫持包，假的包是抢先应答的，所以和真实包的TTL可能不同（例如ip.ttl == 54）
**Seq**：数据段的序号，当接收端收到乱序的包，就能根据此序号重新排序，当前Seq等上一个Seq号与长度相加获取到
**Len**：数据段的长度，这个长度不包括TCP头
**Ack**：确认号，接收方向发送方确认已经收到了哪些字节
**RTT（Round Trip Time）**：也就是一个数据包从发出去到回来的时间
**RTO（Retransmission TimeOut）**：超时重传计数器，描述数据包从发送到失效的时间间隔，是判断数据包丢失与否及网络是否拥塞的重要参数
**MTU（Maximum Transmit Unit）**：最大传输单元
![211606-20170111144750400-1953345030.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114109.png)

**MSS（Maximum Segment Size）**：最长报文段，TCP包所能携带的最大数据量，不包含TCP头和Option。一般为MTU值减去IPv4头部(至少20字节)和TCP头部(至少20字节)得到。

**Win（Window Size）**：声明自己的接收窗口

**TCP Window Scale**：窗口扩张，放在TCP头之外的Option，向对方声明一个shift count，作为2的指数，再乘以TCP定义的接收窗口，得到真正的TCP窗口

**DF（Don't fragment）**：在网络层中，如果带了就丢弃没带就分片
**MF（More fragments）**：0表示最后一个分片，1表示不是最后一片
**7）过滤表达式**
握手请求被对方拒绝：tcp.flags.reset === 1 && tcp.seq === 1
重传的握手请求：tcp.flags.syn === 1 && tcp.analysis.retransmission
过滤延迟确认：tcp.analysis.ack_rtt > 0.2 and tcp.len == 0

# 四、UDP协议

**UDP（User Datagram Protocol）用户数据报协议，提供面向事务的简单不可靠信息传送服务。**
将网络数据流压缩成数据包的形式。每一个数据包的前8个字节保存包头信息，剩余的包含具体的传输数据。
虽然UDP是不可靠的传输协议，但它是分发信息的理想协议，例如在屏幕上报告股票市场、显示航空信息；
在路由信息协议RIP（Routing Information Protocol）中修改路由表、QQ聊天、迅雷、网络电话等。
TCP的效率不一定比UDP低，只要窗口足够大，TCP也可以不受往返时间的约束而源源不断地传数据。
**1）UDP的优势**
1. UDP 协议的头长度不到TCP头的一半，所以同样大小的包里UDP携带的净数据比TCP包多，
2. 没有Seq和Ack等概念，省去了建立连接的开销，DNS解析就使用UDP协议。
**2）UDP的劣势**
1. 超过MTU的时候，发送方的网络层负责分片，接收方收到分片后再组装起来，这个过程会消耗资源，降低性能。
2. 没有重传机制，丢包由应用层处理，某个写操作有6个包，当有一个丢失的时候，就要将6个包重新发送。
![211606-20170117195657646-1412296700.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114117.png)
3. 分片机制存在弱点，接收方是根据包中的“More fragments”的flag来判断是否包已接收完，1表示还有分片，0表示最后一个分片，可以组装了。
如果持续发送flag为1的UDP，接收方无法组装，就有可能耗尽内存。
![211606-20170117200306130-398857268.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114124.png)

# 五、ICMP协议

**ICMP（Internet Control Message Protocol）网际报文控制协议，用于传输错误报告控制信息**，对网络安全有极其重要的意义。
例如请求的服务不可用、主机或路由不可达，ICMP协议依靠IP协议来完成任务，是IP协议的一个集成部分。
通常不被用户网络程序直接使用，多用于ping和tracert等这样的诊断程序。
![211606-20170108160542347-296121480.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114132.jpg)

# 六、DNS协议

**DNS（Domain Name System）域名系统，DNS就是进行域名解析的服务器。**
DNS协议运行在UDP协议之上，端口为53，工作原理如下：
![211606-20170108161117409-976742760.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114144.jpg)
DNS的解析过程：
![211606-20170108161407019-1765801471.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114150.jpg)
DNS客户机向本地域名服务器A发送查询，如果A中没有保存IP地址记录，A就会发请求给根域名服务器B
如果B中也没有，A就发请求给C，再没有就发请求给D，然后是E，找到后将地址发给DNS客户机。
域名解析过程涉及到递归查询和迭代查询。
客户机再与Web服务器连接。
![211606-20170108163521722-1114548493.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114158.jpg)

# 七、HTTP协议

**HTTP（HyperText Transfer Protocol）超文本传输协议，HTTP是一个应用层协议，无状态，由请求和响应构成，是一个标准的客户端服务器模型。**

HTTP工作流程如下：
![211606-20170108164346597-834875445.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114208.jpg)
![211606-20170108164726362-229740261.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114227.jpg)
下面是报文首部字段的说明，表格的摘自《[图解HTTP](https://book.douban.com/subject/25863515/)》。
**HTTP请求头域：**

|     |     |
| --- | --- |
|  Accept |  用户代理能够处理的媒体类型（[MIME](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Basics_of_HTTP/MIME_types)）及媒体类型的相对优先级，“text/plain;q=0.3” |
|  Accpet-Charset |  通知服务器用户代理支持的字符集及字符集的相对优先顺序，“iso-8859-5” |
|  Accept-Encoding |  告知服务器用户代理支持的内容编码及优先级顺序“gzip,deflate” |
|  Accept-Language |  告知服务器用户代理能够处理的自然语言集及优先级，“zh-cn,zh;q=0.7” |
|  Authorization |  用户代理的认证信息（证书值），“Basic dWVub3NlbjpwYNzd==” |
|  Expect |  期望出现的某种特定行为，错误时返回“417 Expectation Failed”，“100-continue” |
|  From |  用户的电子邮箱地址，为了显示搜索引擎等用户代理负责人的联系方式，“info@ha.com” |
|  Host |  请求的资源所处的互联网主机名和端口号，必须包含在请求头中，“www.hh.com” |
|  If-Match |  条件请求，只有当If-Match字段值与ETag匹配才会接受请求，否则返回“412 Precondition Failed” |
|  If-Modified-Since |  若字段值早于资源的更新时间（Last-Modified），资源未更新，返回“304 Not Modified” |
|  If-None-Match |  与If-Match相反 |
|  If-Range |  字段值和请求资源的ETag或时间一致时，作为范围请求处理，反之，返回全体资源 |
|  If-Unmodified-Since |  与If-Modified-Since作用相反 |
|  Max-Forwards |  以十进制整数形式指定可经过的服务器最大数目。服务器转发一次，减少1，当为0就不进行转发 |
|  Proxy-Authorization |  接收从代理服务器发来的认证质询时，发送此字段，告知服务器认证所需要的信息 |
|  Range |  只需获取部分资源的范围请求，“5001-10000”从5001字节到10000字节的资源。 |
|  Referer |  请求的原始资源的URI，也就是上一页 |
|  TE |  客户端能够处理响应的传输编码方式及相对优先级，还可指定Trailer字段分块传输编码的方式。“gzip,deflate;q=0.5” |
| User-Agent |  创建请求的浏览器和用户代理名称等信息 |

![211606-20170108165000503-1181727363.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114236.jpg)![211606-20170108165100409-250784369.png](../_resources/3eddaa4ee053100f6558ff1e9c1850ad.jpg)

**HTTP应答头域：**

|     |     |
| --- | --- |
|  Accpet-Ranges |  告知客户端服务器是否能处理范围请求，以指定获取服务器端某个部分的资源。“bytes” |
|  Age |  源服务器在多久前创建了响应，字段值单位为秒 |
|  ETag |  客户端实体标识，一种可以将资源以字符串形式做唯一标识的方式 |
|  Location |  将响应接收方引导至某个与请求URI位置不同的资源，会配置3xx：Redirection的响应 |
|  Proxy-Authenticate |  由代理服务器所要求的认证信息发送给客户端 |
|  Retry-After |  告知客户端应该在多久（秒数或具体日期）之后再次发送请求，主要配合“503 Service Unavailable”或“3xx Redirect”。 |
|  Server |  当前服务器上安装的HTTP服务器应用程序的信息，包括版本号等。“Apache/2.2.6 (Unix) PHP/5.2.5” |
|  Vary |  对缓存进行控制，设置“Accept-Language”，如果字段值相同，就从缓存返回响应。 |
|  WWW-Authenticate |  HTTP访问认证，告知客户端适用于访问请求URI所指定资源的认证方案（Basic或Digest）和带参数提示的质询（challenge） |

![211606-20170108165315128-1165029106.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114246.jpg)
**HTTP通用头域：**

|     |     |
| --- | --- |
| Cache-Control | 操作缓存的工作机制，多个指令用“,”分割，“private,max-age=0,no-cache” |
| Connection | 控制不再转发给代理的首部字段与管理持久连接，“keep-alive” |
| Date | HTTP报文的日期和时间 |
| Pragema | HTTP1.1之前的遗留字段，作为向后兼容定义，只用在客户端发送的请求中。“no-cache” |
| Trailer | 说明在报文主体后记录了哪些首部字段，可应用在分块编码传输时。在报文最后写了重要信息 |
| Transfer-Encoding | 传输报文主体时采用的编码方式，分块传输“chunked” |
| Upgrade | 检测HTTP协议及其他协议是否可使用更高版本进行通信 |
| Via | 追踪客户端与服务器之间的请求和响应报文的传输路径，各个代理服务器会往Via添加自己的服务器信息 |
| Warning | 告知用户一些与缓存相关问题的警告 |

![211606-20170108165424956-1653930947.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114254.jpg)
**HTTP实体头域：**

|     |     |
| --- | --- |
|  Allow |  告知客户端能够支持Request-URI指定资源的所有HTTP方法，“GET,HEAD”。当不支持，会返回“405 Method Not Allowed” |
|  Content-Encoding |  服务器对实体的主体部分选用的内容编码方式，在不丢失内容的前提下进行压缩。“gzip” |
|  Content-Language |  实体主体使用的自然语言（中文或英文等） |
|  Content-Length |  主体部分的大小（单位是byte） |
|  Content-Location |  给出与报文主体部分相对应的URI，与Location不同 |
|  Content-MD5 |  一串由MD5算法生成的值，目的在于检查报文主体在传输过程中是否保持完整，以及确认传输到达 |
|  Content-Range |  针对范围请求，作为响应返回的实体的哪个部分符合范围请求，单位为byte。“bytes 5001-10000/10000” |
|  Content-Type |  实体主体内对象的媒体类型，与Accpet一样，字段值用type/subtype形式赋值。“text/html; charset=UTF-8” |
|  Expires |  将资源失效的日期告知客户端。当首部字段Cache-Control有指定max-age指令时，优先处理max-age指令 |
|  Last-Modified |  指明资源最终修改时间，一般来说，这个值就是Request-URI指定资源被修改的时间 |

![211606-20170108165534316-881838342.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114302.jpg)

详细信息可以参考MDN的《[HTTP Headers](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers)》

[MIME](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Basics_of_HTTP/MIME_types)(Multipurpose Internet Mail Extensions) 是描述消息内容类型的因特网标准，一种通知客户端其接收文件的多样性的机制，文件后缀名在网页上并没有明确的意义。

# 八、HTTPS协议

**HTTPS（Hypertext Transfer Protocol over Secure Socket Layer）基于SSL的HTTP协议，HTTP的安全版。**

使用端口43，HTTPS协议是由SSL+HTTP协议构建的可进行加密传输和身份认证的网络协议。
**1）HTTPS工作流程**
![211606-20170108173302066-1047085780.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114311.jpg)
**2）SSL**
SSL（Secure Sockets Layer）安全套接层，TLS（Transport Layer Security）传输层安全是其继任者。
SSL和TLS在传输层对网络连接进行加密。
SSL协议分为两层，SSL记录协议（SSL Record Protocol）和SSL握手协议（SSL Handshake Protocol）。
SSL记录协议建立在TCP之上，提供数据封装、压缩加密基本功能的支持。
SSL握手协议建立在SSL记录协议之上，在数据传输之前，通信双方进行身份认证、协商加密算法和交换加密秘钥等。
SSL工作分为两个阶段，服务器认证和用户认证。
SSL协议既用到了公钥加密（非对称加密）又用到了对称加密技术。
**3）数据包**
![211606-20170114183354666-1670442035.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114318.png)
客户端与服务器之间的通信：
![211606-20170108205513425-1646556867.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114348.jpg)
**1.客户端发出请求（Client Hello）**

![211606-20170115211319166-283538674.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114402.jpg)![211606-20170115211603181-1478340977.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114429.jpg)

**2.服务器响应（Server Hello）**

![211606-20170115211929697-1404952591.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114449.jpg)![211606-20170115211929697-1404952591.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114458.jpg)

**3）证书信息**

![211606-20170115212149806-852628991.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114517.jpg)![211606-20170115212303322-886681430.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114523.jpg)![211606-20170115212407447-1814593842.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114619.jpg)

**3.密钥交换**

![211606-20170115212841541-1480758201.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114641.jpg)![211606-20170115212950150-1487179932.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114655.jpg)

**4.应用层信息通信**
用户可以发送通过TLS层使用RC4的写实例加密过的普通HTTP消息，也可以解密服务端RC4写实例发过来的消息。
此外，TLS层通过计算消息内容的HMAC_MD5哈希值来校验每一条消息是否被篡改。

参考资料：
[Wireshark网络分析的艺术](http://download.csdn.net/download/loneleaf1/9730490)
[Wireshark数据包分析实战详解](http://download.csdn.net/download/loneleaf1/9730491)
[车小胖谈网络：MTU 与 MSS](https://zhuanlan.zhihu.com/p/21268782)
[MTU & MSS 详解记录](http://infotech.blog.51cto.com/391844/123859)
[网络传输分片、MTU、MSS](http://blog.csdn.net/peijian1998/article/details/40106965)

[理解TCP序列号（Sequence Number）和确认号（Acknowledgment Number）](http://blog.csdn.net/a19881029/article/details/38091243)

[wireshark抓包图解 TCP三次握手/四次挥手详解](http://www.seanyxie.com/wireshark%E6%8A%93%E5%8C%85%E5%9B%BE%E8%A7%A3-tcp%E4%B8%89%E6%AC%A1%E6%8F%A1%E6%89%8B%E5%9B%9B%E6%AC%A1%E6%8C%A5%E6%89%8B%E8%AF%A6%E8%A7%A3/)

[TCP 的那些事儿（下）](http://coolshell.cn/articles/11609.html)

[TCP segment of a reassembled PDU](http://blog.163.com/hlz_2599/blog/static/142378474201151933643431/)

[SSL/TLS协议运行机制的概述](http://www.ruanyifeng.com/blog/2014/02/ssl_tls.html)

[如何通过Wireshark查看HTTPS、HTTP/2网络包（解码TLS、SSL）](http://joji.me/zh-cn/blog/walkthrough-decrypt-ssl-tls-traffic-https-and-http2-in-wireshark)