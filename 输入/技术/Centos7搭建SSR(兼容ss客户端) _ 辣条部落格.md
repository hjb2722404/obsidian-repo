Centos7搭建SSR(兼容ss客户端) | 辣条部落格

# Centos7搭建SSR(兼容ss客户端)

 **[辣条①号](https://boke.wsfnk.com/archives/author/fnk)  **2018年8月11日  **[Linux System 运维](https://boke.wsfnk.com/archives/category/linux-system-%e8%bf%90%e7%bb%b4), [工具篇](https://boke.wsfnk.com/archives/category/linux-system-%e8%bf%90%e7%bb%b4/%e5%b7%a5%e5%85%b7%e7%af%87)  **3,548 views  **[0](https://boke.wsfnk.com/archives/601.html#respond)

**第一：搭建ssr**
wget https://raw.githubusercontent.com/\ToyoDAdoubi/doubi/master/ssr.sh
chmod +x ssr.sh && bash ssr.sh

[![ssr-1.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180556.png)](https://qiniu.wsfnk.com/ssr-1.png)

[![ssr-2.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180600.png)](https://qiniu.wsfnk.com/ssr-2.png)

[![ssr-3.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180604.png)](https://qiniu.wsfnk.com/ssr-3.png)

[![ssr-4.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180607.png)](https://qiniu.wsfnk.com/ssr-4.png)

[![ssr-5.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180610.png)](https://qiniu.wsfnk.com/ssr-5.png)

**第二：启用google的tcp加速**

wget https://github.com/teddysun/across/raw/master/bbr.sh chmod +x bbr.sh ./bbr.sh 验证 lsmod | grep bbr

默认是单端口模式，可以修改成多端口模式，直接运行 ./ssr.sh

* * *

**windows设置客户端代理**
这个提供了一个SSR的客户端，解压密码 123456
https://qiniu.wsfnk.com/ShadowsocksR-win-4.9.0.zip

[![win-ssr1.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180616.png)](https://qiniu.wsfnk.com/win-ssr1.png)

[![win-ssr2.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180619.png)](https://qiniu.wsfnk.com/win-ssr2.png)

[![win-ssr3.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180623.png)](https://qiniu.wsfnk.com/win-ssr3.png)

[![win-ssr4.png](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107180629.png)](https://qiniu.wsfnk.com/win-ssr4.png)

* * *

**ubuntu设置客户端代理**
这个提供了一个ubuntu的SSR的客户端
https://qiniu.wsfnk.com/electron-ssr_0.2.3_amd64.deb

声明：本文为原创，作者为 辣条①号，转载时请保留本声明及附带文章链接：https://boke.wsfnk.com/archives/601.html

[](http://service.weibo.com/share/share.php?url=https%3A%2F%2Fboke.wsfnk.com%2Farchives%2F601.html&title=Centos7%E6%90%AD%E5%BB%BASSR(%E5%85%BC%E5%AE%B9ss%E5%AE%A2%E6%88%B7%E7%AB%AF)%20%7C%20%E8%BE%A3%E6%9D%A1%E9%83%A8%E8%90%BD%E6%A0%BC&pic=https%3A%2F%2Fqiniu.wsfnk.com%2Fssr-1.png&appkey=)[](http://connect.qq.com/widget/shareqq/index.html?url=https%3A%2F%2Fboke.wsfnk.com%2Farchives%2F601.html&title=Centos7%E6%90%AD%E5%BB%BASSR(%E5%85%BC%E5%AE%B9ss%E5%AE%A2%E6%88%B7%E7%AB%AF)%20%7C%20%E8%BE%A3%E6%9D%A1%E9%83%A8%E8%90%BD%E6%A0%BC&source=Centos7%E6%90%AD%E5%BB%BASSR(%E5%85%BC%E5%AE%B9ss%E5%AE%A2%E6%88%B7%E7%AB%AF)%20%7C%20%E8%BE%A3%E6%9D%A1%E9%83%A8%E8%90%BD%E6%A0%BC&desc=%E7%AC%AC%E4%B8%80%EF%BC%9A%E6%90%AD%E5%BB%BAssr%20wget%20https%3A%2F%2Fraw.githubusercontent.com%2F%5C%20ToyoDAdoubi%2Fdoubi%2Fmaster%2Fssr.sh%20chmod%20%2Bx%20ssr.sh%20%26%26%20bash%20ssr.sh%20%E7%AC%AC%E4%BA%8C%EF%BC%9A%E5%90%AF%E7%94%A8google%E7%9A%84tcp%E5%8A%A0%E9%80%9F&pics=https%3A%2F%2Fqiniu.wsfnk.com%2Fssr-1.png)[](Centos7搭建SSR(兼容ss客户端)%20_%20辣条部落格.md#)[](http://share.v.t.qq.com/index.php?c=share&a=index&title=Centos7%E6%90%AD%E5%BB%BASSR(%E5%85%BC%E5%AE%B9ss%E5%AE%A2%E6%88%B7%E7%AB%AF)%20%7C%20%E8%BE%A3%E6%9D%A1%E9%83%A8%E8%90%BD%E6%A0%BC&url=https%3A%2F%2Fboke.wsfnk.com%2Farchives%2F601.html&pic=https%3A%2F%2Fqiniu.wsfnk.com%2Fssr-1.png)[](http://shuo.douban.com/!service/share?href=https%3A%2F%2Fboke.wsfnk.com%2Farchives%2F601.html&name=Centos7%E6%90%AD%E5%BB%BASSR(%E5%85%BC%E5%AE%B9ss%E5%AE%A2%E6%88%B7%E7%AB%AF)%20%7C%20%E8%BE%A3%E6%9D%A1%E9%83%A8%E8%90%BD%E6%A0%BC&text=%E7%AC%AC%E4%B8%80%EF%BC%9A%E6%90%AD%E5%BB%BAssr%20wget%20https%3A%2F%2Fraw.githubusercontent.com%2F%5C%20ToyoDAdoubi%2Fdoubi%2Fmaster%2Fssr.sh%20chmod%20%2Bx%20ssr.sh%20%26%26%20bash%20ssr.sh%20%E7%AC%AC%E4%BA%8C%EF%BC%9A%E5%90%AF%E7%94%A8google%E7%9A%84tcp%E5%8A%A0%E9%80%9F&image=https%3A%2F%2Fqiniu.wsfnk.com%2Fssr-1.png&starid=0&aid=0&style=11)[](http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=https%3A%2F%2Fboke.wsfnk.com%2Farchives%2F601.html&title=Centos7%E6%90%AD%E5%BB%BASSR(%E5%85%BC%E5%AE%B9ss%E5%AE%A2%E6%88%B7%E7%AB%AF)%20%7C%20%E8%BE%A3%E6%9D%A1%E9%83%A8%E8%90%BD%E6%A0%BC&desc=%E7%AC%AC%E4%B8%80%EF%BC%9A%E6%90%AD%E5%BB%BAssr%20wget%20https%3A%2F%2Fraw.githubusercontent.com%2F%5C%20ToyoDAdoubi%2Fdoubi%2Fmaster%2Fssr.sh%20chmod%20%2Bx%20ssr.sh%20%26%26%20bash%20ssr.sh%20%E7%AC%AC%E4%BA%8C%EF%BC%9A%E5%90%AF%E7%94%A8google%E7%9A%84tcp%E5%8A%A0%E9%80%9F&summary=%E7%AC%AC%E4%B8%80%EF%BC%9A%E6%90%AD%E5%BB%BAssr%20wget%20https%3A%2F%2Fraw.githubusercontent.com%2F%5C%20ToyoDAdoubi%2Fdoubi%2Fmaster%2Fssr.sh%20chmod%20%2Bx%20ssr.sh%20%26%26%20bash%20ssr.sh%20%E7%AC%AC%E4%BA%8C%EF%BC%9A%E5%90%AF%E7%94%A8google%E7%9A%84tcp%E5%8A%A0%E9%80%9F&site=Centos7%E6%90%AD%E5%BB%BASSR(%E5%85%BC%E5%AE%B9ss%E5%AE%A2%E6%88%B7%E7%AB%AF)%20%7C%20%E8%BE%A3%E6%9D%A1%E9%83%A8%E8%90%BD%E6%A0%BC)[](http://www.linkedin.com/shareArticle?mini=true&ro=true&title=Centos7%E6%90%AD%E5%BB%BASSR(%E5%85%BC%E5%AE%B9ss%E5%AE%A2%E6%88%B7%E7%AB%AF)%20%7C%20%E8%BE%A3%E6%9D%A1%E9%83%A8%E8%90%BD%E6%A0%BC&url=https%3A%2F%2Fboke.wsfnk.com%2Farchives%2F601.html&summary=%E7%AC%AC%E4%B8%80%EF%BC%9A%E6%90%AD%E5%BB%BAssr%20wget%20https%3A%2F%2Fraw.githubusercontent.com%2F%5C%20ToyoDAdoubi%2Fdoubi%2Fmaster%2Fssr.sh%20chmod%20%2Bx%20ssr.sh%20%26%26%20bash%20ssr.sh%20%E7%AC%AC%E4%BA%8C%EF%BC%9A%E5%90%AF%E7%94%A8google%E7%9A%84tcp%E5%8A%A0%E9%80%9F&source=Centos7%E6%90%AD%E5%BB%BASSR(%E5%85%BC%E5%AE%B9ss%E5%AE%A2%E6%88%B7%E7%AB%AF)%20%7C%20%E8%BE%A3%E6%9D%A1%E9%83%A8%E8%90%BD%E6%A0%BC&armin=armin)[](https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fboke.wsfnk.com%2Farchives%2F601.html)[](https://twitter.com/intent/tweet?text=Centos7%E6%90%AD%E5%BB%BASSR(%E5%85%BC%E5%AE%B9ss%E5%AE%A2%E6%88%B7%E7%AB%AF)%20%7C%20%E8%BE%A3%E6%9D%A1%E9%83%A8%E8%90%BD%E6%A0%BC&url=https%3A%2F%2Fboke.wsfnk.com%2Farchives%2F601.html&via=https%3A%2F%2Fboke.wsfnk.com)[](https://plus.google.com/share?url=https%3A%2F%2Fboke.wsfnk.com%2Farchives%2F601.html)

### 最后编辑于：2018/10/11作者： 辣条①号

 ![9b5f6f65f02b02aa504df515715519d6](../_resources/21056327f177423a831bb281c6fd2cf7.jpg)

欲求广而精

- [阅读 辣条①号 的其他文章](https://boke.wsfnk.com/archives/author/fnk)

- [访问 辣条①号 的网站](https://boke.wsfnk.com/)

### 相关文章

 [![](../_resources/5b9ae9a047483728ac3247d0a9492c87.png)](https://boke.wsfnk.com/archives/759.html)

### [LVM日常管理之一（卷组的导出与导入）](https://boke.wsfnk.com/archives/759.html)

 **2019年2月19日  **11 views

 [![](../_resources/5b9ae9a047483728ac3247d0a9492c87.png)](https://boke.wsfnk.com/archives/755.html)

### [通过网络进行数据转移(windows+linux皆适用)](https://boke.wsfnk.com/archives/755.html)

 **2019年1月31日  **39 views

[上一篇： 网络基础知识（理论）«](https://boke.wsfnk.com/archives/589.html)

[下一篇： smokeping-2.7.2最新版安装教程»](https://boke.wsfnk.com/archives/610.html)

### 暂无评论

### 发表评论

电子邮件地址不会被公开。 必填项已用*标注

姓名 *
电子邮件 *
站点

有人回复时邮件通知我