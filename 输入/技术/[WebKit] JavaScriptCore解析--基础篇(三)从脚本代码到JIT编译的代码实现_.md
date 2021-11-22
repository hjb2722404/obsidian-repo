[WebKit] JavaScriptCore解析--基础篇(三)从脚本代码到JIT编译的代码实现_求索-CSDN博客

# [WebKit] JavaScriptCore解析--基础篇(三)从脚本代码到JIT编译的代码实现

[前面](http://blog.csdn.net/horkychen/article/details/8928578)说了一些解析、生成ByteCode直至JIT的基本概念，下面是对照JavaScriptCore源代码来大致了解它的实现。

## 从JS Script到Byte Code

首先说明Lexer, Parser和ByteCode的生成都是由ProgramExecutable初始化过程完成的。先在JSC的API evaluate()中会创建ProgramExecutable并指定脚本代码。然后传入Interpreter时，再透过CodeCache获取的UnlinkedProgramCodeBlock就是已经生成ByteCode后的Code Block了。

![20130523002629192](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201218111948.png)

下图是CodeCache调用Parser和ByteCodeGenerator的序列图:

![20130523002655230](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201218113238.png)

而Lexer则是在Parser过程中调用的，如下图:

![20130523002720893](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201218113243.png)

再从类图来观察所涉及的几个类之间的关系:

![20130523002743525](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201218113248.png)

## 关于CodeBlock、UnlinkedCodeBlock和ScriptExecutable

CodeBlock可以理解为代码管理的类，按类型分为GlobalCodeBlock, ProgramCodeBlock, FunctionCodeBlock及EvalCodeBlock, 与之对应的UnlinkedCodeBlock和ScriptExecutable也有相似的继承体系，如下所示:

![20130523002812821](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201218113259.png)

UnlinkedCodeBlock存储的是编译后的ByteCode，而CodeBlock则会用于LLint和JIT。

ProgramExecutable则可以理解为当前所执行脚本的大总管，从其名字上可以看出来是代表一个可执行程序。

它们的作用也很容易理解。

## **关于LLint的slow path**

前面说过了LLint是基于offlineasm的汇编语言，这里只是介绍一下它的slow path. 为了处理一些操作，需要在LLint执行指令时调用一些C函数进行扩展处理，比如后面要说明的JIT统计功能，LLint提供一个调用C函数的接口，并将所有会被调用的C函数称为slow path,如下图所示:

![20130523002924459](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201218113304.png)

代码可以在LowLevelInterpreterXXX.asm中看到。所以可以C函数声明看到带有SLOW_PATH的宏。

## **关于JIT优化的触发**

首先JSC使用的是基于计数器的热点探测方法。前面提到函数或循环体被执行若干次后会触发JIT, 首先这个次数是可以通过JSC::Options中的thresholdForOptimizeSoon来设定的。然后在LLint在执行循环的ByteCode指令loop_hint和函数返回指令ret时会调用slow path中的C函数，进行次数统计和判断，过程如下:

![20130523002945812](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201218113308.png)

  其中会根据checkIfJITThresholdReached()返回结果来决定是否进行jitCompile.一旦要进行JIT编译时，也是根据当前CodeBlock的类型，而执行针对不同函数或代码段的优化。下面显示的是对一个频繁使用的函数进行JIT编译的操作:

![20130523003027254](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201218113312.png)

其中计数的功能并非由CodeBlock直接实现，而是通过ExecutionCounter来管理的。主要关系如下:

![20130523003050191](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201218113316.png)

转载请注明出处:http://blog.csdn.net/horkychen

参考:[WebKit研究](http://blog.csdn.net/column/details/webkit-in-deep.html)


