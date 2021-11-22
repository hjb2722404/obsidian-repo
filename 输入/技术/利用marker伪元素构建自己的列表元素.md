# 利用marker伪元素构建自己的列表元素

## 原生列表

`<li>` 是我们在`web`开发中经常用到了一个`htlm`元素标签。为了理解它的底层的本质，我们今天使用普通的`div`与`p` 标签来模拟实现一个列表。

列表有两种类型，一种是有序列表，即列表项前面的标记位序号会不断递增，一种是无序列表，就是所有列表项前面的标记位都是同一个符号。

我们先使用原生的语法分别实现一个无序列表和有序列表

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>原生list观察DEMO</title>
</head>
<body>
    <ul>
        <li>这是第一个项目</li>
        <li>这是第二个项目</li>
        <li>这是第三个项目</li>
    </ul>
    <ol start="3">
        <li>这是第一个项目</li>
        <li>这是第二个项目</li>
        <li>这是第三个项目</li>
    </ol>
</body>
</html>
```



![](https://gitee.com/hjb2722404/tuchuang/raw/master/img/2020-12-12%2011-32-08%20%E7%9A%84%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE.png)