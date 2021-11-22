mysql my.cnf 配置建议-ztguang-ChinaUnix博客

http://blog.csdn.net/hzcyclone/archive/2010/08/18/5821370.aspx
mysql的配置文件是/etc/my.cnf，通过修改它来配置mysql。
/etc/my.cnf来自以下文件：
如果你的内存≤64M，则复制/usr/share/doc/mysql/my-small.cnf为/etc/my.cnf

# This is for a system with little memory (<= 64M) where MySQL is only used

# from time to time and it’s important that the mysqld daemon

# doesn’t use much resources.

如果内存是128M，则复制/usr/share/doc/mysql/my-medium.cnf为/etc/my.cnf

# This is for a system with little memory (32M – 64M) where MySQL plays

# an important part, or systems up to 128M where MySQL is used together with

# other programs (such as a web server)

如果内存是512M，则复制/usr/share/doc/mysql/my-large.cnf为/etc/my.cnf

# This is for a large system with memory = 512M where the system runs mainly

# MySQL.

如果内存是1-2G，则复制/usr/share/doc/mysql/my-huge.cnf为/etc/my.cnf

# This is for a large system with memory of 1G-2G where the system runs mainly

# MySQL.

如果内存是4G，则复制/usr/share/doc/mysql/my-innodb-heavy-4G.cnf为/etc/my.cnf

# This is a MySQL example config file for systems with 4GB of memory

# running mostly MySQL using InnoDB only tables and performing complex

# queries with few connections.

不过MySQL参数那么多，很多时候我们还是要知道他们具体的含义才能根据实际问题做出具体的调整。
———————————–
我们可以通过SHOW VARIABLES;来查看系统参数，通过SHOW STATUS;来判断系统状态。
———————————–
先来看看table_cache参数对性能的影响。摘录my-innodb-heavy-4G.cnf中对它的描述：

# The number of open tables for all threads. Increasing this value

# increases the number of file descriptors that mysqld requires.

# Therefore you have to make sure to set the amount of open files

# allowed to at least 4096 in the variable “open-files-limit” in

# section [mysqld_safe]

table_cache = 2048

比 如：当系统比较繁忙的时候，我们show variables;查到table_cache的值，再show status;发现open_tables的值和table_cache差不多，而且opened_tables还一直再增加，就说明我们的 table_cache设置的太小了。

+++++++++++++++++++++++++++++++++++++++++++++

http://www.ttadd.com/diannao/HTML/247067.html

　　MySQL中有很多的基本命令，show命令也是其中之一，在很多使用者中对show命令的使用还容易产生混淆，本文汇集了show命令的众多用法。
　　a. show tables或show tables from database_name; -- 显示当前数据库中所有表的名称。
　　b. show databases; -- 显示mysql中所有数据库的名称。

　　c. show columns from table_name from database_name; 或show columns from database_name.table_name; -- 显示表中列名称。

　　d. show grants for user_name; -- 显示一个用户的权限，显示结果类似于grant 命令。
　　e. show index from table_name; -- 显示表的索引。
　　f. show status; -- 显示一些系统特定资源的信息，例如，正在运行的线程数量。
　　g. show variables; -- 显示系统变量的名称和值。

　　h. show processlist; -- 显示系统中正在运行的所有进程，也就是当前正在执行的查询。大多数用户可以查看他们自己的进程，但是如果他们拥有process权限，就可以查看所有人的进程，包括密码。

　　i. show table status; -- 显示当前使用或者指定的database中的每个表的信息。信息包括表类型和表的最新更新时间。
　　j. show privileges; -- 显示服务器所支持的不同权限。
　　k. show create database database_name; -- 显示create database 语句是否能够创建指定的数据库。
　　l. show create table table_name; -- 显示create database 语句是否能够创建指定的数据库。
　　m. show engies; -- 显示安装以后可用的存储引擎和默认引擎。
　　n. show innodb status; -- 显示innoDB存储引擎的状态。
　　o. show logs; -- 显示BDB存储引擎的日志。
　　p. show warnings; -- 显示最后一个执行的语句所产生的错误、警告和通知。
　　q. show errors; -- 只显示最后一个执行语句所产生的错误。
　　r. show [storage] engines; --显示安装后的可用存储引擎和默认引擎。

