angular-drag-and-drop-lists,使用HTML5拖拉&拖放API来排序嵌套列表的Angular 指令,下载angular-drag-and-drop-lists的源码_GitHub_酷徒

# angular-drag-and-drop-lists, 使用HTML5拖拉&拖放API来排序嵌套列表的Angular 指令

marmotz•分享于 18年01月22日
 •
15分钟阅读

[GitHub](https://www.kutu66.com/article/c/GitHub/51-0-0-0)

  •[繁體](https://hant.kutu66.com/GitHub/article_110313)  •[雙語](https://www.kutu66.com/c/mutia_110313)

#### **文章目录**

- [演示](https://www.kutu66.com/GitHub/article_110313#1-yfsys)
- [支持浏览器](https://www.kutu66.com/GitHub/article_110313#2-yfsys)
- [下载&安装](https://www.kutu66.com/GitHub/article_110313#3-yfsys)
- [dnd可以拖动指令](https://www.kutu66.com/GitHub/article_110313#4-yfsys)
- [dnd列表指令](https://www.kutu66.com/GitHub/article_110313#5-yfsys)
- [dnd-nodrag指令](https://www.kutu66.com/GitHub/article_110313#6-yfsys)
- [dnd句柄指令](https://www.kutu66.com/GitHub/article_110313#7-yfsys)
- [推荐的CSS样式](https://www.kutu66.com/GitHub/article_110313#8-yfsys)
- [为什么另一个拖动&除去库？](https://www.kutu66.com/GitHub/article_110313#9-yfsys)
- [许可证](https://www.kutu66.com/GitHub/article_110313#10-yfsys)

广告

[![](../_resources/589257034aaa4448e53a1d2741c9a84d.png)](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CTBm0E4FDX83GA8rJtwfWmIOgCoO2575dmcf4v7ULv-EeEAEguL3wA2CdAaABjK2e6wPIAQapAlLUfb6sZYM-qAMByAPDBKoE1QFP0MRsFULtOHQjirrAwsW3ZH91m_l6E4r5AjlBvlvWSNH9BXXq7OG3E2ttc61RaJsuiArwJgeaAjmMgMLRPdCrovHa9ASGZBFXW5_VN_OG2uxxdABso9_WhtPZbYRliyKhgTDKQu86kU7SgJD-5d9AG5MqZfXDE2fm5dkXvYUjqsqAmQMJv5EPN_HWsu2TaRLwgX39fePKThAm8QrCUhNclWfuie9dUJXjWw2mS1_eFV8y0hB_Xzu2tqW6_GWdcsdnrjsIp0t1MuPda_BKDhUF3lzXt97ABL2ZmeugAqAGN4AH3NLhFKgHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcB0ggHCIBhEAEYH7EJQ-p74yuPwfGACgGYCwHICwHYEwyIFAU&ae=1&num=1&cid=CAASEuRog6MrytkGU_Pc2nIFHag5wA&sig=AOD64_1zjZxcHPTD1z4NDSXTnqk3Vop63g&client=ca-pub-1467695179275159&nb=9&adurl=https://www.ipv4.me/%3Fgclid%3DEAIaIQobChMIjZyUwryz6wIVyuTtCh1WzACkEAEYASAAEgKWn_D_BwE)

[普通宽带可用, 不改变本地网络和 应用程序](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CTBm0E4FDX83GA8rJtwfWmIOgCoO2575dmcf4v7ULv-EeEAEguL3wA2CdAaABjK2e6wPIAQapAlLUfb6sZYM-qAMByAPDBKoE1QFP0MRsFULtOHQjirrAwsW3ZH91m_l6E4r5AjlBvlvWSNH9BXXq7OG3E2ttc61RaJsuiArwJgeaAjmMgMLRPdCrovHa9ASGZBFXW5_VN_OG2uxxdABso9_WhtPZbYRliyKhgTDKQu86kU7SgJD-5d9AG5MqZfXDE2fm5dkXvYUjqsqAmQMJv5EPN_HWsu2TaRLwgX39fePKThAm8QrCUhNclWfuie9dUJXjWw2mS1_eFV8y0hB_Xzu2tqW6_GWdcsdnrjsIp0t1MuPda_BKDhUF3lzXt97ABL2ZmeugAqAGN4AH3NLhFKgHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcB0ggHCIBhEAEYH7EJQ-p74yuPwfGACgGYCwHICwHYEwyIFAU&ae=1&num=1&cid=CAASEuRog6MrytkGU_Pc2nIFHag5wA&sig=AOD64_1zjZxcHPTD1z4NDSXTnqk3Vop63g&client=ca-pub-1467695179275159&nb=0&adurl=https://www.ipv4.me/%3Fgclid%3DEAIaIQobChMIjZyUwryz6wIVyuTtCh1WzACkEAEYASAAEgKWn_D_BwE)

[广告   每一个盒子带有公网固定IP，让内网能 被外网用户访问。]()

[汉士私有云](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CTBm0E4FDX83GA8rJtwfWmIOgCoO2575dmcf4v7ULv-EeEAEguL3wA2CdAaABjK2e6wPIAQapAlLUfb6sZYM-qAMByAPDBKoE1QFP0MRsFULtOHQjirrAwsW3ZH91m_l6E4r5AjlBvlvWSNH9BXXq7OG3E2ttc61RaJsuiArwJgeaAjmMgMLRPdCrovHa9ASGZBFXW5_VN_OG2uxxdABso9_WhtPZbYRliyKhgTDKQu86kU7SgJD-5d9AG5MqZfXDE2fm5dkXvYUjqsqAmQMJv5EPN_HWsu2TaRLwgX39fePKThAm8QrCUhNclWfuie9dUJXjWw2mS1_eFV8y0hB_Xzu2tqW6_GWdcsdnrjsIp0t1MuPda_BKDhUF3lzXt97ABL2ZmeugAqAGN4AH3NLhFKgHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcB0ggHCIBhEAEYH7EJQ-p74yuPwfGACgGYCwHICwHYEwyIFAU&ae=1&num=1&cid=CAASEuRog6MrytkGU_Pc2nIFHag5wA&sig=AOD64_1zjZxcHPTD1z4NDSXTnqk3Vop63g&client=ca-pub-1467695179275159&nb=1&adurl=https://www.ipv4.me/%3Fgclid%3DEAIaIQobChMIjZyUwryz6wIVyuTtCh1WzACkEAEYASAAEgKWn_D_BwE)

[打开](https://www.googleadservices.com/pagead/aclk?sa=L&ai=CTBm0E4FDX83GA8rJtwfWmIOgCoO2575dmcf4v7ULv-EeEAEguL3wA2CdAaABjK2e6wPIAQapAlLUfb6sZYM-qAMByAPDBKoE1QFP0MRsFULtOHQjirrAwsW3ZH91m_l6E4r5AjlBvlvWSNH9BXXq7OG3E2ttc61RaJsuiArwJgeaAjmMgMLRPdCrovHa9ASGZBFXW5_VN_OG2uxxdABso9_WhtPZbYRliyKhgTDKQu86kU7SgJD-5d9AG5MqZfXDE2fm5dkXvYUjqsqAmQMJv5EPN_HWsu2TaRLwgX39fePKThAm8QrCUhNclWfuie9dUJXjWw2mS1_eFV8y0hB_Xzu2tqW6_GWdcsdnrjsIp0t1MuPda_BKDhUF3lzXt97ABL2ZmeugAqAGN4AH3NLhFKgHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcB0ggHCIBhEAEYH7EJQ-p74yuPwfGACgGYCwHICwHYEwyIFAU&ae=1&num=1&cid=CAASEuRog6MrytkGU_Pc2nIFHag5wA&sig=AOD64_1zjZxcHPTD1z4NDSXTnqk3Vop63g&client=ca-pub-1467695179275159&nb=8&adurl=https://www.ipv4.me/%3Fgclid%3DEAIaIQobChMIjZyUwryz6wIVyuTtCh1WzACkEAEYASAAEgKWn_D_BwE)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 24 16' data-evernote-id='46' class='js-evernote-checked'%3e%3cpath d='M10.90 4.69L10.90 5.57L3.17 5.57L3.17 7.22L3.17 7.22Q3.17 9.15 3.06 10.11L3.06 10.11L3.06 10.11Q2.95 11.07 2.58 11.92L2.58 11.92L2.58 11.92Q2.21 12.77 1.27 13.56L1.27 13.56L0.59 12.93L0.59 12.93Q2.29 11.82 2.29 8.66L2.29 8.66L2.29 4.69L6.11 4.69L6.11 2.95L7.00 2.95L7.00 4.69L10.90 4.69ZM23.00 7.34L23.00 8.22L12.80 8.22L12.80 7.34L17.55 7.34L17.55 5.53L15.12 5.53L15.12 5.53Q14.55 6.53 13.86 7.07L13.86 7.07L13.10 6.46L13.10 6.46Q14.44 5.46 14.95 3.33L14.95 3.33L15.84 3.55L15.84 3.55Q15.77 3.86 15.49 4.65L15.49 4.65L17.55 4.65L17.55 2.84L18.47 2.84L18.47 4.65L21.86 4.65L21.86 5.53L18.47 5.53L18.47 7.34L23.00 7.34ZM21.45 8.88L21.45 13.63L20.53 13.63L20.53 12.78L15.32 12.78L15.32 13.63L14.41 13.63L14.41 8.88L21.45 8.88ZM15.32 11.90L20.53 11.90L20.53 9.76L15.32 9.76L15.32 11.90Z'%3e%3c/path%3e%3c/svg%3e)

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 15 15' data-evernote-id='44' class='js-evernote-checked'%3e%3cpath d='M3.25%2c3.25l8.5%2c8.5M11.75%2c3.25l-8.5%2c8.5'%3e%3c/path%3e%3c/svg%3e)

> Angular directives for sorting nested lists using the HTML5 Drag & Drop API
源代码名称:**angular-drag-and-drop-lists**
源代码网址:http://www.github.com/marceljuenemann/angular-drag-and-drop-lists

[angular-drag-and-drop-lists源代码文档](http://www.github.com/marceljuenemann/angular-drag-and-drop-lists/wiki)

[angular-drag-and-drop-lists源代码下载](http://www.github.com/marceljuenemann/angular-drag-and-drop-lists/releases)

Git URL:

`git://www.github.com/marceljuenemann/angular-drag-and-drop-lists.git`
Git Clone代码到本地:

`git clone http://www.github.com/marceljuenemann/angular-drag-and-drop-lists`
Subversion代码到本地:

	$ svn co --depth empty http://www.github.com/marceljuenemann/angular-drag-and-drop-lists
	Checked out revision 1.
	$ cd repo
	$ svn up trunk

[(L)](http://www.github.com/marceljuenemann/angular-drag-and-drop-lists#angular-drag-and-drop-lists) angular-drag-and-drop-lists

允许你使用本机HTML5拖拉&拖放API构建可以排序列表的Angular 指令。 这些指令还可以嵌套，以便将拖放&拖放到你所在的编辑器，树或者你正在构建的任何。

## [(L)](http://www.github.com/marceljuenemann/angular-drag-and-drop-lists#demo)演示

- [嵌套列表](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fnested)
- [简单列表](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fsimple)
- [类型列表](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Ftypes)
- [高级功能插件](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fadvanced)
- [多功能演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fmulti)

## [(L)](http://www.github.com/marceljuenemann/angular-drag-and-drop-lists#supported-browsers)支持浏览器

因为它们不实现HTML5拖放标准，所以不支持 **Touch设备。** 但是，你可以使用 [shim 插件，使它在触摸设备上工作。](https://github.com/timruffles/ios-html5-drag-drop-shim)

IE 8或者更低版本不支持，但是所有现代浏览器都是(。查看已经测试浏览器列表的变更日志)。

## [(L)](http://www.github.com/marceljuenemann/angular-drag-and-drop-lists#download--installation)下载&安装

- 下载 `angular-drag-and-drop-lists.js` ( 或者缩小版) 并将它的包含在你的应用程序中。 如果你使用 Bower 或者 npm，只需包含 `angular-drag-and-drop-lists` 包。
- 添加 `dndLists` MODULE 作为对 Angular 应用程序的依赖项。

## [(L)](http://www.github.com/marceljuenemann/angular-drag-and-drop-lists#dnd-draggable-directive) dnd可以拖动指令

使用dnd可以拖动指令使元素可以拖动
**属性**

- `dnd-draggable` 必需属性。该值必须是表示元素数据的对象。 在拖放操作中，对象将被序列化并在接收端上进行非串行化。
- `dnd-effect-allowed` 使用这里属性限制可以执行的操作。 有效选项是 `move`，`copy` 和 `link`，以及 `all`。`copyMove`。`copyLink` 和 `linkMove`，`move` 是默认值。 这些操作的语义取决于你，必须使用回调描述的below 实现。 如果允许多个选项，用户可以使用修改键( 操作系统特定) 在它们之间进行选择。 将相应地更改 cursor，期望对 IE 和边，这不受支持。 请注意，这个属性的实现在IE9中非常有。 除了Safari和 IE 之外，这里属性与 `dnd-external-sources` 一起工作，在拖动accross浏览器标签时限制将丢失。 [设计文档](https://github.com/marceljuenemann/angular-drag-and-drop-lists/wiki/Drop-Effects-Design)[演示](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fadvanced)
- 如果你的应用程序中有不同类型的项，并且希望将哪些项限制到列表中，`dnd-type` 将使用这里属性。 在 dnd-list(s) 上与dnd-allowed-types结合。 这里属性必须是小写字符串。 可以使用大写字符，但将自动转换为小写字符。 [演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Ftypes)
- `dnd-disable-if` 可以使用这里属性动态禁用元素的draggability。 如果有某些不希望拖动的列表项，或者希望完全禁止拖动&拖放，而不使用两个不同的代码分支( 比如 )，那么这是很有用的。 仅允许管理员)。[演示程序。](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Ftypes)

**回调**

- 在拖动元素时调用的`dnd-dragstart` 回调。 原始的dragstart事件将在本地 `event` 变量中提供。 [演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fadvanced)
- 在移动元素时调用的`dnd-moved` 回调。 通常你将从这里回调中的原始列表中删除元素，因为该指令不会自动为你执行这里操作。 原始的dragend事件将在本地 `event` 变量中提供。 [演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fadvanced)
- `dnd-copied` 和dnd移动一样，只是在复制元素而不是被移动时调用。 原始的dragend事件将在本地 `event` 变量中提供。 [演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fadvanced)
- `dnd-linked` 和dnd移动一样，只是在元素被链接而不是移动时调用。 原始的dragend事件将在本地 `event` 变量中提供。 [演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fadvanced)
- 如果拖动元素，但取消了操作并且未删除元素，则调用了 `dnd-canceled` 回调。 原始的dragend事件将在本地事件变量中提供。 [演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fadvanced)
- 当拖动操作结束时调用的`dnd-dragend` 回调。 可用的局部变量是 `event` 和 `dropEffect`。 [演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fadvanced)
- `dnd-selected` 回调，在单击元素但未被拖动时调用。 原始的click事件将在本地 `event` 变量中提供。 [演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fnested)
- 传递给dropzone回调并可以用于在源作用域和目标作用域之间进行通信的`dnd-callback` 自定义回调。 dropzone可以将用户定义的变量传递给这里回调。 这可以用于传输没有序列化的对象，见[演示](https://jsfiddle.net/Ldxffyod/1/)。

**CSS类**

- `dndDragging` 将这里类添加到元素时将它的添加到元素中。 它将影响你在拖动时所看到的元素和保留在它的位置的源元素。 不要试图用此类隐藏源元素，因为这将中止拖动操作。
- 注意这里类将被添加到元素，这意味着它只影响原始元素，而不是用户用鼠标指针拖动的原始元素。

## [(L)](http://www.github.com/marceljuenemann/angular-drag-and-drop-lists#dnd-list-directive) dnd列表指令

使用dnd列表属性将列表元素设为 dropzone。 通常，将单个li元素添加为带有ng重复指令的子元素。 如果不这样做，我们将不能正确地定位被删除的元素。 如果你希望列表可以排序，还要将指令添加到你的李 element(s) 中。

**属性**

- 必选项。必须为。必须是插入元素的数据的。 如果使用自定义dnd丢弃处理程序处理它的自身的插入，则该值可以是空的。
- `dnd-allowed-types` 可选的项类型的array。 使用时，只有具有匹配dnd类型属性的项才是 dropable。 大写字符将自动转换为小写字符。 [演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Ftypes)
- `dnd-effect-allowed` 可选字符串表达式，限制可以在列表中执行的拖放效果。 有关允许选项的详细信息，请参阅dnd-effect-allowed上的可以拖动。 默认值为 `all`。
- `dnd-disable-if` 可选布尔表达式如果计算结果为 true，则不可能放入列表中。 注意，这也会禁用重新排列列表中的inside。 [演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Ftypes)
- 布尔表达式的值。当它计算为时，定位算法将使用列表项的左和右 halfs，而不是上和下 halfs。 [演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fadvanced)
- 布尔表达式可以选择布尔表达式。当计算结果为 true 时，列表接受当前浏览器选项卡之外的一滴，从而允许拖放不同的浏览器标签。 目前唯一不工作的主要浏览器是微软 Edge。 [演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fadvanced)

**回调**

- `dnd-dragover` 可选表达式，在将元素拖动到列表中时调用。 如果设置了表达式，但不是 return true，则不允许将元素删除。 将提供以下变量：
    - `event` 由浏览器发送的原始dragover事件。
    - `index` 在列表中放置元素的位置。
    - `type` 在dnd可以拖动上设置的`dnd-type`，如果未设置，则为未定义。 对于从 IE 和边来说，从外部来源中删除是空的，因为我们不知道这些情况下的类型。
    - `external` 是否从外部源拖动元素。 查看 `dnd-external-sources`。
    - `dropEffect` 将要执行的dropEffect，请参见 dnd-effect-allowed。
    - 如果在源元素上设置了dnd回调，则这是对回调的函数引用。 可以使用如下的自定义变量调用回调： `callback({var1: value1, var2: value2})` 这里回调将在源元素的范围内执行。 如果dnd-external-sources已经设置且外部为 true，则这里回调将不可用。
    - [演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fadvanced)
- `dnd-drop` 可选的表达式，在列表中拖放元素时调用。 同样的变量可以用于 is，并且类型总是知道的，因这里永远不会为 null。 还将有一个 `item` 变量，它是传输的对象。 返回值决定了对drop的进一步处理：
    - `falsy` 删除将被取消，元素将不会被插入。
    - 允许删除的`true` Signalises，但是dnd回调回调将负责插入元素。
    - 否则，所有其他返回值将被视为要插入到 array 中的对象。 在大多数情况下，只需要返回 `item` 参数，但对可以返回的内容没有限制。
- 如果元素实际上插入到列表中，则在删除后调用的`dnd-inserted` 可选表达式。 `dnd-drop` 相同的本地变量将可用。 请注意，对于 reorderings inside，旧元素仍然在列表中，因为尚未调用 `dnd-moved`。 [演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Fadvanced)

**CSS类**

- 在列表中拖动元素时，将添加一个新的占位子元素。 这里元素的类型为 `li`，并设置了类 `dndPlaceholder`。 或者，可以通过创建带有 `dndPlaceholder` 类的子元素来定义自己的占位符。
- `dndDragover` 将被添加到列表中，而元素正在拖动到列表中。

## [(L)](http://www.github.com/marceljuenemann/angular-drag-and-drop-lists#dnd-nodrag-directive) dnd-nodrag指令

使用 `dnd-draggable` 元素的`dnd-nodrag` 属性 inside 来防止它们开始拖动操作。 如果你想使用 `dnd-draggable` 元素的inside 元素或者创建特定的处理元素，这一点特别有用。

注意：这里指令在 IE 9中不起作用。

[演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Ftypes)

## [(L)](http://www.github.com/marceljuenemann/angular-drag-and-drop-lists#dnd-handle-directive) dnd句柄指令

在 `dnd-nodrag` 元素中使用 `dnd-handle` 指令，以允许在所有元素之后拖动该元素。 通过组合 `dnd-nodrag` 和 `dnd-handle`，你可以只通过特定的处理 `dnd-draggable` 元素元素元素。

注意：IE 将把手柄元素显示为拖拽图像，而不是 `dnd-draggable` 元素。 当拖动句柄元素时，可以不同的方式对它的进行处理。 使用CSS选择器 `.dndDragging:not(.dndDraggingSource) [dnd-handle]` 因为。

[演示工具](http://marceljuenemann.github.io/angular-drag-and-drop-lists/demo/#%2Ftypes)

## [(L)](http://www.github.com/marceljuenemann/angular-drag-and-drop-lists#recommended-css-styles)推荐的CSS样式

建议应用以下CSS样式：

- 如果应用程序是通过拖放移动元素，建议在拖动时隐藏源元素，在 `.dndDraggingSource` 类上设置 换句话说，设置 `display: none`。
- 在应用程序允许将元素放入空列表时，需要确保空列表的高度或者宽度永远不为0，通过设置一个值来确定它的。
- 应该相应地设置 `.dndPlaceholder` 类的样式。

注意：这个指令的以前版本要求在某些元素上使用 `postion: relative`，但是这不再需要。

## [(L)](http://www.github.com/marceljuenemann/angular-drag-and-drop-lists#why-another-drag--drop-library)为什么另一个拖动&除去库？

在那里有大量其他拖拉&库，但是它们都没有满足我的三个要求：

- 如果你使用 angular.js，你真的不想在你的应用程序中抛出大量的jQuery。 相反，你希望使用构建了"Angular 方式"的库，并支持为数据模型自动更新2 路数据绑定。
- 如果你想建立一个**的WYSIWYG编辑器**或者拥有一些漂亮的树结构，库必须支持嵌套列表。
- **HTML5 &拖放：** 大多数拖动&拖放应用你会发现在互联网上使用纯JavaScript拖放&拖放。 但是随着HTML5的到来，我们可以将大部分工作委托给浏览器。 例如：如果要显示用户当前正在拖动的内容，则必须更新元素的位置并将它的设置为 below。 在HTML5中浏览器会为你做这个 ！ 但你不仅可以保存代码行，还可以为本机用户体验提供更多的**:** 如果在纯JavaScript拖放实现中单击某个元素，通常会启动拖动操作。 但是，请记住在你的桌面上单击 icon 时会发生什么情况： 将选择 icon，而不是拖动 ！ 这是你可以使用HTML5给你的web应用程序带来的本地行为。

如果这不符合你的要求，请查看另一个出色的拖放&拖放库：

- [angular-ui-tree](https://github.com/JimLiu/angular-ui-tree): 非常类似于这个库，但是不使用 HTML5 API。 因此，你需要编写更多的标记来查看所拖动的内容，它将创建另一个 DOM node，你必须。 然而，如果你打算支持触摸设备，这可能是你最好的选择。
- [角度 dragdrop](https://github.com/angular-dragdrop/angular-dragdrop): 具有相同 NAME的许多库之一。 使用 for，但是如果你想构建( 嵌套) 可以排序列表，那么你可以自己使用它，因为它没有计算正确的位置。
- [更多。](https://www.google.de/search?q%3Dangular%2Bdrag%2Band%2Bdrop)

## [(L)](http://www.github.com/marceljuenemann/angular-drag-and-drop-lists#license)许可证

版权所有( c ) 2014 [Juenemann](https://www.kutu66.com/GitHub/article_110313mailto:marcel%40juenemann.cc)。

版权所有( c ) 2014 -2017谷歌公司。
这不是官方的谷歌产品( 实验或者其他)，它只是由谷歌拥有的代码。

[MIT许可证](https://raw.githubusercontent.com/marceljuenemann/angular-drag-and-drop-lists/master/LICENSE)

[API](https://www.kutu66.com/article/show_ftag/12749-0-0-1)  [lis](https://www.kutu66.com/article/show_ftag/14659-0-0-1)  [DIR](https://www.kutu66.com/article/show_ftag/21721-0-0-1)  [列表](https://www.kutu66.com/article/show_ftag/12747-0-0-1)  [Directive](https://www.kutu66.com/article/show_ftag/298-0-0-1)  [sort](https://www.kutu66.com/article/show_ftag/21199-0-0-1)

相关文章

 [![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-hidden='true' class='inline-block fill-current icon h-3 w-3 js-evernote-checked' role='img' data-evernote-id='448'%3e%3cuse xlink:href='/images/sprite.svg%23link' data-evernote-id='449' class='js-evernote-checked'%3e%3c/use%3e%3c/svg%3e)  如何从你的移动电话远程控制 uTorrent](https://www.kutu66.com/iPhone/article_11461)