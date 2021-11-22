[Post@https://ryan-miao.github.io](https://ryan-miao.github.io/2017/06/26/java-utf8-iso-%E4%B9%B1%E7%A0%81%E6%A0%B9%E6%BA%90/) 测试代码https://github.com/Ryan-Miao/someTest/commit/50241e50d4b6ecdb8820e58f4cb9628bfb7d77ec

还是多语言, 在项目中遇到本地环境和服务端环境不一致乱码的情形。因此需要搞清楚乱码产生的过程，来分析原因。

获取多语言代码如下：

```
private Map<String, String\> getLocalizationContent(Locale locale) {
    ResourceBundle bundle \= ResourceBundle.getBundle(this.resourceBundleName, Locale.US);
    ResourceBundle bundleLocale \= ResourceBundle.getBundle(this.resourceBundleName, locale);
    Set<String\> keys \= bundle.keySet();
    Map<String, String\> map \= new HashMap();

    String key;
    String translation;
    for(Iterator var6 \= keys.iterator(); var6.hasNext(); map.put(key, translation)) {
        key \= (String)var6.next();

        try {
            translation \= bundleLocale.getString(key);
            translation \= new String(translation.getBytes("ISO-8859-1"), "UTF-8");
            translation \= this.escapeStringForJavaScript(translation);
        } catch (UnsupportedEncodingException | MissingResourceException var10) {
            translation \= bundle.getString(key);
        }
    }

    return map;
}
```

其中，因为`ResourceBundle`通过`PropertyResourceBundle`读取`properties`文件。 这就要看以哪种方式load Properties了。提供了两种构造函数：

```
public PropertyResourceBundle (InputStream stream) throws IOException {
    Properties properties \= new Properties();
    properties.load(stream);
    lookup \= new HashMap(properties);
}
public PropertyResourceBundle (Reader reader) throws IOException {
    Properties properties \= new Properties();
    properties.load(reader);
    lookup \= new HashMap(properties);
}
```

通过跟踪`ResourceBundle.getBundle(this.resourceBundleName, locale);`源码发现创建bundle的方法为：

```
public ResourceBundle newBundle(String baseName, Locale locale, String format,
                                        ClassLoader loader, boolean reload)
                    throws IllegalAccessException, InstantiationException, IOException {
    String bundleName \= toBundleName(baseName, locale);
    ResourceBundle bundle \= null;
    if (format.equals("java.class")) {
        try {
            @SuppressWarnings("unchecked")
            Class<? extends ResourceBundle\> bundleClass
                \= (Class<? extends ResourceBundle\>)loader.loadClass(bundleName);

            
            
            if (ResourceBundle.class.isAssignableFrom(bundleClass)) {
                bundle \= bundleClass.newInstance();
            } else {
                throw new ClassCastException(bundleClass.getName()
                             + " cannot be cast to ResourceBundle");
            }
        } catch (ClassNotFoundException e) {
        }
    } else if (format.equals("java.properties")) {
        final String resourceName \= toResourceName0(bundleName, "properties");
        if (resourceName \== null) {
            return bundle;
        }
        final ClassLoader classLoader \= loader;
        final boolean reloadFlag \= reload;
        InputStream stream \= null;
        try {
            stream \= AccessController.doPrivileged(
                new PrivilegedExceptionAction<InputStream\>() {
                    public InputStream run() throws IOException {
                        InputStream is \= null;
                        if (reloadFlag) {
                            URL url \= classLoader.getResource(resourceName);
                            if (url != null) {
                                URLConnection connection \= url.openConnection();
                                if (connection != null) {
                                    
                                    
                                    connection.setUseCaches(false);
                                    is \= connection.getInputStream();
                                }
                            }
                        } else {
                            is \= classLoader.getResourceAsStream(resourceName);
                        }
                        return is;
                    }
                });
        } catch (PrivilegedActionException e) {
            throw (IOException) e.getException();
        }
        if (stream != null) {
            try {
                bundle \= new PropertyResourceBundle(stream);
            } finally {
                stream.close();
            }
        }
    } else {
        throw new IllegalArgumentException("unknown format: " + format);
    }
    return bundle;
}
```

也就是说，最终通过`properties.load(stream);`的方法读取properties文件的。

> The load(Reader) / store(Writer, String) methods load and store properties from and to a character based stream in a simple line-oriented format specified below. The load(InputStream) / store(OutputStream, String) methods work the same way as the load(Reader)/store(Writer, String) pair, except the input/output stream is encoded in ISO 8859-1 character encoding. Characters that cannot be directly represented in this encoding can be written using Unicode escapes as defined in section 3.3 of The Java™ Language Specification; **only a single 'u' character is allowed in an escape sequence**. The native2ascii tool can be used to convert property files to and from other character encodings.

```
@Test
public void unicodeToChar(){
    char aChar \= '\\u4E2D';
    Assert.assertEquals('中', aChar);

    String aStr \= "\\u4E2D\\u6587";
    Assert.assertEquals("中文", aStr);

}
```

根据官方文档，使用Unicode转义可以识别中文字符的。按照之前本地的表现，Properties文件以中文原样书写，并且文件字符集为utf8,生成字节流的时候中文肯定会变成多个字节。这样系统读取之后的字符是不对的。需要再次使用utf8编码为正确的字符。而服务端的表现是：不需要再次编码，读出来的字符就是正确的。那么就可以证明服务端的Properties文件的中文经过了转义，或者读取的时候进行了转义。目前本地和服务端的唯一区别就是系统。一个是打包的过程，本地编译是否和服务端编译不同？一个是服务端的jvm，到现在没搞清楚服务端jvm的版本。看消息说，java9可以支持直接使用中文而不用转码了。

所以, 问题的根源找到了： 先证明打包是否有问题--将服务端的包在本地跑一下。然后验证服务端的jvm是否有直接读取utf8的能力---编写一个简单的读写code。

找问题的时候找了很久，经过高人指导后又静心查阅了编码的资料才能融会贯通。以下是查资料时整理的对理解编码和乱码有用的文章。

* * *

目前看到两种乱码：问号和ISO符号乱码。

以下内容转载自[深入分析 Java 中的中文编码问题](https://www.ibm.com/developerworks/cn/java/j-lo-chinesecoding/index.html), 作者：许令波，发表时间：2011 年 7 月 06 日。

1.1 结论放在开头
----------

1.  `iso-8859-1`以一个字节(1 byte)存储字符。即字符`a`存储为一个字节，即8位(8 bit)。
2.  `utf-8`变长字节存储字符，最小单位是一个字节。`iso-8859-1`正好相当于`utf-8`的一个单位。因此，将以`utf-8`编码的字节流用`iso-8859-1`的方式读取后字符乱码但信息不丢失，只需要将字符还原成byte数组(`str.getBytes("ISO-8859-1")`)，重新以`utf-8`读取(`new String(byte[], "UTF-8")`)即可。

1.2 为什么要编码，我们认知的符号地如何存在的
------------------------

### 1.2.1 java中的编码

1.  计算机中存储信息的最小单元是一个字节即 8 个 bit，所以能表示的字符范围是 0~255 个
2.  人类要表示的符号太多，无法用一个字节来完全表示
3.  要解决这个矛盾必须需要一个新的**数据结构 char(16bit, 2byte)**，从 char 到 byte 必须编码

### 1.2.2 几个重要的编码

**ASCII** （发音： /ˈæski/ ass-kee\[1\]，American Standard Code for Information Interchange，美国信息交换标准代码）是基于拉丁字母的一套电脑编码系统。它主要用于显示现代英语，而其扩展版本EASCII则可以部分支持其他西欧语言，并等同于国际标准ISO/IEC 646。至今为止共定义了128个字符。

> 用一个字节的低 7 位表示，0~31 是控制字符如换行回车删除等；32~126 是打印字符，可以通过键盘输入并且能够显示出来。

**ISO 8859-1** 正式编号为ISO/IEC 8859-1:1998，又称Latin-1或“西欧语言”，是国际标准化组织内ISO/IEC 8859的第一个8位字符集。它以ASCII为基础，在空置的0xA0-0xFF的范围内，加入96个字母及符号，藉以供使用附加符号的拉丁字母语言使用。

> ISO-8859-1 仍然是单字节编码，它总共能表示 256 个字符。

**GB2312**

> 它的全称是《信息交换用汉字编码字符集 基本集》，它是双字节编码，总的编码范围是 A1-F7，其中从 A1-A9 是符号区，总共包含 682 个符号，从 B0-F7 是汉字区，包含 6763 个汉字。

**GBK**

> 全称叫《汉字内码扩展规范》，是国家技术监督局为 windows95 所制定的新的汉字内码规范，它的出现是为了扩展 GB2312，加入更多的汉字，它的编码范围是 8140~FEFE（去掉 XX7F）总共有 23940 个码位，它能表示 21003 个汉字，它的编码是和 GB2312 兼容的，也就是说用 GB2312 编码的汉字可以用 GBK 来解码，并且不会有乱码。

**UTF-16**

> 具体定义了 Unicode 字符在计算机中存取方法。UTF-16不是定长两字节，它是变长，有二或四字节，Unicode的码点最大已经到了U+10FFFF. 转化格式，这个是定长的表示方法，不论什么字符都可以用两个字节表示，两个字节是 16 个 bit，所以叫 UTF-16。UTF-16 表示字符非常方便，每两个字节表示一个字符，这个在字符串操作时就大大简化了操作，这也是 **Java 以 UTF-16 作为内存的字符存储格式的一个很重要的原因**。

**Unicode**（中文：万国码、国际码、统一码、单一码）是计算机科学领域里的一项业界标准。它对世界上大部分的文字系统进行了整理、编码，使得电脑可以用更为简单的方式来呈现和处理文字。 在表示一个_Unicode的字符_时，通常会用“U+”然后紧接着一组十六进制的数字来表示这一个字符。在基本多文种平面（英文：Basic Multilingual Plane，简写BMP。又称为“零号平面”、plane 0）里的所有字符，要用四个数字（即两个char,16bit ,例如U+4AE0，共支持六万多个字符）；在零号平面以外的字符则需要使用五个或六个数字。旧版的Unicode标准使用相近的标记方法，但却有些微小差异：在Unicode 3.0里使用“U-”然后紧接着八个数字，而“U+”则必须随后紧接着四个数字。

**UTF-8（8-bit Unicode Transformation Format**）

> UTF-16 统一采用两个字节表示一个字符，虽然在表示上非常简单方便，但是也有其缺点，有很大一部分字符用一个字节就可以表示的现在要两个字节表示，存储空间放大了一倍，在现在的网络带宽还非常有限的今天，这样会增大网络传输的流量，而且也没必要。而 UTF-8 采用了一种变长技术，每个编码区域有不同的字码长度。不同类型的字符可以是由 1~6 个字节组成。

UTF-8 有以下编码规则：

1.  如果一个字节，最高位（第 8 位）为 0，表示这是一个 ASCII 字符（00 - 7F）。可见，所有 ASCII 编码已经是 UTF-8 了。
2.  如果一个字节，以 11 开头，连续的 1 的个数暗示这个字符的字节数，例如：110xxxxx 代表它是双字节 UTF-8 字符的首字节。
3.  如果一个字节，以 10 开始，表示它不是首字节，需要向前查找才能得到当前字符的首字节

### 1.2.3 java中编码的流程

#### 1.2.3.1 什么时候需要编码

将字符转换为字节，以及将字节转换字符的时候。

#### 1.2.3.2 Java在什么时候编码

通过I/O读写的时候，以及自定义转码的时候。I/O又区分为磁盘I/O和网络I/O。

java中关于编码有**字节流**和**字符流**。最初学java的时候肯定不去想为啥搞这东西。等用的时候才发现真是有用的。

字节流就是可以理解为byte数组, 一个byte就是一个字节，一个字节等于8位, 即8个0和1的二进制，也即两位的十六进制（FF）。ISO的编码就是基于单字节的，每个字节都可以映射为一个字符。

字符流当然就是面向字符的。这个是在字节流之上做了重组。字符流的最小单位是一个字符，可以理解为char数组。`a`和`中`都是一个字符，但如果用字节表示的话，`a`是一个字节，`中`是两个。

下面介绍字节流和字符流的交互。

#### 1.2.3.3 Java中的I/O流程

`Reader`是Java IO中读取字符的父类，`InputStream`是读取字节的父类，`InputStreamReader`是字节到字符的桥梁，具体通过`StreamDecoder`实现。其中`StreamDecoder`需要指定Charset编码格式，如果用户不指定，则采用本地环境默认字符集。

`Writer`是写字符的父类，`OutputStream`是写字节的父类，`OutputStreamWriter`是字符到字节的桥梁。

![](https://ask.qcloudimg.com/http-save/yehe-1158094/ox64op842y.png?imageView2/2/w/1620)

![](https://ask.qcloudimg.com/http-save/yehe-1158094/ox64op842y.png?imageView2/2/w/1620)

![](https://ask.qcloudimg.com/http-save/yehe-1158094/liijmj6fqo.png?imageView2/2/w/1620)

demo:

```
@Test
public void test\_write\_read\_encoding() throws IOException {
    String file \= this.getClass().getClassLoader().getResource("").getPath()+File.separator+"test.txt";
    String charset \= "UTF-8";

    
    FileOutputStream outputStream \= new FileOutputStream(file);
    OutputStreamWriter writer \= new OutputStreamWriter(
            outputStream, charset);
    try {
        writer.write("这是要保存的中文字符");
    } finally {
        writer.close();
    }

    
    FileInputStream inputStream \= new FileInputStream(file);
    InputStreamReader reader \= new InputStreamReader(
            inputStream, charset);

    StringBuilder sb \= new StringBuilder();

    int charRead \= reader.read();
    while (charRead != \-1){
        sb.append((char) charRead);
        charRead \= reader.read();
    }

    System.out.println(sb.toString());
}
```

文章最初的乱码是因为write的时候是以`utf-8`编码，而读取的时候按照`iso-8859-1`解码。这时候乱码就是：`è¿™æ˜¯è¦ä¿å­˜çš„ä¸­æ–‡å­—ç¬¦`。

#### 1.2.3.4 内存中的编码

除了读写文件，还可以在内存中转换编码。

```
@Test
public void testConvert() throws UnsupportedEncodingException {
    String s \= "这是一段中文字符串";
    byte\[\] b \= s.getBytes("UTF-8");
    String utf8 \= new String(b,"UTF-8");
    String iso \= new String(b,"iso-8859-1");
    Assert.assertEquals(s, utf8);
    Assert.assertEquals("è¿\\u0099æ\\u0098¯ä¸\\u0080æ®µä¸\\u00ADæ\\u0096\\u0087å\\u00AD\\u0097ç¬¦ä¸²", iso);
}
@Test
public void testEncodingCharSet(){
    String aStr \= "中文";
    Charset charset \= Charset.forName("UTF-8");
    ByteBuffer byteBuffer \= charset.encode(aStr);
    CharBuffer charBuffer \= charset.decode(byteBuffer);

    Assert.assertEquals(aStr, charBuffer.toString());
}
```

#### 1.2.3.5 java如何编码

通过实例分析编码过程。

```
@Test
public void testEncoder(){
        String name \= "I am 君山";

    char\[\] chars \= name.toCharArray();
    for (char c : chars) {
        System.out.printf(c +"（"+(int)c+ "）=" + Integer.toHexString(c) +" | ");
    }
    System.out.println();

    try {
            byte\[\] iso8859 \= name.getBytes("ISO-8859-1");
            System.out.println("iso:");
            toHex(iso8859);

            byte\[\] utf8 \= name.getBytes("UTF-8");
            System.out.println("utf8:");
            toHex(utf8);

            byte\[\] gb2312 \= name.getBytes("GB2312");
            System.out.println("gb2312:");
            toHex(gb2312);

            byte\[\] gbk \= name.getBytes("GBK");
            System.out.println("gbk:");
            toHex(gbk);

            byte\[\] utf16 \= name.getBytes("UTF-16");
            System.out.println("utf16:");
            toHex(utf16);

        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

}

private void toHex(byte\[\] data) {
    for (byte b: data){
        byte\[\] bytes \= {b};
        System.out.printf(Hex.encodeHexString(bytes) + "           | ");
    }
    System.out.println();
}
```

注释：

1.  java中char转换成int是因为char是16位的，int是32位，强转不丢失。
2.  char转换成int的数值表示什么？明天去看看java编程思想，应该是该字符在Unicode字符集中的排序位置。
3.  本实例中将char转换的数值转为16进制(Hex)来代表这个字符。比如`君`的int值为`21531`,转换成16进制为`541b`。而`君`的Unicode也正好是`\u541b`。所以，**++Java中char是通过存储字符的16进制的数值来表示该字符的++**。

**java编码需要用的类图**：

![](https://ask.qcloudimg.com/http-save/yehe-1158094/hh3al8xzmb.png?imageView2/2/w/1620)

首先根据`Charset.forName(charsetName)`查找`Charset`，然后创建`CharsetEncoder`, 最后调用`CharsetEncoder.encode`进行编码。其中`UTF-8`等编码子类中内部类`Encoder`都继承了`CharsetEncoder`。

`String. getBytes(charsetName)`时序图:

![](https://ask.qcloudimg.com/http-save/yehe-1158094/1brv1j3be2.jpeg?imageView2/2/w/1620)

下面分析字符串编码的具体过程： 首先，控制台输出内容：

```
I（73）\=49 |  （32）\=20 | a（97）\=61 | m（109）\=6d |  （32）\=20 | 君（21531）\=541b | 山（23665）\=5c71 | 
iso:
49           | 20           | 61           | 6d           | 20           | 3f           | 3f           | 
utf8:
49           | 20           | 61           | 6d           | 20           | e5           | 90           | 9b           | e5           | b1           | b1           | 
gb2312:
49           | 20           | 61           | 6d           | 20           | be           | fd           | c9           | bd           | 
gbk:
49           | 20           | 61           | 6d           | 20           | be           | fd           | c9           | bd           | 
utf16:
fe           | ff           | 00           | 49           | 00           | 20           | 00           | 61           | 00           | 6d           | 00           | 20           | 54           | 1b           | 5c           | 71           | 
```

对应关系如下图,具体规则请参考原文，这里只share图：

![](https://ask.qcloudimg.com/http-save/yehe-1158094/knugibsop7.gif)

> 从上图看出 7 个 char 字符经过 ISO-8859-1 编码转变成 7 个 byte 数组，ISO-8859-1 是单字节编码，中文“君山”被转化成值是 3f 的 byte。3f 也就是“？”字符，所以经常会出现中文变成“？”很可能就是错误的使用了 ISO-8859-1 这个编码导致的。中文字符经过 ISO-8859-1 编码会丢失信息，通常我们称之为“黑洞”，它会把不认识的字符吸收掉。由于现在大部分基础的 Java 框架或系统默认的字符集编码都是 ISO-8859-1，所以很容易出现乱码问题，后面将会分析不同的乱码形式是怎么出现的。

![](https://ask.qcloudimg.com/http-save/yehe-1158094/i4dyn3pl8a.gif)

> UTF-8 对单字节范围内字符仍然用一个字节表示，对汉字采用三个字节表示。UTF-8 编码与 GBK 和 GB2312 不同，不用查码表，所以在编码效率上 UTF-8 的效率会更好，所以在存储中文字符时 UTF-8 编码比较理想

![](https://ask.qcloudimg.com/http-save/yehe-1158094/0l1gduqqmr.gif)

![](https://ask.qcloudimg.com/http-save/yehe-1158094/nk2slxkns2.gif)

#### 1.2.3.6 几种编码比较

对中文字符后面四种编码格式都能处理，GB2312 与 GBK 编码规则类似，但是 GBK 范围更大，它能处理所有汉字字符，所以 GB2312 与 GBK 比较应该选择 GBK。UTF-16 与 UTF-8 都是处理 Unicode 编码，它们的编码规则不太相同，相对来说 UTF-16 编码效率最高，字符到字节相互转换更简单，进行字符串操作也更好。它适合在本地磁盘和内存之间使用，可以进行字符和字节之间快速切换，如 Java 的内存编码就是采用 UTF-16 编码。但是它不适合在网络之间传输，因为网络传输容易损坏字节流，一旦字节流损坏将很难恢复，想比较而言 UTF-8 更适合网络传输，对 ASCII 字符采用单字节存储，另外单个字符损坏也不会影响后面其它字符，在编码效率上介于 GBK 和 UTF-16 之间，所以 UTF-8 在编码效率上和编码安全性上做了平衡，是理想的中文编码方式。

### 1.2.4 继续举例分析字符在java中的乱码情况

你是否考虑过，当我们在电脑中某个文本编辑器里输入某个汉字时，它到底是怎么表示的？我们知道，计算机里所有的信息都是以 01 表示的，那么一个汉字，它到底是多少个 0 和 1 呢？我们能够看到的汉字都是以字符形式出现的，例如在 Java 中“淘宝”两个字符，它在计算机中的数值 10 进制是 28120 和 23453，16 进制是 6bd8 和 5d9d，也就是这两个字符是由这两个数字唯一表示的。Java 中一个 char 是 16 个 bit 相当于两个字节，所以两个汉字用 char 表示在内存中占用相当于四个字节的空间。

#### 1.2.4.1 中文变成了看不懂的字符, 一个汉字变成两个乱码字符

例如，字符串“淘！我喜欢！”变成了“Ì Ô £ ¡Î Ò Ï²»¶ £ ¡”编码过程如下图所示

![](https://ask.qcloudimg.com/http-save/yehe-1158094/1mxnysrulo.gif)

#### 1.2.4.2 一个汉字变成一个问号

![](https://ask.qcloudimg.com/http-save/yehe-1158094/lzt41jcv3y.gif)

#### 1.2.4.3 一个汉字变成两个问号

![](https://ask.qcloudimg.com/http-save/yehe-1158094/wnkv2ulplj.gif)

#### 1.2.4.4 不应该这样编码，即使结果是正确的

```
String value \= request.getParameter(name);

String value \= String(request.getParameter(name).getBytes("
ISO\-8859\-1"), "GBK"); 
```

![](https://ask.qcloudimg.com/http-save/yehe-1158094/zg6ije0bai.gif)

这种情况是这样的，ISO-8859-1 字符集的编码范围是 0000-00FF，正好和一个字节的编码范围相对应。这种特性保证了使用 ISO-8859-1 进行编码和解码可以保持编码数值“不变”。虽然中文字符在经过网络传输时，被错误地“拆”成了两个欧洲字符，但由于输出时也是用 ISO-8859-1，结果被“拆”开的中文字的两半又被合并在一起，从而又刚好组成了一个正确的汉字。虽然最终能取得正确的汉字，但是还是不建议用这种不正常的方式取得参数值，因为这中间增加了一次额外的编码与解码，这种情况出现乱码时因为 Tomcat 的配置文件中 useBodyEncodingForURI 配置项没有设置为”true”，从而造成第一次解析式用 ISO-8859-1 来解析才造成乱码的。

### 1.3 java web的一些编码知识

#### 1.3.1 URL的编码和解码

首先，估计绝大部分搞web的不一定说的出URL的组成部分是啥：

![](https://ask.qcloudimg.com/http-save/yehe-1158094/s5hdsywhgn.gif)

上图中以 Tomcat 作为 Servlet Engine 为例，它们分别对应到下面这些配置文件中： Port 对应在 Tomcat 的`<Connector port="8080"/>` 中配置，而 Context Path 在`<Context path="/examples"/>`中配置，Servlet Path 在 Web 应用的 `web.xml`中的

```
<servlet\-mapping\> 
       <servlet\-name\>junshanExample</servlet\-name\> 
       <url\-pattern\>/servlets/servlet
```

`<url-pattern>` 中配置，PathInfo 是我们请求的具体的 Servlet，QueryString 是要传递的参数，注意这里是在浏览器里直接输入 URL 所以是通过 Get 方法请求的，如果是 POST 方法请求的话，QueryString 将通过表单方式提交到服务器端。

上图中 PathInfo 和 QueryString 出现了中文，当我们在浏览器中直接输入这个 URL 时，在浏览器端和服务端会如何编码和解析这个 URL 呢？为了验证浏览器是怎么编码 URL 的我们选择 FireFox 浏览器并通过 HTTPFox 插件观察我们请求的 URL 的实际的内容，以下是 URL：[HTTP://localhost:8080/examples/servlets/servlet/](http://localhost:8080/examples/servlets/servlet/) 君山 ?author= 君山在中文 FireFox3.6.12 的测试结果 君山的编码结果分别是：`e5 90 9b e5 b1 b1，be fd c9 bd`，查阅上一届的编码可知，PathInfo 是 UTF-8 编码而 QueryString 是经过 GBK 编码，至于为什么会有“%”？查阅 URL 的编码规范 RFC3986 可知**浏览器编码 URL 是将非 ASCII 字符按照某种编码格式编码成 16 进制数字然后将每个 16 进制表示的字节前加上++“%”**，++所以最终的 URL 就成了上图的格式了。

默认情况下中文 IE 最终的编码结果也是一样的，不过 IE 浏览器可以修改 URL 的编码格式在选项 -> 高级 -> 国际里面的发送 UTF-8 URL 选项可以取消。 从上面测试结果可知浏览器对 PathInfo 和 QueryString 的编码是不一样的，不同浏览器对 PathInfo 也可能不一样，这就对服务器的解码造成很大的困难，下面我们以 Tomcat 为例看一下，Tomcat 接受到这个 URL 是如何解码的。 解析请求的 URL 是在 org.apache.coyote.HTTP11.InternalInputBuffer 的 parseRequestLine 方法中，这个方法把传过来的 URL 的 byte\[\] 设置到 org.apache.coyote.Request 的相应的属性中。这里的 URL 仍然是 byte 格式，转成 char 是在 org.apache.catalina.connector.CoyoteAdapter 的 convertURI 方法中完成的：

```
protected void convertURI(MessageBytes uri, Request request) throws Exception { 
       ByteChunk bc \= uri.getByteChunk(); 
       int length \= bc.getLength(); 
       CharChunk cc \= uri.getCharChunk(); 
       cc.allocate(length, \-1); 
       String enc \= connector.getURIEncoding(); 
       if (enc != null) { 
           B2CConverter conv \= request.getURIConverter(); 
           try { 
               if (conv \== null) { 
                   conv \= new B2CConverter(enc); 
                   request.setURIConverter(conv); 
               } 
           } catch (IOException e) {...} 
           if (conv != null) { 
               try { 
                   conv.convert(bc, cc, cc.getBuffer().length \- cc.getEnd()); 
                   uri.setChars(cc.getBuffer(), cc.getStart(), cc.getLength()); 
                   return; 
               } catch (IOException e) {...} 
           } 
       } 
       
       byte\[\] bbuf \= bc.getBuffer(); 
       char\[\] cbuf \= cc.getBuffer(); 
       int start \= bc.getStart(); 
       for (int i \= 0; i < length; i++) { 
           cbuf\[i\] \= (char) (bbuf\[i + start\] & 0xff); 
       } 
       uri.setChars(cbuf, 0, length); 
}
```

从上面的代码中可以知道对 URL 的 URI 部分进行解码的字符集是在 connector 的`<Connector URIEncoding=”UTF-8”/>`中定义的，如果没有定义，那么将以默认编码 ISO-8859-1 解析。所以**如果有中文 URL 时最好把 URIEncoding 设置成 UTF-8 编码**。

**QueryString 又如何解析？**

GET 方式 HTTP 请求的 QueryString 与 POST 方式 HTTP 请求的表单参数都是作为 Parameters 保存，都是通过 request.getParameter 获取参数值。对它们的解码是在 request.getParameter 方法第一次被调用时进行的。request.getParameter 方法被调用时将会调用 org.apache.catalina.connector.Request 的 parseParameters 方法。这个方法将会对 GET 和 POST 方式传递的参数进行解码，但是它们的解码字符集有可能不一样。POST 表单的解码将在后面介绍，**QueryString 的解码字符集是在哪定义的呢？它本身是通过 HTTP 的 Header 传到服务端的，并且也在 URL 中**，是否和 URI 的解码字符集一样呢？从前面浏览器对 PathInfo 和 QueryString 的编码采取不同的编码格式不同可以猜测到解码字符集肯定也不会是一致的。的确是这样 **QueryString 的解码字符集要么是 Header 中 ContentType 中定义的 Charset 要么就是默认的 ISO-8859-1**，要使用 ContentType 中定义的编码就要设置 connector 的 `<Connector URIEncoding=”UTF-8” useBodyEncodingForURI=”true”/>` 中的 `useBodyEncodingForURI` 设置为 `true`。这个配置项的名字有点让人产生混淆，它并不是对整个 URI 都采用 BodyEncoding 进行解码而**仅仅是对 QueryString 使用 BodyEncoding** 解码，这一点还要特别注意。

从上面的 URL 编码和解码过程来看，比较复杂，而且编码和解码并不是我们在应用程序中能完全控制的，所以在我们的应用程序中应该尽量避免在 URL 中使用非 ASCII字符，不然很可能会碰到乱码问题，当然在我们的服务器端最好设置 `<Connector/>` 中的 URIEncoding 和 useBodyEncodingForURI 两个参数。

**HTTP Header 的编解码**

当客户端发起一个 HTTP 请求除了上面的 URL 外还可能会在 Header 中传递其它参数如 Cookie、redirectPath 等，这些用户设置的值很可能也会存在编码问题，Tomcat 对它们又是怎么解码的呢？

对 Header 中的项进行解码也是在调用 request.getHeader 是进行的，如果请求的 Header 项没有解码则调用 MessageBytes 的 toString 方法，这个方法将从 byte 到 char 的转化使用的默认编码也是 **ISO-8859-1**，**而我们也不能设置 Header 的其它解码格式**，所以如果你设置 Header 中有非 ASCII 字符解码肯定会有乱码。

我们在添加 Header 时也是同样的道理，不要在 Header 中传递非 ASCII 字符，如果一定要传递的话，我们可以先将这些字符用 org.apache.catalina.util.URLEncoder 编码然后再添加到 Header 中，这样在浏览器到服务器的传递过程中就不会丢失信息了，如果我们要访问这些项时再按照相应的字符集解码就好了。 POST 表单的编解码在前面提到了 POST 表单提交的参数的解码是在第一次调用 request.getParameter 发生的，POST 表单参数传递方式与 QueryString 不同，它是通过 HTTP 的 BODY 传递到服务端的。当我们在页面上**点击 submit 按钮时浏览器首先将根据 `ContentType`的 `Charset` 编码格式对表单填的参数进行编码然后提交到服务器端，在服务器端同样也是用 ContentType 中字符集进行解码。** 所以通过 POST 表单提交的参数一般不会出现问题，而且这个字符集编码是我们自己设置的，可以通过 request.setCharacterEncoding(charset) 来设置。 另外针对 multipart/form-data 类型的参数，也就是上传的文件编码同样也是使用 ContentType 定义的字符集编码，值得注意的地方是上传文件是用字节流的方式传输到服务器的本地临时目录，这个过程并没有涉及到字符编码，而真正编码是在将文件内容添加到 parameters 中，如果用这个编码不能编码时将会用默认编码 ISO-8859-1 来编码。

**HTTP BODY 的编解码**

当用户请求的资源已经成功获取后，这些内容将通过 Response 返回给客户端浏览器，这个过程先要经过编码再到浏览器进行解码。这个过程的编解码字符集可以通过 response.setCharacterEncoding 来设置，它将会覆盖 request.getCharacterEncoding 的值，并且通过 Header 的 Content-Type 返回客户端，浏览器接受到返回的 socket 流时将通过 Content-Type 的 charset 来解码，如果返回的 HTTP Header 中 Content-Type 没有设置 charset，那么浏览器将根据 Html 的`<meta HTTP-equiv="Content-Type" content="text/html; charset=UTF-8" />` 中的 charset 来解码。如果也没有定义的话，那么浏览器将使用默认的编码来解码。

**其它需要编码的地方**

除了 URL 和参数编码问题外，在服务端还有很多地方可能存在编码，如可能需要读取 xml、velocity 模版引擎、JSP 或者从数据库读取数据等。 xml 文件可以通过设置头来制定编码格式

```
<?xml version\="1.0" encoding\="UTF-8"?\>
```

Velocity 模版设置编码格式：

```
services.VelocityService.input.encoding\=UTF\-8
```

JSP 设置编码格式：

```
<%@page contentType\="text/html; charset=UTF-8"%\>
```

访问数据库都是通过客户端 JDBC 驱动来完成，用 JDBC 来存取数据要和数据的内置编码保持一致，可以通过设置 JDBC URL 来制定如 [MySQL](https://cloud.tencent.com/product/cdb?from=10680)：

```
url\="jdbc:mysql://localhost:3306/DB?useUnicode=true&characterEncoding=UTF-8"
```

[Post@https://ryan-miao.github.io](https://ryan-miao.github.io/2017/06/26/java-utf8-iso-%E4%B9%B1%E7%A0%81%E6%A0%B9%E6%BA%90/)

*   [https://www.ibm.com/developerworks/cn/java/j-lo-chinesecoding/index.html](https://www.ibm.com/developerworks/cn/java/j-lo-chinesecoding/index.html)
*   [http://www.importnew.com/23963.html](http://www.importnew.com/23963.html)
*   [https://en.wikipedia.org/wiki/Unicode](https://en.wikipedia.org/wiki/Unicode)
*   [https://en.wikipedia.org/wiki/ISO/IEC\_8859-1](https://en.wikipedia.org/wiki/ISO/IEC_8859-1)
*   [https://en.wikipedia.org/wiki/ASCII](https://en.wikipedia.org/wiki/ASCII)