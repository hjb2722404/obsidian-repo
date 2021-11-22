逐行分析jQuery源码奥秘 （二）- 给JQ对象添加一些方法和属性

# 逐行分析jQuery源码奥秘 （二）- 给JQ对象添加一些方法和属性

源码

## 给JQ对象添加一些方法和属性

### 简化版

	<script>

	jQuery.fn = jQuery.prototype ={

	    jquery : 版本

	    constructor : 修正指向问题

	    init() : 初始化和参数管理

	    selector : 存储选择字符串

	    length : this对象的长度

	    toArray() : 转数组

	    get()  : 转原生集合

	    pushStack() : JQ对象的入栈

	    each() : 遍历集合

	    ready() : DOM加载的接口

	    slice() : 集合的截取

	    first() : 集合的第一项

	    last() : 集合的最后一项

	    eq() : 集合的指定项

	    map() : 返回新集合

	    end() : 返回集合前一个状态

	    push() : 内部使用

	    sort() : 内部使用

	    splice() : 内部使用

	};

	</script>

### 完整版

1
* * *

2jQuery.fn = jQuery.prototype = {
* * *

3    // The current version of jQuery being used
* * *

4    //将jquery版本号赋给属性jquery
* * *

5    jquery: core_version,
* * *

6    //修正constructor，因为当使用jQuery.prototype={}时是覆盖原型，会导致默认的constructor属性指向了当前这个{}Object对象

* * *

7    constructor: jQuery,
* * *

8    //初始化和参数管理
* * *

9    /*
* * *

10        *$()与jQuery()调用的是jQuery()函数，该函数new了一个init方法并返回
* * *

11        *参数说明：
* * *

12        *   selector:选择器
* * *

13        *   context :执行上下文
* * *

14    */
* * *

15    init: function( selector, context, rootjQuery ) {
* * *

16        //match，匹配结果
* * *

17        var match, elem;
* * *

18        //处理不正确的参数
* * *

19        // HANDLE: $(""), $(null), $(undefined), $(false)
* * *

20        //如果是不支持的参数类型，直接返回对象自身
* * *

21        if ( !selector ) {
* * *

22            return this;
* * *

23        }
* * *

24        //处理字符串格式的参数
* * *

25        // Handle HTML strings
* * *

26        //如果selector参数是字符串
* * *

27        if ( typeof selector === "string" ) {
* * *

28        //如果参数是标签：<li> | <li>...</li>
* * *

29            if ( selector.charAt(0) === "<" && selector.charAt( selector.length - 1 ) === ">" && selector.length >= 3 ) {

* * *

30                // Assume that strings that start and end with <> are HTML and skip the regex check

* * *

31                //
* * *

32                match = [ null, selector, null ];
* * *

33
* * *

34            } else {
* * *

35            //如果是非标签，则匹配rquickExpr的格式
* * *

36            //rquikExpr:/^(?:\s*(<[\w\W]+>)[^>]*|#([\w-]*))$/,
* * *

37            //该正则匹配标签与ID，并防止XSS注入
* * *

38            //该正则对象会匹配selector字符串中符合条件的字符串以及符合分组条件的字符串。
* * *

39            //exec()函数返回的是一个数组，数组第一个元素是符合条件的字符串，后面的元素分别是符合分组条件的字符串
* * *

40                match = rquickExpr.exec( selector );
* * *

41            }
* * *

42
* * *

43            // Match html or make sure no context is specified for #id
* * *

44            // 如果match为真（标签与ID）且“上下文不存在或者match[1]存在”为真
* * *

45            // match[1]代表匹配后的第二个元素，如果它存在则代表匹配到的是标签和ID
* * *

46            //如果是ID肯定没有上下文
* * *

47            //综合结果，能进该if的只有标签和ID
* * *

48            if ( match && (match[1] || !context) ) {
* * *

49                //进一步判断是不是创建html标签
* * *

50                // HANDLE: $(html) -> $(array)
* * *

51                if ( match[1] ) {
* * *

52                    /*
* * *

53                    //如果context是jQuery对象$(document)，则返回原生的document,如果不是，则直接返回的就是原生的document

* * *

54                    var boolean = context instanceof jQuery;
* * *

55                    if(boolean==true){
* * *

56                        context = context[0];
* * *

57                    }else{
* * *

58                        context = context
* * *

59                    }
* * *

60
* * *

61                    */
* * *

62                    context = context instanceof jQuery ? context[0] : context;

* * *

63
* * *

64                    // scripts is true for back-compat
* * *

65                    //jQuery.parseHTML()函数将html字符串转换为一个DOM元素的集合。第一个参数为匹配到的标签字符串，第二个参数确定是哪个文档，第三个参数指定运行其中的script脚本

* * *

66                    //jQuery.merge()将解析后返回的节点数组合并到其自身（当前jQd对象）之中
* * *

67                    jQuery.merge( this, jQuery.parseHTML(
* * *

68                        match[1],
* * *

69                        context && context.nodeType ? context.ownerDocument || context : document,

* * *

70                        true
* * *

71                    ) );
* * *

72
* * *

73                    // HANDLE: $(html, props)
* * *

74                    //为添加的标签添加属性。
* * *

75                    //如果匹配到的标签是个单标签，并且第二个参数是个对象字面量
* * *

76                    if ( rsingleTag.test( match[1] ) && jQuery.isPlainObject( context ) ) {

* * *

77                        //遍历第二个参数context传入的对象
* * *

78                        for ( match in context ) {
* * *

79                            // Properties of context are called as methods if possible

* * *

80                            //this[match] == this.match
* * *

81                            //this指向当前遍历到的元素
* * *

82                            //如果当前元素名称是jQuery的方法
* * *

83                            if ( jQuery.isFunction( this[ match ] ) ) {
* * *

84                                //直接调用这个函数，并将元素值作为参数传入进去
* * *

85                                this[ match ]( context[ match ] );
* * *

86
* * *

87                            // ...and otherwise set as attributes
* * *

88                            //否则，直接将该元素作为属性赋给当前对象
* * *

89                            } else {
* * *

90                                this.attr( match, context[ match ] );
* * *

91                            }
* * *

92                        }
* * *

93                    }
* * *

94                    //返回创建好的标签
* * *

95                    return this;
* * *

96
* * *

97                // HANDLE: $(#id)
* * *

98                // else则是获取ID
* * *

99                } else {
* * *

100                //选择到对应的元素
* * *

101                //格式举例：match:['#div1',null,'div1']
* * *

102                    elem = document.getElementById( match[2] );
* * *

103
* * *

104                    // Check parentNode to catch when Blackberry 4.6 returns

* * *

105                    // nodes that are no longer in the document #6963
* * *

106                    //如果元素存在且元素的父元素存在
* * *

107                    if ( elem && elem.parentNode ) {
* * *

108                        //将元素加入到当前jQuery对象中，并且对象长度设为1
* * *

109                        // Inject the element directly into the jQuery object

* * *

110                        this.length = 1;
* * *

111                        this[0] = elem;
* * *

112                    }
* * *

113                    //设置对象的其他属性并返回
* * *

114                    this.context = document;
* * *

115                    this.selector = selector;
* * *

116                    return this;
* * *

117                }
* * *

118            //处理标签，类，及其他复杂选择器
* * *

119            // HANDLE: $(expr, $(...))
* * *

120            //如果执行上下文不存在或者存在上下文但上下文不是jquery对象（因为jquery对象拥有jquery属性，而其他则没有）
* * *

121            } else if ( !context || context.jquery ) {
* * *

122                //返回利用find()找到的节点
* * *

123                return ( context || rootjQuery ).find( selector );
* * *

124            // 处理存在上下文但上下文不是jquery对象的情况，举例：
* * *

125            //$('ul',document).find('li');
* * *

126            // HANDLE: $(expr, context)
* * *

127            // (which is just equivalent to: $(context).find(expr)
* * *

128            } else {
* * *

129                return this.constructor( context ).find( selector );
* * *

130            }
* * *

131        //处理DOM元素参数
* * *

132        // HANDLE: $(DOMElement)
* * *

133        //如果有nodeType属性则说明是DOM节点
* * *

134        } else if ( selector.nodeType ) {
* * *

135            //设置对象属性，并返回
* * *

136            this.context = this[0] = selector;
* * *

137            this.length = 1;
* * *

138            return this;
* * *

139        //处理函数类型参数
* * *

140        // HANDLE: $(function)
* * *

141        // Shortcut for document ready
* * *

142        //如果参数是函数
* * *

143        } else if ( jQuery.isFunction( selector ) ) {
* * *

144            //直接在document.ready()函数中调用该函数，如：
* * *

145            //$(document).ready(function({...}));
* * *

146            //由此可知，实际上$(function(){..});还是调用的$(document).ready()方法
* * *

147            return rootjQuery.ready( selector );
* * *

148        }
* * *

149        //如果传的参数是不是jquery对象（如果是jquery对象，就会有selector这个属性，即之前几个处理函数返回对象时设置的this.selector属性），如果是jquery对象，则设置对象属性并返回。

* * *

150        if ( selector.selector !== undefined ) {
* * *

151            this.selector = selector.selector;
* * *

152            this.context = selector.context;
* * *

153        }
* * *

154        //将类数组转换为真正的数组，即以下标为标识的json对象
* * *

155        //makeArray方法在内部使用时，加入第2个参数，可以转换为第2个参数对应的数据类型
* * *

156        return jQuery.makeArray( selector, this );
* * *

157    },
* * *

158
* * *

159    // Start with an empty selector
* * *

160    selector: "",
* * *

161    //默认的选择到的对象的长度
* * *

162    // The default length of a jQuery object is 0
* * *

163    length: 0,
* * *

164    //转数组的方法
* * *

165    toArray: function() {
* * *

166        //使用slice方法，不指定参数，截取原数组并返回，相当于复制了一份数组，在json对象下执行，则将该json转换为数组
* * *

167        return core_slice.call( this );
* * *

168    },
* * *

169
* * *

170    // Get the Nth element in the matched element set OR
* * *

171    // Get the whole matched element set as a clean array
* * *

172    //将jQuery对象转换为原生集合
* * *

173    get: function( num ) {
* * *

174        return num == null ?
* * *

175            // 如果没有参数，则将该对象转换为原生数组对象返回
* * *

176            // Return a 'clean' array
* * *

177            this.toArray() :
* * *

178            //如果参数小于0，则返回该对象中属性为（他自身长度+num）【从后往前数num】的值，否则返回该对象中属性为num的值
* * *

179            // Return just the object
* * *

180            ( num < 0 ? this[ this.length + num ] : this[ num ] );
* * *

181    },
* * *

182
* * *

183    // Take an array of elements and push it onto the stack
* * *

184    // (returning the new matched element set)
* * *

185    //jQuery对象的入栈处理
* * *

186    pushStack: function( elems ) {
* * *

187        //将要入栈的元素并入当前的jquery集合对象，返回合并后的集合
* * *

188        // Build a new jQuery matched element set
* * *

189        var ret = jQuery.merge( this.constructor(), elems );
* * *

190
* * *

191        // Add the old object onto the stack (as a reference)
* * *

192        //end()方法中将用到prevObject属性
* * *

193        ret.prevObject = this;
* * *

194        ret.context = this.context;
* * *

195
* * *

196        // Return the newly-formed element set
* * *

197        return ret;
* * *

198    },
* * *

199
* * *

200    // Execute a callback for every element in the matched set.
* * *

201    // (You can seed the arguments with an array of args, but this is
* * *

202    // only used internally.)
* * *

203    //遍历方法，调用了工具方法$.each();
* * *

204    each: function( callback, args ) {
* * *

205        return jQuery.each( this, callback, args );
* * *

206    },
* * *

207    //回调了延迟触发函数
* * *

208    ready: function( fn ) {
* * *

209        // Add the callback
* * *

210        jQuery.ready.promise().done( fn );
* * *

211
* * *

212        return this;
* * *

213    },
* * *

214    // 使用pushStack方法截取集合并返回结果。
* * *

215    //因为参数arguments是一个集合，所以使用apply而非call
* * *

216    slice: function() {
* * *

217        return this.pushStack( core_slice.apply( this, arguments ) );
* * *

218    },
* * *

219    //使用eq()方法选取集合中的第一个元素并返回
* * *

220    first: function() {
* * *

221        return this.eq( 0 );
* * *

222    },
* * *

223    //使用eq()方法选取集合中的最后一个元素并返回
* * *

224    last: function() {
* * *

225        return this.eq( -1 );
* * *

226    },
* * *

227    //选取集合中的指定项
* * *

228    //传入一个下标
* * *

229    eq: function( i ) {
* * *

230        //获得当前集合的长度
* * *

231        var len = this.length,
* * *

232        //如果下标i小于0，则变量j等于i强制转换为数字（加号的妙用）加上len，如果不小于0，将它的值赋给变量j
* * *

233        //例如：集合有5个元素，传入下标-1
* * *

234        //eq(-1),则j=-1+5 = 4，
* * *

235            j = +i + ( i < 0 ? len : 0 );
* * *

236            //调用pushStack方法
* * *

237            //如果j>=0 并且j<len，则将集合中下标为j的元素作为参数传入，否则，则说明j<0,说明本身这个集合就是空的（len<=0），那就返回空的集合。

* * *

238        return this.pushStack( j >= 0 && j < len ? [ this[j] ] : [] );
* * *

239    },
* * *

240    //待注解
* * *

241    map: function( callback ) {
* * *

242        return this.pushStack( jQuery.map(this, function( elem, i ) {
* * *

243            return callback.call( elem, i, elem );
* * *

244        }));
* * *

245    },
* * *

246    // 返回集合的上一个状态
* * *

247    end: function() {
* * *

248        return this.prevObject || this.constructor(null);
* * *

249    },
* * *

250    //内部使用，调用集合的原生方法
* * *

251    // For internal use only.
* * *

252    // Behaves like an Array's method, not like a jQuery method.
* * *

253    push: core_push,
* * *

254    sort: [].sort,
* * *

255    splice: [].splice
* * *

256};
* * *

