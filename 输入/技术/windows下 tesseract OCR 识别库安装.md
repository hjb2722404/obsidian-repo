windows下 tesseract OCR 识别库安装


发布时间：2019-01-23 10:15:41作者：wangjian浏览量：1625点赞量：1

一：下载并安装tesseract
1：下载
tesseract 下载地址：https://digi.bib.uni-mannheim.de/tesseract/

选择你需要的版本进行下载，这里注意：tesseract 版本在3.0以下的不支持中文识别，下载包上带有dev的表示不稳定版本，下载时最好下载不带有dev字符的下载包

2：安装

双击下载下来的安装包，然后傻瓜式安装就可以，这里只需要注意一点：安装过程中有一个让你选择Additional language data(download)表示选择的话帮你下载语言包，这里最好不要选择勾选，因为勾选的话，安装过程非常慢，之后我们可以进行手动安装语言包

二：安装语言包
语言包下载地址：https://github.com/tesseract-ocr/tessdata/
将下载下来的语言包解压之后，将解压包中的所有文件复制到安装目录的tessdata目录下就可以了，例：
![1548210921660284.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105114717.png)
三：配置环境变量
右击我的电脑/计算机，选择属性，然后选择高级属性设置，选择环境变量，在系统变量的path变量中添加你的tesseract 目录就可以了
![1548210922132900.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105121115.png)
四：判断tesseract 是否安装成功并进行简单测试
1：判断是否安装成功
在命令行中输入
`tesseract --version`
出现如下现象表示tesseract 安装成功
![1548210924308687.png](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210105121631.png)
参考安装的语言包
`tesseract --list-langs`
这时候就可以看到你安装的语言包了
2：简单测试
在命令行执行
`tesseract image.png result （tesseract 图片名称 生成文件名称）`
这时候就可以在命令行目录下看到一个名为result.txt的文件，文件内就为图片识别的文字内容
到此windows下tesseract 安装结束
最近由于其他原因，电脑的虚拟机安装了windows server 2016，所以在linux下安装tesseract ，之后再学习


上一篇：[Python 识别验证码](https://www.wj0511.com/site/detail.html?id=251)

下一篇：[PHP 将xml数据转成数组](https://www.wj0511.com/site/detail.html?id=249)

 ![](../_resources/2beb05f5bc4ad48655fb1136c23c9a7e.png)  1