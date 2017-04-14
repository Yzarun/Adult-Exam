var allData = $.ajax({url:"getHomeData.do",async:false}).responseJSON;
    	
$("#aboutIntro").empty();
var aboutIntroHtml = allData.aboutIntro.replace(/[ ]/g,"&nbsp;").replace("\n","<p>");
$("#aboutIntro").append(aboutIntroHtml);

var aboutFeat = allData.aboutFeat;
var aboutIndiHtml = "";
for(var i = 0; i < aboutFeat.length/2; i++)
	aboutIndiHtml += "<li data-target='#mycarousel' data-slide-to='" + i + "' " + (i == 0 ? "class='active'" : "") + "></li>";
$("#aboutIndi").empty();
$("#aboutIndi").append(aboutIndiHtml);

var aboutFeatHtml = "";
for(var i = 0; i < aboutFeat.length; i++) {
  	var temp = "<div class='circular col-md-6'><img src='" + aboutFeat[i].image + "'/><h3>" + aboutFeat[i].title + "</h3><p style='text-align: left;text-indent: 2em;'>" + aboutFeat[i].cont + "</div>";
	if(i % 2 == 0) aboutFeatHtml += "<div class='item " + (i == 0 ? 'active' : '') + "'><div class='container'><div class='carousel-caption'><div class='row'>" + temp + (i == aboutFeat.length-1 ? "</div></div></div></div>" : "");
  	if(i % 2 != 0) aboutFeatHtml += temp + "</div></div></div></div>";
}
$("#aboutFeat").empty();
$("#aboutFeat").append(aboutFeatHtml);

var majors = allData.majors;
var majorsHtml = "";
for(var i = 0; i < majors.length; i++) {
	var type = majors[i].type;
	var temp = type==1 ? "design" : (type==2 ? "videos" : (type==3 ? "banners" : ""));
	majorsHtml += "<div class='col xs-12 col-sm-4 " + temp + " item'><div class='filter-content'><img src='" + majors[i].image + "' class='img-responsive'/>"
       	+ "<div class='image-content'><h4>" + majors[i].name + "</h4><p class='hidden-xs hidden-sm text-height'>" + majors[i].remark + "</p>"
       	+ "<a href='" + majors[i].image + "' class='btn btn-sm btn-warning colorbox-button'>了解更多</a></div></div></div>";
}
$("#filter-items").empty();
$("#filter-items").append(majorsHtml);


var notices = allData.notices;
var noticesHtml = "";
var icons = ['fa-picture-o','fa-bullhorn','fa-video-camera','fa-bar-chart-o','fa-video-camera'];
for(var i = 0; i < notices.length; i++) {
	noticesHtml += "<div class='col-md-3 col-sm-6'><div class='feature'><i class='extralarge fa " + icons[parseInt(5*Math.random())] 
		+ "'></i><br/><br/><h3>" + notices[i].title + "</h3><br/><p>" + notices[i].cont + "</div></div>";
}
$("#noticeCont").empty();
$("#noticeCont").append(noticesHtml);

var majorArr = allData.majorData;
var majorDataHtml = "";
for(var key in majorArr)
	majorDataHtml += "<li><a href='javascript:;'>" + majorArr[key] + "</a></li>";
$("#majorQueryList").empty();
$("#majorQueryList").append(majorDataHtml);
$("#majorRegList").empty();
$("#majorRegList").append(majorDataHtml);

