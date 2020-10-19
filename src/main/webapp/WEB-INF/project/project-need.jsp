<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>需求分析管理</title>
<link rel="stylesheet" type="text/css" href="../../skin/css/base.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/skin/jquery-3.4.1.js"></script>
 </head>
<body leftmargin="8" topmargin="8" background='skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
<tr>
 <td height="26" background="skin/images/newlinebg3.gif">
  <table width="58%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td >
    当前位置:项目管理>>需求分析管理
 </td>
  <td>
    <input type='button' class="coolbg np" onClick="location='${pageContext.request.contextPath}/analysis/add';" value='添加新项目需求' />
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
          <select name='cid' style='width:150' id="ctype">
          <option value='0'>选择类型...</option>
          	<option value='1'>项目名称</option>
          	<option value='1'>标题</option>
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
            <option value='pubdate'>添加时间</option>
            <option value='pubdate'>修改时间</option>
      	</select>
        </td>
        <td>
          &nbsp;&nbsp;&nbsp;<input name="imageField" type="image" src="../../skin/images/frame/search.gif" width="45" height="20" border="0" class="np" />
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
	<td height="24" colspan="12" background="skin/images/tbg.gif">&nbsp;需求列表&nbsp;</td>
</tr>
<tr align="center" bgcolor="#FAFAF1" height="22">
	<td width="4%">选择</td>
	<td width="6%">序号</td>
	<td width="10%">标题</td>
	<td width="10%">项目名称</td>
	<td width="8%">添加时间</td>
	<td width="8%">修改时间</td>
	<td width="10%">操作</td>
</tr>
    <tbody id="tbd"></tbody>




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

</form>
<script>
    function format(data){
        var date =new Date(data);
        return date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate();
    }



    function findByPage(pagenum){
        $.post("${pageContext.request.contextPath}/analysis/page",$("#form3").serialize()+"&pagenum="+pagenum,function (data) {
            var eles="";
            $.each(data.list,function (index,element) {
                ele="<tr align='center' bgcolor=\"#FFFFFF\" onMouseMove=\"javascript:this.bgColor='#FCFDEE';\" onMouseOut=\"javascript:this.bgColor='#FFFFFF';\" height=\"22\" >\n" +
                    "\t<td><input name=\"id\" type=\"checkbox\" id=\"id\" value=\"101\" class=\"np\"></td>\n" +
                    "\t<td>"+index+"</td>\n" +
                    "\t<td>"+element.title+"</td>\n" +
                    "\t<td align=\"center\"><a href=''><u>"+element.proname+"</u></a></td>\n" +
                    "\t<td>"+format(element.addtime)+"</td>\n" +
                    "\t<td>"+format(element.updatetime)+"</td>\n" +
                    "\t<td><a href=\"project-need-edit.jsp\">编辑</a> | <a href=\"project-need-look.jsp\">查看详情</a></td>\n" +
                    "</tr>"
                eles+=ele;
            });
            $("#tbd").html(eles);
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
</script>
  

</body>
</html>