257
* * *

258// Give the init function the jQuery prototype for later instantiation
* * *

259
* * *

260//jQuery.fn 赋值为Init方法的原型，以便init方法拥有jQuery.fn原型上的方法和属性
* * *

261
* * *

262jQuery.fn.init.prototype = jQuery.fn;
* * *

263
* * *

#### jquery选择器选择节点对象的原理

##### jquery选择器

1
* * *

2    $('li').css('background','red');
* * *

3
* * *

##### 原生写法：

1
* * *

2    var aLi = document.getElementsByTagName('li');
* * *

3
* * *

4    for(var i=0; i<aLi.length;i++){
* * *

5        aLi[i].style.background = 'red';
* * *

6    }
* * *

7
* * *

##### jquery处理方式

1
* * *

2    this = {
* * *

3
* * *

4        0 : 'li',
* * *

5        1 : 'li',
* * *

6        2 : 'li',
* * *

7        length : 3
* * *

8
* * *

9    }
* * *

10
* * *

11    for(var i=0;i<this.length;i++){
* * *

12
* * *

13        this[i].style.background = 'red';
* * *

14
* * *

15    }
* * *

16
* * *

#### 知识点：jQuery.HTML();

> 将使用原生的DOM元素创建函数把HTML字符串转换为一个DOM元素的集合，你可以将这些DOM元素插入到文档中。