++++++++++++++++++++++++++++++++++++++++++++++++++++++++

http://taink.javaeye.com/?show_full=true

MySQL 是一个很棒的 open source 数据库引擎，大部分的网站和博客都是由 MySQL 驱动的。MySQL 的默认安装占用的内存资源比较大（相对于一个只有 64MB 的 VPS来说），优化 MySQL 可以减少内存消耗，把更多的内存省下来留给其他程序。

MySQL 的配置文件在 /etc/mysql/my.cnf（Debian 5），为了方便调整配置，MySQL 为小资源系统提供了一个叫做 my-small.cnf 的配置文件，是给小于 32MB 内存的服务器设置的。我们可以在这个配置文件的基础上作小部分的调整。

先找到 /usr/share/doc/mysql-server-5.0/examples/my-small.cnf，然后覆盖 /etc/mysql/my.cnf（Debian）。如果是 CentOS 5 的话，路径是：/usr/share/doc/mysql-server-5.0.45/my-small.cnf，覆盖 /etc/my.cnf。

#### 参数说明

如果不使用 BDB table 和 InnoDB table 的话，加入下面2行关闭不需要的表类型很有必要，关闭 innodb 可以省下大量内存，虽然 InnoDB 好处多多但是在一个64MB的 VPS 上并不能体现出来，并且很占内存。

skip-bdb
skip-innodb

key_buffer 是优化性能的重要参数，用来缓存 tables keys 和 indexes，增加这个值可以更好的处理索引，读和写都需要索引。这里设设置成 16K 足够了。table_cache 是所有线程打开的表的数量，增加值可以增大 MySQL 的文件描述符数量，避免频繁的打开表，原始 my-small.cnf 中 table_cache 设置成4有点小，一个 wordpress 的页面通常会涉及到10个左右的表，其他的程序比如 Drupal，MediaWiki 会涉及到更多，将table_cache改为8。

key_buffer = 16K
table_cache = 8

max_connections 是数据库最大的连接数量，可以根据自己博客/网站的访问量来定这个值。如果博客/网站经常出现：Too many connections 错误的信息说明需要增大 max_connections 的值。thread_concurrency 是最大并发线程数，通常设置为 CPU核数量×2，在 VPS 宿主机上如果服务器有2颗物理 CPU，而每颗物理 CPU 又支持 H.T 超线程（一个处理器上整合了两个逻辑处理器单元），所以实际取值为4 × 2 ＝ 8。

如果我们在优化 php.ini 的时候设置了同时只有2个 php-cgi 运行的话，那么我们也应该只设置2个 MySQL 线程同时运行。
max_connections = 16
thread_concurrency = 2
对于博客/新闻网站来说，用得最多的就是查询，所以需要加入 query cache 的设置。query_cache_size 是执行查询所使用的缓冲大小。
query_cache_limit = 256K
query_cache_size = 4M
thread_stack 用来存放每个线程的标识信息，如线程 id，线程运行时环境等，可以通过设置 thread_stack 来决定给每个线程分配多大的内存。

sort_buffer_size 是每个需要排序的线程分配的缓冲区大小，增加该值可以加速 order by 和 group by 的操作。注意：该参数是以每个连接分配内存，也就是说，如果有16个连接，sort_buffer_size 为 64K，那么实际分配的内存为：16 × 64K = 1MB。如果设置的缓存大小无法满足需要，MySQL 会将数据写入磁盘来完成排序。因为磁盘操作和内存操作不在一个数量级，所以 sort_buffer_size 对排序的性能影响很大。

read_buffer_size 是顺序读取数据时的缓冲区大小，与 sort_buffer_size 一样，该参数分配的内存也是以每连接为单位的。read_buffer_size 是用来当需要顺序读取数据的时候，如无发使用索引的情况下的全表扫描，全索引扫描等。在这种时候，MySQL 按照数据的存储顺序依次读取数据块，每次读取的数据快首先会暂存在 read_buffer_size 中，当 buffer 空间被写满或者全部数据读取结束后，再将 buffer 中的数据返回给上层调用者，以提高效率。

