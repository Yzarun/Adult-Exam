<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<!-- JQUERY UI-->
	<link rel="stylesheet" href="js/jquery-ui-1.10.3.custom/css/custom-theme/jquery-ui-1.10.3.custom.min.css" />
	<!-- DATE RANGE PICKER -->
	<link rel="stylesheet" href="js/bootstrap-daterangepicker/daterangepicker-bs3.css" />
	<!-- JQGRID -->
	<link rel="stylesheet" href="js/jqgrid/css/ui.jqgrid.min.css" />
	<!-- DATE RANGE PICKER -->
	<script src="js/bootstrap-daterangepicker/moment.min.js"></script>
	<script src="js/bootstrap-daterangepicker/daterangepicker.min.js"></script>
	<!-- SLIMSCROLL -->
	<script src="js/jQuery-slimScroll-1.3.0/jquery.slimscroll.min.js"></script>
	<script src="js/jQuery-slimScroll-1.3.0/slimScrollHorizontal.min.js"></script>
	<!-- BLOCK UI -->
	<script src="js/jQuery-BlockUI/jquery.blockUI.min.js"></script>
	<!-- JQGRID -->
	<script src="js/jqgrid/js/grid.locale-cn.js"></script>
	<script src="js/jqgrid/js/jquery.jqGrid.min.js"></script>
	<script src="js/jqgrid/ajaxfileupload.js"></script>
	<script src="js/layer/layer.js"></script>
<div class="row">
    <div class="col-sm-12">
        <div class="page-header">
            <ul class="breadcrumb">
                <li><i class="fa fa-home"></i><a href="index.jsp"> 首页</a>
                </li>
                <li><a href="javascript:;">通用管理</a></li>
                <li>学院介绍</li>
            </ul>
            <div class="clearfix">
                <h3 class="content-title pull-left">学 院 介 绍</h3>
            </div>
            <div class="description">学院介绍及特色展示等</div>
        </div>
    </div>
</div>
<div class="row">
	<div class="col-md-12">
		<div class="box border blue">
			<div class="box-title">
				<h4><i class="fa fa-bars"></i>学院介绍</h4>
				<div class="tools">
					<a href="javascript:;" class="collapse">
						<i class="fa fa-chevron-up"></i>
					</a>
				</div>
			</div>
			<div class="box-body">
				<form class="form-horizontal ">
					<div class="form-group">
						<div class="col-md-12">
							<textarea rows="6" cols="3" id="cont"
								class="autosize form-control"></textarea>
						</div>
					</div>
					<button type="button" class="btn btn-success" onclick="save();">确认</button>
					&emsp;&emsp; <span class="alert alert-warning"><strong>提示！</strong>&emsp;修改、编辑之后，记得确认！</span>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="box">
            <div class="box-body" >
                <table id="aboutTab"></table>
                <div id="aboutTabNav"></div>
            </div>
        </div>
    </div>
</div>
<script>

	$(function() {
		$.ajax({
			contentType : "application/json; charset=utf-8",
			type : "post",
			url : "back/getAboutCont.do",
			data : JSON.stringify({type:1}),
			dataType : "json",
			success : function(result) {
				if (result.success) $('#cont').val(result.data);
			}
		});
	});
	var save = function() {
		$.ajax({
			contentType : "application/json; charset=utf-8",
			type : "post",
			url : "back/saveAbout.do",
			data : JSON.stringify({cont: $('#cont').val(),type:1}),
			dataType : "json",
			success : function(result) {
				if (result.success)
					layer.msg('操作成功',{icon:1,time:1000});
				else layer.msg('操作失败',{icon:2,time:1000});
			}, error : function(xhr) {
				if (xhr.responseText == "loseSession") loginTips();
			}
		});
	};
</script>
