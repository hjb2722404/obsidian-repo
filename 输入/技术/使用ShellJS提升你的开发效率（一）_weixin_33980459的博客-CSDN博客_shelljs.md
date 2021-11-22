*   **echo**
    
    在控制台输出指定内容  
    .to(index.txt)写入文件
    
*   **exit(code)**  
    以退出码为code退出当前进程
    
*   **rm（\[options，\] file \[，file ...\]）**
    
    删除一个目录中一个或多个文件或目录，一旦删除，无法恢复。
    
    常用参数：
    
    1.  \-f:强制删除文件;
    2.  \-i:删除之前先询问用户;
    3.  \-r:递归处理目录;
    4.  \-v:显示处理过程;
    
    ```null
    shell.rm('-rf', staticSplash);```
    
*   **cp(\[options,\] source\_array, dest)** cp('-R','index.txt', '~/newCopy/') cp('-R',\['index.txt', 'old.txt'\], '~/newCopy/')
    
    用来将一个或多个源文件或目录复制到指定的文件或目录。
    
    常用参数：
    
    1.  \-f:force (default behavior)
    2.  \-L: follow symlinks
    3.  \-r,-R: recursive
    4.  \-n: no-clobber
    5.  \-u: only copy if source is newer than dest
    6.  \-P: don't follow symlinks
*   **cd**
    
    切换工作目录至指定的相对路径或绝对路径。cd..为返回上一级，cd-回到前一目录。
    
*   **ls**
    
    用来显示目标列表。
    
    常用参数：
    
    1.  \-a:显示所有文件;
    2.  \-C:多列显示查询结果;
    3.  \-l:单列长格式显示查询结果(与-C相反);
    4.  \-R:递归处理目录;
    5.  \-A：所有文件（包括开头的文件.，除了.和..）
    6.  \-d：列出目录本身，而不是其内容
    
    ```null
    ls(path.join('bundle', 'css/')).forEach(cssName => {```
    
