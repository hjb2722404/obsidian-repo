# js执行机制解析

![20130515081417694](https://gitee.com/hjb2722404/tuchuang/raw/master/img/20201217154251.png)



## 1. 语法检查

> 对输入的脚本文本词法分析、语法分析和语法检查，这个阶段可以检测到语法错误，抛出`sytanx`类型的错误提示

### 1.词法分析（Token）

> 按照一定规则将输入的脚本文本流分割成一个个词汇（Token），每个词汇都对应内置的某种词法分类

例如，以下代码：

```
Array.prototype.forEach = function (callback, thisArg) {

     var T, k;

     if (this == null) {
         throw new TypeError(" this is null or not defined");
     }

     // 1. Let O be the result of calling ToObject passing the |this| value as the argument.
     var O = Object(this);

     // 2. Let lenValue be the result of calling the Get internal method of O with the argument "length".
     // 3. Let len be ToUint32(lenValue).
     var len = O.length >>> 0;

     // 4. If IsCallable(callback) is false, throw a TypeError exception.
     // See: http://es5.github.com/#x9.11
     if (typeof callback !== "function") {
         throw new TypeError(callback + " is not a function");
     }

     // 5. If thisArg was supplied, let T be thisArg; else let T be undefined.
     if (arguments.length > 1) {
         T = thisArg;
     }

     // 6. Let k be 0
     k = 0;

     // 7. Repeat, while k < len
     while (k < len) {

         var kValue;

         // a. Let Pk be ToString(k).
         //   This is implicit for LHS operands of the in operator
         // b. Let kPresent be the result of calling the HasProperty internal method of O with argument Pk.
         //   This step can be combined with c
         // c. If kPresent is true, then
         if (k in O) {

             // i. Let kValue be the result of calling the Get internal method of O with argument Pk.
             kValue = O[k];

             // ii. Call the Call internal method of callback with T as the this value and
             // argument list containing kValue, k, and O.
             callback.call(T, kValue, k, O);
         }
         // d. Increase k by 1.
         k++;
     }
     // 8. return undefined
 };
        
```

经过词法分析后，将形成TOKENS:(此处忽略注释节点)

```
Identifier(Array)
Punctuator(.)
Identifier(prototype)
Punctuator(.)
Identifier(forEach)
Punctuator(=)
Keyword(function)
Punctuator(()
Identifier(callback)
Punctuator(,)
Identifier(thisArg)
Punctuator())
Punctuator({)
Keyword(var)
Identifier(T)
Punctuator(,)
Identifier(k)
Punctuator(;)
Keyword(if)
Punctuator(()
Keyword(this)
Punctuator(==)
Null(null)
Punctuator())
Punctuator({)
Keyword(throw)
Keyword(new)
Identifier(TypeError)
Punctuator(()
String(" this is null or not defined")
Punctuator())
Punctuator(;)
Punctuator(})
Keyword(var)
Identifier(O)
Punctuator(=)
Identifier(Object)
Punctuator(()
Keyword(this)
Punctuator())
Punctuator(;)
Keyword(var)
Identifier(len)
Punctuator(=)
Identifier(O)
Punctuator(.)
Identifier(length)
Punctuator(>>>)
Numeric(0)
Punctuator(;)
Keyword(if)
Punctuator(()
Keyword(typeof)
Identifier(callback)
Punctuator(!==)
String("function")
Punctuator())
Punctuator({)
Keyword(throw)
Keyword(new)
Identifier(TypeError)
Punctuator(()
Identifier(callback)
Punctuator(+)
String(" is not a function")
Punctuator())
Punctuator(;)
Punctuator(})
Keyword(if)
Punctuator(()
Identifier(arguments)
Punctuator(.)
Identifier(length)
Punctuator(>)
Numeric(1)
Punctuator())
Punctuator({)
Identifier(T)
Punctuator(=)
Identifier(thisArg)
Punctuator(;)
Punctuator(})
Identifier(k)
Punctuator(=)
Numeric(0)
Punctuator(;)
Keyword(while)
Punctuator(()
Identifier(k)
Punctuator(<)
Identifier(len)
Punctuator())
Punctuator({)
Keyword(var)
Identifier(kValue)
Punctuator(;)
Keyword(if)
Punctuator(()
Identifier(k)
Keyword(in)
Identifier(O)
Punctuator())
Punctuator({)
Identifier(kValue)
Punctuator(=)
Identifier(O)
Punctuator([)
Identifier(k)
Punctuator(])
Punctuator(;)
Identifier(callback)
Punctuator(.)
Identifier(call)
Punctuator(()
Identifier(T)
Punctuator(,)
Identifier(kValue)
Punctuator(,)
Identifier(k)
Punctuator(,)
Identifier(O)
Punctuator())
Punctuator(;)
Punctuator(})
Identifier(k)
Punctuator(++)
Punctuator(;)
Punctuator(})
Punctuator(})
Punctuator(;)
```

#### 输入分类

* WhiteSpace 空白字符
  * <HT> 也称<TAB> U+0009，也就是tab缩进符号，字符串中的\t。
  * <VT> U+000B c垂直方向的缩进符号 \v。
  * <FF> U+000C Form Feed 分页符 在JavaScript中用的极少。
  * <sp> U+0020 就是最普通的空格。
  * <NBSP> U+00A0 非断行空格，它是SP的一个变体，在文字排版中可以避免因为空格在此处发生断行。
  * <ZWNBSP> U+FEFF，ES5新加入的空白符，是Unicode中的零宽非断行空格。
  * 其它unicode中的空格分类下的空格
* LineTerminator 换行符
  * <LF> U+000A，就是最正常的换行符，在字符串中是\n。
  * <CR> U+000d，这个字符是真正意义上的"回车"，在字符串中是\r，在一部分Windows风格文本编辑器中，换行是两个字符 \r\n。
  * <LS> U+2028，是Unicode中的行分隔符。
  * <PS> U+2029，是Unicode中的段落分割符。
  * * 换行符会影响自动分号插入机制和`no line terminator`规则
* Comment 
  * 注释支持单行注释与多行注释
  * 多行注释中间的`*`号后不允许出现`/`
  * 多行注释中是否有换行符，会影响 no line terminator规则
* Token——如果有无效的Token，则会报错“Invalid or unexpected token”
  * commonToken
    * IdentifierName 标识符，就是变量名和函数名
      * 可以以美元符号‘$’，下划线 ‘_’ 或者Unicode字母开始
      * 可以使用JavaScript的Unicode转义写法
      * 只有当不是保留字的时候，IndentifierName 才会被解析成 Identifier
    * Punctuator 符号，运算符与大括号等符号
      * 注意正则标志
      * 注意模板字符串中的中括号
    * NumbericLiteral 数字直接量
      * 支持四种写法：十进制数，二进制整数，八进制整数和十六进制整数。
      * 十进制的 Number 可以带小数，小数点前后面的部分都可以省略，但是不能同时省略
      * 12.toString（）报错是因为12.被当成了一个带有小数部分的数字直接量，需要在12后面加空格；
      * 支持科学计数法
    * StringLiteral 字符串直接量，使用单双引号包裹的内容
    * Template 字符串模板，用反括号包裹的内容【ES6】
      * 被拆分成了几个部分（`a${b}c${d}e`）
        * 模板头： `a`
        * 普通标识符： `b`
        * 模板中段： `}c${`
        * 普通标识符： `d`
        * 模板尾： `}e`
  * 派生Token
    * *DivPunctuator 除法运算符*
    * *RegularExpressionLiteral 正则字面量*
      * 由body于标志两部分组成 /body/flag
      * *body部分至少有一个字符，但不能是\*，因为/\* 会跟多行注释语法冲突*
    * *RightBracePunctuator【ES6】 右中括号**
    * **TemplateSubstitutionTail* 【ES6】 模板字符中的尾中括号

* KeyWord 关键字, 保留字，未来保留字等

### 2. 语法分析（AST）

> 词法分析和语法分析不是完全独立的，而是交错进行的，也就是说，词法分析器不会在读取所有的词法记号后再使用语法分析器来处理。在通常情况下，每取得一个词法记号，就将其送入语法分析器进行分析

上例中的代码生成的AST（） 使用JSON结构标识如下:

```
{
  "type": "Program",
  "start": 0,
  "end": 1711,
  "body": [
    {
      "type": "ExpressionStatement",
      "start": 0,
      "end": 1702,
      "expression": {
        "type": "AssignmentExpression",
        "start": 0,
        "end": 1701,
        "operator": "=",
        "left": {
          "type": "MemberExpression",
          "start": 0,
          "end": 23,
          "object": {
            "type": "MemberExpression",
            "start": 0,
            "end": 15,
            "object": {
              "type": "Identifier",
              "start": 0,
              "end": 5,
              "name": "Array"
            },
            "property": {
              "type": "Identifier",
              "start": 6,
              "end": 15,
              "name": "prototype"
            },
            "computed": false,
            "optional": false
          },
          "property": {
            "type": "Identifier",
            "start": 16,
            "end": 23,
            "name": "forEach"
          },
          "computed": false,
          "optional": false
        },
        "right": {
          "type": "FunctionExpression",
          "start": 26,
          "end": 1701,
          "id": null,
          "expression": false,
          "generator": false,
          "async": false,
          "params": [
            {
              "type": "Identifier",
              "start": 36,
              "end": 44,
              "name": "callback"
            },
            {
              "type": "Identifier",
              "start": 46,
              "end": 53,
              "name": "thisArg"
            }
          ],
          "body": {
            "type": "BlockStatement",
            "start": 55,
            "end": 1701,
            "body": [
              {
                "type": "VariableDeclaration",
                "start": 63,
                "end": 72,
                "declarations": [
                  {
                    "type": "VariableDeclarator",
                    "start": 67,
                    "end": 68,
                    "id": {
                      "type": "Identifier",
                      "start": 67,
                      "end": 68,
                      "name": "T"
                    },
                    "init": null
                  },
                  {
                    "type": "VariableDeclarator",
                    "start": 70,
                    "end": 71,
                    "id": {
                      "type": "Identifier",
                      "start": 70,
                      "end": 71,
                      "name": "k"
                    },
                    "init": null
                  }
                ],
                "kind": "var"
              },
              {
                "type": "IfStatement",
                "start": 79,
                "end": 167,
                "test": {
                  "type": "BinaryExpression",
                  "start": 83,
                  "end": 95,
                  "left": {
                    "type": "ThisExpression",
                    "start": 83,
                    "end": 87
                  },
                  "operator": "==",
                  "right": {
                    "type": "Literal",
                    "start": 91,
                    "end": 95,
                    "value": null,
                    "raw": "null"
                  }
                },
                "consequent": {
                  "type": "BlockStatement",
                  "start": 97,
                  "end": 167,
                  "body": [
                    {
                      "type": "ThrowStatement",
                      "start": 108,
                      "end": 160,
                      "argument": {
                        "type": "NewExpression",
                        "start": 114,
                        "end": 159,
                        "callee": {
                          "type": "Identifier",
                          "start": 118,
                          "end": 127,
                          "name": "TypeError"
                        },
                        "arguments": [
                          {
                            "type": "Literal",
                            "start": 128,
                            "end": 158,
                            "value": " this is null or not defined",
                            "raw": "\" this is null or not defined\""
                          }
                        ]
                      }
                    }
                  ]
                },
                "alternate": null
              },
              {
                "type": "VariableDeclaration",
                "start": 267,
                "end": 288,
                "declarations": [
                  {
                    "type": "VariableDeclarator",
                    "start": 271,
                    "end": 287,
                    "id": {
                      "type": "Identifier",
                      "start": 271,
                      "end": 272,
                      "name": "O"
                    },
                    "init": {
                      "type": "CallExpression",
                      "start": 275,
                      "end": 287,
                      "callee": {
                        "type": "Identifier",
                        "start": 275,
                        "end": 281,
                        "name": "Object"
                      },
                      "arguments": [
                        {
                          "type": "ThisExpression",
                          "start": 282,
                          "end": 286
                        }
                      ],
                      "optional": false
                    }
                  }
                ],
                "kind": "var"
              },
              {
                "type": "VariableDeclaration",
                "start": 443,
                "end": 468,
                "declarations": [
                  {
                    "type": "VariableDeclarator",
                    "start": 447,
                    "end": 467,
                    "id": {
                      "type": "Identifier",
                      "start": 447,
                      "end": 450,
                      "name": "len"
                    },
                    "init": {
                      "type": "BinaryExpression",
                      "start": 453,
                      "end": 467,
                      "left": {
                        "type": "MemberExpression",
                        "start": 453,
                        "end": 461,
                        "object": {
                          "type": "Identifier",
                          "start": 453,
                          "end": 454,
                          "name": "O"
                        },
                        "property": {
                          "type": "Identifier",
                          "start": 455,
                          "end": 461,
                          "name": "length"
                        },
                        "computed": false,
                        "optional": false
                      },
                      "operator": ">>>",
                      "right": {
                        "type": "Literal",
                        "start": 466,
                        "end": 467,
                        "value": 0,
                        "raw": "0"
                      }
                    }
                  }
                ],
                "kind": "var"
              },
              {
                "type": "IfStatement",
                "start": 591,
                "end": 698,
                "test": {
                  "type": "BinaryExpression",
                  "start": 595,
                  "end": 625,
                  "left": {
                    "type": "UnaryExpression",
                    "start": 595,
                    "end": 610,
                    "operator": "typeof",
                    "prefix": true,
                    "argument": {
                      "type": "Identifier",
                      "start": 602,
                      "end": 610,
                      "name": "callback"
                    }
                  },
                  "operator": "!==",
                  "right": {
                    "type": "Literal",
                    "start": 615,
                    "end": 625,
                    "value": "function",
                    "raw": "\"function\""
                  }
                },
                "consequent": {
                  "type": "BlockStatement",
                  "start": 627,
                  "end": 698,
                  "body": [
                    {
                      "type": "ThrowStatement",
                      "start": 638,
                      "end": 691,
                      "argument": {
                        "type": "NewExpression",
                        "start": 644,
                        "end": 690,
                        "callee": {
                          "type": "Identifier",
                          "start": 648,
                          "end": 657,
                          "name": "TypeError"
                        },
                        "arguments": [
                          {
                            "type": "BinaryExpression",
                            "start": 658,
                            "end": 689,
                            "left": {
                              "type": "Identifier",
                              "start": 658,
                              "end": 666,
                              "name": "callback"
                            },
                            "operator": "+",
                            "right": {
                              "type": "Literal",
                              "start": 669,
                              "end": 689,
                              "value": " is not a function",
                              "raw": "\" is not a function\""
                            }
                          }
                        ]
                      }
                    }
                  ]
                },
                "alternate": null
              },
              {
                "type": "IfStatement",
                "start": 784,
                "end": 840,
                "test": {
                  "type": "BinaryExpression",
                  "start": 788,
                  "end": 808,
                  "left": {
                    "type": "MemberExpression",
                    "start": 788,
                    "end": 804,
                    "object": {
                      "type": "Identifier",
                      "start": 788,
                      "end": 797,
                      "name": "arguments"
                    },
                    "property": {
                      "type": "Identifier",
                      "start": 798,
                      "end": 804,
                      "name": "length"
                    },
                    "computed": false,
                    "optional": false
                  },
                  "operator": ">",
                  "right": {
                    "type": "Literal",
                    "start": 807,
                    "end": 808,
                    "value": 1,
                    "raw": "1"
                  }
                },
                "consequent": {
                  "type": "BlockStatement",
                  "start": 810,
                  "end": 840,
                  "body": [
                    {
                      "type": "ExpressionStatement",
                      "start": 821,
                      "end": 833,
                      "expression": {
                        "type": "AssignmentExpression",
                        "start": 821,
                        "end": 832,
                        "operator": "=",
                        "left": {
                          "type": "Identifier",
                          "start": 821,
                          "end": 822,
                          "name": "T"
                        },
                        "right": {
                          "type": "Identifier",
                          "start": 825,
                          "end": 832,
                          "name": "thisArg"
                        }
                      }
                    }
                  ]
                },
                "alternate": null
              },
              {
                "type": "ExpressionStatement",
                "start": 869,
                "end": 875,
                "expression": {
                  "type": "AssignmentExpression",
                  "start": 869,
                  "end": 874,
                  "operator": "=",
                  "left": {
                    "type": "Identifier",
                    "start": 869,
                    "end": 870,
                    "name": "k"
                  },
                  "right": {
                    "type": "Literal",
                    "start": 873,
                    "end": 874,
                    "value": 0,
                    "raw": "0"
                  }
                }
              },
              {
                "type": "WhileStatement",
                "start": 915,
                "end": 1670,
                "test": {
                  "type": "BinaryExpression",
                  "start": 922,
                  "end": 929,
                  "left": {
                    "type": "Identifier",
                    "start": 922,
                    "end": 923,
                    "name": "k"
                  },
                  "operator": "<",
                  "right": {
                    "type": "Identifier",
                    "start": 926,
                    "end": 929,
                    "name": "len"
                  }
                },
                "body": {
                  "type": "BlockStatement",
                  "start": 931,
                  "end": 1670,
                  "body": [
                    {
                      "type": "VariableDeclaration",
                      "start": 943,
                      "end": 954,
                      "declarations": [
                        {
                          "type": "VariableDeclarator",
                          "start": 947,
                          "end": 953,
                          "id": {
                            "type": "Identifier",
                            "start": 947,
                            "end": 953,
                            "name": "kValue"
                          },
                          "init": null
                        }
                      ],
                      "kind": "var"
                    },
                    {
                      "type": "IfStatement",
                      "start": 1266,
                      "end": 1617,
                      "test": {
                        "type": "BinaryExpression",
                        "start": 1270,
                        "end": 1276,
                        "left": {
                          "type": "Identifier",
                          "start": 1270,
                          "end": 1271,
                          "name": "k"
                        },
                        "operator": "in",
                        "right": {
                          "type": "Identifier",
                          "start": 1275,
                          "end": 1276,
                          "name": "O"
                        }
                      },
                      "consequent": {
                        "type": "BlockStatement",
                        "start": 1278,
                        "end": 1617,
                        "body": [
                          {
                            "type": "ExpressionStatement",
                            "start": 1396,
                            "end": 1410,
                            "expression": {
                              "type": "AssignmentExpression",
                              "start": 1396,
                              "end": 1409,
                              "operator": "=",
                              "left": {
                                "type": "Identifier",
                                "start": 1396,
                                "end": 1402,
                                "name": "kValue"
                              },
                              "right": {
                                "type": "MemberExpression",
                                "start": 1405,
                                "end": 1409,
                                "object": {
                                  "type": "Identifier",
                                  "start": 1405,
                                  "end": 1406,
                                  "name": "O"
                                },
                                "property": {
                                  "type": "Identifier",
                                  "start": 1407,
                                  "end": 1408,
                                  "name": "k"
                                },
                                "computed": true,
                                "optional": false
                              }
                            }
                          },
                          {
                            "type": "ExpressionStatement",
                            "start": 1575,
                            "end": 1606,
                            "expression": {
                              "type": "CallExpression",
                              "start": 1575,
                              "end": 1605,
                              "callee": {
                                "type": "MemberExpression",
                                "start": 1575,
                                "end": 1588,
                                "object": {
                                  "type": "Identifier",
                                  "start": 1575,
                                  "end": 1583,
                                  "name": "callback"
                                },
                                "property": {
                                  "type": "Identifier",
                                  "start": 1584,
                                  "end": 1588,
                                  "name": "call"
                                },
                                "computed": false,
                                "optional": false
                              },
                              "arguments": [
                                {
                                  "type": "Identifier",
                                  "start": 1589,
                                  "end": 1590,
                                  "name": "T"
                                },
                                {
                                  "type": "Identifier",
                                  "start": 1592,
                                  "end": 1598,
                                  "name": "kValue"
                                },
                                {
                                  "type": "Identifier",
                                  "start": 1600,
                                  "end": 1601,
                                  "name": "k"
                                },
                                {
                                  "type": "Identifier",
                                  "start": 1603,
                                  "end": 1604,
                                  "name": "O"
                                }
                              ],
                              "optional": false
                            }
                          }
                        ]
                      },
                      "alternate": null
                    },
                    {
                      "type": "ExpressionStatement",
                      "start": 1659,
                      "end": 1663,
                      "expression": {
                        "type": "UpdateExpression",
                        "start": 1659,
                        "end": 1662,
                        "operator": "++",
                        "prefix": false,
                        "argument": {
                          "type": "Identifier",
                          "start": 1659,
                          "end": 1660,
                          "name": "k"
                        }
                      }
                    }
                  ]
                }
              }
            ]
          }
        }
      }
    }
  ],
  "sourceType": "module"
}
```

#### 语法分析不做的事：

去掉注释：执行时会跳过注释

自动生成文档：从来不会自动生成文档

提供错误位置（如果 JavaScript 解释器在构造语法树的时候发现无法构造，就会报语法错误，并结束整个代码块的解析）：错误位置是由堆栈提供的。

#### 语法type类型

* VariableDeclaration 变量声明
* BinaryExpression 二元运算表达式；
* ExpressionStatement 表达式语句节点
* AssignmentExpression 赋值表达式
* MemberExpression 成员表达式
* ThisExpression This表达式
* Identifier 标识符
* ObjectExpression 对象表达式
* Property 属性
* NewExpression： new表达式
* VariableDeclarator  变量声明的描述
* Literal 字面量
* AssignmentOperator 赋值运算符
* CallExpression 函数调用表达式
* TemplateLiteral 字符串模板字面量
* TemplateElement 模板元素
* ArrowFunctionExpression 箭头函数表达式
* UpdateExpression update运算表达式节点，即++/--，配合该节点的prefix属性来标识前后
* FunctionDeclaration 函数声明
* AssignmentPattern 定义模式
* BlockStatement 块语句节点
* ClassDeclaration 类声明节点
* ClassBody 类定义体
* MethodDefinition 类方法定义
* FunctionExpression 函数表达式
* IfStatement if语句节点
* SwitchStatement switch 语句节点
* SwitchCase switch的case节点
* ForStatement for循环语句节点
* ImportDeclaration 模块声明
* ImportDefaultSpecifier 模块默认指向
* ExportDefaultDeclaration 模块导出默认声明

语法分析的过程就是把词法分析所产生的记号生成语法树，通俗地说，就是把从程序中收集的信息存储到数据结构中。注意，在编译中用到的数据结构有两种：符号表和语法树。
* 符号表：就是在程序中用来存储所有符号的一个表，包括所有的字符串变量、直接量字符串，以及函数和类。
* 语法树：就是程序结构的一个树形表示，用来生成中间代码。

如果 JavaScript 解释器在构造语法树的时候发现无法构造，就会报语法错误，并结束整个代码块的解析。对于传统强类型语言来说，在通过语法分析构造出语法树后，翻译出来的句子可能还会有模糊不清的地方，需要进一步的语义检查。语义检查的主要部分是类型检查。例如，函数的实参和形参类型是否匹配。但是，对于弱类型语言来说，就没有这一步。

## 2.执行（调用栈）

1. 新建执行上下文
   1. 预编译（变量提升，作用域链创建）

      * 词法环境
        * 外部引用——记录父级词法环境（作用域链）
        * 环境记录
          * 声明性环境记录——即ES3中的活动对象，记录当前函数环境内的所有局部变量、函数和形参。直接存储在虚拟机的寄存器中，提高访问效率。
          * 对象环境记录——全局环境的词法环境还是实现为对象

      * 变量环境——当前环境使用的所有变量（局部变量）、函数和形参——就是原来ES3的变量对象

2. 逐行解释执行当前执行上下文中的代码

   1. 同步
   2. 异步
   1. 事件循环
      2. 任务队列
      1. 宏任务
         2. 微任务
      3. Web API

