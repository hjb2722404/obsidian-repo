svnserve: Can’t bind server socket: Address already in use报错解决办法_懒人程序

#

# svnserve: Can’t bind server socket: Address already in use报错解决办法

 ![Created](../_resources/7acc4f3de4239ea06853f52de6e0391e.png)2015-08-17   ![Views](../_resources/17d0befc9e59ec5534750011072d5b9d.gif) 515    ![Author](../_resources/ad28eefacc63e19d639bfcdc9e3e6216.png) 懒人程序       .

 返错

[svn](http://zhannei.baidu.com/cse/search?s=326913546274321940&entry=1&q=svn)serve: Can’t bind server socket: Address already in use

我们可以按照以下方法解决。
1.ps -aux | grep svn
kill pid（pid为ps出的pid这样就停止服务了）
2.我们可以试着重新指定一个端口8081 使用 -- listen-port 8081参数。
svnserve -d -r /home/svn/ --listen-port 8081

## 看过本文的人还看过

- 2013-06-19[linux kill 关闭进程命令](http://www.kuitao8.com/20130619/101.shtml)

 [下载PDF](http://www.kuitao8.com/20150817/3926.shtml#pdfdown)

.

上一篇: [Linux 的cp命令](http://www.kuitao8.com/20150813/3920.shtml)

下一篇: [linux下使用rsync同步备份](http://www.kuitao8.com/20150817/3927.shtml)

支持键盘 ←　→
 .

[(L)](http://www.kuitao8.com/20150817/3926.shtml#)[(L)](http://www.kuitao8.com/20150817/3926.shtml#)[(L)](http://www.kuitao8.com/20150817/3926.shtml#)[(L)](http://www.kuitao8.com/20150817/3926.shtml#)[(L)](http://www.kuitao8.com/20150817/3926.shtml#)[(L)](http://www.kuitao8.com/20150817/3926.shtml#)[(L)](http://www.kuitao8.com/20150817/3926.shtml#)[(L)](http://www.kuitao8.com/20150817/3926.shtml#)[(L)](http://www.kuitao8.com/20150817/3926.shtml#)[(L)](http://www.kuitao8.com/20150817/3926.shtml#).

.