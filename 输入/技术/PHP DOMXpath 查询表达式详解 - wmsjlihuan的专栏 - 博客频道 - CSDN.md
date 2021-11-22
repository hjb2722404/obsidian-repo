PHP DOMXpath 查询表达式详解 - wmsjlihuan的专栏 - 博客频道 - CSDN.NET

#   [PHP DOMXpath 查询表达式详解](http://blog.csdn.net/wmsjlihuan/article/details/9000790)

.

 2013-05-31 15:31  3322人阅读    [评论](http://blog.csdn.net/wmsjlihuan/article/details/9000790#comments)(1)    [收藏](PHP%20DOMXpath%20查询表达式详解%20-%20wmsjlihuan的专栏%20-%20博客频道%20-%20CSDN.md#)    [举报](http://blog.csdn.net/wmsjlihuan/article/details/9000790#report)

 .

 ![category_icon.jpg](../_resources/760c5ec8c68b26ded5d32a15a75b0d4b.jpg)  分类：

   php*（57）*  ![arrow_triangle _down.jpg](../_resources/f4957b54c1e7e28871f863560acc9791.jpg)

 .

**[php]**  [view plain](http://blog.csdn.net/wmsjlihuan/article/details/9000790#)  [copy](http://blog.csdn.net/wmsjlihuan/article/details/9000790#)

1. XPath简介
2.

3. XPath是W3C的一个标准。它最主要的目的是为了在XML1.0或XML1.1文档节点树中定位节点所设计。目前有XPath1.0和XPath2.0两个版本。其中Xpath1.0是1999年成为W3C标准，而XPath2.0标准的确立是在2007年。W3C关于XPath的英文详细文档请见：http://www.w3.org/TR/xpath20/ 。

4.
5.
6.

7. XPath是一种表达式语言，它的返回值可能是节点，节点集合，原子值，以及节点和原子值的混合等。XPath2.0是XPath1.0的超集。它是对XPath1.0的扩展，它可以支持更加丰富的数据类型，并且XPath2.0保持了对XPath1.0的相对很好的向后兼容性，几乎所有的XPath2.0的返回结果都可以和XPath1.0保持一样。另外XPath2.0也是XSLT2.0和XQuery1.0的用于查询定位节点的主表达式语言。XQuery1.0是对XPath2.0的扩展。关于在XSLT和XQuery中使用XPath表达式定位节点的知识在后面的实例中会有所介绍。

8.
9.
10.

11. 在学习XPath之前你应该对XML的节点，元素，属性，原子值（文本），处理指令，注释，根节点（文档节点），命名空间以及对节点间的关系如：父（Parent），子（Children），兄弟（Sibling），先辈（Ancestor），后代（Descendant）等概念有所了解。这里不在说明。

12.
13.
14. XPath路径表达式
15.
16. 在本小节下面的内容中你将可以学习到：
17.
18. 路径表达式语法
19. 相对/绝对路径
20. 表达式上下文
21. 谓词（筛选表达式）及轴的概念
22. 运算符及特殊字符
23. 常用表达式实例
24. 函数及说明
25.
26.
27. 路径表达式语法：
28.
29.
30. 路径 = 相对路径 | 绝对路径
31. XPath路径表达式 = 步进表达式 | 相对路径 "/"步进表达式。
32. 步进表达式=轴 节点测试 谓词
33. 说明：
34.

35. 其中轴表示步进表达式选择的节点和当前上下文节点间的树状关系（层次关系），节点测试指定步进表达式选择的节点名称扩展名，谓词即相当于过滤表达式以进一步过滤细化节点集。

36. 谓词可以是0个或多个。多个多个谓词用逻辑操作符and， or连接。取逻辑非用not()函数。

37. 请看一个典型的XPath查询表达式：/messages/message//child::node()[@id=0]，其中/messages/message是路径（绝对路径以"/"开始），child::是轴表示在子节点下选择，node()是节点测试表示选择所有的节点。[@id=0]是谓词，表示选择所有有属性id并且值为0的节点。

38.
39. 相对路径与绝对路径：

40. 如果"/"处在XPath表达式开头则表示文档根元素，（表达式中间作为分隔符用以分割每一个步进表达式）如：/messages/message/subject是一种绝对路径表示法，它表明是从文档根开始查找节点。假设当前节点是在第一个message节点【/messages/message[1]】，则路径表达式subject（路径前没有"/"）这种表示法称为相对路径，表明从当前节点开始查找。具体请见下面所述的"表达式上下文"。

41.
42.
43.
44. 表达式上下文（Context）:

45. 上下文其实表示一种环境。以明确当前XPath路径表达式处在什么样的环境下执行。例如同样一个路径表达式处在对根节点操作的环境和处在对某一个特定子节点操作的环境下执行所获得的结果可能是完全不一样的。也就是说XPath路径表达式计算结果取决于它所处的上下文。

46.
47.
48.
49. XPath上下文基本有以下几种：
50.
51. 当前节点(./)：
52. 如./sender表示选择当前节点下的sender节点集合（等同于下面所讲的"特定元素"，如：sender）
53.
54. 父节点(../)：
55. 如../sender表示选择当前节点的父节点下的sender节点集合
56.
57. 根元素（/）：
58. 如/messages表示选择从文档根节点下的messages节点集合.
59.
60. 根节点（/*）：
61. 这里的*是代表所有节点，但是根元素只有一个，所以这里表示根节点。/*的返回结果和/messages返回的结果一样都是messages节点。
62.
63. 递归下降（//）:
64. 如当前上下文是messages节点。则//sender将返回以下结果：
65.
66. /messages//sender :
67.
68. <sender>gkt1980@gmail.com</sender>
69.
70. <sender>111@gmail.com</sender>
71.
72. <sender>333@gmail.com</sender>
73.
74.
75.
76. /messages/message[1]//sender:
77.
78. <sender>gkt1980@gmail.com</sender>
79.
80. <sender>111@gmail.com</sender>
81.
82.
83.
84. 我们可以看出XPath表达式返回的结果是：从当前节点开始递归步进搜索当前节点下的所有子节点找到满足条件的节点集。
85.
86.
87.
88. 特定元素
89. 如sender：表示选择当前节点下的sender节点集合，等同于（./sender）
90.

91. 注意：在执行XPath时一定要注意上下文。即当前是在哪个节点下执行XPath表达式。这在XMLDOM中很重要。如：在XMLDOM中的selectNodes,selectSingleNode方法的参数都是一个XPath表达式，此时这个XPath表达式的执行上下文就是调用这个方法的节点及它所在的环境。更多信息请参见：http://www.w3.org/TR/xpath20/

92.
93. 谓词（筛选表达式）及轴的概念：
94. XPath的谓词即筛选表达式，类似于SQL的where子句.
95.
96. 轴名称
97.
98. 结果
99.
100. ancestor
101.
102. 选取当前节点的所有先辈（父、祖父等）
103.
104. ancestor-or-self
105.
106. 选取当前节点的所有先辈（父、祖父等）以及当前节点本身
107.
108. attribute
109.
110. 选取当前节点的所有属性
111.
112. child
113.
114. 选取当前节点的所有子元素。
115.
116. descendant
117.
118. 选取当前节点的所有后代元素（子、孙等）。
119.
120. descendant-or-self
121.
122. 选取当前节点的所有后代元素（子、孙等）以及当前节点本身。
123.
124. following
125.
126. 选取文档中当前节点的结束标签之后的所有节点。
127.
128. namespace
129.
130. 选取当前节点的所有命名空间节点
131.
132. parent
133.
134. 选取当前节点的父节点。
135.
136. preceding
137.
138. 直到所有这个节点的父辈节点，顺序选择每个父辈节点前的所有同级节点
139.
140. preceding-sibling
141.
142. 选取当前节点之前的所有同级节点。
143.
144. self
145.
146. 选取当前节点。
147.
148.
149.
150. 运算符及特殊字符：
151. 运算符/特殊字符
152.
153. 说明
154.
155. /
156.
157. 此路径运算符出现在模式开头时，表示应从根节点选择。
158.
159. //
160.
161. 从当前节点开始递归下降，此路径运算符出现在模式开头时，表示应从根节点递归下降。
162.
163. .
164.
165. 当前上下文。
166.
167. ..
168.
169. 当前上下文节点父级。
170.
171. *
172.
173. 通配符；选择所有元素节点与元素名无关。（不包括文本，注释，指令等节点，如果也要包含这些节点请用node()函数）
174.
175. @
176.
177. 属性名的前缀。
178.
179. @*
180.
181. 选择所有属性，与名称无关。
182.
183. :
184.
185. 命名空间分隔符；将命名空间前缀与元素名或属性名分隔。
186.
187. ( )
188.
189. 括号运算符(优先级最高)，强制运算优先级。
190.
191. [ ]
192.
193. 应用筛选模式（即谓词，包括"过滤表达式"和"轴（向前/向后）"）。
194.
195. [ ]
196.
197. 下标运算符；用于在集合中编制索引。
198.
199. |
200.
201. 两个节点集合的联合，如：//messages/message/to | //messages/message/cc
202.
203. -
204.
205. 减法。
206.
207. div，
208.
209. 浮点除法。
210.
211. and, or
212.
213. 逻辑运算。
214.
215. mod
216.
217. 求余。
218.
219. not()
220.
221. 逻辑非
222.
223. =
224.
225. 等于
226.
227. ！=
228.
229. 不等于
230.
231. 特殊比较运算符
232.
233. < 或者 <
234.
235. <= 或者 <=
236.
237. > 或者 >
238.
239. >= 或者 >=
240.
241. 需要转义的时候必须使用转义的形式，如在XSLT中，而在XMLDOM的scripting中不需要转义。
242.
243.
244.
245. 常用表达式实例：
246.
247.
248. /
249.
250. Document Root文档根.
251.
252. /*
253.
254. 选择文档根下面的所有元素节点，即根节点（XML文档只有一个根节点）
255.
256. /node()
257.
258. 根元素下所有的节点（包括文本节点，注释节点等）
259.
260. /text()
261.
262. 查找文档根节点下的所有文本节点
263.
264. /messages/message
265.
266. messages节点下的所有message节点
267.
268. /messages/message[1]
269.
270. messages节点下的第一个message节点
271.
272. /messages/message[1]/self::node()
273.
274. 第一个message节点（self轴表示自身，node()表示选择所有节点）
275.
276. /messages/message[1]/node()
277.
278. 第一个message节点下的所有子节点
279.
280. /messages/message[1]/*[last()]
281.
282. 第一个message节点的最后一个子节点
283.
284. /messages/message[1]/[last()]
285.
286. Error，谓词前必须是节点或节点集
287.
288. /messages/message[1]/node()[last()]
289.
290. 第一个message节点的最后一个子节点
291.
292. /messages/message[1]/text()
293.
294. 第一个message节点的所有子节点
295.
296. /messages/message[1]//text()
297.
298. 第一个message节点下递归下降查找所有的文本节点（无限深度）
299.
300. /messages/message[1] /child::node()
301.
302. /messages/message[1] /node()
303.
304. /messages/message[position()=1]/node()
305.
306. //message[@id=1] /node()
307.
308. 第一个message节点下的所有子节点
309.
310. //message[@id=1] //child::node()
311.
312. 递归所有子节点（无限深度）
313.
314. //message[position()=1]/node()
315.
316. 选择id=1的message节点以及id=0的message节点
317.
318. /messages/message[1] /parent::*
319.
320. Messages节点
321.
322. /messages/message[1]/body/attachments/parent::node()
323.

324. /messages/message[1]/body/attachments/parent::* /messages/message[1]/body/attachments/..

325.
326. attachments节点的父节点。父节点只有一个,所以node()和* 返回结果一样。
327.
328. （..也表示父节点. 表示自身节点）
329.
330. //message[@id=0]/ancestor::*
331.
332. Ancestor轴表示所有的祖辈，父，祖父等。
333.
334. 向上递归
335.
336. //message[@id=0]/ancestor-or-self::*
337.
338. 向上递归,包含自身
339.
340. //message[@id=0]/ancestor::node()
341.
342. 对比使用*,多一个文档根元素(Document root)
343.
344. /messages/message[1]/descendant::node()
345.
346. //messages/message[1]//node()
347.
348. 递归下降查找message节点的所有节点
349.
350. /messages/message[1]/sender/following::*
351.
352. 查找第一个message节点的sender节点后的所有同级节点，并对每一个同级节点递归向下查找。
353.
354. //message[@id=1]/sender/following-sibling::*
355.
356. 查找id=1的message节点的sender节点的所有后续的同级节点。
357.
358. //message[@id=1]/datetime/@date
359.
360. 查找id=1的message节点的datetime节点的date属性
361.
362. //message[@id=1]/datetime[@date]
363.
364. //message/datetime[attribute::date]
365.
366. 查找id=1的message节点的所有含有date属性的datetime节点
367.
368. //message[datetime]
369.
370. 查找所有含有datetime节点的message节点
371.
372. //message/datetime/attribute::*
373.
374. //message/datetime/attribute::node()
375.
376. //message/datetime/@*
377.
378. 返回message节点下datetime节点的所有属性节点
379.
380. //message/datetime[attribute::*]
381.
382. //message/datetime[attribute::node()]
383.
384. //message/datetime[@*]
385.
386. //message/datetime[@node()]
387.
388. 选择所有含有属性的datetime节点
389.
390. //attribute::*
391.
392. 选择根节点下的所有属性节点
393.
394. //message[@id=0]/body/preceding::node()
395.

396. 顺序选择body节点所在节点前的所有同级节点。（查找顺序为：先找到body节点的顶级节点（根节点）,得到根节点标签前的所有同级节点，执行完成后继续向下一级，顺序得到该节点标签前的所有同级节点，依次类推。）

397.
398. 注意：查找同级节点是顺序查找，而不是递归查找。
399.
400. //message[@id=0]/body/preceding-sibling::node()
401.

402. 顺序查找body标签前的所有同级节点。（和上例一个最大的区别是：不从最顶层开始到body节点逐层查找。我们可以理解成少了一个循环，而只查找当前节点前的同级节点）

403.
404. //message[@id=1]//*[namespace::amazon]
405.
406. 查找id=1的所有message节点下的所有命名空间为amazon的节点。
407.
408. //namespace::*
409.
410. 文档中的所有的命名空间节点。（包括默认命名空间xmlns:xml）
411.
412. //message[@id=0]//books/*[local-name()='book']
413.
414. 选择books下的所有的book节点，
415.

416. 注意：由于book节点定义了命名空间<amazone:book>.若写成//message[@id=0]//books/book则查找不出任何节点。

417.

418. //message[@id=0]//books/*[local-name()='book' and namespace-uri()='http://www.amazon.com/books/schema']

419.
420. 选择books下的所有的book节点，(节点名和命名空间都匹配)
421.
422. //message[@id=0]//books/*[local-name()='book'][year>2006]
423.
424. 选择year节点值>2006的book节点
425.
426. //message[@id=0]//books/*[local-name()='book'][1]/year>2006
427.
428. 指示第一个book节点的year节点值是否大于2006.返回xs:boolean: true
[![save_snippets.png](PHP%20DOMXpath%20查询表达式详解%20-%20wmsjlihuan的专栏%20-%20博客频道%20-%20CSDN.md#)

[(L)](http://blog.csdn.net/wmsjlihuan/article/details/9000790#)[(L)](http://blog.csdn.net/wmsjlihuan/article/details/9000790#)[(L)](http://blog.csdn.net/wmsjlihuan/article/details/9000790#)[(L)](http://blog.csdn.net/wmsjlihuan/article/details/9000790#)[(L)](http://blog.csdn.net/wmsjlihuan/article/details/9000790#)[(L)](http://blog.csdn.net/wmsjlihuan/article/details/9000790#).

顶

0

踩

0

 .

[PHP DOMXpath 查询表达式详解 - wmsjlihuan的专栏 - 博客频道 - CSDN](PHP%20DOMXpath%20查询表达式详解%20-%20wmsjlihuan的专栏%20-%20博客频道%20-%20CSDN.md#)

 [PHP DOMXpath 查询表达式详解 - wmsjlihuan的专栏 - 博客频道 - CSDN](PHP%20DOMXpath%20查询表达式详解%20-%20wmsjlihuan的专栏%20-%20博客频道%20-%20CSDN.md#)

- 上一篇[jpgraph BarPlot 柱形图](http://blog.csdn.net/wmsjlihuan/article/details/8945760)

- 下一篇[http 错误代码表](http://blog.csdn.net/wmsjlihuan/article/details/9083865)

 .

#### 我的同类文章

   php*（57）*

- *•*[php 程序中开启报错](http://blog.csdn.net/wmsjlihuan/article/details/52094139)2016-08-02*阅读***33**

- *•*[php 获取远程图片大小 宽高](http://blog.csdn.net/wmsjlihuan/article/details/51911567)2016-07-14*阅读***46**

- *•*[php 下载完成后删除文件](http://blog.csdn.net/wmsjlihuan/article/details/48491227)2015-09-16*阅读***1063**

- *•*[php 数组转xml](http://blog.csdn.net/wmsjlihuan/article/details/46968953)2015-07-20*阅读***342**

- *•*[php导出excel](http://blog.csdn.net/wmsjlihuan/article/details/39996107)2014-10-11*阅读***353**

- *•*[PHP 判断终端是wap还是web](http://blog.csdn.net/wmsjlihuan/article/details/24267483)2014-04-21*阅读***1759**

- *•*[win7下 php-cgi.exe 0xc000007b 错误](http://blog.csdn.net/wmsjlihuan/article/details/52087885)2016-08-01*阅读***277**

- *•*[php 生成唯一订单号，文件锁](http://blog.csdn.net/wmsjlihuan/article/details/51537092)2016-05-30*阅读***159**

- *•*[php AES加密兼容.net](http://blog.csdn.net/wmsjlihuan/article/details/47337155)2015-08-07*阅读***194**

- *•*[php保存二进制数据为图片](http://blog.csdn.net/wmsjlihuan/article/details/39996279)2014-10-11*阅读***3747**

- *•*[php 获取获取客户端ip](http://blog.csdn.net/wmsjlihuan/article/details/37934893)2014-07-18*阅读***332**

 [更多文章](http://blog.csdn.net/wmsjlihuan/article/category/1092269)