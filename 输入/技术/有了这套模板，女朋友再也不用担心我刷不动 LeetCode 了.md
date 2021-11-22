有了这套模板，女朋友再也不用担心我刷不动 LeetCode 了

##  有了这套模板，女朋友再也不用担心我刷不动 LeetCode 了

 原创   李威     [五分钟学算法](有了这套模板，女朋友再也不用担心我刷不动%20LeetCode%20了.md#)    *2019-10-12*

点击蓝色“五分钟学算法”关注我哟
加个“星标”，天天中午 12:15，一起学算法
![640](../_resources/95388a8270691fb4d1d75509f647c712.jpg)
作者 | 李威
来源 | https://www.liwei.party/
整理 | 五分钟学算法
全文包含 **12000+** 字、**30** 张高清图片，预计阅读时间为 **40** 分钟，强烈建议先**收藏**再仔细阅读。

正文

下面的动画以 「力扣」第 704 题：二分查找 为例，展示了使用这个模板编写二分查找法的一般流程。
![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131545.gif)
binary-search-template-new.gif
以下“演示文稿”展示了本文所要讲解的主要内容，您可以只看这部分的内容，如果您还想看得更仔细一点，可以查看“演示文稿”之后的原文。

### 《十分好用的二分查找法模板》演示文稿

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131550.jpg)
binary-search-template-1.png

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131602.jpg)
binary-search-template-2.png

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131609.jpg)
binary-search-template-3.png

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131616.jpg)
binary-search-template-4.png

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131624.jpg)
binary-search-template-5.png

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131632.jpg)
binary-search-template-6.png

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131636.jpg)
binary-search-template-7.png

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131641.jpg)
binary-search-template-8.png

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131650.jpg)
binary-search-template-9.png

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131656.jpg)
binary-search-template-10.png

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131700.jpg)
binary-search-template-11.png

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131704.jpg)
binary-search-template-12.png

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131708.jpg)
binary-search-template-13.png
**（上面的“演示文稿”是对以下文字的概括。）**

### 1、导读

本文介绍了我这半年以来，在刷题过程中使用“二分查找法”刷题的一个模板，包括这个模板的优点、使用技巧、注意事项、调试方法等。

虽说是模板，但我不打算一开始就贴出代码，因为这个模板根本没有必要记忆，只要你能够理解文中叙述的知识点和注意事项，并加以应用（刷题），相信你会和我一样喜欢这个模板，并且认为使用它是自然而然的事情。

这个模板应该能够帮助你解决 LeetCode 带“二分查找”标签的常见问题（简单、中等难度）。
只要你能够理解文中叙述的知识点和注意事项，并加以应用（其实就是多刷题），相信你会和我一样喜欢这个模板，并且认为使用它是**自然而然**的事情。

### 2、历史上有关“二分查找法”的故事

二分查找法虽然简单，但写好它并没有那么容易。我们可以看看一些名人关于二分查找法的论述。

- 算法和程序设计技术的先驱 Donald Ervin Knuth（中文名：高德纳）：

> Although the basic idea of binary search is comparatively straightforward, the details can be surprisingly tricky …

译：“虽然二分查找的基本思想相对简单，但细节可能会非常棘手”。来自维基百科 Binary_search_algorithm，请原谅本人可能非常不优雅的中文翻译。

- 同样是高德纳先生，在其著作《计算机程序设计的艺术 第 3 卷：排序和查找》中指出：

> 二分查找法的思想在 1946 年就被提出来了。但是第 1 个没有 Bug 的二分查找法在 1962 年才出现。
（因时间和个人能力的关系，我没有办法提供英文原文，如果能找到英文原文的朋友欢迎提供一下出处，在此先谢过。）
据说这个 Bug 在 Java 的 JDK 中都隐藏了将近 10 年以后，才被人们发现并修复。

- 《编程珠玑》的作者 Jon Bentley：

> When Jon Bentley assigned binary search as a problem in a course for professional programmers, he found that ninety percent failed to provide a correct solution after several hours of working on it, mainly because the incorrect implementations failed to run or returned a wrong answer in rare edge cases.

译：当 JonBentley 把二分查找作为专业程序员课程中的一个问题时，他发现百分之九十的人在花了几个小时的时间研究之后，没有提供正确的解决方案，主要是因为错误的实现无法正确运行（笔者注：可能返回错误的结果，或者出现死循环），或者是不能很好地判断边界条件。

### 3、“传统的”二分查找法模板的问题

**（1）取中位数索引的代码有问题**
`int mid = (left + right) / 2 [[NEWLINE]]`

