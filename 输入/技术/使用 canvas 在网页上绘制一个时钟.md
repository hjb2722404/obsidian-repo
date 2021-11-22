使用 canvas 在网页上绘制一个时钟

# 使用 canvas 在网页上绘制一个时钟

### 效果：

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102114909.png)

### 代码：

```
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

    <meta name="renderer" content="webkit">
    <title>使用canvas绘制一个简单的时钟</title>
    <style>
        .csscode{
            width: 40%; float: left; overflow: scroll}
        .jscode { width: 40%; float: left; overflow: scroll}

        .content { width: 55%;  float: right; margin-right: 20px; border: 20px solid #ccc;}

        .explain { width: 55%; float: left; padding: 40px;}
    </style>
</head>
<body>

<div class="content">

    <canvas id="canvas">
        对不起，此浏览器不支持Canvas
    </canvas>

</div>
<script>

    //画布初始化
    var canvas = document.getElementById("canvas");
    canvas.width = 400;
    canvas.height =400;
    var ctx = canvas.getContext("2d");

    //基础参数设置
    var fontHeight =15,
        margin = 35, // 钟表外边框距画布边框的距离
        handTruncation = canvas.width/25,
        hourHandTruncation = canvas.width/10,
        numeralSpacing = 20, //数字离表盘边框的距离
        radius = canvas.width/2 - margin,
        handRadius = radius + numeralSpacing;
        ctx.strokeStyle = "blue";
        ctx.fillStyle = "#999999";

    // 绘制原型钟表框
    function drawCircle(){
        ctx.beginPath();
        ctx.arc(canvas.width/2,canvas.height/2,radius,0,Math.PI*2,true);
        ctx.stroke();
    }

    //绘制表盘数字
    function drawNumerals(){
        var numerals = [1,2,3,4,5,6,7,8,9,10,11,12],
            angle = 0,
            numeralWidth = 0;

        numerals.forEach(function(numeral){
            angle = Math.PI/6 * (numeral -3);
            numeralWidth = ctx.measureText(numeral).width;
            ctx.fillText(numeral,
            canvas.width/2 + Math.cos(angle) * handRadius - numeralWidth/2,

                    canvas.height/2 + Math.sin(angle) * handRadius + fontHeight/3

            );
        });
    }

    // 绘制中间指针转盘
    function drawCenter(){
        ctx.beginPath();
        ctx.arc(canvas.width/2, canvas.height/2, 5, 0, Math.PI*2, true);
        ctx.fill();
    }

    // 绘制单个指针
    function drawHand(loc,isHour){
        var angle = (Math.PI*2) * (loc/60) - Math.PI/ 2,
            //时针的长度要更短一点

            handRadius = isHour ? radius-handTruncation-hourHandTruncation : radius - handTruncation;

        ctx.moveTo(canvas.width/2,canvas.height/2);
        ctx.lineTo(canvas.width/2 + Math.cos(angle)*handRadius,
                    canvas.height/2 + Math.sin(angle)*handRadius);
        ctx.stroke();
    }

    //根据当前时间绘制所有指针
    function drawHands(){
        var date = new Date(),
            hour = date.getHours();
            hour = hour>12 ? hour-12 :hour;

        // 由于在drawHand中 loc要除以60（即以分、秒的进制为准），所以这里原本被分为12份的小时也乘以5，以方便统一调用
        drawHand(hour*5 + (date.getMinutes()/60)*5,true,0.5);
        drawHand(date.getMinutes(),false,0.5);
        drawHand(date.getSeconds(),false,0.2);
    }

    function drawClock() {
        ctx.clearRect(0,0,canvas.width,canvas.height);

        drawCircle();
        drawCenter();
        drawHands();
        drawNumerals();
    }

    ctx.font = fontHeight+'px,Arial';
    loop = setInterval(drawClock,1000);

</script>
</body>
</html>
```

### 知识点：

* 使用定时器，每秒重绘一次
* canvas 中圆的绘制 arc() 方法前两个参数为中心点坐标，即圆心坐标
* 表盘文字的坐标计算公式
    * 弧度的概念：360度 = 2PI弧度
    * 12个小时把360度分割为12份，即 360 / 12 ，转换为弧度为 2PI / 12，约分为 PI/6
    * canvas中起始角度（弧度）0度 从三点钟开始顺时针增加。
    * 如果弧度为负数，说明是逆时针绘制

    * 所以文字横坐标为：圆心坐标（canvas.width/2）+ 文字相对于圆心的距离（Math.cos(angle) * handRadius）- 文字宽度一半（numeralWidth/2），见下图

* 指针的角度计算
* 其原理与表盘文字一样，甚至更简单，只不过是把表盘分为了60等分的弧度，而不是12份；
* 角度计算还是使用了正余弦定理，如下图

![](https://cdn.jsdelivr.net/gh/hjb2722404/myimg/20210102114925.png)