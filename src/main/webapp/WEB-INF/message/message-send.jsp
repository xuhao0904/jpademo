<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>发信息</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
	<link href="${pageContext.request.contextPath}/skin/js/theAlert.css" type=text/css rel=stylesheet>
	<script type="text/javascript" src="${pageContext.request.contextPath}/skin/js/theAlert.js"></script>
	<script type="application/javascript" src="${pageContext.request.contextPath}/skin/js/jquery-3.4.1.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/My97DatePicker/WdatePicker.js"></script>

	<script type="text/javascript">

		function commit(){
			$.ajax({
				url:"${pageContext.request.contextPath}/message/add",
				method:"post",
				data:$("#msgForm").serialize(),
				dataType:"json",
				success:function(data){
					if(data.state==200){
						alert(data.msg);
					}else{
						alert('操作失败');
					}
				},
			})
		}
	</script>

</head>
<body leftmargin="8" topmargin="8" background='{pageContext.request.contextPath}/skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
	<tr>
		<td height="26" background="{pageContext.request.contextPath}/skin/images/newlinebg3.gif">
			<table width="58%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td >
						当前位置:消息>>发送消息
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<form name="form2" id="msgForm">

	<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
		<tr bgcolor="#E7E7E7">
			<td height="24" colspan="2" background="{pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;发信息&nbsp;</td>
		</tr>
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22">收件人：</td>
			<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<select name="recvp" id="recvp">
					<option value="-1">选取收件人</option>
				</select>
			</td>
		</tr>
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22">定时发送时间：</td>
			<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<input name="msgtime" id="time" onfocus="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm:ss',readOnly:true})"></td>
		</tr>
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22">内容：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<textarea rows=15 cols=130 name="msgcontent"></textarea></td>
		</tr>



		<tr bgcolor="#FAFAF1">
			<td height="28" colspan=4 align=center>
				&nbsp;
				<a href="javascript:commit()" class="coolbg">发送定时消息</a>
			</td>
		</tr>
	</table>

</form>


</body>
</html>