这行代码是有问题的，在 `left` 和 `right` 都比较大的时候，`left + right` 很有可能超过 int 类型能表示的最大值，即整型溢出，为了避免这个问题，应该写成：

`int mid = left + (right - left) / 2 ;[[NEWLINE]]`

事实上，`int mid = left + (right - left) / 2`  在 `right` 很大、 `left` 是负数且很小的时候， `right - left` 也有可能超过 `int` 类型能表示的最大值，只不过一般情况下 `left` 和 `right` 表示的是数组索引值，`left` 是非负数，因此  `right - left`  溢出的可能性很小。

更好的写法是：
`int mid = (left + right) >>> 1 ;[[NEWLINE]]`
原因在后文介绍，请读者留意：
**> 使用“左边界索引 + 右边界索引”，然后“无符号右移 1 位”是推荐的写法。**

**（2）循环可以进行的条件写成 `while (left <= right)` 时，在退出循环的时候，需要考虑返回 `left` 还是 `right`，稍不注意，就容易出错**

以本题（LeetCode 第 35 题：搜索插入位置）为例。
分析：根据题意并结合题目给出的 4 个示例，不难分析出这个问题的等价表述如下：
> 1、如果目标值（严格）大于排序数组的最后一个数，返回这个排序数组的长度，否则进入第 2 点。
> 2、返回排序数组从左到右，大于或者等于目标值的第 1 个数的**> 索引**> 。

事实上，当给出数组中有很多数和目标值相等的时候，我们返回任意一个与之相等的数的索引值都可以，不过为了简单起见，也为了方便后面的说明，我们返回第 1 个符合题意的数的索引。

题目告诉你“排序数组”，其实就是在**疯狂暗示你用二分查找法**。二分查找法的思想并不难，但写好一个二分法并不简单，下面就借着这道题为大家做一个总结。
刚接触二分查找法的时候，我们可能会像下面这样写代码，我把这种写法容易出错的地方写在了注释里：
**参考代码**：针对本题（LeetCode 第 35 题）

`public class Solution3 {[[NEWLINE]][[NEWLINE]]    public int searchInsert(int[] nums, int target) {[[NEWLINE]]        int len = nums.length;[[NEWLINE]]        if (nums[len - 1] < target) {[[NEWLINE]]            return len;[[NEWLINE]]        }[[NEWLINE]][[NEWLINE]]        int left = 0;[[NEWLINE]]        int right = len - 1;[[NEWLINE]][[NEWLINE]]        while (left <= right) {[[NEWLINE]]            int mid = (left + right) / 2;[[NEWLINE]]            // 等于的情况最简单，我们应该放在第 1 个分支进行判断[[NEWLINE]]            if (nums[mid] == target) {[[NEWLINE]]                return mid;[[NEWLINE]]            } else if (nums[mid] < target) {[[NEWLINE]]                // 题目要我们返回大于或者等于目标值的第 1 个数的索引[[NEWLINE]]                // 此时 mid 一定不是所求的左边界，[[NEWLINE]]                // 此时左边界更新为 mid + 1[[NEWLINE]]                left = mid + 1;[[NEWLINE]]            } else {[[NEWLINE]]                // 既然不会等于，此时 nums[mid] > target[[NEWLINE]]                // mid 也一定不是所求的右边界[[NEWLINE]]                // 此时右边界更新为 mid - 1[[NEWLINE]]                right = mid - 1;[[NEWLINE]]            }[[NEWLINE]]        }[[NEWLINE]]        // 注意：一定得返回左边界 left，[[NEWLINE]]        // 如果返回右边界 right 提交代码不会通过[[NEWLINE]]        // 【注意】下面我尝试说明一下理由，如果你不太理解下面我说的，那是我表达的问题[[NEWLINE]]        // 但我建议你不要纠结这个问题，因为我将要介绍的二分查找法模板，可以避免对返回 left 和 right 的讨论[[NEWLINE]][[NEWLINE]]        // 理由是对于 [1,3,5,6]，target = 2，返回大于等于 target 的第 1 个数的索引，此时应该返回 1[[NEWLINE]]        // 在上面的 while (left <= right) 退出循环以后，right < left，right = 0 ，left = 1[[NEWLINE]]        // 根据题意应该返回 left，[[NEWLINE]]        // 如果题目要求你返回小于等于 target 的所有数里最大的那个索引值，应该返回 right[[NEWLINE]][[NEWLINE]]        return left;[[NEWLINE]]    }[[NEWLINE]]}[[NEWLINE]]`

**说明**：

