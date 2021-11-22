## 【整理】fiddler不能监听 localhost和 127.0.0.1的问题


解决方案
1，用 [http://localhost](http://localhost/). (locahost紧跟一个点号)
2，用 [http://127.0.0.1](http://127.0.0.1/). (127.0.0.1紧跟一个点号)
3，用 [http://machinename](http://machinename/) (机器名)

4，将localhost、127.0.0.1全部替换为[http://ipv4.fiddler](http://ipv4.fiddler/)，这个是官方的解决方法。

5，修改host文件
C:\WINDOWS\system32\drivers\etc\hosts
可以添加一个自定义的域名，如：
127.0.0.1 mySpace
然后通过[Http://mySpace](http://myspace/)的方式去访问。

-