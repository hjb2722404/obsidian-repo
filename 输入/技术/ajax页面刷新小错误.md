ajax页面刷新小错误

# ajax页面刷新小错误

ajax
问题解决

* * *

许多新手在刚刚接触ajax提交表单或验证数据时，都会碰到这样的问题：
在ajax请求返回成功后，success方法体里的程序却没有执行。
其中有一个重要的小疏忽可能是，你真的讲submit按钮设置为了“submit”类型，典型的代码像下面这样：

	 ···
	<form action="" method="post">

	   <input ... />
	   <input  type="submit" id="submit" value="提交" />

	</form>

	<script>

	   $("#submit").on("click",function(){

	     $.ajax(...);

	})

	</script>

这里，要保证ajax执行成功后可以顺序执行success方法体中的所有程序，则
HTML中的submit按钮必须不能是submit类型，最好是写成type="button",因
为默认情况下，即使你写了ajax提交的程序，但如果该按钮类型是submit时，当
你点击了它，它既会执行ajax方法，也会执行浏览器默认的提交方法，导致的结果
就是ajax还没执行结束，页面便刷新了一次，导致ajax中的方法没有完全执行。
[markdownFile.md](../_resources/dd40c27422d8fbd49e657bbdd28c7638.bin)