*   **sed(\[options,\] search\_regex, replacement, file\_array**
    
    将file\_array中符合search\_regex的内容替换为replacement，支持正则的捕获组自引用。一次处理一行内容，处理完成后把缓冲区内容送往屏幕，然后处理下一行，循环直至结束。
    
    常用参数：
    
    1.  \-i:直接作用源文件
*   **cat(\[options,\] file \[, file ...\])**
    
    将一个或多个文件内容读入，指定一个文件时读入该文件，指定多个文件时将内容连接在一起读入。
    
    可用选项：  
    \-n: number all output lines
    
*   **exec(command \[, options\] \[, callback\])**
    
    执行所传入的命令
    
    1.  async:是否异步执行,默认false，传入callback时自动开启
    2.  slient:不输出信息到console,默认false
    3.  encoding:默认utf8  
        
        除非另有说明，否则command 同步执行给定的给定。在同步 模式下，它返回一个ShellString（与ShellJS v0.6.x兼容，返回 表单的对象{ code:..., stdout:... , stderr:... }）。否则，这将返回子进程 对象，并callback获取参数(code, stdout, stderr)。  
        **注意：对于长期存在的进程，最好以exec()异步方式运行**
*   **chmod**
    
    设置文件调用权限
    
    1.  \-c：output a diagnostic for every file processed
    2.  \-v: like verbose, but report only when a change is made
    3.  \-R: change files and directories recursively
    
    u表示该文件拥有者，g表示同一群体者，o表示其他，a表示所有  
    +表示增加权限，-表示取消权限，=表示唯一设定权限  
    r表示可读，w表示可写，x表示可执行，X表示当该文件是个子目录
    
    ```null
    chmod(755, '/Users/brandon');chmod('755', '/Users/brandon'); // same as abovechmod('u+x', '/Users/brandon');chmod('-R', 'a-w', '/Users/brandon');```
    
*   **pushd（\[options，\] \[dir |'-N'|'+ N'\]）**
    
    可用选项  
    \-n：在向堆栈添加目录时禁止正常更改目录，以便仅操作堆栈
    
    参数
    
    1.  dir：使当前工作目录成为堆栈的顶部，然后执行等效的cd dir
    2.  +N：通过旋转堆栈将第N个目录（从dirs打印的列表的左侧开始，从零开始）到列表的顶部
    3.  \-N：通过旋转堆栈将第N个目录（从dirs打印的列表右侧开始，从零开始计数）到列表顶部
    
    ```null
    echo(process.cwd());  // 当前文件父路径 /Users...pushd('/etc') // /private/etc /Users...pushd('+1') // users... /private/etc  ```
    
    将当前目录保存在目录堆栈的顶部，然后cd到dir。没有参数，pushd交换前两个目录。返回堆栈中的路径数组。
    
*   **popd（\[options，\] \[' - N'|'+ N'\]）**
    
    可用选项：  
    \-n：从堆栈中删除目录时禁止正常更改目录，以便仅操作堆栈
    
    参数：
    
    1.  +N：删除第N个目录（从dirs打印的列表左侧开始计算），从零开始
    2.  \-N：删除第N个目录（从dirs打印的列表右侧开始计算），从零开始。
    
    ```null
    echo(process.cwd()); // '/usr'pushd('/etc');       // '/etc /usr'echo(process.cwd()); // '/etc'echo(process.cwd()); // '/usr'```
    
    如果没有给出参数，popd将从堆栈中删除顶级目录并执行cd到新的顶级目录。从dirs列出的第一个目录开始，元素从0开始编号; 即，popd相当于popd +0。返回堆栈中的路径数组
    
*   **dirs（\[options |'+ N'|'-N'\]**
    
    可用选项：  
    \-c：通过删除所有元素清除目录堆栈
    
    参数：
    
    1.  +N：显示第N个目录（从没有选项调用时由dirs打印的列表左侧开始计数），从零开始
    2.  \-N：显示第N个目录（从没有选项调用时由dirs打印的列表右侧开始计数），从零开始
    
    显示当前记住的目录列表。返回堆栈中的路径数组，如果指定了+ N或-N，则返回单个路径。
    
*   **find（path \[，path ...\]）**
    
    查找文件
    
    ```null
    console.log(find('../Config/application.js'))```
    
    返回path\_array
    
*   **grep（\[options，\] regex\_filter，file \[，file ...\]）**
    
    不同于fing查找文件，grep用于查找内容
    
    可用选项：
    
    1.  \-v：反转正则表达式的意义并打印不符合条件的行
    2.  \-l：仅打印匹配文件的文件名
    
    ```null
    grep('-v', 'GLOBAL_VARIABLE', '*.js');grep('GLOBAL_VARIABLE', '*.js');```
    
    从给定文件中读取输入字符串，并返回一个字符串，其中包含 与给定文件匹配的文件的所有行regex\_filter
    
*   **head（\[{' - n'：}，\] file \[，file ...\]）**
    
    读取文件的开头
    
    可用选项：  
    \-n ：显示文件的第一行
    
    ```null
    console.log(head('bundle.js'))  console.log(head({'-n':1},'bundle.js'))  // 获取第一行```
    
*   **tail（\[{' - n'：}，\] file \[，file ...\]）**
    
    读取文件的结尾
    
    可用选项： -n ：显示文件的最后几行
    
    ```null
    var str = tail({'-n': 1}, 'file*.txt');var str = tail('file1', 'file2');var str = tail(['file1', 'file2']); // same as above```
    
*   **ln（\[options，\] source，dest）**
    
    创建链接
    
    ```null
    ln('file', 'newlink');  // /Users.../newlinkln('-sf', 'file', 'newlink');  //如果newlink存在，则强制链接?```
    
*   **mkdir（\[options，\] dir \[，dir ...\]）**
    
    创建文件夹
    
    可用选项：  
    \-p：完整路径（如有必要，将创建中间目录
    
    ```null
    shell.mkdir('-p', ['bundle', 'js'])```
    
*   **touch（\[options，\] file \[，file ...\]）**
    
    不同于mkdir创建文件夹，touch创建文件
    
    可用选项：
    
    1.  \-a：仅更改访问时间
    2.  \-c：不要创建任何文件
    3.  \-m：仅更改修改时间
    4.  \-d DATE:指定时间
    5.  \-r FILE:用FILE的时间替代新文件时间
*   **mv（\[options，\] source \[，source ...\]，dest'）**
    
    移动
    
    可用选项：
    
    1.  \-f：force（默认行为）
    2.  \-n：no-clobber
    
    ```null
    mv('move', 'target');  // 将move文件移动到target文件夹```
    
*   **PWD（）**
    
    查看当前目录
    
*   **set（选项）**
    
    设置全局配置变量
    
    可用选项：
    
    1.  +/-e：出错时退出（config.fatal）
    2.  +/-v：verbose：show all commands（config.verbose）
    3.  +/-f：禁用文件名扩展（globbing）
    
    ```null
    set('-e'); // exit upon first errorset('+e'); // this undoes a "set('-e')"```
    
*   **sort（\[options，\] file \[，file ...\]）**
    
    内容排序
    
    可用选项：
    
    1.  \-r：反转比较结果
    2.  \-n：根据数值比较
    
    ```null
    sort('foo.txt', 'bar.txt');```
    
    返回文件的内容，逐行排序。排序多个
    
*   **test（）**
    
    文件类型判断
    
    可用选项：  
    '-b', 'path'：如果path是块设备，则为true  
    '-c', 'path'：如果path是字符设备，则为true  
    '-d', 'path'：如果path是目录，则为true  
    '-e', 'path'：如果路径存在，则为true  
    '-f', 'path'：如果path是常规文件，则为true  
    '-L', 'path'：如果path是符号链接，则为true  
    '-p', 'path'：如果path是管道（FIFO），则为true  
    '-S', 'path'：如果path是套接字，则为true
    
    ```null
    if (!test('-f', path)) continue;```
    
*   **uniq（\[options，\] \[input，\[output\]\]）**
    
    可用选项：
    
    1.  \-i：比较时忽略大小写
    2.  \-c：按出现次数排列前缀
    3.  \-d：仅打印重复的行，每行对应一行
*   **ShellString()**
    
    构造器，将一个字符串转化为Shell字符串,转化后的字符串支持链式调用特殊的shell命令
    
    ```null
    ShellString('hello world')```
    
*   **ShellString.Prototype.to()**
    
    将shellString输出至指定文件,相当于脚本语言中的>
    
*   **ShellString.Prototype.toEnd()**
    
    将shellString追加至指定文件,相当于脚本语言中的>>
    
*   **env\['VAR\_NAME'\]**
    
    指向process.env
    
*   **Pipes链式调用支持**
    
    sed,grep,cat,exec,to,toEnd均支持链式调用
    
*   **Configuration**
    
    1.  config.silent `sh.config.silent`
    2.  config.fatal `config.fatal`
    3.  config.verbose `config.verbose`
    4.  config.globOptions `config.globOptions`
    5.  config.reset()重置全局 `shell.config.reset()`