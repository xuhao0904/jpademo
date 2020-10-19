<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>添加用户</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/skin/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(function(){
		//获取级别信息
		$.ajax({
			method:'get',
			url:'${pageContext.request.contextPath}/level/showAll',
			dataType:'json',
			success:function(result){
				$.each(result,function(index,element){
					var option="<option value='"+element.jid+"'>"+element.jname+"</option>";
					$("#level").append(option);
				})
			}
		})

		//获取职位信息
		$.ajax({
			method:'get',
			url:'${pageContext.request.contextPath}/position/showAll',
			dataType:'json',
			success:function(result){
				$.each(result,function(index,element){
					var option="<option value='"+element.id+"'>"+element.name+"</option>";
					$("#position").append(option);
				})
			}
		})

		//获取部门信息
		$.ajax({
			method:'get',
			url:'${pageContext.request.contextPath}/dept/showAll',
			dataType:'json',
			success:function(result){
				$.each(result,function(index,element){
					var option="<option value='"+element.deptno+"'>"+element.dname+"</option>";
					$("#dept").append(option);
				})
			}
		})

		//获取角色信息
		$.ajax({
			method:'get',
			url:'${pageContext.request.contextPath}/role/showAll',
			dataType:'json',
			success:function(result){
				var html="";
				$.each(result,function(index,element){
					html+="<input type='checkbox' name='roleId' value='"+element.roleid+"'/>"+element.rolename;
				})
				$("#roleTd").html(html);
			}
		})
	})

	//点击保存
	function save() {
		$.ajax({
			method:'post',
			url:'${pageContext.request.contextPath}/employee/add',
			data:$("#userForm").serialize(),
			dataType:'json',
			success:function(result){
				if(result.state==200){
					window.location.href='${pageContext.request.contextPath}/system/user';
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
    当前位置:权限管理>>添加用户信息
 </td>
 </tr>
</table>
</td>
</tr>
</table>

<form name="form2" id="userForm">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px" id="userTable">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="2" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;添加用户&nbsp;</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">级别：</td>
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<select id="level" name="lFk">
		</select>
	</td>
</tr>
	<tr >
		<td align="right" bgcolor="#FAFAF1" height="22">职位：</td>
		<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
			<select id="position" name="pFk">
			</select>
		</td>
	</tr>
	<tr >
		<td align="right" bgcolor="#FAFAF1" height="22">部门：</td>
		<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
			<select id="dept" name="dFk">
			</select>
		</td>
	</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">姓名：</td>
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="ename"/>
	</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">性别：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<select name="esex"><option value="男">男</option><option value="女">女</option></select></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">年龄：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="eage"/>
	</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">联系电话：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="telephone"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">入职时间：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="hiredate" onfocus="WdatePicker({dateFmt:'yyyy/MM/dd',readOnly:true})"/>
	</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">身份证号码：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="pnum"/>
	</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">用户名：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="username"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">密码：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="password"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">赋角色：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22" id="roleTd">

	</td>
</tr>

<tr >
	<td align="right" bgcolor="#FAFAF1" >备注：</td>
	<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
		<textarea rows=10 cols=130 name="remark"></textarea>
	</td>
</tr>


<tr bgcolor="#FAFAF1" id="operate">
<td height="28" colspan=4 align=center>
	&nbsp;
	<a href="javascript:save();" class="coolbg">保存</a>
	<a href="user.jsp" class="coolbg">返回</a>
</td>
</tr>
</table>

</form>
  

</body>
</html>