1、当把二分查找法的循环可以进行的条件写成 `while (left <= right)` 时，在写最后一句 `return` 的时候，如果不假思索，把左边界 `left` 返回回去，虽然写对了，但可以思考一下为什么不返回右边界 `right` 呢？

2、但是事实上，返回 `left` 是有一定道理的，如果题目换一种问法，你可能就要返回右边界 `right`，这句话不太理解没有关系，我也不打算讲得很清楚（在上面代码的注释中我已经解释了原因），因为实在太绕了，这不是我要说的重点。

由此，我认为“传统二分查找法模板”使用的痛点在于：
> 传统二分查找法模板，当退出 `while`>  循环的时候，在返回左边界还是右边界这个问题上，比较容易出错。
那么，是不是可以回避这个问题呢？答案是肯定的，答案就在下面我要介绍的“神奇的”二分查找法模板里。

### 4、“神奇的”二分查找法模板的基本思想

**（1）首先把循环可以进行的条件写成 `while(left < right)`，在退出循环的时候，一定有 `left == right` 成立，此时返回 `left` 或者 `right` 都可以**

或许你会问：退出循环的时候还有一个数没有看啊（退出循环之前索引 left 或 索引 right 上的值）？
没有关系，我们就等到退出循环以后来看，甚至经过分析，有时都不用看，就能确定它是目标数值。
（什么时候需要看最后剩下的那个数，什么时候不需要，会在第 5 点介绍。）
更深层次的思想是“夹逼法”或者称为“排除法”。
**（2）“神奇的”二分查找法模板的基本思想（特别重要）**

**> “排除法”即：在每一轮循环中排除一半以上的元素，于是在对数级别的时间复杂度内，就可以把区间“夹逼” 只剩下 1 个数，而这个数是不是我们要找的数，单独做一次判断就可以了。**

“夹逼法”或者“排除法”是二分查找算法的基本思想，“二分”是手段，在目标元素不确定的情况下，“二分” 也是“最大熵原理”告诉我们的选择。

还是 LeetCode 第 35 题，下面给出使用 `while (left < right)` 模板写法的 2 段参考代码，以下代码的细节部分在后文中会讲到，因此一些地方不太明白没有关系，暂时跳过即可。

**参考代码 1**：重点理解为什么候选区间的索引范围是 `[0, size]`。

`public class Solution {[[NEWLINE]][[NEWLINE]]    public int searchInsert(int[] nums, int target) {[[NEWLINE]]        # 返回大于等于 target 的索引，有可能是最后一个[[NEWLINE]]        int len = nums.length;[[NEWLINE]][[NEWLINE]]        if (len == 0) {[[NEWLINE]]            return 0;[[NEWLINE]]        }[[NEWLINE]][[NEWLINE]]        int left = 0;[[NEWLINE]]        # 如果 target 比 nums里所有的数都大，则最后一个数的索引 + 1 就是候选值，因此，右边界应该是数组的长度[[NEWLINE]]        int right = len;[[NEWLINE]]         # 二分的逻辑一定要写对，否则会出现死循环或者数组下标越界[[NEWLINE]]        while (left < right) {[[NEWLINE]]            int mid = left + (right - left) / 2;[[NEWLINE]]            if (nums[mid] < target) {[[NEWLINE]]                left = mid + 1;[[NEWLINE]]            } else {[[NEWLINE]]                right = mid;[[NEWLINE]]            }[[NEWLINE]]        }[[NEWLINE]]        return left;[[NEWLINE]]    }[[NEWLINE]]}[[NEWLINE]]`

**参考代码 2**：对于是否接在原有序数组后面单独判断，不满足的时候，再在候选区间的索引范围 `[0, size - 1]` 内使用二分查找法进行搜索。

