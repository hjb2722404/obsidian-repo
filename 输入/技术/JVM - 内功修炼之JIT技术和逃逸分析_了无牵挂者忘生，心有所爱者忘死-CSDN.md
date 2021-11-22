# JVM - 内功修炼之JIT技术和逃逸分析

>
>  大家会发现不管是从我之前的文章还是从其他各种书籍又或者是各类JVM文章中，在最最最开始都会有几个概念烙在我们的脑海里。
>
1. > 堆是线程共享的内存区域，而栈是线程私有的内存区域。
2. > 堆主要用于存放对象实例，而栈中主要存放基本数据类型以及复杂类型引用。
>
>
>  那么如果我现在告诉你，这些结论并不是百分百正确的，你是否会想顺着网线来打我？好了，请先忍一忍，我们往下看完大家再决定是否要动手好了。
>

>   我们前面的文章也讲过一个Java对象在堆上进行分配时主要是会分配在新生代的Eden区域，而有些时候又会在TLAB区域，当包含大对象时也可能会直接在老年代上分配。这其中的分配规则是不固定的，既取决于何种垃圾收集器也可能和JVM的一些参数有关。不过一般情况和我们之前提到的其实大体相同。

>

>   然而我们也知道，我们所了解的很多虚拟机规范其实对于各个厂商虽大致相同但也有一些差异，比如在内存分配这件事上就会有不同的优化策略。相信就算大家在还没有打算去深入了解JVM之前，也会不经意听到`JIT`> 这一概念，而正是因为`HotSpot`> 虚拟机的`JIT`> 技术，使得对象在堆上分配内存带有不确定性，所以你别打我，去打他。

>

## 1.即时编译JIT(Just in Time)

>

>  我们大家所了解的传统JVM解析器执行Java程序是先通过`javac`> 对其进行源码编译然后转为字节码文件，然后再通过解释字节码转为机器指令一条条读取翻译的。显而易见Java编译器经过编译再执行的话，执行速度必然比直接执行要慢很多，而`HotSpot`> 虚拟机针对这种场景进行了优化，引进了`JIT`> 即时编译技术。

>

>   `JIT`> 技术的引入不会影响原本JVM编译执行，只是当发现某个方法或者代码块运行特别频繁时会将其标记为`热点代码`> 。然后会将其直接编译为本地机器相关的机器码并优化，最后将这部分代码缓存起来。

>

### 1.1 热点代码

>

>  提了这么多，那什么才是`热点代码`> 呢？当虚拟机发现某个方法或者代码块执行十分频繁的时候，就会将其标记为`热点代码`> 。在我们平时开发中，热点代码主要有：`被多次调用的方法`> 、`被多次执行的循环体`> 。

>
>   那么到底被调用多少次才属于`热点代码`> 呢？这是怎样的一个评判标准我们接下来就会提到。
>

### 1.2 热点探测

>
>  我们已经介绍了，要触发`JIT即时编译`> 需要先识别出热点代码，而这一过程就称为`热点探测`> 。目前主要的热点探测方式有两种：
>
1. >   `基于计数器的热点探测`> ：虚拟机为每个方法或是代码块建立一个计数器，统计执行的次数，若此处超过规定阈值则标记为`热点代码`> 。
>
>   优点：统计结果精准严谨。
>   缺点：实现较为复杂，并且需要为每个方法或是代码块都建立并维护计数器，无法直接获取方法调用关系。
>
2. >   `基于采样的热点探测`> ：虚拟机周期性检查各个线程栈顶，若某个方法出现在栈顶频率较高，则标记为`热点代码`> 。
>
>   优点：实现简单高效，可展开堆栈获取方法调用关系
>   缺点：缺乏精准度，线程阻塞或其他因素可能会扰乱热点探测。
>
>
>  我们所使用的`HotSpot`> 虚拟机中主要就是采用基于计数器的热点探测。
>

### 1.3 编译优化

>

>  当`热点探测`> 识别出热点代码后会触发`JIT`> ，除了会对字节码进行缓存外还会对代码进行各种优化。而这些优化中比较重要的几个想必大家也听过不少：`逃逸分析`> 、`锁消除`> 、`锁膨胀`> 、`方法内联`> 、`空值检查消除`> 、`类型检查消除`> 等。而我们接下来要讲就是本文的重点-`逃逸分析`> 。

>

