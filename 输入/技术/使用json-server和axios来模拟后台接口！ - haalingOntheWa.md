# 使用json-server和axios来模拟后台接口！

 2018-08-23 16:42:43  [haalingOntheWay](https://me.csdn.net/haalingOntheWay)  阅读数 574

   [(L)](http://creativecommons.org/licenses/by-sa/4.0/)   版权声明：本文为博主原创文章，遵循[CC 4.0 BY-SA](http://creativecommons.org/licenses/by-sa/4.0/)版权协议，转载请附上原文出处链接和本声明。

本文链接：https://blog.csdn.net/haalingOntheWay/article/details/81983293

1、安装

```
npm install json-server --save
npm install axios --save
```

2、创建一个.json文件（你需要模拟的数据）,放在index.html平级目录；
3、![70](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102121053.png)
5、设置代理接口：
![70](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102121108.png)
然后就可以通过localhost:3000访问到啦
![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201217150640.png)
6、引入axios（import axios from 'axios';要放在前面：就是绝对引入要放在相对引入前面）
 ![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201217150646.png)
7、发送请求获取数据：（用console.log(res.data) 访问数据）
![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201217150655.png)
8、结果：
![70](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201217150659.png)
完成啦！~开始下一步做项目啦~

  文章最后发布于: 2018-08-23 16:42:43
