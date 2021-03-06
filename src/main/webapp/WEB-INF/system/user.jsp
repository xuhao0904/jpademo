<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>用户管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/skin/js/jquery-3.4.1.js"></script>
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
                url: "${pageContext.request.contextPath}/employee/page",
                data:{"pagenum":pagenum},
                dataType:"json",
                success: function(result){
                    //清除原有的表格中的数据
                    $("#userTable tr:gt(1):not(tr[id=operate])").remove();
                    $.each(result.list,function(index,element){
                        var tr="<tr align='center' bgcolor=\"#FFFFFF\" onMouseMove=\"javascript:this.bgColor='#FCFDEE';\" onMouseOut=\"javascript:this.bgColor='#FFFFFF';\" height=\"22\" >\n" +
                            "\t<td><input name=\"id\" type=\"checkbox\" id=\"id\" value=\"101\" class=\"np\"></td>\n" +
                            "\t<td>"+element.eid+"</td>\n" +
                            "\t<td>"+element.ename+"</td>\n" +
                            "\t<td align=\"center\">"+element.position.name+"</td>\n" +
                            "\t<td>"+element.esex+"</td>\n" +
                            "\t<td>"+element.eage+"</td>\n" +
                            "\t<td>"+element.telephone+"</td>\n" +
                            "\t<td>"+getDate(element.hiredate)+"</td>\n" +
                            "\t<td><a href=\"javascript:del("+element.eid+")\">删除</a> | <a href=\"javascript:update("+element.eid+")\">编辑</a> | <a href=\"user-look.jsp\">查看详情</a></td>\n" +
                            "</tr>";

                        //在id:operate对应的行前面添加创建的行数据
                        $("#operate").before(tr);
                    })
                    //分页的html
                    var page="<tr align=\"right\" bgcolor=\"#EEF4EA\">\n" +
                        "\t<td height=\"36\" colspan=\"12\" align=\"center\">\n" +
                        "\n" +
                        "<a href=\"javascript:firstpage();\">首页</a>&nbsp;&nbsp;&nbsp;\n" +
                        "<a href=\"javascript:previouspage("+result.pageNum+");\">上一页</a>&nbsp;&nbsp;&nbsp;\n" +
                        "<a href=\"javascript:nextpage("+result.pageNum+","+result.pages+");\">下一页</a>&nbsp;&nbsp;&nbsp;\n" +
                        "<a href=\"javascript:tailpage("+result.pages+");\">尾页</a>\n" +
                        "</td>\n" +
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
        function del(id) {
            alert(id);
            $.ajax({
                type: "get",
                url: "${pageContext.request.contextPath}/employee/delete/"+id,
                dataType:"json",
                success: function(result){
                    if(result.state==200){
                        window.location.href="${pageContext.request.contextPath}/system/user";
                    }else{
                        alert('删除失败');
                    }
                }
            })
        }

        //更新
        function update(id){
            //根据用户id,查询对应的用户数据
            window.location.href="${pageContext.request.contextPath}/employee/update/"+id;
        }

        //点击搜索按钮
        function search(){
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/employee/search",
                data:$("#searchForm").serialize(),
                dataType:"json",
                success: function(result){
                    //清除原有的表格中的数据
                    $("#userTable tr:gt(1):not(tr[id=operate])").remove();
                    $.each(result.list,function(index,element){
                        var tr="<tr align='center' bgcolor=\"#FFFFFF\" onMouseMove=\"javascript:this.bgColor='#FCFDEE';\" onMouseOut=\"javascript:this.bgColor='#FFFFFF';\" height=\"22\" >\n" +
                            "\t<td><input name=\"id\" type=\"checkbox\" id=\"id\" value=\"101\" class=\"np\"></td>\n" +
                            "\t<td>"+element.eid+"</td>\n" +
                            "\t<td>"+element.ename+"</td>\n" +
                            "\t<td align=\"center\">"+element.position.name+"</td>\n" +
                            "\t<td>"+element.esex+"</td>\n" +
                            "\t<td>"+element.eage+"</td>\n" +
                            "\t<td>"+element.telephone+"</td>\n" +
                            "\t<td>"+getDate(element.hiredate)+"</td>\n" +
                            "\t<td><a href=\"javascript:del("+element.eid+")\">删除</a> | <a href=\"javascript:update("+element.eid+")\">编辑</a> | <a href=\"user-look.jsp\">查看详情</a></td>\n" +
                            "</tr>";
                        //在id:operate对应的行前面添加创建的行数据
                        $("#operate").before(tr);
                    })
                    //分页的html
                    var page="<tr align=\"right\" bgcolor=\"#EEF4EA\">\n" +
                        "\t<td height=\"36\" colspan=\"12\" align=\"center\">\n" +
                        "\n" +
                        "<a href=\"javascript:firstpage();\">首页</a>&nbsp;&nbsp;&nbsp;\n" +
                        "<a href=\"javascript:previouspage("+result.pageNum+");\">上一页</a>&nbsp;&nbsp;&nbsp;\n" +
                        "<a href=\"javascript:nextpage("+result.pageNum+","+result.pages+");\">下一页</a>&nbsp;&nbsp;&nbsp;\n" +
                        "<a href=\"javascript:tailpage("+result.pages+");\">尾页</a>\n" +
                        "</td>\n" +
                        "</tr>";

                    //在id:operate的元素后面追加分页
                    $("#operate").after(page);
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
    当前位置:权限管理>>用户管理
 </td>
  <td>
    <input type='button' class="coolbg np" onClick="location='${pageContext.request.contextPath}/system/user-add';" value='添加用户' />
 </td>
 </tr>
</table>
</td>
</tr>
</table>

<!--  搜索表单  -->
<form name='form3' id="searchForm">
<table width='98%'  border='0' cellpadding='1' cellspacing='1' bgcolor='#CBD8AC' align="center" style="margin-top:8px">
  <tr bgcolor='#EEF4EA'>
    <td background='${pageContext.request.contextPath}/skin/images/wbg.gif' align='center'>
      <table border='0' cellpadding='0' cellspacing='0'>
        <tr>
          <td width='90' align='center'>搜索条件：</td>
          <td width='160'>
          <select name='searchCategory' style='width:150'>
          <option value='0'>选择类型...</option>
          	<option value='name'>姓名</option>
          	<option value='telephone'>联系电话</option>
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
            <option value='hiredate'>入职时间</option>
      	</select>
        </td>
        <td>
          &nbsp;&nbsp;&nbsp;<input  type="button" src="${pageContext.request.contextPath}/skin/images/frame/search.gif" width="45" height="20" border="0" class="np" value="搜索" onclick="search();"/>
        </td>
       </tr>
      </table>
    </td>
  </tr>
</table>
</form>
<!--  内容列表   -->
<form name="form2">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px" id="userTable">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="12" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;用户列表&nbsp;</td>
</tr>
<tr align="center" bgcolor="#FAFAF1" height="22">
	<td width="4%">选择</td>
	<td width="6%">序号</td>
	<td width="10%">姓名</td>
	<td width="10%">职位</td>
	<td width="10%">性别</td>
	<td width="10%">年龄</td>
	<td width="10%">联系电话</td>
	<td width="8%">入职时间</td>
	<td width="10%">操作</td>
</tr>




<tr bgcolor="#FAFAF1"  id="operate">
<td height="28" colspan="12">
	&nbsp;
	<a href="" class="coolbg">全选</a>
	<a href="" class="coolbg">反选</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="" class="coolbg">&nbsp;注销&nbsp;</a>
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