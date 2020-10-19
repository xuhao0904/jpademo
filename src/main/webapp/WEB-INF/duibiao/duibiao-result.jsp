<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>对标管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
    <script type="application/javascript" src="${pageContext.request.contextPath}/skin/js/jquery-3.4.1.js"></script>
    <script type="application/javascript" src="${pageContext.request.contextPath}/eacharjs/echarts.common.min.js"></script>
    <script type="application/javascript">

        function getYear(data){
            var d=new Date(data);
            return d.getFullYear();
        }

        //显示对标公司的名称
        $.ajax({
            method:'get',
            url:'${pageContext.request.contextPath}/duibiao/showname',
            dataType:'json',
            success:function(result){
                var com=$("#indexvalueCompany");
                $.each(result,function(index,element){
                    var option="<option value='"+element.dacname+"'>"+element.dacname+"</option>";
                    com.append(option);
                    $("#indexvalueCom").append(option);
                })
            }
        })

        //选择不同的目标公司显示对应的营业额统计数据
        function showChart(){
            var name=$("#indexvalueCompany option:selected").val();
            var xArray=new Array();
            var yArray=new Array();
            $.ajax({
                method:'get',
                url:'${pageContext.request.contextPath}/duibiao/showinfo',
                data:{"name":name},
                dataType:'json',
                success:function(result){
                   $.each(result.many,function(index,element){
                       xArray.push(getYear(element.datime));
                       yArray.push(element.daturnover);

                       var mychart=echarts.init($("#box")[0]);//javascript对象
                       // 指定图表的配置项和数据
                       var option = {
                           title: {
                               text: '营业额统计'
                           },
                           tooltip: {},
                           legend: {
                               data:['营业额']
                           },
                           xAxis: {
                               data: xArray,
                           },
                           yAxis: {},
                           series: [{
                               name: '营业额(亿)',
                               type: 'bar',
                               data: yArray
                           }]
                       };
                       // 使用刚指定的配置项和数据显示图表。
                       mychart.setOption(option);
                   })
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
    当前位置:对标管理>>对标分析
 </td>
 </tr>
</table>
</td>
</tr>
</table>

<div>
    <select id="indexvalueCompany" onchange="showChart();">
        <option>请选择目标公司</option>
    </select>
</div>

<div id="box" style="width:800px;height:600px;"></div>

</body>
</html>