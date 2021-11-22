mysql的sql_mode合理设置 - 冰刀(skate) - CSDN博客

#   [mysql的sql_mode合理设置](http://blog.csdn.net/wyzxg/article/details/8787878)

 2013-04-11 13:54  52140人阅读    [评论](http://blog.csdn.net/wyzxg/article/details/8787878#comments)(0)    [收藏](mysql的sql_mode合理设置%20-%20冰刀(skate)%20-%20CSDN博客.md#)    [举报](http://blog.csdn.net/wyzxg/article/details/8787878#report)

 .

 ![](http://static.blog.csdn.net/images/category_icon.jpg)  分类：

   Mysql Management*（62）*  ![](http://static.blog.csdn.net/images/arrow_triangle%20_down.jpg)

[作者同类文章](http://blog.csdn.net/wyzxg/article/category/609247)*X*

 .

版权声明：本文为博主原创文章，未经博主允许不得转载。

author：skate
time:2013/04/11

**mysql的sql_mode合理设置**

sql_mode是个很容易被忽视的变量，默认值是空值，在这种设置下是可以允许一些非法操作的，比如允许一些非法数据的插入。在生产环境必须将这个值设置为严格模式，所以开发、测试环境的数据库也必须要设置，这样在开发测试阶段就可以发现问题

**sql_mode常用值如下：**
ONLY_FULL_GROUP_BY：
对于GROUP BY聚合操作，如果在SELECT中的列，没有在GROUP BY中出现，那么这个SQL是不合法的，因为列不在GROUP BY从句中

NO_AUTO_VALUE_ON_ZERO：
该值影响自增长列的插入。默认设置下，插入0或NULL代表生成下一个自增长值。如果用户 希望插入的值为0，而该列又是自增长的，那么这个选项就有用了。

STRICT_TRANS_TABLES：
在该模式下，如果一个值不能插入到一个事务表中，则中断当前的操作，对非事务表不做限制
NO_ZERO_IN_DATE：
在严格模式下，不允许日期和月份为零

NO_ZERO_DATE：
设置该值，mysql数据库不允许插入零日期，插入零日期会抛出错误而不是警告。

ERROR_FOR_DIVISION_BY_ZERO：
在INSERT或UPDATE过程中，如果数据被零除，则产生错误而非警告。如 果未给出该模式，那么数据被零除时MySQL返回NULL

NO_AUTO_CREATE_USER：
禁止GRANT创建密码为空的用户

NO_ENGINE_SUBSTITUTION：
如果需要的存储引擎被禁用或未编译，那么抛出错误。不设置此值时，用默认的存储引擎替代，并抛出一个异常

PIPES_AS_CONCAT：
将"||"视为字符串的连接操作符而非或运算符，这和Oracle数据库是一样的，也和字符串的拼接函数Concat相类似

ANSI_QUOTES：
启用ANSI_QUOTES后，不能用双引号来引用字符串，因为它被解释为识别符

ORACLE的sql_mode设置等同：PIPES_AS_CONCAT, ANSI_QUOTES, IGNORE_SPACE, NO_KEY_OPTIONS, NO_TABLE_OPTIONS, NO_FIELD_OPTIONS, NO_AUTO_CREATE_USER.

**如果使用mysql，为了继续保留大家使用oracle的习惯，可以对mysql的sql_mode设置如下**：

在my.cnf添加如下配置
[mysqld]

sql_mode='ONLY_FULL_GROUP_BY,NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,

ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION,PIPES_AS_CONCAT,ANSI_QUOTES'

参考：http://dev.mysql.com/doc/refman/5.5/en/server-sql-mode.html

------end------

[(L)](http://blog.csdn.net/wyzxg/article/details/8787878#)[(L)](http://blog.csdn.net/wyzxg/article/details/8787878#)[(L)](http://blog.csdn.net/wyzxg/article/details/8787878#)[(L)](http://blog.csdn.net/wyzxg/article/details/8787878#)[(L)](http://blog.csdn.net/wyzxg/article/details/8787878#)[(L)](http://blog.csdn.net/wyzxg/article/details/8787878#).

顶

3

踩

0

[mysql的sql_mode合理设置 - 冰刀(skate) - CSDN博客](mysql的sql_mode合理设置%20-%20冰刀(skate)%20-%20CSDN博客.md#)

 [mysql的sql_mode合理设置 - 冰刀(skate) - CSDN博客](mysql的sql_mode合理设置%20-%20冰刀(skate)%20-%20CSDN博客.md#)

- 上一篇[mysql索引测试案例](http://blog.csdn.net/wyzxg/article/details/8784582)

- 下一篇[mysql replication环境检查脚本](http://blog.csdn.net/wyzxg/article/details/8929313)

####

  相关文章推荐

- *•*  [mysql的sql_mode 模式修改 my.cnf](http://blog.csdn.net/wulantian/article/details/8905573)

- *•*  [Go语言编程入门实战技巧](http://edu.csdn.net/course/detail/2306?utm_source=blog7)

- *•*  [sql_mode=only_full_group_by研读](http://blog.csdn.net/Allen_Tsang/article/details/54892046)

- *•*  [机器学习大咖在等你](http://edu.csdn.net/huiyiCourse/series_detail/65?utm_source=blog7)

- *•*  [incompatible with sql_mode=only_full_group_by](http://blog.csdn.net/hw1287789687/article/details/50990062)

- *•*  [Android高手进阶](http://edu.csdn.net/course/detail/1923?utm_source=blog7)

- *•*  [mysql命令gruop by报错this is incompatible with sql_mode=only_full_group_by](http://blog.csdn.net/tomcat_2014/article/details/53381529)

- *•*  [深入探究Linux/VxWorks的设备树](http://edu.csdn.net/course/detail/5627?utm_source=blog7)

- *•*  [MYSQL5.7版本sql_mode=only_full_group_by问题 5.7就是个坑](http://blog.csdn.net/zqinghai/article/details/62882255)

- *•*  [SDCC 2017之区块链技术实战线上峰会](http://edu.csdn.net/huiyiCourse/series_detail/66?utm_source=blog7)

- *•*  [关于sql_mode的设置问题](http://blog.csdn.net/LHN_hpu/article/details/52200792)

- *•*  [SDCC 2017之大数据技术实战线上峰会](http://edu.csdn.net/huiyiCourse/series_detail/64?utm_soruce=blog7)

- *•*  [MySQL的sql_mode解析与设置](http://blog.csdn.net/CCCCalculator/article/details/70432123)

- *•*  [Mysql sql_Model](http://blog.csdn.net/lploveme/article/details/8258190)

- *•*  [mysql 的sql_model模式](http://blog.csdn.net/baidu_19338587/article/details/59483954)

- *•*  [MySQL的sql_mode合理设置](http://blog.csdn.net/cheng564943797/article/details/53884160)