# 表格的`rowSelection`

在 `<a-table>` 上设置 `rowSelection` 属性，可以为表格条目添加复选框。

一般像下面这样设置：

```html
<a-table :row-selection="{ selectedRowKeys: selectedRowKeys, onChange: onSelectChange }"  />
```

这样，当选项发生变化时，我们可以获取到当前选中的项目编号，它们将存储在 `selectedRowKeys` 变量中，这是一个数组。

当 `<a-table>` 上没有设置 `rowKey` 属性时（此时，控制台会有警告），`selectedRowKeys` 中存储的是所选数据在当前页数据数组中的索引值，

当 `<a-table>` 上设置了 `rowKey` 属性时，`selectedRowKeys` 中存储的是所选数据的对应`rowKey`标识的字段的值。

比如：

```html
<a-table row-key="myid" :row-selection="{ selectedRowKeys: selectedRowKeys, onChange: onSelectChange }"  />
```

则当表格数据被选中时， `selectedRowKeys` 数组中存储的就是所选条目的 `myid`字段的值。