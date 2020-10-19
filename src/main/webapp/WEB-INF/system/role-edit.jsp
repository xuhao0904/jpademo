<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>编辑角色信息</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/ztree/zTreeStyle.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/skin/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ztree/jquery.ztree.core.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ztree/jquery.ztree.excheck.js"></script>
	<script type="text/javascript">
		var zNodes=[];
		var setting = {
			check: {
				enable: true
			},
			data: {
				simpleData: {
					enable: true
				}
			}
		};
		 $(function () {
			var roleid= location.search.substring(location.search.indexOf("=")+1);
			 $("#rid").val(roleid);
			$.getJSON("${pageContext.request.contextPath}/role/findRoleById",{"roleid":roleid},function (data) {

				 var option="";
				  if(data.status==1){
				  	option+="<option  value='1' selected>启用</option>"+"<option value='0'>禁用</option>"
				  }
				$("#rname").val(data.rolename);
				$("#rstatus").html(option);
				$("#dis").text(data.roledis);
				zNodes=data.sources;
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			})

		 }
		);


		//点击保存
		function save(){
			var sourcesIds=[];
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
			//获取选中状态的节点对象
			var nodes = treeObj.getCheckedNodes(true);
			$.each(nodes,function(index,element){
				sourcesIds.push(element.id);
			});

			$.ajax({
				method:'post',
				url:'${pageContext.request.contextPath}/role/update/'+sourcesIds,
				data:$("#roleForm").serialize(),
				dataType:'json',
				success:function(result){
					if(result.state==200){
						window.location.href='${pageContext.request.contextPath}/system/role';
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
    当前位置:权限管理>>编辑角色
 </td>
 </tr>
</table>
</td>
</tr>
</table>

<form name="form2" id="roleForm">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="2" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;编辑角色&nbsp;</td>
</tr>
<tr >
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input type="hidden" name="roleid" id="rid">
	</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">角色名称：</td>
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input type="text" name="rolename"  id="rname"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">状态：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<select name="status" id="rstatus">
			<option value=1

			>启用</option>
			<option value=0
			<c:if test="${role.status==0}">
				selected
			</c:if>
			>禁用</option>
		</select>
	</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">赋菜单资源：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">

		<ul id="treeDemo" class="ztree"></ul>
	
	</td>
</tr>

<tr >
	<td align="right" bgcolor="#FAFAF1" >备注：</td>
	<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
		<textarea rows=10 cols=130 name="roledis" id="dis"></textarea>
	</td>
</tr>


<tr bgcolor="#FAFAF1">
<td height="28" colspan=4 align=center>
	&nbsp;
	<a href="javascript:save();" class="coolbg">保存</a>
	<a href="role.jsp" class="coolbg">返回</a>
</td>
</tr>
</table>

</form>
  

</body>
</html>