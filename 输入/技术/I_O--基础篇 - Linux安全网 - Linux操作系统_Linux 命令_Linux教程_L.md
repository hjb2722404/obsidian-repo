I/O--基础篇 - Linux安全网 - Linux操作系统_Linux 命令_Linux教程_Linux黑客

**什么是I/O**？

I/O即输入/输出(Input/Output)，是在主存和外部设备(如磁盘驱动器、终端和网络)之间拷贝数据的过程。输入操作时从I/O设备拷贝数据到主存，而输出操作是从主存拷贝数据到I/O设备。

# **什么是UnixI/O?**

要知道I/O设备都是千差万别的，有磁带、有磁盘、有光驱、有终端、有网络，但这些设备无外乎就做两件事，输入和输出。所以在Unix的对此就设计得非常聪明，将所有的I/O设备，如网络、磁盘和终端，都模型化为文件，而所有的输入和输出都被当做对相应文件的读和写来执行。这种将设备优雅地映射为文件的方式，允许Unix内核引出一个简单、低级的应用接口，称为Unix I/O。这使得所有的输入和输出都能以一种统一且一致的方式来执行。这样就极大程度地简化了提供给程序员的设备接口。

# **一切皆文件**

**前面也提到了一切设备都映射为文件，文件可以分为如下几类：****

特殊文件（special [*file*](http://www.linuxso.com/command/file.html)）**：所有的设备都用文件来表示，这些文件被称为特殊文件（special file），存放在/dev中。因此，磁盘文件和其他设备都用同一的方式来命名和访问。

**正常文件（regular file）: **只是磁盘上的一个普通文件。

**块特殊文件（block special file）:**表示特性与磁盘类似的设备。磁盘驱动程序以块或者组块的形式从块特殊设备中传送信息，这些设备通常具有从设备任何地方检索块的能力。

**字符特殊文件（character special file）:**表示特性和终端类似的设备。这些设备看起来表示的是一串必须按照顺序访问的字节流。

# **文件描述符**

一个应用程序通过要求内核打开相应的一个文件，来宣告他要访问一个I/O设备。内核返回一个非负整数，叫做文件描述符。文件描述符相当于一个逻辑句柄，以此将文件或物理设备进行关联，操作这个文件描述符就等同于操作这个文件或物理设备。

Unix Shell创建的每个进程开始时都有三个打开的文件：标准输入、标准输出、标准错误

|     |     |
| --- | --- |
| 文件描述符 | 对应的数字 |
| STDIN_FILENO 标准输入设备 | 0   |
| STDOUT_FILENO 标准输出设备 | 1   |
| STDERR_FILENO 标准错误设备 | 2   |

# **描述符表(descriptor table)**

****每个进程又有它独立的描述符表，它的表项是由进程打开的文件描述符来索引的。每个打开的描述符表项指向文件表中的一个表项。

# **文件表(file table)**

打开文件的集合是由一张文件表来表示的，所有的进程共享这张表。每个文件表的一个条目包含有当前的文件位置、引用计数(refere[*nc*](http://www.linuxso.com/command/nc.html)e count)(即当前有多少个描述符指向了这个文件)，以及一个指向v-node表中对应条目的指针。关闭一个描述符会减少相应的文件表条目中的引用计数。内核不会删除这个文件表的单条记录，直到它的引用计数为0.

# **v-node表(v-node table)**

****同文件表一样，所有的进程共享这张v-node表。每个表项包含[*stat*](http://www.linuxso.com/command/stat.html)结构中的大多数信息，包括st_mode和st_size成员。当程序打开一个当前没有打开的特定物理文件时，内核会在v-node表中创建一个条目。

上图为典型的打开文件的内核数据结构，两个描述符引用不同的文件。
![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210108141633.jpg)
了解了上面的概念之后，再进一步熟悉一下Unix I/O的API
**Unix I/O API**
**1.打开和关闭文件**
**open函数**:
open函数将一个文件描述符与一个文件或物理设备关联起来。**程序可以通过调用open函数来打开或创建一个文件**
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
int open(char *path , int flags, mode_t mode);

返回：成功的话返回打开的文件描述符（fil[*ed*](http://www.linuxso.com/command/ed.html)es），失败返回-1并设置errno.

***path***
****** 指向文件或设备的路径名。
***flags***
****** 为打开的文件指定状态标识符和访问模式。

可以通过对访问模式标识符和附加标识符进行按位或（|）的方式来构建oflag。访问模式标识符的POSIX值为O_RDONLY,O_WRONLY,O_RDWR。必须指定其中一个来说明只读，只写或读写访问。

附加标识符包括
 **O_APPEND** 写操作之前使文件偏移到文件末端，用于向一个已存在文件添加内容
 **O_CREAT**, 如果文件不存在，则创建之，同时必须向open函数传递第三个参数来指定权限
 **O_EXCL**, 避免重写文件，使用O_CREAT | O_EXCL的形式。如果文件已存在，则报错
 **O_NOCTTY**, 防止一个已打开的设备变成一个控制终端
 **O_NONBLOCK**, 控制open是立即返回还是阻塞到设备维持好
 **O_TRUNC **与APPEND相反，将写操作打开的文件长度删减为0
***mode***
****** 为访问权限。如果要创建一个文件，就要包含第三个参数来指定访问权限。
比如以只读方式打开：
int fd;
fd = open("foo.txt",O_RDONLY);
用户可以对新文件进行读写，所有其他人则只有读权限：
int fd;
mode_ t fdmode = (S_IRUSR | S_IWUSR | S_IRGRP | S_ IROTH);
if((fd = open("info.dat",O_RDWR | O_CREAT , fdmode))==-1)
perror("...");

**close函数**:
用于关闭一个打开的文件

#include <unistd.h>
int close(int fd);
返回：成功为0，出错为-1
 用户可以对新文件进行读写

## **2.读和写文件**

 用户可以对新文件进应用程序通过调用read和[*write*](http://www.linuxso.com/command/write.html)函数来执行输入和输出的。

**read函数**：

#include <unistd.h>

ssize_t read(int fd, vo[*id*](http://www.linuxso.com/command/id.html) *buf, size_t n);

返回:若成功则为读的字节数，若EOF则为0，若出错为-1
read函数从描述符为fd的当前文件位置拷贝最多n个字节到存储器位置buf。

**write函数**：

#include <unistd.h>
ssize_t write(int fd, const void *buf, size_t n);
返回：若成功则为写的字节数，若出错则为-1
write函数从存储器位置buf拷贝至多n个字节到描述符fd的当前文件位置。

### Standard I/O（标准I/O）

ANSI C定义了一组高级输入输出函数，称为标准I/O库，为程序员提供了Unix I/O的较高级别的替代。这个库(libc)提供了打开和关闭文件的函数(fopen 和 fclose)、读和写字节的函数(fread和fwrite)、读和写字符串的函数(fgets和fputs)，以及复杂的格式化的I/O函数(scanf和printf)。

标准I/O函数是磁盘和终端设备I/O之选。大多数C程序员在他们的职业生涯中只使用标准I/O，大多数情况下也推荐使用标准I/O。

- 查看图片附件