- 语法
    - jQuery.parseHTML( htmlString [, context ] [, keepScripts ] )
- 参数
    - htmlString String类型，需要解析并转为DOM节点数组的HTML字符串。
    - context Element类型，指定在哪个Document中创建元素，默认为当前文档的document。
    - keepScripts Boolean类型，指定传入的HTML字符串中是否包含脚本，默认为false。
- 说明
    - 如果没有指定context参数，或该参数为null或undefined，则默认为当前document。如果创建的DOM元素用于另一个文档，例如iframe，则应该指定该iframe的document对象。
    - 安全考虑：大多数jQuery API都允许HTML字符串在HTML中包含运行脚本。jQuery.parseHTML()不会运行解析的HTML中的脚本，除非你明确将参数keepScripts指定为true。不过，大多数环境仍然可以间接地执行脚本，例如：通过属性。调用者应该避免这种做，并清理或转义诸如URL、cookie等来源的任何不受信任的输入，从而预防出现这种情况。出于未来的兼容性考虑，当参数keepScripts被省略或为false时，调用者应该不依赖任何运行脚本内容的能力。
- 返回值
    - 函数的返回值为Array类型，返回解析指定HTML字符串后的DOM节点数组。

#### 知识点：jQuery.merge();

> 合并两个数组内容到第一个数组