>   另外关于`JIT即时编译`> 如果大家有兴趣深入推荐一篇文章> [> 【你了解JVM中的 JIT 即时编译及优化技术吗？】](https://www.jianshu.com/p/fbced5b34eff)> ，有兴趣的小伙伴可以看看。

>

## 2.逃逸分析(Escape Analysis)

>

>  做了一系列铺垫终于到了今天的主角。`逃逸分析(Escape Analysis)`> 是目前JVM中一项比较重要的优化技术。通过逃逸分析，HotSpot编译器能够分析出一个对象的使用范围从而考虑是否将其分配在堆内存中。

>

>   逃逸分析的核心思想就是分析对象动态作用域：当一个对象在方法中被定义后，它可能被外部方法所引用，称为方法逃逸。甚至某些情况还需要被外部线程访问，称为线程逃逸。举个栗子。

>

	package com.ithzk.springbootjvm.memoryallocation;
	
	*/**
	 * @ Description   :  逃逸分析和栈上分配 -XX:+PrintGCDetails -XX:+DoEscapeAnalysis
	 * @ Author        :  zekunhu
	 * @ CreateDate    :  2020/4/11 15:06
	 * @ UpdateUser    :  zekunhu
	 * @ UpdateDate    :  2020/4/11 15:06
	 * @ UpdateRemark  :
	 * @ Version       :  1.0
	 */*
	public class EscapeAnalysis {
	
	    public void escape1(){
	        Object ojb = new Object();
	    }
	
	    */**
	     * 方法逃逸
	     * @return
	     */*
	    public Object escape2(){
	        return new Object();
	    }
	
	}

- 1
- 2
- 3
- 4
- 5
- 6
- 7
- 8
- 9
- 10
- 11
- 12
- 13
- 14
- 15
- 16
- 17
- 18
- 19
- 20
- 21
- 22
- 23
- 24
- 25
- 26
- 27

>

>  这里我给出了两个方法，`escape1()`> 内部实现只构建了一个对象没有被外部引用，这种情况就属于没有逃逸出方法；`escape2()`> 同样也构建了一个对象但是会将引用返回给调用，此时构建的对象是可以被外部访问的，这种就称之为方法逃逸。

>

>   如果我们能够确定一个变量不会逃逸到方法或者线程外，则是有可能对其进行一些优化的：`同步省略`> 、`标量替换`> 、`栈上分配`> 。这里同步省略会在后面多线程分析文章中介绍，这里主要介绍另外两种。

>

## 3.栈上分配(Stack Allocation)

>

>  众所周知，在JVM中对象的创建都是在堆上分配的，因为堆内存上访问是线程共享的，所有线程只要有该对象的引用就能够访问到堆中存储的对象数据。而`JIT`> 经过逃逸分析后，如果确定某个对象不会逃逸到方法之外，那么还有必要让其在堆上分配吗？如果能够改变Java对象都在堆上分配的原则将其分配到栈上那会发生什么呢？

>

>   小伙伴们都知道垃圾回收不管是标记还是清除又或者是整理都需要耗费时间，若我们能够改变Java对象都在堆上分配的原则能够将没有逃逸出方法外的对象分配在栈上，其所占的空间就会随着栈帧出栈(方法执行完成)而自动销毁，可以大幅度减少垃圾收集器的压力从而提高系统性能。

>

>   在`HotSpot JVM`> 中，栈上分配其实并没有真正意义上实现，但正因为有了这种设计思想，才有了接下来我们要介绍的`标量替换`> ，下面我们就来看看`标量替换`> 是如何实现栈上分配的。

>

## 4.标量替换

>

>  这里的`标量(Scalar)`> 和我们在数学中所了解的标量有所区别，在这里标量指的是一个无法再分解成更小的数据。在Java中原始数据类型如int、long等都属于标量。而其他可以继续分解的数据都称为`聚合量(Aggregate)`> ，最典型的就是对象。

>

>   如果经过逃逸分析确定一个对象不会被外部访问从而触发JIT优化，就会尝试将该对象进行拆解为若干个其中包含的成员变量来代替，在执行时就不会再去直接创建这个对象了，这个过程就是标量替换。这里我们用实际示例来描述一下让大家更容易理解并且印象更深刻。

>

	package com.ithzk.springbootjvm.memoryallocation;
	
	public class EscapeAnalysis {
	
	    public static Escape allocation(){
	        Escape escape = new Escape(3,29);
	        System.out.println("Escape{variable1='" + escape.variable1 + ", variable2='" + escape.variable2 + "}");
	    }
	
	    public static void main(String[] args) {
	        allocation();
	    }
	
	    static class Escape{
	
	        private int variable1;
	        private int variable2;
	
	        public Escape(int variable1, int variable2) {
	            this.variable1 = variable1;
	            this.variable2 = variable2;
	        }
	    }
	
	}

- 1
- 2
- 3
- 4
- 5
- 6
- 7
- 8
- 9
- 10
- 11
- 12
- 13
- 14
- 15
- 16
- 17
- 18
- 19
- 20
- 21
- 22
- 23
- 24
- 25

>

>  上面这段代码我们可以看出，`allocation()`> 中我们构建了一个Escape对象，并且该对象没有逃逸出方法外。那么经过`JIT`> 优化后并不会直接去创建这个对象，而是使用两个标量代替。

>

	package com.ithzk.springbootjvm.memoryallocation;
	
	public class EscapeAnalysis {
	
	    public static Escape allocation(){
	        int variable1 = 3;
	        int variable2 = 29;
	        System.out.println("Escape{variable1='" + variable1 + ", variable2='" + variable2 + "}");
	    }
	
	    public static void main(String[] args) {
	        allocation();
	    }
	
	}

- 1
- 2
- 3
- 4
- 5
- 6
- 7
- 8
- 9
- 10
- 11
- 12
- 13
- 14
- 15

>
>  我们可以看到，通过标量替换的优化，原本一个对象被替换成了两个标量。原本需要再堆上分配内存现在也只要在栈中进行内存分配就可以实现功能了。
>

## 5.实践是检验真理的唯一标准

>
>  上面介绍了这么多，那么逃逸分析对于我们编写的代码是不是真的会实行并且有效呢？这里我们就通过几个例子带大家更深入接触逃逸分析。
>

	package com.ithzk.springbootjvm.memoryallocation;
	
	public class EscapeAnalysis {
	
	    public static void allocation(){
	        Escape escape = new Escape("a", "b");
	    }
	
	    public static void main(String[] args) {
	        long startTime = System.currentTimeMillis();
	        for(int i = 0;i < 10000000; i++){
	            allocation();
	        }
	        long endTime = System.currentTimeMillis();
	        System.out.println("Time:" + (endTime - startTime));
	
	    }
	
	    static class Escape{
	
	        private String variable1;
	        private String variable2;
	
	        public Escape(String variable1, String variable2) {
	            this.variable1 = variable1;
	            this.variable2 = variable2;
	        }
	
	    }
	
	}

- 1
- 2
- 3
- 4
- 5
- 6
- 7
- 8
- 9
- 10
- 11
- 12
- 13
- 14
- 15
- 16
- 17
- 18
- 19
- 20
- 21
- 22
- 23
- 24
- 25
- 26
- 27
- 28
- 29
- 30
- 31
- 32

>

>  这段代码读起来应该很容易理解，就是利用循环怼了1000万个Escape对象。并且从这个示例中我们可以看出我们定义的Escape对象并没有逃逸出`allocation()`> 方法，我们来看看上面那些理论知识所展现真实的情况到底是怎样的。

>

>   这里我们添加JVM参数`-XX:+PrintGCDetails -XX:-DoEscapeAnalysis`> ，可以追踪到详细的GC日志并且这里我们将逃逸分析关闭了，运行看看效果。

>   ![watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM5ODU2NjQ=,size_16,color_FFFFFF,t_70](../_resources/070b98cf497ed3e1ff4eca854d94eda3.png)

>   首先我们可以看到的是这里触发了几次GC，然后整个过程的运行时间也清楚记录了下来，我们再将逃逸分析打开`-XX:+DoEscapeAnalysis`> 。

>   ![watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM5ODU2NjQ=,size_16,color_FFFFFF,t_70](../_resources/e138b3418a0442b099d07d858312fc2b.png)

>   效果简直不要太明显，首先频繁GC没有出现了，并且整个过程的执行时间以目前示例来看有十倍之差，大家是不是感觉逃逸分析优化的效果十分明显了。另外我目前示例使用的版本jdk1.8，该版本默认是开启逃逸分析的，大家可以删除这个JVM参数动手验证下自己使用版本的情况。

>
>   还是刚才这个例子，我们稍微修改一下。
>

	package com.ithzk.springbootjvm.memoryallocation;
	
	public class EscapeAnalysis2 {
	
	    public static void allocation(){
	        Escape escape = new Escape("a", "b");
	    }
	
	    public static void main(String[] args) {
	        long startTime = System.currentTimeMillis();
	        for(int i = 0;i < 1000000; i++){
	            allocation();
	        }
	        long endTime = System.currentTimeMillis();
	        System.out.println("Time:" + (endTime - startTime));
	        try {
	            Thread.sleep(600000);
	        }catch (InterruptedException e) {
	            e.printStackTrace();
	        }
	
	    }
	
	    static class Escape{
	
	        private String variable1;
	        private String variable2;
	
	        public Escape(String variable1, String variable2) {
	            this.variable1 = variable1;
	            this.variable2 = variable2;
	        }
	    }
	
	}

- 1
- 2
- 3
- 4
- 5
- 6
- 7
- 8
- 9
- 10
- 11
- 12
- 13
- 14
- 15
- 16
- 17
- 18
- 19
- 20
- 21
- 22
- 23
- 24
- 25
- 26
- 27
- 28
- 29
- 30
- 31
- 32
- 33
- 34
- 35
- 36

>

>  这里我们创建100万个对象，让线程睡眠可以方便我们查看堆栈信息，这里我们先关闭逃逸分析`-XX:-DoEscapeAnalysis`> 。我们通过`Jps`> 找到对应的进程pid。

>   ![20200414174836546.png](../_resources/7e81748326392a8034359906897a5e89.png)

>   这里我们通过`jmap -histo:live 2772>jmap_histo.log`> 将堆中对象情况给输出到日志中。不熟悉`jmap`> 的可以看看> [> 【java命令–jmap命令使用】](https://www.cnblogs.com/kongzhongqijing/articles/3621163.html)> 这篇博客，后面我们也会介绍JVM常用的一些命令。

>   ![watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM5ODU2NjQ=,size_16,color_FFFFFF,t_70](../_resources/69037f4d931ec032dcd3a067dab5a2cc.png)

>   通过`jamp`> 结果我们可以清楚看到，堆里创建了100万个`Escape`> 对象，这里虽然没有逃逸出方法但是我们将逃逸分析关闭后所有对象依然是会被分配在堆中。我们开启逃逸分析`-XX:+DoEscapeAnalysis`> 再来一遍看看。

>   ![watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM5ODU2NjQ=,size_16,color_FFFFFF,t_70](../_resources/a4c0f7a14eaa16ea7976860503229827.png)

>   当我们开启逃逸分析后，堆中只分配了15万左右的`Escape`> 对象，效果还是十分明显的。并且开启逃逸分析后GC次数也明显减少了。这种方式让我们更贴切感受到了逃逸分析带来的好处。

>

## 6.完美的逃逸分析？

>

>  我们上面通过几个栗子来亲身感受了一下逃逸分析给我们带来的效果，我们会发现当我们开启逃逸分析后并不是直接就将所有没有逃逸出方法的对象都进行了优化，上面我们100万的数量最终优化到了15万左右，也就是说`JIT`> 的优化策略并不是简单的根据是否逃逸出方法来决定的。

>

>   当我们去翻阅各种书籍和资料，上面会介绍说逃逸分析相关的资料在1999年就已经发表了，但是JDK1.6才实现推出。直到我们使用的JDK1.8来说也没有资料说逃逸分析这项技术已经成熟。

>

>   最主要的原因就是因为`逃逸分析`> 整个过程需要经过一系列复杂的分析才能确定该对象是否真正符合条件，也就是说无法保证逃逸分析的性能消耗一定会大于优化所带来的的收益。并且逃逸分析除了对符合条件对象的检测外，还要进行标量替换、栈上分配、同步消除等优化，这其中花费的时间由于数据量的不确定性而无法确定。

>

>   就用我们上面的例子来说，假如我们去创建了1000万个对象，然后经过逃逸分析后发现没有一个对象符合优化条件，那么这整个逃逸分析的过程就是完全浪费的，对系统整个运行时会产生一定性能消耗的。不过我们亲身感受了这项技术，它的强大和带给我们真实的冲击对整个编译器发展都是有着巨大贡献的。

>
>   所以即使这项技术在当下并不是十分完美，但是其整个设计思想和发展轨迹都是值得我们去学习的，并且随着不断地发展其地位也一定十分重要。
>