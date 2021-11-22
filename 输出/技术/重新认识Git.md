

从七八年前开始使用Git，这么多年了，虽然无论是自己的开源项目，还是公司里团队使用，自己都能熟练地使用Git完成日常的版本管理需求。

但是，即便如此，还是偶尔会遇到一些自己不理解的异常情况（参见[关于Git的rebase操作与cherry-pick操作的建议]()一文），再加上团队里有一些刚毕业不久的小伙伴，对Git的操作也还云里雾里没有那么数量，所以就抽空写了这么一篇文章，从版本控制的本质和Git底层的设计来抽丝剥茧地分析，当我们执行那些常用的`git`命令时，Git内部都发生了哪些事情，以帮助我们更好地理解Git，更恰当地运用Git.

当然，在写作本文的过程中，有些知识点是我都未曾注意过的，可以说是真正的`温故而知新`了。

本文大约40000字，[嫌长不看版](#zongjie)

## 渊源

### 什么是版本控制

对于任何类型的文件，在持续不断的变化中，在任意一个时刻，都能将其当时的状态和内容作为一个版本保存在数据库里，然后在需要的时候，能随时读取到指定版本，这就是版本控制。

### 为什么要进行版本控制

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210727095751.png)
[图片来源](https://yanhaijing.com/git/2017/01/19/deep-git-1/)

无论是写文档，还是做设计，或者是开发程序，都不是能一蹴而就的，都要经过一次次的修改和完善才能达到最终想要的结果。而且如果过程中又涉及多个人共同来完成，又会引入协作流程。在这整个过程中，我们就难免会有以下需求：

* 回溯。比如你的文件最近两天的变动部分不想要了，那你可以选择回退到两天前的某个版本，又比如你回退到两天前的版本后，又觉得一天前的某些变动还是需要的，那你可以将这些变动再还原回来。
* 溯源。当文件内容出现问题时，可以对比版本间的差异，看到某个版本是由谁修改了哪些部分，可以帮助我们更快地定位和解决问题。
* 恢复。即使整个项目文件被人恶意改的改，删的删，弄得乱七八糟，我们也能轻松将其恢复到它最后一个正常的版本。

这就是为什么要进行版本控制的原因——它提供给我们一种对文件修改历史精确掌握的能力和一种允许我们随时“后悔”的机制。

### 版本控制的演进史

#### 1. 本地版本控制系统

由于它是本地的，意味着它没有网络，所有数据都是存放在本地的。

这种系统经历过两个阶段。

##### 源代码控制系统——SCCS（source code control system）

这套系统由贝尔实验室开发，旨在解决源文件修订跟踪的问题

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210727134543.gif)

它的基本原理是：

1. 比如有一个名为 `test.txt` 的源文件
2. 我们可以使用一个命令将其加入到SCCS系统的跟踪列表。
3. SCCS系统会创建一个名为SCCS的子目录，然后在该目录下创建一个类似`s.test.txt`这样的`s文件` , 这个`s文件` 就是历史记录文件。
4. `s文件` 里包含了
	*  增量表——用以存储以后每次修改源文件后的增量内容
		*  元数据—— 用以帮助进行版本跟踪。（比如版本号，修改日期，修改人，当前版本是基于哪一个版本修改的等等）
		*  文件校验和（一个使用原始内容和其它信息计算出的散列值）——  用以验证内容是否遭到篡改
		*  增量内容——比上一个版本增加或减少的内容
	*  访问和跟踪标志，包括
		*  权限——指定哪些员工会可以编辑这个文件，哪些版本禁止编辑，是否允许多人共同编辑文件等等
	*  正文——源文件加入跟踪时的初始内容。
5. 这之后每一次对源文件`test.txt`的修改，都可以检入到`s文件`中，但不是每次都存储整个文件内容，而是仅存储增量内容或文件更改。
6. 这些增量内容存储在`s`文件中的【增量表】中。
7. 在需要用到历史版本的时候，可以使用命令将`s`文件中记录的指定历史版本检出到工作目录替换源文件。
8. 可以在某个版本的基础上创建分支，从分支构建的文件版本在分离点之后不会使用放置在主干上的任何增量。

`s文件` 内容示例[^1]：

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210727095609.png)

SCCS系统作为最早的版本控制探索者为后来的版本控制系统提供了最原始的一些思想和概念，包括但不限于：

* 版本
* 分支
* 文件校验和
* 增量表
* 历史文件的检入检出
* 协同编辑
* ……

但由于时代的局限性，它也有显而易见的缺点：

* 没有网络。意味着只能在本地机器上进行变化跟踪，多人协同也用户通过自己的帐户登录到同一共享 Unix 主机方式实现。
* 单点故障。如果本地硬盘损坏，文件就彻底损坏了。
* 单文件跟踪。这个系统的修订跟踪是针对单个文件的，意味着无法将对多个文件的更改作为一个原子版本检入和检出。
* 锁机制。当检出文件进行编辑时，为了防止更改被其它用户覆盖，文件将加一个锁，意味着这会限制多用户同时编辑而降低开发效率。
* 不开源。由于没有开源，所以如果需要使用这套系统，就必须购买授权。

##### 修订控制系统——RCS(Revision Control System)

由于SCCS的不开源，所以Walter Tichy 编写了 RCS系统。

相对于SCCS系统，它进行了如下改进：

* 更简单的用户界面
* 改进的版本存储机制，加快了检出新版本的速度（反向增量）

它的工作原理基本上继承自SCCS，但又有不同：

*  它的历史文件在与源文件同级的`RCS`目录下，它的历史记录文件加了后缀`.v`而非前缀`s.`
*  采用反向增量机制：
	*  SCCS保存的是文件初次被加入跟踪系统时的完整内容，而RCS则保存的是文件最新版本的完整内容
	*  SCCS的增量表的每一个版本保存的是那个版本与前一个版本之间的增量内容，而RCS则保存的是那个版本与它的下一个版本之间的增量内容
	*  这种机制提高了RCS的检出新版本的速度，却使得检出旧版本要花费更多的时间（因为它是由新到旧逐个计算差异的）。

RCS的历史记录文件示例[^1]

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210727140649.jpeg)

由于它是基于SCCS系统的，所以SCCS系统有的缺点它也都有。



#### 2.  集中式版本控制系统

它也经过了两个阶段

##### 并发式版本系统 ——CVS（Concurrent Versions System）

由于第一代版本控制系统都是无网络的，造成了协作的不便，所以 `Dick Grune` 创建了CVS系统，主要是加入了网络，使得协作可以通过网络进行。

相比于第一代本地版本控制系统，CVS系统具有以下特点：

* 可执行脚本。可以提供日志CVS操作或强制执行特定于站点的策略
*  C/S架构。 使分散在不同地理位置或速度较慢的调制解调器上的开发人员能够作为一个团队工作。
*  版本记录存在中央服务器上，客户机拥有开发人员正在处理的所有文件的副本。
*  更灵活的分支策略。
*  没有锁。允许多人同时编辑同一个文件。采用“先允许修改，再处理冲突”的策略。
*  历史文件存储在【模块】中，开发人员可一次性检出一个【模块】中的所有历史记录文件。

CVS历史记录文件示例[^1]

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210727163708.jpg)

##### subversion系统——SVN

CVS相较于第一代的本地版本控制系统，已经解决了网络、锁机制与不开源的问题，但却没有解决单点故障和单文件追踪的缺点。

于是Collabnet 公司开发了 SVN，用以解决之前的版本控制系统只能进行单文件追踪的缺点。

相较于CVS，SVN系统具有以下特性：

* 引入了原子提交的功能，确保提交要么完全成功，要么失败后完全放弃（回滚机制）。原子提交中可以是对多个文件的修改。这是它与CVS最本质的不同。
* CVS与之前的版本控制系统，其用来记录历史版本的都是普通的文本文件，格式与源文件一致，最终CVS目录的树结构也与项目源文件所在目录的树结构一致，这种结构不必担心数据丢失。而SVN则使用了一组类似于关系型数据库的二进制文件来记录历史文件，正是这样的设计产出了原子提交的特性，但同时也使得数据的存储对用户变得不透明。
* 由于采用了新的设计，并且使用了压缩算法，其检入检出速度和网络传输速度都比CVS提升了一个层级。
* 引入了标签（tag）机制，重新设计了分支的逻辑。
* 更广泛地支持所有文件类型（CVS对二进制文件支持很繁琐）
* 更强的扩展性。
* 引入了三路合并机制。CVS前都是二路合并。假设有两个文件都是从某个文件某个版本检出，而它们进行了不同的修改，二路合并在合并时对两个文件进行逐行对比，如果【行内容不同】就报冲突。而三路合并则以那个检出的版本作为基础版本，然后逐行对比哪个版本是与基础版本一致的，哪个是和基础版本不一致的，最后将采用这个不一致的，如果两个都与基础版本不一致，就报冲突。
* SVN以文件夹为基本管理单位，可以在SVN中提交空文件夹，而在其它VCS中（包括Git），无法管理空文件夹
* 没有采取CVS那样的文件内部用不同标记来区分不同功能的设计，而是根据功能分了三个文件夹来存储：
	* `trank`：用于应用程序的生产版本
	
	* `branches`：用于保存与各个分支相对应的子文件夹
	
	* `tags`：用于保存特定项目修订版本的标签（只读）
	
	  

两路合并与三路合并 [^2]

**两路合并：**
![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210727172905.png)

**三路合并**
![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210727173005.png)

**三路合并冲突**
![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210727173108.png)

#### 分布式版本控制系统——DVCS

主要就是Git

我们知道，前面SVN通过引入原子提交解决了CVS前只能进行单文件追踪的问题，但却还是没有解决单点故障的问题，即
* 如果中央服务器崩溃，那所有协作者都不得不停止手中的工作，因为大多数操作都必须与中央服务器进行交互
* 如果服务器版本数据丢失，将很难找回，因为开发者机器上同一时间只保存着其中一个分支的代码，只有中央服务器有所有分支的文件。

受到早期的商业版本管理软件`BitKeeper`的授权问题的刺激，Linux 之父 Linus Torvalds 创建了 Git，它通过分布式的版本存储设计，彻底解决了之前所有版本控制系统的单点故障问题。并且继承了之前版本管理系统的很多基础概念和优秀设计，包括但不限于：
* 分支与标签（branch，tags）系统
* 原子提交（commit）
* 文件校验和用以验证文件有无篡改
* 三路合并
* ……

在这些基础上，Git实现了以下特性：

* 分布式。虽然也会有一个中央服务器，存储着所有文件的所有历史版本，但是，每个开发者本地的客户机上也都有一份完整的拷贝，里面也拥有所有文件所有历史版本。这一点带来两个结果：
	* 1. 彻底解决了单点故障的问题。无论是中央服务器，还是任何一台客户机出现故障或文件丢失，都不会影响其它客户机上数据的完整性，并且事后都可以从其它任意一台客户机恢复所有文件的所有历史版本。
	* 2. 操作本地化。CVS和SVN的检入检出，分支切换等操作都必须依赖网络，因为他们需要和中央服务器通讯才能完成。但是Git本地拥有了仓库的所有文件所有历史版本以及所有分支和tag，所以其大部分操作都只需要在本地进行，不需要网络，只有在需要和中央服务器同步仓库的时候才需要用到网络。
* 暂存区。由于Git中是使用二进制的blob对象存储源文件数据的，那么我们如何知道工作目录的文件对应的是哪个二进制对象呢？这就是暂存区的用武之地：暂存区的本质是一个索引，它建立了工作目录文件和二进制Blob对象之间的映射关系。
* 分支操作的优化。从上面的历史脉络中我们可以发现，之前的版本控制系统也都一直支持分支操作，但Git的分支与之前所有的分支都不一样。`SVN`和`CVS`的分支都是将当前分支里的所有文件复制到一个新的分支目录中取，而Git只是新建一个引用，所以Git的分支操作非常轻量级，这就是官方推荐多使用分支操作的原因，后面我们后详细介绍它的原理。

接下来，我们就详细解析Git的版本控制原理，通过与以上各种版本控制系统方案的对比，来彻底理解Git的工作理念和优缺点。


## 原理
### 实战

#### 1. 本地建立一个目录，将其初始化为git仓库

```bash
$ mkdir git-test
$ cd git-test
$ git init

```

现在我们看看当前的目录：
```bash
$ ll -a
total 12
drwxr-xr-x 1 trs 197121 0 Jul 29 10:50 ./
drwxr-xr-x 1 trs 197121 0 Jul 29 10:50 ../
drwxr-xr-x 1 trs 197121 0 Jul 29 10:50 .git/

```

现在，我们没有添加任何文件，但是目录中自动生成了一个`.git`目录，这个就是Git仓库了

我们看看初始状态下，这个`.git`目录中都有什么：

```bash
$ cd .git
$ ll -a

total 11
drwxr-xr-x 1 trs 197121   0 Jul 29 10:50 ./
drwxr-xr-x 1 trs 197121   0 Jul 29 10:50 ../
-rw-r--r-- 1 trs 197121  23 Jul 29 10:50 HEAD
-rw-r--r-- 1 trs 197121 130 Jul 29 10:50 config
-rw-r--r-- 1 trs 197121  73 Jul 29 10:50 description
drwxr-xr-x 1 trs 197121   0 Jul 29 10:50 hooks/
drwxr-xr-x 1 trs 197121   0 Jul 29 10:50 info/
drwxr-xr-x 1 trs 197121   0 Jul 29 10:50 objects/
drwxr-xr-x 1 trs 197121   0 Jul 29 10:50 refs/

```

我们逐一说明：

 **HEAD**：一个文本文件，它内部存放着当前工作目录所在的分支所指向的那个分支，可以认为它就是【当前分支】
**config**:  配置文件，它内部存放着当前仓库的一些配置
**description**： 一个文本文件，里面是对仓库的描述，初始状态下没有，会提示我们编辑此文件来为仓库创建描述
 **hooks**：GIT 操作的一些钩子，用以在git的一些操作前后添加一些自定义行为
 **info** exclude：存放仓库的一些信息
 **objects** 本地仓库的真正所在，存放二进制文件，初始化时只有`info`与`pack`两个空目录
 **refs** 引用，存放分支与tag当前指向的提交的信息，初始化时只有`heads`与`tags`两个空目录

 直接上图看内容：

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210729111439.png)

#### 2. 新建一个目录

先返回工作目录，然后新建一个目录

```bash
$ cd ..
$ mkdir firstdir
```

现在我们再看`.git`目录，是没有任何变化的 

我们看看当前Git工作目录状态

```bash
$ git status
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)

```

可以看到，现在还没有任何需要提交的东西。

我们执行下`git add` , 再看看Git仓库状态：

```bash
$ git add .
$ git status
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)

```

可以看到，没有任何变化，而我们的`.git`目录里的内容也是毫无变化，由此，我么得到了第一个结论：

**结论1：Git无法跟踪空目录**

上面我们说过，`SVN` 是可以跟踪空目录的，由此看见，它也是唯一支持跟踪空目录的版本控制系统。

#### 3. 新建一个文件

我们在根目录里新建一个文本文件

```bash
$ touch test1.txt
```

现在还没有为这个文件添加任何内容，我们看看Git工作目录状态

```bash
$ git status
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        test1.txt

nothing added to commit but untracked files present (use "git add" to track)

```

Git提示我们可以使用`git add`将这个空文件加入Git仓库的追踪列表里了，再看看`.git`目录：

![image-20210729112819529](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210729112819.png)

依旧是没有任何变化。

#### 4. 将新文件添加到暂存区

接下来，我们执行`git add .`操作，将上面建立的空的新文件添加到Git的暂存区里，然后再看看Git工作目录状态

```bash
$ git add .
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   test1.txt

```

可以看到，现在Git提示我们有变化【待提交】，变化类型为`new file`，变化内容为`test1.txt`

此时，我们再看 `.git`目录，终于有了一些变化：

![image-20210729113558744](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210729113559.png)

有两个变化：

* 在`objects`目录下多了一个目录`e6`，里面有一个名为`9de29bb2d1d6434b8b29ae775ad8c2e48c5391`的二进制文件
* 在`.git`根目录下多了一个名为 `index` 的二进制文件，这其实就是我们说的`暂存区`，有些地方也叫它`索引文件`。

由于它们是二进制文件，我们无法通过编辑器查看它们的内容，但我们可以通过`git`提供的**底层命令**来查看它们的内容。

##### 查看`objects`中二进制文件的内容

我们使用`git cat-file`命令来查看位于`objects`目录下二进制文件的内容：

```bash
$ git cat-file -p e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
```

首先，我们注意到，没有任何输出。其实这个文件存储的就是我们的`test1.txt`的内容，没有输出是因为此时我们还未给它添加内容，下面一小节我们给它添加内容再说。

其次，我们注意到我们查看的文件名是`e69de29bb2d1d6434b8b29ae775ad8c2e48c5391`，它是我们上面看到的`objects`中的目录名（`e6`）+ 目录下的文件名`9de29bb2d1d6434b8b29ae775ad8c2e48c5391` 的结果。这和Git对文件的存储机制有关。

> Git会使用SHA-1散列算法对要存储的内容进行计算（计算前会在头部加一字符串，该字符串标明内容的类型和长度），得到一个40位的散列值，然后将前2位作为目录名，后38位作为文件名存储到`objects`目录下

##### 查看暂存区`index`的内容

我们使用`git ls-files` 命令来查看暂存区`index`文件的内容：

```bash
git ls-files -s
100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       test1.txt

```

这个命令的输出格式和说明如下：

```bash
[<tag> ]<mode> <object> <stage> <file>
```

* `tag`:  可选，文件所属tag，此处没有。
* `mode`: 模式位，描述文件模式
  * 100644 - 普通文件；
  * 100755 - 可执行文件；
  * 120000 - 符号链接（symbolic link）；
  * 040000 - 目录；
* `object`:  blob对象名称（即在`objects`目录下的目录+文件名）
* `stage`:  暂存区编号——分支合并出现冲突时同一个文件会有多个不同版本，都会被索引入暂存区。
* `file`：工作目录文件名

这里，其实就是将文件在工作目录中的文件名和在`objects`目录下的文件名做了映射。这就是它被称为索引的原因。

#### 5. 为文件添加内容

我们给`test1.txt` 增加一些内容，然后查看Git工作目录状态：

```bash
$ echo 'version 1' >> test1.txt
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   test1.txt

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   test1.txt

```

我们看到，待提交的信息并没有因为工作目录中文件内容的改变而改变，并且多了一条未暂存的变化提示，变化类型为`modified`（已修改），涉及文件为`test1.txt`

此时，我们查看`objects`目录和暂存区内容，都没有任何变化：

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210729140141.png)

```bash
$ git ls-files -s
100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       test1.txt

```

然后我们执行`git add`，再查看Git工作目录状态、`objects`目录、暂存区内容

```bash
$ git add .
warning: LF will be replaced by CRLF in test1.txt.
The file will have its original line endings in your working directory

$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   test1.txt

```

此时，已经没有【未暂存】的内容提示了，只剩【待提交】内容提示。

注意，由于从来没有提交过，所以此时【待提交】内容提示中的变化类型还是`new file`，而非`modified`，这里得出一个结论：

**结论2： git status 显示的状态信息中的变化类型是相对于上一次暂存区变动后的**

![image-20210729140747526](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210729140747.png)

此时，`objects`目录多了一个目录和文件，我们查看下它的内容：

```bash
$ git cat-file -p 83baae61804e65cc73a7201a7252750c76066a30
version 1

```

正是我们刚刚为`test1.txt`添加的内容。

此时我们发现，先前空内容的二进制对象`e6xxx`并没有因为内容的改变而消失，而是仍旧存在。而此时，它就是作为一个历史版本存在的。这样，我们又得到如下结论：

**结论3：对于:一个文件，每次重新被添加到暂存区时，都会将当时那个状态的文件内容做一次全文快照（SHA-1计算），保存为二进制对象，即Git的版本库保存的是每次变化后的全文快照，而非增量内容**

```bash
$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt

```

我们发现，此时暂存区也发生了变化，此时`test1.txt`对应的二进制对象名称变成了刚刚添加的那个。由是，我们又得到一个结论：

**结论4：对于一个文件，当其内容改变并被重新添加到暂存区时，暂存区会更新它与`objects`目录下二进制文件的映射关系**

#### 6. 从工作目录删除新文件

我们将空文件`test1.txt`从工作目录中删除，再查看Git工作目录状态

```bash
$ rm -rf test1.txt
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   test1.txt

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    test1.txt

```

我们看到，待提交的信息并没有因为工作目录中文件的删除而改变，并且多了一条未暂存的变化提示，变化类型为`deleted`（已删除），涉及文件为`test1.txt`

此时，我们再看暂存区的内容：

```bash
$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt
```

没有发生变化。

再看`objects`目录：

![image-20210729161141950](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210729161210.png)

然后我们再执行一遍`git add`操作，再看Git工作目录状态和暂存区文件内容

```bash
$ git add .
$ git status
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)
$ git ls-files -s
// 没有输出
```

然后我们再看目录结构：

![image-20210729161344628](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210729161344.png)

`objects`目录下的二进制对象（其实就是该文件的历史版本）还在。



至此，我们得到以下结论：

**结论5：在没有进行git操作之前，单纯对工作目录的文件进行增删改操作，只会影响git status的输出，不会影响暂存区内容**

**结论6： git add 执行了两个操作**

```bash
1.  如果工作区的文件发生了改变（不包括删除），则为其建立新的快照（二进制对象），并存储到`objects`目录下
2.  更新索引文件中发生改变的文件所对应的二进制对象。（如果删除了文件，则删除文件对应的索引）。
```

简言之：

1. 建立快照（`objects`）
2. 更新索引（`index`）。

实际上，Git底层就是调用了两个底层命令来完成`git add`命令的：

* `git hash-object`：计算文件的SHA值（使用SHA-1算法），生成快照（需要加`-w`）参数
* `git update-inidex`： 更新索引

