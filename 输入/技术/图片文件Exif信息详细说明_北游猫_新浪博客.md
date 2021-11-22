图片文件Exif信息详细说明_北游猫_新浪博客

## 图片文件Exif信息详细说明

(2014-08-09 14:52:51)


|     |     |
| --- | --- |
| 标签：<br>### it<br>### 软件<br>### 程序<br>### 说明文档 | 分类：[软件开发](http://blog.sina.com.cn/s/articlelist_1695699430_3_1.html) |

当前，几乎新型的数码相机都使用Exif文件格式来存储图像. 它的规格是由 [JEIDA](http://www.jeida.or.jp/) 来制定的, 但是在互联网上还没有开放的文档可供浏览. 因此我根据从互联网上所能得到一些开放资料做成了这份Exif格式的描述文档.

注: 现在我们能得到官方的文档 Exif2.1 ，它来自 PIMA 的web站点.

ISO 正致力于建立 DCF (Design rule for Camera File system/相机文件系统设计规则) 规格. 所有的数码相机的制造商正准备遵循这份规则并且已经在他们的最新的数字相机上使用了. DCF规格为数字相机定义了完整的文件系统; 如，目录结构, 文件命名方法, 字符集和文件格式等等. 这里的文件格式就是基于 Exif2.1 规格制定的.

rev. 1.4 Feb.03,2001
rev. 1.3 Sep.09,2000
rev. 1.2 Jul.19,2000
rev. 1.1 Dec.19,1999
rev. 1.0 May.28,1999

* * *

## 参考材料

[Exif文件格式](http://www.itojun.org/diary/199610.IWOOOS/exif.html)itojun著 (日文版文档)

[Exif文件格式](http://www.yk.rim.or.jp/~mamo/Computer/DS-7/exif.html)Mamoru Ohno著 (日文版文档)

[TIFF6.0 规格说明](http://partners.adobe.com/asn/developer/PDFS/TN/TIFF6.pdf) Adobe公司著

[TIFF/EP 规格说明](http://www.pima.net/standards/iso/standards/documents/N4378.pdf) ISO TC42 WG18著

[exifdump](http://topo.math.u-psud.fr/~bousch/exifdump.py) 程序由 Thierry Boush完成制作

[DCF 规格说明](http://www.pima.net/standards/iso/tc42/wg18/ISO12234_all/N4522_CD12234-3_Item189-3.PDF) ISO TC42 WG18著

[Exif2.1 规格说明](http://www.pima.net/standards/it10/PIMA15740/exif.htm)  [JEIDA](http://www.jeida.or.jp/)著

* * *

- [什么是Exif?](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#AboutExif)
- [JPEG格式和标记](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#JpegMarker)
- [Exif使用的标记](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#ExifMarker)
- [Exif数据结构](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#ExifData)
    - [TIFF 头](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#TiffHeader)
    - [IFD : 图像文件目录(Image file directory)](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#IFD)
    - [数据格式](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#DataForm)
    - [IFD数据结构](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#IFDRead)
    - [缩略图](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#ExifThumbs)
        - [JPEG 格式缩略图](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#JPEGThumbs)
        - [TIFF 格式缩略图](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#TIFFThumbs)
- [Exif/TIFF使用的标签数](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#ExifTags)
    - [IFD0(主图像IFD) 区域](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#IFD0Tags)
    - [Exif 子IFD区域](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#ExifIFDTags)
    - [IFD1(缩略图IFD) 区域](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#IFD1Tags)
    - [杂项标签](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#MiscTags)
- [附录1: Olympus数字相机的MakerNote](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#APP1)
- [附录2: Nikon数字相机的MakerNote](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#APP2)
- [附录3: Casio数字相机的MakerNote](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#APP3)
- [附录4: Fujifilm数字相机的MakerNote](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#APP4)
- [附录5: Canon数字相机的MakerNote](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#APP5)
- [修订履历](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#HIST)
- [鸣谢](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#THANKS)

* * *

## [什么是 Exif?]()

基本上, Exif文件格式与JPEG 文件格式相同. Exif按照JPEG的规格在JPEG中插入一些 图像/数字相机 的信息数据以及缩略图像. 于是你能通过与JPEG兼容的互联网浏览器/图片浏览器/图像处理等一些软件 来查看Exif格式的图像文件. 就跟浏览通常的JPEG图像文件一样.

## [JPEG格式和标记]()

每一个JPEG文件的内容都开始于一个二进制的值 '0xFFD8', 并结束与二进制值'0xFFD9'. 在JPEG的数据 中有好几种类似于二进制 0xFFXX 的数据, 它们都统称作 **"标记"**, 并且它们代表了一段JPEG的 信息数据. 0xFFD8 的意思是 **SOI**图像起始(Start of image), 0xFFD9 则表示 **EOI**图像结束 (End of image). 这两个特殊的标记的后面都不跟随数据, 而其他的标记在后面则会附带数据. 标记的基本 格式如下.

**0xFF+标记号(1个字节)+数据大小描述符(2个字节)+数据内容(n个字节)**

**数据大小描述符**(2个字节) 是 "Motorola" 的字节顺序, 数据的低位被存放在高地址，也就是 BigEndian. 请注意上面中的 "数据内容" 中包含他前面的数据大小描述符, 如果下面的是一个标记的话;

**FF C1 00 0C**

它就表示这个标记(0xFFC1) 的数据占 0x000C(等于12)个字节. 但是这个数据大小'12' 包含了 "数据大小" 描述符, 也就是在0x000C后面它只允许带有10 个字节大小的数据.

在JPEG 格式中, 最开始先是用一些标记来描述数据, 然后是放置 **SOS**数据流的起始(Start of stream) 标记. 在SOS标记的后面才是, 存放JPEG图像的数据流并终结于EOI标记.

|     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- |
| SOI 标记 | 标记 XX 的大小=SSSS | 标记 YY 的大小=TTTT | SOS 标记 的大小=UUUU | 图像数据流 | EOI 标记 |
| FFD8 | FFXX | SSSS | DDDD...... | FFYY | TTTT | DDDD...... | FFDA | UUUU | DDDD.... | I I I I.... | FFD9 |

## [Exif使用的标记]()

0xFFE0~0xFFEF之间的标记被叫做 **"应用标记"**, 它们在JPEG图像解码中不是必须存在的. 它们被使用于用户的应用程序之中. 例如, 老款的olympus/canon/casio/agfa 数字相机使用 JFIF(JPEG文件交换格式/JPEG File Interchange Format)来存储图像. JFIF 使用 APP0(0xFFE0) 标记来插入数字相机的配置信息数据和缩略图.

Exif也使用应用标记来插入数据, 但是Exif 使用**APP1(0xFFE1)**标记来避免与JFIF格式的 冲突. 且每一个 Exif 文件格式都开始于它, 如;

|     |     |     |     |
| --- | --- | --- | --- |
| SOI 标记 | APP1 标记 | APP1 数据 | Other 标记 |
| FFD8 | FFE1 | SSSS 457869660000 TTTT...... | FFXX SSSS DDDD...... |

该图像文件从SOI(0xFFD8) 标记开始, 因此它是一个 JPEG 文件. 后面马上跟着 APP1 标记. 而它的所有 Exif数据都被存储在 APP1 数据域中. 上面的 "SSSS" 这部分表示 APP1 数据域 (Exif data area)的大小. 请注意这里的大小 "SSSS" 包含描述符本身的大小.

在 "SSSS"后面, 是 APP1 的数据. 其中第一个部分是一个特殊的数据，它用来标识是否是 Exif, 其值是ASCII 字符 "Exif" 和 两个0x00字节 的组合字符串.

在 APP1 标记域的后面是, 跟随着其他的 JPEG 标记.

## [Exif数据结构]()

Exif的数据结构 (APP1)大致如下面那样. 这是"Intel"字节序的情况, 并且它包含了JPEG 格式的 缩略图. 就像上面描述的那样, Exif 数据开始于ASCII字符 "Exif" 和2个字节的0x00, 后面才是 Exif的数据. Exif 使用 TIFF 格式来存储数据. 想获取TIFF的更多的细节的话, 请参考 ["TIFF6.0规格说明(TIFF6.0 specification)"](http://partners.adobe.com/asn/developer/PDFS/TN/TIFF6.pdf).

|     |     |
| --- | --- |
| FFE1 | APP1 标记 |
| SSSS | APP1 数据 | APP1 数据大小 |
| 45786966 0000 | Exif 头 |
| 49492A00 08000000 | TIFF 头 |
| XXXX. . . . | IFD0 (主图像) | 目录  |
| LLLLLLLL | 连接到 IFD1 |
| XXXX. . . . | IFD0的数据域 |
| XXXX. . . . |     | Exif 子IFD | 目录  |
| 00000000 | 连接结束 |
| XXXX. . . . | Exif 子IFD的数据域 |
| XXXX. . . . |     | Interoperability IFD | Directory |
| 00000000 | 连接结束 |
| XXXX. . . . | Interoperability IFD的数据域 |
| XXXX. . . . | Makernote IFD | Directory |
| 00000000 | 连接结束 |
| XXXX. . . . | Makernote IFD的数据域 |
| XXXX. . . . | IFD1(缩略图像) | 目录  |
| 00000000 | 连接结束 |
| XXXX. . . . | IFD1的数据域 |
| FFD8XXXX. . . XXXXFFD9 | 缩略图像 |

### [TIFF 头的结构]()

TIFF格式中前8个字节是 TIFF 头. 其中最开始的前2个字节定义了 TIFF 数据的字节序. 如果这个值是 0x4949="I I"的话, 就表示按照 "Intel" 的字节序(Little Endian) 来排列数据. 如果是 0x4d4d="MM", 则说明按照 "Motorola" 的字节序(Big Endian)来排列数据. 例如, 这个值是'305,419,896' (注意：16进制值为0x12345678). 在 Motorola 的 字节序中, 数据存储时的排列顺序为 0x12,0x34,0x56,0x78. 而用 Intel 的字节序的话, 它就是按照 0x78,0x56,0x34,0x12 来排序数据. 几乎所有的数字相机都是使用 Intel 的字节序. 不过 Ricoh 使用的是 Motorola 的. Sony 使用的是 Intel 字节序(除了 D700). Kodak 的DC200/210/240 使用的是 Motorola 字节序, 但是 DC220/260 使用的是 Intel的, 尽管它们都是使用在 PowerPC的平台上! 因此当我们需要使用 Exif 数据的值的时候, 我们必须每次都要检查它的字节序. 尽管 JPEG 数据仅仅是使用 Motorola 字节序, 但 Exif 却是允许这两种字节序存在的. 我不明白 Exif 为什么不把字节序修订成 Motorola的.

随后的两个字节是一个2字节长度的固定值 0x002A. 如果数据使用 Intel 字节序, 则这两个 字节的数据排列为 "0x2a,0x00". 如果是 Motorola 的, 则是 "0x00,0x2a". TIFF头的最后的 4个字节是到第一个 IFD(图像文件目录/Image File Directory, 将在下一节中描述)的偏移量. 这个偏移量是指从TIFF头("II" 或者 "MM")开始, 包含自己偏移量值的本身, 到下一个IFD为止的 长度的字节数. 通常地第一个 IFD 是紧挨着 TIFF 头出现的, 因此这个偏移量的值是 '0x00000008'.

|     |     |     |
| --- | --- | --- |
| 字节序 | 标签标注 | 到第一个IFD的偏移量 |
| "I I" or "MM" | 0x002a | 0x00000008 |

### [IFD : 图像文件目录]()

紧挨着 TIFF 头, 就是第一个 IFD:图像文件目录(Image File Directory). 它包含了图像 信息的数据. 在下面的表格中, 前两个字节('EEEE') 表示在IFD中有多少个目录项(directory entry) . 它后面存放就是目录项(每个项目大小为12字节) . 在最后一个目录项之后, 有 一个4个字节大小的数据(表格中'LLLLLLLL' ), 它意味着到下一个IFD的偏移量. 如果这个 值是'0x00000000', 则表示它是最后一个IFD 并且不在跟任何的 IFD 相连接.

|     |     |
| --- | --- |
| EEEE | 目录项的号码 |
| TTTT | ffff | NNNNNNNN | DDDDDDDD | 项目 0 |
| TTTT | ffff | NNNNNNNN | DDDDDDDD | 项目 1 |
| . . . . . . . . . | . . . . . . |
| TTTT | ffff | NNNNNNNN | DDDDDDDD | 项目 EEEE-1 |
| LLLLLLLL | 到下一个IFD的偏移量 |

上表中的'TTTT'(2个字节) 是一个标签的号码, 代表数据的种类. 'ffff'(2个字节)表示 数据的格式, 'NNNNNNNN'(4个字节)表示组件的数目. 'DDDDDDDD'(4个字节) 则是数据的 值或者到数据值的偏移量.

### [数据格式]()

数据格式 (上面表格中的'ffff') 的定义如下表示. "rational" 的意思是说明数据的 内容是一个分数, 它含有2个有符号/无符号的长整形(signed/unsigned long integer)值, 并且第一个值表示的是分子, 第二个值则是, 分母.

|     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- |
| 数据的值 | 1   | 2   | 3   | 4   | 5   | 6   |
| 格式  | unsigned byte | ascii strings | unsigned short | unsigned long | unsigned rational | signed byte |
| 组件的大小(字节数) | 1   | 1   | 2   | 4   | 8   | 1   |
|     |
| 数据的值 | 7   | 8   | 9   | 10  | 11  | 12  |
| 格式  | undefined | signed short | signed long | signed rational | single float | double float |
| 组件的大小(字节数) | 1   | 2   | 4   | 8   | 4   | 8   |

通过多个存储在'NNNNNNNN'数据区的'组件的大小(字节数)'你能得到所有数据的字节长度. 如果数据的长度小于4个字节, 则'DDDDDDDD' 就表示的是标签的值. 如果长度超过4字节, 则'DDDDDDDD' 里存放的就是所要存储数据的偏移量地址.

### [IFD数据结构]()

在Exif格式中, 第一个IFD 是IFD0(主图像IFD), 然后它连接到IFD1(缩略图IFD) 并且IFD 连接在此结束. 但是 IFD0/IFD1 不包含任何的数字相机的信息例如快门速度, 焦距等. IFD0 总是包含一个特殊的标签**Exif偏移量(0x8769)**, 它表示到 **Exif子IFD**的偏移量. Exif子IFD 也是一个IFD 格式化的数据, 它包含了数字相机的信息.

在扩展Exif格式(Exif2.1/DCF)中, Exif子IFD还包含了特殊的标签 **Exif Interoperability Offset (0xa005)**. 这个偏移量也指向Interoperability IFD. 根据 DCF 规格, 这个标签是必须的并且子IFD (主图像 IFD) 和 IFD1 (缩略图 IFD) 中可能也会包含Interoperability IFD. 通常, 仅仅主图像仅仅有这个标签.

另外一些数字相机也为Makernote(制造商注释)使用 IFD 数据格式; 这是生产商特定的 魔数(magic number)区域. 判断makernote 是否是IFD 格式是非常困难的, 必须仔细的 编程. 关于Makernote的信息请参考附录.

0000: 49 49 2A 00 08 00 00 00-02 00 1A 01 05 00 01 00
0010: 00 00 26 00 00 00 69 87-04 00 01 00 00 00 11 02
0020: 00 00 40 00 00 00 48 00-00 00 01 00 00 00
上面的是TIFF数据的开头部分, 对它的解读如下;

- 前两个字节是 "I I", 所以字节序是 'Intel'.
- 在地址0x0004~0x0007处存放的值是 0x08000000, 因此IFD0 从地址 '0x0008'开始
- 在地址0x0008~0x0009处存放的值是 0x0200, 则表示IFD0有 '2' 个目录项.
- 在地址0x000a~0x000b处存放的值是 0x1A01, 它意味着这是一个 XResolution(0x011A) 标签, 表示这是图像的水平分辨率.
- 地址0x000c~0x000d处存放的值为 0x0500, 说明数据的格式是一个 unsigned rational(0x0005).
- 地址0x000e~0x0011处存放的值是 0x01000000, 说明组件的数据只有 '1'个. Unsigned rational的数据大小是8字节(组件的大小), 因此数据的总长度是 1x8=8字节.
- 总数居长度比4字节大了, 因此它后面的4个字节里面存放的是一个指向实际数据的偏移量地址.
- 地址0x0012~0x0015处存放的是 0x26000000, 表示XResolution(水平分辨率) 数据的存储地址是0x0026
- 地址0x0026~0x0029处存放的数据是 0x48000000, 说明分子的值为 72, 而地址0x002a~0x002d 处存放的是0x0100000000, 说明分母为 '1'. 因此XResoultion 的值是 72/1.
- 地址0x0016~0x0017处存放的数据为0x6987, 表示下一个标签是 ExifOffset(0x8769). 这就是 指向 **Exif子IFD**的偏移量
- 而它的数据格式是 0x0004, 即是一个无符号的长整形(unsigned long integer).
- 这个标签只有一个组件. 无符号长整形的数据大小是4字节, 因此总数据长度为4字节.
- 总数据长度是 4字节, 则说明下一个4字节的数据中存放的是Exif子IFD的偏移量.
- 地址0x001e~0x0021处存放的是 0x11020000, 则说明Exif子IFD的开始地址是 '0x0211'.
- 这是最后一个目录项, 接下来的4个字节存放的是下一个IFD的偏移地址.
- 地址0x0022~0x0025处存放的是 0x40000000, 就可以知道下一个IFD的开始地址为 '0x0040'

### [缩略图]()

Exif格式中包含缩略图像(除了Ricoh RDC-300Z). 通常它被放到IFD1的后面. 缩略图有 3 种格式; JPEG 格式(JPEG 使用YCbCr), RGB TIFF 格式, YCbCr TIFF 格式. 在Exif2.1之后推荐使用JPEG 格式和160x120像素的尺寸. 根据 DCF 规格, 缩略图像**必须** 使用JPEG 格式以及图像的尺寸 固定为160x120 像素.

#### [JPEG格式的缩略图]()

IFD1中的标签**Compression(0x0103)**如果是 '6', 则缩略图就是JPEG格式. 几乎所有的 Exif图像中缩略图都使用JPEG 格式. 在这种情况下, 你能从IFD1的**JpegIFOffset(0x0201)** 标签中得到缩略图的偏移量, 从标签**JpegIFByteCount(0x0202)**中得到缩略图的大小. 数据格式则是普通的 JPEG 格式, 也就是从0xFFD8处开始在0xFFD9处结束.

#### [TIFF格式的缩略图]()

IFD1的标签**Compression(0x0103)**如果是 '1', 则缩略图的格式就没有经过压缩的 (就是TIFF 图像). 缩略图数据的开始点是标签 **StripOffset(0x0111)** , 缩略图的尺寸 就是标签 **StripByteCounts(0x0117)** 之和.

如果缩略图使用非压缩格式并且IFD1中的标签**PhotometricInterpretation(0x0106)** 是 '2', 则缩略图使用了 RGB 格式. 在这种情况下, 你只要简单的把数据拷贝到计算机的RGB格式 中就能看到缩略图了(如 BMP 格式, 或者拷贝到 VRAM 目录下). Kodak DC-210/220/260 就使用 这个格式. 注意TIFF中存储的像素数据是'RGB' 顺序的, 而 BMP 里的存储顺序则是 'BGR' .

如果这个标签的值是 '6', 缩略图使用 YCbCr 格式. 如果你想要看到缩略图的话, 你必须把它 转换成 RGB 格式的. Ricoh RDC4200/4300, Fuji DS-7/300 和 DX-5/7/9 使用的是这种格式 (较新的 RDC5000/MX-X00 系列使用的是 JPEG). 在下一节中主要描述的就是Fuji DS相机的缩略图 的图像转换. 想要了解更多的信息, 请参考 [TIFF6.0 规格说明](http://partners.adobe.com/asn/developer/PDFS/TN/TIFF6.pdf).

在DX-5/7/9的场合, YCbCrSubsampling(0x0212) 的值是 '2,1', PlanarConfiguration(0x011c) 的 值是 '1'. 因此这种图像的数据排列是下面的那样.

Y(0,0),Y(1,0),Cb(0,0),Cr(0,0), Y(2,0),Y(3,0),Cb(2,0),Cr(3.0), Y(4,0),Y(5,0),Cb(4,0),Cr(4,0). . . .

括 号中的数字代表的是像素坐标. DX 系列中000YCbCrCoefficients(0x0211) 的值是 '0.299/0.587/0.114', ReferenceBlackWhite(0x0214) 的值是 '0,255,128,255,128,255'. 于是把 Y/Cb/Cr 转换成 RGB 就是;

B(0,0)=(Cb-128)*(2-0.114*2)+Y(0,0)
R(0,0)=(Cr-128)*(2-0.299*2)+Y(0,0)
G(0,0)=(Y(0,0)-0.114*B(0,0)-0.299*R(0,0))/0.587

水 平 subsampling 的值是 '2', 因此你能使用 Y(1,0)和 Cr(0,0)/Cb(0,0)计算出B(1,0)/R(1,0)/G(1,0). 根据ImageWidth(0x0100) 和 ImageLength(0x0101)的值可以重复这些转换.

## [Exif/TIFF使用的标签数]()

下面显示了 Exif/TIFF 使用的标签数. 如果这个标签组件数目的上限, CompoNo 一栏就代表这一数值. 如果这个数值没有, 则说明这儿没有上限值.
**IFD0 (主图像)使用的标签**
标签号
标签名
格式
组件数
描述
0x010e
ImageDescription
ascii string

用来描述图像. 双字节的字符码不能使用, 如 中文/韩文/日文.
0x010f
Make
ascii string

表示数字相机的制造商. 在 Exif 标准中, 这个标签是可选的, 但是在DCF中它是必需的.
0x0110
Model
ascii string

表示数字相机的模块代码. 在 Exif 标准中, 这个标签是可选的, 但在DCF中它也是必需的.
0x0112
Orientation
unsigned short
1

|     |     |     |
| --- | --- | --- |
| Value | 0th Row | 0th Column |
| 1   | top | left side |
| 2   | top | right side |
| 3   | bottom | right side |
| 4   | bottom | left side |
| 5   | left side | top |
| 6   | right side | top |
| 7   | right side | bottom |
| 8   | left side | bottom |

当拍照时, 相机相对于场景的方向. 在右边表示的是'0th row' 以及 '0th column' 在视觉位置上的关系.
0x011a
XResolution
unsigned rational
1
图像的 显示/打印 分辨率. 缺省值是 1/72英寸, 但是它没有意义因为个人PC在 显示/打印 图像的时候不使用这个值.
0x011b
YResolution
unsigned rational
1
0x0128
ResolutionUnit
unsigned short
1

XResolution(0x011a)/YResolution(0x011b)的单位. '1' 表示没有单位, '2' 意味着英寸, '3' 表示厘米. 缺省值是 '2'(英寸).

0x0131
Software
ascii string

显示固件的版本号(数字相机的内部控制软件).
0x0132
DateTime
ascii string
20

图像最后一次被修改时的日期/时间. 日期的格式是 "YYYY:MM:DD HH:MM:SS"+0x00, 一共 20个字节. 如果没有设置时钟或者数字相机没有时钟, 则这个域是用空格来填充. 通常, 它和DateTimeOriginal(0x9003)具有相同的值

0x013e
WhitePoint
unsigned rational
2

定义图像白点(white point/白点：在彩色分色、照相或摄影时作为色彩平衡测量用途的参考点) 的色度(chromaticity). 如果图像是用CIE标准照度 D65(著名的是 '光线/daylight'的国际标准), 这个值是 '3127/10000,3290/10000'.

0x013f
PrimaryChromaticities
unsigned rational
6

定义图像的原始色度. 如果图像使用 CCIR 推荐 709原始色度, 则这个值是 '640/1000,330/1000,300/1000,600/1000,150/1000,0/1000'.

0x0211
YCbCrCoefficients
unsigned rational
3
当图像的格式是 YCbCr(JPEG的格式), 这个值表示转换成 RGB格式的一个常量. 通常, 这个值是'0.299/0.587/0.114'.
0x0213
YCbCrPositioning
unsigned short
1

当图像的格式是 YCbCr 并且使用 '子采样/Subsampling'(色度数据的剪切值, 所有的数字相机都使用), 定义了subsampling 像素阵列的色度采样点. '1'表示像素阵列的中心, '2' 表示基准点.

0x0214
ReferenceBlackWhite
unsigned rational
6

表示黑点(black point)/白点 的参考值. 在YCbCr 格式中,前两个值是 Y的黑点/白点, 下两个值是 Cb, 最后两个值是 Cr. 而在 RGB 格式中, 前两个表示R的黑点/白点, 下两个是 G, 最后两个是 B.

0x8298
Copyright
ascii string

表示版权信息
0x8769
ExifOffset
unsigned long
1
Exif 子IFD的偏移量

**Exif 子IFD使用的标签**
标签号
标签名
格式
组件数
描述
0x829a
ExposureTime
unsigned rational
1
曝光时间 (快门速度的倒数). 单位是秒.
0x829d
FNumber
unsigned rational
1
拍照时的光圈F-number(F-stop).
0x8822
ExposureProgram
unsigned short
1

拍照时相机使用的曝光程序. '1' 表示手动曝光, '2' 表示正常程序曝光, '3' 表示光圈优先曝光, '4' 表示快门优先曝光, '5' 表示创意程序(慢速程序), '6' 表示动作程序(高速程序), '7'表示 肖像模式, '8' 表示风景模式.

0x8827
ISOSpeedRatings
unsigned short
2
CCD 的感光度, 等效于 Ag-Hr 胶片的速率.
0x9000
ExifVersion
undefined
4

Exif 的版本号. 用4个ASCII字符来存储. 如果图片是基于Exif V2.1的, 这个值是 "0210". 因为它不是一个用NULL(0x00)来终结的字符串，所以这里的类型是 'undefined'.

0x9003
DateTimeOriginal
ascii string
20

照片在被拍下来的日期/时间. 使用用户的软件是不能被修改这个值的. 日期的格式是 "YYYY:MM:DD HH:MM:SS"+0x00, 一共占用20个字节. 如果数字相机没有设置时钟或者 数字相机没有时钟, 这个域使用空格来填充. 在Exif标准中, 这个标签是可选的, 但是在 DCF中是必需的.

0x9004
DateTimeDigitized
ascii string
20

照片被数字化时的日期/时间. 通常, 它与DateTimeOriginal(0x9003)具有相同的值. 数据格式是 "YYYY:MM:DD HH:MM:SS"+0x00, 一共占用20个字节. 如果数字相机没有设置时钟或者 数字相机没有时钟, 这个域使用空格来填充. 在Exif标准中, 这个标签是可选的, 但是在 DCF中是必需的.

0x9101
ComponentsConfiguration
undefined

表示的是像素数据的顺序. 大多数情况下RGB格式使用 '0x04,0x05,0x06,0x00' 而YCbCr 格式使用 '0x01,0x02,0x03,0x00'. 0x00:并不存在, 其他的对应关系为 0x01:Y, 0x02:Cb, 0x03:Cr, 0x04:Red, 0x05:Green, 0x06:Bllue.

0x9102
CompressedBitsPerPixel
unsigned rational
1
JPEG (粗略的估计)的平均压缩率.
0x9201
ShutterSpeedValue
signed rational
1

用APEX表示出的快门速度. 为了转换成原始的 'Shutter Speed'; 则先要计算2的ShutterSpeedValue次幂, 然后求倒数. 例如, 如果 ShutterSpeedValue 是 '4', 快门速度则是1/(24)=1/16秒.

0x9202
ApertureValue
unsigned rational
1

拍照时镜头的光圈. 单位是 APEX. 为了转换成普通的 F-number(F-stop), 则要先计算出根号2 2 (=1.4142)的ApertureValue次幂. 例如, 如果ApertureValue 是 '5', F-number 就等于1.41425 = F5.6.

0x9203
BrightnessValue
signed rational
1

被拍摄对象的明度, 单位是 APEX. 为了从BrigtnessValue(Bv)计算出曝光量(Ev), 你必须加上 SensitivityValue(Sv).

Ev=Bv+Sv   Sv=log2(ISOSpeedRating/3.125)
ISO100:Sv=5, ISO200:Sv=6, ISO400:Sv=7, ISO125:Sv=5.32.
0x9204
ExposureBiasValue
signed rational
1
照片拍摄时的曝光补偿. 单位是APEX(EV).
0x9205
MaxApertureValue
unsigned rational
1

镜头的最大光圈值. 你可以通过计算根号2的MaxApertureValue次幂来转换成普通的光圈 F-number (跟ApertureValue:0x9202的处理过程一样).

0x9206
SubjectDistance
signed rational
1
到焦点的距离, 单位是米.
0x9207
MeteringMode
unsigned short
1

曝光的测光方法. '0' 表示未知, '1' 为平均测光, '2' 为中央重点测光, '3' 是点测光, '4' 是多点测光, '5' 是多区域测光, '6' 部分测光, '255' 则是其他.

0x9208
LightSource
unsigned short
1

光源, 实际上是表示白平衡设置. '0' 意味着未知, '1'是日光, '2'是荧光灯, '3' 白炽灯(钨丝), '10' 闪光灯, '17' 标准光A, '18' 标准光B, '19' 标准光C, '20' D55, '21' D65, '22' D75, '255' 为其他.

0x9209
Flash
unsigned short
1
'0' 表示闪光灯没有闪光, '1' 表示闪光灯闪光, '5' 表示闪光但没有检测反射光, '7' 表示闪光且检测了反射光.
0x920a
FocalLength
unsigned rational
1
拍摄照片时的镜头的焦距长度. 单位是毫米.
0x927c
MakerNote
undefined

制造商的内部数据. 一些制造商如 Olympus/Nikon/Sanyo 等在这个区域中使用IFD 格式的数据.
0x9286
UserComment
undefined

存储用户的注释. 这个标签允许使用两字节的德字符或者 unicode. 前8 个字节描述的是字符集. 'JIS' 是日文 (著名的有 Kanji).
'0x41,0x53,0x43,0x49,0x49,0x00,0x00,0x00':ASCII
'0x4a,0x49,0x53,0x00,0x00,0x00,0x00,0x00':JIS
'0x55,0x4e,0x49,0x43,0x4f,0x44,0x45,0x00':Unicode
'0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00':Undefined

0x9290
SubsecTime
ascii string

一些数字相机每秒能拍摄 2~30 张照片, 但是DateTime/DateTimeOriginal/DateTimeDigitized 标签只能记录到秒单位的时间. SubsecTime 标签就是用来记录秒后面的数据(微秒).

例如, DateTimeOriginal = "1996:09:01 09:15:30", SubSecTimeOriginal = "130", 合并起来的原始的拍摄 时间就是 "1996:09:01 09:15:30.130"

0x9291
SubsecTimeOriginal
ascii string

0x9292
SubsecTimeDigitized
ascii string

0xa000
FlashPixVersion
undefined
4

存储FlashPix 的版本信息. 如果图像数据是基于 FlashPix formar Ver.1.0, 则这个值为 "0100". 因为它不是一个用NULL(0x00)来终结的字符串，所以这里的类型是 'undefined'.

0xa001
ColorSpace
unsigned short
1

定义色彩空间. DCF 图像必须使用 sRGB 色彩空间因此这个值总是 '1'. 如果这个照片使用了 其他的色彩空间, 这个值是 '65535':未校准(Uncalibrated).

0xa002
ExifImageWidth
unsigned short/long
1
主图像的尺寸大小.
0xa003
ExifImageHeight
unsigned short/long
1
0xa004
RelatedSoundFile
ascii string

如果数字相机能够纪录图像的音频数据, 则表示音频数据的名字.
0xa005
ExifInteroperabilityOffset
unsigned long
1

表示这是一个扩展"ExifR98", 细节未知. 这个值经常是IFD格式的数据. 当前这儿有两个 目录项, 第一个是 Tag0x0001, 值是"R98", 下一个是 Tag0x0002, 它的值为 "0100".

0xa20e
FocalPlaneXResolution
unsigned rational
1

表示CCD的像素密度. 如果你的相机是百万像素的并且是用低分辨率(如VGA模式) 来拍摄照片, 这个值可以通过照片的分辨率来重新采样. 在这种情况下, FocalPlaneResolution 就不是CCD的实际的分辨率.

0xa20f
FocalPlaneYResolution
unsigned rational
1
0xa210
FocalPlaneResolutionUnit
unsigned short
1

FocalPlaneXResoluton/FocalPlaneYResolution的单位. '1' 表示没有单位, '2'是英寸inch, '3' 表示厘米.

注 意:一些Fujifilm的数码相机(如.FX2700,FX2900,Finepix4700Z/40i 等) 使用的值是 '3' 所以它的单位一定是 '厘米' , 但是它们的分辨率单位就变成'8.3mm?'(1/3in.?). 这是Fuji 的 BUG? 从Finepix4900Z 开始这个值就使用 '2' 了但仍然跟实际的值不吻合.

0xa215
ExposureIndex
unsigned rational
1

跟ISOSpeedRatings(0x8827)一样但是数据类型是 unsigned rational. 只有Kodak的数字相机使用 这个标签来替代 ISOSpeedRating, 我不知道这是为什么(历史原因?).

0xa217
SensingMethod
unsigned short
1
表示图像传感器单元的类型. '2' 意味着这是一个芯片颜色区域传感器, 几乎所有的数字相机都 使用这个类型.
0xa300
FileSource
undefined
1
显示图像来源. 值 '0x03' 表示图像源是数字定格相机.
0xa301
SceneType
undefined
1
表示拍摄场景的类型. 值 '0x01' 表示图像是通过相机直接拍摄出来的.
0xa302
CFAPattern
undefined

表示色彩过滤阵列(CFA) 几何模式.

|     |     |     |
| --- | --- | --- |
| 长度  | 类型  | 意义  |
| 2   | short | Horizontal repeat pixel unit = n |
| 2   | short | Vertical repeat pixel unit = m |
| 1   | byte | CFA value[0,0] |
| :   | :   | :   |
| 1   | byte | CFA value[n-1,0] |
| 1   | byte | CFA value[0,1] |
| :   | :   | :   |
| 1   | byte | CFA value[n-1,m-1] |

色彩过滤和CFA值之间的关系.

|     |     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Filter Color | Red | Green | Blue | Cyan | Magenta | Yellow | White |
| CFA value | 0   | 1   | 2   | 3   | 4   | 5   | 6   |

|     |     |
| --- | --- |
| R   | G   |
| G   | B   |

例如, 普通的 RGB 过滤器使用左表的副本, 这个值是 '0x0002,0x0002,0x00,0x01,0x01,0x02'.

|     |
| --- |
| **Interoperability IFD使用的标签** |
| 标签号 | 标签名 | 格式  | 组件号 | 描述  |
| 0x0001 | InteroperabilityIndex | Ascii string | 4   | 如果这个IFD 是主图像的 IFD 并且文件内容采用的是 ExifR98 v1.0, 那这个值就是 "R98". 如果是所略图的, 这个值则是 "THM". |
| 0x0002 | InteroperabilityVersion | Undefined | 4   | 纪录interoperability的版本. "0100" 表示版本1.00. |
| 0x1000 | RelatedImageFileFormat | Ascii string | any | 纪录图像文件的文件格式. 这个值是 ascii 字符串(如. "Exif JPEG Ver. 2.1"). |
| 0x1001 | RelatedImageWidth | Short or Long | 1   | 纪录图像的大小尺寸. |
| 0x1001 | RelatedImageLength | Short or Long | 1   |

|     |
| --- |
| **IFD1 (缩略图)使用的标签** |
| 标签号 | 标签名 | 格式  | 组件数 | 描述  |
| 0x0100 | ImageWidth | unsigned short/long | 1   | 表示缩略图的大小. |
| 0x0101 | ImageLength | unsigned short/long | 1   |
| 0x0102 | BitsPerSample | unsigned short | 3   | 当图像格式没有经过压缩, 这个值表示每像素的比特位的数目. 通常这个值是 '8,8,8' |
| 0x0103 | Compression | unsigned short | 1   | 代表压缩的方式. '1' 表示非压缩, '6' 表示JPEG 压缩格式. |
| 0x0106 | PhotometricInterpretation | unsigned short | 1   | 表示图像数据组件的色彩空间. '1' 意味着单色, '2'表示 RGB, '6' 表示 YCbCr. |
| 0x0111 | StripOffsets | unsigned short/long |     | 如果图像格式没有经过压缩, 这个值表示的是到图像数据的偏移量. 在图像数据被分割的 情况下它有多个值. |
| 0x0115 | SamplesPerPixel | unsigned short | 1   | 如果图像格式没有经过压缩, 这个值表示每个像素中存储的组件数目. 在彩色图像中, 此值为 '3'. |
| 0x0116 | RowsPerStrip | unsigned short/long | 1   | 如果图像格式没有经过压缩 并且 图像被分割存储, 这个值表示每条数据带存储了多少行数据 . 如果图像没有被分割, 它与ImageLength(0x0101)同值. |
| 0x0117 | StripByteConunts | unsigned short/long |     | 如果图像格式没有经过压缩 并且 图像被分割存储, 这个值表示每条数据带使用了多少字节的 数据 且 有多个值. 如果图像没有被分割, 它只有一个且表示为图像的所有数据的大小. |
| 0x011a | XResolution | unsigned rational | 1   | 图像的显示/打印分辨率. 很多的数字相机都使用1/72英寸的规格, 但对于个人PC 来讲这个值没有任何意义因为在显示/打印的时候不使用这个值. |
| 0x011b | YResolution | unsigned rational | 1   |
| 0x011c | PlanarConfiguration | unsigned short | 1   | 如果图像格式是非压缩YCbCr的, 这个值表示YCbCr数据的字节对齐顺序. '1', 表示Y/Cb/Cr值是一个 chunky format, 对于每个子采样像素都是连续的. '2', 则表示Y/Cb/Cr 值被分割存储在 Y plane/Cb plane/Cr plane 格式中. |
| 0x0128 | ResolutionUnit | unsigned short | 1   | XResolution(0x011a)/YResolution(0x011b)的单位. '1' 表示英寸, '2' 表示厘米. |
| 0x0201 | JpegIFOffset | unsigned long | 1   | 当图像格式是JPEG时, 这个值表示到 JPEG 数据的偏移量. |
| 0x0202 | JpegIFByteCount | unsigned long | 1   | 当图像格式是JPEG时, 表示JPEG 图像的数据大小. |
| 0x0211 | YCbCrCoefficients | unsigned rational | 3   | 当图像格式是YCbCr时, 它表示转换成RGB格式的一个常量值. 通常是'0.299/0.587/0.114'. |
| 0x0212 | YCbCrSubSampling | unsigned short | 2   | 当图像格式是YCbCr时 并且 使用子采样(色度数据的剪切值, 所有的数字相机都使用)时, 这个值表示有多少个色度数据被采样了. 首先第一个值表示水平的, 下一个值表示垂直的 采样率. |
| 0x0213 | YCbCrPositioning | unsigned short | 1   | 当图像格式是YCbCr时 并且 使用子采样(色度数据的剪切值, 所有的数字相机都使用)时, 这个值定义了被采样的像素阵列的色度采样点. '1' 表示像素阵列的中心, '2' 表示基准点(0,0). |
| 0x0214 | ReferenceBlackWhite | unsigned rational | 6   | 表示黑点/白点的参考值. 在 YCbCr 格式的情况下, 前两个表示了Y的黑/白, 下两个是 Cb, 最后两个是 Cr. 在 RGB 的情况下, 前两个表示R的黑/白, 下两个是 G, 最后两个是 B. |

|     |
| --- |
| **Misc Tags** |
| 标签号 | 标签名 | 格式  | 组件数 | 描述  |
| 0x00fe | NewSubfileType | unsigned long | 1   |     |
| 0x00ff | SubfileType | unsigned short | 1   |     |
| 0x012d | TransferFunction | unsigned short | 3   |     |
| 0x013b | Artist | ascii string |     |     |
| 0x013d | Predictor | unsigned short | 1   |     |
| 0x0142 | TileWidth | unsigned short | 1   |     |
| 0x0143 | TileLength | unsigned short | 1   |     |
| 0x0144 | TileOffsets | unsigned long |     |     |
| 0x0145 | TileByteCounts | unsigned short |     |     |
| 0x014a | SubIFDs | unsigned long |     |     |
| 0x015b | JPEGTables | undefined |     |     |
| 0x828d | CFARepeatPatternDim | unsigned short | 2   |     |
| 0x828e | CFAPattern | unsigned byte |     |     |
| 0x828f | BatteryLevel | unsigned rational | 1   |     |
| 0x83bb | IPTC/NAA | unsigned long |     |     |
| 0x8773 | InterColorProfile | undefined |     |     |
| 0x8824 | SpectralSensitivity | ascii string |     |     |
| 0x8825 | GPSInfo | unsigned long | 1   |     |
| 0x8828 | OECF | undefined |     |     |
| 0x8829 | Interlace | unsigned short | 1   |     |
| 0x882a | TimeZoneOffset | signed short | 1   |     |
| 0x882b | SelfTimerMode | unsigned short | 1   |     |
| 0x920b | FlashEnergy | unsigned rational | 1   |     |
| 0x920c | SpatialFrequencyResponse | undefined |     |     |
| 0x920d | Noise | undefined |     |     |
| 0x9211 | ImageNumber | unsigned long | 1   |     |
| 0x9212 | SecurityClassification | ascii string | 1   |     |
| 0x9213 | ImageHistory | ascii string |     |     |
| 0x9214 | SubjectLocation | unsigned short | 4   |     |
| 0x9215 | ExposureIndex | unsigned rational | 1   |     |
| 0x9216 | TIFF/EPStandardID | unsigned byte | 4   |     |
| 0xa20b | FlashEnergy | unsigned rational | 1   |     |
| 0xa20c | SpatialFrequencyResponse | unsigned short | 1   |     |
| 0xa214 | SubjectLocation | unsigned short | 1   |     |

* * *

下面是各厂商的Makernote的规格说明，但由于下面所提及的相机太过于古老，不准备全部翻译。

## [附录1: 奥林帕斯数字相机的MakerNote]()

下面是根据Peter Esherick解析出来的Olympus D450Z(C-920Z)的数据.

奥林帕斯的数字相机的MakerNote开始于 ASCII 字符串 "OLYMP". 数据格式跟IFD一样, 但是它是从偏移量 0x07 开始. 实际的数据结构的例子如下.

:0000: 4F 4C 59 4D 50 00 01 00-0B 00 00 02 04 00 03 00 OLYMP...........
:0010: 00 00 0E 04 00 00 01 02-03 00 01 00 00 00 03 00 ................

|     |     |     |     |     |
| --- | --- | --- | --- | --- |
| 标签号 | 标签名 | 格式  | 组件数 | 值   |
| 0x0200 | SpecialMode | Unsigned Long | 3   | 表示照片的拍摄模式. 第一个值的意思是 0=正常, 1=未知, 2=快速, 3=全景. 第二个值意思是序列号, 第三个值表示全景的方向 1=从左到右, 2=从右到左, 3=从下到上, 4=从上到下. |
| 0x0201 | JpegQual | Unsigned Short | 1   | 表示JPEG 的质量. 1=SQ,2=HQ,3=SHQ. |
| 0x0202 | Macro | Unsigned Short | 1   | 表示是否是宏模式. 0=正常, 1=宏. |
| 0x0203 | Unknown | Unsigned Short | 1   | 未知  |
| 0x0204 | DigiZoom | Unsigned Rational | 1   | 表示数字相机的放大率. 0=正常, 2=数字2倍变焦. |
| 0x0205 | Unknown | Unsigned Rational | 1   | 未知  |
| 0x0206 | Unknown | Signed Short | 6   | 未知  |
| 0x0207 | SoftwareRelease | Ascii string | 5   | 表示固件版本. |
| 0x0208 | PictInfo | Ascii string | 52  | 包含 ASCII 格式的数据如 [PictureInfo]. 它跟老的奥林帕斯数码相机(没有采用Exif 数据格式, 如C1400/C820/D620/D340等)采用相同的数据格式. |
| 0x0209 | CameraID | Undefined | 32  | 包含CameraID 的数据, 用户可以使用客户端工具来改变它的内容 |
| 0x0f00 | DataDump | Unsigned Long | 30  | 未知  |

* * *

## [附录2: 尼康相机的MakerNote]()

Nikon相机的MakerNote有两种格式. E700/E800/E900/E900S/E910/E950相机开始于 ASCII 字符串 "Nikon". 数据格式与IFD一样, 但是它从偏移地址0x08处开始. 除了开始字符串 之外这跟奥林帕斯相机的一样. 实际的数据结构的例子如下表示.

:0000: 4E 69 6B 6F 6E 00 01 00-05 00 02 00 02 00 06 00 Nikon...........
:0010: 00 00 EC 02 00 00 03 00-03 00 01 00 00 00 06 00 ................

|     |     |     |     |     |
| --- | --- | --- | --- | --- |
| 标签号. | 标签名 | 格式  | 组件数 | 值   |
| 0x0002 | Unknown | Ascii string | 6   | 未知. E900/E900S/E910:"09.41", 其他的是:"08.00". |
| 0x0003 | Quality | Unsigned short | 1   | 表示图像的质量设置. 在E900相机中, 1:VGA 基本, 2:VGA 正常, 3:VGA 好, 4:SXGA 基本, 5:SXGA 正常, 6:SXGA 好 |
| 0x0004 | Color Mode | Unsigned short | 1   | 1:彩色, 2:黑白. |
| 0x0005 | Image Adjustment | Unsigned short | 1   | 0:正常, 1:明亮+, 2:明亮-, 3:对比+, 4:对比-. |
| 0x0006 | CCD Sensitivity | Unsigned short | 1   | 0:ISO80, 2:ISO160, 4:ISO320, 5:ISO100 |
| 0x0007 | White balance | Unsigned short | 1   | 0:自动, 1:预设, 2:日光, 3:荧光灯, 4:白炽灯, 5:阴天, 6:速度光(SpeedLight) |
| 0x0008 | Focus | Unsigned rational | 1   | 如果是无穷远对焦, 此值为 '1/0'. |
| 0x0009 | Unknown | Ascii string | 20  | 未知  |
| 0x000a | Digital Zoom | Unsigned rational | 1   | '160/100' 表示 1.6x 数码变焦, '0/100' 表示没有采用数码变焦 (仅仅是光学变焦). |
| 0x000b | Converter | Unsigned short | 1   | 如果使用尼康的鱼眼镜头, 此值是 '1'. |
| 0x0f00 | Unknown | Unsigned long | 25~30 | 未知  |

在E990像集中, 没有Ascii 字符串. 就想通常的 IFD (如. IFD0, SubIFD)一样, 从数据的第一个 字节开始就是IFD . Nikon D1 也使用这个格式. 实际数据结构的例子如下表示.

:0000: 10 00 01 00 07 00 04 00-00 00 00 01 00 00 02 00 ................
:0010: 03 00 02 00 00 00 00 00-64 00 03 00 02 00 06 00 ........d.......

以下数据由[ Max Lyons ](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#AboutExifmailto:maxlyons@erols.com)解析.

|     |     |     |     |     |
| --- | --- | --- | --- | --- |
| Tag No. | Tag Name | Format | CompoNo | Value |
| 0x0001 | Unknown | Undefined | 4   | Unknown. Always "0100". version? |
| 0x0002 | ISO Setting | Unsigned short | 2   | 0,100=ISO 100<br>0,200=ISO200<br>0,400=ISO400<br>etc. |
| 0x0003 | Color Mode | Ascii string | varies | "COLOR", "B&W" |
| 0x0004 | Quality | Ascii string | varies | "NORMAL", "FINE", "BASIC" |
| 0x0005 | Whitebalance | Ascii string | varies | "AUTO", "WHITE PRESET" etc. |
| 0x0006 | Image Sharpening | Ascii string | varies | "AUTO", "HIGH" etc. |
| 0x0007 | Focus Mode | Ascii string | varies | "AF-S" means Single AF, "AF-C" means Continuous AF. |
| 0x0008 | Flash Setting | Ascii string | varies | "NORMAL", "RED-EYE" etc. |
| 0x000a | Unknown | Unsigned rational | 1   | Unknown, Always '8832/1000'? |
| 0x000f | ISO Selection | Ascii string | varies | "MANUAL":User selected, "AUTO":Automatically selected. |
| 0x0080 | Image Adjustment | Ascii string | varies | "AUTO", "NORMAL", "CONTRAST(+)" etc. |
| 0x0082 | Adapter | Ascii string | varies | "OFF", "FISHEYE 2", "WIDE ADAPTER" etc. |
| 0x0085 | Manual Focus Distance | Unsigned rational | 1   | Distance in Meters if focus was manually selected, otherwise 0 |
| 0x0086 | Digital Zoom | Unsigned rational | 1   | '100/100' means no digital zoom (optical zoom only), '140/100' means 1.4x digital zoom. |
| 0x0088 | AF Focus Position | Undefined | 4   | '0,0,0,0':Center, '0,1,0,0':Top, '0,2,0,0':Bottom, '0,3,0,0':Left, '0,4,0,0':right |
| 0x0010 | Data Dump | Undefined | 174 | Unknown. |

* * *

## [Appendix 3: MakerNote of Casio]()

Casio started to use Exif format from QV2000/QV8000. Casio's MakerNote format is the same as usual IFD (e.g. IFD0, SubIFD0). Example of actual data structure is shown below.

:0000: 00 14 00 01 00 03 00 00-00 01 00 0A 00 00 00 02 ................
:0010: 00 03 00 00 00 01 00 03-00 00 00 03 00 03 00 00 ................

The data below is analyzed by[ Eckhard Henkel ](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#AboutExifmailto:eckhard.henkel@t-online.de).

|     |     |     |     |     |
| --- | --- | --- | --- | --- |
| Tag No. | Tag Name | Format | CompoNo | Value |
| 0x0001 | RecordingMode | Unsigned Short | 1   | 1:Single Shutter, 2:Panorama, 3:Night Scene, 4:Portrait, 5:Landscape |
| 0x0002 | Quality | Unsigned Short | 1   | 1:Economy, 2:Normal, 3:Fine |
| 0x0003 | Focusing Mode | Unsigned Short | 1   | 2:Macro, 3:Auto Focus, 4:Manual Focus, 5:Infinity |
| 0x0004 | Flash Mode | Unsigned Short | 1   | 1:Auto, 2:On, 3:Off, 4:Red Eye Reduction |
| 0x0005 | Flash Intensity | Unsigned Short | 1   | 11:Weak, 13:Normal, 15:Strong |
| 0x0006 | Object distance | Unsigned Long | 1   | Object distance in [mm] |
| 0x0007 | White Balance | Unsigned Short | 1   | 1:Auto, 2:Tungsten, 3:Daylight, 4:Fluorescent, 5:Shade, 129:Manual |
| 0x0008 | Unknown | Unsigned short | 1   | Unknown |
| 0x0009 | Unknown | Unsigned short | 1   | Unknown |
| 0x000a | Digital Zoom | Unsigned Long | 1   | 0x10000(65536):'Off', 0x10001(65537):'2X Digital Zoom' |
| 0x000b | Sharpness | Unsigned Short | 1   | 0:Normal, 1:Soft, 2:Hard |
| 0x000c | Contrast | Unsigned Short | 1   | 0:Normal, 1:Low, 2:High |
| 0x000d | Saturation | Unsigned Short | 1   | 0:Normal, 1:Low, 2:High |
| 0x000e | Unknown | Unsigned short | 1   | Unknown |
| 0x000f | Unknown | Unsigned short | 1   | Unknown |
| 0x0010 | Unknown | Unsigned short | 1   | Unknown |
| 0x0011 | Unknown | Unsigned long | 1   | Unknown |
| 0x0012 | Unknown | Unsigned short | 1   | Unknown |
| 0x0013 | Unknown | Unsigned short | 1   | Unknown |
| 0x0014 | CCD Sensitivity | Unsigned short | 1   | QV3000:   64:Normal, 125:+1.0, 250:+2.0, 244:+3.0<br>QV8000/2000:   80:Normal, 100:High |

* * *

## [Appendix 4: MakerNote of Fujifilm]()

Fujifilm's digicam added the MakerNote tag from the Year2000's model (e.g.Finepix1400,Finepix4700). It uses IFD format and start from ASCII character 'FUJIFILM', and next 4 bytes(value 0x000c) points the offset to first IFD entry. Example of actual data structure is shown below.

:0000: 46 55 4A 49 46 49 4C 4D-0C 00 00 00 0F 00 00 00 :0000: FUJIFILM........
:0010: 07 00 04 00 00 00 30 31-33 30 00 10 02 00 08 00 :0010: ......0130......

There are two big differences to the other manufacturers.

- Fujifilm's Exif data uses Motorola align, but MakerNote ignores it and uses Intel align.
- The other manufacturer's MakerNote counts the "offset to data" from the first byte of TIFF header (same as the other IFD), but Fujifilm counts it from the first byte of MakerNote itself.

I think it's a BUG, but it can't be helped now... The data below is analyzed at Fujifilm FinePix4900Z.

|     |     |     |     |     |
| --- | --- | --- | --- | --- |
| Tag No. | Tag Name | Format | CompoNo | Value |
| 0x0000 | Version | Undefined | 4   | Version of MakerNote information. At present, value is "0130". |
| 0x1000 | Quality | Ascii string | 8   | Quality setting. Ascii string "BASIC","NORMAL","FINE" |
| 0x1001 | Sharpness | Unsigned Short | 1   | Sharpness setting. 1or2:soft, 3:normal, 4or5:hard. |
| 0x1002 | White Balance | Unsigned Short | 1   | White balance setting. 0:Auto, 256:Daylight, 512:Cloudy, 768:DaylightColor-fluorescence, 769:DaywhiteColor-fluorescence, 770:White-fluorescence, 1024:Incandenscense, 3840:Custom white balance. |
| 0x1003 | Color | Unsigned Short | 1   | Chroma saturation setting. 0:normal(STD), 256:High, 512:Low(ORG). |
| 0x1004 | Tone | Unsigned Short | 1   | Contrast setting. 0:normal(STD), 256:High(HARD), 512:Low(ORG). |
| 0x1010 | Flash Mode | Unsigned Short | 1   | Flash firing mode setting. 0:Auto, 1:On, 2:Off, 3:Red-eye reduction. |
| 0x1011 | Flash Strength | Signed Rational | 1   | Flash firing strength compensation setting. Unit is APEX(EV) and value is -6/10, -3/10, 0/10, 3/10, 6/10 etc. |
| 0x1020 | Macro | Unsigned Short | 1   | Macro mode setting. 0:Off, 1:On. |
| 0x1021 | Focus mode | Unsigned short | 1   | Focusing mode setting. 0:Auto focus, 1:Manual focus. |
| 0x1030 | SlowSync. | Unsigned short | 1   | Slow synchro mode setting. 0:Off, 1:On. |
| 0x1031 | Picture Mode | Unsigned short | 1   | Picture mode setting. 0:Auto, 1:Portrait scene, 2:Landscape scene, 4:Sports scene, 5:Night scene, 6:Program AE, 256:Aperture prior AE, 512:Shutter prior AE, 768:Manual exposure. |
| 0x1032 | unknown | Unsigned Short | 1   | Unknown |
| 0x1100 | ContTake/Bracket | Unsigned Short | 1   | Continuous taking or auto bracketting mode setting. 0:off, 1:on. |
| 0x1200 | unknown | Unsigned Short | 1   | Unknown |
| 0x1300 | Blur warning | Unsigned Short | 1   | Blur warning status. 0:No blur warning, 1:Blur warning. |
| 0x1301 | Focus warning | Unsigned short | 1   | Auto Focus warning status. 0:Auto Focus good, 1:Out of focus. |
| 0x1302 | AE warning | Unsigned short | 1   | Auto Exposure warning status. 0:AE good, 1:Over exposure (>1/1000s,F11). |

* * *

## [Appendix 5: MakerNote of Canon]()

The data below was primarily analysed by [David Burren](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#AboutExifmailto:db061@burren.cx) and the master version of this information is available at: http://www.burren.cx/david/canon.html. Please send any updates to [David](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#AboutExifmailto:db061@burren.cx).

This document is based on his Rev.1.11(2001/01/30) of document.
Canon's MakerNote data is in IFD format, starting at offset 0.

Some of these tags and fields are only produced on cameras such as the EOS D30, but (to current observation) all this is valid for all Canon digicams (at least since the A50). If the tag is not found, or is shorter than shown here, it simply means that data is not supported by that camera.

Tag No.
Tag Name
Format
CompoNo
Value
0x0
Unknown
Unsigned Short
6
Always 0
0x1
Unknown
Unsigned Short
varies

| Offset within tag | Meaning |
| --- | --- |
| 0   | Length of tag in bytes (i.e. twice the number of shorts) |
| 1   | Macro mode | 1: macro<br>2: normal |
| 2   | If non-zero, length of self-timer in 10ths of a second |
| 3   | unknown |
| 4   | Flash mode | 0: flash not fired<br>1: auto<br>2: on<br>3: red-eye reduction<br>4: slow synchro<br>5: auto + red-eye reduction<br>6: on + red-eye reduction<br>16: external flash (not set on D30) |
| 5   | Continuous drive mode | 0: single or timer (see field 2)<br>1: continuous |
| 6   | unknown |
| 7   | Focus Mode | 0: One-Shot<br>1: AI Servo<br>2: AI Focus<br>3: MF<br>4: Single (but check field 32)<br>5: Continuous<br>6: MF |
| 8, 9 | unknown |
| 10  | Image size | 0: large<br>1: medium<br>2: small |
| 11  | "Easy shooting" mode | 0: Full Auto<br>1: Manual<br>2: Landscape<br>3: Fast Shutter<br>4: Slow Shutter<br>5: Night<br>6: B&W<br>7: Sepia<br>8: Portrait<br>9: Sports<br>10: Macro / Close-Up<br>11: Pan Focus |
| 12  | unknown |
| 13  | Contrast | 0xffff: low<br>0x0000: normal<br>0x0001: high |
| 14  | Saturation | 0xffff: low<br>0x0000: normal<br>0x0001: high |
| 15  | Sharpness | 0xffff: low<br>0x0000: normal<br>0x0001: high |
| 16  | ISO | If zero, use ISOSpeedRatings EXIF tag instead<br>15: auto<br>16: 50<br>17: 100<br>18: 200<br>19: 400 |
| 17  | Metering mode | 3: Evaluative<br>4: Partial<br>5: Center-weighted |
| 18  | unknown |
| 19  | AF point selected | 0x3000: none (MF)<br>0x3001: auto-selected<br>0x3002: right<br>0x3003: center<br>0x3004: left |
| 20  | Exposure mode | 0: "Easy shooting" (use field 11)<br>1: Program<br>2: Tv-priority<br>3: Av-priority<br>4: Manual<br>5: A-DEP |
| 21, 22 | unknown |
| 23  | "long" focal length of lens (in "focal units") |
| 24  | "short" focal length of lens (in "focal units") |
| 25  | "focal units" per mm |
| 26 - 28 | unknown |
| 29  | Flash details | Bits 15..0:<br>14: external E-TTL<br>13: internal flash<br>11: FP sync used<br>4: FP sync enabled<br>other bits unknown |
| 30 - 31 | unknown |
| 32  | Focus mode | G1 seems to use this in preference to field 7<br>0: Single<br>1: Continuous |

0x3
Unknown
Unsigned Short
4
unknown
0x4
Unknown
Unsigned Short
varies

| Offset within tag | Meaning |
| --- | --- |
| 0   | Length of tag in bytes (i.e. twice the number of shorts) |
| 1 - 6 | unknown |
| 7   | White balance | 0: auto<br>1: Sunny<br>2: Cloudy<br>3: Tungsten<br>4: Flourescent<br>5: Flash<br>6: Custom |
| 8   | unknown |
| 9   | Sequence number (if in a continuous burst) |
| 10 - 13 | unknown |
| 14  | AF point used | Only set in One-Shot mode?<br>If none used, AF failed or manual focus was used (e.g. on a lens with full-time manual focus)<br>Bits 15..0:<br>15-12: number of available focus points<br>2: left<br>1: center<br>0: right |
| 15  | Flash bias | 0xffc0: -2 EV<br>0xffcc: -1.67 EV<br>0xffd0: -1.50 EV<br>0xffd4: -1.33 EV<br>0xffe0: -1 EV<br>0xffec: -0.67 EV<br>0xfff0: -0.50 EV<br>0xfff4: -0.33 EV<br>0x0000: 0 EV<br>0x000c: 0.33 EV<br>0x0010: 0.50 EV<br>0x0014: 0.67 EV<br>0x0020: 1 EV<br>0x002c: 1.33 EV<br>0x0030: 1.50 EV<br>0x0034: 1.67 EV<br>0x0040: 2 EV |
| 16 - 18 | unknown |
| 19  | Subject Distance | Units are either 0.01m or 0.001m (both have been observed). Still investigating.<br>In any case, the SubjectDistance EXIF tag is set by Canon cameras. |

0x6
Image type
Ascii string
32
e.g.: "IMG:EOS D30 JPEG"
Has trailing whitespace.
0x7
Firmware version
Ascii string
24
May have trailing NULs and whitespace.
0x8
Image Number
Unsigned Long
1
Normally reported as FFF-XXXX.
FFF is this value divided by 1000, XXXX is this value mod 1000.
0x9
Owner name
Ascii string
32
May have trailing NULs and whitespace.
0xa
Unknown
Unsigned Short
varies
unknown
0xc
Camera serial number
Unsigned Long
1
High 16 bits are printed as a 4-digit hex number.
Low 16 bits are printed as a 5-digit decimal number.

These are concatenated to form the serial number. Example printf() format string would be "Xd".

0xd
Unknown
Unsigned Short
varies
unknown
0xf
Custom Functions
Unsigned Short
varies
First short is the number of bytes in the tag (i.e. twice the number of shorts)

For each other value: the top 8 bits are the C.Fn number, and the lower 8 bits are the value.

### EOS D30 Custom Functions

| C.Fn | Name | Value |
| --- | --- | --- |
| 1   | Long exposure noise reduction | 0: Off<br>1: On |
| 2   | Shutter/AE-lock buttons | 0: AF/AE lock<br>1: AE lock/AF<br>2: AF/AF lock<br>3: AE+release/AE+AF |
| 3   | Mirror lockup | 0: Disable<br>1: Enable |
| 4   | Tv/Av and exposure level | 0: 1/2 stop<br>1: 1/3 stop |
| 5   | AF-assist light | 0: On (auto)<br>1: Off |
| 6   | Shutter speed in Av mode | 0: Automatic<br>1: 1/200 (fixed) |
| 7   | AEB sequence/auto cancellation | 0: 0, -, + / Enabled<br>1: 0, -, + / Disabled<br>2: -, 0, + / Enabled<br>3: -, 0, + / Disabled |
| 8   | Shutter curtain sync | 0: 1st-curtain sync<br>1: 2nd-curtain sync |
| 9   | Lens AF stop button Fn. Switch | 0: AF stop<br>1: Operate AF<br>2: Lock AE and start timer |
| 10  | Auto reduction of fill flash | 0: Enable<br>1: Disable |
| 11  | Menu button return position | 0: Top<br>1: Previous (volatile)<br>2: Previous |
| 12  | SET button func. when shooting | 0: Not assigned<br>1: Change quality<br>2: Change ISO speed<br>3: Select parameters |
| 13  | Sensor cleaning | 0: Disable<br>1: Enable |

* * *

## [修订履历]()

### rev. 1.4

- 追加了佳能的Makernote
- 在富士的makernote中增加了色彩/色调 标签

### rev. 1.3

- 追加了 Exif2.1 规格
- 添加了富士的 Makernote

### rev. 1.2

- 追加了 DCF 规格
- 追加了Interoperability IFD
- 添加了尼康/卡西欧的Makernote

### rev. 1.1

- 在TIFF头的标签标记中追加了字节顺序的解释
- 为"unsigned short/long"修正了一些标签的数据格式
- 修正了FocalPlaneResolutionUnit的值
- 附录1: 奥林帕斯的MakerNote

### rev. 1.0

- 第一版发布

## [鸣谢]()

我想要感谢;

Daniel Switkin: 标签标记的字节序, ImageWidth/ImageLeng格式
Peter Esherick: 奥林帕斯的MakerNote
Matthias Wandel: FocalPlaneResolutionUnit的值

[Max Lyons](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#AboutExifmailto:maxlyons@erols.com): 尼康的Makernote   ...它的[ 网页](http://tawba.tripod.com/)在这里

[Eckhard Henkel](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#AboutExifmailto:eckhard.henkel@t-online.de): 卡西欧的Makernote   ...它的[ 网页](http://home.t-online.de/home/eckhard.henkel/)在这里

[David Burren](http://blog.sina.com.cn/s/blog_651251e60102uz3d.html#AboutExifmailto:db061@burren.cx): 富士的FocalPlaneResolutionUnit的值 / 佳能的Makernote  ...它的[ 网页](http://www.burren.cx/david/)在这里

### 整理实属不易，转载请注明来源：http://blog.sina.com.cn/s/blog_651251e60102uz3d.html

