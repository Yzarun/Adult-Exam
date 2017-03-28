<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>成人自考后台管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="css/cloud-admin.css">
    <link rel="stylesheet" href="css/themes/default.css" id="skin-switcher">
    <link rel="stylesheet" href="css/responsive.css">
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700' rel='stylesheet' type='text/css'>
    <script src="js/jquery/jquery-2.0.3.min.js"></script>
    <script src="js/jquery/jquery-migrate-1.2.1.min.js"></script>
    <script src="js/jquery.serializeJSON.js"></script>
    <script src="js/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="bootstrap-dist/js/bootstrap.min.js"></script>
    <script src="js/jQuery-Cookie/jquery.cookie.min.js"></script>
    <script src="js/layer/layer.js"></script>
    <script src="js/layer/laydate/laydate.js"></script>
</head>
<body>
    <!-- HEADER -->
    <header class="navbar clearfix" id="header">
        <div class="container">
            <div class="navbar-brand">
                <!-- COMPANY LOGO -->
                <a href="index.jsp">
                    <img src="img/logo/logo.png" alt="Cloud Admin Logo" class="img-responsive" height="30" width="120">
                </a>
                <!-- /COMPANY LOGO -->
                <!-- SIDEBAR COLLAPSE -->
                <div id="sidebar-collapse" class="sidebar-collapse btn"> <i class="fa fa-bars" data-icon1="fa fa-bars" data-icon2="fa fa-bars"></i>
                </div>
                <!-- /SIDEBAR COLLAPSE -->
            </div>
            <!-- NAVBAR LEFT -->
            <ul class="nav navbar-nav pull-left hidden-xs" id="navbar-left">
                <li class="dropdown">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-cog"></i>
                        <span class="name">皮肤</span>
                        <i class="fa fa-angle-down"></i>
                    </a>
                    <ul class="dropdown-menu skins">
                        <li class="dropdown-title"> <span><i class="fa fa-leaf"></i>主题皮肤</span>
                        </li>
                        <li><a href="javascript:;" data-skin="default">微妙（默认）</a>
                        </li>
                        <li><a href="javascript:;" data-skin="night">夜晚</a>
                        </li>
                        <li><a href="javascript:;" data-skin="earth">地球</a>
                        </li>
                        <li><a href="javascript:;" data-skin="utopia">乌托邦</a>
                        </li>
                        <li><a href="javascript:;" data-skin="nature">自然</a>
                        </li>
                        <li><a href="javascript:;" data-skin="graphite">石墨</a>
                        </li>
                    </ul>
                </li>
            </ul>
            <!-- /NAVBAR LEFT -->
            <!-- BEGIN TOP NAVIGATION MENU -->
            <ul class="nav navbar-nav pull-right">
                <!-- BEGIN USER LOGIN DROPDOWN -->
                <li class="dropdown user" id="header-user">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">
                        <img alt="" src="img/avatars/avatar2.jpg" /> <span class="username">${sessionScope.backUser.username}</span>
                        <i class="fa fa-angle-down"></i>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a data-toggle="modal" data-target="#adminModal" onclick="$('#adminForm')[0].reset()"><i class="fa fa-user"></i>&nbsp;&nbsp;个人信息</a></li>
                        <li><a data-toggle="modal" data-target="#passModal" onclick="$('#passForm')[0].reset()"><i class="fa fa-lock"></i>&nbsp;&nbsp;密码管理</a></li>
                        <li><a onclick="logout();"><i class="fa fa-power-off"></i>&nbsp;&nbsp;退出</a> </li>
                    </ul>
                </li>
                <!-- END USER LOGIN DROPDOWN -->
            </ul>
            <!-- END TOP NAVIGATION MENU -->
        </div>
    </header>
    <!--/HEADER -->
	<!-- Modal -->
	<div class="modal fade" id="adminModal" tabindex="-1" role="dialog"
		aria-labelledby="adminModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="adminModalLabel">个人信息</h4>
				</div>
				<div class="modal-body">
					<form id="adminForm">
						<input type="hidden" name="id" value="${sessionScope.backUser.id}">
						<fieldset disabled>
							<div class="form-group">
								<label for="username">用户名</label> <input type="text" value="${sessionScope.backUser.username}"
									class="form-control" id="username" name="username" placeholder="用户名" readonly>
							</div>
							<div class="form-group">
								<label for="name">姓名</label> <input type="text" value="${sessionScope.backUser.name}"
									class="form-control" id="name" name="name" placeholder="真实姓名">
							</div>
							<div class="form-group">
								<label for="gender1">性别</label>
								<div>
									<label class="radio-inline"> <input type="radio" ${sessionScope.backUser.gender == 1 ? "checked" : ""}
										name="gender" id="gender1" value="1"> 男
									</label> 
									<label class="radio-inline"> <input type="radio" ${sessionScope.backUser.gender == 0 ? "checked" : ""}
										name="gender" value="0"> 女
									</label>
								</div>
							</div>
							<div class="form-group">
								<label for="birthdate">出生年月</label> <input type="text" value="${sessionScope.backUser.birthdate}"
									class="form-control" id="birthdate" name="birthdate" placeholder="出生年月" onfocus="laydate({format:'YYYY-MM-DD'});">
							</div>
						</fieldset>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<input type="button" class="btn btn-primary" onclick="operInfo(this)" value="修改" />
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="passModal" tabindex="-1" role="dialog"
		aria-labelledby="passModalLabel">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="passModalLabel">密码修改</h4>
				</div>
				<div class="modal-body">
					<form id="passForm">
						<input type="hidden" name="id" value="${sessionScope.backUser.id}">
						<div class="form-group">
							<label for="origPass">原始密码</label> <input onfocus="$('#passAlert').hide()"
								type="password" class="form-control" id="origPass" name="origPass"
								placeholder="原始密码">
						</div>
						<div class="form-group">
							<label for="newPass">新密码</label> <input onfocus="$('#passAlert').hide()"
								type="password" class="form-control" id="newPass" name="newPass"
								placeholder="新密码">
						</div>
						<div class="form-group">
							<label for="repeatPass">确认密码</label> <input onfocus="$('#passAlert').hide()"
								type="password" class="form-control" id="repeatPass"
								placeholder="确认密码">
						</div>
						<div id="passAlert" class="alert alert-warning" style="display: none;">
							<strong>警告！</strong><span>……</span>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<input type="button" class="btn btn-primary" onclick="updatePass()" value="确认" />
				</div>
			</div>
		</div>
	</div>

	<!-- PAGE -->
    <section id="page">
        <!-- SIDEBAR -->
        <div id="sidebar" class="sidebar">
            <div class="sidebar-menu nav-collapse">
                <ul>
                    <li class="active">
                        <a href="index.jsp"> <i class="fa fa-tachometer fa-fw"></i>  <span class="menu-text">主控台</span>
                            <span class="selected"></span>
                        </a>
                    </li>
                    <li class="has-sub">
                        <a href="javascript:;" class=""> <i class="fa fa-desktop fa-fw"></i>  <span class="menu-text">通用管理</span>
                            <span class="arrow"></span>
                        </a>
                        <ul class="sub">
                            <li><a class="" href="javascript:;" onclick="toPage('about', 'jqgrid_about');"><span class="sub-menu-text">学院介绍</span></a></li>
                            <li><a class="" href="javascript:;" onclick="toPage('notice', 'jqgrid_notice');"><span class="sub-menu-text">通知公告</span></a></li>
                        </ul>
                    </li>
                    <li><a class="" href="javascript:;" onclick="toPage('major', 'jqgrid_major');"><i class="fa fa-th-large fa-fw"></i> <span class="menu-text">专业设置</span></a>
                    <li><a class="" href="javascript:;" onclick="toPage('examinee', 'jqgrid_examinee');"><i class="fa fa-users fa-fw"></i> <span class="menu-text">考生管理</span></a>
                    <li><a class="" href="javascript:;" onclick="toPage('exam', 'jqgrid_exam');"><i class="fa fa-bar-chart-o fa-fw"></i> <span class="menu-text">考试管理</span></a>
                   
                    <li class="has-sub">
                        <a href="javascript:;" class=""> <i class="fa fa-pencil-square-o fa-fw"></i>  <span class="menu-text">用户管理</span>
                            <span class="arrow"></span>
                        </a>
                        <ul class="sub">
                            <li><a class="" href="javascript:;" onclick="toPage('users0', 'jqgrid_users0');"><span class="sub-menu-text">平台用户</span></a>
                            </li>
                            <li><a class="" href="javascript:;" onclick="toPage('users1','jqgrid_users1');"><span class="sub-menu-text">后台管理员</span></a>
                            </li>
                        </ul>
                    </li>
                </ul>
                <!-- /SIDEBAR MENU -->
            </div>
        </div>
        <!-- /SIDEBAR -->
        <div id="main-content">
            <div class="container">
                <div class="row">
                    <div id="content" class="col-lg-12"></div>
                    <div class="footer-tools">	
                    	<span class="go-top"><i class="fa fa-chevron-up"></i> TOP</span>
                    </div>
                </div>
                <!-- /CONTENT-->
            </div>
        </div>
    </section>
    <!--/PAGE -->
	<script>
		$(function() {
			if (${sessionScope.backUser == null}) {
				layer.confirm("你还没有登录，请先登录", {
					icon : 2,
					title : "提示",
					closeBtn : 0,
					btn : [ '确定' ]
				}, function() {
					top.location.href = "back_login.jsp";
				});
				return false;
			}
			toPage("dashboard", "dashboard");
		});

		var toPage = function(param1, param2) {
			$('#content').load(param1 + '.jsp', function() {
				App.setPage(param2);
				App.init();
			});
		};

		$("#sidebar li").click(function() {
			$(this).addClass("active");
			$(this).siblings().removeClass("active", function() {
				$(this).removeClass("open");
				$(this).find("span.arrow").removeClass("open");
				$(this).find("ul.sub").hide();
			});
		});

		var operInfo = function(elem) {
			if ($(elem).val() == "修改") {
				$(elem).val("保存");
				$("#adminForm").find("fieldset").attr("disabled", false);
			} else {
				$.ajax({
					contentType : "application/json; charset=utf-8",
					type : "post",
					url : "back/updateUser.do",
					data : JSON.stringify($("#adminForm").serializeJSON()),
					dataType : "json",
					success : function(result) {
						if (result.success) {
							$("#adminModal").modal("hide");
							location.reload();
						} else
							alert("修改信息失败");
					},
					error : function(xhr) {
						if (xhr.responseText == "loseSession") {
							alert("请先登录");
							top.location.href = "back_login.jsp";
						}
					}
				});

			}
		};

		var updatePass = function() {
			var showWarn = function(msg) {
				$("#passAlert").find("span").text(msg);
				$("#passAlert").show();
			};
			var origPass = $("#origPass").val().trim();
			var newPass = $("#newPass").val().trim();
			var repeatPass = $("#repeatPass").val().trim();
			if (origPass.length == 0) {
				showWarn('请输入原始密码');
				return false;
			}
			if (newPass.length < 6) {
				showWarn('请输入新密码（不少于6位）');
				return false;
			}
			if (repeatPass.length == 0) {
				showWarn('请确认密码');
				return false;
			}
			if (newPass != repeatPass) {
				showWarn('两次输入密码不一致');
				return false;
			}
			$.ajax({
				contentType : "application/json; charset=utf-8",
				type : "post",
				url : "back/updatePass.do",
				data : JSON.stringify($("#passForm").serializeJSON()),
				dataType : "json",
				success : function(result) {
					if (result.success)
						if(result.code == "0000") {
							$("#passModal").modal("hide");
							alert("密码修改成功，请重新登录");
							top.location.href = "back_login.jsp";
						} else if(result.code == "0004") showWarn(result.msg);
					else showWarn('密码修改失败！');
				},
				error : function(xhr) {
					if (xhr.responseText == "loseSession") {
						alert("请先登录");
						top.location.href = "back_login.jsp";
					}
				}
			});
		};
		var logout = function() {
			$.ajax({
				url : "logout.do?type=1",
				async : false
			});
			location.href = "back_login.jsp";
		};
	</script>

</body>

</html>