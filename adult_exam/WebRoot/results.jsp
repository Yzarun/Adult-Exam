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
	<script src="js/layer/layer.js"></script>
<div class="row">
    <div class="col-sm-12">
        <div class="page-header">
            <ul class="breadcrumb">
                <li><i class="fa fa-home"></i><a href="index.jsp"> 首页</a>
                </li>
                <li>成绩管理</li>
            </ul>
            <div class="clearfix">
                <h3 class="content-title pull-left">成 绩 管 理</h3>
            </div>
            <div class="description">考生考试成绩录入、查看</div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
		<div class="row" style="margin-bottom: 10px;">
			<div class="col-md-3">
				<label for="studentName">考试姓名</label> 
				<input type="text" class="form-control" id="studentName" placeholder="名称模糊查询">
			</div>
			<div class="col-md-3">
				<label>录入状态</label> 
				<select class="form-control" id="status">
				  <option value="0">全部</option>
				  <option value="1">已录入</option>
				  <option value="2">未录入</option>
				</select>
			</div>
			<div class="col-md-3 col-md-offset-2" style="margin-top: 25px;">
				<button type="button" class="btn btn-info btn-sm" onclick="toPageData();">查&emsp;询</button>
			</div>
		</div>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>考号</th>
					<th>考生</th>
					<th>考试内容</th>
					<th>考试专业</th>
					<th>考试时间</th>
					<th>录入状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody id="_data"></tbody>
		</table>
                        总共<code id="total"></code>条记录，  当前显示第<code id="pageNum"></code>页
        <nav class="navbar-right">
			<ul class="pagination" id="pageInfo"> </ul>
		</nav>
    </div>
</div>
		
