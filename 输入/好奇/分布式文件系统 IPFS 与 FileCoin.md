分布式文件系统 IPFS 与 FileCoin

# 分布式文件系统 IPFS 与 FileCoin

 22 May 2018  [聊聊区块链](https://draveness.me/tag/%E8%81%8A%E8%81%8A%E5%8C%BA%E5%9D%97%E9%93%BE)  [区块链](https://draveness.me/tag/%E5%8C%BA%E5%9D%97%E9%93%BE)  [IPFS](https://draveness.me/tag/IPFS)  [Filecoin](https://draveness.me/tag/Filecoin)

在这篇文章中，我想聊一聊最近比较热门的 IPFS（InterPlanetary File System），一个点对点的分布式文件系统；从 HTTP 协议出现到今天已经过去了半个多世纪，很少有一些设计能够增强整个 HTTP 网络或者为它带来新的功能。

![2018-05-22-ipfs.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231110618.png)

使用 HTTP 协议传递相对小的文件其实是非常廉价和方便的，但是随着计算资源和存储空间的指数增长，我们面临了需要随时获取大量数据的问题，而 IPFS 就是为了解决这一问题出现的。

## [(L)](https://draveness.me/ipfs-filecoin#%E6%9E%B6%E6%9E%84%E8%AE%BE%E8%AE%A1)架构设计

作为一个分布式的文件系统，IPFS 提供了一个支持部署和写入的平台，同时能够支持大文件的分发和版本管理；为了达到上述的目的，IPFS 协议被分成如下的几个子协议：

![2018-05-22-ipfs-protocol-stack.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231110624.png)
上述的七个子协议分别负责 IPFS 中的不同功能，我们将在接下来的章节中分别介绍各个协议分别做了哪些工作以及 IPFS 是如何实现的。

### [(L)](https://draveness.me/ipfs-filecoin#%E8%BA%AB%E4%BB%BD)身份

在 IPFS 网络中，所有的节点都通过唯一的 `NodeId` 进行标识，与 Bitcoin 的地址有一些相似， 它其实是一个公钥的哈希，然而为了增加攻击者的成本，IPFS 使用 [S/Kademlia](http://www.spovnet.de/files/publications/SKademlia2007.pdf) 中提到的算法增加创建新身份的成本：

	difficulty = <integer parameter>
	n = Node{}
	do {
	  n.PubKey, n.PrivKey = PKI.genKeyPair()
	  n.NodeId = hash(n.PubKey)
	  p = count_preceding_zero_bits(hash(n.NodeId))
	} while (p < difficulty)

每一个节点在 IPFS 代码中都由 `Node` 结构体来表示，其中只包含 `NodeId` 以及一个公私钥对：

	type NodeId Multihash
	type Multihash []byte
	type PublicKey []byte
	type PrivateKey []byte
	
	type Node struct {
	  NodeId NodeId
	  PubKey PublicKey
	  PriKey PrivateKey
	}

总之，身份系统的主要作用就是表示 IPFS 网络中的每一个节点，代表每一个使用 IPFS 的『用户』。

### [(L)](https://draveness.me/ipfs-filecoin#%E7%BD%91%E7%BB%9C)网络

作为一个分布式的存储系统，节点之间的通信和信息传递都需要通过网络进行，同时能够使用多种传输层协议并保证可靠性、连通性、信息的完整性以及真实性。
![2018-05-22-nodes.png](D:\document\我的坚果云\我的坚果云\技术荟萃\_resources\554cfd54d75f65f16f613b67969b5726.png)

IPFS 可以使用任意的网络进行通信，它并没有假设自己一定运行在 IP 协议上，而是通过 `multiaddr` 的格式来表示目标地址和使用的协议，以此来兼容和扩展未来可能出现的其他网络协议：

	/ip4/10.20.30/40/sctp/1234/
	/ip4/5.6.7.8/tcp/5678/ip4/1.2.3.4/sctp/1234/

### [(L)](https://draveness.me/ipfs-filecoin#%E8%B7%AF%E7%94%B1)路由

在一个分布式系统中，检索或者访问其他节点中存储的资源就需要通过一个路由系统，IPFS 使用了基于 S/Kademlia 和 Coral 中的 DSHT 实现了路由系统，我们能够在 [libp2p/go-libp2p-routing/routing.go](https://github.com/libp2p/go-libp2p-routing/blob/a5abeac4bc668bc194588a7f118c0eaf2f6894f4/routing.go#L19-L74) 中找到 IPFS 路由系统的接口：

	type IpfsRouting interface {
		ContentRouting
		PeerRouting
		ValueStore
	
		Bootstrap(context.Context) error
	}
	
	type ContentRouting interface {
		Provide(context.Context, *cid.Cid, bool) error
		FindProvidersAsync(context.Context, *cid.Cid, int) <-chan pstore.PeerInfo
	}
	
	type PeerRouting interface {
		FindPeer(context.Context, peer.ID) (pstore.PeerInfo, error)
	}
	
	type ValueStore interface {
		PutValue(context.Context, string, []byte) error
		GetValue(context.Context, string) ([]byte, error)
		GetValues(c context.Context, k string, count int) ([]RecvdVal, error)
	}

从这里我们可以看到 IPFS 中的路由需要实现三种基本的功能，内容路由、节点路由以及数据存储。实现了这几些接口的『路由器』就可以在底层进行替换，不会影响系统其他部分的工作。目前 IPFS 使用全局 DHT 和 DNS 来解析路由记录，而 Kademlia DHT 有以下的优点：

1. 在批量节点中快速找到目标地址，时间复杂度是 $log_2(n)$，也就是说，在 10,000,000 节点中只需要 20 次查询；

2. 优化了节点之间的控制消息长度，降低了信息协调的开销；

3. 通过优先选择长期节点抵御多种网络攻击；

4. 在点对点的应用中被广泛应用，例如 BitTorrent 和 Gnutella，技术也比较成熟；

### [(L)](https://draveness.me/ipfs-filecoin#%E6%95%B0%E6%8D%AE%E4%BA%A4%E6%8D%A2)数据交换

在 IPFS 中，数据的分发和交换使用 BitSwap 协议，BitSwap 负责两件事情：向其他节点请求需要的 Block 以及为其他节点提供 Block。
![2018-05-22-BitSwap-api.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231111432.png)

当我们需要向其他节点请求 Block 或者为其他节点提供 Block 时，都会发送 BitSwap 消息，其中主要包含了两部分内容：发送者的 `wantlist` 以及数据块，整个消息都是使用 Protobuf 进行编码的：

	message Message {
	  message Wantlist {
	    message Entry {
	      optional string block = 1; // the block key
	      optional int32 priority = 2; // the priority (normalized). default to 1
	      optional bool cancel = 3;  // whether this revokes an entry
	    }
	
	    repeated Entry entries = 1; // a list of wantlist entries
	    optional bool full = 2;     // whether this is the full wantlist. default to false
	  }
	
	  optional Wantlist wantlist = 1;
	  repeated bytes blocks = 2;
	}

在 BitSwap 系统中，有两个非常重要的模块需求管理器（Want-Manager）和决定引擎（Decision-Engine）；前者会在节点请求 Block 时在本地返回相应的 Block 或者发出合适的请求，而后者决定如何为其他节点分配资源，当节点接收到包含 `Wantlist` 的消息时，消息会被转发至决定引擎，引擎会根据该节点的 `Ledger` 决定如何处理请求。

>

> 想要了解跟多 BitSwap 的实现细节以及 Spec 的读者可以阅读 > [> BitSwap Spec](https://github.com/ipfs/specs/tree/master/BitSwap)>  其他内容。

IPFS 除了定义节点之间互相发送的消息之外，还引入了激励和惩罚来保证整个网络中不会有『恶意』的节点，通过 `Ledger` 来存储两个节点之间的数据来往：

	type Ledger struct {
	    owner      NodeId
	    partner    NodeId
	    bytes_sent int
	    bytes_recv int
	    timestamp  Timestamp
	}

决定引擎会通过两个节点之间的 `Ledger` 计算出一个*负债比率（debt ratio）*：
r=bytes_sentbytes_recv+1r=bytes_sentbytes_recv+1
负债比率是用来衡量节点之间信任的，它不仅能够阻止攻击者创建大量的节点、还能在节点短时间不可用时保护已有的交易关系并且在节点关系恶化之前终止交易。
IPFS 使用 `Ledger` 创建了一个具有激励和惩罚的网络，保证了网络中的大部分节点能够交换数据并且正常运行。

### [(L)](https://draveness.me/ipfs-filecoin#%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F)文件系统

DHT 和 BitSwap 允许 IPFS 构建一个用于存储和分发数据块的大型点对点系统；在这之上，IPFS 构建了一个 Merkle DAG，每一个 IPFS 对象都可能包含一组链接和当前节点中的数据：

	type IPFSLink struct {
	    Name string
	    Hash Multihash
	    Size int
	}
	type IPFSObject struct {
	    links []IPFSLink
	    data []byte
	}

我们可以使用如下的命令列出该对象下的全部链接：

	$ ipfs ls QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG
	QmZTR5bcpQD7cFgTorqxZDYaew1Wqgfbd2ud9QqGPAkK2V 1688 about
	QmYCvbfNbCwFR45HiNP45rwJgvatpiW38D961L5qAhUM5Y 200  contact
	QmY5heUM5qgRubMDD1og9fhCPA6QdkMp3QCwd4s7gJsyE7 322  help
	QmdncfsVm2h5Kqq9hPmU7oAVX2zTSVP3L869tgTbPYnsha 1728 quick-start
	QmPZ9gcCEpqKTo6aq61g2nXGUhM4iCL3ewB6LDXZCtioEB 1102 readme
	QmTumTjvcYCAvRRwQ8sDRxh8ezmrcr88YFU7iYNroGGTBZ 1027 security-notes

原始数据加上通用的链接是在 IPFS 上构造任意数据结构的基础，键值存储、传统的关系型数据库、加密区块链都可以在 IPFS 的 Merkle DAG 上进行存储和分发。

在这之上，IPFS 定义了一系列的对象构建了支持版本控制的文件系统，它与 Git 的对象模型非常类似，并且所有文件对象其实都通过 Protobuf 进行了二进制编码：

![2018-05-22-ipfs-file-object-model.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231111513.png)
IPFS 文件可以通过 `list` 和 `blob` 进行表示：

- 其中 `blob` 不包含任何的链接，只包含数据；

- 但是 `list` 却包含了一个 `blob` 和 `list` 的有序队列

- 而 `tree` 文件对象与 Git 中的 `tree` 非常相似，它表示一个从名字到哈希的文件目录；

- 最后的 `commit` 表示任意对象的快照；

![2018-05-22-ipfs-file-object-graph.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231111524.png)

在上述文件对象图中，最顶层的 `commit` 就表示历史的某一次快照，对比两次 `commit` 以及子节点构成的树就能得到两次快照之间的差别，我们可以认为 Merkle DAG 和文件对象构成了整个 IPFS 中的文件系统。

### [(L)](https://draveness.me/ipfs-filecoin#%E5%91%BD%E5%90%8D%E7%B3%BB%E7%BB%9F)命名系统

到目前为止，IPFS 技术栈已经提供了一个点对点的数据交换系统，能够在节点之间发送 DAG 对象，并且可以推送和取回不可变的对象，但是可变的命名系统也是网络不可缺少的一部分，我们终究需要使用同一个地址获取不同的状态，因为不能因为网站的更新而改变域名，所以 IPFS 需要提供一种『域名服务』解决这一问题。

在 IPFS 中可以使用如下的可变命名空间来解决这些问题，用户可以发布一个对象，其他节点就可以通过 ipns 加上该用户的节点地址访问到这些发布到网络中的对象：

	/ipns/XLF2ipQ4jD3UdeX5xp1KBgeHRhemUtaA8Vm/

当然，我们也可以在现有的 DNS 系统中添加 `TXT` 记录，这样就能通过域名访问 IPFS 网络中发布的文件对象了：

	ipfs.benet.ai. TXT "ipfs=XLF2ipQ4jD3UdeX5xp1KBgeHRhemUtaA8Vm"
	
	/ipns/XLF2ipQ4jD3UdeX5xp1KBgeHRhemUtaA8Vm
	/ipns/ipfs.benet.ai

在 IPFS 不仅能够使用哈希访问可变对象，也能嵌入现有的 DNS 服务中很好的运行，解决了底层服务无缝切换的问题。

## [(L)](https://draveness.me/ipfs-filecoin#%E6%BF%80%E5%8A%B1)激励

在今天，当我们讨论 IPFS 这种底层的区块链技术时，就不得不提构建在 IPFS 上的 FileCoin，它提供了一个给宿主和上传者交易的市场，通过市场可以调节存储的成本，上传者能够根据价格选择速度、冗余和成本。

### [(L)](https://draveness.me/ipfs-filecoin#%E8%8A%82%E7%82%B9)节点

大多数的区块链网络中都只具有单一类型的标准节点，但是 FileCoin 中却有两种不同的节点：*存储节点*和*检索节点*。
![2018-05-22-storage-node.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20201231111536.png)

所有人都可以成为存储节点，将自己磁盘上额外的存储空间租赁出去，FileCoin 会使用这些磁盘存储一些较小的加密文件的一部分；而检索节点则需要尽可能靠近更多的存储节点，也需要更高的带宽和更低的延迟，用户会支付最快返回文件的检索节点。

当我们想要上传文件时，需要支付一定的存储费用，存储节点会为存储文件的权利给出报价，FileCoin 会选择价格最低的存储节点保存文件；存储的文件会被加密并分割成多个部分并发送给多个节点，文件的位置会存储在全局的表中，在这之后只有拥有私钥的节点才能查询、组装并且解密上传的文件。

### [(L)](https://draveness.me/ipfs-filecoin#%E5%85%B1%E8%AF%86%E7%AE%97%E6%B3%95)共识算法

我们可以说所有的区块链应用都需要 [共识算法](https://draveness.me/consensus) 保证多个节点对某一结果达成共识，并在发生冲突时进行解决，Bitcoin 和 Ethereum 目前都使用了 Proof-of-Work 作为共识算法，而 FileCoin 使用 Proof-of-Replication(PoRep) 解决其网络内部存在的问题。

>

> We introduce Proof-of-Replication (PoRep) schemes, which allow a prover P to (a) commit to store n distinct replicas (physically independent copies) of D, and then (b) convince a verifier V that P is indeed storing each of the replicas.

>
> PoRep 允许证明者 P 提交存储 n 个 D 的不同副本，然后说服验证人 V，P 确实保存了这些副本。

在 [Proof of Replication](https://filecoin.io/proof-of-replication.pdf) 一文中能够找到更多与 PoRep、PoS(Proof-of-Storage) 等用于验证磁盘空间提供方确实存储资源的共识算法，在这里就不展开介绍了。

## [(L)](https://draveness.me/ipfs-filecoin#%E6%80%BB%E7%BB%93)总结

IPFS 是一个非常有意思的区块链底层技术，它在兼容现有互联网协议的基础上，实现了点对点的文件存储系统并且为大数据存储提出了方案，作者尝试了一下 IPFS 的官方客户端 [go-ipfs](https://github.com/ipfs/go-ipfs) 也确实比较好用，但是目前也是在项目的早期阶段，很多模块和功能还没有定型，而基于 IPFS 发布的 FileCoin 也没有要发布的确切日志 [Proof of Replication](https://filecoin.io/proof-of-replication.pdf) 这篇白皮书还被标记为 WIP(Work In Process)，有一些部分也没有完成，所以等待这门技术的成熟也确实需要比较长的一段时间。

## [(L)](https://draveness.me/ipfs-filecoin#%E7%9B%B8%E5%85%B3%E6%96%87%E7%AB%A0)相关文章

- 聊聊区块链

    - [分布式文件系统 IPFS 与 FileCoin](https://draveness.me/ipfs-filecoin)

    - [物联网与『高效的』IOTA](https://draveness.me/iota-tangle)

    - [去中心化支付系统 Stellar](https://draveness.me/stellar)

## [(L)](https://draveness.me/ipfs-filecoin#reference)Reference

- [分布式一致性与共识算法](https://draveness.me/consensus)

- [IPFS：替代HTTP的分布式网络协议](http://www.infoq.com/cn/articles/ipfs)

- [S/Kademlia: A Practicable Approach Towards Secure Key-Based Routing](http://www.spovnet.de/files/publications/SKademlia2007.pdf)

- [Sloppy hashing and self-organizing clusters](https://www.coralcdn.org/docs/coral-iptps03.pdf)

- [Kademlia: A Peer-to-Peer Information System Based on the XOR Metric](https://pdos.csail.mit.edu/~petar/papers/maymounkov-kademlia-lncs.pdf)

- [How does Resolution and Routing work with IPFS?](https://github.com/ipfs/faq/issues/48)

- [BitSwap Spec](https://github.com/ipfs/specs/tree/master/BitSwap)

- [What is FileCoin? Beginner’s Guide to the Largest-Ever ICO](https://coincentral.com/FileCoin-beginners-guide-largest-ever-ico/)

- [Proof of Replication](https://filecoin.io/proof-of-replication.pdf)

- [go-ipfs](https://github.com/ipfs/go-ipfs)

### 关于图片和转载

 [![88x31.png](../_resources/229daa2bfc2444f20a57a2deabf6522d.png)](http://creativecommons.org/licenses/by/4.0/)

本作品采用[知识共享署名 4.0 国际许可协议](http://creativecommons.org/licenses/by/4.0/)进行许可。
转载时请注明原文链接，图片在使用时请保留图片中的全部内容，可适当缩放并在引用处附上图片所在的文章链接，图片使用 Sketch 进行绘制。

### 微信公众号

 ![20181227-wechat-account-qrcode.png](../_resources/1e2c4ecbdb7c7556d1ecb6aec0ea02e0.jpg)

### 关于评论和留言

如果对本文 [分布式文件系统 IPFS 与 FileCoin](https://draveness.me/ipfs-filecoin) 的内容有疑问，请在下面的评论系统中留言，谢谢。

>

> 原文链接：> [> 分布式文件系统 IPFS 与 FileCoin · 面向信仰编程](https://draveness.me/ipfs-filecoin)

>
> Follow: > [> Draveness · GitHub](https://github.com/Draveness)
>

 [(L)](https://github.com/draveness)

#### [Draveness](https://github.com/draveness)

Go / Rails / Rust

  Beijing, China  [draveness.me](https://draveness.me/)

#### Share this post

 [](http://twitter.com/share?text=%E5%88%86%E5%B8%83%E5%BC%8F%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F%20IPFS%20%E4%B8%8E%20FileCoin&url=https://draveness.meipfs-filecoin)  [](https://www.facebook.com/sharer/sharer.php?u=https://draveness.meipfs-filecoin)  [](https://plus.google.com/share?url=https://draveness.meipfs-filecoin)

 [6](https://github.com/draveness/blog-comments/issues/108) 条评论

未登录用户![](data:image/svg+xml,%3csvg viewBox='0 0 1024 1024' xmlns='http://www.w3.org/2000/svg' p-id='1619' data-evernote-id='168' class='js-evernote-checked'%3e%3cpath d='M511.872 676.8c-0.003 0-0.006 0-0.008 0-9.137 0-17.379-3.829-23.21-9.97l-251.277-265.614c-5.415-5.72-8.743-13.464-8.744-21.984 0-17.678 14.33-32.008 32.008-32.008 9.157 0 17.416 3.845 23.25 10.009l228.045 241.103 228.224-241.088c5.855-6.165 14.113-10.001 23.266-10.001 8.516 0 16.256 3.32 21.998 8.736 12.784 12.145 13.36 32.434 1.264 45.233l-251.52 265.6c-5.844 6.155-14.086 9.984-23.223 9.984-0.025 0-0.051 0-0.076 0z' p-id='1620' data-evernote-id='576' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

[![](data:image/svg+xml,%3csvg viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' data-evernote-id='169' class='js-evernote-checked'%3e %3cpath d='M64 524C64 719.602 189.356 885.926 364.113 947.017 387.65799 953 384 936.115 384 924.767L384 847.107C248.118 863.007 242.674 773.052 233.5 758.001 215 726.501 171.5 718.501 184.5 703.501 215.5 687.501 247 707.501 283.5 761.501 309.956 800.642 361.366 794.075 387.658 787.497 393.403 763.997 405.637 743.042 422.353 726.638 281.774 701.609 223 615.67 223 513.5 223 464.053 239.322 418.406 271.465 381.627 251.142 320.928 273.421 269.19 276.337 261.415 334.458 256.131 394.888 302.993 399.549 306.685 432.663 297.835 470.341 293 512.5 293 554.924 293 592.81 297.896 626.075 306.853 637.426 298.219 693.46 258.054 747.5 262.966 750.382 270.652 772.185 321.292 753.058 381.083 785.516 417.956 802 463.809 802 513.5 802 615.874 742.99 701.953 601.803 726.786 625.381 750.003 640 782.295 640 818.008L640 930.653C640.752 939.626 640 948.664978 655.086 948.665 832.344 888.962 960 721.389 960 524 960 276.576 759.424 76 512 76 264.577 76 64 276.576 64 524Z' data-evernote-id='580' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)]()

 [![](data:image/svg+xml,%3csvg viewBox='0 0 1024 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' data-evernote-id='170' class='js-evernote-checked'%3e %3cpath d='M512 366.949535c-16.065554 0-29.982212 13.405016-29.982212 29.879884l0 359.070251c0 16.167882 13.405016 29.879884 29.982212 29.879884 15.963226 0 29.879884-13.405016 29.879884-29.879884L541.879884 396.829419C541.879884 380.763865 528.474868 366.949535 512 366.949535L512 366.949535z' p-id='3083' data-evernote-id='585' class='js-evernote-checked'%3e%3c/path%3e %3cpath d='M482.017788 287.645048c0-7.776956 3.274508-15.553912 8.80024-21.181973 5.525732-5.525732 13.302688-8.80024 21.181973-8.80024 7.776956 0 15.553912 3.274508 21.079644 8.80024 5.525732 5.62806 8.80024 13.405016 8.80024 21.181973 0 7.776956-3.274508 15.656241-8.80024 21.181973-5.525732 5.525732-13.405016 8.697911-21.079644 8.697911-7.879285 0-15.656241-3.274508-21.181973-8.697911C485.292295 303.301289 482.017788 295.524333 482.017788 287.645048L482.017788 287.645048z' p-id='3084' data-evernote-id='586' class='js-evernote-checked'%3e%3c/path%3e %3cpath d='M512 946.844409c-239.8577 0-434.895573-195.037873-434.895573-434.895573 0-239.8577 195.037873-434.895573 434.895573-434.895573 239.755371 0 434.895573 195.037873 434.895573 434.895573C946.895573 751.806535 751.755371 946.844409 512 946.844409zM512 126.17088c-212.740682 0-385.880284 173.037274-385.880284 385.777955 0 212.740682 173.037274 385.777955 385.880284 385.777955 212.740682 0 385.777955-173.037274 385.777955-385.777955C897.777955 299.208154 724.740682 126.17088 512 126.17088z' p-id='3085' data-evernote-id='587' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)支持 Markdown 语法](https://guides.github.com/features/mastering-markdown/)

![6550752](../_resources/9e7fb55fa896d08d09a703274e6d1456.jpg)

[daijiale](https://github.com/daijiale)发表于9 个月前[![](data:image/svg+xml,%3csvg viewBox='0 0 1332 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' data-evernote-id='171' class='js-evernote-checked'%3e %3cpath d='M529.066665 273.066666 529.066665 0 51.2 477.866666 529.066665 955.733335 529.066665 675.84C870.4 675.84 1109.333335 785.066665 1280 1024 1211.733335 682.666665 1006.933335 341.333334 529.066665 273.066666' data-evernote-id='601' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)]()

归纳得很系统
![10718837](../_resources/bebfcd6daf4be1ffff341324f67d9efe.png)

[TimorYang](https://github.com/TimorYang)发表于4 个月前[![](data:image/svg+xml,%3csvg viewBox='0 0 1332 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' data-evernote-id='172' class='js-evernote-checked'%3e %3cpath d='M529.066665 273.066666 529.066665 0 51.2 477.866666 529.066665 955.733335 529.066665 675.84C870.4 675.84 1109.333335 785.066665 1280 1024 1211.733335 682.666665 1006.933335 341.333334 529.066665 273.066666' data-evernote-id='610' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)]()

利用这套系统可以解决高质量(蓝光)影片的存储，以前是想看这部影片，必须要下载到本地观看，那就意味着看过这部影片的用户们本地都存储着这部影片，这其实是对存储资源的浪费，利用IPFS，其实可以将影片分成若干个小块存储在各个节点中，当任一用户需要观看这部电影的时候，只需要发起请求，就可以从各个节点中获取到该影片，这样理论上，一部影片只需要存在一份，就可以供所有的节点用户观看。

![22948198](../_resources/dc8e6f9c066688be0543a76e7311343d.jpg)

[zjdznl](https://github.com/zjdznl)发表于4 个月前[![](data:image/svg+xml,%3csvg viewBox='0 0 1332 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' data-evernote-id='173' class='js-evernote-checked'%3e %3cpath d='M529.066665 273.066666 529.066665 0 51.2 477.866666 529.066665 955.733335 529.066665 675.84C870.4 675.84 1109.333335 785.066665 1280 1024 1211.733335 682.666665 1006.933335 341.333334 529.066665 273.066666' data-evernote-id='619' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)]()

感谢楼主的总结！看了一下，主要内容来自于[这篇paper](https://github.com/ipfs/ipfs/blob/master/papers/ipfs-cap2pfs/ipfs-p2p-file-system.pdf?raw=true)

![6585440](../_resources/be861c9d7da54d2467a1e2af77bb43cc.jpg)

[Redwinam](https://github.com/Redwinam)发表于4 个月前[![](data:image/svg+xml,%3csvg viewBox='0 0 1332 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' data-evernote-id='174' class='js-evernote-checked'%3e %3cpath d='M529.066665 273.066666 529.066665 0 51.2 477.866666 529.066665 955.733335 529.066665 675.84C870.4 675.84 1109.333335 785.066665 1280 1024 1211.733335 682.666665 1006.933335 341.333334 529.066665 273.066666' data-evernote-id='628' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)]()

楼主看好其他的分布式存储项目，例如storj v3吗？https://ipfsdrop.com/tech/xianduweikuaistorj-v3-baipishufabu/

![6493255](../_resources/0cc6dc0042a390803cf503e5472ecdd8.png)

[draveness](https://github.com/draveness)发表于4 个月前[![](data:image/svg+xml,%3csvg viewBox='0 0 1332 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' data-evernote-id='175' class='js-evernote-checked'%3e %3cpath d='M529.066665 273.066666 529.066665 0 51.2 477.866666 529.066665 955.733335 529.066665 675.84C870.4 675.84 1109.333335 785.066665 1280 1024 1211.733335 682.666665 1006.933335 341.333334 529.066665 273.066666' data-evernote-id='637' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)]()

> [> @Redwinam](https://github.com/Redwinam)

> 楼主看好其他的分布式存储项目，例如storj v3吗？> [https://ipfsdrop.com/tech/xianduweikuaistorj-v3-baipishufabu/

不看好。。
![9456735](../_resources/6b91a17f77e33fd7828127557f403119.png)

[ace1573](https://github.com/ace1573)发表于22 天前[![](data:image/svg+xml,%3csvg viewBox='0 0 1332 1024' version='1.1' xmlns='http://www.w3.org/2000/svg' data-evernote-id='176' class='js-evernote-checked'%3e %3cpath d='M529.066665 273.066666 529.066665 0 51.2 477.866666 529.066665 955.733335 529.066665 675.84C870.4 675.84 1109.333335 785.066665 1280 1024 1211.733335 682.666665 1006.933335 341.333334 529.066665 273.066666' data-evernote-id='646' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)]()

> [> @TimorYang](https://github.com/TimorYang)

> 利用这套系统可以解决高质量(蓝光)影片的存储，以前是想看这部影片，必须要下载到本地观看，那就意味着看过这部影片的用户们本地都存储着这部影片，这其实是对存储资源的浪费，利用IPFS，其实可以将影片分成若干个小块存储在各个节点中，当任一用户需要观看这部电影的时候，只需要发起请求，就可以从各个节点中获取到该影片，这样理论上，一部影片只需要存在一份，就可以供所有的节点用户观看。

需要做冗余和扩散机制，因为分布式系统下节点是不稳定的。