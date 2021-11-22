使用wro4j和maven在编译期间压缩js和css文件 - - ITeye技术网站

最近在对一个web系统做性能优化.
而对用到的静态资源文件的压缩整合则是前端性能优化中很重要的一环.
好处不仅在于能够减小请求的文件体积,而且能够减少浏览器的http请求数.

因为是基于java的web系统,并且使用的是nginx+tomcat做为服务器.
最后考虑用wro4j和maven plugin在编译期间压缩静态资源.

优化前:
基本上所有的jsp都引用了这一大坨静态文件:

Html代码

 [![收藏代码](使用wro4j和maven在编译期间压缩js和css文件%20-%20-%20ITeye技术网站.md#)
1. <link rel="stylesheet" type="text/css" href="${ctxPath}/css/skin.css"/>

2. <link rel="stylesheet" type="text/css" href="${ctxPath}/css/jquery-ui-1.8.23.custom.css"/>

3. <link rel="stylesheet" type="text/css" href="${ctxPath}/css/validationEngine.jquery.css"/>

4.

5. <script type="text/javascript">var GV = {ctxPath: '${ctxPath}',imgPath: '${ctxPath}/css'};</script>

6. <script type="text/javascript" src="${ctxPath}/js/jquery-1.7.2.min.js"></script>

7. <script type="text/javascript" src="${ctxPath}/js/jquery-ui-1.8.23.custom.min.js"></script>

8. <script type="text/javascript" src="${ctxPath}/js/jquery.validationEngine.js"></script>

9. <script type="text/javascript" src="${ctxPath}/js/jquery.validationEngine-zh_CN.js"></script>

10. <script type="text/javascript" src="${ctxPath}/js/jquery.fixedtableheader.min.js"></script>

11. <script type="text/javascript" src="${ctxPath}/js/roll.js"></script>

12. <script type="text/javascript" src="${ctxPath}/js/jquery.pagination.js"></script>

13. <script type="text/javascript" src="${ctxPath}/js/jquery.rooFixed.js"></script>

14. <script type="text/javascript" src="${ctxPath}/js/jquery.ui.datepicker-zh-CN.js"></script>

15. <script type="text/javascript" src="${ctxPath}/js/json2.js"></script>
16. <script type="text/javascript" src="${ctxPath}/js/common.js"></script>

引用的文件很多,并且文件体积没有压缩,导致页面请求的时间非常长.

另外还有一个问题,就是为了能够充分利用浏览器的缓存,静态资源的文件名称最好能够做到版本化控制.

这样前端web服务器就可以放心大胆的开启缓存功能而不用担心缓存过期问题,因为如果一旦静态资源文件有修改的话,
会重新生成一个文件名称.

下面我根据自己项目的经验,来介绍下如何较好的解决这两个问题.

分两步进行.

第一步:引入wro4j,在编译时期将上述分散的多个文件整合成少数几个文件,并且将文件最小化.

第二步:在生成的静态资源文件的文件名称上加入时间信息

这是两步优化之后的引用情况:
Html代码

 [![收藏代码](使用wro4j和maven在编译期间压缩js和css文件%20-%20-%20ITeye技术网站.md#)
1. ${platform:cssFile("/wro/basic") }

2. <script type="text/javascript">var GV = {ctxPath: '${ctxPath}',imgPath: '${ctxPath}/css'};</script>

3. ${platform:jsFile("/wro/basic") }
4. ${platform:jsFile("/wro/custom") }

只引用了1个css文件,2个js文件.http请求从10几个减少到3个,并且整体文件体积缩小了近一半.

下面介绍优化流程.

第一步：合并并且最小化文件.

1.添加wro4j的maven依赖
Xml代码

 [![收藏代码](使用wro4j和maven在编译期间压缩js和css文件%20-%20-%20ITeye技术网站.md#)
1. <wro4j.version>1.6.2</wro4j.version>
2.
3.    ...
4.
5.  <dependency>
6.   <groupId>ro.isdc.wro4j</groupId>
7.   <artifactId>wro4j-core</artifactId>
8.   <version>${wro4j.version}</version>
9.   <exclusions>
10.    <exclusion>
11.
12.    <!-- 因为项目中的其他jar包已经引入了不同版本的slf4j,所以这里避免jar重叠所以不引入 -->
13.     <groupId>org.slf4j</groupId>
14.     <artifactId>slf4j-api</artifactId>
15.    </exclusion>
16.   </exclusions>
17.  </dependency>

2.添加wro4j maven plugin

Xml代码

 [![收藏代码](使用wro4j和maven在编译期间压缩js和css文件%20-%20-%20ITeye技术网站.md#)
1.    <plugin>
2.     <groupId>ro.isdc.wro4j</groupId>
3.     <artifactId>wro4j-maven-plugin</artifactId>
4.     <version>${wro4j.version}</version>
5.     <executions>
6.      <execution>
7.       <phase>compile</phase>
8.       <goals>
9.        <goal>run</goal>
10.       </goals>
11.      </execution>
12.     </executions>
13.     <configuration>
14.      <targetGroups>basic,custom</targetGroups>
15.
16.     <!-- 这个配置是告诉wro4j在打包静态资源的时候是否需要最小化文件,开发的时候可以设成false,方便调试 -->
17.      <minimize>true</minimize>

18.      <destinationFolder>${basedir}/src/main/webapp/wro/</destinationFolder>

19.      <contextFolder>${basedir}/src/main/webapp/</contextFolder>
20.
21. <!-- 这个配置是第二步优化需要用到的,暂时忽略 -->

22.      <wroManagerFactory>com.rootrip.platform.common.web.wro.CustomWroManagerFactory</wroManagerFactory>

23.     </configuration>
24.          </plugin>

如果开发环境是eclipse的话,可以下载m2e-wro4j这个插件.

下载地址:http://download.jboss.org/jbosstools/updates/m2e-wro4j/

这个插件的主要功能是能够帮助我们在开发环境下修改对应的静态文件,或者pom.xml文件的时候能够自动生成打包好的js和css文件.

对开发来说就会方便很多.只要修改源文件就能看见修改后的结果.

3.在WEB-INF目录下添加wro.xml文件,这个文件的作用就是告诉wro4j需要以怎样的策略打包jss和css文件.
Java代码

 [![收藏代码](使用wro4j和maven在编译期间压缩js和css文件%20-%20-%20ITeye技术网站.md#)
1. <?xml version="1.0" encoding="UTF-8"?>

2. <groups xmlns="http://www.isdc.ro/wro" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"

3.  xsi:schemaLocation="http://www.isdc.ro/wro wro.xsd">
4.
5.  <group name="basic">
6.   <css>/css/basic.css</css>
7.   <css>/css/skin.css</css>
8.   <css>/css/jquery-ui-1.8.23.custom.css</css>
9.   <css>/css/validationEngine.jquery.css</css>
10.
11.   <js>/js/jquery-1.7.2.min.js</js>
12.   <js>/js/jquery-ui-1.8.23.custom.min.js</js>
13.   <js>/js/jquery.validationEngine.js</js>
14.   <js>/js/jquery.fixedtableheader.min.js</js>
15.   <js>/js/roll.js</js>
16.   <js>/js/jquery.pagination.js</js>
17.   <js>/js/jquery.rooFixed.js</js>
18.   <js>/js/jquery.ui.datepicker-zh-CN.js</js>
19.   <js>/js/json2.js</js>
20.  </group>
21.
22.  <group name="custom">
23.   <js>/js/jquery.validationEngine-zh_CN.js</js>
24.   <js>/js/common.js</js>
25.  </group>
26.
27. </groups>

官方文档：http://code.google.com/p/wro4j/wiki/WroFileFormat

其实这个配置文件很好理解,如果不愿看官方文档的朋友我在这简单介绍下.

上面这样配置的目的就是告诉wro4j要将

<css>/css/basic.css</css>
<css>/css/skin.css</css>
<css>/css/jquery-ui-1.8.23.custom.css</css>
<css>/css/validationEngine.jquery.css</css>

这四个文件整合到一起,生成一个叫basic.css的文件到指定目录(wro4j-maven-plugin里配置的),将

<js>/js/jquery-1.7.2.min.js</js>
<js>/js/jquery-ui-1.8.23.custom.min.js</js>
<js>/js/jquery.validationEngine.js</js>
<js>/js/jquery.fixedtableheader.min.js</js>
<js>/js/roll.js</js>
<js>/js/jquery.pagination.js</js>
<js>/js/jquery.rooFixed.js</js>
<js>/js/jquery.ui.datepicker-zh-CN.js</js>
<js>/js/json2.js</js>

这几个文件整合到一起,生成一个叫basic.js的文件到指定目录.

最后将

<js>/js/jquery.validationEngine-zh_CN.js</js>
<js>/js/common.js</js>

这两个文件整合到一起,,生成一个叫custom.js的文件到指定目录.

第一步搞定,这时候如果你的开发环境是eclipse并且安装了插件的话,应该就能在你工程的%your webapp%/wor/目录下看见生成好的

basic.css,basic.js和custom.js这三个文件了.

然后你再将你的静态资源引用路径改成

Html代码

 [![收藏代码](使用wro4j和maven在编译期间压缩js和css文件%20-%20-%20ITeye技术网站.md#)
1. <link rel="stylesheet" type="text/css" href="${ctxPath}/wro/basic.css"/>
2. <script type="text/javascript" src="${ctxPath}/wro/basic.js"></script>
3. <script type="text/javascript" src="${ctxPath}/wro/custom.js"></script>

就ok了.每次修改被引用到的css或js文件的时候,这些文件都将重新生成.

如果开发环境是eclipse但是没有安装m2e-wro4j插件的话,pom.xml可能需要额外配置.

请参考:https://community.jboss.org/en/tools/blog/2012/01/17/css-and-js-minification-using-eclipse-maven-and-wro4j

第二步：给生成的文件名称中加入时间信息并通过el自定义函数引用脚本文件.

1. 创建DailyNamingStrategy类
Java代码

 [![收藏代码](使用wro4j和maven在编译期间压缩js和css文件%20-%20-%20ITeye技术网站.md#)
1. public class DailyNamingStrategy extends TimestampNamingStrategy {
2.

3.  protected final Logger log = LoggerFactory.getLogger(DailyNamingStrategy.class);

4.
5.  @Override
6.  protected long getTimestamp() {
7.   String dateStr = DateUtil.formatDate(new Date(), "yyyyMMddHH");
8.   return Long.valueOf(dateStr);
9.  }
10.
11.
12.
13. }

2.创建CustomWroManagerFactory类

Java代码

 [![收藏代码](使用wro4j和maven在编译期间压缩js和css文件%20-%20-%20ITeye技术网站.md#)
1. //这个类就是在wro4j-maven-plugin里配置的wroManagerFactory参数
2. public class CustomWroManagerFactory extends
3.   DefaultStandaloneContextAwareManagerFactory {
4.  public CustomWroManagerFactory() {
5.   setNamingStrategy(new DailyNamingStrategy());
6.  }
7. }

上面这两个类的作用是使用wro4j提供的文件命名策略,这样生成的文件名就会带上时间信息了.

例如：basic-2013020217.js

但是现在又会发现一个问题:如果静态资源文件名称不固定的话,那怎么样引用呢?

这时候就需要通过动态生成<script>与<link>来解决了.

因为项目使用的是jsp页面,所以通过el自定义函数来实现标签生成.

3.创建PlatformFunction类

Java代码

 [![收藏代码](使用wro4j和maven在编译期间压缩js和css文件%20-%20-%20ITeye技术网站.md#)
1. public class PlatformFunction {
2.

3.  private static Logger log = LoggerFactory.getLogger(PlatformFunction.class);

4.
5.

6.  private static ConcurrentMap<String, String> staticFileCache = new ConcurrentHashMap<>();

7.
8.  private static AtomicBoolean initialized = new AtomicBoolean(false);
9.
10.  private static final String WRO_Path = "/wro/";
11.

12.  private static final String JS_SCRIPT = "<script type=\"text/javascript\" src=\"%s\"></script>";

13.  private static final String CSS_SCRIPT = "<link rel=\"stylesheet\" type=\"text/css\" href=\"%s\">";

14.
15.  private static String contextPath = null;
16.
17.  /**
18.   * 该方法根据给出的路径,生成js脚本加载标签
19.   * 例如传入参数/wro/custom,该方法会寻找webapp路径下/wro目录中以custom开头,以js后缀结尾的文件名称名称.

20.   * 然后拼成<script type="text/javascript" src="${ctxPath}/wro/custom-20130201.js"></script>返回

21.   * 如果查找到多个文件,返回根据文件名排序最大的文件
22.   * @param str
23.   * @return
24.   */
25.  public static String jsFile(String filePath) {
26.   String jsFile = staticFileCache.get(buildCacheKey(filePath, "js"));
27.   if(jsFile == null) {
28.    log.error("加载js文件失败,缓存中找不到对应的文件[{}]", filePath);
29.   }
30.   return String.format(JS_SCRIPT, jsFile);
31.  }
32.
33.  /**
34.   * 该方法根据给出的路径,生成css脚本加载标签
35.   * 例如传入参数/wro/custom,该方法会寻找webapp路径下/wro目录中以custom开头,以css后缀结尾的文件名称名称.

36.   * 然后拼成<link rel="stylesheet" type="text/css" href="${ctxPath}/wro/basic-20130201.css">返回

37.   * 如果查找到多个文件,返回根据文件名排序最大的文件
38.   * @param str
39.   * @return
40.   */
41.  public static String cssFile(String filePath) {
42.   String cssFile = staticFileCache.get(buildCacheKey(filePath, "css"));
43.   if(cssFile == null) {
44.    log.error("加载css文件失败,缓存中找不到对应的文件[{}]", filePath);
45.   }
46.   return String.format(CSS_SCRIPT, cssFile);
47.  }
48.
49.  public static void init() throws IOException {
50.   if(initialized.compareAndSet(false, true)) {
51.    ServletContext sc = Platform.getInstance().getServletContext();
52.    if(sc == null) {
53.     throw new PlatformException("查找静态资源的时候的时候发现servlet context 为null");
54.    }
55.    contextPath = Platform.getInstance().getContextPath();

56.    File wroDirectory = new ServletContextResource(sc, WRO_Path).getFile();

57.    if(!wroDirectory.exists() || !wroDirectory.isDirectory()) {

58.     throw new PlatformException("查找静态资源的时候发现对应目录不存在[" + wroDirectory.getAbsolutePath() + "]");

59.    }
60.    //将wro目录下已有文件加入缓存
61.    for(File file : wroDirectory.listFiles()) {
62.     handleNewFile(file);
63.    }
64.    //监控wro目录,如果有文件生成,则判断是否是较新的文件,是的话则把文件名加入缓存

65.    new Thread(new WroFileWatcher(wroDirectory.getAbsolutePath())).start();

66.   }
67.  }
68.
69.  private static void handleNewFile(File file) {
70.   String fileName = file.getName();
71.   Pattern p = Pattern.compile("^(\\w+)\\-\\d+\\.(js|css)$");
72.   Matcher m = p.matcher(fileName);
73.   if(!m.find() || m.groupCount() < 2) return;
74.   String fakeName = m.group(1);
75.   String fileType = m.group(2);
76.   //暂时限定只能匹配/wro/目录下的文件
77.   String key = buildCacheKey(WRO_Path + fakeName, fileType);
78.   if(staticFileCache.putIfAbsent(key, fileName) != null) {
79.    synchronized(staticFileCache) {
80.     String cachedFileName = staticFileCache.get(key);
81.     if(fileName.compareTo(cachedFileName) > 0) {
82.      staticFileCache.put(key, contextPath + WRO_Path + fileName);
83.     }
84.    }
85.   }
86.  }
87.
88.  private static String buildCacheKey(String fakeName, String fileType) {
89.   return fakeName + "-" + fileType;
90.  }
91.
92.  static class WroFileWatcher implements Runnable {
93.

94.   private static Logger log = LoggerFactory.getLogger(WroFileWatcher.class);

95.
96.   private String wroAbsolutePathStr;
97.
98.   public WroFileWatcher(String wroPathStr) {
99.    this.wroAbsolutePathStr = wroPathStr;
100.   }
101.
102.   @Override
103.   public void run() {
104.    Path path = Paths.get(wroAbsolutePathStr);
105.    File wroDirectory = path.toFile();
106.    if(!wroDirectory.exists() || !wroDirectory.isDirectory()) {
107.     String message = "监控wro目录的时候发现对应目录不存在[" + wroAbsolutePathStr + "]";
108.     log.error(message);
109.     throw new PlatformException(message);
110.    }
111.    log.warn("开始监控wro目录[{}]", wroAbsolutePathStr);
112.    try {
113.     WatchService watcher = FileSystems.getDefault().newWatchService();
114.     path.register(watcher, StandardWatchEventKinds.ENTRY_CREATE);
115.
116.     while (true) {
117.      WatchKey key = null;
118.      try {
119.       key = watcher.take();
120.      } catch (InterruptedException e) {
121.       log.error("", e);
122.       continue;
123.      }
124.      for (WatchEvent<?> event : key.pollEvents()) {
125.       if (event.kind() == StandardWatchEventKinds.OVERFLOW) {
126.        continue;
127.       }
128.       WatchEvent<Path> e = (WatchEvent<Path>) event;
129.       Path filePath = e.context();
130.       handleNewFile(filePath.toFile());
131.      }
132.      if (!key.reset()) {
133.       break;
134.      }
135.     }
136.    } catch (IOException e) {
137.     log.error("监控wro目录发生错误", e);
138.    }
139.    log.warn("停止监控wro目录[{}]", wroAbsolutePathStr);
140.   }
141.  }
142. }

对应的tld文件就不给出了,根据方法签名编写就行了.

其中的cssFile和jsFile方法分别实现引用css和js文件.

在页面使用的时候类似这样:

${platform:cssFile("/wro/basic") }

${platform:jsFile("/wro/custom") }

这个类的主要功能就是使用jdk7的WatchService监控wro目录的新增文件事件,

一旦有新的文件加到目录里,判断这个文件是不是最新的,如果是的话则使用这个文件名称引用.

这样一旦有新加的资源文件放到wro目录里,则能够自动被引用,不需要做任何代码上的修改,并且基本不影响性能.

到此为止功能已经实现.

但是我考虑到还有两个问题有待完善:

1.因为生成的文件名称精确到小时,如果这个小时之内有多次代码修改,生成的文件名都完全一样.

这样就算线上的代码有修改,对于已经有该文本缓存的浏览器来说,不会重新请求文件,也就看不到文件变化.

不过一般来说线上代码不会如此频繁改动,对于大多数应用来说影响不大.

2.在开发环境开发一段时间之后,wro目录下会生成一大堆的文件(因为m2e-wro4j插件在生成新的文件的时候不会删除旧文件,如果文件名相同会覆盖掉以前的文件),

这时候就需要手动删除时间靠前的旧文件,虽然系统会忽略旧文件,但是我相信大多数程序员和我一样是有些许洁癖的吧.

解决办法还是不少,比如可以写脚本定期清理掉旧文件.

时间有限,有些地方考虑的不是很完善,欢迎拍砖.

参考资料:

http://meri-stuff.blogspot.sk/2012/08/wro4j-page-load-optimization-and-lessjs.html#Configuration

https://community.jboss.org/en/tools/blog/2012/01/17/css-and-js-minification-using-eclipse-maven-and-wro4j

http://code.google.com/p/wro4j/wiki/MavenPlugin
http://code.google.com/p/wro4j/wiki/WroFileFormat
http://java.dzone.com/articles/using-java-7s-watchservice