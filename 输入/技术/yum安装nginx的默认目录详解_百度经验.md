yum安装nginx的默认目录详解_百度经验

# yum安装nginx的默认目录详解



[分步阅读](http://jingyan.baidu.com/album/63f2362844423e0209ab3d44.html)
nginx是一种web应用服务，我们通过yum安装往往会找不到默认的配置文件，文件目录等等，我们来说一下

[![b21bb051f819861867626a5c41ed2e738ad4e6c5.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/4da57244605a022f5d2791314654dce3.png)](http://jingyan.baidu.com/album/63f2362844423e0209ab3d44.html?picindex=1)

## [(L)](yum安装nginx的默认目录详解_百度经验.md#)工具/原料

- nginx
- centos

## [(L)](yum安装nginx的默认目录详解_百度经验.md#)方法/步骤

1. 1
我们先通过yum install nginx 安装好这个服务，这里我已经安装过了。我已经启动了

[![e7cd7b899e510fb324caf24fd233c895d0430c12.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/2b206d6203ed391d6a7e4e66ad03b98c.png)](http://jingyan.baidu.com/album/63f2362844423e0209ab3d44.html?picindex=2)

2. 2
nginx的配置文件在/etc/nginx/nginx.conf

[![00e93901213fb80ebac8e60f3dd12f2eb83894c9.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/918903c18467b22eddc594e0f924525b.png)](http://jingyan.baidu.com/album/63f2362844423e0209ab3d44.html?picindex=3)

3. 3
自定义的配置文件放在/etc/nginx/conf.d

[![80cb39dbb6fd5266cf73bbcca018972bd5073689.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/4a8f3c0f2bad5573cafff642491bf91d.png)](http://jingyan.baidu.com/album/63f2362844423e0209ab3d44.html?picindex=4)

4. 4
项目文件存放在/usr/share/nginx/html/

[![58ee3d6d55fbb2fb3ad2dfca444a20a44723dc69.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/001a9170ec9b2e532b75832b315c726e.png)](http://jingyan.baidu.com/album/63f2362844423e0209ab3d44.html?picindex=5)

5. 5
日志文件存放在/var/log/nginx/

[![b58f8c5494eef01fedae9e1debfe9925bd317db4.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/4f7ee9d7fbbad1109262a3ba3b06b575.png)](http://jingyan.baidu.com/album/63f2362844423e0209ab3d44.html?picindex=6)

6. 6
还有一些其他的安装文件都在/etc/nginx

[![3812b31bb051f819ca4f8292d1b44aed2f73e784.jpg](https://gitee.com/hjb2722404/tuchuang/raw/master/img/8ae2458e965d2d0b0a3b9318677e2487.png)](http://jingyan.baidu.com/album/63f2362844423e0209ab3d44.html?picindex=7)

END

经验内容仅供参考，如果您需解决具体问题(尤其法律、医学等领域)，建议您详细咨询相关领域专业人士。
[举报](yum安装nginx的默认目录详解_百度经验.md#)*作者声明：*本篇经验系本人依照真实经历原创，未经许可，谢绝转载。