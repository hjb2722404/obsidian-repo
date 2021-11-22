centOS安装mongodb

1.确保服务器安装了wget工具，如果没有安装，使用以下命令安装：

yum install wget

2.使用wget命令下载mongodb最新版（最新下载地址可以去官网获得）

wget [(L)](https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-3.2.4.tgz)https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-3.2.4.tgz

3.解压缩：

tar zxvf mongodb-linux-86.....3.2.4.tgz (文件名太长，中间的我省略了)

4.移动到新目录下：

mv mongodb-linux-86.....3.2.4   mongodb

5.切换到新目录下

cd mongodb

6.创建数据存储目录：

mkdir -p data/db

7.创建日志存放目录

mkdir logs

8.创建日志记录文件：

touch logs/mongodb.log

9.切换到bin目录下

cd bin

10.执行运行命令

./mongod --dbpath ... --logpath .....

11.可能遇到的问题：

* * *

/lib64/libc.so.6: version `GLIBC_2.18' not found

解决办法：

去官网查看glibc-2.19版本下载链接：http://ftp.gnu.org/gnu/glibc/

下载：

wget [http://ftp.gnu.org/gnu/glibc/glibc-2.19.1.tar.gz](http://ftp.gnu.org/gnu/glibc/glibc-2.14.1.tar.gz)

解压：

tar xvf glibc-2.19.tar.gz

cd glibc-2.19

构建：

mkdir build

cd ./build

编译：

../configure --prefix=/opt/glibc-2.19

可能遇到的问题：

no acceptable C compiler found in $PATH

解决办法：

yum install gcc

重新编译：

../configure --prefix=/opt/glibc-2.19
make -j4
make install

修改临时环境变量：

vi /etc/profile

在文件末尾加入：

LD_LIBRARY_PATH=/opt/glibc-2.19-build/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH

保存退出

更新配置：

source /etc/profile

* * *

          /usr/lib64/libstdc++.so.6: version `GLIBCXX_3.4.18' not found

          到官网下载最新版本libstdc++:

          [(L)](http://ftp.de.debian.org/debian/pool/main/g)http://ftp.de.debian.org/debian/pool/main/g

          根据需要选择最新版，这里选择gcc-4.9

          [(L)](http://ftp.de.debian.org/debian/pool/main/g/gcc-4.9/)http://ftp.de.debian.org/debian/pool/main/g/gcc-4.9/

          复制libstdc++的下载链接，根据系统位数和需要复制相应下载链接：

          [(L)](http://ftp.de.debian.org/debian/pool/main/g/gcc-4.9/libstdc++6_4.9.2-10_amd64.deb)http://ftp.de.debian.org/debian/pool/main/g/gcc-4.9/libstdc++6_4.9.2-10_amd64.deb

          使用wget下载：

          wget [(L)](http://ftp.de.debian.org/debian/pool/main/g/gcc-4.9/libstdc++6_4.9.2-10_amd64.deb)http://ftp.de.debian.org/debian/pool/main/g/gcc-4.9/libstdc++6_4.9.2-10_amd64.deb

          解压deb文件：

          ar -x libstdc++6.4.9.2-10_adm64.deb

          得到data.tar.xz，解压该文件：

          xz -d data.tar.xz

                        可能遇到的问题：xz命令没有找到
                         解决办法：yum -y xz

          解压成功得到data.tar

          解压data.tar:

          tar xvf data.tar

          然后切换到解压出的libstdc++所在目录：

          cd usr/lib/x86-64-linux-gnu

          拷贝libstdc++库文件到系统库目录(根据64位和32位，分别为/usr/lib64和/usr/lib)

          cp libstdc++-so.6.0.20  /usr/lib64

            切换到系统库目录

               cd /usr/lib64

               删除旧的libstdc++库：

               rm -rf libstdc++-so.6

               建立新的软链接：

               ln libstdc++.so.6.0.20 libstdc++.so.6

               完成。

* * *