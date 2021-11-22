
# web前端高级工程师，面试题

1：简述前后端通讯的过程（三次握手，四次挥手）？
**TCP(Transmission Control Protocol)　传输控制协议**

## 1､TCP三次握手和四次挥手的过程图

![181351206012825.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105133005.png)

tcp的6种标志位的分别代表：
SYN(synchronous建立联机)
ACK(acknowledgement 确认)
PSH(push传送)
FIN(finish结束)
RST(reset重置)
URG(urgent紧急)
Sequence number(顺序号码)
Acknowledge number(确认号码)
**客户端TCP状态迁移：**
CLOSED->SYN_SENT->ESTABLISHED->FIN_WAIT_1->FIN_WAIT_2->TIME_WAIT->CLOSED
**服务器TCP状态迁移：**
CLOSED->LISTEN->SYN收到->ESTABLISHED->CLOSE_WAIT->LAST_ACK->CLOSED

**各个状态的意义如下：**
LISTEN - 侦听来自远方TCP端口的连接请求；
SYN-SENT -在发送连接请求后等待匹配的连接请求；
SYN-RECEIVED - 在收到和发送一个连接请求后等待对连接请求的确认；
ESTABLISHED- 代表一个打开的连接，数据可以传送给用户；
FIN-WAIT-1 - 等待远程TCP的连接中断请求，或先前的连接中断请求的确认；
FIN-WAIT-2 - 从远程TCP等待连接中断请求；
CLOSE-WAIT - 等待从本地用户发来的连接中断请求；
CLOSING -等待远程TCP对连接中断的确认；
LAST-ACK - 等待原来发向远程TCP的连接中断请求的确认；
TIME-WAIT -等待足够的时间以确保远程TCP接收到连接中断请求的确认；
CLOSED - 没有任何连接状态；

下面具体说说三次握手和四次挥手过程：

### 1.1 三次握手

###

TCP是主机对主机层的传输控制协议，提供可靠的连接服务，采用三次握手确认建立一个连接:
TCP/IP协议中，TCP协议提供可靠的连接服务，采用三次握手建立一个连接，如图1所示。
![TCPConnect.JPG](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105133013.jpg)
图1 TCP三次握手建立连接![291246111727359.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105133018.png)
（1）第一次握手：建立连接时，客户端A发送SYN包（SYN=j）到服务器B，并进入SYN_SEND状态，等待服务器B确认。

（2）第二次握手：服务器B收到SYN包，必须确认客户A的SYN（ACK=j+1），同时自己也发送一个SYN包（SYN=k），即SYN+ACK包，此时服务器B进入SYN_RECV状态。

（3）第三次握手：客户端A收到服务器B的SYN＋ACK包，向服务器B发送确认包ACK（ACK=k+1），此包发送完毕，客户端A和服务器B进入ESTABLISHED状态，完成三次握手。

完成三次握手，客户端与服务器开始传送数据。
**确认号：其数值等于发送方的**发送序号 +1**(即接收方期望接收的下一个序列号)。**
**TCP****的包头结构：**
源端口 16位
目标端口 16位
序列号 32位
回应序号 32位
TCP头长度 4位
reserved 6位
控制代码 6位
窗口大小 16位
偏移量 16位
校验和 16位
选项 32位(可选)
这样我们得出了TCP包头的最小长度，为20字节

- 第一次握手:

客户端发送一个TCP的SYN标志位置1的包指明客户打算连接的服务器的端口，以及初始序号X,保存在包头的序列号(Sequence Number)字段里。

- 第二次握手:

服务器发回确认包(ACK)应答。即SYN标志位和ACK标志位均为1同时，将确认序号(Acknowledgement Number)设置为客户的I S N加1以.即X+1。

- 第三次握手.

客户端再次发送确认包(ACK) SYN标志位为0,ACK标志位为1.并且把服务器发来ACK的序号字段+1,放在确定字段中发送给对方.并且在数据段放写ISN的+1

下面是具体的例子截图：
1.此图包含两部分信息：TCP的三次握手(方框中的内容） （SYN, (SYN+ACK), ACK)
2. TCP的数据传输 （[TCP segment of a reassembled PUD])可以看出，server是将数据TCP层对消息包进行分片传输

(1)Server端收到HTTP请求如GET之后，构造响应消息，其中携带网页内容，在server端的HTTP层发送消息200 OK->server端的TCP层；

(2)server端的TCP层对消息包进行分片传输；
(3)client端的TCP层对接收到的各个消息包分片回送响应；

(4)client端的TCP层每次收到一部分都会用ACK确认，之后server继续传输，client继续确认，直到完成响应消息的所有分片之后，Server**发送组合HTTP响应包 200 O**K，此时在client端的消息跟踪中才可以显示**HTTP 200 OK**的消息包

![021812235945327.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105133026.jpg)

### 1.2 四次挥手，关闭连接

###

由于TCP连接是全双工的，因此每个方向都必须单独进行关闭。这个原则是当一方完成它的数据发送任务后就能发送一个FIN来终止这个方向的连接。收到一个 FIN只意味着这一方向上没有数据流动，一个TCP连接在收到一个FIN后仍能发送数据。首先进行关闭的一方将执行主动关闭，而另一方执行被动关闭。

CP的连接的拆除需要发送四个包，因此称为四次挥手(four-way handshake)。客户端或服务器均可主动发起挥手动作，在socket编程中，任何一方执行close()操作即可产生挥手操作。

（1）客户端A发送一个FIN，用来关闭客户A到服务器B的数据传送。
（2）服务器B收到这个FIN，它发回一个ACK，确认序号为收到的序号加1。和SYN一样，一个FIN将占用一个序号。
（3）服务器B关闭与客户端A的连接，发送一个FIN给客户端A。
（4）客户端A发回ACK报文确认，并将确认序号设置为收到序号加1。
TCP采用四次挥手关闭连接如图2所示。
![281600391879667.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105133034.png)
图2 TCP四次挥手关闭连接

