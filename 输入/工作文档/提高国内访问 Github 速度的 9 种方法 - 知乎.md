> 来源｜[https://urlify.cn/IFzQRb](https://link.zhihu.com/?target=https%3A//urlify.cn/IFzQRb)

因为某些原因，github 访问速度确实太慢了，图片经常刷不出来，甚至会出现项目无法下载的情况。

码云虽好，可目前还是无法代替 github 在编程界的地位。

今天，GitHubPorn 给大家推荐几种提高 github 访问速度的方案，挑自己喜欢的尝试就好！

  
**1\. GitHub 镜像访问**
----------------------

这里提供两个最常用的镜像地址：

*   [https://github.com.cnpmjs.org](https://link.zhihu.com/?target=https%3A//github.com.cnpmjs.org)
*   [https://hub.fastgit.org](https://link.zhihu.com/?target=https%3A//hub.fastgit.org)

也就是说上面的镜像就是一个克隆版的 GitHub，你可以访问上面的镜像网站，网站的内容跟 GitHub 是完整同步的镜像，然后在这个网站里面进行下载克隆等操作。

  
**2\. GitHub 文件加速**
----------------------

利用 Cloudflare Workers 对 github release 、archive 以及项目文件进行加速，部署无需服务器且自带CDN.

*   [https://gh.api.99988866.xyz](https://link.zhihu.com/?target=https%3A//gh.api.99988866.xyz)
*   [https://g.ioiox.com](https://link.zhihu.com/?target=https%3A//g.ioiox.com)

以上网站为演示站点，如无法打开可以查看开源项目：gh-proxy-GitHub([https://hunsh.net/archives/23/](https://link.zhihu.com/?target=https%3A//hunsh.net/archives/23/)) 文件加速自行部署。

**3\. Github 加速下载**
-------------------

只需要复制当前 GitHub 地址粘贴到输入框中就可以代理加速下载！

地址：[http://toolwa.com/github/](https://link.zhihu.com/?target=http%3A//toolwa.com/github/)

![](https://pic4.zhimg.com/v2-4dc6c6f860aee692dbf71acd76a9e95b_b.jpg)

**4\. 加速你的 Github**
-------------------

[https://github.zhlh6.cn](https://link.zhihu.com/?target=https%3A//github.zhlh6.cn)

输入 Github 仓库地址，使用生成的地址进行 git ssh 等操作

**5\. 谷歌浏览器 GitHub 加速插件(推荐)**
-----------------------------

![](https://pic3.zhimg.com/v2-3f1b72f19f4ff88b2a5402c244869bfa_b.jpg)
![](https://pic3.zhimg.com/v2-2563db0fb3a0f8bc89320c6dc36d99b6_b.jpg)

**6\. GitHub raw 加速**
---------------------

GitHub raw 域名并非 [http://github.com](https://link.zhihu.com/?target=http%3A//github.com) 而是 [http://raw.githubusercontent.com](https://link.zhihu.com/?target=http%3A//raw.githubusercontent.com)，上方的 GitHub 加速如果不能加速这个域名，那么可以使用 Static CDN 提供的反代服务。

将 [http://raw.githubusercontent.com](https://link.zhihu.com/?target=http%3A//raw.githubusercontent.com) 替换为 [http://raw.staticdn.net](https://link.zhihu.com/?target=http%3A//raw.staticdn.net) 即可加速。

**7\. GitHub + Jsdelivr**
-------------------------

jsdelivr 唯一美中不足的就是它不能获取 exe 文件以及 Release 处附加的 exe 和 dmg 文件。

也就是说如果 exe 文件是附加在 Release 处但是没有在 code 里面的话是无法获取的。所以只能当作静态文件 cdn 用途，而不能作为 Release 加速下载的用途。

**8\. 通过 Gitee 中转 fork 仓库下载**
-----------------------------

网上有很多相关的教程，这里简要的说明下操作。

访问 gitee 网站：[https://gitee.com/](https://link.zhihu.com/?target=https%3A//gitee.com/) 并登录，在顶部选择“从 GitHub/GitLab 导入仓库” 如下：

![](https://pic2.zhimg.com/v2-b75c0fa5d07bb12de3caae8b36794095_b.jpg)

在导入页面中粘贴你的Github仓库地址，点击导入即可：

![](https://pic3.zhimg.com/v2-41b441bb1278ad0065edc64f75011772_b.jpg)

等待导入操作完成，然后在导入的仓库中下载浏览对应的该 GitHub 仓库代码，你也可以点击仓库顶部的“刷新”按钮进行 Github 代码仓库的同步。

![](https://pic1.zhimg.com/v2-a7ac80ee298ec8d735f3fd1fdcdce794_b.jpg)

**9\. 通过修改 HOSTS 文件进行加速**
-------------------------

手动把cdn和ip地址绑定。

第一步：

获取 github 的 global.ssl.fastly

地址访问：

[http://github.global.ssl.fastly.net.ipaddress.com/#ipinfo](https://link.zhihu.com/?target=http%3A//github.global.ssl.fastly.net.ipaddress.com/%23ipinfo)

获取cdn和ip域名：

![](https://pic1.zhimg.com/v2-3799df08708c5411be3adc0708fd2154_b.jpg)

得到：

199.232.69.194 [https://github.global.ssl.fastly.net](https://link.zhihu.com/?target=https%3A//github.global.ssl.fastly.net)

第二步：获取[http://github.com](https://link.zhihu.com/?target=http%3A//github.com)地址

访问：

[https://github.com.ipaddress.com/#ipinfo](https://link.zhihu.com/?target=https%3A//github.com.ipaddress.com/%23ipinfo)

获取cdn和ip：

![](https://pic4.zhimg.com/v2-d039bd5c9ecc2ad176d1cd101d6453bb_b.jpg)

得到：

140.82.114.4 [http://github.com](https://link.zhihu.com/?target=http%3A//github.com)

第三步：修改 host 文件映射上面查找到的 IP

windows系统：

1、修改C:\\Windows\\System32\\drivers\\etc\\hosts文件的权限，指定可写入：右击->hosts->属性->安全->编辑->点击Users->在Users的权限“写入”后面打勾。如下：

![](https://pic2.zhimg.com/v2-bfc133fa4b2bc64ba68f74f1e11f9821_b.jpg)

然后点击确定。

2、右击->hosts->打开方式->选定记事本（或者你喜欢的编辑器）->在末尾处添加以下内容：

```text
199.232.69.194github.global.ssl.fastly.net
140.82.114.4 github.com
```

[【算法与数据结构】+一点点ACM从入门到进阶吐血整理推荐书单（珍藏版）​mp.weixin.qq.com![](https://pic3.zhimg.com/v2-ea38dff0c2c6f5b03640cea3718fb79e_180x120.jpg)
](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s/elSJT0CqKzu0TxqfEAMVQg)