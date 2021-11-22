jquery中的多条件选择，相对选择和层次选择

# jquery中的多条件选择，相对选择和层次选择

jquery
1、多条件选择器
用途：使用多个条件同时选择多个标签
用法：$("条件1，条件2，条件3，……，条件n ");
特征：多个条件在“”内用逗号隔开；

用例：$("div#id,span.tip,p"); [//同时选择id为](http:////xn--id-vz2c32uuxu4fehs3g)“id”的div标签,class为“tip”的span标签和p标签；

2、相对选择器
用途：使用第二个参数选出相对元素，从而不影响其他具有相同条件的元素
用法：$("条件1",条件2)；
特征：两个参数
用例：$("td",$(this)).css("background","red");
[//当前tr的td元素背景变红](http:////xn--trtd-yn8fz8cfxeuz8aguog31b4gpoieyvi)，其他tr中的td不变；
3、层次选择器
用途：选择后代节点
用法：$("条件1 条件2 条件3");
特征：双引号之内，条件之间用空格隔开；
用例：$("#com ul li");

[//选择Id为com的元素中的UL里面的所有li节点](http:////xn--IdcomULli-ul6nle981bpt1dk6b51z1r0bcuucac9494acwxg59d1qiu28a)；

[markdownFile.md](../_resources/ac9289d516c6daab4ce87f8b0a1e4dd2.bin)