read_rnd_buffer_size 是随机读取数据时的缓冲区大小，与顺序读相对应。

net_buffer_size 用来存放客户端连接线程的连接信息和返回客户端的结果集的缓存大小。当 MySQL 接到请求后，产生返回结果集时，会在返回给请求线程之前暂存在在这个缓存中，等积累到一定大小的时候才开始向客户端发送，以提高网络效率。不 过，net_buffer_size 所设置的仅仅只是初始大小，MySQL 会根据实际需要自行申请更多的内存，但最大不会超过 max_allowed_packet。

sort_buffer_size = 64K
read_buffer_size = 256K
read_rnd_buffer_size = 256K
net_buffer_length = 2K
thread_stack = 64K
skip-locking用来避免 MySQL 外部锁定，减少出错几率，增强稳定性。
skip-locking

#### 优化后配置

经优化后，my.cnf 的配置如下，top 查看 mysqld 保持在 5M 一下。
[mysqld]
port = 3306
socket = /var/run/mysqld/mysqld.sock
skip-locking
key_buffer = 16K
query_cache_limit = 256K
query_cache_size = 4M
max_allowed_packet = 1M
table_cache = 8
max_connections = 16
thread_concurrency = 2
sort_buffer_size = 64K
read_buffer_size = 256K
read_rnd_buffer_size = 256K
net_buffer_length = 2K
thread_stack = 64K
skip-bdb
skip-innodb
[mysqldump]
quick
max_allowed_packet = 16M
[mysql]
no-auto-rehash
#safe-updates
[isamchk]
key_buffer = 8M
sort_buffer_size = 8M
[myisamchk]
key_buffer = 8M
sort_buffer_size = 8M
[mysqlhotcopy]
interactive-timeout

#### 内存计算公式

#### MySQL memory = key_buffer + max_connections *

#### (join_buffer + record_buffer + sort_buffer + thread_stack + tmp_table_size)

+++++++++++++++++++++++++++++++++++++++++++++++++