`public class Solution {[[NEWLINE]][[NEWLINE]]    // 只会把比自己大的覆盖成小的[[NEWLINE]]    // 二分法[[NEWLINE]]    // 如果有一连串数跟 target 相同，则返回索引最靠前的[[NEWLINE]][[NEWLINE]]    // 特例：3 5 5 5 5 5 5 5 5 5[[NEWLINE]]    // 特例：3 6 7 8[[NEWLINE]][[NEWLINE]]    // System.out.println("尝试过的值：" + mid);[[NEWLINE]]    // 1 2 3 5 5 5 5 5 5 6 ，target = 5[[NEWLINE]]    // 1 2 3 3 5 5 5 6 target = 4[[NEWLINE]][[NEWLINE]][[NEWLINE]]    public int searchInsert(int[] nums, int target) {[[NEWLINE]]        int len = nums.length;[[NEWLINE]]        if (len == 0) {[[NEWLINE]]            return -1;[[NEWLINE]]        }[[NEWLINE]]        if (nums[len - 1] < target) {[[NEWLINE]]            return len;[[NEWLINE]]        }[[NEWLINE]]        int left = 0;[[NEWLINE]]        int right = len - 1;[[NEWLINE]]        while (left < right) {[[NEWLINE]]            int mid = left + (right - left) / 2;[[NEWLINE]]            if (nums[mid] < target) {[[NEWLINE]]                // nums[mid] 的值可以舍弃[[NEWLINE]]                left = mid + 1;[[NEWLINE]]            } else {[[NEWLINE]]                // nums[mid] 不能舍弃[[NEWLINE]]                right = mid;[[NEWLINE]]            }[[NEWLINE]]        }[[NEWLINE]]        return right;[[NEWLINE]]    }[[NEWLINE]][[NEWLINE]]    public static void main(String[] args) {[[NEWLINE]]        int[] nums = {1, 2, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6};[[NEWLINE]]        int target = 4;[[NEWLINE]]        Solution2 solution2 = new Solution2();[[NEWLINE]]        int searchInsert = solution2.searchInsert(nums, target);[[NEWLINE]]        System.out.println(searchInsert);[[NEWLINE]]    }[[NEWLINE]]}[[NEWLINE]]`

### 5、细节、注意事项、调试方法

#### （1）前提：思考左、右边界，如果左、右边界不包括目标数值，会导致错误结果

例：LeetCode 第 69 题：x 的平方根
> 实现 `int sqrt(int x)`>  函数。
> 计算并返回 x 的平方根，其中 x 是非负整数。
> 由于返回类型是整数，结果只保留整数的部分，小数部分将被舍去。
分析：一个非负整数的平方根最小可能是 0 ，最大可能是它自己。
因此左边界可以取 0 ，右边界可以取 x。
可以分析得再细一点，但这道题没有必要，因为二分查找法会帮你排除掉不符合的区间元素。
例：LeetCode 第 287 题：寻找重复数

> 给定一个包含 n + 1 个整数的数组 nums，其数字都在 1 到 n 之间（包括 1 和 n），可知至少存在一个重复的整数。假设只有一个重复的整数，找出这个重复的数。

分析：题目告诉我们“其数字都在 1 到 n 之间（包括 1 和 n）”。因此左边界可以取 1 ，右边界可以取 n。
**要注意 2 点**：

- 如果 `left` 和 `right` 表示的是数组的索引，就要考虑“索引是否有效” ，即“索引是否越界” 是重要的定界依据；
- 左右边界一定要包括目标元素，例如 LeetCode 第 35 题：“搜索插入位置” ，当 `target` 比数组中的最后一个数字还要大（不能等于）的时候，插入元素的位置就是数组的最后一个位置 + 1，即 `(len - 1 + 1 =) len`，如果忽略掉这一点，把右边界定为 `len - 1` ，代码就不能通过在线测评。

#### （2）中位数先写 `int mid = (left + right) >>> 1 ;` 根据循环里分支的编写情况，再做调整

理解这一点，首先要知道：当数组的元素个数是偶数的时候，中位数有左中位数和右中位数之分。

- 当数组的元素个数是偶数的时候：

使用 `int mid = left + (right - left) / 2 ;`  得到左中位数的索引；
使用 `int mid = left + (right - left + 1) / 2 ;`  得到右中位数的索引。

- 当数组的元素个数是奇数的时候，以上二者都能选到最中间的那个中位数。

其次，
`int mid = left + (right - left) / 2 ;[[NEWLINE]]`

等价于
`int mid = (left + right) >>> 1;[[NEWLINE]]`
而
`int mid = left + (right - left + 1) / 2 ;[[NEWLINE]]`

等价于
`int mid = (left + right + 1) >>> 1 [[NEWLINE]]`
我们使用一个具体的例子来验证：当左边界索引 `left = 3`，右边界索引 `right = 4` 的时候，

`mid1 = left + (right - left) // 2 = 3 + (4 - 3) // 2 = 3 + 0 = 3[[NEWLINE]]mid2 = left + (right - left + 1) // 2 = 3 + (4 - 3 + 1) // 2 = 3 + 1 = 4[[NEWLINE]]`

左中位数 `mid1` 是索引 `left`，右中位数 `mid2` 是索引 `right`。
**记忆方法**：
**`(right - left)`>  不加 > 1>  选左中位数，加 > 1>  选右中位数**> 。
那么，什么时候使用左中位数，什么时候使用右中位数呢？选中位数的依据是为了避免死循环，得根据分支的逻辑来选择中位数，而分支逻辑的编写也有技巧，下面具体说。

