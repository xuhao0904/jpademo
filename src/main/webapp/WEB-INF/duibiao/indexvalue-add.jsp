<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加对标信息</title>
<LINK href="${pageContext.request.contextPath}/skin/css/theAlert.css" type=text/css rel=stylesheet>

<script type="text/javascript" src="${pageContext.request.contextPath}/skin/js/theAlert.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
<script type="application/javascript" src="${pageContext.request.contextPath}/skin/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/skin/js/jquery.form.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">

	var dataList;

	function getYear(data){
		var d=new Date(data);
		return d.getFullYear();
	}


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



	//显示对标公司的名称
	$(function(){
		$.getJSON("${pageContext.request.contextPath}/duibiao/showname",function (data) {
			var com=$("#com");
			$.each(data,function(index,element){
				var option="<option value='"+element.dacname+"'>"+element.dacname+"</option>";
				com.append(option);
			})
		});
	})


	//选择对标公司
	function showInfo(){
		var name=$("#com option:selected").val();
		$("#ymd").empty();
		$.ajax({
			method:'get',
			url:'${pageContext.request.contextPath}/duibiao/showinfo',
			data:{"name":name},
			dataType:'json',
			success:function(result){
				dataList=result.many;
				$.each(result.many,function(index,element){
					var option="<option value='"+element.daid+"'>"+getYear(element.datime)+"</option>";
					$("#ymd").append(option);
				})
				setDuibiaoForm(result.one);
			}
		})
	}

	//选择年份
	function showInfoBydaid(){
		//获取到所选择的年份所对应的对标信息的id
		var id=$("#ymd option:selected").val();
		$.each(dataList,function (index,element) {
			if(element.daid==id){
				setDuibiaoForm(element);
			}
		})

	}

	//设置对标公司的表单信息
	function setDuibiaoForm(element){
		$("#cname1").val(element.dacname);
		$("#money1").val(element.daturnover);
		$("#maindo1").val(element.dabusiness);
		$("#good1").val(element.dasuperiority);
		$("#nogood1").val(element.dainforiority);
		$("#po1").val(element.dasort);
		$("#count1").val(element.empcount);
		$("#build1").val(getDate(element.buildtime));
		$("#remark1").val(element.remark);
	}


	//点击保存
	function commit(){
		//获取所参考的公司的id
		var id=$("#ymd option:selected").val();
		//设置目标公司中所参考公司的id
		$("#comnameFk").val(id);
		$("#indexvalueForm").ajaxForm();
		$("#indexvalueForm").ajaxSubmit(function(result){
			if(result.state==200){
				alert('添加成功');
			}else{
				alert('添加失败');
			}
		});
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
    当前位置:对标管理>>添加对标基本信息
 </td>
 </tr>
</table>
</td>
</tr>
</table>

<div>

	<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
		<tr bgcolor="#E7E7E7">
			<td height="40" colspan="12" background="${pageContext.request.contextPath}/skin/images/tbg.gif">
				<h1>选择对标企业：</h1>
				<select id="com"  onchange="showInfo()">
					<option>选择对标企业</option>
				</select>

			</td>
		</tr>
	</table>


	<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
		<tr bgcolor="#E7E7E7">
			<td height="24" colspan="12" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;<font color="red">对标企业信息如下</font>&nbsp;</td>
		</tr>
		<tr >

			<td align="right" bgcolor="#FAFAF1" height="22">公司名称：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<input type="text" name="pname" id="cname1"/>
			</td>

			<td align="right" bgcolor="#FAFAF1" height="22" >营业额：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<input type="text" id="money1"/>
			</td>
		</tr>
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22">年份：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">

				<h1>选择对标年份：</h1>
				<select id="ymd" onchange="showInfoBydaid()">
					<option>选择对标年份</option>
				</select>
			</td>

			<td align="right" bgcolor="#FAFAF1" height="22">主要业务：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				  <textarea rows="3" cols="18" id="maindo1"></textarea>
			</td>
		</tr>


		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22" >优势：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<textarea rows="3" cols="18" id="good1"></textarea>
			</td>
			<td align="right" bgcolor="#FAFAF1" height="22">劣势：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<textarea rows="3" cols="18" id="nogood1"></textarea>
			</td>
		</tr>
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22">行业地位：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<input type="text" name="buildtime" id="po1"/>
			</td>
			<td align="right" bgcolor="#FAFAF1" height="22">员工数量：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<input type="text" name="cost" id="count1"/>
			</td>
		</tr>
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22">创建时间：</td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<input type="text" name="cost" id="build1" />
			</td>
			<td align="right" bgcolor="#FAFAF1" height="22"></td>
			<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">

			</td>
		</tr>

		<tr >
			<td align="right" bgcolor="#FAFAF1" >简单描述：</td>
			<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
				<textarea type="text" rows=15 cols=130 id="remark1"></textarea>
			</td>
		</tr>

		<tr >
			<td align="right" bgcolor="#FAFAF1" >附件下载：</td>
			<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
				  <a href="#" id="attachment"></a>
			</td>
		</tr>
	</table>
</div>




<!-- 添加指标 -->

<form name="form17" id="indexvalueForm" action="${pageContext.request.contextPath}/indexvalue/add" method="POST" enctype="multipart/form-data">
	    <!-- 向后台传递的关联外键 -->
        <input type="hidden" id="comnameFk"  name="comnameFk">
<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="12" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;<font color="red">添加对标信息</font>&nbsp;</td>
</tr>
  <tr >
	<td align="right" bgcolor="#FAFAF1" height="22">目标公司：</td>
	  <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		  <select id="indexvalueCom">

		  </select>
	  </td>

	<td align="right" bgcolor="#FAFAF1" height="22" >目标营业额：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input type="text" name="inTurnover"/>
	</td>

</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">业务方向：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input type="text"  id="cp" name="inBusiness"/>
	</td>
	<td align="right" bgcolor="#FAFAF1" height="22">开始时间：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input type="datetime" class="time" name="inStarttime" onfocus="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm:ss',readOnly:true})"/>
	</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22" >截止时间：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input type="datetime" class="time" name="inEndtime" onfocus="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm:ss',readOnly:true})"/></td>
	<td align="right" bgcolor="#FAFAF1" height="22"></td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22"></td>
</tr>


<tr >
	<td align="right" bgcolor="#FAFAF1" >备注：</td>
	<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
		<textarea type="text" rows=15 cols=130 name="inRemark"></textarea><span id="number"></span>
	</td>
</tr>
	<tr >
		<td align="right" bgcolor="#FAFAF1" >上传详细计划书：</td>
		<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
			<input type="file" name="file" >
		</td>
	</tr>

<tr bgcolor="#FAFAF1">
<td height="28" colspan=4 align=center>
	&nbsp;
	<a class="coolbg" onclick="commit()" >保存</a>
	<a href="project-base.jsp" class="coolbg">返回</a>
</td>
</tr>
</table>

</form>
  

</body>
</html>