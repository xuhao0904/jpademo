<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>发件箱</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
<script type="application/javascript" src="${pageContext.request.contextPath}/skin/js/jquery-3.4.1.js"></script>
	<script type="text/javascript">
		$(function(){
			$.getJSON("${pageContext.request.contextPath}/email/page",{"pagenum":1,"pagesize":6},function (data) {
				$.each(data.list, function (index, element) {
					var tr = "<tr align='center' bgcolor=\"#FFFFFF\" onMouseMove=\"javascript:this.bgColor='#FCFDEE';\" onMouseOut=\"javascript:this.bgColor='#FFFFFF';\" height=\"22\" >\n" +
							"\t<td><input name=\"id\" type=\"checkbox\" id=\"id\" value=\"101\" class=\"np\"></td>\n" +
							"\t<td>" + element.id + "</td>\n" +
							"\t<td>" + element.title + "</td>\n" +
							"\t<td align=\"center\"><span >" + element.emailcontent + "</span></td>\n" +
							"\t<td>" + element.employee.ename + "</td>\n" +
							"\t<td>" + getDate(element.sendtime) + "</td>\n" +
							"\t<td><a >删除</a></td>\n" +
							"</tr>";
					$("#operate").before(tr);
				})
			})
		})



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
    当前位置:信息箱>>发件箱
 </td>
 <td>
  <input type='button' class="coolbg np" onClick="location='${pageContext.request.contextPath}/message/email-send';" value='添加邮件' />
 </td>
 </tr>
</table>
</td>
</tr>
</table>


<!--  内容列表   -->
<form name="form2">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="12" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;发件箱&nbsp;</td>
</tr>
<tr align="center" bgcolor="#FAFAF1" height="22">
	<td width="4%">选择</td>
	<td width="6%">序号</td>
	<td width="10%">标题</td>
	<td width="10%">内容</td>
	<td width="10%">收件人</td>
	<td width="8%">发送时间</td>
	<td width="8%">操作</td>
</tr>




<tr bgcolor="#FAFAF1" id="operate">
<td height="28" colspan="12">
	&nbsp;
	<a href="" class="coolbg">全选</a>
	<a href="" class="coolbg">反选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="" class="coolbg">&nbsp;删除&nbsp;</a>
</td>
</tr>
<%--<tr align="right" bgcolor="#EEF4EA">
	<td height="36" colspan="12" align="center"><!--翻页代码 --></td>
</tr>--%>
</table>

</form>
  

</body>
</html>