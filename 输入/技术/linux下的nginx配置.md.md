linux下的nginx配置.md

## linux下的nginx配置

> 本文档主要用于指导如何将nginx作为域名转发服务器使用

### 绑定域名

首先你要登录到你的域名服务商提供的管理控制台去绑定域名到你的服务器，这里我们假设我们需要绑定的域名为`demo.njxuqiang.com`,服务器的IP地址为`125.64.9.228`，域名服务商为`万网`

1、进入万网官网:
​ [万网官网](https://wanwang.aliyun.com/)
2、点击左上角登录链接

![001.png](../_resources/c94241cb3c5a174d42a58e36247e8d63.png)

001.png

3、输入用户名密码登录，用户名密码见《旭强账户资料》文件：

![002.png](../_resources/f577a647b036931f267d3a91d5207688.png)

002.png
)

4、点击“管理控制台”，进入控制台：

![003.png](../_resources/113b21dae0e22880db348f2f99246330.png)

003.png

5、点击左列面板中的“云解析”

![004.png](../_resources/c8e8c3e11c9ce42626a70c421798a783.png)

004.png

6、找到相应域名（[这里是njxuqiang.com](http://xn--njxuqiang-pr6sn087ad5e.com)），然后点击后面的“解析”链接：

![005.png](../_resources/7592f90dbce1807c1c0b9c1d955a9bfd.png)

005.png

7、点击“添加解析”按钮

![006.png](../_resources/ba8a655c0f2f30bc798419b15e978c10.png)

006.png

8、填写记录类型为“A”，主机记录即是你要绑定的二级域名，这里是`demo` ,记录值则是要指向的服务器IP地址，这里是`125.64.9.228` ,然后点击“保存”

![007.png](../_resources/2fc973a637c201c524cf4516e0b3b523.png)

007.png

**至此，在域名服务商网站绑定域名的工作就完成了，接下来就要在服务器上来设置域名转发了**

### 服务器域名转发

1、SSH登入服务器
2、切换到nginx的安装目录，这里为：`/usr/local/nginx-1.8.0`

	# cd /usr/local/nginx-1.8.0

3、切换到虚拟主机目录：

	# cd conf/vhost/

4、列出现有虚拟主机：

	[root@cloud vhost]# ls
	api.njxuqiang.com.conf  travel.njxuqiang.com.conf  www.njxuqiang.com.conf

5、如果已存在虚拟主机配置文件，则复制其中一份并重命名为“二级域名.一级域名.conf"格式的名字：

	# cp api.njxuqiang.com.conf  demo.njxuqiang.com.conf

6、如果没有，则自己使用`touch`命令新建一份：

	# touch demo.njxuqiang.com.conf

7、将复制或创建的文件内容编辑为以下所示：

	server {
	        listen 8086;  //这里是你的域名对应的服务所监听的端口地址
	        server_name demo.njxuqiang.com; //这里填写你要设置的域名

	        charset UTF-8;

	        location / {
	        proxy_pass http://localhost:18081/; //这里填写你的服务所在端口，例如tomcat是8080，nodejs是9600
	        proxy_set_header Host $host;
	        proxy_set_header X-Real-IP $remote_addr;
	        proxy_set_header REMOTE-HOST $remote_addr;
	        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	        proxy_redirect off;
	                client_max_body_size    10m;
	        }

	          error_page  404              /404.html;

	          location = /404.html {
	          root   /usr/share/nginx/html;
	          }

	          # redirect server error pages to the static page /50x.html
	          #
	          error_page   500 502 503 504  /50x.html;
	          location = /50x.html {
	          root   /usr/share/nginx/html;
	          }

> 注意以上文件内容中有注释的说明部分
并保存退出。
8、重启nginx服务
域名转发设置成功!
[markdownFile.md](../_resources/b9f409defe3210625a2660e29a3b9cd1.bin)