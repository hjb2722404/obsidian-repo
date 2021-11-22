> 这个实验，是在采用ssm框架的基础上演示的。

在前端向后端发出http请求时，有时候当我们采用GET方式时，参数会被编码在url后面。那么这个url是如何编码解码的呢？

### http请求的发出，以及编码过程

下面在chrome浏览器和postman下模拟请求，用fiddler来监控请求发出信息。

**chrome游览器地址输入**:  
![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141503.png)

这个路径是手动输入的，黑色线是url，黄色线是uri，绿色线是queryString。这时F12，然后我们**路径按下回车**。

**chrome地址**：

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141508.png)

**chrome监控**：

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141516.png)

**fiddler监控**：

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141525.png)

我们关注chrome控制台和fiddler的情况，可以发现，chrome发出这个http请求的时候，对查询参数进行了编码。我们在网站([https://www.bejson.com/conver...](https://www.bejson.com/convert/ox2str/)) 进行Hex转字符的操作，可以发现：中文字符被编码成16进制数，而且每个字节(byte)的16进制数前都被浏览器加上了一个%。（下图中，20E8B083这4个字节对应“调”，E4BC98这3个字节对应“优”）

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141530.png)

**浏览器编码url的风格：**  到这里，可能你有点迷惑了。我来解释一下，根据URL的编码规范，浏览器会把URL中的非ASCII字符按照某种编码格式（chrome是utf-8）编码成byte数组后，转成16进制数字，然后在每个16进制数字前加上%分隔。

到现在，应该清楚了浏览器GET传参时的编码过程了。值得一提的是，在实践中，我们最糟糕也只会在GET方式的url后面携带中文参数，在servletPath（也就是?前的一段）中我们不会去用中文的，除非你自找麻烦。

**具体的传输：**  其实，我们还没有讲到url的传输。我们要知道，在网络世界的传输中，所有的信息都是以字节传输的（byte\[\])，一个http请求的所有内容都是编码成byte数组后传输的，也就是0101这样的数字。为了方便显示，fiddler中用Hex来表示。可以这么理解，上面那个url路径只是一个初步处理后的string而已，我们从fiddler中查看，

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141536.png)

我们对Hex进行几次copy查看：

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141547.png)

可以看出，传输过程中的Hex数组，就是我们之前监控到的真正的http请求url经过了中文utf-8编码后的路径。

### http请求的接收，以及解码过程

#### 需不需要设置解码呢？

答案是肯定的，手动设置一下肯定是非常好的。

##### uri/url的解码过程

下面我们以tomcat为例，当上面那一大串byte数组传输到服务器后，首先，tomcat会对uri部分进行解码，这里charset由tomcat配置文件中的`<Connector URIEncoding="UTF-8"`决定，不设置的话默认值为`ISO-8859-1`。由于域名和端口只会是英文，比如说：`www.baidu.com`,`www.google.com`；同时我们上面讲过，在uri部分我们不会去用中文，我们只会采用英文。因此，对于url这一块，无论是采用`UTF-8`还是`ISO-8859-1`解码，url这部分内容都不会乱码。到这一步，我们服务器端就解码得到了`localhost:8082/article/queryByTitle`。

##### queryString的解码过程

上面，我们知道了uri/url这一块的内容解码过程。下面，我们来看看queryString这部分的解码过程。

我们在chrome中，F12查看http请求的详细信息，可以发现查询参数被作为parameters保存了下来。这里，可以告诉大家，通过GET方式发出http请求所携带的queryString以及通过POST方式发出http请求所携带的表单参数，也就是GET、POST这2种方式携带的参数，都会被作为parameters保存；在服务器端通过request.getParameter()方法可以获取到值。

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141555.png)

下面以GET方式的queryString的解码过程来讲解。首先我们思考一下，如何才能得到原来的中文呢？当然是先把Hex数字使用UTF-8转码一次，得到浏览器初步处理的参数，如：`title=JVM%20%E8%B0%83%E4%BC%98`，然后再对原来非ASCII字符的部分使用UTF-8转码一次，得到最初值：`title=JVM 调优`。中文这一块我也没找到相关资料，我就分析一下英文的解码过程吧。

###### 1.英文参数的情况

假设我们原有的请求并不含中文参数，比如说：`title=JVMoptimize` 。那么在服务器端调用request.getParameter的方法时，会先进行转码，而charset由http请求的header中的contentType决定，否则使用`ISO-8859-1`。要想使用contentType的charset，还需要把`<Connector URIEncoding="UTF-8" useBodyEncodingForURI="true" />`设置为true，注意，true只是设置queryString的解码。到这里，对Hex的解码就会采用contentType的UTF-8进行解码了，我们就可以还原得到`title=JVMoptimize`了，然后取到`JVMoptimize`这个参数值。

###### 2.中文参数的情况

我们再来讲一讲中文参数的问题，因为在chrome中，非ASCII字符会采用UTF-8先进行一次编码；那么其实在服务器端，我们可以自己思考一下。因为如果是纯英文的参数，下图是`title=JVM optimize`的请求，在初步处理时，空格是Hex的%20，也就是说纯英文下%后面一定是20，%20代表了一个空格。而如果是中文参数，因为浏览器手动在每一个字节前加了%，注意，这样我们服务器端通过%和其后面的是否跟着20就可以知道这里是空格还是代表着中文参数了。

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141601.png)

##### queryString解码的猜想

我们可以做出设想，在对queryString进行第一次转码之后，可能有2种基本情况：

*   纯英文，还有空格的参数。原参数如：`title=JVM optimize` 。  
    那么第一次转码，会得到：`title=JVM%20optimize` 。
*   中文，还有空格的参数。原参数如：`title=JVM 调优`。  
    那么第一次转码。会得到：`title=JVM%20%E8%B0%83%E4%BC%98`。

这个时候的结果就很明确了。我猜测，这时候服务器内部应该会对%进行检测，然后做出相应的处理。下面是我的猜测：

如果检测到%，那么看看其后面是否跟着20？是的话，就表示这是一个空格，将其转化（解码）为空格`" "` ；不是的话，代表这一块将是中文字符（或其他非ASCII字符，如日文，韩文），就把这一块连续的%剔除，再用UTF-8转码，就得到了中文字符。

上面应该是挺靠近真实情况的解释了，因为肯定对非ASCII的解码要进行2次，上面的依据也挺充足的。

### 其他

那么我已经对url的编码解码过程做了一个分析，要注意的点和需要设置的地方在文中已经提到了。对于网上常见的一个设置：`request.setCharacterEncoding(charset)`，设不设置都无所谓了，它的作用和contentType是一样的。