#### （3）先写逻辑上容易想到的分支逻辑，这个分支逻辑通常是排除中位数的逻辑；

在逻辑上，“可能是也有可能不是”让我们感到犹豫不定，但**“一定不是”是我们非常坚决的，通常考虑的因素特别单一，因此“好想” **。在生活中，我们经常听到这样的话：找对象时，“有车、有房，可以考虑，但没有一定不要”；找工作时，“事儿少、离家近可以考虑，但是钱少一定不去”，就是这种思想的体现。

例：LeetCode 第 69 题：x 的平方根
> 实现 `int sqrt(int x)`>  函数。
> 计算并返回 x 的平方根，其中 x 是非负整数。
> 由于返回类型是整数，结果只保留整数的部分，小数部分将被舍去。

分析：因为题目中说“返回类型是整数，结果只保留整数的部分，小数部分将被舍去”。例如 5 的平方根约等于 2.236，在这道题应该返回 2。因此如果一个数的平方小于或者等于 x，那么这个数有可能是也有可能不是 x 的平方根，但是能很肯定的是，如果一个数的平方大于 x ，这个数肯定不是 x 的平方根。

注意：先写“好想”的分支，排除了中位数之后，通常另一个分支就不排除中位数，而不必具体考虑另一个分支的逻辑的具体意义，且代码几乎是固定的。

#### （4）循环内只写两个分支，一个分支排除中位数，另一个分支不排除中位数，循环中不单独对中位数作判断

既然是“夹逼”法，没有必要在每一轮循环开始前单独判断当前中位数是否是目标元素，因此分支数少了一支，代码执行效率更高。
以下是“排除中位数的逻辑”思考清楚以后，可能出现的两个模板代码。
![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131721.jpg)
二分查找法模板
可以排除“中位数”的逻辑，通常比较好想，但并不绝对，这一点视情况而定。
分支条数变成 2 条，比原来 3 个分支要考虑的情况少，好处是：

**> 不用在每次循环开始单独考虑中位数是否是目标元素，节约了时间**> ，我们只要在退出循环的时候，即左右区间压缩成一个数（索引）的时候，去判断这个索引表示的数是否是目标元素，而不必在二分的逻辑中单独做判断。

这一点很重要，希望读者结合具体练习仔细体会，**每次循环开始的时候都单独做一次判断，在统计意义上看，二分时候的中位数恰好是目标元素的概率并不高，并且即使要这么做，也不是普适性的，不能解决绝大部分的问题**。

还以 LeetCode 第 35 题为例，通过之前的分析，我们需要找到“大于或者等于目标值的第 1 个数的**索引**”。对于这道题而言：
（1）如果中位数小于目标值，它就应该被排除，左边界 `left` 就至少是 `mid + 1`；

（2）如果中位数大于等于目标值，还不能够肯定它就是我们要找的数，因为要找的是等于目标值的第 1 个数的**索引**，**中位数以及中位数的左边都有可能是符合题意的数**，因此右边界就不能把 `mid` 排除，因此右边界 `right` 至多是 `mid`，此时右边界不向左边收缩。

**下一点就更关键了**。

#### （5）根据分支逻辑选择中位数的类型，可能是左中位数，也可能是右位数，选择的标准是避免死循环

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131726.jpg)
造成死循环的代码
死循环容易发生在区间只有 2 个元素时候，此时中位数的选择尤为关键。**选择中位数的依据是**：避免出现死循环。我们需要确保：
（下面的这两条规则说起来很绕，可以暂时跳过）。
> 1、如果分支的逻辑，在选择左边界的时候，不能排除中位数，那么中位数就选“右中位数”，只有这样区间才会收缩，否则进入死循环；
> 2、同理，如果分支的逻辑，在选择右边界的时候，不能排除中位数，那么中位数就选“左中位数”，只有这样区间才会收缩，否则进入死循环。
理解上面的这个规则可以通过具体的例子。针对以上规则的第 1 点：如果分支的逻辑，在选择左边界的时候不能排除中位数，例如：
伪代码：

`while left < right:[[NEWLINE]]      # 不妨先写左中位数，看看你的分支会不会让你代码出现死循环，从而调整[[NEWLINE]]    mid = left + (right - left) // 2[[NEWLINE]]    # 业务逻辑代码[[NEWLINE]]    if (check(mid)):[[NEWLINE]]        # 选择右边界的时候，可以排除中位数[[NEWLINE]]        right = mid - 1[[NEWLINE]]    else:[[NEWLINE]]        # 选择左边界的时候，不能排除中位数[[NEWLINE]]        left = mid[[NEWLINE]]`