<script>
	var pageNum = 1;
	var deleteIds = "";
	var toEnter = function(id) {
		var html = "<div id='editRes'>";
		$.getJSON("getResultsByReg.do?regId="+id, function(data) {
			for(var i = 0, size = data.length; i < size; i++) {
			var cur = data[i];
			html += "<div class='row'><input type='hidden' name='id' value='"+cur.id+"'><div class='col-md-6' style='margin-right: -20px;'><label>课程</label>"+
				"<input type='text' class='form-control' value='"+cur.course+"' name='course'></div><div class='col-md-3'"+
				"style='margin-right: -20px;'><label>分数</label><input type='number' class='form-control' value='"+
				cur.score+"' name='score'></div><div class='col-md-2' style='margin-top: 30px;'><button type='button' class='btn btn-danger btn-xs'"+
				" onclick='deleteOne(this,"+cur.id+")'><span class='glyphicon glyphicon-trash'></span>&nbsp;删除"+
				"</button></div></div>";
			}
		html += "</div><br><button type='button' class='btn btn-primary btn-xs' onclick='toAdd()'><span class='glyphicon glyphicon-plus'></span>&nbsp;添加</button>";
		layer.open({
			type: 0,
	     	title: '考生成绩编辑',
	     	area: ['530px', '500px'],
	     	content: html,
			yes: function() {
				var editData = "";
				var flag = true;
				$("#editRes .row").each(function(e) {
					var idv = $(this).find("input[name='id']").val();
					var course = $(this).find("input[name='course']");
					var score = $(this).find("input[name='score']");
					if($(course).val().trim().length == 0) {
						layer.tips("请填写课程名称",course);
						editData = "";
						flag = false;
						return false;
					}
					if($(score).val().trim().length == 0) {
						layer.tips("请填写分数",score);
						editData = "";
						flag = false;
						return false;
					}
					var temp = idv + "," + $(course).val().trim() + "," + $(score).val().trim();
					editData += editData.length > 0 ? "-" + temp : temp;
				});
				if(flag) {
					$.ajax({
						url: "operaResults.do",
						type: "post",
						data : {deleteIds:deleteIds, editData: editData,registrationId:id},
						dataType: "json",
						success: function(res) {
							if(res.success) {
								deleteIds = "";
								layer.msg(res.msg,{icon:1});
								toPageData();
								setTimeout(function() {layer.closeAll();}, 800);
							} else {
								layer.msg(res.msg,{icon:2,time:1000});
							}
						}
					});
				}
			}
	    });
		});
		
	};

	var deleteOne = function(elem,id) {
		deleteIds += deleteIds.length > 0 ? "," + id : id;
		$(elem).parent().parent().remove();
	};
	
	var toAdd = function() {
		var html = "<div class='row'><input type='hidden' name='id' value='0'><div class='col-md-6' style='margin-right: -20px;'><label>学科</label>"+
			"<input type='text' class='form-control' name='course'></div><div class='col-md-3' style='margin-right: -20px;'>"+
			"<label>分数</label><input type='number' class='form-control' name='score'></div><div class='col-md-2' "+
			"style='margin-top: 30px;'><button type='button' class='btn btn-danger btn-xs' onclick='deleteOne(this,0)'>"+
		  	"<span class='glyphicon glyphicon-trash'></span>&nbsp;删除</button></div></div>";
		$('#editRes').append(html);
	};
	var showResults = function(id) {
		$.getJSON("getResultsByReg.do?regId="+id, function(data) {
			var html = "";
			if(data.length == 0) html += "<h4>暂无数据……</h4>"
				for(var i = 0, size = data.length; i < size; i++) {
					var cur = data[i];
					html += "<div class='row'><div class='col-md-6' style='margin-right: -20px;'><label>课程</label>"+
						"<input type='text' class='form-control' value='"+cur.course+"' disabled></div><div class='col-md-3'"+
						"style='margin-right: -20px;'><label>分数</label><input type='number' class='form-control' value='"+
						cur.score+"' disabled></div></div>";
				}
			layer.open({
				type: 0,
		     	title: '考生成绩查看',
		     	area: ['500px', '480px'],
		     	content: html
		    });
		});
	};
	
	var toPageData = function() {
		$.getJSON("getRegInfoPage.do", {pageNum:pageNum,studentName:$('#studentName').val(),status:$('#status').val()}, 
			function(data) {
				var params = data.params;
				var page = data.page;
				$('#studentName').val(params.studentName);
				$('#status').val(params.status);
				
				var list = page.list;
				var _dataHtml = "";
				for(var i = 0,size = list.length; i < size; i++) {
					var cur = list[i];
					_dataHtml += "<tr><th>"+cur.examNum+"</th><td>"+cur.studentName+"</td><td>"+cur.cont+"</td><td>"+cur.majorName+
							"</td><td>"+cur.examTime+"</td><td>"+cur.statusName+"</td><td><div class='btn-toolbar'><button type='button'"+
							" class='btn btn-success btn-xs' onclick='showResults("+cur.id+")'><span class='glyphicon glyphicon-file'>"+
							"</span>&nbsp;查看</button><button type='button' class='btn btn-primary btn-xs' onclick='toEnter("+cur.id+")'>"+
							"<span class='glyphicon glyphicon-edit'></span>&nbsp;录入</button></div></td></tr>";
					
				}
				$('#_data').empty();
				$('#_data').append(_dataHtml);
				
				var pageHtml = "<li class='"+(page.prePage==0?'disabled':'')+"'><a onclick='setPageNum("+page.prePage+")'><span>&laquo;</span></a></li>";
				for(var i = 0,size = page.navigatepageNums.length; i < size; i++) {
					var num = page.navigatepageNums[i];
					pageHtml += "<li class='"+(num==page.pageNum?'active':'')+"'><a onclick='setPageNum("+num+");'>"+num+"</a></li>";
				}
			    pageHtml += "<li class='"+(page.nextPage==0?'disabled':'')+"'><a onclick='setPageNum("+page.nextPage+")'><span>&raquo;</span></a></li>";
				$('#pageInfo').empty();
				$('#pageInfo').append(pageHtml);
				$('#total').text(page.total);
				$('#pageNum').text(page.pageNum);
				pageNum = page.pageNum;
		});
	};
	
	var setPageNum = function(num) {
		if(num > 0 && num != pageNum) {
			pageNum = num;
			toPageData();
		}
	};
	toPageData();
	
</script>
