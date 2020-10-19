<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>用户管理</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/skin/js/jquery-3.4.1.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
    <LINK href="${pageContext.request.contextPath}/skin/js/theAlert.css" type=text/css rel=stylesheet>
    <script type="text/javascript" src="${pageContext.request.contextPath}/skin/js/theAlert.js"></script>

    <script type="text/javascript">





        //选择父菜单的下拉列表
        function updateParentSources(){
            var id=$("#pid option:selected").val();
            //根据id获取它的同一级菜单信息
            $.ajax({
                method:'get',
                url:'${pageContext.request.contextPath}/sources/sourcesinfo',
                data:{"id":id},
                dataType:'json',
                success:function(result){
                    $.each(result,function(index,element){
                        var option="<option value='"+element.id+"'>"+element.name+"</option>";
                        $("#pid").append(option);
                    })
                }
            })
        }

        //点击保存按钮
        function commit(){
            $.ajax({
                method:'post',
                url:'${pageContext.request.contextPath}/sources/update',
                data:$("#sourceForm").serialize(),
                dataType:'json',
                success:function(result){
                   if(result.flag){
                       window.location.href='${pageContext.request.contextPath}/system/resource';
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
                    <td>
                        当前位置:权限管理>>修改菜单资源
                    </td>
                    <td>

                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>


<!--  内容列表   -->
<form name="form2" id="sourceForm">
    <input type="hidden" name="id" id="hidden">

    <table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center"
           style="margin-top:8px">
        <tr bgcolor="#E7E7E7">
            <td height="24" colspan="12" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;修改资源&nbsp;</td>
        </tr>

        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">菜单资源名称：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input name="name" id="sname" value="${sources.name}"/></td>
        </tr>

        <tr >
            <td align="right" bgcolor="#FAFAF1" height="22">父菜单：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <select name="pid"  id="pid">
                    <option >请选择父菜单</option>

                </select>
            </td>
        </tr>

        <tr  id="ttr">
            <td align="right" bgcolor="#FAFAF1" height="22">菜单资源路径：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input name="url" id="surl" size="80" value="${sources.url}"/></td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1">资源描述：</td>
            <td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';">
                <textarea rows=10 cols=130 name="remark" id="sremark">${sources.remark}</textarea>
            </td>
        </tr>


        <tr bgcolor="#FAFAF1">
            <td height="28" colspan=4 align=center>
                &nbsp;
                <a href="javascript:commit()" class="coolbg">保存</a>
                <a href="${pageContext.request.contextPath}/system/resources" class="coolbg">返回</a>
            </td>
        </tr>
    </table>

</form>
<script>
    $(function () {
        var id=location.search.substring(location.search.indexOf("=")+1);
        $("#hidden").val(id);
        $.getJSON("${pageContext.request.contextPath}/sources/findOne",{"id":id},function (data) {
            $('#sname').val(data.name);
            $("#surl").val(data.url);
            $("#sremark").val(data.remake);
            var option="<option >请选择父菜单</option>";
            $.each(data.children,function (index,element) {
                option+="<option value="+element.id+">"+element.name+"</option>"
            })
                $("#pid").html(option);
        })
    });
</script>

</body>
</html>