- **在区间中的元素只剩下 $2$ 个时候**，例如：`left = 3`，`right = 4`。此时**左中位数就是左边界**，如果你的逻辑执行到 `left = mid` 这个分支，**且你选择的中位数是左中位数，此时左边界就不会得到更新，区间就不会再收缩（理解这句话是关键），从而进入死循环**；
- 为了避免出现死循环，你需要选择中位数是右中位数，当逻辑执行到 `left = mid` 这个分支的时候，因为你选择了右中位数，让逻辑可以转而执行到 `right = mid - 1` 让区间收缩，最终成为 1 个数，退出 `while` 循环。

上面这段话不理解没有关系，因为我还没有举例子，你有个印象就好，类似地，理解选择中位数的依据的第 2 点。

#### （6）退出循环的时候，可能需要对“夹逼”剩下的那个数单独做一次判断，这一步称之为“后处理”。

二分查找法之所以高效，是因为它利用了数组有序的特点，在每一次的搜索过程中，都可以排除将近一半的数，**使得搜索区间越来越小，直到区间成为一个数**。回到这一节最开始的疑问：“区间左右边界相等（即收缩成 1 个数）时，这个数是否会漏掉”，解释如下：

1、**如果你的业务逻辑保证了你要找的数一定在左边界和右边界所表示的区间里出现**，那么可以放心地返回 `left` 或者 `right`，无需再做判断；

2、如果你的业务逻辑不能保证你要找的数一定在左边界和右边界所表示的区间里出现，那么只要在退出循环以后，再针对 `nums[left]` 或者 `nums[right]` （此时 `nums[left] == nums[right]`）单独作一次判断，看它是不是你要找的数即可，这一步操作常常叫做“后处理”。

- 如果你能确定候选区间里目标元素一定存在，则不必做“后处理”。

例：LeetCode 第 69 题：x 的平方根
> 实现 `int sqrt(int x)`>  函数。
> 计算并返回 x 的平方根，其中 x 是非负整数。
> 由于返回类型是整数，结果只保留整数的部分，小数部分将被舍去。

分析：非负实数 x 的平方根在 `[0, x]` 内一定存在，故退出 `while (left < right)` 循环以后，不必单独判断 `left` 或者 `right` 是否符合题意。

- 如果你不能确定候选区间里目标元素一定存在，需要单独做一次判断。

例：LeetCode 第 704 题：二分查找

> 给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target  ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1。

分析：因为目标数有可能不在数组中，当候选区间夹逼成一个数的时候，要单独判断一下这个数是不是目标数，如果不是，返回 -1。

#### （7）取中位数的时候，要避免在计算上出现整型溢出；

`int mid = (left + right) / 2;` 的问题：在 `left` 和 `right` 很大的时候，`left + right` 会发生整型溢出，变成负数，这是一个 bug ，得改！

`int mid = left + (right - left) / 2;` 在 `right` 很大、 `left` 是负数且很小的时候， `right - left` 也有可能超过 int 类型能表示的最大值，只不过一般情况下 `left` 和 `right` 表示的是数组索引值，`left` 是非负数，因此 `right - left` 溢出的可能性很小。因此，它是正确的写法。下面介绍推荐的写法。

`int mid = (left + right) >>> 1;`  **如果这样写， `left + right` 在发生整型溢出以后，会变成负数，此时如果除以 2 ，`mid` 是一个负数，但是经过无符号右移，可以得到在不溢出的情况下正确的结果**。

解释“无符号右移”：在 Java 中，无符号右移运算符 `>>>` 和右移运算符 `>>` 的区别如下：

- 右移运算符 `&gt;&gt;` 在右移时，丢弃右边指定位数，左边补上符号位；
- 无符号右移运算符 `&gt;&gt;&gt;` 在右移时，丢弃右边指定位数，左边补上 0，也就是说，对于正数来说，二者一样，而负数通过 `&gt;&gt;&gt;` 后能变成正数。

下面解释上面的模板中，取中位数的时候使用先用“＋”，然后“无符号右移”。

1、`int mid = (left + right) / 2` 与 `int mid = left + (right - left) / 2` 两种写法都有整型溢出的风险，没有哪一个是绝对安全的，注意：这里我们取平均值用的是除以 2，并且是整除：

- `int mid = (left + right) / 2` 在 `left` 和 `right` 都很大的时候会溢出；
- `int mid = left + (right - left) / 2` 在 `right` 很大，且 `left` 是负数且很小的时候会溢出；

