js帧动画函数封装 - youlinaixu的博客 - CSDN博客

原

# js帧动画函数封装

2018年09月10日 13:50:16  [youlinaixu](https://me.csdn.net/youlinaixu)  阅读数 290

![](data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' style='display: none%3b' data-evernote-id='818' class='js-evernote-checked'%3e %3cpath stroke-linecap='round' d='M5%2c0 0%2c2.5 5%2c5z' id='raphael-marker-block' style='-webkit-tap-highlight-color: rgba(0%2c 0%2c 0%2c 0)%3b' data-evernote-id='819' class='js-evernote-checked'%3e%3c/path%3e %3c/svg%3e)

*//函数的封装部分start*
function  MovieSprites(ele, obj)  {
var  t =  this;
t.ele = ele;
t.classOrigin = obj.classOrigin ||  null;
t.classAnimate = obj.classAnimate;
t.frameLastTime = obj.frameLastTime ||  40;
t.totalFrame = obj.totalFrame ||  1;
t.currentFrame = obj.currentFrame ||  1;
t.step =  1;
t.loop = obj.loop ||  0;
*// 播放的部分*
t.play =  function  (speed, now, whereStop)  {
t.currentFrame = now;
t.interval = setInterval(function(){
*// 循环的时候loop=1，非循环的时候loop=0*
if(t.loop ==  1  && t.currentFrame == whereStop) {
t.currentFrame =  1;
}
if(t.currentFrame == whereStop){
t.stop();
}
$(ele).attr('class', t.classOrigin+  ' '  + t.classAnimate + t.currentFrame);
t.currentFrame += t.step;
}, speed)
},
*// 结束的部分*
t.stop =  function  ()  {
clearInterval( t.interval );
*// 如果有后续的操作，则执行后续的操作*
if( t.stopCallBack ){
t.stopCallBack();
}
},
*// 倒放的部分（即可以实现倒放的功能）*
t.revert =  function  (speed,whereend,wherestart)  {
t.currentFrame = whereend;
t.interval = setInterval(function(){
t.currentFrame -= t.step;
if(t.currentFrame == wherestart){
t.stop();
}
$(ele).attr('class', t.classOrigin+  ' '  + t.classAnimate + t.currentFrame);
}, speed)
}
}

*// 调用的部分*
goToFridge =  new  MovieSprites($('.donghua'), {
classAnimate:  'sprite-bingxiang-',
classOrigin:  'donghua',
frameLastTime:  144,
totalFrame:  71,
currentFrame:  0,
});
function  getFoods()  {
$('.p2-goOnText').on('click',  function(){
goToFridge.play(144,  59,  71);  *//播放帧动画*
goToFridge.stopCallBack = newChance;  *//帧动画进行完后的回调函数*
});
}
登录后复制