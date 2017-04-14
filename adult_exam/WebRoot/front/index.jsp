<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-cn">

<head>
    <base href="<%=basePath%>">
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <meta charset="utf-8">
    <title>成人自考首页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="front/css/cloud-admin-frontend.css">
    <link rel="stylesheet" href="front/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="front/css/amimatecss/animate.min.css">
    <link rel="stylesheet" href="front/js/colorbox/colorbox.min.css" />
    <link rel="stylesheet" href="front/css/carousel.css">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700' rel='stylesheet' type='text/css'>
</head>

<body>
    <!-- page -->
    <div id="page">
        <!-- header -->
        <section id="header" data-type="background" data-speed="10">
            <div id="sidebar-collapse" class="sidebar-collapse btn visible-xs">	<i class="fa fa-bars" data-icon2="fa fa-bars" data-icon1="fa fa-bars"></i>
            </div>
            <div class="divide60"></div>
            <div id="mobile-menu" class="list-group collapse text-center"> 
            	<a href="#about" class="list-group-item">学院概况</a>
                <a href="#major-intro" class="list-group-item">专业介绍</a>
                <a href="#notice" class="list-group-item">通知公告</a>
                <a href="#result-view" class="list-group-item">成绩查询</a>
                <a href="#register" class="list-group-item">考试报名</a>
                <c:if test="${!empty sessionScope.frontUser}">
                	<a href="#personal-center" class="list-group-item" style="text-transform: none;">${sessionScope.frontUser.username}，你好！</a>
               		<a href="javascript:;" onclick="logout();" class="list-group-item external" style="color: red;">[退出]</a>
                </c:if>
               	<c:if test="${empty sessionScope.frontUser}">
                	<a href="javascript:;" onclick="location.href='front_login.jsp'" class="list-group-item external">登录/注册 </a>
                </c:if>
            </div>
            <!-- hero -->
            <div class="container-transparent text-center">
                <ul class="heronav left hidden-xs">
                    <li><a href="#about">学院概况</a>
                    </li>
                    <li><a href="#major-intro">专业介绍</a>
                    </li>
                    <li><a href="#notice">通知公告</a>
                    </li>
                </ul>
				<ul class="heronav right hidden-xs">
					<li><a href="#result-view">成绩查询</a></li>
					<li><a href="#register">考试报名</a></li>
					<c:if test="${!empty sessionScope.frontUser}">
						<li><a href="#personal-center" style="text-transform: none;">${sessionScope.frontUser.username}，你好！</a></li>
						<li><a href="javascript:;" onclick="logout();" style="color: red;">[退出]</a></li>
					</c:if>
					<c:if test="${empty sessionScope.frontUser}">
						<li><a href="javascript:;" onclick="location.href='front_login.jsp'">登录/注册</a></li>
					</c:if>
				</ul>
				<h1><img src="img/logo/logo.png" height="50" alt="logo name"></h1>
                <h1 class="page-title">圆一个大学梦</h1>
                <h4 class="page-sub-title">工作不易,你需要一个本科 
				<br>
					想改变现状，想要储备不同行业证书，其实就是差一个本科证书。
				</h4>
                <div class="showcase">	
                	<a class="btn btn-warning btn-lg hidden-xs" href="#about">了解更多 &nbsp;&nbsp;<i class="fa fa-play"></i></a>
                    <a class="btn btn-warning btn-sm visible-xs" href="#about">了解更多 &nbsp;&nbsp;<i class="fa fa-play"></i></a>
                </div>
            </div>
            <!--/hero -->
        </section>
        <!--/header -->
        <!-- nav-bar -->
        <div id="nav-bar">
            <div class="container">
                <div class="row">
                    <div class="col-sm-3 col-md-4">
                        <div class="logo">
                            <a href="#">
                                <img src="img/logo/logo.png" height="40" alt="logo name" />
                            </a>
                        </div>
                    </div>
                    <div class="col-sm-9 col-md-8">
                        <nav id="fixed-top-navigation">
                            <ul class="list-inline pull-right">
                                <li><a href="#about">学院概况</a>
                                </li>
                                <li><a href="#major-intro">专业介绍</a>
                                </li>
                                <li><a href="#notice">通知公告</a>
                                </li>
                                <li><a href="#result-view">成绩查询</a>
                                </li>
                                <li><a href="#register">考试报名</a>
                                </li>
                                <c:if test="${!empty sessionScope.frontUser}">
				                	<li><a href="#personal-center" style="text-transform: none;">${sessionScope.frontUser.username}，你好！</a></li>
				               		<li><a href="javascript:;" onclick="logout();" style="color: red;">[退出]</a></li>
				                </c:if>
				               	<c:if test="${empty sessionScope.frontUser}">
				                	<li><a href="javascript:;" onclick="location.href='front_login.jsp'">登录/注册 </a></li>
				                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <!--/nav-bar -->
        <!-- 学院介绍 -->
        <section id="about" class="color-light text-center">
            <div class="container">
                <div class="divide40"></div>
                <div class="row">
                    <div class="col-md-12">
                        <h2 class="text-center">
							<span class="bigintro">学院介绍</span>
							</h2>
                    </div>
                </div>
                <div class="divide20"></div>
                <div class="row">
                    <div class="col-md-12 about" style="text-align: left;" id="aboutIntro"></div>
                </div>
            </div>
            <div class="divide40"></div>
        </section>
        <section id="parallax-2" data-type="background" data-speed="10" class="pages textcenter">
            <div class="parallax-overlay">
                <h2 class="text-center">
					<span class="bigintro-light">学院特色</span>
				</h2>
                <div id="mycarousel" class="carousel slide">
                    <!-- indicators -->
                    <ol class="carousel-indicators" id="aboutIndi"></ol>
                    <div class="carousel-inner" id="aboutFeat"></div> 
                    <a class="left carousel-control" href="#mycarousel" data-slide="prev"><span class="fa fa-chevron-left fa-2x"></span></a>
                    <a class="right carousel-control" href="#mycarousel" data-slide="next"><span class="fa fa-chevron-right fa-2x"></span></a>
                </div>
                <div class="divide85"></div>
            </div>
        </section>
        <!-- 专业展示 -->
        <section id="major-intro" class="color-light text-center">
            <div class="divide40"></div>
            <div class="row">
                <div class="col-md-12">
                    <h2 class="text-center"><span class="bigintro">专业一览</span></h2>
                </div>
            </div>
            <div class="divide60"></div>
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div id="filters" class="text-center btn-group">
                        <div class="hidden-xs"> <a class="btn btn-lg btn-primary active" data-filter="*" href="#">全部</a>
                            <a class="btn btn-lg btn-warning" data-filter=".design" href="#">热门</a>
                            <a class="btn btn-lg btn-success" data-filter=".videos" href="#">最新</a>
                            <a class="btn btn-lg btn-danger" data-filter=".banners" href="#">传统</a>
                        </div>
                        <div class="visible-xs">
                            <select id="e1" class="form-control">
                                <option value="*">全部</option>
                                <option value=".design">热门</option>
                                <option value=".videos">最新</option>
                                <option value=".banners">传统</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="divide40"></div>
            <div class="container">
                <div id="filter-items" class="row"></div>
            </div>
            <div class="divide60"></div>
        </section>
        <!-- 通知公告 -->
        <section id="notice" class="color-light">
            <div class="container">
                <div class="divide40"></div>
                <div class="row">
                    <div class="col-md-12">
                        <h2 class="text-center">
							<span class="bigintro">通知公告</span>
							</h2>
                    </div>
                </div>
                <div class="divide60"></div>
                <div class="row" id="noticeCont"></div>
                <div class="divide60"></div>
            </div>
        </section>
        <!-- 成绩查询-->
       	<section id="result-view" data-type="background" data-speed="10" class="pages text-center" style="height: 100px!important;">
        </section>
        <!-- 查询 -->
        <section id="signup-again" class="color-primary pattern text-center">
            <section class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="centered big call-to-action">成绩查询</h3>
                    </div>
                </div>
                <div class="divide20"></div>
				<div class="row">
					<div class="col-md-6 col-md-pull-1">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-default dropdown-toggle"
										data-toggle="dropdown" aria-haspopup="true"
										aria-expanded="false">
										报考专业 <span class="caret"></span>
									</button>
									<ul class="dropdown-menu pull-left" id="majorQueryList"></ul>
								</div>
								<input type="text" class="form-control" id="major">
							</div><br />
							<button type="button" class="btn btn-warning pull-right" onclick="queryResults();">查询</button>
					</div>
					
					<div class="col-md-6 col-md-push-1">
						<div class="panel panel-default">
							<div class="panel-heading"><b>查询结果</b></div>
							<div class="panel-body text-danger" id="noResults" style="display: none;"><p>没有查到任何数据……</p></div>
							<table class="table table-striped text-primary text-left" id="results"></table>
						</div>
					</div>
					
				</div>
				<div class="divide20"></div>
            </section>
        </section>
        <c:if test="${sessionScope.frontUser != null}">
	        <section id="personal-center" class="color-light">
	            <div class="container">
	                <div class="divide40"></div>
	                <div class="row">
	                    <div class="col-md-12">
	                        <h2 class="text-center">
								<span class="bigintro">个人信息</span>
								</h2>
	                    </div>
	                </div>
	                <div class="divide40"></div>
					<div class="row">
						<form id="userForm">
							<input type="hidden" name="id" value="${sessionScope.frontUser.id}">
							<fieldset disabled>
								<div class="col-md-6 col-sm-6">
									<div class="form-group">
										<label for="username">用户名</label> <input type="text"
											class="form-control" id="username"
											value="${sessionScope.frontUser.username}" readonly>
									</div>
									<div class="form-group">
										<label for="email">邮箱地址</label> <input type="text"
											class="form-control" id="email"
											value="${sessionScope.frontUser.email}" readonly>
									</div>
									<label for="gender1">性别</label>
									<div class="form-group">
										<label class="radio-inline"><input type="radio"
											id="gender1" name="gender" value="1"
											<c:if test="${sessionScope.frontUser.gender == 1}">checked</c:if>>男</label>
										<label class="radio-inline"><input type="radio"
											id="gender2" name="gender" value="0"
											<c:if test="${sessionScope.frontUser.gender == 0}">checked</c:if>>女</label>
									</div>
								</div>
								<div class="col-md-6 col-sm-6">
									<div class="form-group">
										<label for="name">姓名</label> <input type="text"
											class="form-control" id="name" name="name"
											value="${sessionScope.frontUser.name}">
									</div>
									<div class="form-group">
										<label for="email">出生日期</label> <input class="form-control"
											id="birthdate" name="birthdate" onfocus="laydate({format: 'YYYY-MM-DD'});laydate.skin('danlan');"
											value="${sessionScope.frontUser.birthdate}">
									</div>
								</div>
							</fieldset>
						</form>
						<button class="btn btn-warning btn" type="button" onclick="operUser(this)">修改信息</button>
						<button class="btn btn-info btn" type="button" data-toggle="modal" data-target="#passModal" onclick="$('#passForm')[0].reset()">修改密码</button>
					</div>
					<div class="divide60"></div>
	            </div>
	        </section>
	    </c:if>
        <!-- 考试报名 -->
        <section id="parallax-3" data-type="background" data-speed="10" class="pages text-center">
            <div class="parallax-overlay">
                <section id="register">
                    <section class="container">
                        <div class="divide20"></div>
                        <div class="row">
                            <div class="col-md-12">
                                <h3 class="text-center"><span class="bigintro-light">考试报名</span></h3>
                            </div>
                        </div>
                        <div class="divide20"></div>
                        <div class="row">
	                        <div class="btn-group">
							  <button type="button" class="btn btn-default dropdown-toggle exam-width" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							    <span id="regMajorName">选择专业 </span> <span class="caret"></span>
							  </button>
							  <ul class="dropdown-menu exam-width" id="majorRegList"></ul>
							</div>
							<div class="divide20"></div>
							<div class="list-group exam-info"></div>
						    
						    <div class="col-md-6 col-md-offset-3 form-submit">
                                <button id="submit" class="btn btn-warning btn-lg" type="button">报名提交</button>
                            </div>
						</div>
                    </section>
                </section>
            </div>
        </section>
        <!--/register-us -->
        <!-- footer -->
        <section id="footer" class="color-light pattern">
            <div class="container"></div>
        </section>
        <!--/footer -->
    </div>
    <!-- modal -->
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
						<input type="hidden" name="id" value="${sessionScope.frontUser.id}">
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
					<button type="button" class="btn btn-primary" onclick="updatePass()">确认</button>
				</div>
			</div>
		</div>
	</div>
    
    <!--/page -->
    <script src="js/jquery/jquery-2.0.3.min.js"></script>
    <script src="bootstrap-dist/js/bootstrap.min.js"></script>
    <script src="front/js/waypoint/waypoints.min.js"></script>
    <script src="front/js/navmaster/jquery.scrollTo.js"></script>
    <script src="front/js/navmaster/jquery.nav.js"></script>
    <script src="front/js/isotope/jquery.isotope.min.js"></script>
    <script src="front/js/isotope/imagesloaded.pkgd.min.js"></script>
    <!-- colorbox -->
    <script src="front/js/colorbox/jquery.colorbox.min.js"></script>
    <script src="front/js/script.non-min.js"></script>
    <script src="js/layer/layer.js"></script>
    <script src="js/layer/laydate/laydate.js"></script>
    <script src="js/jquery.serializeJSON.js"></script>
    <script src="front/js/custom.js"></script>
</body>

</html>