php实现word文档在线浏览功能，配置安装手记 - 永不停歇 - 博客频道 - CSDN.NET

一般类似oa或者crm等管理系统可能都会遇到需要再线查看word文档的功能，类似百度文库。

记得去年小组中的一个成员负责的项目就需要这个的功能，后面说是实现比较困难，就将就着用chm格式替代了。今天看到网上一遍文章《[Linux](http://lib.csdn.net/base/linux)下面PHP文件转换》，介绍怎么样在linux下使用Openoffice 3 , Pdf2Swf tool , Jodconverter , FlexPaper，实现文档在线查看。

自己再ubuntu下进行的尝试安装，步骤如下：
因为ubuntu版本为10.0.4，openoffice已经默认安装。如果没有安装openoffice的话自行谷歌安装。
第一步：安装jodconverter，安装之后可以实现doc文档转成pdf。
文件下载地址为http://www.artofsolving.com/opensource/jodconverter

下载了之后直接解压，解压到/opt目录下/opt/jodconverter-2.2.2/，使用到的文件是安装包内的lib/jodconverter-cli-2.2.2.jar。

测试是否可以使用

1. java -jar /opt/jodconverter-2.2.2/lib/jodconverter-cli-2.2.2.jar  /home/php/1.doc  /home/php/1.pdf

这里提示缺少[Java](http://lib.csdn.net/base/javaee)软件包，并会提示几个安装包供。选择我安装openjdk-6-jre-headless，命令如下：

1. sudo apt_get openjdk-6-jre-headless
安装之后再运行上面doc转pdf的命名，会提示openoffice进程未启动，

[![openoffice1-1024x144.png](../_resources/2ae3e761b33dde57f1455cb02061c7f0.png)](http://laoniangke.com/uploads/2012/10/openoffice1.png)

因为JODConverter是通过OpenOffice來做转换的 ，所以使用前需要先安裝OpenOffice, 並且將OpenOffice的Service启动, 才可以使用. 启动命令

1. /usr/lib/soffice -headless -accept=&quot;socket,host=127.0.0.1,port=8100;urp;&quot;  -nofirststartwizard &amp;

到此运行上面的doc转pdf的命令已经可以成功。
第二步：安装swftools，安装之后可以实现pdf文件转成swf
1. wget http://www.swftools.org/swftools-0.9.1.tar.gz
2. tar xzf swftools-0.9.1.tar.gz
3. cd swftools-0.9.1
4. ./configure
5. make
6. make install
测试是否可以使用
1. pdf2swf -o /home/php/1.swf  -T -z -t -f /home/php/1.pdf  -s flashversion=9
第三步：用FlexPaper实现在线预览，里面有详细的demo。
第四步：使用php测试文档转换命令：
文档转pdf
1. <?php
2. $doc =  './docs/test.txt';
3. $formatName =  './pdf/test.pdf';

4. $command =  'java -jar /opt/jodconverter-2.2.2/lib/jodconverter-cli-2.2.2.jar '.$doc.' '.$formatName;

5.
6. exec($command);
7. echo 'ok';
pdf转swf
1. <?php
2. $pdf =  './pdf/test.pdf';
3. $swf =  './swf/test.swf';
4.

5. $command =  '/usr/local/wenku/swftools-0.9.1/src/pdf2swf -o '.$swf.' -T -z -t -f '.$pdf.' -s flashversion=9';

6.
7. exec($command);
8. echo 'ok';
php脚本去运行上面的命令可能存在权限的问题无法执行
其中我测试使用的php脚本调用pdf2swf进行转换文件，生成不了。这样只需配置apache的用户权限即可，确保配置的用户有权限运行pdf2swf命令
默认安装的php环境ubuntu下配置文件是/etc/apache2/apache2.conf修改这两行，
User ${APACHE_RUN_USER}
Group ${APACHE_RUN_USER}
配置完之后，重启apache。
/etc/init.d/apache2 restart
到此linux下的安装配置就结束了。
**window下测试**
下载window下使用的Pdf2Swf tool和FlexPaper，手动的将pdf文件转swf后进行在线查看的功能。
步骤整理如下：
1.安装Pdf2Swf tool之后，进行将pdf转swf。cmd命令行：

pdf2swf.exe -t D:\wamp5.3\www\test\pdf\c.pdf -s flashversion=9 -o D:\wamp5.3\www\test\swf\c.swf

-t: 源文件路径，即待转换的pdf文件路径。
-s: 设置参数,这里我们设置为 flashversion=9 ，即可以转换为9 的版本啦。
-o: 输出文件的路径,这里我输出到D:盘下
运行的结果如图所示：

[![pdf2swf.png](../_resources/cdf96aa90b42afd729c8ac41adc968b2.png)](http://laoniangke.com/uploads/2012/10/pdf2swf.png)

2.使用FlexPaper插件显示浏览swf文件。这里下载使用的版本是1.5.8 Flash Version (release notes)。软件包内就已经有html版本的demo，稍微改动下句可以实现了。

代码如下：
1. <script  src="js/flexpaper_flash.js"  type="text/javascript"></script>

2. <a  id="viewerPlaceHolder"  style="width:680px;height:480px;display:block;"/></a>

3. <script  type="text/javascript">
4.   var fp =  new  FlexPaperViewer(
5.   'FlexPaperViewer',
6.   'viewerPlaceHolder',  { config :  {
7.   SwfFile  : escape('c.swf'),
8.   Scale  :  0.1,
9.   ZoomTransition  :  'easeOut',
10.   ZoomTime  :  0.5,
11.   ZoomInterval  :  0.2,
12.   FitPageOnLoad  :  true,
13.   FitWidthOnLoad  :  false,
14.   FullScreenAsMaxWindow  :  false,
15.   ProgressiveLoading  :  false,
16.   MinZoomSize  :  0.2,
17.   MaxZoomSize  :  5,
18.   SearchMatchAll  :  false,
19.   InitViewMode  :  'Portrait',
20.   PrintPaperAsBitmap  :  false,
21.
22.   ViewModeToolsVisible  :  true,
23.   ZoomToolsVisible  :  true,
24.   NavToolsVisible  :  true,
25.   CursorToolsVisible  :  true,
26.   SearchToolsVisible  :  true,
27.
28.  localeChain:  'en_US'
29.   }})
30. </script>
到此就结束了，查看效果如图实现：

[![flexpaper.png](../_resources/1f543b13d58ee0ea359dbae088b99476.png)](http://laoniangke.com/uploads/2012/10/flexpaper.png)