2、写算法题的话，一般是让你在数组中做二分查找，因此 `left` 和 `right` 一般都表示数组的索引，因此 `left` 在绝大多数情况下不会是负数并且很小，因此使用  `int mid = left + (right - left) // 2`  相对 `int mid = (left + right) // 2` 更安全一些，并且也能向别人展示我们注意到了整型溢出这种情况，但事实上，还有更好的方式；

3、建议使用 `int mid = (left + right) >>> 1` 这种写法，其实是大有含义的：
> JDK8 中采用 `int mid = (left + right) >>> 1`>  ，重点不在 `+`>  ，而在 `>>>`>  。

我们看极端的情况，`left` 和 `high` 都是整型最大值的时候，注意，此时 32 位整型最大值它的二进制表示的最高位是 0，它们相加以后，最高位是 1 ，变成负数，但是再经过无符号右移 `>>>`（**重点是忽略了符号位**，空位都以 0 补齐），就能保证使用 `+` 在整型溢出了以后结果还是正确的。

Java 中 `Collections` 和 `Arrays` 提供的 `binarySearch` 方法，我们点进去看 `left` 和 `right` 都表示索引，使用无符号右移又不怕整型溢出，那就用 `int mid = (left + right) >>> 1`  好啦。位运算本来就比使用除法快，这样看来使用 `+` 和 `<<<` 真的是又快又好了。

我想这一点可能是 JDK8 的编写者们更层次的考量。
看来以后写算法题，就用  `int mid = (left + right) >>> 1` 吧，反正更多的时候 `left` 和 `right` 表示索引。

#### （8）编码一旦出现死循环，输出必要的变量值、分支逻辑是调试的重要方法。

当出现死循环的时候的调试方法：打印输出左右边界、中位数的值和目标值、分支逻辑等必要的信息。

按照我的经验，一开始编码的时候，稍不注意就很容易出现死循环，不过没有关系，你可以你的代码中写上一些输出语句，就容易理解“在区间元素只有 2 个的时候容易出现死循环”。

### 6、总结

总结一下，我爱用这个模板的原因、技巧、优点和注意事项：

#### （1）原因：

> 无脑地写 `while left < right:`>  ，这样你就不用判断，在退出循环的时候你应该返回 `left`>  还是 `right`> ，因为返回 `left`>  或者 `right`>  都对；

#### （2）技巧：

> 先写分支逻辑，并且先写排除中位数的逻辑分支（因为更多时候排除中位数的逻辑容易想，但是前面我也提到过，这并不绝对），另一个分支的逻辑你就不用想了，写出第 1 个分支的反面代码即可（下面的说明中有介绍），再根据分支的情况选择使用左中位数还是右中位数；

**说明**：这里再多说一句。如果从代码可读性角度来说，只要是你认为好想的逻辑分支，就把它写在前面，并且加上你的注释，这样方便别人理解，而另一个分支，你就不必考虑它的逻辑了。有的时候另一个分支的逻辑并不太好想，容易把自己绕进去。如果你练习做得多了，会形成条件反射。

我简单总结了一下，左右分支的规律就如下两点：

- 如果第 1 个分支的逻辑是“左边界排除中位数”（`left = mid + 1`），那么第 2 个分支的逻辑就一定是“右边界不排除中位数”（`right = mid`），反过来也成立；
- 如果第 2 个分支的逻辑是“右边界排除中位数”（`right = mid - 1`），那么第 2 个分支的逻辑就一定是“左边界不排除中位数”（`left = mid`），反之也成立。

“反过来也成立”的意思是：如果在你的逻辑中，“边界不能排除中位数”的逻辑好想，你就把它写在第 1 个分支，另一个分支是它的反面，你可以不用管逻辑是什么，按照上面的规律直接给出代码就可以了。能这么做的理论依据就是“排除法”。

#### （3）优点：

> 分支条数只有 2 条，代码执行效率更高，不用在每一轮循环中单独判断中位数是否符合题目要求，**> 写分支的逻辑的目的是尽量排除更多的候选元素**> ，而判断中位数是否符合题目要求我们放在最后进行，这就是第 5 点；

**说明**：每一轮循环开始都单独判断中位数是否符合要求，这个操作不是很有普适性，因为从统计意义上说，中位数直接就是你想找的数的概率并不大，有的时候还要看看左边，还要看看右边。不妨就把它放在最后来看，把候选区间“夹逼”到只剩 1 个元素的时候，视情况单独再做判断即可。

#### （4）注意事项 1：

