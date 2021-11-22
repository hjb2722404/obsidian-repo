jquery ajax传递的data参数中带json多维数组字符串

# jquery ajax传递的data参数中带json多维数组字符串

jquery
ajax
**情况描述：**
后台那边是JAVA，需要我从前台Ajax传递数据，数据包含一些表单字段，和一个json二维数组，使用的是jquery $.ajax跨域方法。

	var $dataStr = {
	        "name": $name,
	        "phone": $phone,
	        "trainNum": $trainNum,
	        "coach": $coach,
	        "seatNum": $seatNum,
	        "remark": $remark,
	        "menusStr":$menusStr //这个是二维数组字符串
	    }
	    $.ajax({
	        type:"get",
	        url:"ip:port/ordering/orderManager/addOrder",
	        data:$dataStr,
	        dataType:'jsonp',
	        async:false,
	        jsonp:'callback',
	        jsonpCallback:'callback',
	        success:function(json){
	           if(json.result){
	               alert("订餐成功，等待送餐");
	           }else{
	               alert("抱歉，订餐失败，请联系服务员");
	           }
	        },
	        complete:function(){

	        },
	        error:function(e){
	            alert("数据加载失败");
	            alert(e);
	        }

	    });

其中 $menusStr是一个JSON二维数组字符串，之前的写法是：

	// $menusStr='[{"a":3,"b":"33"},{"d":"vv","c":55}]';

然后发现后台那边其他字段都可以接收到，唯独 '$menusStr'为null，百思不得其解，然后利用json格式校验工具校验，发现整个'$dataStr'格式无法通过校验。

后来改成如下格式，通过了验证，并且后台接收成功：

	 $menusStr="[{'a':3,'b':'33'},{'d':'vv','c':55}]";

虽然问题解决，但是原因不详，因为json官方的多维数组写法是第一种那种，但就是不行，这个问题在这里做标记，等工作忙完好好研究一下。
[markdownFile.md](../_resources/f51f26181856ef287395b68a9c503920.bin)