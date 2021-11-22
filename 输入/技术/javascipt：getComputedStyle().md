javascipt：getComputedStyle()

# javascipt：getComputedStyle()

javascirpt内置方法
简单的说，这个方法是用来获取元素样式的值的，语法为：

	var style = window.getComputedStyle(element[, pseudoElt]);

其中，element 是用于计算样式的元素，为必须参数，pseudoElt为可选参数，主要用于选取伪元素进行匹配计算
用法示例：

	<style>
	 #elem-container{
	   position: absolute;
	   left:     100px;
	   top:      200px;
	   height:   100px;
	 }
	</style>

	<div id="elem-container">dummy</div>
	<div id="output"></div>

	<script>
	  function getTheStyle(){
	    var elem = document.getElementById("elem-container");
	    var theCSSprop = window.getComputedStyle(elem,null).getPropertyValue("height");
	    document.getElementById("output").innerHTML = theCSSprop;
	   }
	  getTheStyle();
	</script>

可以看出，getComputedStyle 返回的对象跟 element 调用 style 属性返回的对象是同一种类型，可以称为 CSSStyleDeclaration. 但两个对象有不同的用处， getComplutedSytle返回的对象是只读对象， 用于检测元素的样式（包括在

[markdownFile.md](../_resources/571ebca81231585aee4b5b59c5e0b372.bin)