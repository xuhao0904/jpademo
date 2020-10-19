<%@ page language="java"  pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>报销管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/skin/jquery-3.4.1.js"></script>
	<script type="text/javascript">

		var state;

		//格式化月与日
		function getFormatDate(data){
			if(data<10){
				return '0'+data;
			}else{
				return data;
			}
		}
		//处理日期格式的数据
		function getDate(data){
			var d=new Date(data);
			return d.getFullYear()+"/"+getFormatDate(d.getMonth())+"/"+getFormatDate(d.getDate());
		}

		//获取分页数据
		function getInfos(s,pagenum){
			var status="";
			$("#baoxiaoTable tr:gt(1):not(tr[id='operate'])").remove();
			$.get('${pageContext.request.contextPath}/baoxiao/page',{"pagenum":pagenum,"pagesize":5,"status":s},function(data){
				$.each(data.list,function (index,element) {
					if(element.bxstatus==0){
						status="\t\t\t\t\t\t<font color=\"blue\">未审批</font>\n";
					}else if(element.bxstatus==1){
						status="\t\t\t\t\t\t<font color=\"red\">被驳回</font>\n";
					}else if(element.bxstatus==2){
						status="\t\t\t\t\t\t<font color=\"green\">审批通过</font>\n";
					}
					var tr="<tr align='center' bgcolor=\"#FFFFFF\" onMouseMove=\"javascript:this.bgColor='#FCFDEE';\" onMouseOut=\"javascript:this.bgColor='#FFFFFF';\" height=\"22\" >\n" +
							"\t\t<td><input name=\"id\" type=\"checkbox\" id=\"id\" value=\"101\" class=\"np\"></td>\n" +
							"\t\t<td>"+element.bxid+"</td>\n" +
							"\t\t<td>"+element.paymode+"</td>\n" +
							"\t\t<td>"+element.employee.ename+"</td>\n" +
							"\t\t<td>"+element.totalmoney+"</td>\n" +
							"\t\t<td align=\"center\"><u>"+getDate(element.bxtime)+"</u></td>\n" +
							"\t\t<td>"+element.bxremark+"</td>\n" +
							"\t\t<td>"+status+"</td>\n" +
							"\t\t<td><a href=\"javascript:shenpi('"+element.bxid+"',"+state+")\">审批</a> </td>\n" +
							"\t</tr>"
					$("#operate").before(tr);
				})
				var page="<tr align=\"right\" bgcolor=\"#EEF4EA\">\n" +
						"\t<td height=\"36\" colspan=\"12\" align=\"center\">\n" +
						"\n" +
						"        <a href=\"javascript:firstpage();\">首页</a>&nbsp;&nbsp;&nbsp;&nbsp;\n" +
						"        <a href=\"javascript:prepage("+data.prePage+");\">上一页</a>&nbsp;&nbsp;&nbsp;&nbsp;\n" +
						"        <a href=\"javascript:nextpage("+data.pageNum+","+data.pages+");\">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;\n" +
						"        <a href=\"javascript:endpage("+data.pages+");\">尾页</a>\n" +
						"\n" +
						"    </td>\n" +
						"</tr>";
				$("#operate").after(page);
			},"json");
		}

		//初始化页面
		$(function(){
			getInfos(0,1);
			state=0;
		})

		//点击首页
		function firstpage() {
			getInfos(state,1);
		}

		//点击尾页
		function endpage(pagenum){
			getInfos(state,pagenum);
		}

		//上一页
		function prepage(pagenum) {
			if(pagenum==0){
				getInfos(state,1);
			}else{
				getInfos(state,pagenum);
			}

		}


		//下一页
		function nextpage(pagenum,pages) {
			if((pagenum+1)<pages){
				getInfos(state,pagenum+1);
			}else{
				getInfos(state,pages);
			}
		}

		//全选
		function chooseAll() {
			//获取所有的复选框
			var inputs=$("input[name='id']");
			$.each(inputs,function(index,element){
				element.checked=true;
			})
		}
		//反选
		function reverse() {
			//获取所有的复选框
			var inputs=$("input[name='id']");
			$.each(inputs,function(index,element){
				if(element.checked){
					element.checked=false;
				}else{
					element.checked=true;
				}
			})
		}
		//删除
		function del(){
			var ids="";
			var inputs=$("input[name='id']");
			$.each(inputs,function(index,element){
				if(element.checked){
					ids+=element.id+",";
				}
			})
			if(ids!=""){
				ids=ids.substring(0,ids.length-1);
				console.log(ids);
				//ids:选中的id值
				$.get("${pageContext.request.contextPath}/customer/delete",{"ids":ids},function (data) {
					if(data.state==200){
						alert('操作成功');
						window.location.href="${pageContext.request.contextPath}/customer/customer-list";
					}else{
						alert('失败');
					}
				},"json");
			}
		}

		function shenpi(bxid,state) {
			if(state==0){
				window.location.href="${pageContext.request.contextPath}/baoxiao/update?bxid="+bxid;
			}else{
				alert('已审批过了');
			}
		}

		function bohui(){
			getInfos(1,1);
			state=1;
		}

		function weishenpi(){
			getInfos(0,1);
			state=0;
		}

		function yishenpi(){
			getInfos(2,1);
			state=2;
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
    当前位置:报销管理>>报销列表
 </td>

 </tr>
</table>
</td>
</tr>
</table>


<!--  内容列表   -->
<form name="form2">

<table width="98%"  cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px" id="baoxiaoTable">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="12" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;报销单列表&nbsp;</td>
</tr>

<tr align="center" bgcolor="#FAFAF1" height="22">
	<td width="4%">选择</td>
	<td width="22%">编号</td>
	<td width="8%">类型</td>
	<td width="8%">报销人</td>
	<td width="6%">总金额</td>
	<td width="10%">使用时间</td>
	<td width="20%">备注信息</td>
	<td width="7%">审批状态</td>
	<td width="5%">操作</td>
</tr>


	<%--<tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22" >
		<td><input name="id" type="checkbox" id="id" value="101" class="np"></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td align="center"><u></u></td>
		<td></td>
		<td>/td>
		<td><a href="#">审批</a> </td>
	</tr>--%>
    <tr bgcolor="#FAFAF1" id="operate">
		<td height="28" colspan="12">
			<a href="javascript:weishenpi();" class="coolbg">&nbsp;未审批的报销&nbsp;</a>
			<a href="javascript:yishenpi();" class="coolbg">&nbsp;已审批的报销&nbsp;</a>
			<a href="javascript:bohui();" class="coolbg">&nbsp;已驳回&nbsp;</a>
		</td>
	</tr>

<%--<tr align="right" bgcolor="#EEF4EA">
	<td height="36" colspan="12" align="center"><!--翻页代码 --></td>
</tr>--%>
</table>

</form>
  

</body>
</html>