> 左中位数还是右中位数选择的标准根据分支的逻辑而来，标准是每一次循环都应该让区间收缩，当候选区间只剩下 > 2>  个元素的时候，为了避免死循环发生，选择正确的中位数类型。如果你实在很晕，不防就使用有 > 2>  个元素的测试用例，就能明白其中的原因，另外在代码出现死循环的时候，建议你可以将左边界、右边界、你选择的中位数的值，还有分支逻辑都打印输出一下，出现死循环的原因就一目了然了；

#### （5）注意事项 2：

> 如果能确定要找的数就在候选区间里，那么退出循环的时候，区间最后收缩成为 > 1>  个数后，直接把这个数返回即可；如果你要找的数有可能不在候选区间里，区间最后收缩成为 > 1>  个数后，还要单独判断一下这个数是否符合题意。

最后给出两个模板，大家看的时候看注释，不必也无需记忆它们。
![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131741.jpg)
二分查找模板-1.png
![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131755.jpg)
二分查找模板-2.png

**说明**：我写的时候，一般是先默认将中位数写成左中位数，再根据分支的情况，看看是否有必要调整成右中位数，即是不是要在 `(right - left)` 这个括号里面加 1 。

**> 虽说是两个模板，区别在于选中位数，中位数根据分支逻辑来选，原则是区间要收缩，且不出现死循环，退出循环的时候，视情况，有可能需要对最后剩下的数单独做判断**> 。

我想我应该是成功地把你绕晕了，如果您觉得啰嗦的地方，就当我是“重要的事情说了三遍”吧，确实是重点的地方我才会重复说。
当然，最好的理解这个模板的方法还是应用它。

在此建议您不妨多做几道使用“二分查找法”解决的问题，用一下我说的这个模板，**在发现问题的过程中，体会这个模板好用的地方，相信你一定会和我一样爱上这个模板的**。

### 7、应用提升

这里给出一些练习题，这些练习题都可以使用这个“神奇的”二分查找法模板比较轻松地写出来，并且得到一个不错的分数，大家加油！
![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131807.png)
LeetCode 第 704 题

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131811.png)
LeetCode 第 69 题

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131816.png)
LeetCode 第 153 题

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131821.png)
LeetCode 第 154 题

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131826.png)
LeetCode 第 287
![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131835.png)
LeetCode 第 1095 题

![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131840.png)
LeetCode 第 658 题
![640](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20210107131844.png)
LeetCode 第 4 题

![640](../_resources/859063c763d83e4844bdcb74e8e08fab.gif)
****有热门推荐****

1.【程序员】[我们就必须承认：这个世界上，有很多问题，就是无解的](http://mp.weixin.qq.com/s?__biz=MzUyNjQxNjYyMg==&mid=2247486454&idx=1&sn=797f4eb0cc4a586b512d012ac52925cc&chksm=fa0e6477cd79ed618a6a7c895dad16a3d748b47f740e667a5365bea72ccd235db471093903f7&scene=21#wechat_redirect)

2.【GitHub】[我在 GitHub 上看到了一个丧心病狂的开源项目！](http://mp.weixin.qq.com/s?__biz=MzUyNjQxNjYyMg==&mid=2247486254&idx=1&sn=654c208601879fe1b76c682a069a4e6a&chksm=fa0e64afcd79edb960a9863c7af7e6de5893da2326e6eca2bcd9d68061966d200ba0e189ab91&scene=21#wechat_redirect)

3.【算法】[动画：七分钟理解什么是KMP算法](http://mp.weixin.qq.com/s?__biz=MzUyNjQxNjYyMg==&mid=2247485939&idx=1&sn=b25f39b5644da92c4047bbbd9936f73c&chksm=fa0e6672cd79ef64dda0a21e23c2817edf4a64cbb75b9bed328d6519c6cd4fef36d03a4cb309&scene=21#wechat_redirect)

4.【数据结构】[十大经典排序算法动画与解析，看我就够了！](http://mp.weixin.qq.com/s?__biz=MzUyNjQxNjYyMg==&mid=2247484184&idx=1&sn=62965b401aa42107b3c17d1d8ea17454&chksm=fa0e6c99cd79e58f298e9026f677f912bd8c8e55edb48fc509b2b5834f05e529a9b47d59d202&scene=21#wechat_redirect)

![640](../_resources/684be3126daac1d00a86e97321fd6a72.jpg)
▼ 点击**『阅读原文』**前往博客阅读更多文章

 [阅读原文](https://mp.weixin.qq.com/s/lPfR049hwgnpnIvC4LYF6g##)