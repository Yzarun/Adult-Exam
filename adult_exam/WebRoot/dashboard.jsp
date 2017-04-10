<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 	<!-- ANIMATE -->
    <link rel="stylesheet" href="css/animatecss/animate.min.css" />
    <!-- DATE RANGE PICKER -->
    <link rel="stylesheet" href="js/bootstrap-daterangepicker/daterangepicker-bs3.css" />
    <!-- TODO -->
    <link rel="stylesheet" href="js/jquery-todo/css/styles.css" />
    <!-- FULL CALENDAR -->
    <script src="js/bootstrap-daterangepicker/moment.min.js"></script>
    <script src="js/bootstrap-daterangepicker/daterangepicker.min.js"></script>
    <!-- SLIMSCROLL -->
    <script src="js/jQuery-slimScroll-1.3.0/jquery.slimscroll.min.js"></script>
    <!-- SLIMSCROLL -->
    <script src="js/jQuery-slimScroll-1.3.0/jquery.slimscroll.min.js"></script>
    <script src="js/jQuery-slimScroll-1.3.0/slimScrollHorizontal.min.js"></script>
    <!-- BLOCK UI -->
    <script src="js/jQuery-BlockUI/jquery.blockUI.min.js"></script>
    <!-- SPARKLINES -->
    <script src="js/sparklines/jquery.sparkline.min.js"></script>
    <!-- EASY PIE CHART -->
    <script src="js/jquery-easing/jquery.easing.min.js"></script>
    <script src="js/easypiechart/jquery.easypiechart.min.js"></script>
    <!-- FLOT CHARTS -->
    <script src="js/flot/jquery.flot.min.js"></script>
    <!-- TODO -->
    <script src="js/jquery-todo/js/paddystodolist.js"></script>
    <!-- TIMEAGO -->
    <script src="js/timeago/jquery.timeago.min.js"></script>
    
<div class="row">
    <div class="col-sm-12">
        <div class="page-header">
            <ul class="breadcrumb">
                <li> <i class="fa fa-home"></i>
                    <a href="index.jsp">首页</a>
                </li>
                <li>主控台</li>
            </ul>
            <!-- /BREADCRUMBS -->
            <div class="clearfix">
                <h3 class="content-title pull-left">主  控  台</h3>
            </div>
            <div class="description">概述、统计等等</div>
        </div>
    </div>
</div>
<div class="row">
    <!-- COLUMN 1 -->
    <div class="col-md-6">
        <div class="row">
            <div class="col-lg-4">
                <div class="dashbox panel panel-default">
                    <div class="panel-body">
                        <div class="panel-left red"> <i class="fa fa-users fa-2x"></i>
                        </div>
                        <div class="panel-right">
                            <div class="number">6718</div>
                            <div class="title">用户量</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="dashbox panel panel-default">
                    <div class="panel-body">
                        <div class="panel-left blue"> <i class="fa fa-book fa-2x"></i>
                        </div>
                        <div class="panel-right">
                            <div class="number">2724</div>
                            <div class="title">专业</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="dashbox panel panel-default">
                    <div class="panel-body">
                        <div class="panel-left blue"> <i class="fa fa-tasks fa-2x"></i>
                        </div>
                        <div class="panel-right">
                            <div class="number">2724</div>
                            <div class="title">考试</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="quick-pie panel panel-default">
                    <div class="panel-body">
                        <div class="col-md-4 text-center">
                            <div id="dash_pie_1" class="piechart" data-percent="59"> <span class="percent"></span>
                            </div> <a href="javascript:;" class="title">报名比例</a>
                        </div>
                        <div class="col-md-4 text-center">
                            <div id="dash_pie_2" class="piechart" data-percent="73"> <span class="percent"></span>
                            </div> <a href="javascript:;" class="title">考试专业</a>
                        </div>
                        <div class="col-md-4 text-center">
                            <div id="dash_pie_3" class="piechart" data-percent="90"> <span class="percent"></span>
                            </div> <a href="javascript:;" class="title">通过率</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /COLUMN 1 -->
    <!-- COLUMN 2 -->
    <div class="col-md-6">
        <div class="box solid grey">
            <div class="box-title">
                <h4><i class="fa fa-rocket"></i>注册量（人数  / 距离今天天数）</h4>
                <div class="tools">
                    <a href="javascript:;" class="collapse"> <i class="fa fa-chevron-up"></i>
                    </a>
                    <a href="javascript:;" class="remove"> <i class="fa fa-times"></i>
                    </a>
                </div>
            </div>
            <div class="box-body">
                <div id="chart-revenue" style="height:240px"></div>
            </div>
        </div>
    </div>
    <!-- /COLUMN 2 -->
</div>
<!-- /DASHBOARD CONTENT -->
<!-- HERO GRAPH -->
<div class="row">
    <div class="col-md-12">
        <!-- BOX -->
        <div class="box border green">
            <div class="box-title">
                <h4><i class="fa fa-bars"></i> <span class="hidden-inline-mobile">专业报考人数统计</span></h4>
            </div>
            <div class="box-body">
                <div class="tabbable header-tabs">
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="box_tab1">
                            <div id="chart-dash" class="chart" style="top: 26px;"></div>
                            <hr class="margin-bottom-0">
                        </div>
                        <div class="tab-pane fade" id="box_tab2">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="demo-container">
                                        <div id="placeholder" class="demo-placeholder"></div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="demo-container" style="height:100px;">
                                        <div id="overview" class="demo-placeholder"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /BOX -->
    </div>
</div>    
<script>
	

</script>
