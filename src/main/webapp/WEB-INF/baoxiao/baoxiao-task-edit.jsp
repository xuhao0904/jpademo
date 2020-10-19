<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>编辑附件</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
<LINK href="${pageContext.request.contextPath}/skin/css/theAlert.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="${pageContext.request.contextPath}/skin/js/theAlert.js"></script>
<script type="application/javascript" src="${pageContext.request.contextPath}/skin/jquery-3.4.1.js"></script>

	<script type="text/javascript">
		function agree() {
			$("#bxstatus").val(2);
			$.post("${pageContext.request.contextPath}/baoxiao/update",$("#baoxiaoForm").serialize(),function (data) {
				if(data.flag){
					alert(data.messages);
					window.location.href="${pageContext.request.contextPath}/baoxiao/baoxiao-task";
				}else{
					alert('失败');
				}
			},"json");
		}

		function refuse() {
			$("#bxstatus").val(1);
			$.post("${pageContext.request.contextPath}/baoxiao/update",$("#baoxiaoForm").serialize(),function (data) {
				if(data.state==200){
					alert('操作成功');
					window.location.href="${pageContext.request.contextPath}/baoxiao/baoxiao-task";
				}else{
					alert('失败');
				}
			},"json");
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
    当前位置:项目管理>>报销审批
 </td>
 </tr>
</table>
</td>
</tr>
</table>

<form id="baoxiaoForm">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr >
	<td colspan="2"  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input  type="hidden" name="bxid" id="bxid" value="${baoxiao.bxid}"/>
		<input  type="hidden" name="bxstatus" id="bxstatus" value=""/>
	</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">金额：</td>
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input readonly="true" name="totalmoney" value="${baoxiao.totalmoney}"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">使用时间</td>
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">

		<input  readonly="true" value="<fmt:formatDate value="${baoxiao.bxtime}" pattern="yyyy/MM/dd"/>" name="bxtime"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" >备注：</td>
	<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
		<textarea rows=10 cols=130 readonly="true" name="bxremark">
			${baoxiao.bxremark}
		</textarea>
	</td>
</tr>
	<tr >
	<td align="right" bgcolor="#FAFAF1" >批准信息：</td>
	<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
		<!-- 批注信息 -->
		<textarea rows=10 id="pizhu" cols=130 name="result" placeholder=""></textarea>
	</td>
</tr >

<tr bgcolor="#FAFAF1">
<td height="28" colspan=4 align=center>
	&nbsp;
	<a href="javascript:agree();" class="coolbg">同意</a>
	<a href="javascript:refuse();" class="coolbg">驳回</a>
</td>
</tr>
</table>

</form>
  

</body>
</html>