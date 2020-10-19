<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>增加资源</title>
<script src="${pageContext.request.contextPath}/skin/js/jquery-3.4.1.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
<LINK href="${pageContext.request.contextPath}/skin/js/theAlert.css" type=text/css rel=stylesheet>
<script type="text/javascript">

		$(function () {
	  var pid=location.search.substring(location.search.indexOf("=")+1);
	   $("#hidden").val(pid);
		});

	//点击保存
	function commit(){
		$.ajax({
			method:'post',
			url:'${pageContext.request.contextPath}/sources/add',
			data:$("#sourceForm").serialize(),
			dataType:'json',
			success:function(result){
				if(result.flag){
					window.location.href='${pageContext.request.contextPath}/system/resource';
				}else{
					alert('操作失败');
				}
			}
		})
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
    当前位置:权限管理>>添加菜单资源
 </td>
 <td>

 </td>
 </tr>
</table>
</td>
</tr>
</table>

<!--  内容列表   -->
<form name="form2" id="sourceForm">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<input type="hidden"  id="hidden" value="">
	<td height="24" colspan="12" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;添加资源&nbsp;</td>
</tr>
    <input type="hidden" id="pid" name="pid" >
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">菜单资源名称：</td>
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
	<input name="name" /></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">菜单资源路径：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
	<input name="url" /></td>
</tr>
<tr>
	<td align="right" bgcolor="#FAFAF1" >资源描述：</td>
	<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
		<textarea rows=10 cols=130 name="remark"></textarea>
	</td>
</tr>

<tr bgcolor="#FAFAF1">
<td height="28" colspan=4 align=center>
	&nbsp;
	<a href="javascript:commit()" class="coolbg">保存</a>
	<a href="resources.jsp" class="coolbg">返回</a>
</td>
</tr>
</table>

</form>
  

</body>
</html>