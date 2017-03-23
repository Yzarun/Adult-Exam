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
    <!-- animate -->
    <link rel="stylesheet" href="front/css/amimatecss/animate.min.css">
    <!-- colorbox -->
    <link rel="stylesheet" href="front/js/colorbox/colorbox.min.css" />
    <!-- carousel -->
    <link rel="stylesheet" href="front/css/carousel.css">
    <!-- fonts -->
    <link rel='stylesheet' href='http://fonts.googleapis.com/css?family=open+sans:300,400,600'>
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
                <c:if test="${sessionScope.frontUser != null}">
                	<a href="#personal-center" class="list-group-item" style="text-transform: none;">${sessionScope.frontUser.username}，你好！</a>
               		<a href="javascript:;" onclick="logout();" class="list-group-item external" style="color: red;">[退出]</a>
                </c:if>
               	<c:if test="${sessionScope.frontUser == null}">
                	<a href="front_login.jsp" class="list-group-item external">登录/注册 </a>
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
					<c:if test="${sessionScope.frontUser != null}">
						<li><a href="#personal-center" style="text-transform: none;">${sessionScope.frontUser.username}，你好！</a></li>
						<li><a href="javascript:;" onclick="logout();" style="color: red;">[退出]</a></li>
					</c:if>
					<c:if test="${sessionScope.frontUser == null}">
						<li><a href="front_login.jsp">登录/注册</a></li>
					</c:if>
				</ul>
				<h1><img src="img/logo/logo.png" height="50" alt="logo name"></h1>
                <h1 class="page-title">圆一个大学梦</h1>
                <h4 class="page-sub-title">工作不易,你需要一个本科 
						<br>
							想改变现状，想要储备不同行业证书，其实就是差一个本科证书。
						</h4>
                <div class="showcase">	<a class="btn btn-warning btn-lg hidden-xs" href="#about">了解更多 &nbsp;&nbsp;<i class="fa fa-play"></i></a>
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
                            <a href="front/index.jsp">
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
                                <c:if test="${sessionScope.frontUser != null}">
				                	<li><a href="#personal-center" style="text-transform: none;">${sessionScope.frontUser.username}，你好！</a></li>
				               		<li><a href="javascript:;" onclick="logout();" style="color: red;">[退出]</a></li>
				                </c:if>
				               	<c:if test="${sessionScope.frontUser == null}">
				                	<li><a href="front_login.jsp">登录/注册 </a></li>
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
                    <div class="col-md-12 about" style="text-align: left;text-indent: 2em;">
                        <p>蚌埠学院是一所以工学学科为主，工学、文学、理学、管理学、经济学、教育学多学科协调发展的教学型普通本科院校。成人教育学院是负责统筹、协调、组织和管理全院成人高等学历教育和非学历教育培训的二级机构。下设办公室、教务科、学籍科、教研室和继教办五个科室。
                        <p>蚌埠学院成人教育学院办学时间长，师资力量强，开设专业全，管理科学规范。经过二十几年的不断探索和发展，初步形成了高等学历教育和非学历教育并举的办学体系和发展格局。目前，高等学历教育在籍学员近2000人，既有本院举办的专科函授、业余和脱产教育，又有与安徽师范大学联合举办的本科函授教育；此外还与安徽师范大学、合肥工业大学、安徽大学、安徽财经大学、安徽工程科技学院等名校联合举办的高等教育自学考试（二学历）本科教育。我院的成人学历教育有函授、业余、脱产教育多形式，本科、专科多层次，主办、联办多渠道的特点，为社会培养和输送了大量的各类专业技术人才，在社会上享有较高的声誉。非学历教育也面向社会开展了多种多样的培训业务，培训项目主要有：“计算机数字图形图像应用技术等级证书”、“职业指导人员”等多种资格证书的培训考证。
					</div>
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
                    <ol class="carousel-indicators">
                        <li data-target="#mycarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#mycarousel" data-slide-to="1"></li>
                        <li data-target="#mycarousel" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                        <div class="item active">
                            <div class="container">
                                <div class="carousel-caption">
                                    <div class="row">
                                        <div class="circular col-md-6" >
                                            <img src="front/img/testimonials/1.jpg" alt="headshot #1" />
                                            <h3>自学考试</h3>
                                            <p style="text-align: left;text-indent: 2em;">近年来，成人教育学院特别注重成人高等教育学科建设、专业建设和成人教育改革与发展的规律、趋势和政策法规的研究，在成人教育的常规管理、专业建设、教学研究等方面都取得了一定的成就。在常规管理上，注重建立健全各项规章制度，并与各站（函授站）点（教学点）密切合作，推行规范化、制度化、科学化、人性化管理
                                        </div>
                                        <div class="circular col-md-6">
                                            <img src="front/img/testimonials/2.jpg" alt="headshot #2" />
                                            <h3>成人考试</h3>
                                            <p style="text-align: left;text-indent: 2em;">　面对新的机遇和新的挑战，成人教育学院将在蚌埠学院党委的正确领导下，依托学院的丰富教学资源，以质量求生存，以改革促发展，在教学计划、课程设置、师资队伍等方面，切实加强建设和管理，确保我院成人高等教育专业的人才培养规格和质量，争取把学院的成人教育工作推上一个新台阶。
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="container">
                                <div class="carousel-caption">
                                    <div class="row">
                                        <div class="circular col-md-6">
                                            <img src="front/img/testimonials/3.jpg" alt="headshot #3" />
                                            <h3>远程、函授</h3>
                                            <p style="text-align: left;text-indent: 2em;">招生工作围绕学院“地方性、应用型、工程化”的办学定位，紧密联系地方经济和社会发展的实际，主动适应“实基础、适口径、重应用、强素质”的应用型人才培养规格定位，积极拓宽发展空间。努力开拓工作新局面。
                                        </div>
                                        <div class="circular col-md-6">
                                            <img src="front/img/testimonials/4.jpg" alt="headshot #4" />
                                            <h3>特色专业</h3>
                                            <p style="text-align: left;text-indent: 2em;"> 蚌埠学院是一所以工为主，工学、文学、理学、管理学、经济学、教育学多学科协调发展的应用型普通本科院校。学院的成人高等学历教育由其继续教育学院全面负责。我院成人高等教育办学时间长，师资力量强，开设专业全，管理科学规范。二十多年来已有数万名成教毕业生从这里走向社会，成为社会各个行业的优秀人才和中坚力量。
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> <a class="left carousel-control" href="#mycarousel" data-slide="prev"><span class="fa fa-chevron-left fa-2x"></span></a>
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
                    <h2 class="text-center">
								<span class="bigintro">专业一览</span>
								</h2>
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
                <div id="filter-items" class="row">
                    <div class="col xs-12 col-sm-4 design item">
                        <div class="filter-content">
                            <img src="front/img/gallery/1.jpg" alt="" class="img-responsive" />
                            <div class="image-content">
                                <h4>专业名称</h4>
                                <p class="hidden-xs hidden-sm text-height">中国大学共有12个学科，中国大学共有12个学科，中国大学共有12个学科，中国大学共有12个学科，61个大学专业类506个大学专业学专业类506个大学专业学专业类506个大学专业学专业类506个大学专业学专业类</p>	
                                <a href="front/img/gallery/1.jpg" class="btn btn-sm btn-warning colorbox-button">了解更多</a>
                            </div>
                        </div>
                    </div>
                    <div class="col xs-12 col-sm-4 videos item">
                        <div class="filter-content">
                            <img src="front/img/gallery/2.jpg" alt="" class="img-responsive" />
                            <div class="image-content">
                                <h4>专业名称</h4>
                                <p class="hidden-xs hidden-sm text-height">中国大学共有12个学科，61个大学专业类，506个大学专业。</p>	
                                <a href="front/img/gallery/2.jpg" class="btn btn-sm btn-warning colorbox-button">了解更多</a>
                            </div>
                        </div>
                    </div>
                    <div class="col xs-12 col-sm-4 banners item">
                        <div class="filter-content">
                            <img src="front/img/gallery/3.jpg" alt="" class="img-responsive" />
                            <div class="image-content">
                                <h4>专业名称</h4>
                                <p class="hidden-xs hidden-sm text-height">中国大学共有12个学科，61个大学专业类，506个大学专业。</p>	
                                <a href="front/img/gallery/3.jpg" class="btn btn-sm btn-warning colorbox-button">了解更多</a>
                            </div>
                        </div>
                    </div>
                    <div class="col xs-12 col-sm-4 videos item">
                        <div class="filter-content">
                            <img src="front/img/gallery/4.jpg" alt="" class="img-responsive" />
                            <div class="image-content">
                                <h4>专业名称</h4>
                                <p class="hidden-xs hidden-sm text-height">中国大学共有12个学科，61个大学专业类，506个大学专业。</p>	
                                <a href="front/img/gallery/4.jpg" class="btn btn-sm btn-warning colorbox-button">了解更多</a>
                            </div>
                        </div>
                    </div>
                    <div class="col xs-12 col-sm-4 design item">
                        <div class="filter-content">
                            <img src="front/img/gallery/5.jpg" alt="" class="img-responsive" />
                            <div class="image-content">
                                <h4>专业名称</h4>
                                <p class="hidden-xs hidden-sm text-height">中国大学共有12个学科，61个大学专业类，506个大学专业。</p>	
                                <a href="front/img/gallery/5.jpg" class="btn btn-sm btn-warning colorbox-button">了解更多</a>
                            </div>
                        </div>
                    </div>
                    <div class="col xs-12 col-sm-4 banners item">
                        <div class="filter-content">
                            <img src="front/img/gallery/6.jpg" alt="" class="img-responsive" />
                            <div class="image-content">
                                <h4>专业名称</h4>
                                <p class="hidden-xs hidden-sm text-height">中国大学共有12个学科，61个大学专业类，506个大学专业。</p>	
                                <a href="front/img/gallery/6.jpg" class="btn btn-sm btn-warning colorbox-button">了解更多</a>
                            </div>
                        </div>
                    </div>
                    <div class="col xs-12 col-sm-4 banners item">
                        <div class="filter-content">
                            <img src="front/img/gallery/7.jpg" alt="" class="img-responsive" />
                            <div class="image-content">
                                <h4>专业名称</h4>
                                <p class="hidden-xs hidden-sm text-height">中国大学共有12个学科，61个大学专业类，506个大学专业。</p>	
                                <a href="front/img/gallery/7.jpg" class="btn btn-sm btn-warning colorbox-button">了解更多</a>
                            </div>
                        </div>
                    </div>
                    <div class="col xs-12 col-sm-4 videos item">
                        <div class="filter-content">
                            <img src="front/img/gallery/8.jpg" alt="" class="img-responsive" />
                            <div class="image-content">
                                <h4>专业名称</h4>
                                <p class="hidden-xs hidden-sm text-height">中国大学共有12个学科，61个大学专业类，506个大学专业。</p>	
                                <a href="front/img/gallery/8.jpg" class="btn btn-sm btn-warning colorbox-button">了解更多</a>
                            </div>
                        </div>
                    </div>
                </div>
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
                <div class="row">
                    <div class="col-md-3 col-sm-6">
                        <div class="feature">	<i class="extralarge fa fa-bar-chart-o"></i>
                            <br/>
                            <br/>
                            <h3>新生须知</h3>
                            <br/>
                            <p> 经省教育厅招生考试院批准，你被录取为我院2017级函授、业余学员，向你表示祝贺！现将新生报到事项告知如下，请你按规定时间办理报到手续，逾期一周无故不报到者，视为放弃入学资格。
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="feature">	<i class="extralarge fa fa-video-camera"></i>
                            <br/>
                            <br/>
                            <h3>申报通知</h3>
                            <br/>
                            <p> 根据《蚌埠学院成人高等教育本科毕业生学士学位授予细则》，成绩合格且符合相关条件的成人高等教育本科毕业生可向学校提出学士学位授予申请。  请各相关负责人认真对待，届时请督促学员材料按时送达，配合完成此项工作。
                          </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="feature">	<i class="extralarge fa fa-bullhorn"></i>
                            <br/>
                            <br/>
                            <h3>管理制度</h3>
                            <br/>
                            <p>对于在整个学习过程中出勤率高、成绩达到优秀、关心集体、对班级做出贡献者，毕业时按学生人数的10%比例评选优秀毕业生，颁发证书。 学生在籍期间，不遵守纪律，违反规章制度，扰乱社会治安或触犯国家法律者，视情节轻重，分别给予警告、严重警告、记过、留校察看、开除学籍处分。开除学籍须经学院院长办公会研究决定并报安徽省教育厅备案。
						</div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="feature">	<i class="extralarge fa fa-picture-o"></i>
                            <br/>
                            <br/>
                            <h3>执行办法</h3>
                            <br/>
                            <p>为了加强成人高等教育工作的管理，促使学院成人高等教育工作规范化、制度化，根据《安徽省普通高等学校成人高等教育工作规定》（教高〔2009〕4号）、《关于加强高校举办非学历教育管理的通知》（教高〔2009〕10号）文件精神，结合学院实际，制定本办法。本办法所称成人高等教育系指成人高等学历教育和继续教育、各类培训、进修和自考助学辅导等形式的成人非学历教育。
						</div>
                    </div>
                </div>
                <div class="divide60"></div>
            </div>
        </section>
        <!-- 成绩查询-->
       	<section id="result-view" data-type="background" data-speed="10" class="pages text-center" style="height: 100px!important;">
            <!-- <div class="parallax-overlay text-center">
                <h2 class="text-center">
					<span class="bigintro-light">部分案例</span>
				</h2>
            </div> -->
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
									<ul class="dropdown-menu pull-left" id="majorQueryList">
										<li><a href="javascript:;">电子信息科学</a></li>
										<li><a href="javascript:;">会计</a></li>
										<li><a href="javascript:;">市场营销</a></li>
										<li><a href="javascript:;">工商管理</a></li>
									</ul>
								</div>
								<input type="text" class="form-control" id="major">
							</div><br />
							<button type="button" class="btn btn-warning pull-right">查询</button>
					</div>
					
					<div class="col-md-6 col-md-push-1">
						<div class="panel panel-default">
							<div class="panel-heading"><b>查询结果</b></div>
							<div class="panel-body text-danger" id="noResults"><p>没有查到任何数据……</p></div>
							<table class="table table-striped text-primary text-left" id="results">
							  <!-- <tr class="text-center"><th>课&emsp;&emsp;程</th><th>成&emsp;&emsp;绩</th></tr>
							  <tr class="info"><td>理论知ytery识</td><td>100</td></tr>
							  <tr class="info"><td>理论</td><td>100</td></tr>
							  <tr class="info"><td>理论知识</td><td>100</td></tr> -->
							</table>
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
							  <ul class="dropdown-menu exam-width" id="majorRegList">
							    <li><a href="javascript:;">计算机科学与技术 </a></li>
							    <li><a href="javascript:;">网络工程</a></li>
							    <li><a href="javascript:;">文学艺术鉴赏</a></li>
							    <li><a href="javascript:;">会计</a></li>
							  </ul>
							</div>
							<div class="divide20"></div>
							<div class="list-group exam-info">
						      <a href="javascript:;" class="list-group-item">
						        <h4 class="list-group-item-heading">考试课程</h4>
						        <p class="list-group-item-text">考场：xxxxxxx</p>
						        <p class="list-group-item-text">时间：xxxxxxx</p>
						        <p class="list-group-item-text">注意事项：xxxxxxx</p>
						      </a>
						      <a href="javascript:;" class="list-group-item">
						        <h4 class="list-group-item-heading">考试课程</h4>
						        <p class="list-group-item-text">考场：xxxxxxx</p>
						        <p class="list-group-item-text">时间：xxxxxxx</p>
						        <p class="list-group-item-text">注意事项：xxxxxxx</p>
						      </a>
						      <a href="javascript:;" class="list-group-item">
						        <h4 class="list-group-item-heading">考试课程</h4>
						        <p class="list-group-item-text">考场：xxxxxxx</p>
						        <p class="list-group-item-text">时间：xxxxxxx</p>
						        <p class="list-group-item-text">注意事项：xxxxxxx</p>
						      </a>
						      <a href="javascript:;" class="list-group-item">
						        <h4 class="list-group-item-heading">考试课程</h4>
						        <p class="list-group-item-text">考场：xxxxxxx</p>
						        <p class="list-group-item-text">时间：xxxxxxx</p>
						        <p class="list-group-item-text">注意事项：xxxxxxx</p>
						      </a>
						      <a href="javascript:;" class="list-group-item">
						        <h4 class="list-group-item-heading">考试课程</h4>
						        <p class="list-group-item-text">考场：xxxxxxx</p>
						        <p class="list-group-item-text">时间：xxxxxxx</p>
						        <p class="list-group-item-text">注意事项：xxxxxxx</p>
						      </a>
						    </div>
						    
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
    <!-- javascripts -->
    <!-- placed at the end of the document so the pages load faster -->
    <script src="front/js/jquery-1.9.1.min.js"></script>
    <script src="front/bootstrap-dist/js/bootstrap.min.js"></script>
    <script src="front/js/waypoint/waypoints.min.js"></script>
    <script src="front/js/navmaster/jquery.scrollto.js"></script>
    <script src="front/js/navmaster/jquery.nav.js"></script>
    <script src="front/js/isotope/jquery.isotope.min.js"></script>
    <script src="front/js/isotope/imagesloaded.pkgd.min.min.js"></script>
    <!-- colorbox -->
    <script src="front/js/colorbox/jquery.colorbox.min.js"></script>
    <script src="front/js/script.non-min.js"></script>
    <script src="js/layer/layer.js"></script>
    <script src="js/layer/laydate/laydate.js"></script>
    <script src="js/jquery.serializeJSON.js"></script>
    <script>
	    $('.list-group.exam-info a').click(function () {
	    	 $(this).attr("class","list-group-item active");
	         $(this).siblings().attr("class","list-group-item");
		});
	    
	    $("#majorQueryList").find("a").click(function() {
	    	$("#major").val($(this).text());
	    });
	    $("#majorRegList").find("a").click(function() {
	    	$("#regMajorName").text($(this).text());
	    });
	    
	    var logout = function() {
	    	$.ajax({url:"logout.do?type=0",async:false});
	    	location.href = "front_login.jsp";
	    };
	    
	    var operUser = function(elem) {
			if ($(elem).text() == "修改信息") {
				$(elem).text("保存");
				$("#userForm").find("fieldset").attr("disabled", false);
			} else {
				$(elem).attr("disabled", true);
				$.ajax({
					contentType : "application/json; charset=utf-8",
					type : "post",
					url : "front/updateUser.do",
					data : JSON.stringify($("#userForm").serializeJSON()),
					dataType : "json",
					success : function(result) {
						if (result.success) {
							layer.msg("修改成功",{icon:1});
							$(elem).attr("disabled", false);
							setTimeout(function() {location.reload();}, 800);
						} else {
							layer.msg("修改信息失败",{icon:2,time:1000});
							$(elem).attr("disabled", false);
						}
					},
					error : function(xhr) {
						if (xhr.responseText == "loseSession")
							layer.confirm("你还没有登录，请先登录", {icon : 2,title : "提示",closeBtn : 0,btn : [ '确定' ]}, function() {top.location.href = "front_login.jsp";});
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
				url : "front/updatePass.do",
				data : JSON.stringify($("#passForm").serializeJSON()),
				dataType : "json",
				success : function(result) {
					if (result.success)
						if(result.code == "0000") {
							$("#passModal").modal("hide");
							alert("密码修改成功，请重新登录");
							top.location.href = "front_login.jsp";
						} else if(result.code == "0004") showWarn(result.msg);
					else showWarn('密码修改失败！');
				},
				error : function(xhr) {
					if (xhr.responseText == "loseSession") {
						alert("请先登录");
						top.location.href = "front_login.jsp";
					}
				}
			});
		};
	    
    </script>
</body>

</html>