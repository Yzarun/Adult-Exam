<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>后台登录</title>
    <link href="bootstrap-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/signin.css" rel="stylesheet">
    <script src="js/jquery/jquery-2.0.3.min.js"></script>
    <script src="js/jQuery-Cookie/jquery.cookie.min.js"></script>
    <script src="js/layer/layer.js"></script>
</head>
<body>
    <div class="signin">
        <div class="signin-head">
            <img src="img/avatars/avatar2.jpg" width="120px" height="120px" class="img-circle">
        </div>
        <form id="form" class="form-signin" role="form" method="post">
            <input type="text" class="form-control" placeholder="用户名" id="username" name="username" required autofocus />
            <input type="password" class="form-control" placeholder="密码" id="password" name="password" required />
            <button class="btn btn-lg btn-warning btn-block" type="submit">登录</button>
            <label class="checkbox"><input id="rmbMe" type="checkbox" >记住我</label>
        </form>
    </div>
    
    <script>
    	var rememberMe = function() {
    		if($("#rmbMe").is(":checked")) {
    			$.cookie("rmbMe", true, {expires: 7});
    			$.cookie("rmbUser", $("#username").val(), {expires: 7});
    			$.cookie("rmbPass", $("#password").val(), {expires: 7});
    		} else $.cookie("rmbMe", false, {expires: -1});
    	};
    	
    	if($.cookie("rmbMe")) {
    		$("#username").val($.cookie("rmbUser"));
    		$("#password").val($.cookie("rmbPass"));
    		$("#rmbMe").attr("checked", true);
    	};
    	
    	$("#form").submit(function(e) {
    		e.preventDefault();
    		rememberMe();
    		$.ajax({
    			type : "post",
    			contentType: "application/json; charset=utf-8",
    			url : "handler/login.do",
    			data : JSON.stringify({
    				username: $("#username").val(), password: $("#password").val(), type: 1}),
    			dataType : "json",
    			success : function(result) {
    				if(result.success) {
        				if(result.code == "0000")
        					location.href = "index.jsp";
    					else layer.msg(result.msg,{icon:0, time:2000});
    				} else layer.msg(result.msg,{icon:2, time:1500});
    			}
    		});
		});
    </script>
</body>
</html>