第 58 题：箭头函数与普通函数（function）的区别是什么？构造函数（function）可以使用 new 生成实例，那么箭头函数可以吗？为什么？ · Issue #101 · Advanced-Frontend/Daily-Interview-Question

 [New issue](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/new/choose)

#    第 58 题：箭头函数与普通函数（function）的区别是什么？构造函数（function）可以使用 new 生成实例，那么箭头函数可以吗？为什么？   #101

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='16' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' aria-hidden='true' data-evernote-id='39'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='1737' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [zeroone001](https://github.com/zeroone001) opened this issueon 19 Apr 2019· 17 comments

## Comments

 [![9162197](../_resources/9f40574f02ef956d3e3e54f6370d8cf9.jpg)](https://github.com/zeroone001)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='41'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='1772' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='42'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='1787' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [zeroone001](https://github.com/zeroone001)  ** commented [on 19 Apr 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issue-434992452)

|     |
| --- |
|  *No description provided.* |

 [![13692434](../_resources/fac123c08985584ab1610c3ef5466046.jpg)](https://github.com/lmjben)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='44'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='1827' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='45'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='1842' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [lmjben](https://github.com/lmjben)  ** commented [on 19 Apr 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-484730708)    •

  edited   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-triangle-down v-align-middle js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='47'%3e%3cpath d='M4.427 7.427l3.396 3.396a.25.25 0 00.354 0l3.396-3.396A.25.25 0 0011.396 7H4.604a.25.25 0 00-.177.427z' data-evernote-id='1878' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

|     |
| --- |
| 箭头函数是普通函数的简写，可以更优雅的定义一个函数，和普通函数相比，有以下几点差异：<br>1、函数体内的 this 对象，就是定义时所在的对象，而不是使用时所在的对象。<br>2、不可以使用 arguments 对象，该对象在函数体内不存在。如果要用，可以用 rest 参数代替。<br>3、不可以使用 yield 命令，因此箭头函数不能用作 Generator 函数。<br>4、不可以使用 new 命令，因为：<br>- 没有自己的 this，无法调用 call，apply。<br>- 没有 prototype 属性 ，而 new 命令在执行时需要将构造函数的 prototype 赋值给新的对象的 __proto__<br>new 过程大致是这样的：<br>function  newFunc(father, ...rest)  {  var  result  =  {};  result.__proto__  =  father.prototype;  var  result2  =  father.apply(result,  rest);  if  (  (typeof  result2  ===  'object'  \|\|  typeof  result2  ===  'function')  &&  result2 !== null  )  {  return  result2;  }  return  result;} |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='48'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='1965' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![26347008](../_resources/b775b280f422649510a6348f2c1a4bc2.jpg)](https://github.com/ZavierTang)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='49'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='1987' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='50'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2002' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [ZavierTang](https://github.com/ZavierTang)  ** commented [on 19 Apr 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-484730765)    •

  edited   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-triangle-down v-align-middle js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='52'%3e%3cpath d='M4.427 7.427l3.396 3.396a.25.25 0 00.354 0l3.396-3.396A.25.25 0 0011.396 7H4.604a.25.25 0 00-.177.427z' data-evernote-id='2038' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

|     |
| --- |
| 引入箭头函数有两个方面的作用：更简短的函数并且不绑定this。箭头函数与普通函数不同之处有：<br>1. 箭头函数没有 this，它会从自己的作用域链的上一层继承 this（因此无法使用 apply / call / bind 进行绑定 this 值）；<br>2. 不绑定 arguments，当在箭头函数中调用 aruguments 时同样会向作用域链中查询结果；<br>3. 不绑定 super 和 new.target；<br>4. 没有 prototype 属性，即指向 undefined；<br>5. 无法使用 new 实例化对象，因为普通构造函数通过 new 实例化对象时 this 指向实例对象，而箭头函数没有 this 值，同时 箭头函数也没有 prototype。 |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='53'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='2059' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![26347008](../_resources/b775b280f422649510a6348f2c1a4bc2.jpg)](https://github.com/ZavierTang)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='54'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='2081' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='55'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2096' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [ZavierTang](https://github.com/ZavierTang)  ** commented [on 19 Apr 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-484733295)

|     |
| --- |
| > 箭头函数是普通函数的简写，可以更优雅的定义一个函数，和普通函数相比，有以下几点差异：<br>> 1、函数体内的 this 对象，就是定义时所在的对象，而不是使用时所在的对象。<br>> 2、不可以使用 arguments 对象，该对象在函数体内不存在。如果要用，可以用 rest 参数代替。<br>> 3、不可以使用 yield 命令，因此箭头函数不能用作 Generator 函数。<br>> 4、不可以使用 new 命令，因为：<br>- > 没有自己的 this，无法调用 call，apply。<br>- > 没有 prototype 属性 ，而 new 命令在执行时需要将构造函数的 prototype 赋值给新的对象的 **> proto**<br>> new 过程大致是这样的：<br>> function>   > newFunc> (> father> ,>  ...> rest> )>   > {>   > var>   > result>   > =>   > {> }> ;>   > result> .> __proto__>   > =>   > father> .> prototype> ;>   > var>   > result2>   > =>   > father> .> apply> (> result> ,>   > rest> )> ;>   > if>   > (>   > (> typeof>   > result2>   > ===>   > 'object'>   > \|\|>   > typeof>   > result2>   > ===>   > 'function'> )>   > &&>   > result2>  !== > null>   > )>   > {>   > return>   > result2> ;>   > }>   > return>   > result> ;> }<br>"函数体内的 this 对象，就是定义时所在的对象，而不是使用时所在的对象。" 也不能说是定义时所在的对象吧，应该是定义时所在的作用域中的 this 值，因为 JS 的静态作用域的机制，this 相当于一个普通变量会向作用域链中查询结果，同时定义时所在对象也并不等于所在对象中的 this 值。 |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='57'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='2211' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![25497230](../_resources/a5428765e37d2c2983cd8db76ae3e978.jpg)](https://github.com/coolliyong)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='58'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='2233' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='59'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2248' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [coolliyong](https://github.com/coolliyong)  ** commented [on 19 Apr 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-484741125)    •

  edited   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-triangle-down v-align-middle js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='61'%3e%3cpath d='M4.427 7.427l3.396 3.396a.25.25 0 00.354 0l3.396-3.396A.25.25 0 0011.396 7H4.604a.25.25 0 00-.177.427z' data-evernote-id='2284' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

区别：

1.箭头函数没有自己的[object Object]属性、[object Object]属性、而普通函数有，箭头函数的this指向当前函数作用域的[object Object]。

new：
2.箭头函数没有[object Object]显示原型，所以不能作为构造函数。
箭头函数带来的好处：

- 没有箭头函数的时候，函数闭包 [object Object] 的事没少干，有了箭头函数，就不需要这么写了。
- 极简语法，函数式风格，写一时爽一时，一直写一直爽！

 [![27949553](../_resources/ac65a09d507d754095a9ebae00ac54e9.jpg)](https://github.com/Caaalabash)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='63'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='2324' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='64'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2339' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [Caaalabash](https://github.com/Caaalabash)  ** commented [on 19 Apr 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-484741764)

### 箭头函数不能通过new关键字调用原因

[object Object]函数两个内部方法: [object Object]和[object Object]

- 直接调用时执行[object Object]方法, 直接执行函数体
- [object Object]调用时执行[object Object]方法, 创建一个实例对象blabla(如下)

[object Object]
箭头函数并没有[object Object]方法, 所以不能被用作构造函数
另外, 可以参考[object Object]中的[object Object]方法

[object Object]>  方法用于拦截[object Object]> 操作符. 为了使[object Object]> 操作符在生成的[object Object]> 对象上生效，用于初始化代理的目标对象自身必须具有[object Object]> 内部方法（即 [object Object]>  必须是有效的）。

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='66'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='2393' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![26050644](../_resources/f6ea47cc2896f363672b7816cc66d67a.jpg)](https://github.com/Flcwl)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='67'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='2415' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='68'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2430' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [Flcwl](https://github.com/Flcwl)  ** commented [on 20 Apr 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-485053056)    •

  edited   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-triangle-down v-align-middle js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='70'%3e%3cpath d='M4.427 7.427l3.396 3.396a.25.25 0 00.354 0l3.396-3.396A.25.25 0 0011.396 7H4.604a.25.25 0 00-.177.427z' data-evernote-id='2466' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

|     |
| --- |
| 没有自己的this，无法指向自身。构造函数生成对象需要调用函数初始化属性。 |

 [![38586385](../_resources/cd5d93e3f5a4e898c71abe905314994d.jpg)](https://github.com/huijingL)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='72'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='2499' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='73'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2514' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [huijingL](https://github.com/huijingL)  ** commented [on 21 Apr 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-485231347)

|     |
| --- |
| 我也来献个丑：<br>箭头函数是ES6的写法，与function最大的不同是this的指向问题，<br>箭头函数内部的this 是继承自其上一级<br>而function 的this是看情况指向的，一般优先级是 new > bind > obj. > window<br>new 的本质是生成一个新对象，将对象的_proto_指向函数的prototype,再执行call 方法，最后将新对象赋给定义的对象，<br>而箭头函数既无自己的this，也没有prototype 所以不行。<br>前端新手，有错误的话请不要客气，直接指出，谢谢。 |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='75'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='2564' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![24588825](../_resources/1d972e640c84e018d8f027edb43b621a.jpg)](https://github.com/superermiao)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='76'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='2586' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='77'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2601' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [superermiao](https://github.com/superermiao)  ** commented [on 24 Apr 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-486169996)

箭头函数与普通函数区别：
（1）箭头函数体内的this对象，就是定义时所在的对象，而不是使用时所在的对象。例子：
var person = {
name: '叮当猫',
sayName:function () {
console.log(this.name)
},
sayHi: function(){
(() => { console.log('hi') ; this.sayName() })()
}
}
person.sayHi()
// hi
// 叮当猫

* * *

[object Object]
// hi
//Uncaught TypeError: this.sayName is not a function
at :7:44
at Object.sayHi
at :10:14
并且箭头函数的this是固定的。不是可变的。
（2）不可以当作构造函数，箭头函数根本没有自己的this，导致内部的this就是外层代码块的this。正是因为它没有this，所以也就不能用作构造函数。
var func= ()=>{this.name = 'ss'}
var personOne = new func()
//VM708:2 Uncaught TypeError: func is not a constructor
（3）不可以使用arguments对象，该对象在函数体内不存在。如果要用，可以用 rest 参数代替。
（4）不可以使用yield命令，因此箭头函数不能用作 Generator 函数。

 [![26019582](../_resources/781cf1b4e082fd8573aa0cf60095948a.jpg)](https://github.com/Vikingama)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='80'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='2689' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='81'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2704' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [Vikingama](https://github.com/Vikingama)  ** commented [on 24 Apr 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-486201024)

|     |
| --- |
| 剪头函数没有自己的 this，不能用作构造函数 |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-cross-reference js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='84'%3e%3cpath fill-rule='evenodd' d='M16 1.25v4.146a.25.25 0 01-.427.177L14.03 4.03l-3.75 3.75a.75.75 0 11-1.06-1.06l3.75-3.75-1.543-1.543A.25.25 0 0111.604 1h4.146a.25.25 0 01.25.25zM2.75 3.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h2a.75.75 0 01.75.75v2.19l2.72-2.72a.75.75 0 01.53-.22h4.5a.25.25 0 00.25-.25v-2.5a.75.75 0 111.5 0v2.5A1.75 1.75 0 0113.25 13H9.06l-2.573 2.573A1.457 1.457 0 014 14.543V13H2.75A1.75 1.75 0 011 11.25v-7.5C1 2.784 1.784 2 2.75 2h5.5a.75.75 0 010 1.5h-5.5z' data-evernote-id='2763' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![22773923](../_resources/0741f060e2278c8c05e3f4b6b029d4f8.jpg)](https://github.com/yidafu)[yidafu](https://github.com/yidafu) mentioned this issue [on 25 Apr 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#ref-issue-436966700)

 [arrow functionyidafu/notes#13](https://github.com/yidafu/notes/issues/13)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-closed js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='85'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 0110.65-5.003.75.75 0 00.959-1.153 8 8 0 102.592 8.33.75.75 0 10-1.444-.407A6.5 6.5 0 011.5 8zM8 12a1 1 0 100-2 1 1 0 000 2zm0-8a.75.75 0 01.75.75v3.5a.75.75 0 11-1.5 0v-3.5A.75.75 0 018 4zm4.78 4.28l3-3a.75.75 0 00-1.06-1.06l-2.47 2.47-.97-.97a.749.749 0 10-1.06 1.06l1.5 1.5a.75.75 0 001.06 0z' data-evernote-id='2772' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Closed

 [![32598811](../_resources/d0b30b7769768d820cc60883b2ea1b50.jpg)](https://github.com/fireairforce)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='86'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='2780' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='87'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2795' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [fireairforce](https://github.com/fireairforce)  ** commented [on 22 May 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-494456045)

|     |
| --- |
| 箭头函数由于this的指向在它定义的时候已经确定了(它外层代码的this)，并不像其他普通函数在执行的时候确定this的指向，所以在new 的时候不会改变this的指向(在new 的过程中this会变成空对象然后指向对应的地方) |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-cross-reference js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='90'%3e%3cpath fill-rule='evenodd' d='M16 1.25v4.146a.25.25 0 01-.427.177L14.03 4.03l-3.75 3.75a.75.75 0 11-1.06-1.06l3.75-3.75-1.543-1.543A.25.25 0 0111.604 1h4.146a.25.25 0 01.25.25zM2.75 3.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h2a.75.75 0 01.75.75v2.19l2.72-2.72a.75.75 0 01.53-.22h4.5a.25.25 0 00.25-.25v-2.5a.75.75 0 111.5 0v2.5A1.75 1.75 0 0113.25 13H9.06l-2.573 2.573A1.457 1.457 0 014 14.543V13H2.75A1.75 1.75 0 011 11.25v-7.5C1 2.784 1.784 2 2.75 2h5.5a.75.75 0 010 1.5h-5.5z' data-evernote-id='2854' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![18049290](../_resources/fff6492408e87463e314a25f1fc51707.jpg)](https://github.com/yygmind)[yygmind](https://github.com/yygmind) mentioned this issue [on 14 Jul 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#ref-issue-467790870)

 [前端 100 问：能搞懂80%的请把简历给我yygmind/blog#43](https://github.com/yygmind/blog/issues/43)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='91'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='2863' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [![29700023](../_resources/1c4f315ca1a3779d1206a497a2784078.jpg)](https://github.com/mofiggHasSugar)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='92'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='2871' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='93'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2886' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [mofiggHasSugar](https://github.com/mofiggHasSugar)  ** commented [on 25 Jul 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-514991419)

|     |
| --- |
| let num1 = [1,2,2,1];<br>let num2 = [2,2];<br>let res = [];<br>let obj = {};<br>function fn(n1,n2) {<br>for(let i = 0;i<n1.length;i++){<br>if(!obj[n1[i]]){<br>obj[n1[i]] = 1;<br>}else{<br>obj[n1[i]]++<br>}<br>}<br>for(let i = 0;i<n2.length;i++){<br>if(obj[n2[i]]){<br>res.push(n2[i]);<br>obj[n2[i]]--;<br>}<br>}<br>return res<br>}<br>console.log(fn(num1,num2)) |

 [![35484453](../_resources/3c18ba1b56491278455b0d76ecdcc3f9.jpg)](https://github.com/spongege)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='96'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='2969' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='97'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='2984' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [spongege](https://github.com/spongege)  ** commented [on 9 Sep 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-529359472)

|     |
| --- |
| 箭头函数的this是上下文的this，它会从自己作用域的上一层继承this<br>箭头函数自身没有arguments（但是可以向作用域链中查找arguments）， 不能使用yield命令，不能做generator函数<br>箭头函数不可以使用new，因为箭头函数没有prototype（使用new需要把函数的prototype赋值给新对象的__proto__），没有自己的this，不能调用call和apply |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='99'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='3030' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-cross-reference js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='100'%3e%3cpath fill-rule='evenodd' d='M16 1.25v4.146a.25.25 0 01-.427.177L14.03 4.03l-3.75 3.75a.75.75 0 11-1.06-1.06l3.75-3.75-1.543-1.543A.25.25 0 0111.604 1h4.146a.25.25 0 01.25.25zM2.75 3.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h2a.75.75 0 01.75.75v2.19l2.72-2.72a.75.75 0 01.53-.22h4.5a.25.25 0 00.25-.25v-2.5a.75.75 0 111.5 0v2.5A1.75 1.75 0 0113.25 13H9.06l-2.573 2.573A1.457 1.457 0 014 14.543V13H2.75A1.75 1.75 0 011 11.25v-7.5C1 2.784 1.784 2 2.75 2h5.5a.75.75 0 010 1.5h-5.5z' data-evernote-id='3048' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![22773923](../_resources/0741f060e2278c8c05e3f4b6b029d4f8.jpg)](https://github.com/yidafu)[yidafu](https://github.com/yidafu) mentioned this issue [on 16 Sep 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#ref-issue-455213775)

 [ES6+yidafu/notes#23](https://github.com/yidafu/notes/issues/23)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='101'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='3057' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [![10781715](../_resources/f5d6c61c68a879f0a93bd8f95eca00ff.jpg)](https://github.com/MrTenger)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='102'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='3065' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='103'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3080' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [MrTenger](https://github.com/MrTenger)  ** commented [on 21 Nov 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-557027769)

|     |
| --- |
| - 箭头函数语法简洁多了<br>- 箭头函数没有自己的this，它里面的this指向函数所处的上下文，call和apply也没法改变this指向<br>- 箭头函数没有arguments(类数组)，只能基于…arg获取传递得参数集合（数组）<br>箭头函数不能被 new 执行，不能用作构造函数。因为箭头函数没有prototype ，也没有自己的this，不能调用call和apply |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-tag js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='106'%3e%3cpath fill-rule='evenodd' d='M2.5 7.775V2.75a.25.25 0 01.25-.25h5.025a.25.25 0 01.177.073l6.25 6.25a.25.25 0 010 .354l-5.025 5.025a.25.25 0 01-.354 0l-6.25-6.25a.25.25 0 01-.073-.177zm-1.5 0V2.75C1 1.784 1.784 1 2.75 1h5.025c.464 0 .91.184 1.238.513l6.25 6.25a1.75 1.75 0 010 2.474l-5.026 5.026a1.75 1.75 0 01-2.474 0l-6.25-6.25A1.75 1.75 0 011 7.775zM6 5a1 1 0 100 2 1 1 0 000-2z' data-evernote-id='3143' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![18049290](../_resources/fff6492408e87463e314a25f1fc51707.jpg)](https://github.com/yygmind)[yygmind](https://github.com/yygmind) added the   [JS基础](https://github.com/Advanced-Frontend/Daily-Interview-Question/labels/JS%E5%9F%BA%E7%A1%80) label [on 16 Dec 2019](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#event-2884591804)

 [![24450293](../_resources/d1d33e7afa14aa01d6f49b62519020b1.jpg)](https://github.com/Been101)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='107'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='3154' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='108'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3169' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [Been101](https://github.com/Been101)  ** commented [on 4 Jan](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-570768465)    •

  edited   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-triangle-down v-align-middle js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='110'%3e%3cpath d='M4.427 7.427l3.396 3.396a.25.25 0 00.354 0l3.396-3.396A.25.25 0 0011.396 7H4.604a.25.25 0 00-.177.427z' data-evernote-id='3205' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

|     |
| --- |
| 为什么不能当Generator 函数使用 |

 [![20236883](../_resources/ed6b3b00df52ecd53be4dfae8e27f016.jpg)](https://github.com/zowiegong)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='112'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='3238' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='113'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3253' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [zowiegong](https://github.com/zowiegong)  ** commented [on 6 Jan](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-571106186)

|     |
| --- |
| 箭头函数具有以下特性：<br>1. 没有自己的 this<br>    - 函数不会创建自己的 this，它只会从自己的作用域链的上一层继承 this<br>    - 通过 call 或 apply 调用不会改变 this 指向<br>    - 箭头函数不能用作构造器，和 new一起用会抛出错误<br>    - 所以箭头函数不适合做方法函数<br>2. 没有自己的 arguments<br>3. 没有自己的 super 或 new.target<br>    - super 关键字用于访问和调用一个对象的父对象上的函数。<br>    - new.target 属性允许你检测函数或构造方法是否是通过 new 运算符被调用的<br>4. 箭头函数没有 prototype 属性<br>5. yield 关键字通常不能在箭头函数中使用（除非是嵌套在允许使用的函数内）。因此，箭头函数不能用作函数生成器<br>6. 当只有一个参数时，圆括号是可选的<br>7. 加圆括号的函数体返回对象字面量表达式<br>8. 支持剩余参数和默认参数<br>9. 同样支持参数列表解构 |

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-cross-reference js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='116'%3e%3cpath fill-rule='evenodd' d='M16 1.25v4.146a.25.25 0 01-.427.177L14.03 4.03l-3.75 3.75a.75.75 0 11-1.06-1.06l3.75-3.75-1.543-1.543A.25.25 0 0111.604 1h4.146a.25.25 0 01.25.25zM2.75 3.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h2a.75.75 0 01.75.75v2.19l2.72-2.72a.75.75 0 01.53-.22h4.5a.25.25 0 00.25-.25v-2.5a.75.75 0 111.5 0v2.5A1.75 1.75 0 0113.25 13H9.06l-2.573 2.573A1.457 1.457 0 014 14.543V13H2.75A1.75 1.75 0 011 11.25v-7.5C1 2.784 1.784 2 2.75 2h5.5a.75.75 0 010 1.5h-5.5z' data-evernote-id='3330' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 [![6823623](../_resources/1435be2999aaaa7884438b3d379ebd0e.png)](https://github.com/yaofly2012)[yaofly2012](https://github.com/yaofly2012) mentioned this issue [on 13 Feb](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#ref-issue-564654869)

 [JS-ES6-箭头函数yaofly2012/note#105](https://github.com/yaofly2012/note/issues/105)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' height='14' class='octicon octicon-issue-opened js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='14' aria-hidden='true' data-evernote-id='117'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z' data-evernote-id='3339' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e) Open

 [![15606183](../_resources/56992f5084aa0ee2753896a5c8430b8e.jpg)](https://github.com/soraly)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='118'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='3347' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='119'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3362' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [soraly](https://github.com/soraly)  ** commented [on 24 Jun](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-648716492)

|     |
| --- |
| ### 箭头函数与普通函数（function）的区别是什么？构造函数（function）可以使用 new 生成实例，那么箭头函数可以吗？为什么<br>- 区别1，this指向的区别，function里的this会指向调用该函数的对象，箭头函数里的this是指向作用域里的this，本身没有this指向<br>- 区别2，箭头函数没有arguments<br>- 区别3，yield 关键字不能在箭头函数中使用<br>- 箭头函数不能用new生成实例，因为箭头函数没有prototype属性，而new操作有一步是要把函数的prototype属性赋值给实例的__proto__，所以不能进行new操作 |

 [![65157428](../_resources/d7fc4f0ac857ce7e20784c19569773af.png)](https://github.com/Verahuan)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-smiley js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='122'%3e%3cpath fill-rule='evenodd' d='M1.5 8a6.5 6.5 0 1113 0 6.5 6.5 0 01-13 0zM8 0a8 8 0 100 16A8 8 0 008 0zM5 8a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zM5.32 9.636a.75.75 0 011.038.175l.007.009c.103.118.22.222.35.31.264.178.683.37 1.285.37.602 0 1.02-.192 1.285-.371.13-.088.247-.192.35-.31l.007-.008a.75.75 0 111.222.87l-.614-.431c.614.43.614.431.613.431v.001l-.001.002-.002.003-.005.007-.014.019a1.984 1.984 0 01-.184.213c-.16.166-.338.316-.53.445-.63.418-1.37.638-2.127.629-.946 0-1.652-.308-2.126-.63a3.32 3.32 0 01-.715-.657l-.014-.02-.005-.006-.002-.003v-.002h-.001l.613-.432-.614.43a.75.75 0 01.183-1.044h.001z' data-evernote-id='3430' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' aria-label='Show options' class='octicon octicon-kebab-horizontal js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' role='img' data-evernote-id='123'%3e%3cpath d='M8 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zM1.5 9a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm13 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z' data-evernote-id='3445' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

###   **  [Verahuan](https://github.com/Verahuan)  ** commented [on 25 Jul](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/101#issuecomment-663865420)

|     |
| --- |
| > 箭头函数是普通函数的简写，可以更优雅的定义一个函数，和普通函数相比，有以下几点差异：<br>> 1、函数体内的 this 对象，就是定义时所在的对象，而不是使用时所在的对象。<br>> 2、不可以使用 arguments 对象，该对象在函数体内不存在。如果要用，可以用 rest 参数代替。<br>> 3、不可以使用 yield 命令，因此箭头函数不能用作 Generator 函数。<br>> 4、不可以使用 new 命令，因为：<br>- > 没有自己的 this，无法调用 call，apply。<br>- > 没有 prototype 属性 ，而 new 命令在执行时需要将构造函数的 prototype 赋值给新的对象的 **> proto**<br>> new 过程大致是这样的：<br>> function>   > newFunc> (> father> ,>  ...> rest> )>   > {>   > var>   > result>   > =>   > {> }> ;>   > result> .> __proto__>   > =>   > father> .> prototype> ;>   > var>   > result2>   > =>   > father> .> apply> (> result> ,>   > rest> )> ;>   > if>   > (>   > (> typeof>   > result2>   > ===>   > 'object'>   > \|\|>   > typeof>   > result2>   > ===>   > 'function'> )>   > &&>   > result2>  !== > null>   > )>   > {>   > return>   > result2> ;>   > }>   > return>   > result> ;> }<br>你好，我想请问一下，后面判断result的用意是什么呢？ |

 [![10215241](../_resources/48f9babaca4db32a4ef43417b19bbab6.png)](https://github.com/hjb2722404)

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-heading js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='129'%3e%3cpath fill-rule='evenodd' d='M3.75 2a.75.75 0 01.75.75V7h7V2.75a.75.75 0 011.5 0v10.5a.75.75 0 01-1.5 0V8.5h-7v4.75a.75.75 0 01-1.5 0V2.75A.75.75 0 013.75 2z' data-evernote-id='3591' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  Add header text    ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-bold js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='130'%3e%3cpath fill-rule='evenodd' d='M4 2a1 1 0 00-1 1v10a1 1 0 001 1h5.5a3.5 3.5 0 001.852-6.47A3.5 3.5 0 008.5 2H4zm4.5 5a1.5 1.5 0 100-3H5v3h3.5zM5 9v3h4.5a1.5 1.5 0 000-3H5z' data-evernote-id='3593' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  Add bold text <ctrl+b>    ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-italic js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='131'%3e%3cpath fill-rule='evenodd' d='M6 2.75A.75.75 0 016.75 2h6.5a.75.75 0 010 1.5h-2.505l-3.858 9H9.25a.75.75 0 010 1.5h-6.5a.75.75 0 010-1.5h2.505l3.858-9H6.75A.75.75 0 016 2.75z' data-evernote-id='3595' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  Add italic text <ctrl+i>

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-quote js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='132'%3e%3cpath fill-rule='evenodd' d='M1.75 2.5a.75.75 0 000 1.5h10.5a.75.75 0 000-1.5H1.75zm4 5a.75.75 0 000 1.5h8.5a.75.75 0 000-1.5h-8.5zm0 5a.75.75 0 000 1.5h8.5a.75.75 0 000-1.5h-8.5zM2.5 7.75a.75.75 0 00-1.5 0v6a.75.75 0 001.5 0v-6z' data-evernote-id='3598' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  Insert a quote    ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-code js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='133'%3e%3cpath fill-rule='evenodd' d='M4.72 3.22a.75.75 0 011.06 1.06L2.06 8l3.72 3.72a.75.75 0 11-1.06 1.06L.47 8.53a.75.75 0 010-1.06l4.25-4.25zm6.56 0a.75.75 0 10-1.06 1.06L13.94 8l-3.72 3.72a.75.75 0 101.06 1.06l4.25-4.25a.75.75 0 000-1.06l-4.25-4.25z' data-evernote-id='3600' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  Insert code    ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-link js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='135'%3e%3cpath fill-rule='evenodd' d='M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z' data-evernote-id='3603' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  Add a link <ctrl+k>

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-list-unordered js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='136'%3e%3cpath fill-rule='evenodd' d='M2 4a1 1 0 100-2 1 1 0 000 2zm3.75-1.5a.75.75 0 000 1.5h8.5a.75.75 0 000-1.5h-8.5zm0 5a.75.75 0 000 1.5h8.5a.75.75 0 000-1.5h-8.5zm0 5a.75.75 0 000 1.5h8.5a.75.75 0 000-1.5h-8.5zM3 8a1 1 0 11-2 0 1 1 0 012 0zm-1 6a1 1 0 100-2 1 1 0 000 2z' data-evernote-id='3606' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  Add a bulleted list    ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-list-ordered js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='137'%3e%3cpath fill-rule='evenodd' d='M2.003 2.5a.5.5 0 00-.723-.447l-1.003.5a.5.5 0 00.446.895l.28-.14V6H.5a.5.5 0 000 1h2.006a.5.5 0 100-1h-.503V2.5zM5 3.25a.75.75 0 01.75-.75h8.5a.75.75 0 010 1.5h-8.5A.75.75 0 015 3.25zm0 5a.75.75 0 01.75-.75h8.5a.75.75 0 010 1.5h-8.5A.75.75 0 015 8.25zm0 5a.75.75 0 01.75-.75h8.5a.75.75 0 010 1.5h-8.5a.75.75 0 01-.75-.75zM.924 10.32l.003-.004a.851.851 0 01.144-.153A.66.66 0 011.5 10c.195 0 .306.068.374.146a.57.57 0 01.128.376c0 .453-.269.682-.8 1.078l-.035.025C.692 11.98 0 12.495 0 13.5a.5.5 0 00.5.5h2.003a.5.5 0 000-1H1.146c.132-.197.351-.372.654-.597l.047-.035c.47-.35 1.156-.858 1.156-1.845 0-.365-.118-.744-.377-1.038-.268-.303-.658-.484-1.126-.484-.48 0-.84.202-1.068.392a1.858 1.858 0 00-.348.384l-.007.011-.002.004-.001.002-.001.001a.5.5 0 00.851.525zM.5 10.055l-.427-.26.427.26z' data-evernote-id='3608' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  Add a numbered list    ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-tasklist js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='138'%3e%3cpath fill-rule='evenodd' d='M2.5 2.75a.25.25 0 01.25-.25h10.5a.25.25 0 01.25.25v10.5a.25.25 0 01-.25.25H2.75a.25.25 0 01-.25-.25V2.75zM2.75 1A1.75 1.75 0 001 2.75v10.5c0 .966.784 1.75 1.75 1.75h10.5A1.75 1.75 0 0015 13.25V2.75A1.75 1.75 0 0013.25 1H2.75zm9.03 5.28a.75.75 0 00-1.06-1.06L6.75 9.19 5.28 7.72a.75.75 0 00-1.06 1.06l2 2a.75.75 0 001.06 0l4.5-4.5z' data-evernote-id='3610' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  Add a task list

   ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-mention js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='139'%3e%3cpath fill-rule='evenodd' d='M4.75 2.37a6.5 6.5 0 006.5 11.26.75.75 0 01.75 1.298 8 8 0 113.994-7.273.754.754 0 01.006.095v1.5a2.75 2.75 0 01-5.072 1.475A4 4 0 1112 8v1.25a1.25 1.25 0 002.5 0V7.867a6.5 6.5 0 00-9.75-5.496V2.37zM10.5 8a2.5 2.5 0 10-5 0 2.5 2.5 0 005 0z' data-evernote-id='3613' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  Directly mention a user or team    ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-cross-reference js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='141'%3e%3cpath fill-rule='evenodd' d='M16 1.25v4.146a.25.25 0 01-.427.177L14.03 4.03l-3.75 3.75a.75.75 0 11-1.06-1.06l3.75-3.75-1.543-1.543A.25.25 0 0111.604 1h4.146a.25.25 0 01.25.25zM2.75 3.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h2a.75.75 0 01.75.75v2.19l2.72-2.72a.75.75 0 01.53-.22h4.5a.25.25 0 00.25-.25v-2.5a.75.75 0 111.5 0v2.5A1.75 1.75 0 0113.25 13H9.06l-2.573 2.573A1.457 1.457 0 014 14.543V13H2.75A1.75 1.75 0 011 11.25v-7.5C1 2.784 1.784 2 2.75 2h5.5a.75.75 0 010 1.5h-5.5z' data-evernote-id='3617' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)  Reference an issue or pull request

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-reply js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='142'%3e%3cpath fill-rule='evenodd' d='M6.78 1.97a.75.75 0 010 1.06L3.81 6h6.44A4.75 4.75 0 0115 10.75v2.5a.75.75 0 01-1.5 0v-2.5a3.25 3.25 0 00-3.25-3.25H3.81l2.97 2.97a.75.75 0 11-1.06 1.06L1.47 7.28a.75.75 0 010-1.06l4.25-4.25a.75.75 0 011.06 0z' data-evernote-id='3618' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)

            Attach files by dragging & dropping, selecting or pasting them.       [![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-markdown v-align-bottom js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='150'%3e%3cpath fill-rule='evenodd' d='M14.85 3H1.15C.52 3 0 3.52 0 4.15v7.69C0 12.48.52 13 1.15 13h13.69c.64 0 1.15-.52 1.15-1.15v-7.7C16 3.52 15.48 3 14.85 3zM9 11H7V8L5.5 9.92 4 8v3H2V5h2l1.5 2L7 5h2v6zm2.99.5L9.5 8H11V5h2v3h1.5l-2.51 3.5z' data-evernote-id='3670' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)](https://guides.github.com/features/mastering-markdown/)  Styling with Markdown is supported

 ![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' class='octicon octicon-info mr-1 js-evernote-checked' viewBox='0 0 16 16' version='1.1' width='16' height='16' aria-hidden='true' data-evernote-id='151'%3e%3cpath fill-rule='evenodd' d='M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm6.5-.25A.75.75 0 017.25 7h1a.75.75 0 01.75.75v2.75h.25a.75.75 0 010 1.5h-2a.75.75 0 010-1.5h.25v-2h-.25a.75.75 0 01-.75-.75zM8 6a1 1 0 100-2 1 1 0 000 2z' data-evernote-id='3680' class='js-evernote-checked'%3e%3c/path%3e%3c/svg%3e)Remember, contributions to this repository should follow our [GitHub Community Guidelines](https://docs.github.com/articles/github-community-guidelines).

Assignees
  No one assigned

Labels

 [JS基础](https://github.com/Advanced-Frontend/Daily-Interview-Question/labels/JS%E5%9F%BA%E7%A1%80)

Projects
  None yet

Milestone
No milestone

Linked pull requests

Successfully merging a pull request may close this issue.
None yet

Notifications
 Customize

You’re not receiving notifications from this thread.

18 participants

 [![9162197](../_resources/8029d427da0cdfc6b710fa312bde0679.jpg)](https://github.com/zeroone001)  [![10781715](../_resources/a61498ebb5b673fa949e03a4db3fc796.jpg)](https://github.com/MrTenger)  [![13692434](../_resources/f93e1575cef2d9e6baaff1abd19d39fb.jpg)](https://github.com/lmjben)  [![15606183](../_resources/2d4e5c025559a13f93bdb68bcc8d71c1.jpg)](https://github.com/soraly)  [![18049290](../_resources/c4c2eeaf33db835461e4b3331898e353.jpg)](https://github.com/yygmind)  [![20236883](../_resources/a99170a0224104387529ce70a09b0dcb.jpg)](https://github.com/zowiegong)  [![24450293](../_resources/bcdc067d88e1acb69431de308428bf88.jpg)](https://github.com/Been101)  [![24588825](../_resources/3d7819b8a94c6492956702e38ea015e9.jpg)](https://github.com/superermiao)  [![25497230](../_resources/e961ef8f19a7a3cdf7f6901015a15df5.jpg)](https://github.com/coolliyong)  [![26019582](../_resources/aa349415d4d77886809e87d0e043c354.jpg)](https://github.com/Vikingama)  [![26050644](../_resources/3c8eb6f207815fcaa19ddf79e89ea46f.jpg)](https://github.com/Flcwl)  [![26347008](../_resources/fe3915d86c1c17d2ab3d170016164247.jpg)](https://github.com/ZavierTang)  [![27949553](../_resources/b845a048668874e9b559ea6051fa324e.jpg)](https://github.com/Caaalabash)  [![29700023](../_resources/591393382f24c6174f3162230597f269.jpg)](https://github.com/mofiggHasSugar)  [![32598811](../_resources/95192e29a1e47a82b2aef932acb91349.jpg)](https://github.com/fireairforce)  [![35484453](../_resources/4edbb7c86beda3dd36a31aa3833bc0be.jpg)](https://github.com/spongege)  [![38586385](../_resources/34f09d72bf0fe27ad105afe5a3d953a8.jpg)](https://github.com/huijingL)  [![65157428](../_resources/1327615671115c3665fc9540fd1e0e3e.png)](https://github.com/Verahuan)