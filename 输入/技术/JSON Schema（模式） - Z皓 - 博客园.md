JSON Schema（模式） - Z皓 - 博客园

#  JSON Schema（模式）

JSON Schema指的是数据交换中的一种虚拟的“合同”。
JSON验证器负责验证语法错误，JSON Schema负责提供一致性检验。
JSON Schema是数据接收方额第一道防线，也是数据发送方节约时间、保证数据正确的好工具。
JSON Schema可以解决下列有关一致性验证的问题。
1、  值的数据类型是否正确：可以具体规定一个值是数字、字符串等类型；
2、  是否包含所需的数据：可以规定哪些数据是需要的，哪些是不需要的；
3、  值的形式是不是我需要的：可以指定范围、最小值和最大值。
编写JSON Schema的步骤：
一、在JSON第一个名称——值对中，声明其为一个schema文件。声明的名称必须为”$schema”,值必须为所用草拟版本的连接：
![1108615-20170410084648297-1012158517.png](../_resources/b4e4b70c501c24274b0e308b129f91ac.png)
二、第二个名称——值对是JSON Schema文件格式，比如表示一只猫：

![1108615-20170410084723797-974752865.png](../_resources/ff5c31af1691340912aece56ea5217e7.png)

三、定义title的相关属性值：

![1108615-20170410084757532-1902728665.png](../_resources/04ec3f2addeac0a7e13a33a55e8374bb.png)

**完整的案例：**
1、验证猫的JSON

![1108615-20170410084824297-1272785095.png](../_resources/4aaa0fcf444002a735d76cae7cb233fa.png)

![1108615-20170410084839813-54544344.png](../_resources/7e4cd36a6715dbdf935060d94977ccdf.png)

其中required定义的是必填字段。
2、JSON

![1108615-20170410084935204-1914755641.png](../_resources/986d7e6ea10ed4c281c74f1f9b4a102d.png)

在线测试网址：
http://jsonschemalint.com/draft4
Measure
Measure