参见wireshark抓包，实测的抓包结果并没有严格按挥手时序。我估计是时间间隔太短造成。
![](http://blogimg.chinaunix.net/blog/upfile2/100327023334.png)

## 2､深入理解TCP

##

**连接的释放：**

由于TCP连接是全双工的，因此每个方向都必须单独进行关闭。这原则是当一方完成它的数据发送任务后就能发送一个FIN来终止这个方向的连接。收到一个 FIN只意味着这一方向上没有数据流动，一个TCP连接在收到一个FIN后仍能发送数据。首先进行关闭的一方将执行主动关闭，而另一方执行被动关闭。

TCP协议的连接是全双工连接，一个TCP连接存在双向的读写通道。
简单说来是 “先关读，后关写”，一共需要四个阶段。以客户机发起关闭连接为例：
1.服务器读通道关闭
2.客户机写通道关闭
3.客户机读通道关闭
4.服务器写通道关闭

关闭行为是在发起方数据发送完毕之后，给对方发出一个FIN（finish）数据段。直到接收到对方发送的FIN，且对方收到了接收确认ACK之后，双方的数据通信完全结束，过程中每次接收都需要返回确认数据段ACK。

详细过程：
**第一阶段** 客户机发送完数据之后，向服务器发送一个**FIN**数据段，序列号为**i**；
1.服务器收到**FIN(i)**后，返回确认段**ACK**，序列号为**i+1**，**关闭服务器读通道**；
2.客户机收到**ACK(i+1)**后，**关闭客户机写通道**；
（此时，客户机仍能通过读通道读取服务器的数据，服务器仍能通过写通道写数据）
**第二阶段 **服务器发送完数据之后，向客户机发送一个FIN数据段，序列号为j；
3.客户机收到**FIN(j)**后，返回确认段**ACK**，序列号为**j+1**，**关闭客户机读通道**；
4.服务器收到**ACK(j+1)**后，**关闭服务器写通道**。
这是标准的TCP关闭两个阶段，服务器和客户机都可以发起关闭，完全对称。

FIN标识是通过发送最后一块数据时设置的，标准的例子中，服务器还在发送数据，所以要等到发送完的时候，设置FIN（此时可称为TCP连接处于**半关闭状态，**因为数据仍可从被动关闭一方向主动关闭方传送）。如果在服务器收到FIN(i)时，已经没有数据需要发送，可以在返回ACK(i+1)的时候就设置FIN(j)标识，这样就相当于可以合并第二步和第三步。读《Linux网络编程》关闭TCP连接章节，作以下笔记：

## 3､TCP的TIME_WAIT和Close_Wait状态

面试时看到应聘者简历中写精通网络，TCP编程，我常问一个问题，TCP建立连接需要几次握手？95%以上的应聘者都能答对是3次。问TCP断开连接需要几次握手，70%的应聘者能答对是4次通讯。再问CLOSE_WAIT，TIME_WAIT是什么状态，怎么产生的，对服务有什么影响，如何消除？有一部分同学就回答不上来。不是我扣细节，而是在通讯为主的前端服务器上，必须有能力处理各种TCP状态。比如统计在本厂的一台前端机上高峰时间TCP连接的情况，统计命令：

Linux shell代码
```
netstat -n | awk ’/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}’
```
结果：
![84326b90-3259-337a-84c9-1051ac366772.jpg](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105133047.jpg)

除了ESTABLISHED，可以看到连接数比较多的几个状态是：FIN_WAIT1, TIME_WAIT, CLOSE_WAIT, SYN_RECV和LAST_ACK；下面的文章就这几个状态的产生条件、对系统的影响以及处理方式进行简单描述。

**TCP状态**
TCP状态如下图所示：
![bdf8d214-c8de-3b2a-8a53-219a0dce3259.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105133052.png)
可能有点眼花缭乱？再看看这个时序图

![5d4e8c89-fc42-3862-bdb8-399bc982f410.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105133100.png)

## 4､三种TCP状态

### 4.1 SYN_RECV

服务端收到建立连接的SYN没有收到ACK包的时候处在SYN_RECV状态。有两个相关系统配置：

1，net.ipv4.tcp_synack_retries ：INTEGER
默认值是5

对于远端的连接请求SYN，内核会发送SYN ＋ ACK数据报，以确认收到上一个 SYN连接请求包。这是所谓的三次握手( threeway handshake)机制的第二个步骤。这里决定内核在放弃连接之前所送出的 SYN+ACK 数目。不应该大于255，默认值是5，对应于180秒左右时间。通常我们不对这个值进行修改，因为我们希望TCP连接不要因为偶尔的丢包而无法建立。

2，net.ipv4.tcp_syncookies

一般服务器都会设置net.ipv4.tcp_syncookies=1来防止SYN Flood攻击。假设一个用户向服务器发送了SYN报文后突然死机或掉线，那么服务器在发出SYN+ACK应答报文后是无法收到客户端的ACK报文的（第三次握手无法完成），这种情况下服务器端一般会重试（再次发送SYN+ACK给客户端）并等待一段时间后丢弃这个未完成的连接，这段时间的长度我们称为SYN Timeout，一般来说这个时间是分钟的数量级（大约为30秒-2分钟）。

这些处在SYNC_RECV的TCP连接称为半连接，并存储在内核的半连接队列中，在内核收到对端发送的ack包时会查找半连接队列，并将符合的requst_sock信息存储到完成三次握手的连接的队列中，然后删除此半连接。大量SYNC_RECV的TCP连接会导致半连接队列溢出，这样后续的连接建立请求会被内核直接丢弃，这就是SYN Flood攻击。

能够有效防范SYN Flood攻击的手段之一，就是SYN Cookie。SYN Cookie原理由D. J. Bernstain和 Eric Schenk发明。SYN Cookie是对TCP服务器端的三次握手协议作一些修改，专门用来防范SYN Flood攻击的一种手段。它的原理是，在TCP服务器收到TCP SYN包并返回TCP SYN+ACK包时，不分配一个专门的数据区，而是根据这个SYN包计算出一个cookie值。在收到TCP ACK包时，TCP服务器在根据那个cookie值检查这个TCP ACK包的合法性。如果合法，再分配专门的数据区进行处理未来的TCP连接。

观测服务上SYN_RECV连接个数为：7314，对于一个高并发连接的通讯服务器，这个数字比较正常。

### 4.2 CLOSE_WAIT

发起TCP连接关闭的一方称为client，被动关闭的一方称为server。被动关闭的server收到FIN后，但未发出ACK的TCP状态是CLOSE_WAIT。出现这种状况一般都是由于server端代码的问题，如果你的服务器上出现大量CLOSE_WAIT，应该要考虑检查代码。

### 4.3 TIME_WAIT

根据TCP协议定义的3次握手断开连接规定,发起socket主动关闭的一方 socket将进入TIME_WAIT状态。TIME_WAIT状态将持续2个MSL(Max Segment Lifetime),在Windows下默认为4分钟，即240秒。TIME_WAIT状态下的socket不能被回收使用. 具体现象是对于一个处理大量短连接的服务器,如果是由服务器主动关闭客户端的连接，将导致服务器端存在大量的处于TIME_WAIT状态的socket， 甚至比处于Established状态下的socket多的多,严重影响服务器的处理能力，甚至耗尽可用的socket，停止服务。

## 5､ 为什么需要TIME_WAIT？

TIME_WAIT是TCP协议用以保证被重新分配的socket不会受到之前残留的延迟重发报文影响的机制,是必要的逻辑保证。

和TIME_WAIT状态有关的系统参数有一般由3个，本厂设置如下：
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_fin_timeout = 30

net.ipv4.tcp_fin_timeout，默认60s，减小fin_timeout，减少TIME_WAIT连接数量。

net.ipv4.tcp_tw_reuse = 1表示开启重用。允许将TIME-WAIT sockets重新用于新的TCP连接，默认为0，表示关闭；
net.ipv4.tcp_tw_recycle = 1表示开启TCP连接中TIME-WAIT sockets的快速回收，默认为0，表示关闭。

为了方便描述，我给这个TCP连接的一端起名为Client，给另外一端起名为Server。上图描述的是Client主动关闭的过程，FTP协议中就这样的。如果要描述Server主动关闭的过程，只要交换描述过程中的Server和Client就可以了，HTTP协议就是这样的。

描述过程：

Client调用close()函数，给Server发送FIN，请求关闭连接；Server收到FIN之后给Client返回确认ACK，同时关闭读通道（不清楚就去看一下shutdown和close的差别），也就是说现在不能再从这个连接上读取东西，现在read返回0。此时Server的TCP状态转化为CLOSE_WAIT状态。

Client收到对自己的FIN确认后，关闭 写通道，不再向连接中写入任何数据。

接下来Server调用close()来关闭连接，给Client发送FIN，Client收到后给Server回复ACK确认，同时Client关闭读通道，进入TIME_WAIT状态。

Server接收到Client对自己的FIN的确认ACK，关闭写通道，TCP连接转化为CLOSED，也就是关闭连接。
Client在TIME_WAIT状态下要等待最大数据段生存期的两倍，然后才进入CLOSED状态，TCP协议关闭连接过程彻底结束。
以上就是TCP协议关闭连接的过程，现在说一下TIME_WAIT状态。
从上面可以看到，主动发起关闭连接的操作的一方将达到TIME_WAIT状态，而且这个状态要保持Maximum Segment Lifetime的两倍时间。
原因有二：
一、保证TCP协议的全双工连接能够可靠关闭
二、保证这次连接的重复数据段从网络中消失

先说第一点，如果Client直接CLOSED了，那么由于IP协议的不可靠性或者是其它网络原因，导致Server没有收到Client最后回复的ACK。那么Server就会在超时之后继续发送FIN，此时由于Client已经CLOSED了，就找不到与重发的FIN对应的连接，最后Server就会收到RST而不是ACK，Server就会以为是连接错误把问题报告给高层。这样的情况虽然不会造成数据丢失，但是却导致TCP协议不符合可靠连接的要求。所以，Client不是直接进入CLOSED，而是要保持TIME_WAIT，当再次收到FIN的时候，能够保证对方收到ACK，最后正确的关闭连接。

再说第二点，如果Client直接CLOSED，然后又再向Server发起一个新连接，我们不能保证这个新连接与刚关闭的连接的端口号是不同的。也就是说有可能新连接和老连接的端口号是相同的。一般来说不会发生什么问题，但是还是有特殊情况出现：假设新连接和已经关闭的老连接端口号是一样的，如果前一次连接的某些数据仍然滞留在网络中，这些延迟数据在建立新连接之后才到达Server，由于新连接和老连接的端口号是一样的，又因为TCP协议判断不同连接的依据是socket pair，于是，TCP协议就认为那个延迟的数据是属于新连接的，这样就和真正的新连接的数据包发生混淆了。所以TCP连接还要在TIME_WAIT状态等待2倍MSL，这样可以保证本次连接的所有数据都从网络中消失。

2：webpack 和 gulp 的区别

# [对webpack和gulp的理解和区别](https://www.cnblogs.com/wenshaochang123/p/7978773.html)

webpack是前端构建工具，称为模块打包机，webpack支持模块化；构建前端开发过程中常用的文件，如：js，css，html，img等；使用简单方便，自动化构建。webpack是通过loader（加载器）和plugins（插件）对资源进行处理的。

Glup侧重于前端开发的整个过程的控制管理，我们可以通过给glup配置不同的task来让glup实现不同的功能，从而构建整个前端开发流程。（通过gulp中的gulp.task（）方法配置，比如server、sass/less预编译、文件的合并压缩等等）

区别：
gulp严格上讲，模块化不是他强调的东西，他旨在规范前端开发流程。
webpack更是明显强调模块化开发，而那些文件压缩合并、预处理等功能，不过是他附带的功能。

3:tcp,udp的区别？
**TCP****协议与UDP协议的区别**

    **首先咱们弄清楚，****TCP****协议和****UCP****协议与****TCP/IP****协议的联系，很多人犯糊涂了，一直都是说****TCP/IP****协议与****UDP****协议的区别，我觉得这是没有从本质上弄清楚网络通信！**

**TCP/IP****协议是一个协议簇。里面包括很多协议的。UDP只是其中的一个。之所以命名为TCP/IP协议，因为TCP,IP协议是两个很重要的协议，就用他两命名了。**

TCP/IP协议集包括应用层,传输层，网络层，网络访问层。
其中应用层包括:
超文本传输协议(HTTP):万维网的基本协议.
文件传输(TFTP简单文件传输协议):
远程登录(Telnet),提供远程访问其它主机功能,它允许用户登录
internet主机,并在这台主机上执行命令.
网络管理(SNMP简单网络管理协议),该协议提供了监控网络设备的方法,以及配置管理,统计信息收集,性能管理及安全管理等.
域名系统(DNS),该系统用于在internet中将域名及其公共广播的网络节点转换成IP地址.
其次网络层包括:
Internet协议(IP)
Internet控制信息协议(ICMP)
地址解析协议(ARP)
反向地址解析协议(RARP)

最后说网络访问层:网络访问层又称作主机到网络层(host-to-network).网络访问层的功能包括IP地址与物理地址硬件的映射,以及将IP封装成帧.基于不同硬件类型的网络接口,网络访问层定义了和物理介质的连接.

当然我这里说得不够完善，TCP/IP协议本来就是一门学问，每一个分支都是一个很复杂的流程，但我相信每位学习软件开发的同学都有必要去仔细了解一番。
**下面我着重讲解一下****TCP****协议和****UDP****协议的区别。**

**TCP****（Transmission Control Protocol，传输控制协议）**是面向连接的协议，也就是说，在收发数据前，必须和对方建立可靠的连接。一个TCP连接必须要经过三次“对话”才能建立起来，其中的过程非常复杂，只简单的描述下这三次对话的简单过程：主机A向主机B发出连接请求数据包：“我想给你发数据，可以吗？”，这是第一次对话；主机B向主机A发送同意连接和要求同步（同步就是两台主机一个在发送，一个在接收，协调工作）的数据包：“可以，你什么时候发？”，这是第二次对话；主机A再发出一个数据包确认主机B的要求同步：“我现在就发，你接着吧！”，这是第三次对话。三次“对话”的目的是使数据包的发送和接收同步，经过三次“对话”之后，主机A才向主机B正式发送数据。

详细点说就是：（文章部分转载[http://zhangjiangxing-gmail-com.iteye.com](http://zhangjiangxing-gmail-com.iteye.com/)，主要是这个人讲解得很到位，的确很容易使人理解！）

**TCP****三次握手过程**
1 主机A通过向主机B 发送一个含有同步序列号的标志位的数据段给主机B ,向主机B 请求建立连接,通过这个数据段,
主机A告诉主机B 两件事:我想要和你通信;你可以用哪个序列号作为起始数据段来回应我.
2 主机B 收到主机A的请求后,用一个带有确认应答(ACK)和同步序列号(SYN)标志位的数据段响应主机A,也告诉主机A两件事:
我已经收到你的请求了,你可以传输数据了;你要用哪佧序列号作为起始数据段来回应我
3 主机A收到这个数据段后,再发送一个确认应答,确认已收到主机B 的数据段:"我已收到回复,我现在要开始传输实际数据了
这样3次握手就完成了,主机A和主机B 就可以传输数据了.
3次握手的特点
没有应用层的数据
SYN这个标志位只有在TCP建产连接时才会被置1
握手完成后SYN标志位被置0

**TCP****建立连接要进行3次握手,而断开连接要进行4次**

1 当主机A完成数据传输后,将控制位FIN置1,提出停止TCP连接的请求
2  主机B收到FIN后对其作出响应,确认这一方向上的TCP连接将关闭,将ACK置1
3 由B 端再提出反方向的关闭请求,将FIN置1
4 主机A对主机B的请求进行确认,将ACK置1,双方向的关闭结束.
由TCP的三次握手和四次断开可以看出,TCP使用面向连接的通信方式,大大提高了数据通信的可靠性,使发送数据端
和接收端在数据正式传输前就有了交互,为数据正式传输打下了可靠的基础
**名词解释**
ACK  TCP报头的控制位之一,对数据进行确认.确认由目的端发出,用它来告诉发送端这个序列号之前的数据段

都收到了.比如,确认号为X,则表示前X-1个数据段都收到了,只有当ACK=1时,确认号才有效,当ACK=0时,确认号无效,这时会要求重传数据,保证数据的完整性.

SYN  同步序列号,TCP建立连接时将这个位置1
FIN  发送端完成发送任务位,当TCP完成数据传输需要断开时,提出断开连接的一方将这位置1
**TCP****的包头结构：**
源端口 16位
目标端口 16位
序列号 32位
回应序号 32位
TCP头长度 4位
reserved 6位
控制代码 6位
窗口大小 16位
偏移量 16位
校验和 16位
选项  32位(可选)
这样我们得出了TCP包头的最小长度，为20字节。

**UDP****（User Data Protocol，用户数据报协议）**

（1） UDP是一个非连接的协议，传输数据之前源端和终端不建立连接，当它想传送时就简单地去抓取来自应用程序的数据，并尽可能快地把它扔到网络上。在发送端，UDP传送数据的速度仅仅是受应用程序生成数据的速度、计算机的能力和传输带宽的限制；在接收端，UDP把每个消息段放在队列中，应用程序每次从队列中读一个消息段。

（2） 由于传输数据不建立连接，因此也就不需要维护连接状态，包括收发状态等，因此一台服务机可同时向多个客户机传输相同的消息。
（3） UDP信息包的标题很短，只有8个字节，相对于TCP的20个字节信息包的额外开销很小。
（4） 吞吐量不受拥挤控制算法的调节，只受应用软件生成数据的速率、传输带宽、源端和终端主机性能的限制。
（5）UDP使用**尽最大努力交付，**即不保证可靠交付，因此主机不需要维持复杂的链接状态表（这里面有许多参数）。

（6）UDP是**面向报文**的。发送方的UDP对应用程序交下来的报文，在添加首部后就向下交付给IP层。既不拆分，也不合并，而是保留这些报文的边界，因此，应用程序需要选择合适的报文大小。

我们经常使用“ping”命令来测试两台主机之间TCP/IP通信是否正常，其实“ping”命令的原理就是向对方主机发送UDP数据包，然后对方主机确认收到数据包，如果数据包是否到达的消息及时反馈回来，那么网络就是通的。

**UDP****的包头结构：**
源端口 16位
目的端口 16位
长度 16位
校验和 16位

**小结TCP与UDP的区别：**

1、TCP面向连接（如打电话要先拨号建立连接）;UDP是无连接的，即发送数据之前不需要建立连接
2、TCP提供可靠的服务。也就是说，通过TCP连接传送的数据，无差错，不丢失，不重复，且按序到达;UDP尽最大努力交付，即不保证可靠交付

Tcp通过校验和，重传控制，序号标识，滑动窗口、确认应答实现可靠传输。如丢包时的重发控制，还可以对次序乱掉的分包进行顺序控制。

3、UDP具有较好的实时性，工作效率比TCP高，适用于对高速传输和实时性有较高的通信或广播通信。

4.每一条TCP连接只能是点到点的;UDP支持一对一，一对多，多对一和多对多的交互通信

1. TCP对系统资源要求较多，UDP对系统资源要求较少。
1.基于连接与无连接；
2.对系统资源的要求（TCP较多，UDP少）；
3.UDP程序结构较简单；
4.流模式与数据报模式 ；
5.TCP保证数据正确性，UDP可能丢包，TCP保证数据顺序，UDP不保证。

****4.闭包是什么，有什么特性，对页面有什么影响****
    答：我的理解是，闭包就是能够读取其他函数内部变量的函数。在本质上，闭包就是将函数内部和函数外部连接起来的一座桥梁。

```
function outer(){  
 var num = 1;  
 function inner(){  
 var n = 2;  
 alert(n + num);  
 }  
 return inner;  
}  
outer()();
```

## 5:浏览不兼容：浏览器版本，内核的不同

### html常见兼容性问题？

1.双边距BUG float引起的  使用display
2.3像素问题 使用float引起的 使用dislpay:inline -3px
3.超链接hover 点击后失效  使用正确的书写顺序 link visited hover active
4.Ie z-index问题 给父级添加position:relative
5.Png 透明 使用js代码 改
6.Min-height 最小高度 ！Important 解决’
7.select 在ie6下遮盖 使用iframe嵌套
8.为什么没有办法定义1px左右的宽度容器（IE6默认的行高造成的，使用over:hidden,zoom:0.08 line-height:1px）
9.IE5-8不支持opacity，解决办法：
.opacity {
    opacity: 0.4
    filter: alpha(opacity=60); /* for IE5-7 */

    -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=60)"; /* for IE 8*/

}
10. IE6不支持PNG透明背景，解决办法: IE6下使用gif图片

6：Get和post的区别
    get参数通过url传递，post放在request body中。

    get请求在url中传递的参数是有长度限制的，而post没有。

    get比post更不安全，因为参数直接暴露在url中，所以不能用来传递敏感信息。

        get请求只能进行url编码，而post支持多种编码方式

        get请求会浏览器主动cache，而post支持多种编码方式。

        get请求参数会被完整保留在浏览历史记录里，而post中的参数不会被保留。

    GET和POST本质上就是TCP链接，并无差别。但是由于HTTP的规定和浏览器/服务器的限制，导致他们在应用过程中体现出一些不同。

    GET产生一个TCP数据包；POST产生两个TCP数据包。
ajax.请求头，applation......
j发送jipost请求的方法如下面所示：
```
var XMLHttpReq;
//创建XMLHttpRequest对象
function createXMLHttpRequest() {if(window.XMLHttpRequest) { //Mozilla 浏览
XMLHttpReq = new XMLHttpRequest();}
else if (window.ActiveXObject) { // IE浏览器
try {XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
} catch (e) {try {XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
} catch (e) {}
//发送请求函
function sendRequest(url,para) {
createXMLHttpRequest();
XMLHttpReq.open("POST", url,true);
XMLHttpReq.onreadystatechange = processResponse;//指定响应函数
XMLHttpReq.setRequestHeader("Content-Type", "application/x-www-form-
urlencoded");
XMLHttpReq.send(para);  // 发送请求}// 处理返回信息函数
```
在通过POST方式向服务器发送AJAX请求时最好要通过设置请求头来指定为application/x-www-form-urlencoded编码类型。知道通过表单上传文件时必须指定编码类型为"multipart/form-data"。ajax.setRequestHeader("content-type","application/x-www-form-urlencoded")表示将请求中的内容，按照UTF-8的方式进行编码，只针对POST请求有效，设置此内容是为了确保服务器知道实体中有参数变量，注意: 请求体格式和请求头的Content-Type类型必须保持一致,如果1的格式,设置Content-Type是application/json,或者2的格式,设置Content-Type是application/x-www-form-urlencoded,后台接收到的请求提都会是空的

# 7.[js中return；、return true、return false;区别](https://www.cnblogs.com/weiwang/p/3268374.html)

一、返回控制与函数结果，
语法为：return 表达式;
语句结束函数执行，返回调用函数，而且把表达式的值作为函数的结果
 二、返回控制，
无函数结果，语法为：return;

 在大多数情况下,为事件处理函数返回false,可以防止默认的事件行为.例如,默认情况下点击一个<a>元素,页面会跳转到该元素href属性指定的页.    Return False 就相当于终止符，Return True 就相当于执行符。    在js中return false的作用一般是用来取消默认动作的。比如你单击一个链接除了触发你的    onclick时间（如果你指定的话）以外还要触发一个默认事件就是执行页面的跳转。所以如果    你想取消对象的默认动作就可以return false。

首先在js中，我们常用return false来**阻止提交表单**或**者继续执行下面的代码，**通俗的来说就是阻止执行默认的行为。
```
	function a（）{
	   if（True）
		   return false;
	},
```
这是没有任何问题的。
如果我改成这种
```
function Test（）{
   a（）;
   b（）;
   c（）;
}
```
即使a函数返回return false 阻止提交了，但是不影响 b（）以及 c（）函数的执行。在Test（）函数里调用a()函数，那面里面
return false 对于Test（）函数来说，只是相当于返回值。而不能阻止Test（）函数执行。
**总之：return false 只在当前函数有效，不会影响其他外部函数的执行。**

**三：总结**
**retrun true； 返回正确的处理结果。**
**return false；返回错误的处理结果，终止处理。**
**return；把控制权返回给页面。**

**8:**URL 输入到页面展现的过程简述
在浏览器中输入URL到整个页面显示在用户面前这个过程大致可以被分为以下几个阶段：
1. 域名解析
2. 服务器处理
3. 网站处理
4. 浏览器处理与绘制
URL的定义

URL（Uniform Resource Locator），即统一资源定位符，是对可以从互联网上得到的资源的位置和访问方法的一种简洁的表示，是互联网上标准资源的地址（网址）。互联网上的每个文件都有一个唯一的URL，它包含的信息指出文件的位置以及浏览器应该怎么处理它。

基本URL包含模式（或称协议）、服务器名称（或IP地址）、路径和文件名，如“协议://授权/路径查询”。完整的、带有授权部分的普通统一资源标志符语法看上去如下：协议://用户名:密码@子域名.域名.顶级域名:端口号/目录/文件名.文件后缀?参数=值#标志

URL常用协议有:

- http——超文本传输协议资源
- https——用安全套接字层传送的超文本传输协议（加密）
- ftp——文件传输协议
- mailto——电子邮件地址
- file——当地电脑或网上分享的文件

# 具体过程介绍

# 一、域名解析

互联网上每一台计算机的唯一标识是它的IP地址，但是IP地址并不方便记忆。用户更喜欢用方便记忆的网址去寻找互联网上的其它计算机。所以互联网设计者需要在用户的方便性与可用性方面做一个权衡，这个权衡就是一个网址到IP地址的转换，这个过程就是域名解析。它实际上充当了一个翻译的角色，实现了网址到IP地址的转换。域名的解析工作由DNS服务器完成。

**IP 地址**：IP 协议为互联网上的每一个网络和每一台主机分配的一个逻辑地址。IP 地址如同门牌号码，通过 IP 地址才能确定一台主机位置。服务器本质也是一台主机，想要访问某个服务器，必须先知道它的 IP 地址

**域名（ DN ）**：IP 地址由四个数字组成，中间用点号连接，在使用过程中难记忆且易输入错误，所以用我们熟悉的字母和数字组合来代替纯数字的 IP 地址，比如我们只会记住 [www.baidu.com](https://link.jianshu.com/?t=http://www.baidu.com)（百度域名） 而不是 220.181.112.244（百度的其中一个 IP 地址）。

**DNS**： 每个域名都对应一个或多个提供相同服务服务器的 IP 地址，只有知道服务器 IP 地址才能建立连接，所以需要通过 DNS 把域名解析成一个 IP 地址。

具体流程
1. 浏览器搜索自己的DNS缓存 – 浏览器会缓存DNS记录一段时间
2. 搜索操作系统中的Hosts文件 - 从 Hosts 文件查找是否有该域名和对应 IP。
3. 搜索路由器缓存 – 一般路由器也会缓存域名信息。
4. 搜索ISP DNS 缓存 （ISP:互联网服务提供商）– 比如到电信的 DNS 上查找缓存。
如果都没有找到，则向根域名服务器查找域名对应 IP，根域名服务器把请求转发到下一级，直到找到 IP
**小知识**：
1. 8.8.8.8 ：8.8.8.8是一个IP地址，是Google提供的免费DNS服务器的IP地址
114.114.114.114 ：是国内第一个、全球第三个开放的DNS服务地址,又称114DNS
2. DNS劫持：

DNS劫持又称域名劫持，是指在劫持的网络范围内拦截域名解析的请求，分析请求的域名，把审查范围以外的请求放行，否则返回假的IP地址或者什么都不做使请求失去响应，其效果就是对特定的网络不能反应或访问的是假网址。

# 二、服务器处理

服务器是一台安装系统的机器，常见的系统如Linux、windows server 2012等系统里安装的处理请求的应用叫 **Web server**（web服务器）

常见的 web服务器有 Apache、Nginx、IIS、Lighttpd
web服务器接收用户的Request 交给网站代码，或者接受请求反向代理到其他 web服务器
[webp](../_resources/30b26b3876d21c03633dfb78e23feb4d.webp)
> ** 饥人谷服务器处理过程示意图**

# 三、网站处理

[webp](../_resources/dfe65ec9ae621c3d4612e891239d8dc7.webp)
> **MVC架构网站处理示意图**.png

**MVC**全名是Model View Controller，是模型(model)－视图(view)－控制器(controller)的缩写，一种软件设计典范，用一种业务逻辑、数据、界面显示分离的方法组织代码，将业务逻辑聚集到一个部件里面，在改进和个性化定制界面及用户交互的同时，不需要重新编写业务逻辑。MVC被独特的发展起来用于映射传统的输入、处理和输出功能在一个逻辑的图形化用户界面的结构中。

- Model（模型）：是应用程序中用于处理应用程序数据逻辑的部分，通常模型对象负责在数据库中存取数据。
- View（视图）：是应用程序中处理数据显示的部分。，通常视图是依据模型数据创建的。（**前端工程师主要负责**）
- Controller（控制器）：是应用程序中处理用户交互的部分，通常控制器负责从视图读取数据，控制用户输入，并向模型发送数据。

# 四、浏览器处理与绘制

解析过程：

- HTML字符串被浏览器接受后被一句句读取解析
- 解析到link 标签后重新发送请求获取css；解析到 script标签后发送请求获取 js，并执行代码
- 解析到img 标签后发送请求获取图片资源

绘制过程：

- 浏览器根据 HTML 和 CSS 计算得到渲染树，绘制到屏幕上，js 会被执行

解析顺序：

- 浏览器是一个边解析边渲染的过程。首先浏览器解析HTML文件构建DOM树，然后解析CSS文件构建渲染树，等到渲染树构建完成后，浏览器开始布局渲染树并将其绘制到屏幕上。
- JS的解析是由浏览器中的JS解析引擎完成的。JS是单线程运行，也就是说，在同一个时间内只能做一件事，所有的任务都需要排队，前一个任务结束，后一个任务才能开始。
- 浏览器在解析过程中，如果遇到请求外部资源时请求过程是异步的，并不会影响HTML文档进行加载，但是当文档加载过程中遇到JS文件，HTML文档会挂起渲染过程，不仅要等到文档中JS文件加载完毕还要等待解析执行完毕，才会继续HTML的渲染过程。原因是因为JS有可能修改DOM结构，这就意味着JS执行完成前，后续所有资源的下载是没有必要的，这就是JS阻塞后续资源下载的根本原因。CSS文件的加载不影响JS文件的加载，但是却影响JS文件的执行。JS代码执行前浏览器必须保证CSS文件已经下载并加载完毕。

链接：https://www.jianshu.com/p/63166522c244

9:浅谈HTTP中Get、Post、Put与Delete的区别

1、GET请求会向数据库发索取数据的请求，从而来获取信息，该请求就像数据库的select操作一样，只是用来查询一下数据，不会修改、增加数据，不会影响资源的内容，即该请求不会产生副作用。无论进行多少次操作，结果都是一样的。

2、与GET不同的是，PUT请求是向服务器端发送数据的，从而改变信息，该请求就像数据库的update操作一样，用来修改数据的内容，但是不会增加数据的种类等，也就是说无论进行多少次PUT操作，其结果并没有不同。

3、POST请求同PUT请求类似，都是向服务器端发送数据的，但是该请求会改变数据的种类等资源，就像数据库的insert操作一样，会创建新的内容。几乎目前所有的提交操作都是用POST请求的。

4、DELETE请求顾名思义，就是用来删除某一个资源的，该请求就像数据库的delete操作。

就像前面所讲的一样，既然PUT和POST操作都是向服务器端发送数据的，那么两者有什么区别呢。。。POST主要作用在一个集合资源之上的（url），而PUT主要作用在一个具体资源之上的（url/xxx），通俗一下讲就是，如URL可以在客户端确定，那么可使用PUT，否则用POST。

综上所述，我们可理解为以下：
1、POST /url 创建
2、DELETE /url/xxx 删除
3、PUT /url/xxx 更新
4、GET /url/xxx 查看

 Http定义了与服务器交互的不同方法，最基本的方法有4种，分别是GET，POST，PUT，DELETE。URL全称是统一资源定位符，我们可以这样认为：一个URL地址，它用于描述一个网络上的资源，而HTTP中的GET，POST，PUT，DELETE就对应着对这个资源的查，改，增，删4个操作。到这里，大家应该有个大概的了解了，GET一般用于获取/查询资源信息，而POST一般用于更新资源信息。

**1**.根据HTTP规范，GET用于信息获取，而且应该是安全的和幂等的。

(1).所谓安全的意味着该操作用于获取信息而非修改信息。换句话说，GET 请求一般不应产生副作用。就是说，它仅仅是获取资源信息，就像[**数据库**](http://lib.csdn.net/base/14)查询一样，不会修改，增加数据，不会影响资源的状态。

* 注意：这里安全的含义仅仅是指是非修改信息。
(2).幂等的意味着对同一URL的多个请求应该返回同样的结果。这里我再解释一下**幂等**这个概念：
**幂等**（idempotent、idempotence）是一个数学或计算机学概念，常见于抽象代数中。
　　幂等有一下几种定义：

　　对于单目运算，如果一个运算对于在范围内的所有的一个数多次进行该运算所得的结果和进行一次该运算所得的结果是一样的，那么我们就称该运算是幂等的。比如绝对值运算就是一个例子，在实数集中，有abs(a)=abs(abs(a))。

　　对于双目运算，则要求当参与运算的两个值是等值的情况下，如果满足运算结果与参与运算的两个值相等，则称该运算幂等，如求两个数的最大值的函数，有在在实数集中幂等，即max(x,x) = x。

看完上述解释后，应该可以理解GET幂等的含义了。

　　但在实际应用中，以上2条规定并没有这么严格。引用别人文章的例子：比如，新闻站点的头版不断更新。虽然第二次请求会返回不同的一批新闻，该操作仍然被认为是安全的和幂等的，因为它总是返回当前的新闻。从根本上说，如果目标是当用户打开一个链接时，他可以确信从自身的角度来看没有改变资源即可。

**2**.根据HTTP规范，POST表示可能修改变服务器上的资源的请求。继续引用上面的例子：还是新闻以网站为例，读者对新闻发表自己的评论应该通过POST实现，因为在评论提交后站点的资源已经不同了，或者说资源被修改了。

　　上面大概说了一下HTTP规范中GET和POST的一些原理性的问题。但在实际的做的时候，很多人却没有按照HTTP规范去做，导致这个问题的原因有很多，比如说：
**1**.很多人贪方便，更新资源时用了GET，因为用POST必须要到FORM（表单），这样会麻烦一点。
**2**.对资源的增，删，改，查操作，其实都可以通过GET/POST完成，不需要用到PUT和DELETE。

**3**.另外一个是，早期的Web MVC框架设计者们并没有有意识地将URL当作抽象的资源来看待和设计，所以导致一个比较严重的问题是传统的Web MVC框架基本上都只支持GET和POST两种HTTP方法，而不支持PUT和DELETE方法。

 　　* 简单解释一下MVC：MVC本来是存在于Desktop程序中的，M是指数据模型，V是指用户界面，C则是控制器。使用MVC的目的是将M和V的实现代码分离，从而使同一个程序可以使用不同的表现形式。

　　以上3点典型地描述了老一套的风格（没有严格遵守HTTP规范），随着[**架构**](http://lib.csdn.net/base/16)的发展，现在出现REST(Representational State Transfer)，一套支持HTTP规范的新风格，这里不多说了，可以参考《RESTful Web Services》。

　　说完原理性的问题，我们再从表面现像上面看看GET和POST的区别：

**1**.GET请求的数据会附在URL之后（就是把数据放置在HTTP协议头中），以?分割URL和传输数据，参数之间以&相连，如：login.action?name=hyddd&password=idontknow&verify=%E4%BD%A0%E5%A5%BD。如果数据是英文字母/数字，原样发送，如果是空格，转换为+，如果是中文/其他字符，则直接把字符串用BASE64加密，得出如：%E4%BD%A0%E5%A5%BD，其中％XX中的XX为该符号以16进制表示的ASCII。

POST把提交的数据则放置在是HTTP包的包体中。
**2**."GET方式提交的数据最多只能是1024字节，理论上POST没有限制，可传较大量的数据，IIS4中最大为80KB，IIS5中为100KB"？？！
　　以上这句是我从其他文章转过来的，其实这样说是错误的，不准确的：

(1).首先是"GET方式提交的数据最多只能是1024字节"，因为GET是通过URL提交数据，那么GET可提交的数据量就跟URL的长度有直接关系了。而实际上，URL不存在参数上限的问题，HTTP协议规范没有对URL长度进行限制。这个限制是特定的浏览器及服务器对它的限制。IE对URL长度的限制是2083字节(2K+35)。对于其他浏览器，如Netscape、FireFox等，理论上没有长度限制，其限制取决于操作系统的支持。

　　注意这是限制是整个URL长度，而不仅仅是你的参数值数据长度。[见参考资料5]

(2).理论上讲，POST是没有大小限制的，HTTP协议规范也没有进行大小限制，说“POST数据量存在80K/100K的大小限制”是不准确的，POST数据是没有限制的，起限制作用的是服务器的处理程序的处理能力。

　　对于ASP程序，Request对象处理每个表单域时存在100K的数据长度限制。但如果使用Request.BinaryRead则没有这个限制。
　　由这个延伸出去，对于IIS 6.0，微软出于安全考虑，加大了限制。我们还需要注意：
1).IIS 6.0默认ASP POST数据量最大为200KB，每个表单域限制是100KB。
2).IIS 6.0默认上传文件的最大大小是4MB。
3).IIS 6.0默认最大请求头是16KB。
IIS 6.0之前没有这些限制。[见参考资料5]

　　所以上面的80K，100K可能只是默认值而已(注：关于IIS4和IIS5的参数，我还没有确认)，但肯定是可以自己设置的。由于每个版本的IIS对这些参数的默认值都不一样，具体请参考相关的IIS配置文档。

**3**.在ASP中，服务端获取GET请求参数用Request.QueryString，获取POST请求参数用Request.Form。在JSP中，用request.getParameter(\"XXXX\")来获取，虽然jsp中也有request.getQueryString()方法，但使用起来比较麻烦，比如：传一个test.jsp?name=hyddd&password=hyddd，用request.getQueryString()得到的是：name=hyddd&password=hyddd。在PHP中，可以用$_GET和$_POST分别获取GET和POST中的数据，而$_REQUEST则可以获取GET和POST两种请求中的数据。值得注意的是，JSP中使用request和PHP中使用$_REQUEST都会有隐患，这个下次再写个文章总结。

**4**.POST的安全性要比GET的安全性高。注意：这里所说的安全性和上面GET提到的“安全”不是同个概念。上面“安全”的含义仅仅是不作数据修改，而这里安全的含义是真正的Security的含义，比如：通过GET提交数据，用户名和密码将明文出现在URL上，因为(1)登录页面有可能被浏览器缓存，(2)其他人查看浏览器的历史纪录，那么别人就可以拿到你的账号和密码了，除此之外，使用GET提交数据还可能会造成Cross-site request forgery攻击。

　　总结一下，Get是向服务器发索取数据的一种请求，而Post是向服务器提交数据的一种请求，在FORM（表单）中，Method默认为"GET"，实质上，GET和POST只是发送机制不同，并不是一个取一个发！

10:[什么是作用域链，什么是原型链，它们的区别，在js中它们具体指什么？](https://www.cnblogs.com/pssp/p/5204324.html)

什么是作用域链，什么是原型链。
　　作用域是针对变量的，比如我们创建了一个函数，函数里面又包含了一个函数，那么现在就有三个作用域
　　全局作用域==>函数1作用域==>函数2作用域
作用域的特点就是，先在自己的变量范围中查找，如果找不到，就会沿着作用域往上找。
如：
```
var a = 1;
function b(){
var a = 2;
function c(){
var a = 3;
console.log(a);
}
c();
}
b();
```


最后打印出来的是3，因为执行函数c（）的时候它在自己的范围内找到了变量a所以就不会越上继续查找，如果在函数c()中没有找到则会继续向上找，一直会找到全局变量a，这个查找的过程就叫作用域链。

不知道你有没有疑问，函数c为什么可以在函数b中查找变量a，因为函数c是在函数b中创建的，也就是说函数c的作用域包括了函数b的作用域，当然也包括了全局作用域，但是函数b不能向函数c中查找变量，因为作用域只会向上查找。

那么什么是原型链呢？

　　原型链是针对构造函数的，比如我先创建了一个函数，然后通过一个变量new了这个函数，那么这个被new出来的函数就会继承创建出来的那个函数的属性，然后如果我访问new出来的这个函数的某个属性，但是我并没有在这个new出来的函数中定义这个变量，那么它就会往上（向创建出它的函数中）查找，这个查找的过程就叫做原型链。

Object ==> 构造函数1 ==> 构造函数2
就和css中的继承一样，如果自身没有定义就会继承父元素的样式。
```
function a(){};
a.prototype.name = "追梦子";
var b = new a();
console.log(b.name); //追梦子
```
11:JS继承的实现方式
前言
JS作为面向对象的弱类型语言，继承也是其非常强大的特性之一。那么如何在JS中实现继承呢？让我们拭目以待。

## JS继承的实现方式

既然要实现继承，那么首先我们得有一个父类，代码如下：
```
1. `// 定义一个动物类`
2. `function Animal (name) {`
3. `// 属性`
4. `this.name = name || 'Animal';`
5. `// 实例方法`
6. `this.sleep = function(){`
7. `console.log(this.name + '正在睡觉！');`
8. `}`
9. `}`
10. `// 原型方法`
11. `Animal.prototype.eat = function(food) {`
12. `console.log(this.name + '正在吃：' + food);`
13. `};`
```
### 1、原型链继承

**核心：** 将父类的实例作为子类的原型
```
1. `function Cat(){ `
2. `}`
3. `Cat.prototype = new Animal();`
4. `Cat.prototype.name = 'cat';`
5.
6. `//　Test Code`
7. `var cat = new Cat();`
8. `console.log(cat.name);`
9. `console.log(cat.eat('fish'));`
10. `console.log(cat.sleep());`
11. `console.log(cat instanceof Animal); //true `
12. `console.log(cat instanceof Cat); //true`
```
特点：
1. 非常纯粹的继承关系，实例是子类的实例，也是父类的实例
2. 父类新增原型方法/原型属性，子类都能访问到
3. 简单，易于实现
缺点：
1. 要想为子类新增属性和方法，必须要在`new Animal()`这样的语句之后执行，不能放到构造器中
2. 无法实现多继承
3. 来自原型对象的引用属性是所有实例共享的（详细请看附录代码： [示例1]()）
4. 创建子类实例时，无法向父类构造函数传参
推荐指数：★★（3、4两大致命缺陷）

**2017-8-17 10:21:43补充：感谢 [MMHS](http://home.cnblogs.com/u/1066372/) 指出。缺点1中描述有误：可以在Cat构造函数中，为Cat实例增加实例属性。如果要新增原型属性和方法，则必须放在`new Animal()`这样的语句之后执行。**

### 2、构造继承

**核心：**使用父类的构造函数来增强子类实例，等于是复制父类的实例属性给子类（没用到原型）
```
1. `function Cat(name){`
2. `Animal.call(this);`
3. `this.name = name || 'Tom';`
4. `}`
5.
6. `// Test Code`
7. `var cat = new Cat();`
8. `console.log(cat.name);`
9. `console.log(cat.sleep());`
10. `console.log(cat instanceof Animal); // false`
11. `console.log(cat instanceof Cat); // true`
```
特点：
1. 解决了1中，子类实例共享父类引用属性的问题
2. 创建子类实例时，可以向父类传递参数
3. 可以实现多继承（call多个父类对象）
缺点：
1. 实例并不是父类的实例，只是子类的实例
2. 只能继承父类的实例属性和方法，不能继承原型属性/方法
3. 无法实现函数复用，每个子类都有父类实例函数的副本，影响性能
推荐指数：★★（缺点3）

### 3、实例继承

**核心：**为父类实例添加新特性，作为子类实例返回
```
1. `function Cat(name){`
2. `var instance = new Animal();`
3. `instance.name = name || 'Tom';`
4. `return instance;`
5. `}`
6.
7. `// Test Code`
8. `var cat = new Cat();`
9. `console.log(cat.name);`
10. `console.log(cat.sleep());`
11. `console.log(cat instanceof Animal); // true`
12. `console.log(cat instanceof Cat); // false`
```
特点：
1. 不限制调用方式，不管是`new 子类()`还是`子类()`,返回的对象具有相同的效果
缺点：
1. 实例是父类的实例，不是子类的实例
2. 不支持多继承
推荐指数：★★

### 4、拷贝继承
```
1. `function Cat(name){`
2. `var animal = new Animal();`
3. `for(var p in animal){`
4. `Cat.prototype[p] = animal[p];`
5. `}`
6. `Cat.prototype.name = name || 'Tom';`
7. `}`
8.
9. `// Test Code`
10. `var cat = new Cat();`
11. `console.log(cat.name);`
12. `console.log(cat.sleep());`
13. `console.log(cat instanceof Animal); // false`
14. `console.log(cat instanceof Cat); // true`
```
特点：
1. 支持多继承
缺点：
1. 效率较低，内存占用高（因为要拷贝父类的属性）
2. 无法获取父类不可枚举的方法（不可枚举方法，不能使用for in 访问到）
推荐指数：★（缺点1）

### 5、组合继承

**核心：**通过调用父类构造，继承父类的属性并保留传参的优点，然后通过将父类实例作为子类原型，实现函数复用
```
1. `function Cat(name){`
2. `Animal.call(this);`
3. `this.name = name || 'Tom';`
4. `}`
5. `Cat.prototype = new Animal();`
6.

7. `**// 感谢 @[学无止境c](http://www.cnblogs.com/long-long/) 的提醒，组合继承也是需要修复构造函数指向的。**`

8.
9. `**Cat.prototype.constructor = Cat;**`
10.
11. `// Test Code`
12. `var cat = new Cat();`
13. `console.log(cat.name);`
14. `console.log(cat.sleep());`
15. `console.log(cat instanceof Animal); // true`
16. `console.log(cat instanceof Cat); // true`
```
特点：
1. 弥补了方式2的缺陷，可以继承实例属性/方法，也可以继承原型属性/方法
2. 既是子类的实例，也是父类的实例
3. 不存在引用属性共享问题
4. 可传参
5. 函数可复用
缺点：
1. 调用了两次父类构造函数，生成了两份实例（子类实例将子类原型上的那份屏蔽了）
推荐指数：★★★★（仅仅多消耗了一点内存）

### 6、寄生组合继承

**核心：**通过寄生方式，砍掉父类的实例属性，这样，在调用两次父类的构造的时候，就不会初始化两次实例方法/属性，避免的组合继承的缺点
```
1. `function Cat(name){`
2. `Animal.call(this);`
3. `this.name = name || 'Tom';`
4. `}`
5. `(function(){`
6. `// 创建一个没有实例方法的类`
7. `var Super = function(){};`
8. `Super.prototype = Animal.prototype;`
9. `//将实例作为子类的原型`
10. `Cat.prototype = new Super();`
11. `})();`
12.
13. `// Test Code`
14. `var cat = new Cat();`
15. `console.log(cat.name);`
16. `console.log(cat.sleep());`
17. `console.log(cat instanceof Animal); // true`
18. `console.log(cat instanceof Cat); //true`
19.

20. `**感谢 @[bluedrink](http://home.cnblogs.com/u/1291442/) 提醒，该实现没有修复constructor。**`

21.
22. `Cat.prototype.constructor = Cat; // 需要修复下构造函数`
```
特点：
1. 堪称完美
缺点：
1. 实现较为复杂
推荐指数：★★★★（实现复杂，扣掉一颗星）

## 附录代码：

示例一：
```
1. `function Animal (name) {`
2. `// 属性`
3. `this.name = name || 'Animal';`
4. `// 实例方法`
5. `this.sleep = function(){`
6. `console.log(this.name + '正在睡觉！');`
7. `}`
8. `//实例引用属性`
9. `this.features = [];`
10. `}`
11. `function Cat(name){`
12. `}`
13. `Cat.prototype = new Animal();`
14.
15. `var tom = new Cat('Tom');`
16. `var kissy = new Cat('Kissy');`
17.
18. `console.log(tom.name); // "Animal"`
19. `console.log(kissy.name); // "Animal"`
20. `console.log(tom.features); // []`
21. `console.log(kissy.features); // []`
22.
23. `tom.name = 'Tom-New Name';`
24. `tom.features.push('eat');`
25.
26. `//针对父类实例值类型成员的更改，不影响`
27. `console.log(tom.name); // "Tom-New Name"`
28. `console.log(kissy.name); // "Animal"`
29. `//针对父类实例引用类型成员的更改，会通过影响其他子类实例`
30. `console.log(tom.features); // ['eat']`
31. `console.log(kissy.features); // ['eat']`
32.
33. `原因分析：`
34.
35. `关键点：属性查找过程`
36.
37. `执行tom.features.push，首先找tom对象的实例属性（找不到），`
38. `那么去原型对象中找，也就是Animal的实例。发现有，那么就直接在这个对象的`
39. `features属性中插入值。`
40. `在console.log(kissy.features); 的时候。同上，kissy实例上没有，那么去原型上找。`
41. `刚好原型上有，就直接返回，但是注意，这个原型对象中features属性值已经变化了。`
```
12:简述下前后端，以及服务器他们是如何如何协同工作的？

前后端分工协作是一个老生常谈的大话题，很多公司都在尝试用工程化的方式去提升前后端之间交流的效率，降低沟通成本，并且也开发了大量的工具。但是几乎没有一种方式是令双方都很满意的。事实上，也不可能让所有人都满意。根本原因还是前后端之间的交集不够大，交流的核心往往只限于接口及接口往外扩散的一部分。这也是为什么很多公司在招聘的时候希望前端人员熟练掌握一门后台语言，后端同学了解前端的相关知识。

### 一、开发流程

前端切完图，处理好接口信息，接着就是把静态demo交给后台去拼接，这是一般的流程。这种流程存在很多的缺陷。

- 后端同学对文件进行拆分拼接的时候，由于对前端知识不熟悉，可能会搞出一堆bug，到最后又需要前端同学帮助分析原因，而前端同学又不是特别了解后端使用的模板，造成尴尬的局面。
- 如果前端没有使用统一化的文件夹结构，并且静态资源（如图片，css，js等）没有剥离出来放到 CDN，而是使用相对路径去引用，当后端同学需要对静态资源作相关配置时，又得修改各个link，script标签的src属性，容易出错。
- 接口问题

    1. 后端数据没有准备好，前端需要自己模拟一套，成本高，如果后期接口有改变，自己模拟的那套数据又不行了。

    2. 后端数据已经开发好，接口也准备好了，本地需要代理线上数据进行测试。这里有两个费神的地方，一是需要代理，否则可能跨域，二是接口信息如果改动，后期接你项目的人需要改你的代码，麻烦。

- 不方便控制输出。为了让首屏加载速度快一点，我们期望后端先吐出一点数据，剩下的才去 ajax 渲染，但让后端吐出多少数据，我们不好控。

当然，存在的问题远不止上面枚举的这些，这种传统的方式实在是不酷（Kimi 附身^_^）。还有一种开发流程，SPA（single page application），前后端职责相当清晰，后端给我接口，我全部用 ajax 异步请求，这种方式，在现代浏览器中可以使用 PJAX 稍微提高体验，Facebook 早在三四年前对这种 SPA 的模式提出了一套解决方案，quickling+bigpipe，解决了 SEO 以及数据吐出过慢的问题。他的缺点也是十分明显的：

- 页面太重，前端渲染工作量也大
- 首屏还是慢
- 前后端模板复用不了
- SEO 依然很狗血（quickling 架构成本高）
- history 管理麻烦

问题多的已经是无力吐槽了，当然他依然有自己的优势，咱们也不能一票否决。
针对上面看到的问题，现在也有一些团队在尝试前后端之间加一个中间层（比如淘宝UED的 MidWay ）。这个中间层由前端来控制。
+----------------+

| F2E |

+---↑--------↑---+

| | +---↓--------↓---+
| Middle |

+---↑--------↑---+

| | +---↓--------↓---+
| R2E |

+----------------+

中间层的作用就是为了更好的控制数据的输出，如果用MVC模型去分析这个接口，R2E（后端）只负责 M（数据） 这部分，Middle（中间层）处理数据的呈现（包括 V 和 C）。淘宝UED有很多类似的文章，这里不赘述。

### 二、核心问题

上面提出了在业务中看到的常见的三种模式，问题的核心就是数据交给谁去处理。数据交给后台处理，这是模式一，数据交给前端处理，这是模式二，数据交给前端分层处理，这是模式三。三种模式没有优劣之分，其使用还是得看具体场景。

既然都是数据的问题，数据从哪里来？这个问题又回到了接口。

- 接口文档由谁来撰写和维护？
- 接口信息的改动如何向前后端传递？
- 如何根据接口规范拿到前后端可用的测试数据？
- 使用哪种接口？JSON，JSONP？
- JSONP 的安全性问题如何处理？

这一系列的问题一直困扰着奋战在前线的前端工程师和后端开发者。淘宝团队做了两套接口文档的维护工具，IMS以及DIP，不知道有没有对外开放，两个东西都是基于 JSON Schema 的一个尝试，各有优劣。JSON Schema 是对 JSON 的一个规范，类似我们在数据库中创建表一样，对每个字段做一些限制，这里也是一样的原理，可以对字段进行描述，设置类型，限制字段属性等。

接口文档这个事情，使用 JSON Schema 可以自动化生产，所以只需编写 JSON Schema 而不存在维护问题，在写好的 Schema 中多加些限制性的参数，我们就可以直接根据 Schema 生成 mock（测试） 数据。

mock 数据的外部调用，这倒是很好处理：
typeof callback === "function" && callback({
json: "jsonContent"
})

在请求的参数中加入 callback 参数，如 /mock/hashString?cb=callback，一般的 io(ajax) 库都对异步数据获取做了封装，我们在测试的时候使用 jsonp，回头上线，将 dataType 改成 json 就行了。
```
IO({
url: "http://barretlee.com",
dataType: "jsonp", //json
success: function(){}
})
```
这里略微麻烦的是 POST 方法，jsonp 只能使用 get 方式插入 script 节点去请求数据，但是 POST，只能呵呵了。
这里的处理也有多重方式可以参考：

- 修改 Hosts，让 mock 的域名指向开发域名
- mock 设置 header 响应头，Access-Allow-Origin-Control

对于如何拿到跨域的接口信息，我也给出几个参考方案：

- fiddler 替换包，好像是支持正则的，感兴趣的可以研究下（求分享研究结果，因为我没找到正则的设置位置）
- 使用 HTTPX 或者其他代理工具，原理和 fiddler 类似，不过可视化效果（体验）要好很多，毕竟人家是专门做代理用的。
- 自己写一段脚本代理，也就是本地开一个代理服务器，这里需要考虑端口的占用问题。其实我不推荐监听端口，一个比较不错的方案是本地请求全部指向一个脚本文件，然后脚本转发URL，如：

原始请求：http://barretlee.com/api/test.json
在ajax请求的时候：
```
$.ajax({
url: "http://<local>/api.php?path=/api/text.json"
});
php中处理就比较简单啦：
if(!isset($_GET["page"])){
echo 0;
exit();
}
echo file_get_contents($_GET["path"]);
```
- Ctrl+S,保存把线上的接口数据到本地的api文件夹吧-_-||

### 三、小结

本文只是对前后端协作存在的问题和现有的几种常见模式做了简要的列举，JSON Schema 具体如何去运用，还有接口的维护问题、接口信息的获取问题没有具体阐述，这个后续有时间会整理下我对他的理解。

我的总结，文章主要分享前后端技术协作相关技术问题的解决方法，主要包括前后期开发接口确定等，需要先验知识为ajax、mock、json等。

ajax：Asynchronous Javascript **A**nd XML”（异步JavaScript和XML），是指一种创建交互式[网页](http://baike.baidu.com/view/828.htm)应用的网页开发技术。

Mock:通常是指，在测试一个对象A时，我们构造一些假的对象来模拟与A之间的交互，而这些Mock对象的行为是我们事先设定且符合预期。通过这些Mock对象来测试A在正常逻辑，异常逻辑或压力情况下工作是否正常。

引入Mock最大的优势在于：Mock的行为固定，它确保当你访问该Mock的某个方法时总是能够获得一个没有任何逻辑的直接就返回的预期结果。
Mock Object的使用通常会带来以下一些好处：
隔绝其他模块出错引起本模块的测试错误。
隔绝其他模块的开发状态，只要定义好接口，不用管他们开发有没有完成。
一些速度较慢的操作，可以用Mock Object代替，快速返回。
对于分布式系统的测试，使用Mock Object会有另外两项很重要的收益：
通过Mock Object可以将一些分布式测试转化为本地的测试
将Mock用于压力测试，可以解决测试集群无法模拟线上集群大规模下的压力。

JSON：(JavaScript Object Notation) 是一种轻量级的数据交换格式。它基于ECMAScript的一个子集。 JSON采用完全独立于语言的文本格式，但是也使用了类似于C语言家族的习惯（包括C、C++、C#、Java、JavaScript、Perl、Python等）。这些特性使JSON成为理想的数据交换语言。 易于人阅读和编写，同时也易于机器解析和生成(网络传输速率)。

JSONP：(JSON

with Padding)是[JSON](http://baike.baidu.com/view/136475.htm)的一种“使用模式”，可用于解决主流浏览器的跨域数据访问的问题。由于同源策略，一般来说位于

server1.example.com 的网页无法与不是 server1.example.com的服务器沟通，而 HTML 的<script> 元素是一个例外。

13：五大浏览器和其对应的内核
浏览器的内核是分为两个部分的，一是渲染引擎，另一个是JS引擎。现在JS引擎比较独立，内核更加倾向于说渲染引擎。

1、Trident内核：代表作品是IE，因IE捆绑在Windows中，所以占有极高的份额，又称为IE内核或MSHTML，此内核只能用于Windows平台，且不是开源的。

    代表作品还有腾讯、Maxthon（遨游）、360浏览器等。但由于市场份额比较大，曾经出现脱离了W3C标准的时候，同时IE版本比较多，
    存在很多的兼容性问题。

2、Gecko内核：代表作品是Firefox，即火狐浏览器。因火狐是最多的用户，故常被称为firefox内核它是开源的，最大优势是跨平台，在Microsoft Windows、Linux、MacOs X等主   要操作系统中使用。

   Mozilla是网景公司在第一次浏览器大战败给微软之后创建的。有兴趣的同学可以了解一下浏览器大战
3、Webkit内核：代表作品是Safari、曾经的Chrome，是开源的项目。

4、Presto内核：代表作品是Opera，Presto是由Opera Software开发的浏览器排版引擎，它是世界公认最快的渲染速度的引擎。在13年之后，Opera宣布加入谷歌阵营，弃用了    Presto

5、Blink内核：由Google和Opera Software开发的浏览器排版引擎，2013年4月发布。现在Chrome内核是Blink。谷歌还开发了自己的JS引擎，V8，使JS运行速度极大地提高了