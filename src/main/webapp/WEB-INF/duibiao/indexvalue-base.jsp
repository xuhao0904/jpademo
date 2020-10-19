<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>对标管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
	<script type="application/javascript" src="${pageContext.request.contextPath}/skin/js/jquery-3.4.1.js"></script>
	<script type="text/javascript">
		//初始化页面之后显示的数据
		$(function(){
			getInfo(1);
		})

		//处理日期显示
		function formatData(data){
			if(data<10){
				return "0"+data;
			}else{
				return data;
			}
		}
		//获取日期
		function getDate(d){
			var date=new Date(d);
			return date.getFullYear()+"-"+formatData((date.getMonth()+1))+"-"+formatData(date.getDate());
		}

		//获取客户信息的分页信息
		function getInfo(pagenum){
			$.ajax({
				type: "get",
				url: "${pageContext.request.contextPath}/indexvalue/page",
				data:{"pagenum":pagenum},
				dataType:"json",
				success: function(result){
					//清除原有的表格中的数据
					$("#indexvalueTable tr:gt(1):not(tr[id=operate])").remove();
					$.each(result.list,function(index,element){
						var tr="<tr align='center' bgcolor=\"#FFFFFF\" onMouseMove=\"javascript:this.bgColor='#FCFDEE';\" onMouseOut=\"javascript:this.bgColor='#FFFFFF';\" height=\"22\" >\n" +
								"\t<td><input name=\"id\" type=\"checkbox\" id=\"id\" value=\"101\" class=\"np\"></td>\n" +
								"\t<td>"+element.inId+"</td>\n" +
								"\t<td><a href=''><u>"+element.datacollect.dacname+"</u></a></td>\n" +
								"\t<td>"+element.inTurnover+"亿</td>\n" +
								"\t<td>"+element.employee.ename+"</td>\n" +
								"\t<td>"+getDate(element.inStarttime)+"</td>\n" +
								"\t<td>"+getDate(element.inEndtime)+"</td>\n" +
								"\t<td><a href=\"${pageContext.request.contextPath}/indexvalue/download/"+element.inId+"\">附件下载</a> |<a href=\"project-base-edit.jsp\">编辑</a> | <a href=\"project-base-look.jsp\">查看详情</a></td>\n" +
								"</tr>";

						//在id:operate对应的行前面添加创建的行数据
						$("#operate").before(tr);
					})
					//分页的html
					var page="<tr align=\"right\" bgcolor=\"#EEF4EA\">\n" +
							"\t<td height=\"36\" colspan=\"12\" align=\"center\">\n" +
							"\n" +
							"        <a href=\"javascript:firstpage();\">首页</a>&nbsp;&nbsp;&nbsp;\n" +
							"        <a href=\"javascript:previouspage("+result.pageNum+");\">上一页</a>&nbsp;&nbsp;&nbsp;\n" +
							"        <a href=\"javascript:nextpage("+result.pageNum+","+result.pages+");\">下一页</a>&nbsp;&nbsp;&nbsp;\n" +
							"        <a href=\"javascript:tailpage("+result.pages+");\">尾页</a>\n" +
							"    </td>\n" +
							"</tr>";

					//在id:operate的元素后面追加分页
					$("#operate").after(page);

				}
			});
		}

		//首页
		function firstpage(){
			getInfo(1);
		}

		//上一页 pagenum:当前页数
		function previouspage(pagenum){
			//如果当前页大于1的话，才有上一页
			if(pagenum>1){
				getInfo(pagenum-1);
			}
		}

		//下一页 pagenum:当前页；pages:总页数
		function nextpage(pagenum,pages){
			if(pagenum<pages){
				getInfo(pagenum+1);
			}
		}

		//尾页
		function tailpage(pagenum){
			getInfo(pagenum);
		}

		//全选
		function chooseAll() {
			//获取到可以选择的单选框
			var elements=$("input[name=id]");
			$.each(elements,function(index,element){
				element.checked=true;
			})
		}

		//反选
		function reverseChoose(){
			//获取到可以选择的单选框
			var elements=$("input[name=id]");
			$.each(elements,function(index,element){
				if(element.checked){
					element.checked=false;
				}else{
					element.checked=true;
				}
			})
		}

		//删除
		function del() {
			var ids="";
			//获取到可以选择的单选框
			var elements=$("input[name=id]");
			$.each(elements,function(index,element){
				if(element.checked){
					ids+=element.id+",";
				}
			})
			//获取要删除的id
			ids=ids.substring(0,ids.length-1);
			$.ajax({
				type: "get",
				url: "${pageContext.request.contextPath}/customer/delete",
				data:{"ids":ids},
				dataType:"json",
				success: function(result){
					if(result.state==200){
						window.location.href="${pageContext.request.contextPath}/customer/list";
					}else{
						alert('删除失败');
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
    当前位置:对标管理>>添加指标信息
 </td>
  <td>
    <input type='button' class="coolbg np" onClick="location='${pageContext.request.contextPath}/duibiao/indexvalue-add';" value='添加指标信息' />
 </td>
 </tr>
</table>
</td>
</tr>
</table>


<!--  内容列表   -->
<form name="form2">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px" id="indexvalueTable">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="12" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;指标信息列表&nbsp;</td>
</tr>
<tr align="center" bgcolor="#FAFAF1" height="22" id="ttr">
	<td width="4%">选择</td>
	<td width="6%">序号</td>
	<td width="15%">目标公司</td>
	<td width="15%">目标营业额</td>
	<td width="15%">指标制定人</td>
	<td width="15%">指标开始时间</td>
	<td width="15%">指标截止时间</td>
	<td width="15%">操作</td>
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
<%--<tr align="right" bgcolor="#EEF4EA">
	<td height="36" colspan="12" align="center"><!--翻页代码 --></td>
</tr>--%>
</table>

</form>
  

</body>
</html>