<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>添加需求分析信息</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
    <script type="application/javascript" src="${pageContext.request.contextPath}/skin/js/jquery-3.4.1.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/utf8-jsp/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/utf8-jsp/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/utf8-jsp/lang/zh-cn/zh-cn.js"></script>

    <script type="application/javascript">
        var ue = UE.getEditor('editor');

        function commit() {
            $("#form15").submit();
        }
    </script>
    <style type="text/css">
        div {
            width: 100%;
        }
    </style>
    <script type="text/javascript">

        function commit(){
            $.ajax({
                url:"${pageContext.request.contextPath}/message/evaluate/add",
                method:"post",
                data:$("#evaluateForm").serialize(),
                success:function(data){
                    if(data.state==200){
                        alert(data.msg);
                        //跳转
                        window.location.href="${pageContext.request.contextPath}/message/forum/"+$("#forumfk").val();
                    }else{
                        alert('操作失败');
                    }
                },
                cache:false
            })
        }

        //点击回复一级评论
         function setReplay(evaid){
             $("#evaidFk").val(evaid);//evaidFK的值为一级评论的id值
         }
    </script>
</head>
<body leftmargin="8" topmargin="8" background='${pageContext.request.contextPath}/skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" c1ellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
    <tr>
        <td height="26" background="${pageContext.request.contextPath}/skin/images/newlinebg3.gif">
            <table width="58%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        当前位置:论坛>>评论
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<div>
    <form name="form2" id="evaluateForm">
        <input type="hidden" value="${forumpost.forumid}" name="forumfk" id="forumfk">
        <input type="hidden"  name="evaidfk" id="evaidFk">
        <table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center"
               style="margin-top:8px">
            <tr bgcolor="#E7E7E7">
                <td height="24" colspan="2" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;评论&nbsp;</td>
            </tr>
            <tr>
                <td align="right" bgcolor="#FAFAF1" height="22">
				<span>
					<img src='${pageContext.request.contextPath}/images/tx.png' height='50px' width='50px'/>
				</span>
               </td>

                <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                    onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                    <span>发布人:${forumpost.employee.ename}</span><br>
                    <span>发布时间: <fmt:formatDate value="${forumpost.createtime}" pattern="yyyy/MM/dd HH:mm:ss"></fmt:formatDate></span><br>
                    <span>标题：${forumpost.forumtitle}</span><br>
                    <span>内容:${forumpost.forumcontent}</span>
                </td>
            </tr>
            <!--一级评论开始-->
            <c:forEach items="${forumpost.evaluateList}" var="firstEvaluate">
                <tr>
                    <td align="right" bgcolor="#FAFAF1" height="22">
                        <span>
                            <img src='${pageContext.request.contextPath}/images/tx.png' height='50px' width='50px'/>
                        </span>
                    </td>
                    <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                        onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                        <span>评论人：${firstEvaluate.employee.ename}&nbsp;&nbsp;回复了 ${forumpost.employee.ename}&nbsp;&nbsp;</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <span>评论时间：<fmt:formatDate value="${firstEvaluate.evatime}" pattern="yyyy/MM/dd HH :mm:ss"></fmt:formatDate> </span><br>
                        <span>评论内容:${firstEvaluate.evacontent}</span>
                        &nbsp;<span><a href="javascript:setReplay(${firstEvaluate.evaid});">【回复】</a></span>
                    </td>
                </tr>
                <c:if test="${not empty firstEvaluate.subEvaluateList}">
                    <!--二级评论开始-->
                    <c:forEach items="${firstEvaluate.subEvaluateList}" var="secondEvalate">
                        <tr>
                            <td align="right" bgcolor="#FAFAF1" height="22">
                                <span>
                                    <img src='${pageContext.request.contextPath}/images/tx.png' height='50px' width='50px'/>
                                </span>
                            </td>
                            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                                <span>${secondEvalate.employee.ename}&nbsp;回复了&nbsp;${firstEvaluate.employee.ename}</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span>回复时间：<fmt:formatDate value="${secondEvalate.evatime}" pattern="yyyy/MM/dd HH :mm:ss"></fmt:formatDate></span><br>
                                <span>回复内容:${secondEvalate.evacontent}</span>
                                &nbsp;<span><a href="javascript:setReplay(${secondEvalate.evaid});">【回复】</a></span>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                <!--二级评论结束-->
            </c:forEach>
            <!--一级评论结束-->

            <!-- 添加空行
            <tr>
                <td align="right" bgcolor="#FAFAF1" height="22"></td>
                <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                    onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                </td>
            </tr>
            -->


            <tr>
                <td align="right" bgcolor="#FAFAF1" height="22">我也说两句：</td>
                <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                    onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                    <script id="editor" name="evacontent" type="text/plain" style="width:1024px;height:100px;"></script></td>
            </tr>
            <tr bgcolor="#FAFAF1">
                <td height="28" colspan=4 align=center>
                    &nbsp;
                    <a href="javascript:commit()" class="coolbg">发布</a>
                    <a href="project-need.jsp" class="coolbg">返回</a>
                </td>
            </tr>

        </table>
    </form>

</div>

</body>
</html>