有兴趣，可以到[这里](https://gitee.com/progit/9-Git-%E5%86%85%E9%83%A8%E5%8E%9F%E7%90%86.html#9.2-Git-%E5%AF%B9%E8%B1%A1)进行深度阅读。

#### 7. 在目录中新建一个文件并添加到暂存区

```bash
$ cd fisrtdir/
$ touch test1.txt
$ echo 'version 1' >> test1.txt
$ git add .
warning: LF will be replaced by CRLF in fisrtdir/test1.txt.
The file will have its original line endings in your working directory

```

我们从根目录转战到一开始我们创建的目录中，重新建立一个与刚才我们删除的文件文件名和内容一样的文件，并把它添加到了暂存区，现在看一下状态：

```bash
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   test1.txt

```

再看下`objects`目录

![image-20210729162240486](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210729162240.png)

没有变化！！！

我们上面说过，`git  add` 操作会为发生变化的文件创建一个新的快照，但是这里却没有变化，说明什么？

Git是以内容的SHA-1计算值来作为版本历史的，如果两个文件有一模一样的内容，那么它们将共享一个二进制快照。

我们可以先看下暂存区再验证上面这个猜想

```bash
$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt

```

好的，这里索引将文件与我们之前那个已经删除的文件的最后一个版本对应了起来。

现在，我们在同一个目录下，创建另一个与这个文件内容一样的文件，看看会发生什么变化：

```bash
$ touch test2.txt
$ echo 'version 1' >> test2.txt
$ git add .
warning: LF will be replaced by CRLF in fisrtdir/test2.txt.
The file will have its original line endings in your working directory
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   test1.txt
        new file:   test2.txt

```

现在，我们的待提交列表里有了两个文件。

然后看看`objects`目录：

![image-20210729162930685](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210729162930.png)



岿然不动！！！

我们得到了一个结论：

**结论7：:如果两个文件的内容一模一样，无论他们的路径和文件名是否一样，它们共享`objects`里同一个二进制对象**

顺便也看下暂存区：

```bash
$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test2.txt

```

果然，在暂存区，工作目录的两个文件被映射到了`objects`目录下的同一个对象上。

#### 8. 提交一下

前面我们实验了工作目录的变更与暂存区（`index`）和本地仓库(`objects`)之间的变化关系和原理，接下来我们进行一次提交，看看暂存区和本地仓库又会发生什么新的变化。

```bash
$ cd .. // 回到项目根目录
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   fisrtdir/test1.txt
        new file:   fisrtdir/test2.txt

```

注意，此时回到根目录所显示的`git status`信息和刚刚在`firstdir`目录中执行`git status`时的输出是有差别的：

待提交的文件加上了路径。

据此，我们又得到一个结论：

**结论8： git status 反映的是执行命令时所在工作目录文件的变化，其文件路径是相对于执行命令时的目录的**

```bash
$ git commit -m "v1"
[master (root-commit) c18c134] v1
 2 files changed, 2 insertions(+)
 create mode 100644 fisrtdir/test1.txt
 create mode 100644 fisrtdir/test2.txt
$ git status
On branch master
nothing to commit, working tree clean

```

执行完`commit`，我们看到了一些返回信息，现在我们来看看它们都代表什么意思：

`[branch (root-commit) commitHash] msg`

`changed file count, changed lines info`

`changed file list: type mode modevalue filepath`

* `branch(root-commit)` : 当前提交到了哪个分支上，可选的`root-commit`表明这是整个项目的第一次提交

* `commitHash`：本次提交在`objects`目录下所对应的二进制对象名称的前7位

* `msg`:  用户提交时输入的提交信息，即`-m` 参数的值

* `changed file count`：本次提交涉及的有变化的文件数量

* `changed lines info`： 本次提交涉及的有变化的行数说明（`+`代表插入，`-`代表删除），如果是对某行的修改，则意味着先删除，后插入

* `changed file list`：发生变化的文件列表，具体：

  * `type`：变化类型，这里`create`代表新创建
  * `mode`： 固定值，文件模式
  * `modeValue`: 文件模式的值
  * `filepath`： 文件路径

  此时查看工作目录状态，会被告知当前出于哪个分支，没有待提交的内容，工作目录是干净的（即上次提交后没有任何变化）。

  先来看下暂存区：

  ```bash
  $ git ls-files -s
  100644 83baae61804e65cc73a7201a7252750c76066a30 0       fisrtdir/test1.txt
  100644 83baae61804e65cc73a7201a7252750c76066a30 0       fisrtdir/test2.txt
  ```

  没有发生任何变化，我们又得到一个结论：

  **结论9： Git提交不会改变暂存区的内容**

  然后看下`objects`目录

  ![image-20210729170644004](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210729170644.png)

  好家伙，竟然多了这么多，没关系，我们一个一个看

  * `COMMIT_EDITMSG`:  第一次提交后自动创建的文本文件，用来存储上一次提交时用户输入的提交信息，当我们执行`git amend`命令时，其实就是在编辑这个文件。

  * `logs`目录，保存所有更新的引用记录，里面包含了：

    * `HEAD` 保存的是所有的操作记录，使用 `git reflog `查询的结果就是从这个文件来的。其格式如下：

      `preHash`  `curHash`  `username` `useremail` `time` `opertype` `msg`

      * `preHash`：上一次提交的SHA值，这里由于是第一次，所以上一次是`0000000……`
      * `curHash`：本次提交的SHA值
      * `username`：操作者姓名
      * `useremail`： 操作者邮箱
      * `time`： 操作时间，包含时间戳和时区
      * `opertype`: 操作类型，这里是提交
      * `msg`： 操作信息，这里是提交信息

    * `refs `文件夹中有两个文件夹

      * `heads`: 里面存储的是本地分支的对象，每个对象的文件名就是本地的一个分支名。我们使用 `git branch `查看本地所有分支时，查询出的分支就是` heads `文件夹下所有文件的名称，这些分支文件中存储的是对应分支下的操作记录，操作记录的格式同`logs/HEAD`中的一样。
      * `remotes`：这里还没创建，要等到添加了远程仓库后才创建。到时我们再说

  * `refs`目录下

    * `heads`目录下多了一个`master`文件： 文件中存储了`master`分支当前指向的 `commit`

  最后，我们看`objects`下面又多了三个对象，加上原来是两个对象，总共有五个对象了，现在我们按个来看下它们的内容和类型（通过`git cat-file`的`-t`选项）：

  ```bash
  $ git cat-file -p 7c976dec102d3872bf3bbf6e4df6c694249cb645
  100644 blob 83baae61804e65cc73a7201a7252750c76066a30    test1.txt
  100644 blob 83baae61804e65cc73a7201a7252750c76066a30    test2.txt
  $ git cat-file -t 7c976dec102d3872bf3bbf6e4df6c694249cb645
  tree
  ```

  第一个是一个`tree`对象，它里面有两条记录，是本次提交的两个文件与`objects`下对象的映射关系，注意它们映射的是`blob`对象

  

  ```bash
  $ git cat-file -p 8d1be8f35fa5fba58c05bb28f1cb50813394a9c4
  040000 tree 7c976dec102d3872bf3bbf6e4df6c694249cb645    fisrtdir
  $ git cat-file -t 8d1be8f35fa5fba58c05bb28f1cb50813394a9c4
  tree
  ```

  第二个也是一个`tree`对象，它有一条记录，反映的是`firstdir`这个目录和`objects`中对象的映射关系，它被映射到了上面第一个`tree`对象上。最前面的`040000`代表这是一个目录。

  

  ```bash
  $ git cat-file -p 83baae61804e65cc73a7201a7252750c76066a30
  version 1
  $ git cat-file -t 83baae61804e65cc73a7201a7252750c76066a30
  blob
  
  ```

  第三个是早先生成的，它是一个`blob`对象，它就是工作目录中`test1.txt`和`test2.txt`两个文件所对应的二进制对象。里面存储的就是它们的内容。

  

  ```bash
  $ git cat-file -p e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
  
  $ git cat-file -t e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
  blob
  
  ```

  第四个是我们最早生成的，就是那个没有内容的空文件（后来被删除）所生成的`blob`对象，由于它没有内容，所以内容输出为空

  

  ```bash
  $ git cat-file -p c18c13420e4b84311a262b4cbf969920740d607a
  tree 8d1be8f35fa5fba58c05bb28f1cb50813394a9c4
  author 何建博 <hjb2722404@163.com> 1627548349 +0800
  committer 何建博 <hjb2722404@163.com> 1627548349 +0800
  
  v1
  
  $ git cat-file -t c18c13420e4b84311a262b4cbf969920740d607a
  commit
  
  ```

  第五个是一个类型为`commit`的对象，它里面存储了以下信息：

  * 本次`commit`所执行的文件树对象
  * 作者信息
  * 提交者信息
  * 提交描述

**结论10：作者（author）_和_提交者（committer）_之间是差别是，作者指的是实际作出修改的人，提交者指的是最后将此工作成果提交到仓库的人**

  现在，我们可以将上述五个对象的关系使用关系图来描述下了：

![image-20210802114833699](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210802114833.png)


#### 9. 修改文件内容，并添加到暂存区后提交

  

  ```bash
  $ cd fisrtdir/
  $ echo 'version 2' >> test2.txt
  $ git add .
  ```

  ![image-20210730110443821](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210730110451.png)

  依据之前所说，`git add`命令会建立快照和更新索引，`objects`下新增的这个对象就是新的快照

  我们验证下，看它的内容

  ```bash
  $ git cat-file -p 0c1e7391ca4e59584f8b773ecdbbb9467eba1547
  version 1
  version 2
  $ git cat-file -t 0c1e7391ca4e59584f8b773ecdbbb9467eba1547
  blob
  
  ```

  再看索引区：

  ```bash
  $ git ls-files -s
  100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt
  100644 0c1e7391ca4e59584f8b773ecdbbb9467eba1547 0       test2.txt
  
  ```

  `test2.txt`的索引已经更新为了刚刚建立的快照。

  我们再提交一下

  ```bash
  $ git commit -m "v2"
  [master 9297c01] v2
   1 file changed, 1 insertion(+)
  
  ```

  ![image-20210730112357472](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210730112357.png)

  现在，本地仓库里发生了以下变化：

  * `COMMIT_EDITMSG`：内容变为最新一次提交的描述。可见，这个文件总是存储最新一次提交的描述信息
  * `refs/HEAD`：此时多了一条提交记录，正如我们上面所说，它保存了所有的操作记录。
  * `refs/heads/master`：也多了一条提交记录，这个记录是属于`master`分支的。
  * `objects/`
    * `9297c01de99123bcafa9669d052211ff3c961e04`
    * `ea0c09b60766c9958752ff74f807b036e380feb0`
    * `fd4e2f5bd8d4f4f045208cb1fa5b339477b88954`

  看下这三个二进制文件的内容和类型：

  ```bash
  // 9297c01de99123bcafa9669d052211ff3c961e04
  $ git cat-file -p 9297c01de99123bcafa9669d052211ff3c961e04
  tree ea0c09b60766c9958752ff74f807b036e380feb0
  parent c18c13420e4b84311a262b4cbf969920740d607a
  author 何建博 <hjb2722404@163.com> 1627614624 +0800
  committer 何建博 <hjb2722404@163.com> 1627614624 +0800
  
  v2
  $ git cat-file -t 9297c01de99123bcafa9669d052211ff3c961e04
  commit
  // ea0c09b60766c9958752ff74f807b036e380feb0
  $ git cat-file -p ea0c09b60766c9958752ff74f807b036e380feb0
  040000 tree fd4e2f5bd8d4f4f045208cb1fa5b339477b88954    fisrtdir
  
  $ git cat-file -t ea0c09b60766c9958752ff74f807b036e380feb0
  tree
  
  
  //fd4e2f5bd8d4f4f045208cb1fa5b339477b88954
  $ git cat-file -p fd4e2f5bd8d4f4f045208cb1fa5b339477b88954
  100644 blob 83baae61804e65cc73a7201a7252750c76066a30    test1.txt
  100644 blob 0c1e7391ca4e59584f8b773ecdbbb9467eba1547    test2.txt
  $ git cat-file -t fd4e2f5bd8d4f4f045208cb1fa5b339477b88954
  tree
  ```

  又是一个`commit`对象和两个`tree`对象.

  那我们修改了内容，又进行了一次提交，之前那五个对象会有变化吗？

  不会，因为`objects`中的对象名称都是根据其内容计算出的SHA值，如果SHA值没有发生变化，说明内容也没有变化。我们还是验证一下：

  ```bash
  $ git cat-file -p 7c976dec102d3872bf3bbf6e4df6c694249cb645
  100644 blob 83baae61804e65cc73a7201a7252750c76066a30    test1.txt
  100644 blob 83baae61804e65cc73a7201a7252750c76066a30    test2.txt
  $ git cat-file -p 8d1be8f35fa5fba58c05bb28f1cb50813394a9c4
  040000 tree 7c976dec102d3872bf3bbf6e4df6c694249cb645    fisrtdir
  $ git cat-file -p 83baae61804e65cc73a7201a7252750c76066a30
  version 1
  $ git cat-file -p e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
  $ git cat-file -p c18c13420e4b84311a262b4cbf969920740d607a
  tree 8d1be8f35fa5fba58c05bb28f1cb50813394a9c4
  author 何建博 <hjb2722404@163.com> 1627548349 +0800
  committer 何建博 <hjb2722404@163.com> 1627548349 +0800
  
  v1
  
  ```

  可以与前文结果对照，并无什么变化。

  所以，我们又得到一个结论：

  **结论11,： Git的每次提交，都会根据本次提交与上次提交的不同，生成新的`tree`对象和`commit`对象，并更新日志目录里的操作记录和对应分支的操作记录**

  简言之，`git commit `做了如下操作

  1. 生成存储目录嵌套结构的 `tree`对象
  2. 生成`commit`对象，存储顶级`tree`对象、作者、提交者信息
  3. 更新日志。

  事实上，Git底层是调用如下底层命令来实现上述操作的：

  * `git write-tree` : 创建`tree`对象
  * `git commit-tree`：创建`commit` 对象
  * `git update-ref` :  更新日志

  对细节感兴趣可以[看这里](https://gitee.com/progit/9-Git-%E5%86%85%E9%83%A8%E5%8E%9F%E7%90%86.html#9.2-Git-%E5%AF%B9%E8%B1%A1)

  

  现在，我们的关系图更新如下：

![image-20210802114944522](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210802114944.png)

  

#### 10. 与修改相关的命令

  ##### `git diff` 查看变更内容

  现在，我们先看看工作目录状态：

  ```bash
  $ git status
  On branch master
  nothing to commit, working tree clean
  
  ```

  工作目录是干净的，所以现在执行`git diff`命令应该是没有任何输出的：

  ```bash
  $ git diff
  
  ```

  试着修改一下`test2.txt`的内容，再执行`git diff`

  ```bash
  $ echo 'version 3' >> test2.txt
  
  $ cat test2.txt
  version 1
  version 2
  version 3
  
  $ git diff
  warning: LF will be replaced by CRLF in fisrtdir/test2.txt.
  The file will have its original line endings in your working directory
  diff --git a/fisrtdir/test2.txt b/fisrtdir/test2.txt
  index 0c1e739..822f9b8 100644
  --- a/fisrtdir/test2.txt
  +++ b/fisrtdir/test2.txt
  @@ -1,2 +1,3 @@
   version 1
   version 2
  +version 3
  
  
  ```

  可以看到`git diff`输出了信息[^4]，这些信息包括：

  * 前两行，一个警告信息，警告比较时文件内行尾换行符`LF`将被换行符`CRLF`替换[^3]，但工作目录里的文件还是它原来的格式。
  * 下一行，`diff`,标识结果格式为`git`格式的`diff`，以及用作比较的两个版本，`a`版本和`b`版本，`a`版本是变动前的版本，即暂存区快照中的内容，`b`版本是工作目录中的当前内容。
  * 下一行，`index 0c1e739`代表暂存区快照地址，`.. 822f9b8`代表工作目录中内容的HASH计算值。`100644`是文件模式，代表普通文件
  * 下面两行，表示进行比较的两个文件，`---`表示变动前的版本， `+++`表示变动后的版本
  * 再下面一行是变动小结，表示变动的位置，前后以`@@`包裹
    * `-1,2`: 
      * `-`号表示第一个文件（即`a`版本的`test2.txt`）
      * `1` 表示从第1行开始
      * `2`表示连续2行
      * 总的意思是：下面具体的变动内容中，从第 1 行开始的连续 2 行的内容时第一个文件的
    * `+1,3`:
      * `+` 号表示第二个文件（即`b`版本的`test2.txt`）
      * `1` 从第1行开始
      * `3` 表示连续3行
      * 总的意思是：下面具体的变动内容中，从第 1 行开始的连续 3行的内容时第二个文件的
  * 再下面几行就是所有的具体变化内容，上面变动小结的序号就是以这里的行的序号为准的。

我们上面说，比较的版本是暂存区的快照版本和工作目录的版本，我们验证一下。

现在我们知道，上次提交，`test2.txt`对应的`blob`对象是`0c1e7391ca4e59584f8b773ecdbbb9467eba1547`

我们看看它的内容：

```bash
$ git cat-file -p 0c1e7391ca4e59584f8b773ecdbbb9467eba1547
version 1
version 2

```

那现在工作目录中的内容是：

```bash
$ cat test2.txt
version 1
version 2
version 3

```

现在，我们把工作目录中的内容添加到暂存区，但不提交

```bash
$ git add .
warning: LF will be replaced by CRLF in fisrtdir/test2.txt.
The file will have its original line endings in your working directory

```

这里，我们同样看到了换行符替换的警告信息，这就是为什么比较时要把工作区内容的换行符进行临时替换了，因为暂存区生成快照时也是替换了的，这样才能保证`diff`时的一致性。

现在，我们可以看看暂存区：

```bash
$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt
100644 822f9b8f82f0e134b230d8e03c220c7fe2ce2c79 0       test2.txt

```

这里，`test2.txt`对应的`blob`对象信息已更新为`822f9b8f82f0e134b230d8e03c220c7fe2ce2c79`，我们看看这个新生成的快照对象的内容：

```bash
$ git cat-file -p 822f9b8f82f0e134b230d8e03c220c7fe2ce2c79
version 1
version 2
version 3

```

接下来，我们再次更改工作目录的内容:

```bash
$ echo 'version 4' >> test2.txt
$ cat test2.txt
version 1
version 2
version 3
version 4

```

现在，上次提交的快照、当前暂存区的快照、当前工作目录下`test2.txt`的内容都是不一样的了，我们再看`git diff`的结果：

```bash
$ git diff
warning: LF will be replaced by CRLF in fisrtdir/test2.txt.
The file will have its original line endings in your working directory
diff --git a/fisrtdir/test2.txt b/fisrtdir/test2.txt
index 822f9b8..48ca800 100644
--- a/fisrtdir/test2.txt
+++ b/fisrtdir/test2.txt
@@ -1,3 +1,4 @@
 version 1
 version 2
 version 3
+version 4

```

我们无论是从上面第`5`行，还是下面具体内容，都可以发现，参与比较的确实是暂存区快照和工作区内容，而没有上次提交什么事。

所以：

**结论12：`git diff`默认不带参数执行时， 对比暂存区快照与工作目录中文件内容的差异**

##### `git mv` 文件改名

我们尝试将`test1.txt`改名为`test.txt`

```bash
$ git mv test1.txt test.txt
$ ll
total 2
-rw-r--r-- 1 trs 197121 10 Jul 29 16:19 test.txt
-rw-r--r-- 1 trs 197121 40 Jul 30 14:14 test2.txt


```

改名成功，看看工作目录状态：

```bash
$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        renamed:    test1.txt -> test.txt
        modified:   test2.txt

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   test2.txt

```

我们看到，改名操作没有进行`git add`, 但这个变动却直接进入了待提交的列表。（`test2.txt`的修改是我们上文操作，先不用管）

我们看`objects`目录下，没有任何变化，因为我们改的是文件名，而前面说过，`objects`下的对象只和文件内容有关，与文件名无关，所以这里没有发生变化。

再看看暂存区：

```bash
$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test.txt
100644 822f9b8f82f0e134b230d8e03c220c7fe2ce2c79 0       test2.txt
```

暂存区发生了变化，原来对应`test1.txt`的那条记录里，除了`test1.txt`变成了`test.txt`,其它还和原来一样。

所以：

**结论13： `git mv` 更改工作目录中文件的文件名，并将暂存区中对应的文件名使用修改后的名称进行替换，执行此操作后不用`git add`就可以直接提交**

为了方便下面的操作，我们先进行一次提交：

```bash
$ git commit -m 'v3-v4-rename'
[master 604a016] v3-v4-rename
 2 files changed, 1 insertion(+)
 rename fisrtdir/{test1.txt => test.txt} (100%)

```

看看`objects`目录

![image-20210730144716102](C:\Users\trs\AppData\Roaming\Typora\typora-user-images\image-20210730144716102.png)

这是新生成的`commit`对象和两个树对象：

```bash
$ git cat-file -p 1eabe4abc7348adfcf46691a68e75f15445074fa
040000 tree 65788721081a2317015819c537bb15501da014af    fisrtdir

$ git cat-file -p 604a016fee1bdd9b6d2f461c634f501fc0ce60de
tree 1eabe4abc7348adfcf46691a68e75f15445074fa
parent 9297c01de99123bcafa9669d052211ff3c961e04
author 何建博 <hjb2722404@163.com> 1627626907 +0800
committer 何建博 <hjb2722404@163.com> 1627626907 +0800

v3-v4-rename

$ git cat-file -p 65788721081a2317015819c537bb15501da014af
100644 blob 83baae61804e65cc73a7201a7252750c76066a30    test.txt
100644 blob 822f9b8f82f0e134b230d8e03c220c7fe2ce2c79    test2.txt

```

这时当前仓库内其他信息：

![image-20210730153124013](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210730153124.png)



现在，我们先看下工作目录状态：

```bash
$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   test2.txt

no changes added to commit (use "git add" and/or "git commit -a")

$ cat test2.txt
version 1
version 2
version 3
version 4


```

看到，我们对`test2.txt`的最后一次修改还未添加到暂存区，接下来，我们执行下`git restore`命令，撤销最后一次修改。

```bash
$ git restore test2.txt
$ git status
On branch master
nothing to commit, working tree clean
$ cat test2.txt
version 1
version 2
version 3
```

除了工作目录，暂存区与`objects`目录没有任何变化。

##### `git reset` 撤销提交

第一种，软撤销 `--soft`

```bash
$ git reset --soft HEAD~1
$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        renamed:    test1.txt -> test.txt
        modified:   test2.txt
        
```

可以看到，我们最后一次提交的内容又回到了待提交列表中，而此时，我们看`objects`目录：

```bash
// 进入objects目录

$ ll -a
total 8
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 ./
drwxr-xr-x 1 trs 197121 0 Jul 30 15:52 ../
drwxr-xr-x 1 trs 197121 0 Jul 30 11:03 0c/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 1e/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 60/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 65/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 7c/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:10 82/
drwxr-xr-x 1 trs 197121 0 Jul 29 14:03 83/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 8d/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 92/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 c1/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 ea/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 fd/
drwxr-xr-x 1 trs 197121 0 Jul 29 10:50 info/
drwxr-xr-x 1 trs 197121 0 Jul 29 10:50 pack/

```

没有任何变化。

再看仓库其他信息

  ![image-20210730160046251](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210730160046.png)



又是很多变化，我们一个一个看：

1. `logs`里面，无论是`HEAD`还是`master`分支的操作记录都多了一条操作类型为`reset`的记录，这条记录中，前一次提交HASH是我们的上次提交的HASH，而本次HASH则是上上次提交的HASH
2. `refs`目录里的`master`当前内容由上次提交的HASH编程了上上次提交的HASH
3. `COMMIT_EDITMSG`的内容没有变化，可见它只有在有新提交时才会变，而撤销提交不会影响它。
4. 多了一个文件`ORIG_HEAD`，存储了上一次提交的HASH

总结下软撤销做的工作：

1. 更新操作记录 —— 添加一条`reset`记录
2. 更新当前分支引用的提交引用地址
3. 保存撤销前的提交HASH

第二种： 混合撤销 ，参数`--mixed`

在进行第二种撤销前，我们先再次进行提交：

```bash
$ git commit -m "re-commit"
[master 87f7898] re-commit
 2 files changed, 1 insertion(+)
 rename fisrtdir/{test1.txt => test.txt} (100%)
 
 $ git status
On branch master
nothing to commit, working tree clean

```

![image-20210730161225935](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210730161226.png)

还是老规矩，更新了分支引用，更新了最后一次提交信息，更新了操作记录

```bash
$ ll -a
total 8
drwxr-xr-x 1 trs 197121 0 Jul 30 16:11 ./
drwxr-xr-x 1 trs 197121 0 Jul 30 16:11 ../
drwxr-xr-x 1 trs 197121 0 Jul 30 11:03 0c/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 1e/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 60/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 65/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 7c/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:10 82/
drwxr-xr-x 1 trs 197121 0 Jul 29 14:03 83/
drwxr-xr-x 1 trs 197121 0 Jul 30 16:11 87/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 8d/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 92/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 c1/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 ea/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 fd/
drwxr-xr-x 1 trs 197121 0 Jul 29 10:50 info/
drwxr-xr-x 1 trs 197121 0 Jul 29 10:50 pack/

```

`objects`还是没变化，因为文件内容没有变化。同理，暂存区也没有变化。

现在，我们进行混合撤销操作：

```bash
$ git reset --mixed HEAD~1
Unstaged changes after reset:
D       fisrtdir/test1.txt
M       fisrtdir/test2.txt

$ git status
On branch master
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    test1.txt
        modified:   test2.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        test.txt

no changes added to commit (use "git add" and/or "git commit -a")

```



**不同于软撤销，将更改恢复到待提交列表，混合撤销将更改恢复到了未暂存列表**

并且，我们的重命名操作也被回退，这里显示的是删除了`test1.txt`,新增了`test.txt`.

看看仓库的其它信息：

![image-20210730162157490](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210730162157.png)

然后再看暂存区：

```bash
$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt
100644 0c1e7391ca4e59584f8b773ecdbbb9467eba1547 0       test2.txt

$ git cat-file -p 0c1e7391ca4e59584f8b773ecdbbb9467eba1547
version 1
version 2

```

发生了两点变化：

1. 我们之前重命名后的`test.txt` 又变回了`test1.txt`
2. `test2.txt`对应的`blob`对象的SHA值变为了之前`v2`的版本：

由此，混合撤销做了以下工作：

1. 更新了操作记录——添加一条`reset`类型的记录
2. 将上上次提交到上次提交之间的更改全部恢复为未暂存状态
3. 更新暂存区索引。（因为第二步）

这种撤销是我们执行不带参数的`git reset`命令时的默认处理方式

第三种： 硬撤销 ，参数`--hard`

在进行第三种撤销操作前，我们还是再次提交：

```bash
$ git add .
warning: LF will be replaced by CRLF in fisrtdir/test.txt.
The file will have its original line endings in your working directory

$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        renamed:    test1.txt -> test.txt
        modified:   test2.txt
        
$ git commit -m "re-commit-2"
[master f4fed17] re-commit-2
 2 files changed, 1 insertion(+)
 rename fisrtdir/{test1.txt => test.txt} (100%)

$ git status
On branch master
nothing to commit, working tree clean
```

看 `objects`对象

```bash
//在objects目录下执行
$ ll -a
total 8
drwxr-xr-x 1 trs 197121 0 Jul 30 16:32 ./
drwxr-xr-x 1 trs 197121 0 Jul 30 16:32 ../
drwxr-xr-x 1 trs 197121 0 Jul 30 11:03 0c/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 1e/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 60/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 65/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 7c/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:10 82/
drwxr-xr-x 1 trs 197121 0 Jul 29 14:03 83/
drwxr-xr-x 1 trs 197121 0 Jul 30 16:11 87/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 8d/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 92/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 c1/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 ea/
drwxr-xr-x 1 trs 197121 0 Jul 30 16:32 f4/  // 这里新生成了一个对象
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 fd/
drwxr-xr-x 1 trs 197121 0 Jul 29 10:50 info/
drwxr-xr-x 1 trs 197121 0 Jul 29 10:50 pack/

```

我们发现多了一个对象，让我们看下它的内容：

```bash
$ git cat-file -p f4fed170c78535c48e9128fa4f1b51d2bcd4face
tree 1eabe4abc7348adfcf46691a68e75f15445074fa
parent 9297c01de99123bcafa9669d052211ff3c961e04
author 何建博 <hjb2722404@163.com> 1627633951 +0800
committer 何建博 <hjb2722404@163.com> 1627633951 +0800

re-commit-2

$ git cat-file -t f4fed170c78535c48e9128fa4f1b51d2bcd4face
commit
```

我们发现，这是新建了一个`commit`对象，既然`objects`目录下新建了提交对象，那说明它的内容发生了改变，我们对比一下它和之前那次提交的`commit`对象的不同

```bash
$ git cat-file -p 604a016fee1bdd9b6d2f461c634f501fc0ce60de
tree 1eabe4abc7348adfcf46691a68e75f15445074fa
parent 9297c01de99123bcafa9669d052211ff3c961e04
author 何建博 <hjb2722404@163.com> 1627626907 +0800
committer 何建博 <hjb2722404@163.com> 1627626907 +0800

v3-v4-rename

```

我们发现，是因为提交信息（`msg`）变了。所以生成了新的`commit`。

看看仓库其他信息：

<img src="https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210730164429.png" alt="image-20210730164429230"  />



现在，进行硬撤销：

```bash
$ git reset --hard HEAD~1
HEAD is now at 9297c01 v2
$ git status
On branch master
nothing to commit, working tree clean
$ ll
total 2
-rw-r--r-- 1 trs 197121 11 Jul 30 16:47 test1.txt
-rw-r--r-- 1 trs 197121 22 Jul 30 16:47 test2.txt
$ cat test2.txt
version 1
version 2
$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt
100644 0c1e7391ca4e59584f8b773ecdbbb9467eba1547 0       test2.txt

```

可以看到，硬撤销直接将工作目录和暂存区都重置为上上次提交后的状态了。

硬撤销后，`objects`目录没有变化

看看仓库其他信息：

![image-20210730165246629](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210730165246.png)



1. 更新操作记录——添加了一条`reset`记录
2. 更新了当前分支引用的提交HASH地址
3. 保存了上一次提交的HASH

现在，我们来总结一下Git撤销提交的三种模式：

* 软撤销（`--sort`）: 将已提交的更改恢复为待提交状态，暂存区索引与工作目录文件都无变化，只是本地仓库中更改了当前分支所引用的提交快照。
* 混合撤销（`--mixed` 默认方式）：将已提交的更改恢复为未暂存状态，工作目录文件不发生变化，本地仓库更改了当前分支所引用的提交快照，但暂存区索引会恢复到将这些更改添加到暂存区之前的状态。
* 硬撤销（`--hard`）：将已提交的更改丢弃掉，工作目录恢复到这些更改未发生之前的状态，暂存区索引也回到这些更改未发生之前，本地仓库更改了当前分支所引用的提交快照。

以上所说“更改”指的是上上次提交到上次提交之间对工作目录内容所做的所有修改。

到这里，我们还有一个疑问——`git reset` 的硬撤销模式将工作区的内容使用上上次提交快照中的内容给替换掉了，那么它是如何实现的呢？

我们不妨根据现有信息大胆猜测一下，以下内容纯属猜测，Git内部到底是不是这么运行的，并不能十分确定。

这里，我们先看看命令：

```bash
$ git reset --hard HEAD~1
```

前面的命令我们不管了，关键看最后一个`HEAD~1`，这个参数告诉命令，我们要恢复到当前提交（`HEAD`）的前1个提交（`~1`）.如果我们要回到往前数第3个提交，我们既要传入`HEAD~3`。我们看到了`HEAD`，回想上文，仓库中有三个和`HEAD`有关的文件:

`.git/HEAD`： 这个文件里的内容是一个`ref`地址，指向的是当前操作的分支文件`refs/heads/master`

`.git/logs/HEAD`：这里存放的是所有操作记录

`.git/ORIG_HEAD`: 这里是执行`git reset`之后才生成的，存储的是`reset`之前最后一次提交的SHA值。

按照上面分析，既然`reset`命令可以回到当前提交之前的N个提交，那说明这N个提交信息它都能读取到，那只能是读取了`.git/logs/HEAD`里的记录，但是细一想，真是这样吗？

不然，因为`.git/logs/HEAD`里存放的是所有分支的操作记录，但很明显，当我们执行`reset`时期望的是回到当前分支的往前数第N个提交。那很明显，命令里的`HEAD`应该代表的是当前分支，即读取的是`.git/HEAD`里的引用地址，按照引用地址，找到了这个文件：

`.git/refs/heads/master`

这个里面存储的是当前分支此时指向哪个提交对象上：`f4fed170c78535c48e9128fa4f1b51d2bcd4face`

然后，我们知道，还有一个地方可以查到当前分支`master`所有的提交记录，那就是：

`.git/logs/refs/heads/master`

我们可以在这个文件里看到当前指向的提交`f4fed170c78535c48e9128fa4f1b51d2bcd4face`的前一条提交的SHA值是

`9297c01de99123bcafa9669d052211ff3c961e04`，实际上，此时仓库里各个提交对象、树对象和`blob`对象的关系如下图所示：

![image-20210802101307632](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210802101553.png)

实际上，除了第一次提交的`commit`对象，其它所有的提交对象都有一个`parent`属性，指向本次提交的前一次提交的HASH，通过这种机制，所有的`commit`形成了一个链条，当我们指定`HEAD~N`时，就会：

1. 沿着这个链条往前找`N`步，找到那个目标提交的HASH，
2. 然后根据`HASH`值读取到目标提交对象，
3. 再根据对象里记录的`tree`对象的HASH，找到树对象，沿着树对象形成的链条往后递归
4. 找到所有的树对象，和每个树对象里的嵌套的树对象以及`blob`对象，及其对应的目录名称和文件名称、文件内容，
5. 最后删除原来工作目录中的所有文件，按照从快照中读取到的目录层级、文件名称、文件内容，挨个将它们写入工作目录。

##### `git revert`  撤销操作

在执行完`git reset`硬撤销后，我们看看现在的提交记录：

```bash
$ git log
commit 9297c01de99123bcafa9669d052211ff3c961e04 (HEAD -> master)
Author: 何建博 <hjb2722404@163.com>
Date:   Fri Jul 30 11:10:24 2021 +0800

    v2

commit c18c13420e4b84311a262b4cbf969920740d607a
Author: 何建博 <hjb2722404@163.com>
Date:   Thu Jul 29 16:45:49 2021 +0800

    v1

$ ll
total 2
-rw-r--r-- 1 trs 197121 11 Jul 30 16:47 test1.txt
-rw-r--r-- 1 trs 197121 11 Aug  2 11:19 test2.txt

$ cat test1.txt
version 1

$ cat test2.txt
version 1
version 2

```

可以看到，在我们恢复到`9297c01de99123bcafa9669d052211ff3c961e04`提交后，在这之后的提交记录都没有了。

当前工作目录的内容变成了提交`v2`的内容。

现在，我们执行`git revert`操作：

```bash
$ git revert HEAD
```

```wiki
Revert "v2"

This reverts commit 9297c01de99123bcafa9669d052211ff3c961e04.

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch master
# Changes to be committed:
#       modified:   fisrtdir/test2.txt

```

可以看到，程序要求我们填写一个新的提交信息，默认值为`Revert "v2"`，我们采用默认值，直接输入`:wq`保存执行：

```bash

$ git revert HEAD
[master d4f0c34] Revert "v2"
 1 file changed, 1 deletion(-)

$ git log
commit d4f0c34c2f25ede948c66f78f937e66c06c16b05 (HEAD -> master)
Author: 何建博 <hjb2722404@163.com>
Date:   Mon Aug 2 11:19:46 2021 +0800

    Revert "v2"

    This reverts commit 9297c01de99123bcafa9669d052211ff3c961e04.

commit 9297c01de99123bcafa9669d052211ff3c961e04
Author: 何建博 <hjb2722404@163.com>
Date:   Fri Jul 30 11:10:24 2021 +0800

    v2

commit c18c13420e4b84311a262b4cbf969920740d607a
Author: 何建博 <hjb2722404@163.com>
Date:   Thu Jul 29 16:45:49 2021 +0800

    v1

```

可以看到，新生成了一条`commit`记录，

再看看当前工作目录内容：

```bash
$ ll
total 2
-rw-r--r-- 1 trs 197121 11 Jul 30 16:47 test1.txt
-rw-r--r-- 1 trs 197121 11 Aug  2 11:19 test2.txt

$ cat test1.txt
version 1

$ cat test2.txt
version 1

$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test2.txt


```

可以看到，当前工作目录内容变成了提交`v1`的内容，暂存区的索引也变成了`v1`提交前的索引。

再看`objects`目录：

```bash
$ ll
total 0
drwxr-xr-x 1 trs 197121 0 Jul 30 11:03 0c/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 1e/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 60/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 65/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 7c/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:10 82/
drwxr-xr-x 1 trs 197121 0 Jul 29 14:03 83/
drwxr-xr-x 1 trs 197121 0 Jul 30 16:11 87/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 8d/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 92/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 c1/
drwxr-xr-x 1 trs 197121 0 Aug  2 11:23 d4/   // 这里多了一个对象
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 ea/
drwxr-xr-x 1 trs 197121 0 Jul 30 16:32 f4/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 fd/
drwxr-xr-x 1 trs 197121 0 Jul 29 10:50 info/
drwxr-xr-x 1 trs 197121 0 Jul 29 10:50 pack/

```

毋庸置疑，这就是这次`revert`操作新生成的提交。

再看看仓库信息：

![image-20210802114124035](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210802114124.png)

可见，`git revert`的操作效果和`git reset --hard`硬撤销的效果是一样的，但是它们有一个区别：

* `git reset --hard` 不生成新的提交，只是简单地将当前分支指向目标提交，会删除目标提交之后的所有提交记录
* `git revert` 不会删除之前的提交记录，会生成一次新的提交，并将当前分支指向这次新的提交，这次提交所指向的顶级`tree`对象和目标对象一样

用图谱描述以上两种不同的变化：

`git reset --hard`:

![image-20210802134435900](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210802134436.png)





`git revert`：

![image-20210802134643087](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210802134643.png)





##### `git rm`  删除文件

这个命令有两种效果：

* 从工作目录和暂存区删除
* 只从暂存区删除（加`--cached` 参数）

接着上面的实验步骤，我们先实验第一种，先查看当前工作目录与暂存区，然后执行`rm`命令，再看工作目录和暂存区

```bash
// 执行git rm 命令前
$ ll
total 2
-rw-r--r-- 1 trs 197121 11 Jul 30 16:47 test1.txt
-rw-r--r-- 1 trs 197121 11 Aug  2 11:19 test2.txt


$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test2.txt


// 执行git rm 命令

$ git rm test1.txt
rm 'fisrtdir/test1.txt'

// 执行git rm 命令之后
$ ll
total 1
-rw-r--r-- 1 trs 197121 11 Aug  2 11:19 test2.txt

$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test2.txt

$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        deleted:    test1.txt


```

 我们看到，`git rm`命令执行了以下操作：

1. 删除了工作目录中的文件
2. 更新了暂存区索引

它的效果类似下面操作

```bash
$ rm test1.txt
$ git add
```



再来试试第二种，

```bash
$ git rm --cached test2.txt
rm 'fisrtdir/test2.txt'

$ ll
total 1
-rw-r--r-- 1 trs 197121 11 Aug  2 11:19 test2.txt

$ git ls-files -s
// 没有输出

$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        deleted:    test1.txt
        deleted:    test2.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)



```



加了`--cached`参数的`git rm`命令只更新了索引，从索引中删除了对指定文件的索引，但工作目录中对应的文件却并没有被删除。

注意此时的工作树状态——如果此时提交的话，下次再回到当前提交，工作目录中将没有`test2.txt`，并且此时的`test2.txt`将处于未跟踪状态：

```bash
$ git commit -m "rm"
[master 5c617fe] rm
 2 files changed, 2 deletions(-)
 delete mode 100644 fisrtdir/test1.txt
 delete mode 100644 fisrtdir/test2.txt
 
 $ ll
total 1
-rw-r--r-- 1 trs 197121 11 Aug  2 11:19 test2.txt

$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        ./
        
$ git add .

$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   test2.txt

```

同时，我们从`git status`给出的提示也可以知道，使用`git restore --staged`命令也可以实现`git rm --cached`命令的效果。

最后，我们提交这次更改，因为，马上将要引入一个最重要的东西——分支。

```bash
$ git commit -m "re add test2"
[master af155da] re add test2
 1 file changed, 1 insertion(+)
 create mode 100644 fisrtdir/test2.txt
```



#### 11. 新建一个分支

在新建分支前，我们还是先看看当前工作目录、暂存区、`objects`与仓库其它信息：

工作目录和暂存区：

```bash
$ ll
total 1
-rw-r--r-- 1 trs 197121 11 Aug  2 11:19 test2.txt

$ cat test2.txt
version 1

$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test2.txt

```

`objects`目录

```bash
$ ll
total 0
drwxr-xr-x 1 trs 197121 0 Jul 30 11:03 0c/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 1e/
drwxr-xr-x 1 trs 197121 0 Aug  2 14:26 49/
drwxr-xr-x 1 trs 197121 0 Aug  2 14:04 4b/
drwxr-xr-x 1 trs 197121 0 Aug  2 14:04 5c/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 60/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 65/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 7c/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:10 82/
drwxr-xr-x 1 trs 197121 0 Jul 29 14:03 83/
drwxr-xr-x 1 trs 197121 0 Jul 30 16:11 87/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 8d/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 92/
drwxr-xr-x 1 trs 197121 0 Aug  2 14:26 af/
drwxr-xr-x 1 trs 197121 0 Aug  2 14:26 b2/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 c1/
drwxr-xr-x 1 trs 197121 0 Aug  2 11:23 d4/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 ea/
drwxr-xr-x 1 trs 197121 0 Jul 30 16:32 f4/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 fd/
drwxr-xr-x 1 trs 197121 0 Jul 29 10:50 info/
drwxr-xr-x 1 trs 197121 0 Jul 29 10:50 pack/

```

仓库其它信息：

![image-20210802143917345](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210802143917.png)

当前关系图谱：

![image-20210802145827932](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210802145828.png)

好的，现在我们使用`git branch` 查看下当前的分支情况

```bash
$ git branch
* master

```

目前只有一个分支，前面的`*` 号表明当前分支是`master`

接下来使用`git branch` 新建一个分支 

```bash
$ git branch dev
$ git branch
  dev
* master
```

我们看到，本地分支列表中多了一个`dev`分支，但当前仍旧在`master`分支上。

此时如果查看工作区，暂存区和`objects`目录，都没有发生变化，那看看当前仓库其它信息：

![image-20210802150258370](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210802150258.png)



可以看到，多了两个文件：

* `logs/refs/heads/dev`：`dev`分支的操作记录，新建时的记录是`branch: Created from master`
* `refs/heads/dev`： 存放了`dev`分支所指向的提交的SHA值，此时它的内容与同目录下`master`的一样。

前面我们说过，Git的分支与之前所有版本控制系统都不一样，非常的轻量级，现在应该能够明白为什么了：

**结论14：Git新建分支其实就是新建了一个引用指针而已，这个指针存储了新建分支时所在那个分支当时所指向的提交对象的SHA值**。

此时，关系图谱如下：

![image-20210802151348915](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210802151349.png)

接下来，我们使用`git checkout`命令切换到新建的`dev`分支

```bash
$ git checkout dev
Switched to branch 'dev'

$ git branch
* dev
  master

```

可以看到，当前分支已经切换为了`dev`分支

![image-20210802151608238](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210802151608.png)

可以看到，此时，有两个文件发生了变化：

* `.git/HEAD`：它的内容更新为了`dev`分支的引用地址
* `logs/HEAD`： 全局操作记录里多了一条`checkout`的记录。

我们前面说`HEAD`是当前分支的别名，现在能明白了，因为`HEAD`里的内容永远只有一行，那就是当前分支的引用地址（就是`refs/heads/`目录下的分支对应文件路径）。

现在，关系图谱如下：

![image-20210802152019275](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210802152019.png)

`HEAD`就像是一个分支指针，而切换分支就是移动指针位置而已。

#### 12. 在新分支提交两次

我们修改`test2.txt`的内容提交一次，再新建一个`test1.txt`文件，再提交一次，为了让`objects`目录变化最小，我们还是按照以前一样的内容进行修改：

```bash
$ ll
total 1
-rw-r--r-- 1 trs 197121 11 Aug  2 11:19 test2.txt

$ cat test2.txt
version 1

$ echo 'version 2' >> test2.txt

$ git add .
warning: LF will be replaced by CRLF in fisrtdir/test2.txt.
The file will have its original line endings in your working directory

$ cat test2.txt
version 1
version 2

$ git commit -m 'v2'
[dev 83aa5d4] v2
 1 file changed, 1 insertion(+)
 
 $ echo 'version 1' >> test1.txt
 
 $ ll
total 2
-rw-r--r-- 1 trs 197121 10 Aug  2 16:28 test1.txt
-rw-r--r-- 1 trs 197121 21 Aug  2 15:46 test2.txt

$ git add .
warning: LF will be replaced by CRLF in fisrtdir/test1.txt.
The file will have its original line endings in your working directory

$ git commit -m "v2"
[dev 1e8c39e] v2
 1 file changed, 1 insertion(+)
 create mode 100644 fisrtdir/test1.txt

$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt
100644 0c1e7391ca4e59584f8b773ecdbbb9467eba1547 0       test2.txt
```

看下仓库信息：

![image-20210802163203904](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210802163204.png)



我们使用`git cat-file`方法一路追踪这两个提交对象（这里过程就省略了），得到如下关系图谱：

![image-20210802165616139](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210802173857.png)

 #### 13. 合并分支

我们切回到`master`分支：

```bash
$ git checkout master
Switched to branch 'master'

$ git branch
  dev
* master

```

在`master`分支上修改`test2.txt`的内容，然后提交：

```bash
$ cat test2.txt
version 1

$ echo 'version 2 master' >> test2.txt

$ cat test2.txt
version 1
version 2 master

$ git add .
warning: LF will be replaced by CRLF in fisrtdir/test2.txt.
The file will have its original line endings in your working directory

$ git commit -m "v2 in master"
[master 06865bd] v2 in master
 1 file changed, 1 insertion(+)


```

看看当前仓库信息：

![image-20210803102815805](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803102823.png)



根据目前信息，我们画出当前仓库里分支与提交的关系图谱（为了方便聚焦于主要变化，不再展示内容细节）：

![image-20210803103518782](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803103518.png)



现在，我们将`dev`分支合并入`master`分支：

```bash
$ git merge dev
Auto-merging fisrtdir/test2.txt
CONFLICT (content): Merge conflict in fisrtdir/test2.txt
Automatic merge failed; fix conflicts and then commit the result.

$ git status
On branch master
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Changes to be committed:
        new file:   test1.txt

Unmerged paths:
  (use "git add <file>..." to mark resolution)
        both modified:   test2.txt

```

我们看到，Git提示我们，它尝试自动合并两个分支的`test2.txt`，但是出现了冲突，自动合并失败，需要我们手动解决冲突后再提交结果。

再看当前工作树状态，发现多了一个`Unmerged paths`，里面是出现冲突的文件，类型为`both modified`，即两个分支同时都修改了这个文件。

![image-20210803104127601](C:\Users\trs\AppData\Roaming\Typora\typora-user-images\image-20210803104127601.png)

此时我们看仓库状态信息，发现多了三个文件：

* `MERGE_HEAD`:  一个指针，指向要合并的分支的当前提交对象。如果冲突未解决，就试图从远程仓库`pull`最先代码，`pull`命令会先检查有没有这个文件，如果这个文件存在，就会报错。
* `MERGE_MODE`: 暂时未查到关于此文件的相关资料，不知其作用
* `MERGE_MSG`：一个用于记录合并结果信息的文件。

再看此时的暂存区：

```bash
$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt
100644 83baae61804e65cc73a7201a7252750c76066a30 1       test2.txt
100644 d6508a9fed612872652dff0b673c6d35e129ef73 2       test2.txt
100644 0c1e7391ca4e59584f8b773ecdbbb9467eba1547 3       test2.txt

```

我们看到它保存了`text2.txt`的三个版本的索引，分别看下这三个内容：

```bash
$ git cat-file -p 83ba
version 1

$ git cat-file -p d650
version 1
version 2 master

$ git cat-file -p 0c1e
version 1
version 2

```

还记得前面说过的【三路合并】吗，可以看到，此时的三个版本分别是：

1. 基础提交（即两个分支的共同祖先提交（`af155da`））上`test2.txt`版本
2. 当前分支所指向的提交(`06865bd`)上的`text2.txt`版本
3. 目标分支（被合并分支`dev`）所指向的提交(`1e8c39e`)上的`test2.txt`版本。

然后，我们看下工作目录：

![image-20210803110228574](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803110228.png)

可以看到，当前工作目录下，有冲突的文件`test2.txt`中被加入了冲突标记，格式如下：

```css

xxxxxxx // 基础版本与当前分支版本和目标分支版本相同的部分，
<<<<<< HEAD
xxxxxx // 当前分支版本与基础版本比较后的差异部分
==========
xxxxxxx // 目标分支版本与基础版本比较后的差异部分
>>>>>>> dev // 目标分支名称
xxxxxxx // 基础版本与当前分支版本和目标分支版本相同的部分，
```

在冲突时，=我们也可以通过`git diff`查看当前冲突详情：

```bash
$ git diff
diff --cc fisrtdir/test2.txt
index d6508a9,0c1e739..0000000
--- a/fisrtdir/test2.txt
+++ b/fisrtdir/test2.txt
@@@ -1,2 -1,2 +1,6 @@@
  version 1
++<<<<<<< HEAD
 +version 2 master
++=======
+ version 2
++>>>>>>> dev

```

我们再看此时的`objects`目录

![image-20210803111139677](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803111139.png)



我们查看下它的内容：

```bash
$ git cat-file -p 8b39
version 1
<<<<<<< HEAD
version 2 master
=======
version 2
>>>>>>> dev
```

我们发现，这个内容和我们当前工作目录中的`text2.txt`内容一模一样。

所以，我们此时工作目录中的冲突内容其实也是被创建了快照的。

我们尝试不解决冲突，直接提交：

```bash
$ git commit -m "not fix confilict"
error: Committing is not possible because you have unmerged files.
hint: Fix them up in the work tree, and then use 'git add/rm <file>'
hint: as appropriate to mark resolution and make a commit.
fatal: Exiting because of an unresolved conflict.
U       fisrtdir/test2.txt

```

不允许提交，因为冲突未解决，我们尝试下先`git add`，再提交：

```
$ git add .
$ git status
On branch master
All conflicts fixed but you are still merging.
  (use "git commit" to conclude merge)

Changes to be committed:
        new file:   test1.txt
        modified:   test2.txt

```

不再有`unMerged paths`，所以，`git add`的又一个作用是：标记冲突已解决。

但其实此时冲突并未解决，我们还是把冲突给解决了(采用当前分支上的更改)，重新`git add`，再提交：

```bash
$ cat test2.txt
version 1
version 2 master

$ git add .

$ git commit -m 'fix confilict'
[master d3c4a56] fix confilict


```

提交后的变化：

仓库信息：

![image-20210803114026368](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803114026.png)

可以发现，冲突解决后，`MERGE_HEAD`、`MERGE_MSG`、`MERGE_MODE`三个文件自动删除。其它变化与之前一样。

暂存区：

```
$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt
100644 d6508a9fed612872652dff0b673c6d35e129ef73 0       test2.txt

```

`test2.txt`的索引只留了一个版本。

`objects`目录

![image-20210803113832073](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803113832.png)



多了三个对象，不用多想，肯定是新生成的两个`tree`对象和一个`commit`对象：

```bash
$ git cat-file -p d3c4
tree 68603cac361ab7765ac5f4c6ef35639ba2aa4626
parent 06865bd463c3f764c8acdccdb2e77305685e22d8
parent 1e8c39e84306479cc42f5f573f1592caee736227
author 何建博 <hjb2722404@163.com> 1627961783 +0800
committer 何建博 <hjb2722404@163.com> 1627961783 +0800

fix confilict

$ git cat-file -t d3c4
commit

$ git cat-file -p 6860
040000 tree 89ff0fda87d52f3ee71393ebe95c694ab846d72d    fisrtdir

$ git cat-file -t 6860
tree

$ git cat-file -p 89ff
100644 blob 83baae61804e65cc73a7201a7252750c76066a30    test1.txt
100644 blob d6508a9fed612872652dff0b673c6d35e129ef73    test2.txt

$ git cat-file -t 89ff
tree



```

这里要特别注意的是，这次的`commit`对象中有两个`parent`，分别指向参与合并的两个分支。

现在，我们看下当期的分支与提交图谱：

![image-20210803133204928](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803133205.png)

这里我们注意到，合并后，`HEAD->master`指针只是简单的沿着最新提交前进了一步（实际上就是改了`refs/heads/master`里的提交HASH为合并后新生成的提交的SHA值），这种模式我们称为`fast-foward`模式，即快速前进。这个模式有个缺点：

当分支很多，并且分支之间的各种合并操作很多时，整个提交图谱会显得很凌乱。

我们先使用`git log --graph`命令看下当前图谱：

```bash
$ git log --graph
*   commit d3c4a568d736006aa9f61d9232d4841d4f378da9
|\  Merge: 06865bd 1e8c39e
| | Author: 何建博 <hjb2722404@163.com>
| | Date:   Tue Aug 3 11:36:23 2021 +0800
| |
| |     fix confilict
| |
| * commit 1e8c39e84306479cc42f5f573f1592caee736227
| | Author: 何建博 <hjb2722404@163.com>
| | Date:   Mon Aug 2 16:28:46 2021 +0800
| |
| |     v2
| |
| * commit 83aa5d482b04290a9c47b74957bc39de5d099076
| | Author: 何建博 <hjb2722404@163.com>
| | Date:   Mon Aug 2 15:48:19 2021 +0800
| |
| |     v2
| |
* | commit 06865bd463c3f764c8acdccdb2e77305685e22d8
|/  Author: 何建博 <hjb2722404@163.com>
|   Date:   Tue Aug 3 10:05:19 2021 +0800
|
|       v2 in master
|
* commit af155da98dafa516a4712a606e2cfd53c7499012
| Author: 何建博 <hjb2722404@163.com>
| Date:   Mon Aug 2 14:26:03 2021 +0800
|
|     re add test2
|
* commit 5c617fe1069b4d60ce472e0209b7648be7bc7eee
| Author: 何建博 <hjb2722404@163.com>
| Date:   Mon Aug 2 14:04:33 2021 +0800

```

上面的图谱中有两根竖直的虚线，分别代表两个分支`master`和`dev`，每个`commit`前都有一个`*`号，`*`号落在哪根线上，就代表那次提交是在哪个分支上进行的，比如上图中的两个`v2`提交前面的`*` 号都在第二根线上，说明他们是在`dev`分支上进行的。

下面，我们尝试一下非快速前进模式。

还是先切换到`dev`分支，增加一个`test3.txt`，写入一些内容并提交：

```bash
$ git checkout dev
Switched to branch 'dev'

$ echo 'test3 version 1' >> test3.txt

$ git add .
warning: LF will be replaced by CRLF in fisrtdir/test3.txt.
The file will have its original line endings in your working directory

$ git commit -m "init test3"
[dev b741c35] init test3
 1 file changed, 1 insertion(+)
 create mode 100644 fisrtdir/test3.txt

```

此时的提交图谱变为：

![image-20210803135944695](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803135944.png)



然后我们切回`master`分支，新建`test4.txt`，输入一些内容并提交：

```bash
$ git checkout -
Switched to branch 'master'

$ echo 'test4 version 1' >> test4.txt

$ git add .
warning: LF will be replaced by CRLF in fisrtdir/test4.txt.
The file will have its original line endings in your working directory

$ git commit -m "test4 init"
[master f326976] test4 init
 1 file changed, 1 insertion(+)
 create mode 100644 fisrtdir/test4.txt


```

> 这里，我使用了`git checkout -` ,这个命令代表【回到切换到当前分支之前的那个分支】

现在，提交图谱更新如下

![image-20210803140525139](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803140525.png)

然后，我们用非快速进行方式（加`--no-ff`参数）进行分支合并，还是将`dev`分支合并到`master`分支：

```bash
$ git merge --no-ff dev
```

```bash
Merge branch 'dev'
# Please enter a commit message to explain why this merge is necessary,
# especially if it merges an updated upstream into a topic branch.
#
# Lines starting with '#' will be ignored, and an empty message aborts
# the commit.
```

终端中会打开默认的编辑器（VIM），提示我们输入一个提交信息，默认为`Merge branch 'dev'`

我们直接采用默认值，按`:wq`保存：

```bash
$ git merge --no-ff dev
Merge made by the 'recursive' strategy.
 fisrtdir/test3.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 fisrtdir/test3.txt

```

这里提示我们，使用了`recursive`递归策略来进行了合并。

这里有必要简单介绍一下Git进行合并时的两种策略[^5]：

> * resolve: 仅仅使用三路合并算法合并两个分支的顶部节点（例如当前分支和你拉取下来的另一个分支）。这种合并策略遵循三路合并算法，由两个分支的 HEAD 节点以及共同子节点进行三路合并
> * recursive: 仅仅使用三路合并算法合并两个分支。和 resolve 不同的是，在交叉合并的情况时，这种合并方式是递归调用的，从共同祖先节点之后两个分支的不同节点开始递归调用三路合并算法进行合并，如果产生冲突，那么该文件不再继续合并，直接抛出冲突；其他未产生冲突的文件将一直执行到顶部节点。额外地，这种方式也能够检测并处理涉及修改文件名的操作。这是 git 合并和拉取代码的默认合并操作

不同于前一次合并，这里并没有返回合并后的提交HASH，但我们可以通过仓库信息看到：

![image-20210803142712135](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803142712.png)

注意我们上次手动解决冲突后的合并记录信息和本次没有冲突自动合并后记录信息的差异。

我们根据这个新的提交HASH一路追踪，得到了当前的提交图谱：

![image-20210803143027704](C:\Users\trs\AppData\Roaming\Typora\typora-user-images\image-20210803143027704.png)

我们再用`git log`看下分支图谱

```bash
$ git log --graph
*   commit 2c91821b0ae94199eb2151e0a8aa0932b5b6221c (HEAD -> master)
|\  Merge: f326976 b741c35
| | Author: 何建博 <hjb2722404@163.com>
| | Date:   Tue Aug 3 14:15:43 2021 +0800
| |
| |     Merge branch 'dev'
| |
| * commit b741c3531fd194361e8498d3496adbd26c032543 (dev)
| | Author: 何建博 <hjb2722404@163.com>
| | Date:   Tue Aug 3 13:55:35 2021 +0800
| |
| |     init test3
| |
* | commit f326976f955c910518846b5b910b2fd248084109
| | Author: 何建博 <hjb2722404@163.com>
| | Date:   Tue Aug 3 14:01:40 2021 +0800
| |
| |     test4 init
| |
* |   commit d3c4a568d736006aa9f61d9232d4841d4f378da9
|\ \  Merge: 06865bd 1e8c39e
| |/  Author: 何建博 <hjb2722404@163.com>
| |   Date:   Tue Aug 3 11:36:23 2021 +0800
| |
| |       fix confilict
| * commit 1e8c39e84306479cc42f5f573f1592caee736227
| | Author: 何建博 <hjb2722404@163.com>
| | Date:   Mon Aug 2 16:28:46 2021 +0800
| |
| |     v2
| |
| * commit 83aa5d482b04290a9c47b74957bc39de5d099076
| | Author: 何建博 <hjb2722404@163.com>
| | Date:   Mon Aug 2 15:48:19 2021 +0800
| |
| |     v2

```

这时还不出两次合并有任何不同，因为第一次合并有冲突，所以我们手动进行了一次提交，导致两次看起来似乎一样。现在，我们再用一次快速前进模式（`git merge`默认使用此方式）来进行操作。

```bash
// 切换到dev分支
$ git checkout dev
Switched to branch 'dev'
// 修改test3.txt的内容
$ echo 'test3 version 2' >> test3.txt
// 添加到暂存区
$ git add .
warning: LF will be replaced by CRLF in fisrtdir/test3.txt.
The file will have its original line endings in your working directory
// 提交
$ git commit -m "test3 v2"
[dev e11c5ac] test3 v2
 1 file changed, 1 insertion(+)

// 切换回master分支
$ git checkout -
Switched to branch 'master'
// 修改test4.txt内容
$ echo 'test4 version 2' >> test4.txt
// 添加到暂存区
$ git add .
warning: LF will be replaced by CRLF in fisrtdir/test4.txt.
The file will have its original line endings in your working directory
// 提交
$ git commit -m "test4 v2"
[master 4cb949e] test4 v2
 1 file changed, 1 insertion(+)
```

截止目前，提交图谱如下：

![image-20210803144646562](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803145950.png)

接下来，进行快速前进模式合并：

```bash
$ git merge dev
```

```bash
Merge branch 'master' to 'dev'
# Please enter a commit message to explain why this merge is necessary,
# especially if it merges an updated upstream into a topic branch.
#
# Lines starting with '#' will be ignored, and an empty message aborts
# the commit.
```

又让我们输入一次提交信息，我们输入`Merge branch master to dev`，然后按`:wq`保存

```bash
$ git merge dev
Merge made by the 'recursive' strategy.
 fisrtdir/test3.txt | 1 +
 1 file changed, 1 insertion(+)
```

此时查看提交图谱，发现并没有什么不同。

究竟为什么采用两种模式执行的结果是一样的呢？

原因是：**结论15：ff 模式只有在顺着一个分支走下去可以到达另一个分支时才会选用**

由于我们的`dev`分支缺少了`master`分支上的几次提交（没有`test4.txt`相关的所有提交），所以顺着其中一个并不能到达另一个分支。所以默认的`git merge`命令一直是采用的`--no-ff`模式。

现在，我们从`master`分支重新拉取一个`dev2`分支，然后在`dev2`分支上做两次提交，再回到`master`，直接合并`dev2`:

```bash
$ git checkout -b dev2
Switched to a new branch 'dev2'

$ echo 'test 5 version 1' >> test5.txt
$ git add .
warning: LF will be replaced by CRLF in fisrtdir/test5.txt.
The file will have its original line endings in your working directory
$ git commit -m "test5 v1"
[dev2 5513a65] test5 v1
 1 file changed, 1 insertion(+)
 create mode 100644 fisrtdir/test5.txt

$ echo 'test 5 version 2' >> test5.txt
$ git add .
warning: LF will be replaced by CRLF in fisrtdir/test5.txt.
The file will have its original line endings in your working directory
$ git commit -m 'test5 v2'
[dev2 fd3da8e] test5 v2
 1 file changed, 1 insertion(+)
 
$ git checkout -
Switched to branch 'master'
$ git merge dev2 --ff
Updating 4cb949e..fd3da8e
Fast-forward
 fisrtdir/test5.txt | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 fisrtdir/test5.txt
```

> 注意，这里第一行使用了`git checkout -b dev2`来新建并切换到了`dev2`分支，它相当于下面的步骤：
>
> 1. `git branch dev2`
> 2. `git checkout dev2`

此时，查看仓库信息：

![image-20210803151935746](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803151936.png)

根据这些信息，我们得到了最新的提交图谱：

![image-20210803152209857](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803152210.png)

这次，我们终于看到了快速前进与非快速前进的差别：

* 非快速前进：在合入分支上新建一个提交，该提交中包含并合并了两个分支所指向提交的内容
* 快速前进： 直接将合入分支的指针指向被合入分支所指向的提交上。

我们再看分支提交图谱：

```bash
$ git log --graph
* commit fd3da8e44fb01aa14bf75a92d3947047d5d6c300 (HEAD -> master, dev2)
| Author: 何建博 <hjb2722404@163.com>
| Date:   Tue Aug 3 15:13:44 2021 +0800
|
|     test5 v2
|
* commit 5513a65a509d8b9cd5dbdd9543bf76c32785c529
| Author: 何建博 <hjb2722404@163.com>
| Date:   Tue Aug 3 15:13:13 2021 +0800
|
|     test5 v1
|
* commit 4cb949eda83a7cd44d838cb8f0adbbc7814db6dc
| Author: 何建博 <hjb2722404@163.com>
| Date:   Tue Aug 3 14:40:41 2021 +0800
|
|     test4 v2
|
*   commit 2c91821b0ae94199eb2151e0a8aa0932b5b6221c
|\  Merge: f326976 b741c35
| | Author: 何建博 <hjb2722404@163.com>
| | Date:   Tue Aug 3 14:15:43 2021 +0800
| |
| |     Merge branch 'dev'
| |
| * commit b741c3531fd194361e8498d3496adbd26c032543
| | Author: 何建博 <hjb2722404@163.com>
| | Date:   Tue Aug 3 13:55:35 2021 +0800
| |
| |     init test3
| |
* | commit f326976f955c910518846b5b910b2fd248084109
| | Author: 何建博 <hjb2722404@163.com>
| | Date:   Tue Aug 3 14:01:40 2021 +0800
| |
| |     test4 init

```

可以看到，`test5 v1` 和 `test5 v2`两次提交明明是在`dev2`分支上进行的，但这里却丝毫没有体现，甚至根本没有代表`dev2`分支的历史线。

所以，我们始终建议，任何时候，在`git merge`时都加上`--no-ff`模式，以便回顾提交历史时能够清晰地放映分支关系。

除了`git merge`命令外，Git里还有另外一种合并分支的方式`git rebase`(衍合)，我们来看一下。

在进行下面的操作前，我们先要介绍一个命令—— `git  gc`。

由于之前我们的诸多操作，现在`objects`里已经存在很多对象了：

```bash
$ ll
total 0
drwxr-xr-x 1 trs 197121 0 Aug  3 10:05 06/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:54 0c/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:56 0e/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:53 0f/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:53 10/
drwxr-xr-x 1 trs 197121 0 Aug  3 15:13 14/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:57 17/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:57 1c/
drwxr-xr-x 1 trs 197121 0 Aug  2 16:28 1e/
drwxr-xr-x 1 trs 197121 0 Aug  3 13:55 1f/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:54 24/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:17 2c/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:39 2d/
drwxr-xr-x 1 trs 197121 0 Aug  3 15:13 31/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:54 38/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:57 39/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:54 41/
drwxr-xr-x 1 trs 197121 0 Aug  2 14:26 49/
drwxr-xr-x 1 trs 197121 0 Aug  2 14:04 4b/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:40 4c/
drwxr-xr-x 1 trs 197121 0 Aug  3 15:13 52/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:54 53/
drwxr-xr-x 1 trs 197121 0 Aug  3 15:13 55/
drwxr-xr-x 1 trs 197121 0 Aug  2 14:04 5c/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:35 60/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:54 64/
drwxr-xr-x 1 trs 197121 0 Aug  2 15:48 65/
drwxr-xr-x 1 trs 197121 0 Aug  3 11:36 68/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:48 6f/
drwxr-xr-x 1 trs 197121 0 Aug  3 15:13 70/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:01 74/
drwxr-xr-x 1 trs 197121 0 Aug  3 15:13 75/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:50 7a/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 7c/
drwxr-xr-x 1 trs 197121 0 Aug  3 10:05 80/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:54 81/
drwxr-xr-x 1 trs 197121 0 Jul 30 14:10 82/
drwxr-xr-x 1 trs 197121 0 Aug  2 15:48 83/
drwxr-xr-x 1 trs 197121 0 Jul 30 16:11 87/
drwxr-xr-x 1 trs 197121 0 Aug  3 11:36 89/
drwxr-xr-x 1 trs 197121 0 Aug  3 10:37 8b/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 8d/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:53 8e/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:56 8f/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:40 91/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 92/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:48 97/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:39 98/
drwxr-xr-x 1 trs 197121 0 Aug  2 15:48 9c/
drwxr-xr-x 1 trs 197121 0 Aug  2 14:26 af/
drwxr-xr-x 1 trs 197121 0 Aug  2 14:26 b2/
drwxr-xr-x 1 trs 197121 0 Aug  3 13:55 b7/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:40 b8/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:01 ba/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:56 bd/
drwxr-xr-x 1 trs 197121 0 Jul 29 16:45 c1/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:15 c3/
drwxr-xr-x 1 trs 197121 0 Aug  3 10:05 c4/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:53 c9/
drwxr-xr-x 1 trs 197121 0 Aug  3 11:36 d3/
drwxr-xr-x 1 trs 197121 0 Aug  2 11:23 d4/
drwxr-xr-x 1 trs 197121 0 Aug  3 10:05 d6/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:40 dd/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:39 e1/
drwxr-xr-x 1 trs 197121 0 Aug  3 13:55 e4/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Jul 30 11:10 ea/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:15 ef/
drwxr-xr-x 1 trs 197121 0 Aug  3 14:39 f3/
drwxr-xr-x 1 trs 197121 0 Jul 30 16:32 f4/
drwxr-xr-x 1 trs 197121 0 Aug  3 15:13 f7/
drwxr-xr-x 1 trs 197121 0 Aug  3 15:11 f9/
drwxr-xr-x 1 trs 197121 0 Aug  3 15:13 fd/
drwxr-xr-x 1 trs 197121 0 Jul 29 10:50 info/
drwxr-xr-x 1 trs 197121 0 Jul 29 10:50 pack/

```

实际上，这些对象都是松散对象格式，就拿`blob`对象来说，它存储的是实际上我们的文件的内容，所以它的大小和源文件是一样的，我们从暂存区找个文件验证一下：

```bash
$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt
100644 d6508a9fed612872652dff0b673c6d35e129ef73 0       test2.txt
100644 1728e5ee30cee9e075deb93f91d003efc08c153e 0       test3.txt
100644 91b749ddf2b1579a482306ed42a5a4636a927d6b 0       test4.txt
100644 31715cd8e1d6bd99296db7f2b98ec8243d873c0c 0       test5.txt
```

我们以`test2.txt`为例，先看看它的源文件有多大：

```bash
$ cat test2.txt
version 1
version 2 master

$ ls -l test2.txt
-rw-r--r-- 1 trs 197121 29 Aug  3 15:10 test2.txt

```

它的大小是`197121`字节

再看它对应的`blob`对象大小：

```bash
// 在objects目录下：
$ cd d6
$ ls -l 508a9fed612872652dff0b673c6d35e129ef73
-r--r--r-- 1 trs 197121 36 Aug  3 14:54 508a9fed612872652dff0b673c6d35e129ef73

```

与源文件大小是一样的。

那么，这就带来一个问题，这么多对象，而且大小还和源文件一样，在用于向远程仓库推送时，岂不是会很慢？

完全不会，因为在推送前，Git会调用`git gc`命令，将这些松散对象压缩打包成一个`pack`文件，由于经过了压缩（实际上就是只存储同一个文件不同版本之间的差异来缩小体积），网络传输速度大大提高。

我们试一下：

```bash
$ git gc$ git gc
Enumerating objects: 80, done.
Counting objects: 100% (80/80), done.
Delta compression using up to 8 threads
Compressing objects: 100% (44/44), done.
Writing objects: 100% (80/80), done.
Total 80 (delta 17), reused 0 (delta 0)

```

输出信息告诉我们，总共有80个对象，然后可以使用差异内容来压缩的有44个，最后有17个差异内容。

再来看看仓库信息发生了哪些变化：



![image-20210803173648323](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803173648.png)

* 首先，`refs/heads`中的分支信息没有了
* `info` 目录下多了一个`refs`文件，记录了分支的引用信息
* `objects`下的对象只剩下两个了，并且
  * `info`目录下多了一个`packs`文件，记录了打包文件的文件名
  * `pack`目录下多了两个文件：
    * `.idx`的文件，是一个索引文件
    * `.pack`，打包文件，实际数据存储的地方
* 根目录多了一个`packed-refs`文件，里面记录了各个分支对应的提交对象信息。

那么，还有两个对象没有被打包，我们看下它们的内容：

```bash
$ git cat-file -p 8b39
version 1
<<<<<<< HEAD
version 2 master
=======
version 2
>>>>>>> dev

$ git cat-file -p e69d
// 没有输出
```

如果还记得我们之前的操作的话，你应该知道，第一个对象是我们第一次合并时，生成的冲突内容对象，而第二个对象，是我们最开始在根目录添加的那个没有任何内容的后来又删除的`test1.txt`对应的`blob`对象，由于在整个项目的分支-提交-树-blob链条中，已经没用任何地方再用到他们，所以它们成为了无用对象，在打包时被排除了。



好的，经过打包操作，我们把`objects`目录基本算清理干净了，这方便我们看接下来执行`git rebase` 操作时它所发生的变化。

现在，我们仍旧出于`master`分支上，我们需要切换到`dev2`分支上。

我们的目标是从`dev2`分支切换出一个新的分支`dev3`，在`dev3`上做四次提交，并且把`dev3`上的提交合并到`dev2`上面。

```bash
$ git status
On branch master
nothing to commit, working tree clean

$ git checkout dev2
Switched to branch 'dev2'

$ git checkout -b dev3
Switched to a new branch 'dev3'

$ echo '1' >> dev3.txt
$ git add .
$ git commit -m "dev3 v1"
[dev3 fd4fa54] dev3 v1
 1 file changed, 1 insertion(+)
 create mode 100644 fisrtdir/dev3.txt

$ echo '2' >> dev3.txt
$ git add .
$ git commit -m "dev3 v2"
[dev3 24e0ca3] dev3 v2
 1 file changed, 1 insertion(+)

$ echo '3' >> dev3.txt
$ git add .
$ git commit -m "dev3 v3"
[dev3 8b92a39] dev3 v3
 1 file changed, 1 insertion(+)

$ echo '4' >> dev3.txt
$ git add .
$ git commit -m "dev3 v4"
[dev3 fb02e99] dev3 v4
 1 file changed, 1 insertion(+)
 
 $ git checkout dev2
Switched to branch 'dev2'

$ git branch dev4

```

经过以上操作，最后，我们切回到了`dev2`分支，并且从它新建了`dev4`分支，用于后续的操作。

在进行合并操作前，我们先看下当前状态：

工作区：

![image-20210803181029359](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803181029.png)

暂存区：

```bash
$ git ls-files -s
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt
100644 d6508a9fed612872652dff0b673c6d35e129ef73 0       test2.txt
100644 1728e5ee30cee9e075deb93f91d003efc08c153e 0       test3.txt
100644 91b749ddf2b1579a482306ed42a5a4636a927d6b 0       test4.txt
100644 31715cd8e1d6bd99296db7f2b98ec8243d873c0c 0       test5.txt
```

当前分支(`dev2`)提交历史，我限定了最近两次提交：

```bash
$ git log -2
commit fd3da8e44fb01aa14bf75a92d3947047d5d6c300 (HEAD -> dev2, master, dev4)
Author: 何建博 <hjb2722404@163.com>
Date:   Tue Aug 3 15:13:44 2021 +0800

    test5 v2

commit 5513a65a509d8b9cd5dbdd9543bf76c32785c529
Author: 何建博 <hjb2722404@163.com>
Date:   Tue Aug 3 15:13:13 2021 +0800

    test5 v1

```

看下仓库信息：

![image-20210803181709006](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803181709.png)



依据以上信息，我们先整理下提交图谱：

![image-20210803182120278](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803182120.png)





现在，我们使用`git rebase`来将`dev3`的四次提交合并入`dev2`

```bash
$ git rebase dev3
First, rewinding head to replay your work on top of it...
Fast-forwarded dev2 to dev3.
```

命令输出信息提示我们，重新倒带头部，重新应用到当前工作分支的顶部（所指向的提交），并且使用的是【快速前进】模式。

现在再看看状态:

工作区：成功合并到了`dev3`上的内容

![image-20210803182745238](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803182745.png)

`objects`目录没有变化

看看仓库信息：

![image-20210803183257413](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803183257.png)

这里，我们可以出`git rebase`与`git merge`操作后操作记录的不同，我们再来看看`master`之前快速前进模式合并后的记录：

![image-20210803183635605](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803183635.png)

其次，`dev2`的引用的提交对象直接变成了与`dev3`一样的。

根据以上信息，我们得到了提交图谱

![image-20210803183832296](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210803183832.png)

看起来，`git rebase` 与 `git merge`的快速前进模式似乎是一样的效果。

**结论16：实际上，当我们从一个源分支（如`dev2`）上切出一个新分支（如`dev3`），然后在新分支上进行若干次提交而源分支不做任何提交后，此时将新分支衍合（即`rebase`）到源分支，其效果是和`git merge`的快速前进模式（`--ff`）是一样的**。

现在，我们再次进行打包操作，清理`objects`目录：

```bash
$ git gc
Enumerating objects: 96, done.
Counting objects: 100% (96/96), done.
Delta compression using up to 8 threads
Compressing objects: 100% (35/35), done.
Writing objects: 100% (96/96), done.
Total 96 (delta 21), reused 79 (delta 17)

// 在objects目录
$ ll
total 4
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 8b/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 info/
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 pack/

$ ll pack
total 12
-r--r--r-- 1 trs 197121 3760 Aug  4 09:25 pack-0752eca71323f6ee23f45c3a663c671d312e2e5f.idx
-r--r--r-- 1 trs 197121 7229 Aug  4 09:25 pack-0752eca71323f6ee23f45c3a663c671d312e2e5f.pack


```

这里注意看输出的提示，当我们再次进行打包操作时，依旧是要算上之前打包的所有内容的，并且会生成一个新的包替换之前的包。

之前的操作，我们都是在`fisrtdir`目录中进行的操作，以下操作，我们在根目录进行：

然后我们切换到`dev4`，并从`dev4`上新建`dev5`与`dev6`分支，并且分别在`dev4`与`dev5`分支上j进行两次提交，然后再将`dev5`衍合（`rebase`）到`dev4`分支上。

```bash
$ git checkout dev4
Switched to branch 'dev4'

$ git branch dev5
$ git branch dev6

$ echo '1' >> dev4.txt
$ git add .
$ git commit -m "dev4 v1"
[dev4 5dd51dd] dev4 v1
 1 file changed, 1 insertion(+)
 create mode 100644 dev4.txt
 
$ echo '2' >> dev4.txt
$ git add .
$ git commit -m "dev4 v2"
[dev4 0f43486] dev4 v2
 1 file changed, 1 insertion(+)
 
 $ git checkout dev5
Switched to branch 'dev5'
$ echo '1' >> 'dev5.txt'
$ git add .
$ git commit -m "dev5 v1"
[dev5 55ef176] dev5 v1
 1 file changed, 1 insertion(+)
 create mode 100644 dev5.txt
 
$ echo '2' >> 'dev5.txt'
$ git add .
$ git commit -m "dev5 v2"
[dev5 4e0bdd4] dev5 v2
 1 file changed, 1 insertion(+)

$ git checkout dev4
Switched to branch 'dev4'
```

看看当前仓库状态：

![image-20210804105424172](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804105431.png)

根据以上易信息，我们整理出当前的分支提交图谱：

![image-20210804105851234](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804105851.png)

现在，我们再次执行`git gc`对当前对象打包：

```bash
$ git gc
Enumerating objects: 104, done.
Counting objects: 100% (104/104), done.
Delta compression using up to 8 threads
Compressing objects: 100% (39/39), done.
Writing objects: 100% (104/104), done.
Total 104 (delta 23), reused 95 (delta 21)

```

看下当前`objects目录`：

```bash
$ ll
total 4
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 8b/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Aug  4 10:59 info/
drwxr-xr-x 1 trs 197121 0 Aug  4 10:59 pack/

```

然后执行衍合操作：

```bash
$ git rebase dev5
First, rewinding head to replay your work on top of it...
Applying: dev4 v1
Applying: dev4 v2

```

这里提示，应用了`dev3 v1`和`dev5`两个版本，这里我们先不说代表什么意思，先看看`objects`目录：

```bash
$ ll
total 4
drwxr-xr-x 1 trs 197121 0 Aug  4 11:01 7c/ 
drwxr-xr-x 1 trs 197121 0 Aug  4 11:01 84/
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 8b/
drwxr-xr-x 1 trs 197121 0 Aug  4 11:01 a8/
drwxr-xr-x 1 trs 197121 0 Aug  4 11:01 d3/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Aug  4 10:59 info/
drwxr-xr-x 1 trs 197121 0 Aug  4 10:59 pack/

```

对比上面可以看出，多了4个对象，我们看下它们的内容：

```bash
$ git cat-file -p 7c78
tree 84b5c0989343771fba3731f5bcd823f37c90e9ed
parent a8f986aafd750b239a75edef98b225a0ce4ee978
author 何建博 <hjb2722404@163.com> 1628041072 +0800
committer 何建博 <hjb2722404@163.com> 1628046065 +0800

dev4 v2

$ git cat-file -p 84b5
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev4.txt
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev5.txt
040000 tree 75242e9fdbeba1b611a896ee69aae732962b8e94    fisrtdir

$ git cat-file -p a8f9
tree d3258920a8783ca1594dac226a8c856f44e2efe0
parent 4e0bdd4a14ca9b38fa0468d41ce813ff5b2ca975
author 何建博 <hjb2722404@163.com> 1628041048 +0800
committer 何建博 <hjb2722404@163.com> 1628046065 +0800

dev4 v1


$ git cat-file -p d325
100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d    dev4.txt
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev5.txt
040000 tree 75242e9fdbeba1b611a896ee69aae732962b8e94    fisrtdir


```



是两个树对象和两个提交对象，两个树对象我们知道，是因为我们切换回了根目录进行内容更改，所以目录结构变了，新生成了两个树对象。那么，为什么多了两个提交对象呢？

从这两个提交对象的提交信息来看，是复制了`dev4 v1`（提交HASH为`5dd51dd`）和`dev4 v2` (提交Hash为`0f43486`)两个提交，但这个新复制的`dev4 v1`的父提交却又是`dev5 v2`（`4e0bdd4`）.

再看看仓库信息：

![image-20210804111712753](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804111713.png)

根据以上信息，我们得到当前分支提交图谱：

![image-20210804112215781](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804112215.png)

所以，

**结论17： `git rebase`操作实际上是——**

**1. 从当前分支上，找到与目标分支的【共同祖先提交】之后的那次提交**

**2. 从那次提交开始，把之后的所有提交挨个提取出来，**

**3. 在目标分支的最新提交基础上将提取出来的提交挨个再重做一次，**

**4. 将当前分支指向目标分支重做后的最后一个提交。**

这也就是为什么上一次衍合操作看起来和`git merge`的快速前进模式看起来一样的原因：因为当前分支没有做任何提交，所以直接执行了第4步。

我们看下当前分支`dev4`的提交历史：

```bash
$ git log --graph
* commit 7c7821041e576bf0cd410c74ee52477e67ba4a1b (HEAD -> dev4)
| Author: 何建博 <hjb2722404@163.com>
| Date:   Wed Aug 4 09:37:52 2021 +0800
|
|     dev4 v2
|
* commit a8f986aafd750b239a75edef98b225a0ce4ee978
| Author: 何建博 <hjb2722404@163.com>
| Date:   Wed Aug 4 09:37:28 2021 +0800
|
|     dev4 v1
|
* commit 4e0bdd4a14ca9b38fa0468d41ce813ff5b2ca975 (dev5)
| Author: 何建博 <hjb2722404@163.com>
| Date:   Wed Aug 4 10:47:37 2021 +0800
|
|     dev5 v2
|
* commit 55ef176872403d64d6e29816277d9431e1d2820a
| Author: 何建博 <hjb2722404@163.com>
| Date:   Wed Aug 4 10:46:57 2021 +0800
|
|     dev5 v1
|
* commit fd3da8e44fb01aa14bf75a92d3947047d5d6c300 (master, dev6)
| Author: 何建博 <hjb2722404@163.com>
| Date:   Tue Aug 3 15:13:44 2021 +0800
|
|     test5 v2
|
* commit 5513a65a509d8b9cd5dbdd9543bf76c32785c529
| Author: 何建博 <hjb2722404@163.com>
| Date:   Tue Aug 3 15:13:13 2021 +0800
|
|     test5 v1
|

```

从这里我们可以看出这个操作的两个问题来：

1. 与`git merge`的快速前进模式一样，丢失了分支历史线，只剩了一根单一的当前分支的历史线。
2. 时间顺序错乱。我们在`dev 4`分支上提交的`dev4 v1`和`dev4 v2`的时间是早于`dev5 v1`和`dev5 v2`的，但是这里看，他们却在`dev5 v1`和`dev5 v2`的上面。

所以，官方建议是：**结论18：可以在自己的分支之间进行衍合（`rebase`）操作，但不要在自己的分支与其他人的分支（包括所有远程分支）之间进行衍合操作，因为会造成分支线和时间线混乱**。

#### 14 分支片段复制

有时候，我们需要将某个分支上的中间几次提交合并到另一个分支上，这种操作我们暂且称作【分支片段复制】，那么该如何操作呢？

有两个命令可以做到：

* `git rebase`，对，又是它，只不过这次传递给它的参数不再是分支名，而是提交的SHA值。
* `git cherry-pick`，给定一个或多个现有提交，应用每个提交的更改，为每个提交记录一个新提交。这个命令要求工作目录是干净的。

我们先看用`git rebase`是怎么操作的。

我们的目标是，在`dev6`上做四次提交，然后将前两次提交合并入`dev4`分支。

我们先看下当前的提交图谱：

![image-20210804140111738](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804140111.png)

当前`dev6`指向`fd3da8e`提交，而`dev4`则指向`7c78210`提交。

我们按照目标进行操作：

```bash
$ git checkout dev6
Switched to branch 'dev6'

$ echo '1' >> dev6.txt
$ git add .
$ git commit -m "dev6 v1"
[dev6 09af99d] dev6 v1
 1 file changed, 1 insertion(+)
 create mode 100644 dev6.txt

$ echo '2' >> dev6.txt
$ git add .
$ git commit -m "dev6 v2"
[dev6 9061323] dev6 v2
 1 file changed, 1 insertion(+)

$ echo '3' >> dev6.txt
$ git add .
$ git commit -m "dev6 v3"
[dev6 1a324be] dev6 v3
 1 file changed, 1 insertion(+)

$ echo '4' >> dev6.txt
$ git add .
$ git commit -m "dev6 v4"
[dev6 846c2c3] dev6 v4
 1 file changed, 1 insertion(+)

$ git checkout -
Switched to branch 'dev4'

```

看看现在的仓库信息：

![image-20210804141647077](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804141647.png)

根据以上信息，得到现在的分支提交关系图谱变为：

![image-20210804142114255](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804142114.png)

照例，我们执行`git gc`打包`objects`里的对象：

```bash
$git gc

// objects目录
$ ll
total 4
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 8b/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Aug  4 14:22 info/
drwxr-xr-x 1 trs 197121 0 Aug  4 14:22 pack/

```

接下来，我们使用`git rebase`操作将`dev6 v1`(提交HASH`09af99d`)、`dev6 v2`(提交HASH`9061323`)两次提交合并到`dev4`分支上。

```bash
$ git checkout dev6
Switched to branch 'dev6'

$ git rebase 09af99d 9061323 --onto dev4
First, rewinding head to replay your work on top of it...
Applying: dev6 v1
Applying: dev6 v2

```

首先来说明下我们的操作：

1. 使用`rebase`复制某个分支（这里是`dev6`）的某几个连续提交到另一个分支(这里是`dev4`)上，需要在被复制的分支（`dev6`）上操作。所以，我们先切换到了`dev6`分支上。
2. 使用`git rebase startpoint  endpoint --onto targetBranchName`命令来完成复制粘贴的操作，其中：
   1. `startpoint endpoint`，要复制的多个提交的第一个和最后一个提交的HASH，这两个提交之间的提交都将被复制
   2. `--onto` 指定将提交应用到哪里
   3. `targetBranchName`，指定目标分支，即这几个提交要被复制到哪个分支上。

先来看看主要区域的变化：

工作目录：

![image-20210804163250417](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804163250.png)

`objects`目录：

```bash
drwxr-xr-x 1 trs 197121 0 Aug  4 14:32 07/
drwxr-xr-x 1 trs 197121 0 Aug  4 14:32 55/
drwxr-xr-x 1 trs 197121 0 Aug  4 14:32 81/
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 8b/
drwxr-xr-x 1 trs 197121 0 Aug  4 14:32 db/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Aug  4 14:22 info/
drwxr-xr-x 1 trs 197121 0 Aug  4 14:22 pack/

```

生成了四个对象，我们分别来看一下它们的内容：

```bash
$ git cat-file -p 07c7
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev4.txt
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev5.txt
100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d    dev6.txt
040000 tree 75242e9fdbeba1b611a896ee69aae732962b8e94    fisrtdir

$ git cat-file -p 55a2
tree 81ac24f940adb7fac88ffe83bc7e020290584428
parent db24271a59244dacc57976eac93604aecc2fa48c
author 何建博 <hjb2722404@163.com> 1628057385 +0800
committer 何建博 <hjb2722404@163.com> 1628058745 +0800

dev6 v2

$ git cat-file -p 81ac
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev4.txt
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev5.txt
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev6.txt
040000 tree 75242e9fdbeba1b611a896ee69aae732962b8e94    fisrtdir

$ git cat-file -p db24
tree 07c7729b5cdee28aaea6114e29097578eb6928d4
parent 7c7821041e576bf0cd410c74ee52477e67ba4a1b
author 何建博 <hjb2722404@163.com> 1628057355 +0800
committer 何建博 <hjb2722404@163.com> 1628058745 +0800

dev6 v1

```

与上文的衍合操作一样，生成了两次提交和两个树对象。

再看看仓库信息：

![image-20210804145113890](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804145114.png)

神奇的是，其它都没有变，只有`HEAD`变了，之前的`HEAD`一直都存放的是一个指向分支引用的地址，但是这次变成了新生成的提交对象`dev6 v2`

根据以上信息，我们更新提交关系图：

![image-20210804150341530](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804150341.png)



我们看到，在`dev4`分支上，又多出了两个提交，正是我们从`dev6`复制出的两次提交。

但此时出现了新情况，此时`dev4`仍旧指向`7c78210`提交，而`HEAD`却指向了最新的`55a2eba`提交上，我们把这种情况称为游离`HEAD`，专门指`HEAD`指向与分支指向不同的情况。

此时，我们需要回到`dev4`分支所指向的提交，并且使用`git reset`命令强制让`dev4`指向当前`HEAD`所在提交：

```bash
$git checkout dev4
Warning: you are leaving 2 commits behind, not connected to
any of your branches:

  55a2eba dev6 v2
  db24271 dev6 v1

If you want to keep them by creating a new branch, this may be a good time
to do so with:

 git branch <new-branch-name> 55a2eba

Switched to branch 'dev4'

$ git reset --hard 55a2eba
HEAD is now at 55a2eba dev6 v2

```

注意，当`HEAD`处于游离状态时，我们切换到分支时，会给出提示。这里提示我们当前`dev4`分支所指向的提交比`HEAD`所指向的提交落后了两个提交，并给出了两个提交的信息和解决办法，它建议的解决办法是使用`git branch`命令从挡墙`HEAD`指向的提交处新建一个分支出来，我们不采用它的办法，而是直接`reset`当前分支指向。

现在再看状态：

![image-20210804151653872](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804151654.png)

![image-20210804154623507](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804154623.png)

再看下提交历史图谱：

```bash
$ git log --graph
* commit 55a2ebaacef7e18ff9a710359632ed90a924576d (HEAD -> dev4)
| Author: 何建博 <hjb2722404@163.com>
| Date:   Wed Aug 4 14:09:45 2021 +0800
|
|     dev6 v2
|
* commit db24271a59244dacc57976eac93604aecc2fa48c
| Author: 何建博 <hjb2722404@163.com>
| Date:   Wed Aug 4 14:09:15 2021 +0800
|
|     dev6 v1
|
* commit 7c7821041e576bf0cd410c74ee52477e67ba4a1b
| Author: 何建博 <hjb2722404@163.com>
| Date:   Wed Aug 4 09:37:52 2021 +0800
|
|     dev4 v2
|
* commit a8f986aafd750b239a75edef98b225a0ce4ee978
| Author: 何建博 <hjb2722404@163.com>
| Date:   Wed Aug 4 09:37:28 2021 +0800
|
|     dev4 v1
|
* commit 4e0bdd4a14ca9b38fa0468d41ce813ff5b2ca975
| Author: 何建博 <hjb2722404@163.com>
| Date:   Wed Aug 4 10:47:37 2021 +0800
|
|     dev5 v2
|
* commit 55ef176872403d64d6e29816277d9431e1d2820a
| Author: 何建博 <hjb2722404@163.com>
| Date:   Wed Aug 4 10:46:57 2021 +0800
|
|     dev5 v1

```

与衍合操作一样，提交区间的复制粘贴不显示分支信息，即从这个历史线看不出哪些提交是从哪个分支复制过来的



接下来，我们再使用`git cherry-pick`命令来将`dev6`的前两次提交复制到`dev5`分支上去。

注意，如上图，此时`dev5`分支指向的提交是`dev5 v2`(`4e0bdd4`).

与`git rebase`不同，`git cherry-pick`需要在目标分支上运行，比如我们要将`dev6`上的提交复制到`dev5`分支，那么我们需要在`dev5`上操作，而`git rebase`则是在`dev6`上操作：

我们当前就正处在`dev4`分支上，老规矩，先指向`git gc`，然后查看仓库状态：

```bash
$ git gc

```

```bash
// objects目录下：
$ ll
total 4
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 8b/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Aug  4 15:47 info/
drwxr-xr-x 1 trs 197121 0 Aug  4 15:47 pack/

```

![image-20210804155316430](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804155316.png)

然后切换到`dev5`分支，进行`cherry-pick`操作：

```bash
$ git checkout dev5 
Switched to branch 'dev5'  // 此时HEAD指向`dev5`

$ git cherry-pick 09af99d^..9061323
[dev5 96f758d] dev6 v1
 Date: Wed Aug 4 14:09:15 2021 +0800
 1 file changed, 1 insertion(+)
 create mode 100644 dev6.txt
[dev5 8dcd326] dev6 v2
 Date: Wed Aug 4 14:09:45 2021 +0800
 1 file changed, 1 insertion(+)

```

我们先解释下命令和输出：

1. 使用`git cherry-pick start..end`来将`start`与`end`两个提交之间的所有提交复制到本分支
2. `start..end` 是一个左开右闭的区间，意思是复制时将包含`end`而不包含`start`.
3. 所以我们使用`start^` 来将开始提交指定为`start`之前一个提交
4. 执行命令后，输出了我们复制的两个提交的相关信息，包括HASH、提交说明、源提交创建日期、提交中包含的变动数量等。

我们看下工作目录：

![image-20210804162231493](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804162231.png)

然后看下`objects`目录：

```bash
$ ll
total 4
drwxr-xr-x 1 trs 197121 0 Aug  4 16:15 64/
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 8b/
drwxr-xr-x 1 trs 197121 0 Aug  4 16:15 8d/
drwxr-xr-x 1 trs 197121 0 Aug  4 16:15 96/
drwxr-xr-x 1 trs 197121 0 Aug  4 16:15 c1/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Aug  4 15:47 info/
drwxr-xr-x 1 trs 197121 0 Aug  4 15:47 pack/

```

同样，也是生成了四个对象，不出意外，应该是两个树对象和两个提交对象：

```bash
$ git cat-file -p 8dcd
tree c1bc787666536cb9daafb6c32947ec19deb82afc
parent 96f758d85051aeb54c795ddb07b5d15cf7313a7a
author 何建博 <hjb2722404@163.com> 1628057385 +0800
committer 何建博 <hjb2722404@163.com> 1628064910 +0800

dev6 v2

$ git cat-file -p 6466
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev5.txt
100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d    dev6.txt
040000 tree 75242e9fdbeba1b611a896ee69aae732962b8e94    fisrtdir

$ git cat-file -p 96f7
tree 6466b593f32a0212d1c936c7f6e675f27a8ec78a
parent 4e0bdd4a14ca9b38fa0468d41ce813ff5b2ca975
author 何建博 <hjb2722404@163.com> 1628057355 +0800
committer 何建博 <hjb2722404@163.com> 1628064910 +0800

dev6 v1

$ git cat-file -p c1bc
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev5.txt
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev6.txt
040000 tree 75242e9fdbeba1b611a896ee69aae732962b8e94    fisrtdir


```

然后看仓库状态：

![image-20210804162811199](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804162811.png)

我们发现，`git cherry-pick`与`git rebase`不同，它会将复制过来的每次提交都生成一条操作记录。

此时，关系图谱变为:

![image-20210804163114878](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804163115.png)

看下提交历史图谱：

```bash
$ git log --graph
* commit 8dcd32635ea5a0450ade6a3e2f964f8b8dd064b0 (HEAD -> dev5)
| Author: 何建博 <hjb2722404@163.com>
| Date:   Wed Aug 4 14:09:45 2021 +0800
|
|     dev6 v2
|
* commit 96f758d85051aeb54c795ddb07b5d15cf7313a7a
| Author: 何建博 <hjb2722404@163.com>
| Date:   Wed Aug 4 14:09:15 2021 +0800
|
|     dev6 v1
|
* commit 4e0bdd4a14ca9b38fa0468d41ce813ff5b2ca975
| Author: 何建博 <hjb2722404@163.com>
| Date:   Wed Aug 4 10:47:37 2021 +0800
|
|     dev5 v2
|
* commit 55ef176872403d64d6e29816277d9431e1d2820a
| Author: 何建博 <hjb2722404@163.com>
| Date:   Wed Aug 4 10:46:57 2021 +0800
|
|     dev5 v1
|
* commit fd3da8e44fb01aa14bf75a92d3947047d5d6c300 (master)
| Author: 何建博 <hjb2722404@163.com>
| Date:   Tue Aug 3 15:13:44 2021 +0800
|
|     test5 v2

```

**结论19：`git cherry-pick`与`git rebase`一样，无法在提交历史图谱里体现哪些提交是从哪个分支复制过来的**。

#### 15 临时贮藏

在实际协作时，会有这样的情况，我们在某个分支上正在进行开发，此时另一个分支上有一个问题需要修复，那我们就需要切换到另一个分支去工作，可是当前这个分支上的工作还未完成，又不想提交（因为会影响提交历史），这个时候我们就可以把已经开发的尚未提交的那部分（包括工作目录中的和暂存区中的）改动（我们称它们为`stash`）暂时贮藏在一个独立的【栈】里面。

所谓栈的意思是这个空间的数据结构，意味着我们可以将多个不同分支的未提交的更改(即多个`stash`)都同时存入这个空间，而从空间取出时遵照【先进后出】的原则，就是先存入的后取出。（这是指使用`pop`命令时的情况，实际上，我们可以直接取出指定编号的那部分）。

现在，

1. 我们先在`dev5`分支上做一些改动，提交到暂存区，
2. 然后再做一些改动，
3. 然后将所有这些改动存入【栈】中，
4. 再切换到`dev4`分支上，做同样的操作，
5. 再切回`dev5`分支，取出刚刚存入【栈】的内容

这个过程中，我们随时观察仓库的状态。

老规矩，先`git gc`打包现有`objects`：

```bash
$ git gc

// objects目录
$ ll
total 4
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 8b/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Aug  4 17:27 info/
drwxr-xr-x 1 trs 197121 0 Aug  4 17:27 pack/
```

当前在`dev5`分支下，为了便于观察变化，我们在根目录下创建与之前内容一样的`test1.txt`和`test2.txt`

```bash
$ echo 'version 1' >> test1.txt
$ git add .
$ echo 'version 1' >> test2.txt
$ echo 'version 2' >> test2.txt
$ git status
On branch dev5
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   test1.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        test2.txt

```

此时我们再次查看`objeects`目录，没有变化。再看下仓库其它信息，也没有变化。

![image-20210804173226799](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804173227.png)

现在，我们使用贮藏命令将工作区和暂存区贮藏起来：

```bash
$ git stash
Saved working directory and index state WIP on dev5: 8dcd326 dev6 v2

$ git status
On branch dev5
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        test2.txt

nothing added to commit but untracked files present (use "git add" to track)


```

从命令的输出我们可以看到，`dev5`分支上`8dcd326`提交之后变化的工作目录和暂存区的状态已经保存。

其中，`WIP` 代表`Work in progress`，表示【在处理中的工作】，也即【未完成的工作】。

但是此时`test2.txt`还未加入暂存区，仍旧是未跟踪状态。

我们看下`objects`目录：

```bash
$ ll
total 4
drwxr-xr-x 1 trs 197121 0 Aug  4 17:33 0c/
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 8b/
drwxr-xr-x 1 trs 197121 0 Aug  4 17:33 99/
drwxr-xr-x 1 trs 197121 0 Aug  4 17:33 a4/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Aug  4 17:27 info/
drwxr-xr-x 1 trs 197121 0 Aug  4 17:27 pack/

```

发现多了三个对象，我们分别看下它们的内容和类型：

```bash
$ git cat-file -p 0cc0
tree 990b0127d134c87c5e8d85c4f3922d0420d4bf1f
parent 8dcd32635ea5a0450ade6a3e2f964f8b8dd064b0
author 何建博 <hjb2722404@163.com> 1628069596 +0800
committer 何建博 <hjb2722404@163.com> 1628069596 +0800

index on dev5: 8dcd326 dev6 v2

$ git cat-file -t 0cc0
commit


$ git cat-file -p 990b
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev5.txt
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev6.txt
040000 tree 75242e9fdbeba1b611a896ee69aae732962b8e94    fisrtdir
100644 blob 83baae61804e65cc73a7201a7252750c76066a30    test1.txt

$ git cat-file -t 990b
tree

 git cat-file -p a449
tree 990b0127d134c87c5e8d85c4f3922d0420d4bf1f
parent 8dcd32635ea5a0450ade6a3e2f964f8b8dd064b0
parent 0cc0b3ad20617d22706a00ca99932c9bebd38eb1
author 何建博 <hjb2722404@163.com> 1628069596 +0800
committer 何建博 <hjb2722404@163.com> 1628069596 +0800

WIP on dev5: 8dcd326 dev6 v2

$ git cat-file -t a449
commit

```

我们发现，这是一个树对象和两个提交对象。其中，第一个提交对象的`parent`父提交对象是`8dcd326`，正是我们当前分支的上一次提交，而第二个提交对象的`parent`父提交对象有两个，一个同样是`8dcd326`，另一个则是第一个提交对象。

同时，我们注意到，在`tree`对象里，没有`test2.txt`的身影。

而此时观察仓库其它状态：

![image-20210804174917646](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804174918.png)

发现在`refs`目录下多了一个`stash`文件，里面存放的是上述新生成的第二个提交对象的SHA值。

而在`logs/refs`目录里，也多了一个`stash`文件，内容如下：

```js
0000000000000000000000000000000000000000 a44902bbb10185a981ab5e6d2afba3ed84fba140 何建博 <hjb2722404@163.com> 1628069596 +0800	WIP on dev5: 8dcd326 dev6 v2
```



我们观察一下当前的关系图：

![image-20210804175104812](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804175105.png)



然后，我们再切换到`dev4`分支上，做一点改动，贮藏：

```bash
$ git checkout dev4
Switched to branch 'dev4'

$ git status
On branch dev4
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        test2.txt

nothing added to commit but untracked files present (use "git add" to track)

```

我们看到，`text2.txt`现在还是未被跟踪的状态。

```bash
$ echo 'version 1' >> test1.txt
$ git add .
warning: LF will be replaced by CRLF in test1.txt.
The file will have its original line endings in your working directory
warning: LF will be replaced by CRLF in test2.txt.
The file will have its original line endings in your working directory
$ echo 'new content' >> dev4.txt

$ git stash
warning: LF will be replaced by CRLF in dev4.txt.
The file will have its original line endings in your working directory
Saved working directory and index state WIP on dev4: 55a2eba dev6 v2

$ git status
On branch dev4
nothing to commit, working tree clean

```

这里注意，在刚刚的`dev5`分支上，`test2.txt`由于是新加的文件，从没有被添加到过暂存区，所以在贮藏的时候，没有把它存入【栈】，而这里我们对`dev4.txt`的修改同样没有使用`git add`添加到暂存区，但是通过`git status`的状态知道它是被存入【栈】中了，这就是说：

**结论20：`git stash`对未加入暂存区的文件，只会存入那些已跟踪的，而不会存入未跟踪的**。

我们再看下`objects`目录：

```bash
$ ll
total 4
drwxr-xr-x 1 trs 197121 0 Aug  4 17:33 0c/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 21/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 4d/
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 8b/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 93/
drwxr-xr-x 1 trs 197121 0 Aug  4 17:33 99/
drwxr-xr-x 1 trs 197121 0 Aug  4 17:33 a4/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 eb/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 f9/
drwxr-xr-x 1 trs 197121 0 Aug  4 17:27 info/
drwxr-xr-x 1 trs 197121 0 Aug  4 17:27 pack/

```

看看`18:02`分，新生成了5个对象，我们分别看下它们的内容：

```bash
$ git cat-file -p 21d8
tree eb9b50facff4936f5bc47ef2178af671f27f0d6a
parent 55a2ebaacef7e18ff9a710359632ed90a924576d
parent 938a1efde684b575d52401633b46e06bd201d9e0
author 何建博 <hjb2722404@163.com> 1628071327 +0800
committer 何建博 <hjb2722404@163.com> 1628071327 +0800

WIP on dev4: 55a2eba dev6 v2

$ git cat-file -p 4da1
1
2
new content

$ git cat-file -p 938a
tree f9745c9a0bf2897b6e2144f3f531e9ee38f248a2
parent 55a2ebaacef7e18ff9a710359632ed90a924576d
author 何建博 <hjb2722404@163.com> 1628071327 +0800
committer 何建博 <hjb2722404@163.com> 1628071327 +0800

index on dev4: 55a2eba dev6 v2

$ git cat-file -p eb9b
100644 blob 4da168afac6ed75a06b7de80a9975e0b406186be    dev4.txt
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev5.txt
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev6.txt
040000 tree 75242e9fdbeba1b611a896ee69aae732962b8e94    fisrtdir
100644 blob 83baae61804e65cc73a7201a7252750c76066a30    test1.txt
100644 blob 0c1e7391ca4e59584f8b773ecdbbb9467eba1547    test2.txt

$ git cat-file -p f974
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev4.txt
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev5.txt
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev6.txt
040000 tree 75242e9fdbeba1b611a896ee69aae732962b8e94    fisrtdir
100644 blob 83baae61804e65cc73a7201a7252750c76066a30    test1.txt
100644 blob 0c1e7391ca4e59584f8b773ecdbbb9467eba1547    test2.txt

```

这5个对象，与之前一样，有两个提交对象，不同的是，这一次，针对`dev4.txt`的改动后的内容，生成了一个新的`blob` 对象，并且因为`dev4.txt`有改动前后的两种状态，所以生成了两个树对象，这两个树对象唯一的不同就是`dev4.txt`指向的提交HASH不同。

我们再看下仓库状态：

![image-20210804181621518](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804181621.png)

新增了一条操作记录，`refs`目录下的`stash`所指向的提交HASH也变成了最新的那个，我们梳理下关系图：

![image-20210804182315245](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804182315.png)



然后，我们切换回`dev5`，尝试取出【栈】中的内容：

```bash
$ git checkout dev5
Switched to branch 'dev5'
```

先看下当前【栈】的状态：

```bash
$ git stash list
stash@{0}: WIP on dev4: 55a2eba dev6 v2
stash@{1}: WIP on dev5: 8dcd326 dev6 v2
```

我们看到，此时【栈】中有两个`stash`：

* 第1个编号是0，是在`dev4`上存入栈的，
* 第2个编号是1，是在`dev5`上存入栈的。

那我们要取第2个，怎么取呢？使用`git stash apply stashName`：

```bash
$ git stash apply stash@{1}
On branch dev5
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   test1.txt

```

其中，`stashName`就是我们执行`git stash list`后输出的每行冒号前面那一串。

我们看到，在从【栈】中取出指定内容后，会输出当前工作目录的状态，确实是我们之前在`dev5`上存入时的状态（注意，由于`test2.txt`没有被存入【栈】，所以这里没有）。

我们提交后再切换到`dev4`分支，取出存入的内容。

```bash
$ git add .

$ git commit -m 'new test1'
[dev5 0181d3f] new test1
 1 file changed, 1 insertion(+)
 create mode 100644 test1.txt

$ git checkout dev4
Switched to branch 'dev4'

$ git stash list
stash@{0}: WIP on dev4: 55a2eba dev6 v2
stash@{1}: WIP on dev5: 8dcd326 dev6 v2

$ git stash pop
On branch dev4
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   test1.txt
        new file:   test2.txt

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   dev4.txt

Dropped refs/stash@{0} (21d8558ed641bb172d417498f008c9cf7bf98d7d)

$ git stash list
stash@{0}: WIP on dev5: 8dcd326 dev6 v2

```

这里有更多需要说明的了。

1. `git stash apply`命令不从【栈】中删除对应的`stash`
2. ``git stash pop`属于出栈动作，所以会把内容直接从【栈】中删除
3. `git stash pop` 每次只能取出一个`stash`，并且永远只能取出处于栈顶的那个`stash`，即编号为`0`的`stash@{0}`那个`stash`。
4. 当栈顶`stash`被`pop`出栈后，原来编号为`1`的那个`stash`将变成编号为`0`的`stash`，后面的一次类推。

现在再看仓库状态的变化：

![image-20210805094300141](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210805094307.png)

显而易见地有两条变化：

1. 在`log/refs/stash`中，被取出的那个`stash`，其存入时的操作记录也被删除了。

2. 在`refs/stash`中，`stash`指针重新指向了`dev5`分支上贮藏的那个`stash`。也就是说，现在关系图又恢复成了:

   ![image-20210804175104812](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210804175105.png)

可见，【栈】就是一个临时性的空间，针对每一个`stash`，这个空间里存储着两个提交对象，其中一个是暂存区的快照，另一个是工作目录的快照。其中工作目录的快照同时又将上一次提交和本次暂存区快照的内容快照作为父对象。

当我们从【栈】中取出`stash`时，其实就是从工作区快照开始逆向解析提交链（顺着`parent`属性），然后直到上一次提交，把这个过程中解析出的内容恢复到工作目录和暂存区。

好了，了解了`git stash`命令的原理后，我们现在看看当前工作目录的状态：

```bash
$ git status
On branch dev4
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   test1.txt
        new file:   test2.txt

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   dev4.txt
 
$ git ls-files -s
100644 1191247b6d9a206f6ba3d8ac79e26d041dd86941 0       dev4.txt
100644 1191247b6d9a206f6ba3d8ac79e26d041dd86941 0       dev5.txt
100644 1191247b6d9a206f6ba3d8ac79e26d041dd86941 0       dev6.txt
100644 83baae61804e65cc73a7201a7252750c76066a30 0       fisrtdir/test1.txt
100644 d6508a9fed612872652dff0b673c6d35e129ef73 0       fisrtdir/test2.txt
100644 1728e5ee30cee9e075deb93f91d003efc08c153e 0       fisrtdir/test3.txt
100644 91b749ddf2b1579a482306ed42a5a4636a927d6b 0       fisrtdir/test4.txt
100644 31715cd8e1d6bd99296db7f2b98ec8243d873c0c 0       fisrtdir/test5.txt
100644 83baae61804e65cc73a7201a7252750c76066a30 0       test1.txt
100644 0c1e7391ca4e59584f8b773ecdbbb9467eba1547 0       test2.txt


```

这是我们刚刚从【栈】中取出的`stash`内容，现在，我们舍弃这些修改。

前面说过，使用`git rm`命令可以从暂存区和工作目录删除未提交内容。

下面，我们使用另一种方式`git checkout .` + `git restore`

```bash
$ git checkout .
Updated 1 path from the index

$ git status
On branch dev4
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   test1.txt
        new file:   test2.txt
        
$ git restore --staged .
$ git status
On branch dev4
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        test1.txt
        test2.txt

$ git checkout .
Updated 0 paths from the index

$ git status
On branch dev4
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        test1.txt
        test2.txt
$ git restore test1.txt
error: pathspec 'test1.txt' did not match any file(s) known to git
$ git rm test1.txt
fatal: pathspec 'test1.txt' did not match any files        
        
$ rm test1.txt
$ rm test2.txt
$ git status
On branch dev4
nothing to commit, working tree clean
```

我们注意到：

1. 对于已被跟踪，工作目录中已修改，但未暂存的`dev4.txt`，使用`git checkout .`可以将这些改动丢弃。
2. 对于已处于暂存区的`test1.txt` 与 `test2.txt`，`git checkout .`无法丢弃。而使用`git restore --staged .`可以将其改变为未跟踪状态，即从暂存区删除。
3. 对于已处于未跟踪状态的`test1.txt`和`test2.txt`，无论是`git checkout`还是`git restore`或者是`git rm`，我们都无法将其从工作目录删除，此时，只有我们手动删除（调用`linux`的`rm`命令）才可以。

现在， 工作目录是干净的了，我们将开始探索Git中的下一个重要概念：标签（`tag`）

#### 16. 标签

通过上文的学习，我们知道，分支实际上是一个指针，随着不断地进行新的提交，它会不断地指向新的提交，但有时候我们需要快速回到某个以前的提交怎么办呢？当然，我们可以记住这个提交的SHA值，但是我们能记住一两个，能记住100个吗？比如我们的软件发布了100个版本，我们能记住每个版本发布时所在的按个提交的SHA值吗？

除非我们都是最强大脑，否则这是不可能的，所以，此时我们就可以给想要记住的那次提交打一个标签，起一个容易记住的名字，比如`1.1.1.0`这样的。实际上，在真实项目开发场景中，我们绝大多数时候就是用标签来标注我们要发布的版本的。而标签如果被用来标记版本号，则会遵循[《语义化版本控制规范》](https://semver.org/lang/zh-CN/)

现在，假定这个时候的`dev4`分支当前就是待发布的`1.0.0`版本了，那我们使用`git tag`命令来给它打一个标签，老规矩，在打标签前先执行`git gc`打包已有`objects`，方便我们观察变化

```bash
$ git gc
Enumerating objects: 128, done.
Counting objects: 100% (128/128), done.
Delta compression using up to 8 threads
Compressing objects: 100% (54/54), done.
Writing objects: 100% (128/128), done.
Total 128 (delta 32), reused 123 (delta 30)

$ ll .git/objects/
total 4
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 21/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 4d/
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 8b/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 93/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 eb/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 f9/
drwxr-xr-x 1 trs 197121 0 Aug  5 16:12 info/
drwxr-xr-x 1 trs 197121 0 Aug  5 16:12 pack/

$ git tag v1.0.0

```

现在我们看下有什么变化，先看`objects`目录，输出与上面输出一致，没有变化，再看仓库状态：

![image-20210805161838022](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210805161838.png)

唯一的变化是：

`refs/tags` 目录下多了一个`v1.0.0`的文件，它里面保存了当前分支所指向的提交的SHA值，也就是说，它其实就是一个指针，但是与分支不一样，分支的内容会随着新的提交产生而改变，但它的内容永远不会变。

现在我们看看当前工作目录的内容：

```bash
$ ll
total 3
-rw-r--r-- 1 trs 197121 6 Aug  5 10:59 dev4.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 14:32 dev5.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 16:15 dev6.txt
drwxr-xr-x 1 trs 197121 0 Aug  4 09:36 fisrtdir/
```





记住当前内容，我们在`dev4`上做一些变更并提交：

```bash
$ echo '1' >> dev4-1.txt
$ git add .
$ git commit -m "4-1"
[dev4 59c0b6d] 4-1
 1 file changed, 1 insertion(+)
 create mode 100644 dev4-1.txt
 
$ echo '2' >> dev4-2.txt
$ git add .
$ git commit -m "4-2"
[dev4 b757051] 4-2
 1 file changed, 1 insertion(+)
 create mode 100644 dev4-2.txt
 
 $ ll
total 5
-rw-r--r-- 1 trs 197121 2 Aug  5 16:23 dev4-1.txt
-rw-r--r-- 1 trs 197121 2 Aug  5 16:24 dev4-2.txt
-rw-r--r-- 1 trs 197121 6 Aug  5 10:59 dev4.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 14:32 dev5.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 16:15 dev6.txt
drwxr-xr-x 1 trs 197121 0 Aug  4 09:36 fisrtdir/


```

此时的提交图谱如下：

![image-20210805163945265](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210805163945.png)

此时，我们想回顾看看在`v1.0.0`版本时我们发布了哪些内容，就可以使用`git checkout tagName`切换到那个标签所指向的提交处：

```bash
$ git checkout v1.0.0
Note: switching to 'v1.0.0'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at 55a2eba dev6 v2

$ ll
total 3
-rw-r--r-- 1 trs 197121 6 Aug  5 10:59 dev4.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 14:32 dev5.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 16:15 dev6.txt
drwxr-xr-x 1 trs 197121 0 Aug  4 09:36 fisrtdir/

```

首先，通过列出目录我们可以看出，确实回到了之前发布`1.0.0`版本时的提交。这里，命令输出了一些说明，我们说明一下：

* 首先，告诉我们已经切换到了`v1.0.0`
* 然后，告诉我们，我们当前出于`HEAD`游离状态，你可以在当前状态做任何更改和提交，这都不会影响现有的任何分支
* 如果你想要保存这些修改和提交，就必须使用`git switch`命令来创建一个新的分支
* 如果你想要撤销本次`checkout`操作（即从`tag`回到分支），则可以使用`git switch -`命令，这个命令的效果和`git checkout -`的效果是一样的。
* 可以通过设置`advice.detachedHead` 为`false` 来关闭这个提示，以后再出于`HEAD`游离状态时不会再有此提示
* 当前`HEAD`处于`55a2eba`这次提交上。

看看仓库状态：

![image-20210805164141208](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210805164141.png)

也就是说，此时的提交图谱变为了：

![image-20210805164227901](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210805164228.png)



既然有此提示，那我们就尝试一下，在当前状态下做一个修改提交：

```bash
$ git gc
Enumerating objects: 133, done.
Counting objects: 100% (133/133), done.
Delta compression using up to 8 threads
Compressing objects: 100% (56/56), done.
Writing objects: 100% (133/133), done.
Total 133 (delta 34), reused 127 (delta 32)

$ ll .git/objects/
total 4
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 21/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 4d/
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 8b/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 93/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 eb/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 f9/
drwxr-xr-x 1 trs 197121 0 Aug  5 16:43 info/
drwxr-xr-x 1 trs 197121 0 Aug  5 16:43 pack/

$ echo '1' >> tag1.txt

$ ll
total 4
-rw-r--r-- 1 trs 197121 6 Aug  5 10:59 dev4.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 14:32 dev5.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 16:15 dev6.txt
drwxr-xr-x 1 trs 197121 0 Aug  4 09:36 fisrtdir/
-rw-r--r-- 1 trs 197121 2 Aug  5 16:44 tag1.txt

$ git add .

$ git commit -m "tag 1"
[detached HEAD af63581] tag 1
 1 file changed, 1 insertion(+)
 create mode 100644 tag1.txt

$ ll .git/objects/
total 4
drwxr-xr-x 1 trs 197121 0 Aug  5 16:44 07/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 21/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 4d/
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 8b/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 93/
drwxr-xr-x 1 trs 197121 0 Aug  5 16:44 af/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 eb/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 f9/
drwxr-xr-x 1 trs 197121 0 Aug  5 16:43 info/
drwxr-xr-x 1 trs 197121 0 Aug  5 16:43 pack/
```

可以看到，再我们进行修改提交后，`16:44`分生成了两个新的对象：

```bash
$ git cat-file -p 0737
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev4.txt
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev5.txt
100644 blob 1191247b6d9a206f6ba3d8ac79e26d041dd86941    dev6.txt
040000 tree 75242e9fdbeba1b611a896ee69aae732962b8e94    fisrtdir
100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d    tag1.txt

$ git cat-file -p af63
tree 07374fee96debdaa6406fa9768862326b1d29223
parent 55a2ebaacef7e18ff9a710359632ed90a924576d
author 何建博 <hjb2722404@163.com> 1628153083 +0800
committer 何建博 <hjb2722404@163.com> 1628153083 +0800

tag 1
```

正是针对我们刚刚的修改生成的一个树对象和一个提交对象

看看仓库状态：

![image-20210805165027954](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210805165028.png)

此时关系图如下：

![image-20210805165157534](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210805165157.png)

也就是说，当前`HEAD`、分支（`dev4`）、标签（`v1.0.0`）指向不同的提交。

这时，如果我们想要保存这次修改，就使用建议的命令：

```bash
$ git switch -c fromTagv1
Switched to a new branch 'fromTagv1'

$ ll
total 4
-rw-r--r-- 1 trs 197121 6 Aug  5 10:59 dev4.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 14:32 dev5.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 16:15 dev6.txt
drwxr-xr-x 1 trs 197121 0 Aug  4 09:36 fisrtdir/
-rw-r--r-- 1 trs 197121 2 Aug  5 16:44 tag1.txt

```

![image-20210805165510184](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210805165510.png)

`HEAD`指向了新建的分支，新分支指向了之前我们在`tag`上所做的那次提交。

![image-20210805165740485](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210805165740.png)

现在，我们再切换回`tag`：

```bash
$ git checkout v1.0.0
Note: switching to 'v1.0.0'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at 55a2eba dev6 v2

$ ll
total 3
-rw-r--r-- 1 trs 197121 6 Aug  5 10:59 dev4.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 14:32 dev5.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 16:15 dev6.txt
drwxr-xr-x 1 trs 197121 0 Aug  4 09:36 fisrtdir/

```

可以看到，我们所做的更改丝毫没有影响`tag`的内容。

现在，我们再次做一次修改，然后不提交，再切回`dev4`，看看会发生什么：

```bash
$ echo '2' >> tag1.txt

$ ll
total 4
-rw-r--r-- 1 trs 197121 6 Aug  5 10:59 dev4.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 14:32 dev5.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 16:15 dev6.txt
drwxr-xr-x 1 trs 197121 0 Aug  4 09:36 fisrtdir/
-rw-r--r-- 1 trs 197121 2 Aug  5 17:00 tag1.txt

$ git checkout dev4
Previous HEAD position was 55a2eba dev6 v2
Switched to branch 'dev4'

$ git status
On branch dev4
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        tag1.txt

nothing added to commit but untracked files present (use "git add" to track)


```

可以看到，在`tag`上，未跟踪的内容切换到其它分支上，内容仍旧存在，仍旧是未跟踪。

我们手动删除这个文件，再次切换回`tag`，再修改一下已跟踪的文件，再切换回`dev4`:

```bash
$ rm tag1.txt
$ git checkout v1.0.0
Note: switching to 'v1.0.0'.

$ ll
total 3
-rw-r--r-- 1 trs 197121 6 Aug  5 10:59 dev4.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 14:32 dev5.txt
-rw-r--r-- 1 trs 197121 6 Aug  4 16:15 dev6.txt
drwxr-xr-x 1 trs 197121 0 Aug  4 09:36 fisrtdir/

$ cat dev4.txt
1
2

$ echo '3' >> dev4.txt
$ cat dev4.txt
1
2
3

$ git checkout dev4
Previous HEAD position was 55a2eba dev6 v2
Switched to branch 'dev4'
M       dev4.txt

$ git status
On branch dev4
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   dev4.txt

no changes added to commit (use "git add" and/or "git commit -a")

```

一样的，对于已跟踪但未暂存的内容，同样切换到其它分之后，仍旧保留更改与状态。

其实，对于已暂存未提交的内容，也是一样的会在切换时把更改和状态保留着的。

想想就能明白了，虽然我们是在`tag`与分支之间进行切换，但本质上是在两次提交之间切换，而在两个分支之间切换的本是也是在两次提交之间切换，所以它们的行为都是一样的。

现在，我们将更改提交到`dev4`上

```bash

$ git add .
$ git commit -m "from tag"
[dev4 3d9cb7e] from tag
 1 file changed, 1 insertion(+)

```

此时，提交图谱如下：

![image-20210805172703182](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210805172703.png)

刚刚我们打的标签是一个轻量标签，它只是一个简单的指向一个提交，而没有自己的信息，

```bash
$ git show v1.0.0
commit 55a2ebaacef7e18ff9a710359632ed90a924576d (tag: v1.0.0)
Author: 何建博 <hjb2722404@163.com>
Date:   Wed Aug 4 14:09:45 2021 +0800

    dev6 v2
```

还有另一种标签，叫做【附注标签】，在这个标签上，我们可以加入一些说明和签署信息，我们在当前`dev4`上再打一个`v2.0.0`的标签，这次我们用【附注标签】:

```bash
$ git tag -a v2.0.0 -m "本次发版修改了dev4.txt"

$ ll .git/objects/
total 4
drwxr-xr-x 1 trs 197121 0 Aug  5 16:44 07/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 21/
drwxr-xr-x 1 trs 197121 0 Aug  5 17:32 23/
drwxr-xr-x 1 trs 197121 0 Aug  5 17:24 3d/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 4d/
drwxr-xr-x 1 trs 197121 0 Aug  5 17:24 68/
drwxr-xr-x 1 trs 197121 0 Aug  4 09:25 8b/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 93/
drwxr-xr-x 1 trs 197121 0 Aug  5 16:44 af/
drwxr-xr-x 1 trs 197121 0 Jul 29 13:56 e6/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 eb/
drwxr-xr-x 1 trs 197121 0 Aug  4 18:02 f9/
drwxr-xr-x 1 trs 197121 0 Aug  5 16:43 info/
drwxr-xr-x 1 trs 197121 0 Aug  5 16:43 pack/

```

这次打标签是在`17:32`分执行的，我们看一下，在这个时间点又生成了一个对象：

```bash
$ git cat-file -p 2363
object 3d9cb7e51fbaa6a3192d83fb6a24d4f97b0b48ca
type commit
tag v2.0.0
tagger 何建博 <hjb2722404@163.com> 1628155925 +0800

本次发版修改了dev4.txt

$ git cat-file -t 2363
tag

```

前面我们接触了Git底层的三种对象：提交（`commit`）对象，树（`tree`）对象，实体（`blob`）对象。

这里，我们终于遇见了Git中的最后一种对象：标签（`tag`)对象。

标签对象存储了：

* 一个`type`为`commit`的`object`(对象)的SHA值，实际上，这就是`dev4`当前所指向的那个提交对象。
* 标签的名字： `v2.0.0`
* 打标签的人的信息及时间。
* 标签说明

![image-20210805174107122](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210805174107.png)

此时的提交关系图：

![image-20210805174154859](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210805174155.png)



在这里，我们可以看到【轻量标签】和【附注标签】的区别：

* 轻量标签只是一个指向提交对象的指针，不生成任何对象
* 附注标签会生成一个标签对象来存储标签信息，标签指针指向这个标签对象。

我们还可以通过`git show`方法类看下两类标签的不同：

```bash
$ git show v1.0.0
commit 55a2ebaacef7e18ff9a710359632ed90a924576d (tag: v1.0.0)
Author: 何建博 <hjb2722404@163.com>
Date:   Wed Aug 4 14:09:45 2021 +0800

    dev6 v2

diff --git a/dev6.txt b/dev6.txt
xxx

$ git show v2.0.0
tag v2.0.0
Tagger: 何建博 <hjb2722404@163.com>
Date:   Thu Aug 5 17:32:05 2021 +0800

本次发版修改了dev4.txt

commit 3d9cb7e51fbaa6a3192d83fb6a24d4f97b0b48ca (HEAD -> dev4, tag: v2.0.0)
Author: 何建博 <hjb2722404@163.com>
Date:   Thu Aug 5 17:24:43 2021 +0800

    from tag

diff --git a/dev4.txt b/dev4.txt
xxx
```

轻量标签只显示它指向的那个提交对象的信息，而附注标签则即显示了标签对象的信息，又显示了它所指向的提交对象的信息。

所以，我们建议，尽量使用【附注标签】。

基本上，涉及本地开发的一些基本操作，我们已经学习的差不多了，现在，我们看看如何通过远程仓库来进行协作。

#### 17. 远程仓库

为了学习多人通过远程仓库进行协作时到底发生了什么，我们必须先建立一个远程仓库。我们选择直接在`gitee`上新建一个仓库，作为我们的远程仓库。

具体如何在`gitee`上新建仓库，这里就不演示了，我已经建好一个仓库远程仓库，它的地址是：

`https://gitee.com/hjb2722404/git-test`

我们看一下：

![image-20210806162739265](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210806162746.png)



现在，这个仓库还没有任何内容，我们看到它提示我们，有两种方式初始化它：

* 一种是从本地新建并初始化一个仓库，添加一些内容，关联远程仓库，然后通过`git push` 将本地仓库推送到远程仓库
* 一种是直接将本地已有的仓库关联远程仓库，并推送到远程仓库

我们已经有了一个仓库，所以选择第一种。

在进行这个操作前，需要说明的是，要想获得将本地仓库内容推送到远程仓库的权限，需要先将本地生成的SSH公钥加入到远程仓库的公钥库中，我们已经将本地的SSH公钥和另一台`ubuntu`主机的公钥都存入了远程仓库的公钥库中，过程就不再展示了，有兴趣请互联网搜索相关资料阅读。

首先，看一下当前本地仓库状态：

![image-20210806170403350](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210806170403.png)

  我们按照远程仓库页面上的提示在当前分支上`dev4`进行操作：

```bash
$$ find .git/objects/ -type f
.git/objects/07/374fee96debdaa6406fa9768862326b1d29223
.git/objects/21/d8558ed641bb172d417498f008c9cf7bf98d7d
.git/objects/23/63fe8ccf7862c9b438274cdc8aaab0f39c3e0d
.git/objects/3d/9cb7e51fbaa6a3192d83fb6a24d4f97b0b48ca
.git/objects/4d/a168afac6ed75a06b7de80a9975e0b406186be
.git/objects/68/71fab3194b5e9438d66952e18267be4fc1539f
.git/objects/8b/39179329c2c79f240dd854660214f2824e37ac
.git/objects/93/8a1efde684b575d52401633b46e06bd201d9e0
.git/objects/af/63581aae4bd968303adb6d068f8fe4dca34068
.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
.git/objects/eb/9b50facff4936f5bc47ef2178af671f27f0d6a
.git/objects/f9/745c9a0bf2897b6e2144f3f531e9ee38f248a2
.git/objects/info/packs
.git/objects/pack/pack-52baf12078dedba1121a601848ad83fe26d58036.idx
.git/objects/pack/pack-52baf12078dedba1121a601848ad83fe26d58036.pack

$ git remote add origin https://gitee.com/hjb2722404/git-test.git


```



这一步执行完，我们发现，仓库状态发生了变化：

![image-20210806171111335](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210806171111.png)

`.git/config`里多了远程仓库的信息，远程仓库名为`origin`，下面有两个属性：

* `url`：通过这个地址可以访问到远程仓库
* `fetch`：从远程仓库拉取时将会把远程仓库`.git`目录下的`refs/remotes/origin/*`文件映射到本地的`.git/refs/heds/*`

```bash
$ git push -u origin master
Enumerating objects: 48, done.
Counting objects: 100% (48/48), done.
Delta compression using up to 8 threads
Compressing objects: 100% (17/17), done.
Writing objects: 100% (48/48), 3.58 KiB | 1.19 MiB/s, done.
Total 48 (delta 8), reused 45 (delta 7)
remote: Powered by GITEE.COM [GNK-6.0]
To https://gitee.com/hjb2722404/git-test.git
 * [new branch]      master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.

$ find .git/objects/ -type f
.git/objects/07/374fee96debdaa6406fa9768862326b1d29223
.git/objects/21/d8558ed641bb172d417498f008c9cf7bf98d7d
.git/objects/23/63fe8ccf7862c9b438274cdc8aaab0f39c3e0d
.git/objects/3d/9cb7e51fbaa6a3192d83fb6a24d4f97b0b48ca
.git/objects/4d/a168afac6ed75a06b7de80a9975e0b406186be
.git/objects/68/71fab3194b5e9438d66952e18267be4fc1539f
.git/objects/8b/39179329c2c79f240dd854660214f2824e37ac
.git/objects/93/8a1efde684b575d52401633b46e06bd201d9e0
.git/objects/af/63581aae4bd968303adb6d068f8fe4dca34068
.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
.git/objects/eb/9b50facff4936f5bc47ef2178af671f27f0d6a
.git/objects/f9/745c9a0bf2897b6e2144f3f531e9ee38f248a2
.git/objects/info/packs
.git/objects/pack/pack-52baf12078dedba1121a601848ad83fe26d58036.idx
.git/objects/pack/pack-52baf12078dedba1121a601848ad83fe26d58036.pack

```

我们说明一下：

1. 首先，我们看到，`git push` 调用了`git gc`命令来对当前的`objects`进行打包，但是之后我们查看`objects`目录里的`objects`并不见减少，原因我们下面解释。

2. 打包完后，输出了远程仓库的信息：

   * `Powered by GITEE.COM[GNK-6.0]`：表明远程仓库是由`GITEE.COM`所有，【GNK-6.0】是（`Gitee native hook`）的意思，它是`gitee`系统的钩子库，在推送时它会检测文件大小等。
   * 接下来是远程仓库的地址
   * 然后告诉我们，远程仓库新生成了一个分支，并将本地的`master`分支映射到了远程仓库的`master`上面

   这就是为什么明明执行了打包操作，`objects`目录却不见减少的原因：

   * 虽然我们是在`dev4`上进行的推送，但我们的命令时`git push -u origin master`，所以实际上我们是将本地的`master`分支推送到远程仓库了，而`master`早就打过包了，当前`objects`目录里的内容时属于`dev4`的，自然没有被打入包，而之所以`pack`里的包名没有变化，是因为在`packed-refs`里记录了`master`分支所指向的提交对象HASH，Git会在后台沿着这个提交向前递归所有它包含的提交和内容进行打包，然后传输到远程仓库，并不会改变本地仓库。

     ![image-20210806172756676](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210806172757.png)

     从上图中我们还可以看出，此时`config`文件里又多了一条配置记录，它描述了将本地`master`分支映射到远程仓库的`refs/heads/master`文件。

   现在我们看远程仓库：

   ![image-20210806172948928](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210806172949.png)

可以看到，这里是`master`分支，对应的内容也和本地`master`分支一样，指向的最新提交是`test5 v2`.

现在，我们切换到`ubuntu`主机上，将远程仓库拉取下来：

```bash
// ubuntu
$ mkdir  test
$ cd test
$ git clone https://gitee.com/hjb2722404/git-test.git
Cloning into 'git-test'...
Username for 'https://gitee.com': xxxxxx@163.com
Password for 'https://xxxxx@163.com@gitee.com':
remote: Enumerating objects: 48, done.
remote: Counting objects: 100% (48/48), done.
remote: Compressing objects: 100% (24/24), done.
remote: Total 48 (delta 9), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (48/48), 3.50 KiB | 14.00 KiB/s, done
```

我们通过`git clone`命令将远程仓库拉取下来，此时，命令行提示我们：

1. 将远程仓库内容克隆至`git-test`目录，我们没有创建这个目录，Git将自动创建
2. 要求我们输入远程仓库所在服务器（`gitee.com`）的用户名、密码
3. 远程仓库打包压缩信息
4. 本地解压包信息

现在我们看看`ubuntu`本地仓库

```bash
$ ll
total 0
drwxr-xr-x 1 hjb2722404 hjb2722404 4096 Aug  6 17:35 ./
drwxr-xr-x 1 hjb2722404 hjb2722404 4096 Aug  6 17:33 ../
drwxr-xr-x 1 hjb2722404 hjb2722404 4096 Aug  6 17:36 git-test/

$ cd git-test/

$ git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean

$ ll
total 0
drwxr-xr-x 1 hjb2722404 hjb2722404 4096 Aug  6 17:36 ./
drwxr-xr-x 1 hjb2722404 hjb2722404 4096 Aug  6 17:35 ../
drwxr-xr-x 1 hjb2722404 hjb2722404 4096 Aug  6 17:47 .git/
drwxr-xr-x 1 hjb2722404 hjb2722404 4096 Aug  6 17:36 fisrtdir/
```

Git为我们建立了与远程仓库同名的目录，并且把远程仓库内容下载解压到了本地，我们看，它其实也自动初始化了Git本地仓库，所以它也有了一个`.git`目录。

我们还是在编辑器中看看这个仓库的信息：

![image-20210806175439742](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210806175440.png)

这里有一些需要说明的地方：

1. 我们注意到在`logs`目录里的三个文件：

   1. `refs/heads/master`
   2. `refs/remotes/origin/HEAD`
   3. `refs/HEAD`

   它们都只有一条记录，也就是说，之前我们在`windows`主机上的操作记录没有被推送到远程仓库，而远程仓库的操作记录也不会被同步到`ubuntu`主机，即：

   **`logs`里面存储的所有操作记录，永远只存储在本机，不会被同步到其它仓库，每个协作者的本地仓库的操作记录都只会记录那个协作者自己的操作，而不会记录到其它协作者的操作记录**

2. `refs`目录里既没有我们之前在`windows`主机打的`tag`，也没有我们的除了`master`之外的其它分支，说明：

    **除非我们手动推送，否则本地仓库的分支和标签都不会自动同步到远程仓库去**

3. `config`里有远程仓库的信息和本地分支与远程分支的映射信息，这是`git clone`时自动生成的

4. `packed-refs` 文件也只记录本地用了的打包文件的信息，其它的不会通过远程仓库进行同步

5. `stash` 与 `logs`一样，永远只是本地的，无法被推送到远程。

我们在`windows`主机上把其它分支和标签都推送到远程仓库里去：

```bash
$ git branch -a
  dev
  dev2
  dev3
* dev4
  dev5
  dev6
  fromTagv1
  master
  remotes/origin/master  
  
// 以下命令的输出我都省略了，大致同`git push origin master`的输出  
$ git push origin dev
$ git push origin dev2 
$ git push origin dev3
$ git push origin dev4
$ git push origin dev5
$ git push origin dev6
$ git push origin fromTagv1

$ git branch -a
  dev
  dev2
  dev3
* dev4
  dev5
  dev6
  fromTagv1
  master
  remotes/origin/dev
  remotes/origin/dev2
  remotes/origin/dev3
  remotes/origin/dev4
  remotes/origin/dev5
  remotes/origin/dev6
  remotes/origin/fromTagv1
  remotes/origin/master
```

![image-20210809093929943](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210809093938.png)

可以看到，所有被推送到远程仓库的分支，都会在

* `logs/refs/remotes/origin`目录下产生对应的操作记录
* `refs/remotes/origin`目录下产生当前远程仓库指向的提交的记录。

我们看下远程仓库：

![image-20210809094314527](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210809094314.png)

我们再到`ubuntu`主机上看下：

![image-20210809094527858](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210809094528.png)

此时仓库里是没有远程仓库新加入的分支的信息的。

我们命令行里看下：

```bash
$ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
```

可以看到，也只有远程仓库`master`分支的信息。

我们执行`git fetch`再看一下：

```bash
$ git fetch
remote: Enumerating objects: 67, done.
remote: Counting objects: 100% (65/65), done.
remote: Compressing objects: 100% (46/46), done.
remote: Total 58 (delta 18), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (58/58), 5.19 KiB | 19.00 KiB/s, done.
From https://gitee.com/hjb2722404/git-test
 * [new branch]      dev        -> origin/dev
 * [new branch]      dev2       -> origin/dev2
 * [new branch]      dev3       -> origin/dev3
 * [new branch]      dev4       -> origin/dev4
 * [new branch]      dev5       -> origin/dev5
 * [new branch]      dev6       -> origin/dev6
 * [new branch]      fromTagv1  -> origin/fromTagv1
 
 $ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/dev
  remotes/origin/dev2
  remotes/origin/dev3
  remotes/origin/dev4
  remotes/origin/dev5
  remotes/origin/dev6
  remotes/origin/fromTagv1
  remotes/origin/master
```

![image-20210809095139975](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210809095140.png)

可见，`git fetch`的作用就是将远程仓库的信息同步到本地仓库，并且在本地仓库初始化对远程仓库的操作记录。

我们还注意到，在`.git`根目录多了一个文件：

![image-20210809152819395](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210809152819.png)

这个文件记录了所有远程分支的信息，包括：

* 分支所指向的提交对象SHA值
* 是否可以在执行`git pull`命令（不带任何参数）时，自动执行`git merge`操作
* 分支所属远程仓库地址

在我们直接执行`git pull`命令而不带任何参数时，没有标识`not-for-merge`的分支(这里为`master`)，会自动与本地同名分支做合并（即执行`git merge`）

当然，**结论21：并不意味着我不管在哪个分支上执行`git pull `都会默认合并`master`分支，而是我们在哪个分支上执行的`git fetch`，那么默认`git pull` 时就会对哪个分支执行合并操作**。

我们切换到`dev`分支：

```bash
$ git checkout dev
$ git status
On branch dev
Your branch is up to date with 'origin/dev'.

nothing to commit, working tree clean
$git fetch
```

然后再看：

![image-20210809153949482](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210809153949.png)

所以，每次`git fetch`时这个文件（`FETCH_HEAD`）的内容都会更新，`fetch`时所在的分支将被设定为`git pull`时默认执行`git mrege`的分支，而其它分支则不会。

![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210809154142.png)

并且当我们执行了`git checkout dev`之后，`config`里就会记录`dev`分支对应的远程仓库的信息。

当然，我们还可以指定只`fetch`某个远程分支：

```bash
$ git fetch origin dev4
From https://gitee.com/hjb2722404/git-test
 * branch            dev4       -> FETCH_HEAD
```

![image-20210809154555195](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210809154555.png)

好的，当前可合并分支为`dev4`，现在，我们切换到`dev5`:

```bash
$ git checkout dev5
```

然后回到`windows`主机，在`dev4`上修改一些内容提交，并推送到远程仓库：

```bash
$ git status
On branch dev4
nothing to commit, working tree clean

$ git add .
$ git commit -m "new"
[dev4 b0724fe] new
 1 file changed, 1 insertion(+)
 create mode 100644 new.txt
$ git push origin dev4

```

看下远程仓库：

![image-20210809162259999](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210809162300.png)



然后在`ubuntu`主机的`dev5`分支上执行`git pull`操作：

```bash
$ git pull
remote: Enumerating objects: 4, done.
remote: Counting objects: 100% (4/4), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), 252 bytes | 10.00 KiB/s, done.
From https://gitee.com/hjb2722404/git-test
   3d9cb7e..b0724fe  dev4       -> origin/dev4
Already up to date.
```

可以看到，倒数第二行告诉我们，将远程仓库的`origin/dev4`更新到了本地`dev4`上，我们看下本地`dev4`的内容：

```bash
$ git checkout dev4

$ ll
total 0
drwxr-xr-x 1 hjb2722404 hjb2722404 4096 Aug  9 16:25 ./
drwxr-xr-x 1 hjb2722404 hjb2722404 4096 Aug  6 17:35 ../
drwxr-xr-x 1 hjb2722404 hjb2722404 4096 Aug  9 16:25 .git/
-rw-r--r-- 1 hjb2722404 hjb2722404    2 Aug  9 16:25 dev4-1.txt
-rw-r--r-- 1 hjb2722404 hjb2722404    2 Aug  9 16:25 dev4-2.txt
-rw-r--r-- 1 hjb2722404 hjb2722404    6 Aug  9 16:25 dev4.txt
-rw-r--r-- 1 hjb2722404 hjb2722404    4 Aug  9 15:46 dev5.txt
-rw-r--r-- 1 hjb2722404 hjb2722404    4 Aug  9 15:46 dev6.txt
drwxr-xr-x 1 hjb2722404 hjb2722404 4096 Aug  9 15:46 fisrtdir/
-rw-r--r-- 1 hjb2722404 hjb2722404    4 Aug  9 16:25 new.txt  // 说明远程仓库的`dev4`已经合并到本地`dev4`上
```



现在，我们在`ubuntu`主机的`dev4`上切出一个新分支`dev7`，然后做几次提交：

```bash
$ git checkout -b dev7
$ echo '1' >> dev7.txt
$ git commit -m "dev7 v1"
*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: empty ident name (for <hjb2722404@DESKTOP-RG3539D.localdomain>) not allowed
```

这里，进行提交时提示我们配置当前用户的邮箱和用户名，因为`commit`对象里需要记录`author`和`commiter`.

我们配置一下继续提交：

```bash
$ git config --local user.email "391655435@qq.com"
$ git config --local user.name "huluwa"
$ git commit -m "dev7 v1"
[dev7 af00d0b] dev7 v1
 1 file changed, 1 insertion(+)
 create mode 100644 dev7.txt
 $ git cat-file -p af00d0b
tree f627f2820d5beb8d28b439c5deca0d4473fc0dbf
parent b0724fe0685e60cd678972ad617639aa9c5d2d2c
author huluwa <391655435@qq.com> 1628498152 +0800
committer huluwa <391655435@qq.com> 1628498152 +0800

dev7 v1
 
```

提交完我们看了下生成的提交对象，作者和提交者都是 `huluwa`

我们再提交一次：

```bash
$ echo '2' >> dev7.txt
$ git add .
$ git commit -m "dev7 v2"
[dev7 aa6d997] dev7 v2
 1 file changed, 1 insertion(+)
 
 $ git cat-file -p aa6d997
tree db6c9e02fe57878f0ba6b98fa277cfedd3740d65
parent af00d0b7c68407b4d751d72d810644b839cfb28e
author huluwa <391655435@qq.com> 1628498433 +0800
committer huluwa <391655435@qq.com> 1628498433 +0800

dev7 v2
```



现在，我们把换个分支推送到远程分支去：

```bash
$ git push origin dev7
```

现在看看远程仓库：

![image-20210809164321280](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210809164321.png)

现在，我们回到`windows`主机，将`dev7`的两次提交合并为一次提交：

```bash
$ git checkout dev7
error: pathspec 'dev7' did not match any file(s) known to git

```

提示没有找到`dev7`分支， 这是因为本地还没有`dev7`，必须先通过`git fetch`从远程仓库拉取：

```bash
$ git fetch
$ git checkout dev7
Switched to a new branch 'dev7'
Branch 'dev7' set up to track remote branch 'dev7' from 'origin'.
$ git log -3
commit aa6d997d9b785136b468465d593ebe829324340e (HEAD -> dev7, origin/dev7)
Author: huluwa <391655435@qq.com>
Date:   Mon Aug 9 16:40:33 2021 +0800

    dev7 v2

commit af00d0b7c68407b4d751d72d810644b839cfb28e
Author: huluwa <391655435@qq.com>
Date:   Mon Aug 9 16:35:52 2021 +0800

    dev7 v1

commit b0724fe0685e60cd678972ad617639aa9c5d2d2c (origin/dev4, dev4)
Author: 何建博 <hjb2722404@163.com>
Date:   Mon Aug 9 16:21:48 2021 +0800

    new

```

`fetch`后，我们成功切换到了`dev7`，现在看`dev7`的提交历史，我们接下来把`dev7 v1`与`dev7 v2`合并成一条记录：

```bash
$ git rebase -i b0724fe

```

执行后打开了默认的`vi`编辑器：

```bash
pick af00d0b dev7 v1
pick aa6d997 dev7 v2

# Rebase b0724fe..aa6d997 onto b0724fe (2 commands)
#
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup <commit> = like "squash", but discard this commit's log message
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       create a merge commit using the original merge commit's
# .       message (or the oneline, if no original merge commit was
# .       specified). Use -c <commit> to reword the commit message.
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out

```

这里列出了我们指定的提交(`b0724fe`)之后的所有提交（实际上就是我们要合并为一条的两个提交），并且提示了操作说明：

每一行第一个单词代表要对这一行的这次提交做的操作：

* `pick`：保留该提交，缩写为`p`；
* `reword`：保留该提交，但我需要修改该提交的提交信息；缩写`r`;
* `edit`：保留该提交，但我要停下来修改该提交（包括提交内容和提交说明），缩写`e`
* `squash`：将该提交和前一个提交合并，缩写`s`
* `fixup`：将该提交和前一个提交合并，但不保留该提交的提交说明，缩写`f`
* `exec`： 执行`shell`命令，缩写`x`
* `drop`： 我要丢弃该提交，缩写`d`

根据我们的需求，我们修改如下：

```bash
pick af00d0b dev7 v1
s aa6d997 dev7 v2

#……
```

按`:wq`保存，然后来到提交说明修改界面：

```bash
# This is a combination of 2 commits.
# This is the 1st commit message:

dev7 v1

# This is the commit message #2:

dev7 v2

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Author:    huluwa <391655435@qq.com>
# Date:      Mon Aug 9 16:35:52 2021 +0800
#
# interactive rebase in progress; onto b0724fe
# Last commands done (2 commands done):
#    pick af00d0b dev7 v1
#    squash aa6d997 dev7 v2
# No commands remaining.
# You are currently rebasing branch 'dev7' on 'b0724fe'.
#
# Changes to be committed:
#       new file:   dev7.txt

```

我们将其修改为如下：

```bash
# This is a combination of 2 commits.
# This is the 1st commit message:

new on dev7

# This is the commit message #2:
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Author:    huluwa <391655435@qq.com>
# Date:      Mon Aug 9 16:35:52 2021 +0800
#
# interactive rebase in progress; onto b0724fe
# Last commands done (2 commands done):
#    pick af00d0b dev7 v1
#    squash aa6d997 dev7 v2
# No commands remaining.
# You are currently rebasing branch 'dev7' on 'b0724fe'.
#
# Changes to be committed:
#       new file:   dev7.txt

```



然后保存退出。

```bash
$ git rebase -i b0724fe
[detached HEAD 0ffdc30] new on dev7
 Author: huluwa <391655435@qq.com>
 Date: Mon Aug 9 16:35:52 2021 +0800
 1 file changed, 2 insertions(+)
 create mode 100644 dev7.txt
Successfully rebased and updated refs/heads/dev7.

$ git log -3
commit 0ffdc303e673c25cc686ebecf0dc66ca24809fb5 (HEAD -> dev7)
Author: huluwa <391655435@qq.com>
Date:   Mon Aug 9 16:35:52 2021 +0800

    new on dev7

commit b0724fe0685e60cd678972ad617639aa9c5d2d2c (origin/dev4, dev4)
Author: 何建博 <hjb2722404@163.com>
Date:   Mon Aug 9 16:21:48 2021 +0800

    new

commit 3d9cb7e51fbaa6a3192d83fb6a24d4f97b0b48ca (tag: v2.0.0)
Author: 何建博 <hjb2722404@163.com>
Date:   Thu Aug 5 17:24:43 2021 +0800

    from tag
    
$ git cat-file -p 0ffdc30
tree db6c9e02fe57878f0ba6b98fa277cfedd3740d65
parent b0724fe0685e60cd678972ad617639aa9c5d2d2c
author huluwa <391655435@qq.com> 1628498152 +0800
committer 何建博 <hjb2722404@163.com> 1628499758 +0800

new on dev7

```

可以看到，修改后，原来的两个提交不见了，变成一个新的提交了，

并且可以看到，新生成的提交，作者仍旧是合并前两个提交的作者`huluwa`，而提交者却已经变成了进行`rebase`操作的人(`何建博`)。

**结论22：`git rebase` 新生成的提交，作者是源提交的作者，提交者将变成执行`rebase`操作的人**

### 总结 <a id="zongjie"> </a>

以上，我们通过实时追踪Git仓库内部文件的变化，演示了大多数常用Git命令的原理，在这个过程中还发现了一些以前不曾注意到的特性。

现在，我们来对以上学习的成果做个总结：

#### 0. 核心——快照和指针

快照是Git版本库的核心：

* 一个快照实际上就是一个存储着特定对象的二进制文件，它的文件名就是使用SHA-1算法对它的内容计算后的SHA值。
* 有四种快照：
  * 文件快照：一个存储着`Blob`对象的二进制文件，当项目中一个被`git add`过的文件每次发生变化时，就会生成一个新的文件快照，里面存储着这个文件在最后一次被`git add`时的内容和状态（文件类型等元信息）。
  * 目录快照：一个存储着`tree`对象的二进制文件，当在项目里`git commit`时，会将每个目录的结构生成一个目录快照，快照里的`tree`对象存储着自己的子目录的快照的SHA值和目录内文件的SHA值。
  * 提交快照：一个存储着`commit`对象的二进制文件，当在项目里进行提交操作时，会生成一个提交快照，这个快照的`commit`对象里存储着项目最顶级目录快照的SHA值，以及本次提交所涉及的内容变动的作者，本次提交的提交者，本次提交的提交时间，和提交者对本次提交所做的提交说明等信息，以下名令会进行提交操作
    * `git commit`
    * `git merge`的非快速前进模式（`--no-ff`）
    * `git rebase`
    * `git cherry-pick`
  * 标签快照：一个存储着`tag`对象的二进制文件，当在项目里使用`git tag -a`新建【附注标签】时，会生成一个标签快照，这个标签快照的`tag`对象里存储着`tag`所指向的对象（一般为`commit`对象）的SHA值和类型，标签的名称，打标签的人的信息和时间，以及标签说明等信息。

指针，是一个记录着内部路径引用和内部快照SHA值的特殊文件：

* 我们所说的分支就是一个指针，它存储着该分支上最近一次的提交快照的SHA值
* 我们所说的`HEAD`也是一个指针，在非游离状态，它存储着当前分支指针的文件路径，在游离状态，它存储着当前所处的快照对象的SHA值
* 我们所说的`tag`也是一个指针， 对于轻量标签，它存储着打标签时所在的那个提交快照的SHA值，对于附注标签，它存储着一个`tag`对象的SHA值，这个`tag`对象里存储着打标签时所在的那个提交快照的SHA值。
* 我们所说的`stash`，也是一个指针，它存储着我们进行`git stash`操作时，Git针对当前工作区和暂存区以及前一次提交所做的一个新的提交快照的SHA值。

#### 1. 四个空间

在Git中，一共有四种空间：

* 工作目录。这是我们实际编辑文件的地方。
* 本地仓库。这是Git存储快照与各种指针的地方。
* 暂存区。 这是Git用来存储索引文件的地方，索引文件记录的是自上次提交后，当前工作目录已修改并`git add`的文件与其对应的`blob`对象之间的映射关系。
* 远程仓库。一个远端服务器上的一片存储空间，用来进行多人协作的地方。

#### 2. 三种状态

* 未暂存。 文件的全部或部分内容存在于工作目录中，但暂存区尚未对其进行索引。
  * 未跟踪：新添加的文件，从来没有向暂存区添加过
  * 已跟踪：已经向暂存区添加过的文件
* 待提交。暂存区已对其索引，并建立快照，但是本地仓库中尚不存在其对应的提交对象和提交记录。
* 已提交。本地仓库已经建立了其对应的提交对象和提交记录。

用一张图来描述空间、文件状态、快照、指针等之间的关系：

![image-20210810110541446](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210810110541.png)

#### 3. 若干个结论：

* Git无法跟踪空目录
* `git status` 显示的状态信息中的变化类型是相对于上一次暂存区更新时文件的状态的。
* 对于一个文件，每次重新被添加到暂存区时，都会将当时那个状态的文件内容做一次全文快照（SHA-1计算），并保存为二进制的`blob`对象——Git的版本库保存的是每次变化后的全文快照，而非增量内容。
* 对于一个文件，当其内容改变并被重新添加到暂存区时，暂存区会更新它与`.git/objects`目录下所对应的最新文件快照的映射关系。
* 在没有进行`git`暂存区或提交操作前，单纯对工作目录的文件进行增删改操作，只会影响`git status`的输出，不会影响暂存区和本地仓库的内容
* `git add`实际上执行了两个操作：1.建立最新的文件快照；2.更新暂存区索引
* 如果两个文件的内容一模一样，无论它们的路径和文件名是否一样，在Git本地仓库里，它们共享同一个文件快照。
* `git status` 反映的是执行命令时所在工作目录文件的变化，其输出信息中的文件路径是相对于执行命令时的目录的。
* Git提交不会改变暂存区的内容
* Git提交的作者和提交者之间的差别是：作者指的是实际作出修改的人，提交者指的是最后将此工作成果提交到仓库的人
* Git的每次提交，都会根据本次提交与上次提交的不同，生成新的目录快照（`tree`对象）和提交快照（`commit`对象），并更新日志目录里的操作记录和对应分支的操作记录
* `git diff`默认不带参数执行时， 对比暂存区快照与工作目录中文件内容的差异
*  `git mv` 更改工作目录中文件的文件名，并将暂存区中对应的文件名使用修改后的名称进行替换，执行此操作后不用`git add`就可以直接提交
*  Git新建分支其实就是新建了一个引用指针而已，这个指针存储了新建分支时所在那个分支当时所指向的提交快照的SHA值
*  Git分支合并时的ff 模式（快速前进模式）只有在顺着一个分支走下去可以到达另一个分支时才会选用
*  Git合并的非快速模式会在合入分支上新建一个提交快照，该提交快照包含并合并了两个分支所指向的提交快照。而快速前进模式则是直接将合入分支的指针指向被合入分支所指向的提交快照上。
*  Git合并的快速前进模式无法如实反映分支历史。所以建议除非有特殊需求，否则始终使用非快速前进模式。
*  Git在向远程仓库推送时，会压缩本地仓库，将全文快照格式转换为增量快照格式。
*  当我们从一个源分支上切出一个新分支，然后在新分支上进行若干次提交而源分支不做任何提交后，此时将新分支衍合（即`rebase`）到源分支，其效果是和`git merge`的快速前进模式（`--ff`）是一样的
*  `git rebase`操作实际上是
	 1. 从当前分支上，找到与目标分支的【共同祖先提交快照】之后的那次提交快照
	 2. 从那次提交快照开始，把之后的所有提交挨个提取出来
	 3. 在目标分支的最新提交基础上将提取出来的提交挨个再重做一次
	 4. 将当前分支指向目标分支重做后的最后一个提交。
*  可以在自己的分支之间进行衍合（`rebase`）操作，但不要在自己的分支与其他人的分支（包括所有远程分支）之间进行衍合操作，因为会造成分支线和时间线混乱，
*  `git cherry-pick`与`git rebase`一样，无法在提交历史图谱里体现哪些提交是从哪个分支复制过来的
*  `git stash`对未加入暂存区的文件，只会存入那些已跟踪的，而不会存入未跟踪的
*  【轻量标签】和【附注标签】的区别：
	* 轻量标签只是一个指向提交对象的指针，不生成任何对象
	* 附注标签会生成一个标签对象来存储标签信息，标签指针指向这个标签对象。
	* 除非我们手动推送，否则本地仓库的分支和标签都不会自动同步到远程仓库去
	* 我们在哪个分支上执行的`git fetch`，那么默认`git pull` 时就会对哪个分支执行合并操作
	* `git rebase` 新生成的提交，作者是源提交的作者，提交者将变成执行`rebase`操作的人


## 参考

[^1]:  [SCCS](https://zhuanlan.zhihu.com/p/95179354)

[^2]:  [git merge 原理（递归三路合并算法）](https://www.jianshu.com/p/e8932999fe1f)
[^3]: [**关于 git 提示 “warning: LF will be replaced by CRLF” 终极解答**](https://www.jianshu.com/p/450cd21b36a4)
[^4]: [**git 格式的 diff 输出内容含义**](https://blog.csdn.net/qq_27965129/article/details/52923383)

[^5]: [**git-merge 完全解析**](https://www.jianshu.com/p/58a166f24c81)



