# [【转】mysql的SQL_NO_CACHE(在查询时不使用缓存)和sql_cache用法](https://www.cnblogs.com/wangjuns8/p/7840730.html)

转自：http://www.169it.com/article/5994930453423417575.html

为了测试sql语句的效率，有时候要不用缓存来查询。
使用
SELECT SQL_NO_CACHE ...
语法即可

SQL_NO_CACHE的真正作用是禁止缓存查询结果，但并不意味着cache不作为结果返回给query。

目前流传的SQL_NO_CACHE不外乎两种解释：
1.对当前query不使用数据库已有缓存来查询，则当前query花费时间会多点
2.对当前query的产生的结果集不缓存至系统query cache里，则下次相同query花费时间会多点
我做了下实验，似乎两种都对。

sql_cache意思是说，查询的时候使用缓存。

对SQL_NO_CACHE的解释及测试如下:

SQL_NO_CACHE means that the query result is not cached. It does not mean that the cache is not used to answer the query.

You may use RESET QUERY CACHE to remove all queries from the cache and then your next query should be slow again. Same effect if you change the table, because this makes all cached queries invalid.
```
mysql> select count(*) from users where email = 'hello';
+----------+

| count(*) |

+----------+

| 0 |

+----------+
1 row in set (7.22 sec)

mysql> select count(*) from users where email = 'hello';
+----------+

| count(*) |

+----------+

| 0 |

+----------+
1 row in set (0.45 sec)

mysql> select count(*) from users where email = 'hello';
+----------+

| count(*) |

+----------+

| 0 |

+----------+
1 row in set (0.45 sec)

mysql> select SQL_NO_CACHE count(*) from users where email = 'hello';
+----------+

| count(*) |

+----------+

| 0 |

+----------+
1 row in set (0.43 sec)

================MyBatis的对CACHE的应用======================
```
**MyBatis的flushCache和useCache的使用**
转自：http://blog.csdn.net/ssssny/article/details/52248960

（1）当为select语句时：
flushCache默认为false，表示任何时候语句被调用，都不会去清空本地缓存和二级缓存。
useCache默认为true，表示会将本条语句的结果进行二级缓存。

（2）当为insert、update、delete语句时：
flushCache默认为true，表示任何时候语句被调用，都会导致本地缓存和二级缓存被清空。
useCache属性在该情况下没有。

当为select语句的时候，如果没有去配置flushCache、useCache，那么默认是启用缓存的，所以，如果有必要，那么就需要人工修改配置，修改结果类似下面：

<select id="save" parameterType="XX" flushCache="true" useCache="false">
……
</select>

update 的时候如果 flushCache="false"，则当你更新后，查询的数据数据还是老的数据。

标签: [mysql](https://www.cnblogs.com/wangjuns8/tag/mysql/), [Mybatis](https://www.cnblogs.com/wangjuns8/tag/Mybatis/), [cache](https://www.cnblogs.com/wangjuns8/tag/cache/), [no_cache](https://www.cnblogs.com/wangjuns8/tag/no_cache/), [缓存](https://www.cnblogs.com/wangjuns8/tag/%E7%BC%93%E5%AD%98/)

https://www.cnblogs.com/wangjuns8/p/7840730.html#)