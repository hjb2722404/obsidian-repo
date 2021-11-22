open_basedir restriction in effect错误解决办法

在访问PHP程序时，遇到了以下错误：
**
**

open_basedir restriction in effect. File(/) is not within the allowed path(s)；...

原因是因为php.ini设置了open_basedir，而使用require或者Include方法来引用文件时，如果没有显式的指定目录，则Php会根据open_basedir所设置的目录为前缀来寻找文件和目录，而open_basedir所设置的目录与用户的程序目录不同，所以发生找不到或者无权限的错误。

**解决办法：**

在http.conf里加入配置项： php_admin_value open_basedir none;