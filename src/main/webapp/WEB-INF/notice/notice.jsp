<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>通知公告</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
	<script type="application/javascript" src="${pageContext.request.contextPath}/skin/js/jquery-3.4.1.js"></script>
<script type="application/javascript">
	$(function(){
		//当加载完页面，获取默认的第一页数据
		getData(1);
	})

	function getData(currentPage){
		$.ajax({
			url:"${pageContext.request.contextPath}/office/notice/list",
			method:"post",
			data:{"currentPage":currentPage,"pageSize":5},
			dataType:"json",
			success:function(data){//pageInfo
				$("#notice tr:gt(1):not([id=operate])").remove();
				$.each(data.list,function (index,element) {
					var tr="<tr align='center' bgcolor=\"#FFFFFF\" onMouseMove=\"javascript:this.bgColor='#FCFDEE';\" onMouseOut=\"javascript:this.bgColor='#FFFFFF';\" height=\"22\" >\n" +
							"\t\t<td><input name=\"id\" type=\"checkbox\" id=\"id\" value=\"101\" class=\"np\"></td>\n" +
							s"\t\t<td>"+element.nid+"</td>\n" +
							"\t\t<td>"+element.ntitle+"</td>\n" +
							"\t\t<td align=\"center\"><span >"+element.remark+"</span></td>\n" +
							"\t\t<td>"+getDate(element.ndate)+"</td>\n" +
							"\t\t<td><a >删除</a></td>\n" +
							"\t</tr>";
					$("#operate").before(tr);
				})

				var page="<tr align=\"right\" bgcolor=\"#EEF4EA\">\n" +
						"\t<td height=\"36\" colspan=\"12\" align=\"center\">\n" +
						"        <a href=\"javascript:firstPage("+data.pageNum+");\">首页</a>&nbsp;&nbsp;&nbsp;&nbsp;\n" +
						"        <a href=\"javascript:previousPage("+data.pageNum+");\">上一页</a>&nbsp;&nbsp;&nbsp;&nbsp;\n" +
						"        <a href=\"javascript:nextPage("+data.pageNum+","+data.pages+");\">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;\n" +
						"        <a href=\"javascript:tailPage("+data.pages+");\">尾页</a>&nbsp;&nbsp;&nbsp;&nbsp;\n" +
						"    </td>\n" +
						"</tr>"

				$("#operate").after(page);
			},
			cache:false
		})
	}

	//首页
	function firstPage(currentPage) {
		getData(1);
	}

	//上一页
	function previousPage(currentPage){
		if(currentPage>1){
			getData(currentPage-1);
		}else{
			getData(1);
		}
	}

	//下一页
	function nextPage(currentPage,totalPage) {
		if(currentPage<totalPage){
			getData(currentPage+1);
		}else{
			getData(totalPage);
		}
	}

	//尾页
	function tailPage(totalPage){
		getData(totalPage);
	}

	function getMonthOrDate(data) {
		if(data<10){
			return "0"+data;
		}else{
			return data;
		}
	}


	//处理json中的日期数据
	function getDate(data){
		var d=new Date(data);
		return d.getFullYear()+"-"+getMonthOrDate((d.getMonth()+1))+"-"+getMonthOrDate(d.getDate());
	}
</script>

</head>
<body leftmargin="8" topmargin="8" background='${pageContext.request.contextPath}/skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
<tr>
 <td height="26" background="${pageContext.request.contextPath}/skin/images/newlinebg3.gif">
  <table width="58%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td >
    当前位置:日常办公>>通知公告
 </td>
	  <td>
		  <input type='button' class="coolbg np" onClick="location='${pageContext.request.contextPath}/office/notice-send';" value='发布新通告' />
	  </td>
 </tr>
</table>
</td>
</tr>
</table>

<!--  搜索表单  -->

<!--  内容列表   -->
<form name="">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px" id="notice">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="12" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;发件箱&nbsp;</td>
</tr>
<tr align="center" bgcolor="#FAFAF1" height="22">
	<td width="4%">选择</td>
	<td width="6%">序号</td>
	<td width="10%">标题</td>
	<td width="10%">内容</td>
	<td width="8%">发送时间</td>
	<td width="8%">操作</td>
</tr>



<tr bgcolor="#FAFAF1" id="operate">
<td height="28" colspan="12">
	&nbsp;
	<a href="" class="coolbg">全选</a>
	<a href="" class="coolbg">反选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="" class="coolbg">&nbsp;删除&nbsp;</a>
	<a href="" class="coolbg">&nbsp;导出Excel&nbsp;</a>
</td>
</tr>

</table>

</form>
  

</body>
</html>