在整体的系统运行过程中，数据库服务器 MySQL 的压力是最大的，不仅占用很多的内存和 cpu 资源，而且占用着大部分的磁盘 io 资源， 连 PHP 的官方都在声称，说 PHP 脚本 80% 的时间都在等待 MySQL 查询返回的结果。由此可见，提高系统的负载能力，降 低 MySQL 的资源消耗迫在眉睫。

 1、页面缓存功能：

 页面缓存功能降低MySQL的资源消耗的（系统本身就已经考虑，采用生成HTML页面，大大降低了数据库的压力）。

 2、mysql服务器的优化
   2.1、修改全站搜索

     修改my.ini(my.cnf) ，在 [mysqld] 后面加入一行“ft_min_word_len=1”，然后重启Mysql，再登录网站后台（模块管理->全站搜索）重建全文索引。

   2.2、记录慢查询sql语句，修改my.ini(my.cnf)，添加如下代码：
     #log-slow-queries
     long_query_time = 1 #是指执行超过多久的 sql 会被 log 下来
     log-slow-queries = E:/wamp/logs/slow.log #设置把日志写在那里，可以为空，系统会给一个缺省的文件
     #log-slow-queries = /var/youpath/slow.log linux下     host_name-slow.log
     log-queries-not-using-indexes
   2.3、mysql缓存的设置

    mysql>show variables like '%query_cache%';     mysql本身是有对sql语句缓存的机制的，合理设置我们的mysql缓存可以降低数据库的io资源。

     #query_cache_type= 查询缓存的方式(默认是 ON)
     query_cache_size 如果你希望禁用查询缓存，设置 query_cache_size=0。禁用了查询缓存，将没有明显的开销
     query_cache_limit 不缓存大于这个值的结果。(缺省为 1M)
    2.4、查询缓存的统计信息
    mysql> SHOW STATUS LIKE ‘qcache%’;

      Qcache_free_blocks 缓存中相邻内存块的个数。数目大说明可能有碎片。FLUSH QUERY CACHE 会对缓存中的碎片进行整理，从而得到一个空闲块。

     Qcache_free_memory 缓存中的空闲内存。
     Qcache_hits 每次查询在缓存中命中时就增大。

     Qcache_inserts 每次插入一个查询时就增大。命中次数除以插入次数就是不中比率；用 1 减去这个值就是命中率。在上面这个例子中，大约有 87% 的查询都在缓存中命中。

     Qcache_lowmem_prunes 缓 存出现内存不足并且必须要进行清理以便为更多查询提供空间的次数。这个数字最好长时间来看；如果这个数字在不断增长，就表示可能碎片非常严重，或者内存很 少。（上面的 free_blocks 和 free_memory 可以告诉您属于哪种情况）。

     Qcache_not_cached 不适合进行缓存的查询的数量，通常是由于这些查询不是 SELECT 语句。
     Qcache_queries_in_cache 当前缓存的查询（和响应）的数量。

     Qcache_total_blocks 缓存中块的数量。通常，间隔几秒显示这些变量就可以看出区别，这可以帮助确定缓存是否正在有效地使用。运行 FLUSH STATUS 可以重置一些计数器，如果服务器已经运行了一段时间，这会非常有帮助。

    2.5、my.ini(my.conf)配置
     2.5.1、key_buffer_size = 256M

     # key_buffer_size指定用于索引的缓冲区大小，增加它可得到更好的索引处理性能。     对于内存在4GB左右的服务器该参数可设置为256M或384M。注意：该参数值设置的过大反而会是服务器整体效率降低！

     2.5.2、
     max_allowed_packet = 4M
     thread_stack = 256K
     table_cache = 128K
     sort_buffer_size = 6M

     查询排序时所能使用的缓冲区大小。注意：该参数对应的分配内存是每连接独占！如果有100个连接，那么实际分配的总共排序缓冲区大小为100 × 6 ＝ 600MB。所以，对于内存在4GB左右的服务器推荐设置为6-8M。

     2.5.3、
     read_buffer_size = 4M
     读查询操作所能使用的缓冲区大小。和sort_buffer_size一样，该参数对应的分配内存也是每个连接独享！
     2.5.4、join_buffer_size = 8M
     联合查询操作所能使用的缓冲区大小，和sort_buffer_size一样，该参数对应的分配内存也是每个连接独享！
     2.5.5、
     myisam_sort_buffer_size = 64M
     table_cache = 512
     thread_cache_size = 64
     query_cache_size = 64M
     指定MySQL查询缓冲区的大小。可以通过在MySQL控制台执行以下命令观察：
     # > SHOW VARIABLES LIKE '%query_cache%';
     # > SHOW STATUS LIKE 'Qcache%';
     # 如果Qcache_lowmem_prunes的值非常大，则表明经常出现缓冲不够的情况；
     #如果Qcache_hits的值非常大，则表明查询缓冲使用非常频繁，如果该值较小反而会影响效率，那么可以考虑不用查询缓冲；
     Qcache_free_blocks，如 果该值非常大，则表明缓冲区中碎片很多
     2.5.6、
     tmp_table_size = 256M
      max_connections = 768
     指定MySQL允许的最大连接进程数。如果在访问论坛时经常出现Too Many Connections的错误提示，则需要增大该参数值。
     2.5.7、
     max_connect_errors = 10000000
     wait_timeout = 10
     指定一个请求的最大连接时间，对于4GB左右内存的服务器可以设置为5-10。
     2.5.8、
     thread_concurrency = 8
     该参数取值为服务器逻辑CPU数量×2，如果服务器有2颗物理CPU，而每颗物理CPU又支持H.T超线程，所以实际取值为4 × 2 ＝ 8
      2.5.9、
     skip-networking

     开启该选项可以彻底关闭MySQL的TCP/IP连接方式，如果WEB服务器是以远程连接的方式访问MySQL数据库服务器则不要开启该选项！否则将无法正常连接！