- 语法
    - jQuery.merge(first,second);
- 参数
    - first第一个用来合并的数组，元素是第二数组加进来的。
    - second第二个数组合并到第一，保持不变
- 说明
    - $.merge()操作形成一个数组，其中包含两个数组的所有元素。从第二个追加的数组元素顺序将保存。$.merge()函数是破坏性的。它改变了从第二个添加项目到第一个参数。
    - 如果您需要原始的第一个数组，请在调用$.merge()前拷贝一个出来。幸运的是， $.merge()本身也可以用于此副本
    - $.merge()本身还可以将数组合并到json对象中。

#### 知识点：jQuery.isPlainObject() 函数

> 用于判断指定参数是否是一个纯粹的对象。所谓"纯粹的对象"，就是该对象是通过"{}"或"new Object"创建的。

- 语法
    - jQuery.isPlainObject( object )
- 参数
    - object 任意类型，需要进行判断的任意值。
- 说明
    - 注意：宿主对象(或其它被浏览器宿主环境使用的对象，以完成ECMAScript的执行环境)难以进行跨平台的特性检测。因此，对于这些对象的实例，$.isPlainObject()在不同的浏览器上可能得出不同的结果。
- 返回值
    - 返回值为Boolean类型，如果指定的参数是纯粹的对象，则返回true，否则返回false。

#### 知识点：for...in语句

> 用于遍历数组或者对象的属性（对数组或者对象的属性进行循环操作）

- 语法

	    for (变量 in 对象)
	{
	    在此执行代码
	}

- 参数
    - “变量”用来指定变量，指定的变量可以是数组元素，也可以是对象的属性。

#### 知识点：jQuery.makeArray()函数

> 用于将一个类数组对象转换为真正的数组对象

- 语法
    - jQuery.makeArray( object )
- 参数
    - object | Object类型。需要转换为数组的类数组对象。
- 说明
    - 一个类数组对象，它至少应该具备length属性，哪怕其值为 0，它可以没有"元素"(相当于空数组)。
    - 如果参数object没有length属性，则它不是类数组对象。jQuery.makeArray()会直接将其视作结果数组中的一个元素。
    - String对象虽然有length属性，但一般不将其视作类数组对象。该函数仍然直接将其视作结果数组中的一个元素。
    - 如果对象的最大数字属性大于或等于length属性，则以length属性为准，大于或等于其值的数字属性将被忽略。
- 返回值
    - 数的返回值为Array类型，返回转换后的数组对象。

[markdownFile.md](../_resources/f5adfb1c28dc471470d34cb42fe8e089.bin)