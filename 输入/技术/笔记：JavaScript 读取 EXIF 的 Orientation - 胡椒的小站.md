笔记：JavaScript 读取 EXIF 的 Orientation - 胡椒的小站

1.   [首页](https://moxo.io/)  /

2.   [笔记簿](https://moxo.io/blog/)  /

3.  当前文章 /

# 笔记：JavaScript 读取 EXIF 的 Orientation

   **胡椒**    |  2017-03-21


拍摄于 2017-03-20，最近在用 IQOS，图上的是一些「烟弹」，IQOS 电子烟每一发的子弹。

 * blog 内容里有很多代码片段是直接存在 [Gist](https://gist.github.com/) ，而部分图片、视频则放在 [Flickr](https://www.flickr.com/) 上，两者在大陆的访问状况基本不堪 ，所以自备梯子。*  笔记内容目录

[问题在哪里？需要 EXIF.Orientation 出现的场景](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#%E9%97%AE%E9%A2%98%E5%9C%A8%E5%93%AA%E9%87%8C-%E9%9C%80%E8%A6%81-exif-orientation-%E5%87%BA%E7%8E%B0%E7%9A%84%E5%9C%BA%E6%99%AF)
- [为什么会出现图片旋转角度的错误](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#%E4%B8%BA%E4%BB%80%E4%B9%88%E4%BC%9A%E5%87%BA%E7%8E%B0%E5%9B%BE%E7%89%87%E6%97%8B%E8%BD%AC%E8%A7%92%E5%BA%A6%E7%9A%84%E9%94%99%E8%AF%AF)
- [EXIF 和 Orientation Tag 的一些历史](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#exif-%E5%92%8C-orientation-tag-%E7%9A%84%E4%B8%80%E4%BA%9B%E5%8E%86%E5%8F%B2)
- [Orientation Tag 的值和对应的角度](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#orientation-tag-%E7%9A%84%E5%80%BC%E5%92%8C%E5%AF%B9%E5%BA%94%E7%9A%84%E8%A7%92%E5%BA%A6)
- [不同设备之间的区别](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#%E4%B8%8D%E5%90%8C%E8%AE%BE%E5%A4%87%E4%B9%8B%E9%97%B4%E7%9A%84%E5%8C%BA%E5%88%AB)
- [解决问题：CSS Way: image-orientation 属性：](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#%E8%A7%A3%E5%86%B3%E9%97%AE%E9%A2%98-css-way-image-orientation-%E5%B1%9E%E6%80%A7)
- [解决问题：JavaScript Way，步骤、 demo 和原理：](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#%E8%A7%A3%E5%86%B3%E9%97%AE%E9%A2%98-javascript-way-%E6%AD%A5%E9%AA%A4-demo-%E5%92%8C%E5%8E%9F%E7%90%86)
- [步骤：](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#%E6%AD%A5%E9%AA%A4)
        - [伪代码：](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#%E4%BC%AA%E4%BB%A3%E7%A0%81)
            - [D is for Demonstration：](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#d-is-for-demonstration)
    
    - [附录](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#%E9%99%84%E5%BD%95)
        - [JPEG 文件中有些什么？](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#jpeg-%E6%96%87%E4%BB%B6%E4%B8%AD%E6%9C%89%E4%BA%9B%E4%BB%80%E4%B9%88)
            - [JPEG 文件的线性结构](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#jpeg-%E6%96%87%E4%BB%B6%E7%9A%84%E7%BA%BF%E6%80%A7%E7%BB%93%E6%9E%84)
            - [Brief on JPEG：](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#brief-on-jpeg)
            - [Brief on APP1:](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#brief-on-app1)
            - [Brief on TIFF header：](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#brief-on-tiff-header)
            - [Brief on Exif’s IFD(Image File Directory):](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#brief-on-exif-s-ifd-image-file-directory)
            - [Brief on entry of IFD(Image File Directory):](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#brief-on-entry-of-ifd-image-file-directory)
        - [《Description of Exif file format》 截至 IFD data structure 的翻译](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#description-of-exif-file-format-%E6%88%AA%E8%87%B3-ifd-data-structure-%E7%9A%84%E7%BF%BB%E8%AF%91)

##### Updated 2017-03-25

- 这篇笔记最早发表在[知乎](https://zhuanlan.zhihu.com/p/25216999)；
- 把 《[Description of Exif file format](https://www.media.mit.edu/pia/Research/deepview/exif.html)》的翻译贴到了[博客](https://moxo.io/blog/2017/03/22/translation-of-description-of-exif-file-format/)上。

**处理 JPEG 中 EXIF 数据相关的项目过程中，填了「前台剪裁上传图片」这个需求中，图片旋转错误导致显示错误的坑。**对于前台图片上传中「剪裁之后旋转错误」，除了 [Exif.js](https://github.com/exif-js/exif-js) 之外其实还有别的[解决方案](https://stackoverflow.com/a/32490603)，很简单的一个代码片段却非常有效，不免有「为什么」的疑问，这篇笔记针对这个「为什么」做了大致梳理。

## 问题在哪里？需要 EXIF.Orientation 出现的场景

前端图片剪裁上传， 利用画布（canvas）将原始图片绘制到 2d content 上后，进行旋转，但旋转成了错误的角度。对这个挺常见的场景步骤的还原：

1. `input[type=“file“].onchange = (e)` 获得 `file`，`FileReader` 将 `file` 转换成 `base64`；

2. `new image()`，在它的 `onload()` 事件中将获取到的 `base64` 赋值到画布（canvas）上，并且赋予新的宽和高；
3. 通过 `context(‘2d’)` 在 `canvas` 上绘制，获得一张同比例不同尺寸的新图；
4. 最后 `canvas.toDataURL()` 得到需要的新数据进行上传 base 64 数据。

**问题在第 4 步，导致的结果直观的体现为：上传到服务器的图片，或者生成在前台预览的图片的方向错误。**（比如，使用 iPhone 拍摄，竖持手机 Home 键在下，得到的图片会逆时针转 90 度），如下图：

 ![u8bzJp.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/bad412e2df4907a00675a5ab1d6c441c.png)

上传到服务器的图片，或者生成在前台预览的图片的方向错误。

## 为什么会出现图片旋转角度的错误

1. 首先来看看在电脑里这张图片是什么样子，通过 Mac 里的 preview.app 打开结果是正确的：
![vD7d1c.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/bab384e0ed1dd91bc8917232385739f1.png)
通过 Mac 里的 preview.app 打开后，正确显示的图片。

2. 接着在浏览器里直接打开这张图是什么样子？结果同样正确的：
![z1zwDQ.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/1f371c872fbccba717854573fba67766.png)

1. 接着尝试在 html 的 `<img>` 元素中引用这张图片，结果会怎样？错误出现[1](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fn:1)。

![jtKv00.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/2d8a6b7412e5199b5a268f6efe65066b.png)

1. 看到这个结果的时候，大概可以意识到：**旋转角度错误的问题出现，可能不是上传的时候我们做错了什么导致图片的方向错了，而是我们少做了什么，没有正确将图片旋转成我们需要的方向**。

那么怎么样确认如何才是正确的方向？首先在 Mac 上可以通过 **preview.app** 来获得线索，在 **preview** 中打开 **tools -> show inspector（工具-显示检查器）**，第二栏的「通用」如下：

 ![faaDC6.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/b760340efaa19280fce03fb8c7afa1c1.png)

检查器。

在「通用」下有「方向」，对应的值是 6（逆时针旋转 90°）；**对比图片，猜测这图片是不是被逆时针旋转 90°，所以为了得到正确的显示结果，需要顺时针旋转图片 90°？**

Google 了一堆后发现，这里的「方向」指的就是图片 Exif 信息中的 Orientation 数据，而我们没有做的，就是 preview.app（或者说操作系统） 已经帮我们做了的事情：**根据 Exif 信息中的 Orientation 不同的值，旋转所要查看的图片，将其以正确的方式显示在浏览器的网页之中**，放到我们的需求中，就是在 canvas 上 draw 新图的时候，没有按照正确的方向去 draw。

## EXIF 和 Orientation Tag 的一些历史

早期的数码相机所拍摄的图片，图片的 metadata（EXIF）信息中并没有 Orientation Tag，只会按照相机本身设备的默认方向存储图片，比如使用默认为 landscape 的相机，竖持设备，拍出来的图片就被旋转了 90°；早期的图片查看软件，可以暂时将图片旋转成正确的角度以供查看，如果需要一劳永逸的解决角度问题，必须手动修改。

用户手动修改图片的过程：**decompress JPEG -> rotate -> re-compress JPEG again**，可能会导致再一次的有损压缩，但当时的软件基本可以做到无损的解码-旋转-重新编码，所以旋转问题并不是一个特别严重的问题。

同时，一些相机厂商意识到这个角度问题，想要解决，所以他们在相机产品中加入了 orientation sensor 去识别拍摄图片的角度，这里产生了一个问题：生成图片的 image signal processing chips (ISPs) 并不能按照 orientation sensor 识别的到的角度直接生成一张图片。

于是，厂商们就决定将这些数据写入图片的 metadata（EXIF） 之中，所以实际上相机存储的图片实际上本身就可能为错误的旋转角度（默认 landscape 的设备，拍摄了 portrait 的图片），而图片自带的数据里包含了图片本身正确旋转角度对应的值。导致：如果图片查看软件对 orientation tag 做了支持，显示的图片会以适当的角度呈现在我们面前，否则我们看到的图片，（对设备来说正确的）角度在我们看来就是错的。

结合上文中将图片在各种环境下（操作系统，浏览器，html）打开、查看的例子，很显然操作系统、浏览器本身是对 orientation tag 做了支持的，而在 DOM 中并没有，至少并没有为我们自动作出旋转[2](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fn:2)。

## Orientation Tag 的值和对应的角度

Orientation Tag 有八个值，对应不同的翻转角度：1，2，3，4，5，6，7，8 [3](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fn:3)。

**>

- **> case 1:**>  The 0th row is at the visual top of the image, and the 0th column is the visual left-hand side.
- **> case 2:**>  The 0th row is at the visual top of the image, and the 0th column is the visual right-hand side.
- **> case 3:**>  The 0th row is at the visual bottom of the image, and the 0th column is the visual right-hand side.
- **> case 4:**>  The 0th row is at the visual bottom of the image, and the 0th column is the visual left-hand side.
- **> case 5:**>  The 0th row is the visual left-hand side of the image, and the 0th column is the visual top.
- **> case 6:**>  The 0th row is the visual right-hand side of the image, and the 0th column is the visual top.
- **> case 7:**>  The 0th row is the visual right-hand side of the image, and the 0th column is the visual bottom.
- **> case 8:**>  The 0th row is the visual left-hand side of the image, and the 0th column is the visual bottom.
- **> Other:**>  reserved

描述中出现的 **「visual top」** 等，原文中说是指**「a display device」**上的上下左右，理解起来就是平时用到图片查看软件，具体的上下左右所指其实和我们日常中的并无出入[4](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fn:4)：

 ![yM5ozh.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/9bac3150142de5a2ff2887e65e9a6bc1.png)

「a display device」

关于 0th row 和 0th column ，大致的理解是，一张 JPEG 文件，在 compress 和 uncompressed 的时候会由很多的行 row 和 column 组成， 0th row 和 0th column 代表的是拍摄的景物（captured scene）的 上和左，对照如下表格，以 iPhone 拍摄和 case 6 来做个例子：

1. 首先 case 6 的 0th row 在显示设备的右，0th column 在显示器的上面；

2. 接着，想象一下 iPhone 拍摄，当 home 键在右边的时候，case 为 1，也就是拍摄的和显示 top = 0th row，left = 0th column；

3. 然后把 iPhone 旋转成 home 键在下的竖持位置，这个时候，对比 case 1 时候设备 top 和 left，top 被转到了右，left 被转到了上，即顺时针转了 90 度；

4. 所以，此时生成出来的 JPEG 在没有自动读取 EXIF 进行旋转的图片查看器里，就是被逆时针旋转了 90 度；
5. 于是，相机就在图片的 EXIF 中 Orientation Tag 上加了 6 的值，告诉图片查看器需要顺时针旋转 90 度。

这些值有一张更好的图可以说明它们之间的相互关系[5](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fn:5) ：**[1, 6, 3, 8] 是相互一次顺时针 90 度方向的关系，而 [2, 5, 4, 7] 则对应了 [1, 6 ,3, 8] 的水平镜像 [6](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fn:6)[7](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fn:7)。**

 ![HODq9r.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/5e9c02418646d9caeeff42a4a8c7870d.png)

[1, 6, 3, 8] 是相互一次顺时针 90 度方向的关系，而 [2, 5, 4, 7] 则对应了 [1, 6 ,3, 8] 的水平镜像

## 不同设备之间的区别

调用系统摄像头：

EXIF 的问题主要出现在移动端 iPhone 拍摄的图片上，但是使用 iPhone 前后置摄像头进行旋转各种角度拍摄的结果都只在 [1, 6, 3, 8] 之间，不太确定什么情况才会产生 [2, 5, 4, 7]；

Android 设备手边能够测试的不多，几台下来，有的是直接没有写入 EXIF.Orientation 信息（比如小米）；值得一提的是：貌似部分 Android 手机会无论以什么角度旋转来拍摄图片，在生成图片的时候都会把图片旋转成正确的角度，然后在 orientation 打上 1 的值（比如华为）即：

- **普通设备（包括 iPhone）的拍摄图片到生成图片的过程：**拍摄 -> 生成图片 -> 根据角度给 EXIF.orientation 打上 [1, 6, 3, 8] 间不同的值；
- **部分 Android （测试华为手机）设备：**拍摄 -> 根据设备所持旋转角度生成正确角度的图片 -> 给 EXIF.orientation 打上 1 的值。

**App 内调用摄像头：**
比如微信对话内拍摄发送给对方的图，是没有 EXIF 信息的；别的没有做太多测试。

## 解决问题：CSS Way: image-orientation 属性：

W3C 已经有了相关的 [CSS3 Candidate Recommendation](https://www.w3.org/TR/css3-images/#the-image-orientation) 和 [Working Draft](https://www.w3.org/TR/css-images-4/#the-image-orientation)；不过实际中浏览器提供的支持比较差，各家中只有 [Firefox 和 iOS Safari 的 latest 的版本对这个属性有支持](https://caniuse.com/#feat=css-image-orientation) 。

## 解决问题：JavaScript Way，步骤、 demo 和原理：

### 步骤：

假设已经得到了 file，并且通过 `readAsArrayBuffer` 后得到了我们需要的 view，那么获得 orientation 的值的获取步骤是：
1. 检查 JPEG 的 SOI maker：0xFFD8 是否存在？继续 ：中止；
2. 检查 APP1 的 marker：0xFFE1 是否存在 ？继续 ：中止；
3. 检查 Exif header 的开始是否为「Exif」（ascii：0x45786966）？继续 ：中止；
4. 找到 TIFF header，通过开头两个字节的数据判定字节序：
    1. 「II」0x4949 -> little-endian；
    2. 「MM」0x4D4D -> big-endian；
    3. 两者都不是，something wrong or crazy happened，中止；
5. 找到 IFD0;
    1. 有 -> 读取其中的 entry 的数量。得到 entry 入口偏移量；
    2. 无 -> 中指；
6. 找到 IFD0 中的 entries，循环读取查找是否有 tag number 为 0x0112 的 entry：
    1. 有 -> 继续读取 format，components，value 的值，计算得出 tag 真正的值；
    2. 无 -> 没有 orientation 信息。



##  使用 JavaScript 读取 JPEG 文件中 EXIF 的 Orientation 属性，利用 canvas 根据其对应值作出旋转。

### 没有处理旋转的结果：

### 2. 根据 Exif 中 Orientation 进行旋转了的结果：



### 结果预览

 ![0IBOm4.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/6930a1d312f33abfbe2e792d1205bfaa.png)

## 附录

针对文章开头问题的解决方案没有多少行，但要得出这个结论绕不过去的一个疑问就是「 JPEG 文件内部存了什么？」。附录就是来解决这个疑问，内部原理是怎么样的。

附录部分包含两部分内容，「JPEG 中有些什么？」和 《[Description of Exif file format](https://www.media.mit.edu/pia/Research/deepview/exif.html)》的部分翻译。显然，第一部分的结论基于第二部分的翻译和一些手动的测试[10](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fn:10)。

### JPEG 文件中有些什么？

#### JPEG 文件的线性结构

下面会提到很多 xxxx’s structure，但其实一张 JPEG 文件里面就是一整段二进制码（binary），不是树形结构，是线形从头到尾，比如 APP0，APP0 content，APP1，APP1 content，只是：

`APP0 - APP0 content - APP1 - APP1 content`
并不是：

	JPEG
	|_APP0_APP0 content
	|_APP1_APP1 content

 ![2us1Rq.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/29cb8fc88219e92a63d4dae4eb0fca04.png)

JPEG 文件里面就是一整段二进制码（binary），不是树形结构，是线形从头到尾，截图软件为 Hex Friend。

#### Brief on JPEG：

1. [JPEG（Joint Photographic Experts Group）](https://en.wikipedia.org/wiki/JPEG) 指一种对图像压缩标准的简称，日常口中提到的 JPEG 文件，更多的是指 JPEG/JFIF（JPEG File Interchange Format） 文件[11](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fn:11)。

2. JPEG 中的数据均是 Big-Endian 格式；
3. JPEG 开头的一部分数据，对于其中包含的图像数据的解码并没有作用；
4. Exif 信息就包含这些信息中，内容主要是不同软件，硬件制造商在图片上写入的数据，比如拍摄的环境、设备信息，或者用了什么软件。
5. 如表所示，这些数据，会被划分到不同的 APP 区块（application segment）；

其中 APP0 是 JFIF application segment， APP1 里面则对应的是 Exif 数据（也就是我们需要找的），[APP 13 对应 PhotoShop 写入的一些数据](http://search.cpan.org/~rjbs/Image-MetaData-JPEG-0.159/lib/Image/MetaData/JPEG/Structures.pod#Structure_of_a_Photoshop-style_APP13_segment)；

**表中的 marker 一列是不同 APP 开头部分的标志，但找到它们并不能完全确定之后的就是 APP 内容，还需要对内容部分做出筛选来过滤 marker 的真假。**

表格中列出了 APP0 到 APP2，因为需要处理的 Exif 数据都在 APP1 之内，剩余的使用 APPn 表示，如果的有兴趣了解，可以参考：[维基](https://en.wikibooks.org/wiki/JPEG_-_Idea_and_Practice/The_header_part)、[ExifTool 相关的数据列表页](http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/JPEG.html)、或者[这里](http://www.ozhiker.com/electronics/pjmt/jpeg_info/app_segments.html)也对所有 application segment 做了总结。

#### Brief on APP1:

1. 开头是 APP1 maker: 0xFFE1：
2. 紧跟的两个字节表示的内容的是 APP1 数据长度的字节数；
3. Exif header 部分开始：
    1. 首先是「Exif」四个字母的 ascii string: 45 78 69 66
    2. 之后是两个字节的 0：0x0000;
4. TIFF header 开始：
    1. byte order mark；
    2. TIFF marker；
    3. 从 TIFF header 到第一个 Image File Directory 的偏移量；

5. 之后依次是，IFD0（第一个 Image File Directory）、ExifSubIFD、GPSIFD。而我们需要的 Orientation 信息就在这个 IFD0 之中。

#### Brief on TIFF header：

1. [Exif（Exchangeable image file format）](https://en.wikipedia.org/wiki/Exif)建立在 [TIFF（Tagged Image File Format）](https://en.wikipedia.org/wiki/TIFF)格式之上。**所以开头有 8 个字节长度的 TIFF Header，用来表示其中的数据信息和结构**；

2. 最开始的两个字节代表 TIFF 中数据的 byte order：
    1. 如果是 「II」(0x4949)，数据是 Little-Endian；
    2. 如果是「MM」（0x4d4d），则是 Big-Endian；
3. 之后的两个字节是 TIFF marker，按照数据格式 byte order 的不同，可能会显示为 0x2A00 或者 0x002A；

4. 之后的四个字节表示从 TIFF header 的偏移量到 Exif header 的偏移量。一般 TIFF header 后面紧跟的就是 Exif header，所以这个偏移量一般都是 8（0x00000008）。

**关于第二点的补充：**（上文说道 JPEG 中数据都是 Big-Endian 的 byte order，但是这里因为包含了 TIFF 数据格式，所以每次读取的时候都需要检查，数据可能是 little-endian，也可能是 big-endian）

#### Brief on Exif’s IFD(Image File Directory):

1. TIFF header 之后通常就是 APP1 中所有 IFD（Image File Directory）；
2. 每个 IFD 开始的两个字节，表示其中 entry 的数量；
3. 每个 entry 可以理解成针对不同属性值包裹的文件夹，包含了属性，格式，数量等值。

#### Brief on entry of IFD(Image File Directory):

1. 每一个 entry 由四个部分组成：tag number，format，count，value；一共 12 个字节长；

2. tag number 就是属性的 code name，比如说想找 Orientation，[对应的 code 是 0x0112（hex）](http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/EXIF.html)；

3. format 是数据的格式；
4. components 对应数据值的长度；

5. **value 的值，但不一定是 tag 的值，也有可能是 tag 的值的偏移量**；这里有一个计算，format 对应了一个 bytes per component 的值，需要与 components 的值相乘，得到真正数据值（val）的数据长度（bytes length），如果这个数据长度大于 4 个字节，那么 value 的值是 val 的偏移量，如果小于 4，则 value 就是 val。

6. 最后取得 tag 值（val）的数据，对应不同数据格式（format），进行 decode。

关于第五点，需要的是 orientation tag（0x112）的值的 format 对应的计算：它的 format value 是 3，对应的 format 是 `unsigned short`，每个值由 2 个字节组成，使用 `DataView.getUint16(offset, little)` 直接读取就可以。

##### 其它 format，数据格式对应表格：

* * *

### 《Description of Exif file format》 截至 IFD data structure 的翻译

《[Description of Exif file format](https://www.media.mit.edu/pia/Research/deepview/exif.html)》 截至 IFD data structure 的翻译。（不算是直译，可能是会夹杂一些自己的理解，句子写长或者缩短，推荐对照原文阅读）

#### Exif file format

原文：[《Exif file format》](https://www.media.mit.edu/pia/Research/deepview/exif.html)

#### JPEG format and Marker

JPEG 文件以十六进制 0xFFD8 开始，以 0xFFD9 结束。在 JPEG 数据中有像 0xFF **这样的数据，这些被称为「标志」（Marker），它表示 JPEG 信息数据段。0xFFD8 表示 SOI（Start of image 图像开始，0xFFD9 表示 EOI（End of image 图像结束）**。这两个特殊的标志没有附加的数据，而其他的标志在标志后都带有附加的数据。

Marker 的基本格式如下：

	0xFF + Marker Number(1 byte) + Data size(2 bytes) + Data(n bytes)
	0xFF + 标志数字（1字节） + 数据大小（2字节） + 数据（n字节）

数据大小（Data size）使用「Motorola」方式表示 byte 的顺序，起始从高字节开始。（也就是 big-endian format 参考 Wikipedia）。需要注意的是，数据中包含着有关于数据大小的描述。

如果一个 Marker 为：`FF xx - 00 0C - 01 02 03 04 05 06 08 09 0A`：

它代表的含义是：Marker（`OxFFC1`） 这个标记对应的数据的长度是 `0x000C`（12 字节），但这个数据长度「12 字节」也包含「对于数据的描述」的字节，所以「真实数据」在这里应该是 10 个字节。所以实际的数据是：`00 0C - 01 02 03 04 05 06 08 09 0A` 这 12 个字节。

在 JPEG 格式中，在一些 Marker 描述数据后就是SOS（Start of stream）Marker，紧随 SOS Mark 后的就是图片本身的流，直到 EOI Marker 终结。

#### Marker used by Exif（Exif 中使用到的标记）

The marker 0xFFE0~3 被称为「Application Marker」（应用程序标记），这一系列标记对于 JPEG 文件的解码并不必须。更多的，他们是被一些设备的图像格式 JFIF（JPEG File Interchange Format）用来记录数码相机的配置信息和缩略图像，比如：老款的 olympus/canon/casio/agfa 数码相机。

Exif 同时也使用「Application Marker」（应用程序标记）来插入数据，但是会使用 APP1（0xFFE1）Marker 来避免与 JFIF 格式之间的冲突。所有 Exif 文件格式都以一下格式开始：

| SOI marker | APP1 marker | APP1 Data | Other Marker |
| --- | --- | --- | --- |
| FFD8 | FFE1 | SSSS 4578660000 TTTT… | FFXX SSSS DDDD… |

Exif 文件最开始的码位是 FFD8，所以它是一个 JPEG 文件，之后是 APP1 Marker 紧随其后。Exif 里所有的数据都是在 APP1 对应的数据区内。上面表格中「SSSS」代表的是 APP1 数据区（Exif 的数据区）内的数据大小。 在「SSSS」之后，是 APP1 的数据，这段数据的第一部分用来判定 Exif 是否存在，使用的是 ASCII 码对应的「Exif」和 2个字节的 `0x00`。

APP1 Marker 对应的数据区结束之后，其它 JPEG 的数据紧随其后。

#### Exif 数据结构：

Exif（APP1）基本结构如下面的表格所示，采用了 Intel 的 little-endian 的字节顺序，并且包含了 JPEG 格式的缩略图。如上文说，Exif 数据的开始是 ASCII 字符的 「Exif」和 2 个字节的 0x00，接着就是 Exif 具体数据。Exif 使用「TIFF」格式来存储数据。更多关于「TIFF」格式的信息，可以参考 TIFF6.0 specification。

 ![OaPKTy.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/f1ef1c4cce9065c458adaaff704fe4a3.png)

#### TIFF Header：

TiFF header 指的是 TIFF 格式的前 8 个字节，前两个定义了 TIFF 数据采用何种字节顺序：

- 如果是 `0x4949` = II，表示采用 Inter 的小端字节顺序（`49 49：01001001 01001001`）；
- 如果为 `0x4d4d` = MM，表示采用 Motorola 的大端字节顺序（`4d 4d：01001101 01001101`）；

例如：十进制值 `305419896` 的十六进制表示是：`12345678`，如果以 Motroal 式的 big-endian 进行存储，对应的 code unit 就是 `0x12 0x34 0x56 0x78`；而如果是 Intel 式的 little-endian 进行存储，则对应 `0x78 0x56 0x34 0x12`。

不过市面上大多数的数码相机似乎都是使用的 intel 的 little-endian：

- Ricoh 使用 big-endian；
- Sony 旗下的除了 D700 都是使用 little-endian；
- Kodak 的 DC200／210／240 使用 big-edian，而 DC220／260 使用 PowerPC 却仍旧是 little-endian。

因此，每次我们想从图像文件获取 Exif 信息的时候，都必须确认其自己的对齐方式。虽然 JPEG 只采用了 Motorola 的 big-endian 字节顺序，但 little-edian 和 big-endian 在 Exif 中都可以使用。完全不明白为什么 Exif 为什么不将字节的对齐方法修正为 Motorola 的 big-endian 方式。

接下来的 2 个字节是 2 个字节长的 `0x002A`，如果是 intel 的 little-endian，则为 `0x2A`, `0x00`；如果是 Motorola 的 big-endian，则是 `0x00`，`0x2A`。

TiFF header 中包含 8 个字节，除去上面提到四个字节，剩下的四个字节是相对于第一个 IFD（Image File Directory 图像文件目录） 的偏移量。这个偏移量的计算包含了从 TIFF header 中的第一个字节，即从「II」或者「MM」，而该偏移量结束之后往往紧跟着的就是 IFD ，所以这个偏移量的值（一般情况下）是 `0x00000008`。

Byte Align
Tag Marker
Offset to first IFD
「II」或者「MM」
[object Object]
[object Object]

#### IFD：Image file directory

在 TIFF header 之后的是包含了图像信息的 IFD，image file directory（可以大致翻译为：图像文件目录）。 对照下表，可以对其结构有个大概的认识。最前面的两个字节 `EEEE` 表示了当前「图像文件目录」中所包含的目录实体的数量。之后是图像目录实体本身，每一个目录的长度是 12 个字节。在最后一个目录实体中，有长度为 4 个字节的数据（表中的 `LLLLLLLL`），它表示相对于相对于下一个目录试题的字节偏移量。而如果这个偏移量是 `0x00000000`，则意味着这是 IFD 中的最后一个目录实体。

 ![LuKxG0.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/026ba568723d0b745d262ed67396649f.png)

以上表格中：

- `TTTT`（2 个字节）表示的是 Tag number，表示一种类型的数据；
- `ffff`（2 个字节）表示数据的格式；
- `NNNNNNNN` （4 个字节）表示所组成元素的数量；
- `DDDDDDDD` （4 个字节）表示所包含数据的长度，或者是数据存储地址的偏移量。

数据格式（Data format） 上表中 ffff 对应数据的格式如下表所示。rational 表示一个分数，它包含两个signed/unsigned long integer值并且第一个为分子，第二个为分母。

 ![WkhDj6.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/1e4456258c30bc525ace07828e31eec1.png)

将 `Bytes/component` 的数值乘以 `NNNNNNNN` 可以得到全部数据的字节长度。（ a ‘bytes/components’ value * number of component stored ‘NNNNNNNN’ = total data byte length）

- 如果全部数据的字节长度小于 4 个字节，`DDDDDDDD` 区域就包含着当个标签对应的值；
- 如果数据的字节长度大于于 4 个字节，`DDDDDDDD` 中的值指的是数据地址的偏移量。

#### IFD data structure

在 Exif 格式中，第一个图像文件目录（IFD）是 IFD0（主图像的 IFD），之后是 IFD1（缩略图的 IFD），接着图像文件目录链（IFD link）结束。IFD0/IFD1 中没有快门速度（shutter speed），焦距（focal length）等任何关于数码相机的信息。IFD0 有一个特别的标签（Tag）Exif Offset（0x8769），在这个标签中是 Exif SubIFD 的偏移量。Exif SubIFD 的数据格式也是 IFD 的数据格式，它包含了数码相机的相关信息。

例，如果 TIFF 的第一部分的数据如下：

	0000: 49 49 2A 00 08 00 00 00-02 00 1A 01 05 00 01 00
	0010: 00 00 26 00 00 00 69 87-04 00 01 00 00 00 11 02
	0020: 00 00 40 00 00 00 48 00-00 00 01 00 00 00

 ![42Rxl5.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/7ebd1115a734399310f331e5472df553.png)

则其中的数据可以按照以下步骤（方法）来读取：

- `0x0000 ~ 0x0001` 是 `49 49`，相当于「ii」，可以判断为 Intel 的 little-endian 对齐方式；
- `0x0004 ~ 0x0007` 是 `0x08 00 00 00`，IFD0 就是从 `0x00000008` 开始；
- `0x0008 ~ 0x0009` 是 `0x02 00`，那么 IFD0 种图像目录实体的数量就是 2；
- `0x000a ~ 0x000b` 是 `0x1A 01`，它代表 XResolution 标签，`0x001A`，包含了图像文件水平像素值（horizontal resolution of image）
- `0x000c ~ 0x000d` 是 `0x05 00`，数值表现的值 unsigned rational。
- `0x000e ~ 0x0011` 是 `0x01 00 00 00`，包含的元素数量是 1，unsigned relational 的数据长度是每个元素 8 个字节（8 bytee/components），所以所有数据的总长度是 1 * 8 = 8 bytes。数据总长度大于 4 个字节，所以接下来的 4 个字节是数据的偏移量。
- `0x0012 ~ 0x0015` 是 `0x26 00 00 00`，即水平分辨率（XResolutation）的数据存储在 0x0026；
- `0x0026 ~ 0x0029` 是 `0x48 00 00 00`，分子是 72；`0x00 2a ~ 0x00 2d` 是 `0x01 00 00 00`，分母是 1；所以水平分辨率（XResoultion）是 72/1。
- `0x0016 ~ 0x0017` 是 `0x69 87`，下一个标签是 Exif 偏移量（ExifOffset，0x8769），值是 Exif SubIFD 的偏移量。 数据结构是 0x0004，unsigned long integer；
- 这个 tag 只有一个 component，unsigned long integer 的 4 bytes/components，所以数据的总长度是 4 个字节，等于四个字节的情况，那么之后的四个字节就是 ExifSubIFD 的偏移量；
- `0x001e~0x0021` 是 `0x11020000`，所以 ExifSubIFD 从 `0x0211` 开始；
- 这是当前 IFD 的最后一个 entry，之后的四个字节代表了「到下一个 IFD」的偏移量；
- `0x0022~0x0025` 是 `0x40000000`, 所以下一个 IFD 开始的位置是 `0x0040`。

* * *

1. 这里补充一个 hack，如果在 HTML 中创建一个 iframe，再从中引用这张 img，图片会以正确的方向显示。 [↩](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fnref:1)

2. Exif Orientation 这一部分参考、翻译自《[The most evil feature ever conceived: the Exif Orientation Tag](http://keyj.emphy.de/exif-orientation-rant/)》。 [↩](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fnref:2)

3. 出自 [PDF：Exif Version 2.3](http://www.cipa.jp/std/documents/e/DC-008-2012_E.pdf) 的第三十页 ，《4.6.4 TIFF Rev. 6.0 Attribute Information》。 [↩](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fnref:3)

4. 出自 [PDF：Exif Version 2.3](http://www.cipa.jp/std/documents/e/DC-008-2012_E.pdf) 的第三十二页。 [↩](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fnref:4)

5. 出自 [PDF：Exif Version 2.3](http://www.cipa.jp/std/documents/e/DC-008-2012_E.pdf) 的第三十五页，《Relationship between the orientation tag and rotation processing to display image data on a screen》。 [↩](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fnref:5)

6. 参考文章中说，Exif 的 Orientation 的值为 2, 5, 4, 7 的时候属于 rare case，测试完全不会出现在手持设备的拍摄图片中，任何角度的前置后置摄像图拍摄的图片都没这几个值。 [↩](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fnref:6)

7. 旋转角度（Orientation Tag）这一块理解起来有点抽象，参考《[ImpulseAdventure - JPEG / Exif Orientation and Rotation](http://www.impulseadventure.com/photo/exif-orientation.html)》和《[图片Exif 信息中Orientation的理解和对此的处理](http://www.aichengxu.com/other/11170249.htm)》。 [↩](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fnref:7)

8. [CodePen](https://codepen.io/movii/pen/MJzRYr) 测试的时候，不一定每张图都有 Exif 信息，或者各家厂商写入会不会格式不同我没兼容到错误，可以前去 [图虫 EXIF 查看器 alpha 版](https://exif.cn/) 查看图片本身是否有信息，Orientation 信息一般都是在 IFD0 中。 [↩](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fnref:8)

9. 除了证明 Exif Orientation 值确实被提取出来的 CodePen 之外，还制作了一个根据不同 Orientation 值来对图片进行对应旋转、镜像的 Codepen：[ctx.transform](https://codepen.io/movii/pen/RKdWOe/)  [↩](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fnref:9)

10. 推荐个软件 Hex Friend，debug 这些二进制数据读取操作挺有帮助的；cmd+L 定位到 offset，cmd + F 寻找 text 或者 hex 内容。知乎上找到一个[答案](https://www.zhihu.com/question/25523839/answer/49410338)，对JPEG、APPn、IFD 的结构也说得挺好，提到了一个 windows 平台的软件 [MagicEXIF](http://www.magicexif.com/)，打开图片可以得到比较直观的感受）。 [↩](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fnref:10)

11. 参考《[JPEG JFIF](https://www.w3.org/Graphics/JPEG/)》。 [↩](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/#fnref:11)

#### 感谢阅读

你们好，

2018 年初把小站从 Jekyll 迁移到 Hugo 的过程中，删除了评论区放的 Disqus 插件，考虑有二：首先无论评论、还是对笔记内容的进一步讨论，读者们更喜欢通过邮件、或者 Twitter 私信的方式来沟通；其次一年多以来 Disqus 后台能看到几乎都是垃圾留言（spam），所以这里直接贴一下[邮件](https://moxo.io/blog/2017/03/21/using-javascript-to-read-orientation-value-inside-jpeg-file/mailto:mo.strangeline@gmail.com)、以及 [Twitter 账户](https://twitter.com/movii_0) 地址。

技术发展迭代很快，所以这些笔记内容也有类似新闻的时效性，不免有过时、或者错误的地方，欢迎指正 ^_^。

BEST
Lien（A.K.A 胡椒）