<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <base href="<%=basePath%>">
    <title>成人自考 | 登录</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="css/cloud-admin.css">
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- DATE RANGE PICKER -->
    <link rel="stylesheet" href="js/bootstrap-daterangepicker/daterangepicker-bs3.css" />
    <!-- UNIFORM -->
    <link rel="stylesheet" href="js/uniform/css/uniform.default.min.css" />
    <!-- ANIMATE -->
    <link rel="stylesheet" href="css/animatecss/animate.min.css" />
    <!-- FONTS -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700' rel='stylesheet'>
	<style type="text/css">
		.login-box input { font-size: 14px;}
	</style>
</head>

<body class="login">
    <!-- PAGE -->
    <section id="page">
        <!-- HEADER -->
        <header>
            <!-- NAV-BAR -->
            <div class="container">
                <div class="row">
                    <div class="col-md-4 col-md-offset-4">
                        <div id="logo">
                            <a href="front/index.jsp">
                                <img src="img/logo/logo.png" height="40" alt="logo name" />
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <!--/NAV-BAR -->
        </header>
        <!--/HEADER -->
        <!-- LOGIN -->
        <section id="login_bg" class="visible">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 col-md-offset-4">
                        <div class="login-box">
                            <h2 class="bigintro">登&nbsp;&nbsp;&nbsp;录</h2>
                            <div class="divide-40"></div>
                            <form role="form">
                                <div class="form-group">
                                    <label for="user_mail">用户名或邮箱</label> <i class="fa fa-user"></i>
                                    <input type="email" class="form-control" id="user_mail" name="user_mail">
                                </div>
                                <div class="form-group">
                                    <label for="pass">密码</label> <i class="fa fa-lock"></i>
                                    <input type="password" class="form-control" id="pass" name="pass">
                                </div>
                                <div>
                                    <label class="checkbox"><input type="checkbox" class="uniform" value="" id="rmbMe" >记住我</label>
                                    <button type="button" class="btn btn-danger" onclick="login()">提&nbsp;&nbsp;&nbsp;交</button>
                                </div>
                            </form>
                            <div class="login-helpers"> <a href="#" onclick="swapScreen('forgot_bg');return false;">忘记密码?</a>
                            </div>
                            <div class="login-helpers">没有我们的账号？<a href="#" onclick="swapScreen('register_bg');return false;">现在注册！</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--/LOGIN -->
        <!-- REGISTER -->
        <section id="register_bg" class="font-400">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 col-md-offset-4">
                        <div class="login-box">
                            <h2 class="bigintro">注&nbsp;&nbsp;&nbsp;册</h2>
                            <div class="divide-40"></div>
                            <form role="form" id="registerForm">
                                <div class="form-group">
                                    <label for="username">用户名</label> <i class="fa fa-user"></i>
                                    <input type="text" class="form-control" id="username" name="username">
                                </div>
                                <div class="form-group">
                                    <label for="email">邮箱</label> <i class="fa fa-envelope"></i>
                                    <input type="email" class="form-control" id="email" name="email">
                                    <div class="col-md-6 col-md-offset-6" style="padding: 0px; display: none;">
                                    	<button type="button" class="btn btn-info btn-xs" id="sendCode">发送验证码</button>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="authCode">邮箱验证码</label> <i class="fa fa-font"></i>
                                    <input type="text" class="form-control" id="authCode" name="authCode" placeholder="区分大小写">
                                </div>
                                <div class="form-group">
                                    <label for="password">密码</label> <i class="fa fa-lock"></i>
                                    <input type="password" class="form-control" id="password" name="password">
                                </div>
                                <div class="form-group">
                                    <label for="repeatPass">确认密码</label> <i class="fa fa-check-square-o"></i>
                                    <input type="password" class="form-control" id="repeatPass" name="repeatPass">
                                </div>
                                <div>
                                    <label class="checkbox">
                                        <input type="checkbox" class="uniform" value="" id="agree">我同意  
                                        <a href="javascript:;" onclick="layer.tips('这是服务条款！这是服务条款！这是服务条款！这是服务条款！这是服务条款！这是服务条款！这是服务条款！这是服务条款！这是服务条款！',this,{tips:[1]});">服务条款</a> 和
                                        <a href="javascript:;" onclick="layer.tips('这是隐私政策！这是隐私政策！这是隐私政策！这是隐私政策！这是隐私政策！这是隐私政策！这是隐私政策！……',this,{tips:[1]});">隐私政策</a>
                                    </label>
                                    <button type="button" class="btn btn-success" id="registerSubmit">注册</button>
                                </div>
                            </form>
                            <div class="login-helpers"> <a href="#" onclick="swapScreen('login_bg');return false;">返回登录</a> 
                                <br>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--/REGISTER -->
        <!-- FORGOT PASSWORD -->
        <section id="forgot_bg">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 col-md-offset-4">
                        <div class="login-box">
                            <h3 class="bigintro">重置密码</h3>
                            <div class="divide-40"></div>
                            <form role="form">
                                <div class="form-group">
                                    <label for="resetEmail">输入 邮箱地址</label> <i class="fa fa-envelope"></i>
                                    <input type="email" class="form-control" id="resetEmail" name="resetEmail">
                                </div>
                                <div>
                                    <button type="button" class="btn btn-info" onclick="sendReset()" >发送密码重置指令</button>
                                </div>
                            </form>
                            <div class="login-helpers"> <a href="#" onclick="swapScreen('login_bg');return false;">返回登录</a> 
                                <br>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- FORGOT PASSWORD -->
    </section>
    <!--/PAGE -->
    <!-- JAVASCRIPTS -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!-- JQUERY -->
    <script src="js/jquery/jquery-2.0.3.min.js"></script>
    <!-- JQUERY TO JSON -->
    <script src="js/jquery.serializeJSON.js"></script>
     <!-- JQUERY Cookie -->
    <script src="js/jQuery-Cookie/jquery.cookie.min.js"></script>
    <!-- JQUERY UI-->
    <script src="js/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js"></script>
    <!-- BOOTSTRAP -->
    <script src="bootstrap-dist/js/bootstrap.min.js"></script>
    <!-- UNIFORM -->
    <script type="text/javascript" src="js/uniform/jquery.uniform.min.js"></script>
    <!-- BACKSTRETCH -->
    <script type="text/javascript" src="js/backstretch/jquery.backstretch.min.js"></script>
    <!-- CUSTOM SCRIPT -->
    <script src="js/script.js"></script>
    <script src="js/layer/layer.js"></script>
    <script>
        jQuery(document).ready(function() {
            App.setPage("login_bg"); //Set current page
            App.init(); //Initialise plugins and elements
        });
        function swapScreen(id) {
            jQuery('.visible').removeClass('visible animated fadeInUp');
            jQuery('#' + id).addClass('visible animated fadeInUp');
        }
        var emailReg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/; 
        var usernameReg = /^[a-zA-Z0-9_]+$/;
        var realEmail = null;
        var realCode = null;
        var contentType = "application/json; charset=utf-8";
        $("#registerSubmit").click(function() {
        	var username = $("#username").val().trim();
        	var email = $("#email").val().trim();
        	var authCode = $("#authCode").val().trim();
        	var password = $("#password").val().trim();
        	var repeatPass = $("#repeatPass").val().trim();
            if(username.length == 0) {
            	layer.tips('请输入用户名', '#username');
            	return false;
            }
            if(!usernameReg.test(username)) {
            	layer.tips('用户名由数字字母下划线组成', '#username');
            	return false;
            }
            if(!validator(0)) return false;
            if(email.length == 0) {
            	layer.tips('请输入邮箱地址', '#email');
            	return false;
            }
            if(!emailReg.test(email)) {
            	layer.tips('请输入正确的邮箱地址', '#email');
            	return false;
            }
            if(!validator(1)) return false;
            if(authCode.length == 0) {
            	layer.tips('请输入邮箱验证码', '#authCode');
            	return false;
            }
            if(email != realEmail || authCode != realCode) {
            	layer.tips('验证码与邮箱不匹配', '#authCode');
            	return false;
            }
            if(password.length < 6) {
            	layer.tips('请输入密码（不少于6位）', '#password');
            	return false;
            }
            if(repeatPass.length == 0) {
            	layer.tips('请确认密码', '#repeatPass');
            	return false;
            }
            if(password != repeatPass) {
            	layer.tips('两次输入密码不一致', '#repeatPass');
            	return false;
            }
            if(!$("#agree").is(":checked")) {
            	layer.tips('请同意服务条款和隐私政策', '#agree',{tips:4});
            	return false;
            }
        	$.ajax({
        		contentType: contentType,
        		url: "handler/register.do",
        		type: "post",
        		data: JSON.stringify($("#registerForm").serializeJSON()),
        		dataType: "json",
        		success: function(result) {
        			if(result.success) {
        				layer.msg(result.msg,{icon:1});
        				setTimeout(function() { location.reload();}, 1500);
        			} else layer.msg(result.msg,{icon:2});
        		}
        	});
        });
        var validator = function(type) {
        	var id = "username", msg = "该用户名已存在",flag = false; 
        	var data = {username: $('#'+id).val().trim(), type:0};
        	if(type == 1) {
        		id = "email"; msg = "该邮箱已被注册"; data = {email: $('#'+id).val().trim(), type:0};
        	}
        	if($('#'+id).val().trim().length > 0)
	        	$.ajax({
	        		contentType: contentType,
	        		url: "handler/validateUsers.do",
	        		type: "post",
	        		async: false,
	        		data: JSON.stringify(data),
	        		dataType: "json",
	        		success: function(result) {
	        			if(result.success) {
	        				if(result.code == "0001")
	        					layer.tips(msg,'#'+id);
	        				else flag = true;
	        			} else layer.msg(result.msg,{icon:2});
	        		}
	        	});
        	return flag;
        };
        
        $("#username").blur(function () {
        	validator(0);
		});
       
        $("#email").blur(function () {
        	if(realCode == null) {
	        	var email = $('#email').val().trim();
	       		if(!emailReg.test(email))
	               	layer.tips('请输入正确的邮箱地址', '#email');
	            else if(validator(1)) {
	           		$('#sendCode').parent().show();
	           		$('#sendCode').attr('disabled',false);
	            }
        	}
		});
        $("#sendCode").click(function() {
        	layer.load(0, {content:"<div style='margin-left:60px;width:150px;font-size:15px;'>邮件发送中...</div>"});
        	$('#sendCode').attr('disabled',true);
        	$.ajax({
        		contentType: contentType,
        		url: "handler/sendEmail.do",
        		type: "post",
        		data: JSON.stringify({address: $('#email').val(), type: 0}),
        		dataType: "json",
        		success: function(result) {
        			layer.closeAll();
        			if(result.success) {
						var data = result.data;
						realCode = data.code;
						realEmail = data.address;
						layer.msg(result.msg,{icon:1, time:1500});
						$("#sendCode").parent().hide();
        			} else {
        				layer.msg(result.msg,{icon:2,time:1000});
        				$('#sendCode').attr('disabled',false);
        			}
        		}
        	});
        });

        var rememberMe = function() {
    		if($("#rmbMe").is(":checked")) {
    			$.cookie("loginRmbMe", true, {expires: 7});
    			$.cookie("rmbUser_mail", $("#user_mail").val(), {expires: 7});
    			$.cookie("rmbPassword", $("#pass").val(), {expires: 7});
    		} else $.cookie("loginRmbMe", false, {expires: -1});
    	};
    	if($.cookie("loginRmbMe")) {
    		$("#user_mail").val($.cookie("rmbUser_mail"));
    		$("#pass").val($.cookie("rmbPassword"));
    		$("#rmbMe").attr("checked", true);
    	};
		var login = function () {
			var username = $('#user_mail').val().trim();
			if(username.length == 0) {
				layer.tips('请输入用户名或邮箱','#user_mail');
				return false;
			}
			var password = $('#pass').val().trim();
			if(password.length == 0) {
				layer.tips('请输入密码','#pass');
				return false;
			}
			rememberMe();
    		$.ajax({
    			type : "post",
    			contentType: contentType,
    			url : "handler/login.do",
    			data : JSON.stringify({username: username, password: password, type: 0}),
    			dataType : "json",
    			success : function(result) {
    				if(result.success)
    					if(result.code == "0000")
        					location.href = "front/index.jsp";
    					else layer.msg(result.msg,{icon:0, time:2000});
    				else layer.msg(result.msg,{icon:2, time:1500});
    			}
    		});
			
		};
        var sendReset = function() {
        	var email = $('#resetEmail').val().trim();
       		if(!emailReg.test(email)) {
               	layer.tips('请输入正确的邮箱地址', '#resetEmail');
               	return false;
       		}
       		$.ajax({
        		contentType: contentType,
        		url: "handler/validateUsers.do",
        		type: "post",
        		async: false,
        		data: JSON.stringify({email: email, type: 0}),
        		dataType: "json",
        		success: function(result) {
        			if(result.success)
        				if(result.code == "0001") {
        					layer.load(0, {content:"<div style='margin-left:60px;width:150px;font-size:15px;'>邮件发送中...</div>"});
        		        	$.ajax({
        		        		contentType: contentType,
        		        		url: "handler/sendEmail.do",
        		        		type: "post",
        		        		data: JSON.stringify({address: email, type: 1}),
        		        		dataType: "json",
        		        		success: function(result) {
        		        			layer.closeAll();
        		        			if(result.success) {
        		        				layer.msg(result.msg,{icon:1});
        		        				setTimeout(function() {location.href = "front/index.jsp";}, 1500);
        		        			} else layer.msg(result.msg,{icon:2,time:1000});
        		        		}
        		        	});
        				} else layer.tips('该邮箱不存在，请重新输入', '#resetEmail');
        			else {
        				layer.msg(result.msg,{icon:2});
        				return false;
        			}
        		}
        	});
        };
    </script>
    <!-- /JAVASCRIPTS -->
</body>

</html>