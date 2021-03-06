<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ taglib uri="http://www.xnx3.com/java_xnx3/xnx3_tld" prefix="x" %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<jsp:include page="../../iw/common/head.jsp">
	<jsp:param name="title" value="登录"/>
	<jsp:param name="keywords" value="网市场,免费建站"/>
	<jsp:param name="description" value="以高精尖技术压缩建站成本，以超低价甚至免费享受高端体验，网·市场！让每个企业、个体户、个人拥有自己的网络名片，网上门头！"/>
</jsp:include>

<style>
.myForm{
	margin: 0 auto;
    width: 495px;
    height: 360px;
    border-width: 1px 1px 1px 1px;
    padding: 0px;
    border-radius: 20px;
    overflow: hidden;
    -webkit-box-shadow: 0 0 10px #e2e2e2;
    -moz-box-shadow: 0 0 10px #e2e2e2;
    box-shadow: 0 0 10px #e2e2e2;
    position: absolute;
    left: 50%;
    top: 50%;
    margin-left: -248px;
    margin-top: -181px;
}

@media screen and (max-width:600px){
	.myForm{
		margin: 0 auto;
	    width: 100%;
	    height: 100%;
	    border-width: 0px;
	    padding: 0px;
	    border-radius: 0px;
	    overflow: auto;
	    -webkit-box-shadow: 0 0 0px #e2e2e2;
	    -moz-box-shadow: 0 0 0px #e2e2e2;
	    box-shadow: 0 0 0px #e2e2e2;
	    position: static;
	    left: 0px;
	    top: 0px;
	    margin-left: 0px;
	    margin-top: 0px;
	}
}

.touming{
	background: rgba(0,190,150,0.1) none repeat scroll !important;
}
.baisetouming{
	background: rgba(250,250,250,0.1) none repeat scroll !important;
}
</style>

<!-- 背景 -->
<div class="layui-canvs" style="position: fixed;top: 0px;left: 0px;z-index: -1;"></div>

<form class="layui-form layui-elem-quote layui-quote-nm myForm">
  <div class="layui-form-item touming" style="height: 70px;background-color: #eeeeee;line-height: 70px;text-align: center;font-size: 25px;color: #3F4056;">
    网·市场 云建站平台登陆
  </div>
  <div style="padding: 30px 50px 40px 0px;">
  	<div class="layui-form-item">
	    <label class="layui-form-label">用户名</label>
	    <div class="layui-input-block">
	      <input type="text" name="username" required  lay-verify="required" placeholder="请输入 用户名/邮箱" autocomplete="off" class="layui-input baisetouming">
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label"> 密 码&nbsp;&nbsp; </label>
	    <div class="layui-input-block">
	      <input type="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input baisetouming">
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label"> 验证码 </label>
	    <div class="layui-input-inline">
	      <input type="text" name="code" required lay-verify="required" placeholder="请输入右侧验证码" autocomplete="off" class="layui-input baisetouming">
	    </div>
	    <div class="layui-form-mid layui-word-aux" style="padding-top: 3px;padding-bottom: 0px;"><img id="code" src="captcha.do" onclick="reloadCode();" style="height: 29px;width: 110px; cursor: pointer;" /></div>
	  </div>
	  <div class="layui-form-item" style="display:none">
	    <label class="layui-form-label">记住密码</label>
	    <div class="layui-input-block">
	      <input type="checkbox" name="switch" lay-skin="switch">
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <div class="layui-input-block">
	      <button class="layui-btn" lay-submit lay-filter="formDemo" style="opacity:0.6; margin-right: 50px;">立即登陆</button>
	      <button type="reset" class="layui-btn layui-btn-primary baisetouming" style="width: 90px;">重置</button>
	    </div>
	  </div>
  </div>
</form>
 
<!--[if IE]>
	<div style="position: absolute;bottom: 0px;padding: 10px;text-align: center;width: 100%;background-color: yellow;">建议使用<a href="https://www.baidu.com/s?wd=Chrome" target="_black" style="text-decoration:underline">Chrome(谷歌)</a>、<a href="https://www.baidu.com/s?wd=Firefox" target="_black" style="text-decoration:underline">Firefox(火狐)</a>浏览器，IE浏览器会无法操作！！！</div>
<![endif]-->

<!-- weui -->
<script src="http://res.weiunity.com/js/jquery-2.1.4.js"></script>
<script src="http://res.weiunity.com/js/jquery-weui.js"></script>
<link rel="stylesheet" href="http://res.weiunity.com/css/weui.min.css">
<link rel="stylesheet" href="http://res.weiunity.com/css/jquery-weui.css">
<script>
//Demo
layui.use('form', function(){
  var form = layui.form;
  
  //监听提交
  form.on('submit(formDemo)', function(data){
  	$.showLoading('登录中...');
    var d=$("form").serialize();
	$.post("<%=basePath %>loginSubmit.do", d, function (result) {
		$.hideLoading();
       	var obj = JSON.parse(result);
       	if(obj.result == '1'){
       		layer.msg('登陆成功', {shade: 0.3});
       		window.location.href=obj.info;
       	}else if(obj.result == '0'){
       		reloadCode();
       		layer.msg(obj.info, {shade: 0.3})
       	}else{
       		reloadCode();
       		layer.msg(result, {shade: 0.3})
       	}
	}, "text");
    return false;
  });
});

//重新加载验证码
function reloadCode(){
var code=document.getElementById('code');
code.setAttribute('src','captcha.do?'+Math.random());
//这里必须加入随机数不然地址相同我发重新加载
}


//检测浏览器，若不是Chrome浏览器，弹出提示
if(navigator.userAgent.indexOf('Chrome') == -1){
	layer.open({
	  type: 1
	  ,title:'提示'
	  ,offset: 'rb' //具体配置参考：offset参数项
	  ,content: '<div style="padding: 18px; line-height:30px;">建议使用<a href="https://www.baidu.com/s?wd=Chrome" target="_black" style="text-decoration:underline">Chrome(谷歌)</a>浏览器<br/>其他浏览器登录可能无法正常操作！</div>'
	  ,btn: ['下载Chrome','忽略']
	  ,btnAlign: 'c' //按钮居中
	  ,shade: 0 //不显示遮罩
	  ,yes: function(){
	    layer.closeAll();
	    window.open("https://www.baidu.com/s?wd=Chrome");
	  }
	  ,btn2: function(){
	    layer.closeAll();
	  }
	});
}

</script>


<!-- 以下为背景特效相关 -->
<script type="text/javascript">
'use strict';
layui.use(['jquery'],function(){
	window.jQuery = window.$ = layui.jquery;
   $(".layui-canvs").width($(window).width());
   $(".layui-canvs").height($(window).height());

});
</script>
<script type="text/javascript" src="http://res.weiunity.com/js/jparticle.jquery.js"></script>
<script type="text/javascript">
$(function(){
	$(".layui-canvs").jParticle({
		background: "#FFFFFF",
		color: "#FDEDED"
	});
});
</script>
<!-- 背景特效相关结束 -->
</body>
</html>