$("#majorQueryList").find("a").click(function() {
	$("#major").val($(this).text());
});
$("#majorRegList").find("a").click(function() {
	var major = $(this).text();
	$("#regMajorName").text(major);
	$.ajax({
		contentType : "application/json; charset=utf-8",
		type : "post",
		async:false,
		url : "handler/getExams.do",
		data : JSON.stringify({major: major}),
		dataType : "json",
		success : function(result) {
			if (result.success) {
				var examArr = result.data;
				var examHtml = "";
				for(var i = 0; i < examArr.length; i++) {
					examHtml += "<a href='javascript:;' class='list-group-item'><input type='hidden' value='" + examArr[i]['id'] + "'>";
					examHtml += "<p class='list-group-item-text'>时间：" + examArr[i]['examTime'] + "</p>";
					examHtml += "<p class='list-group-item-text'>内容：" + examArr[i]['cont'] + "</p>";
					examHtml += "<p class='list-group-item-text'>地点：" + (examArr[i]['address'] == undefined ? '无': examArr[i]['address']) + "</p>";
					examHtml += "</a>";
				}
				if(examHtml.length == 0) examHtml += "<h4><b class='text-danger'>该专业暂无考试信息……</b></h4>";
				$('.list-group.exam-info').empty();
				$('.list-group.exam-info').append(examHtml);
				
				$('.list-group.exam-info a').click(function () {
			    	 $(this).attr("class","list-group-item active");
			         $(this).siblings().attr("class","list-group-item");
				});
			}
		}
	});
});

var queryResults = function() {
	var major = $('#major').val().trim();
	if(major.length == 0) {
		layer.msg("请先选择专业",{icon:0,time:800});
		return false;
	}
	layer.load(0, {content:"<div style='margin-left:60px;width:150px;font-size:15px;'>成绩查询中...</div>"});
	$.ajax({
		contentType : "application/json; charset=utf-8",
		type : "post",
		url : "front/getResults.do",
		data : JSON.stringify({userId: "${sessionScope.frontUser.id}", major: major}),
		dataType : "json",
		success : function(result) {
			if(result.success) {
				layer.closeAll();
				var res = result.data;
				if(res.length > 0) {
					$('#noResults').hide();
					var resultsHtml = "<tr class='text-center'><th>课&emsp;&emsp;程</th><th>成&emsp;&emsp;绩</th></tr>";
					for(var i = 0; i < res.length; i++)	
						resultsHtml += "<tr class='info'><td>" + res[i].course + "</td><td>" + res[i].score + "</td></tr>"
					$('#results').empty();
					$('#results').append(resultsHtml);
				} else $('#noResults').show();
			} else layer.msg(result.msg,{icon:2,time:1500});
		},
		error : function(xhr) {
			if (xhr.responseText == "loseSession")
				layer.confirm("你还没有登录，请先登录", {icon : 2,title : "提示",closeBtn : 0,btn : [ '确定' ]}, function() {top.location.href = "front_login.jsp";});
		}
	});
};

$("#submit").click(function() {
	var examId = $('.exam-info a.active').find('input').val();
	if(examId) {
		$.ajax({
			contentType : "application/json; charset=utf-8",
			type : "post",
			url : "front/regExam.do",
			data : JSON.stringify({"userId": "${sessionScope.frontUser.id}", "examId": examId}),
			dataType : "json",
			success : function(result) {
				if(result.success && result.code == "0000") layer.alert(result.msg,{icon:1});
				else layer.msg(result.msg,{icon:2,time:1500});
			},
			error : function(xhr) {
				if (xhr.responseText == "loseSession")
					layer.confirm("你还没有登录，请先登录", {icon : 2,title : "提示",closeBtn : 0,btn : [ '确定' ]}, function() {top.location.href = "front_login.jsp";});
			}
		});
		
		
	} else layer.alert("请先选择考试",{icon:0});
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
					layer.confirm("密码修改成功，请重新登录", {icon : 1,title : "提示",closeBtn : 0,btn : [ '确定' ]}, function() {top.location.href = "front_login.jsp";});
				} else if(result.code == "0004") showWarn(result.msg);
			else showWarn('密码修改失败！');
		},
		error : function(xhr) {
			if (xhr.responseText == "loseSession") {
				layer.confirm("你还没有登录，请先登录", {icon : 2,title : "提示",closeBtn : 0,btn : [ '确定' ]}, function() {top.location.href = "front_login.jsp";});
			}
		}
	});
};