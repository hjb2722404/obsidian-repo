## what——问题描述

在使用了`ElemtnUI`的皮肤功能和使用了`Vitify`的`Vue`工程打包时，会报一大堆如下形式的错误：

```shell
   ╷
62 │     'sm': $grid-gutter / 6,
   │           ^^^^^^^^^^^^^^^^
   ╵
    node_modules\_vuetify@2.5.8@vuetify\src\styles\settings\_variables.scss 62:11  @import
    node_modules\_vuetify@2.5.8@vuetify\src\styles\settings\_index.sass 1:9        @import
    node_modules\_vuetify@2.5.8@vuetify\src\styles\styles.sass 2:9                 @import
    stdin 2:9                                                                      root stylesheet

DEPRECATION WARNING: Using / for division is deprecated and will be removed in Dart Sass 2.0.0.

Recommendation: math.div($grid-gutter, 3)

More info and automated migrator: https://sass-lang.com/d/slash-div
```

这会导致我们错过其它重要的警告信息。

## why——为什么会出现这个问题

问题的原因在于，早期的`sass`语法中，`/` 符号既可以作为除法运算符，又可以作为分隔符，例如：

```css
@width=300;

/*作为除法运算法**/
.content {
    height: @width / 2, 
}

/**作为分隔符**/
.grid {
    grid-column: 1 / 3; 
}
```

这就导致很多情况下造成语法混乱，无法分辨这个符号到底是除法运算符还是分隔符。

于是，后来的`sass`版本就不再推荐`/` 作为除法运算符了，而是单纯地作为分隔符使用。

而除法则使用`math.div()`代替:

```css

.content {
    height: math.div(@width, 2);
}
```



但是`ElementUI`和`vitify` 的早期很多样式代码都是使用`sass`的旧版写法写的，所以采用一些不再推荐就写法的`sass`版本时，就会报这一堆警告信息。

## how——怎么解决

安装指定的支持旧版语法的`sass`版本：目前发现`1.32.13`版本不会出警告

```bash
$ npm i -D sass@1.32.13
```



