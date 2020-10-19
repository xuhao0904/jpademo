<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>项目信息管理</title>
<link rel="stylesheet" type="text/css" href="../../skin/css/base.css">
    <script src="${pageContext.request.contextPath}/skin/jquery-3.4.1.js"></script>
    <style>
        ul li{
            list-style: none;
            float: left;
            margin-left: 2vw;
            cursor: pointer;

        }
    </style>
</head>
<body leftmargin="8" topmargin="8" background='skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
<tr>
 <td height="26" background="skin/images/newlinebg3.gif">
  <table width="58%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td >
    当前位置:项目管理>>基本信息管理
 </td>
  <td>
    <input type='button' class="coolbg np" onClick="location='${pageContext.request.contextPath}/project/base-add';" value='添加新项目' />
 </td>
 </tr>
</table>
</td>
</tr>
</table>

<!--  搜索表单  -->
<form name='form3' action='' method='get' id="form3">
<input type='hidden' name='dopost' value='' />
<table width='98%'  border='0' cellpadding='1' cellspacing='1' bgcolor='#CBD8AC' align="center" style="margin-top:8px">
  <tr bgcolor='#EEF4EA'>
    <td background='skin/images/wbg.gif' align='center'>
      <table border='0' cellpadding='0' cellspacing='0'>
        <tr>
          <td width='90' align='center'>搜索条件：</td>
          <td width='160'>
          <select name='ctype' style='width:150'>
          <option value='0'>选择类型...</option>
          	<option value='pname'>项目名称</option>
          	<option value='empFk'>项目经理</option>
          </select>
        </td>
        <td width='70'>
          关键字：
        </td>
        <td width='160'>
          	<input type='text' name='keyword' value='' style='width:120px' />
        </td>
        <td width='110'>
    		<select name='orderby' style='width:120px'>
            <option value='id'>排序...</option>
            <option value='buildtime'>立项时间</option>
            <option value='endtime'>计划完成时间</option>
      	</select>
        </td>
        <td>
          &nbsp;&nbsp;&nbsp;<input type="button" value="提交" id="but"/>
        </td>
       </tr>
      </table>
    </td>
  </tr>
</table>
</form>
<!--  内容列表   -->
<form name="form2">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="12" background="skin/images/tbg.gif">&nbsp;项目信息列表&nbsp;</td>
</tr>
<tr align="center" bgcolor="#FAFAF1" height="22">
	<td width="4%">选择</td>
	<td width="6%">序号</td>
	<td width="10%">项目名称</td>
	<td width="10%">客户公司名称</td>
	<td width="10%">客户方负责人</td>
	<td width="5%">项目经理</td>
	<td width="8%">开发人员数</td>
	<td width="6%">立项时间</td>
	<td width="8%">最近更新时间</td>
	<td width="8%">计划完成时间</td>
	<td width="8%">状态</td>
	<td width="10%">操作</td>
</tr>
    <tbody id="tbody">

    </tbody>
<tr bgcolor="#FAFAF1">
<td height="28" colspan="12">
	&nbsp;
	<a href="" class="coolbg">全选</a>
	<a href="" class="coolbg">反选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="" class="coolbg">&nbsp;删除&nbsp;</a>
	<a href="" class="coolbg">&nbsp;导出Excel&nbsp;</a>
</td>
</tr>
<tr align="right" bgcolor="#EEF4EA">
	<td height="36" colspan="12" align="center"><!--翻页代码 --></td>
</tr>
</table>
    <ul id="ul">
    </ul>

</form>



<script>

    function format(data){
        var date =new Date(data)
        return date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate();
    }



    function findByPage(pagenum){
        $.post("${pageContext.request.contextPath}/project/page",$("#form3").serialize()+"&pagenum="+pagenum,function (data) {
            var eles="";
            $.each(data.list,function (index,element) {
                ele="<tr align='center' bgcolor=\"#FFFFFF\" onMouseMove=\"javascript:this.bgColor='#FCFDEE';\" onMouseOut=\"javascript:this.bgColor='#FFFFFF';\" height=\"22\" >\n" +
                    "\t<td><input name=\"pid\" type=\"checkbox\" id=\"pid\" value="+element.pid+ "class=\"np\"></td>\n" +
                    "\t<td>"+(index+1)+"</td>\n" +
                    "\t<td align=\"left\"><a href=''><u>"+element.pname+"</u></a></td>\n" +
                    "\t<td>"+element.customer.comname+"</td>\n" +
                    "\t<td>"+element.comper+"</td>\n" +
                    "\t<td>"+(element.employee.ename)+"</td>\n" +
                    "\t<td>"+element.empcount+"</td>\n" +
                    "\t<td>"+format(element.buildtime)+"</td>\n" +
                    "\t<td>"+format(element.starttime)+"</td>\n" +
                    "\t<td>"+format(element.endtime)+"</td>\n"+
                    "\t<td>"+element.level+"</td>\n" +
                    "\t<td><a href=${pageContext.request.contextPath}/project/edit?id="+element.pid+">编辑</a> | <a href=${pageContext.request.contextPath}/project/edit?id="+element.pid+">查看详情</a></td>\n" +
                    "</tr>";
                eles+=ele;
            });
            $("#tbody").html(eles);
            var lis="<li onclick=javascript:findByPage(1)>首页</li>"+"<li onclick=javascript:findByPage("+(pagenum-1)+")>上一页</li>";
            for(var i=1;i<=data.pages;i++){
                if(pagenum==i){lis+="<li style='color: blue' onclick=javascript:findByPage("+i+")>"+i+"</li>"}else{
                    lis+="<li onclick=javascript:findByPage("+i+")>"+i+"</li>"}
            }
            if(pagenum==data.pages){
                lis+="<li onclick=javascript:findByPage("+data.pages+")>下一页</li>"
            }else{
                lis+="<li onclick=javascript:findByPage("+(pagenum+1)+")>下一页</li>"
            }
            lis+="<li onclick=javascript:findByPage("+data.pages+")>尾页</li>";
            $("#ul").html(lis)
        },"json")
    }
    $(function () {
        findByPage(1);
    });
    $("#but").click(function(){
        findByPage(1);
    }
    )
</script>

</body>
</html>