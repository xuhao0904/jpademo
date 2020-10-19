<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>客户信息管理5555</title>
    <style type="text/css">
        #ul li {
            float: left;
            margin-left: 2vw;
            cursor: pointer;
        }
    </style>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/skin/jquery-3.4.1.js"></script>
    <script type="text/javascript">

        function format(da) {
            var date =new Date(da);
            return  date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate();

        }


        function findByPage(pagenum) {
            $.get("${pageContext.request.contextPath}/cust/page",$("#form3").serialize()+"&pagenum="+pagenum,function (data) {
                var lis="<li onclick='javascript:findByPage(1)'>首页</li>";
                if(pagenum==1){
                    lis+="<li onclick='javascript:findByPage(1)'>上一页</li>";
                }else{
                    lis+="<li onclick='javascript:findByPage("+(pagenum-1)+")'>上一页</li>";
                }
                var pages="";
                $.each(data.list,function (index,element) {
                         var li="<tr align=\"center\" bgcolor=\"#FAFAF1\" height=\"22\">\n" +
                             "\t<td width=\"4%\"><input type=\"checkbox\" name=\"cid\" class='cid' value="+element.id+"></td>\n" +
                             "\t<td width=\"6%\">"+(index+1)+"</td>\n" +
                             "\t<td width=\"10%\">"+element.companyperson+"</td>\n" +
                             "\t<td width=\"10%\">"+element.comname+"</td>\n" +
                             "\t<td width=\"8%\">"+format(element.addtime)+"</td>\n" +
                             "\t<td width=\"8%\">"+element.comphone+"</td>\n" +
                             "\t<td width=\"10%\"><a href=${pageContext.request.contextPath}/cust/edit?id="+element.id+">编辑</a>" +
                             "<a href=${pageContext.request.contextPath}/cust/look?id="+element.id+">/查看详情</a></td>\n" +
                             "</tr>";
                   pages= pages+li;
                })
                $("#tbody").html(pages);
                for(var i=1;i<=data.pages;i++){
                    if(i==pagenum){
                        lis+=  "<li  style='color:slateblue' onclick='javascript:findByPage("+i+")'>"+i+"</li>";
                    }else{
                    lis+=  "<li  onclick='javascript:findByPage("+i+")'>"+i+"</li>";
                }
                }
                if(data.pages==pagenum){
                    lis+="<li onclick='javascript:findByPage("+pagenum+")'>下一页</li>"
                }else{
                    lis+="<li onclick='javascript:findByPage("+(pagenum+1)+")'>下一页</li>"
                }
                lis+="<li onclick='javascript:findByPage("+data.pages+")'>尾页</li>"
                $("#ul").html(lis);



            },"json")

        }

       $(function () {
           findByPage(1)
       });
        function search(){
            findByPage(1)
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
    当前位置:客户信息管理>>客户信息
 </td>
  <td>
    <input type='button' class="coolbg np" onClick="location='${pageContext.request.contextPath}/cust/add';" value='添加客户信息' />
 </td>
 </tr>
</table>
</td>
</tr>
</table>

<!--  搜索表单  -->
<form name='form3'  method='get' id="form3">
<input type='hidden' name='dopost' value='' />
<table width='98%'  border='0' cellpadding='1' cellspacing='1' bgcolor='#CBD8AC' align="center" style="margin-top:8px">
  <tr bgcolor='#EEF4EA'>
    <td background='${pageContext.request.contextPath}/skin/images/wbg.gif' align='center'>
      <table border='0' cellpadding='0' cellspacing='0'>
        <tr>
          <td width='90' align='center'>搜索条件：</td>
          <td width='160'>
          <select name='ctype' style='width:150'>
          <option value='0'>选择类型...</option>
          	<option value='comname'>客户所在公司名称</option>
          	<option value='companyperson'>联系人姓名</option>
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
            <option value='0'>排序...</option>
            <option value="addtime">添加时间</option>
      	    </select>
        </td>
        <td>
          &nbsp;&nbsp;&nbsp;<input  type="button" onclick="search()" value="搜索"/>
        </td>
       </tr>
      </table>
    </td>
  </tr>
</table>
</form>
<!--  内容列表   -->
<form name="form2" id="form2">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px" id="customerTable">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="12" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;需求列表&nbsp;</td>
</tr>
<tr align="center" bgcolor="#FAFAF1" height="22">
	<td width="4%">选择</td>
	<td width="6%">序号</td>
	<td width="10%">联系人</td>
	<td width="10%">公司名称</td>
	<td width="8%">添加时间</td>
	<td width="8%">联系电话</td>
	<td width="10%">操作</td>
</tr>
    <tbody id="tbody">


    </tbody>





<tr bgcolor="#FAFAF1" id="operate">
<td height="28" colspan="12">
	<a href="javascript:checkall()" class="coolbg">全选</a>
	<a href="javascript:reverse()" class="coolbg">反选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" value="删除" id="button" />
	<a href="" class="coolbg">&nbsp;导出Excel&nbsp;</a>
</td>



</tr>

</table>
    <ul id="ul" >

    </ul>
</form>
  <script>
      $("#button").click(function () {
          if(confirm("您确定要删除么？")){
              $.get("${pageContext.request.contextPath}/cust/delete",$("#form2").serialize(),function (data) {
                  findByPage(1)
              },"json")}else{
              $(".cid").prop("checked",false)
          }
      })

      function checkall() {
          $(".cid").prop("checked",true);

      }
      function  reverse() {

          $.each($(".cid"),function (index,element) {
              if(element.checked){
                  element.checked=false;
              }else{
                  element.checked=true;
              }

          })

      }


  </script>

</body>
</html>