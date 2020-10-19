<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户管理</title>
    <script src="${pageContext.request.contextPath}/skin/js/jquery-3.4.1.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/script/docs.min.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/ztree/jquery.ztree.all-3.5.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/ztree/zTreeStyle.css">
<script type="text/javascript">
       $(function(){
	     var setting = {
				async: {
					enable: true,//开启异步加载数据
                    url:"${pageContext.request.contextPath}/sources/showAll"//向后台发送的请求
					//autoParam:["id", "name=n", "level=lv"]
				 },
				view: {
					addHoverDom: function(treeId, treeNode){
					    console.log(treeId);
					    console.log(treeNode);
						var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
                        aObj.attr("href", "javascript:void(0);");
                        aObj.attr("target","_self");
						if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
						var s = '<span id="btnGroup'+treeNode.tId+'">';
						if ( treeNode.level == 0 ) {//一级菜单
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" target="_self" onclick="add('+treeNode.id+');">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
						} else if ( treeNode.level == 1 ) {//二级菜单
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"   href="#" title="修改权限信息" onclick="edit('+treeNode.id+');">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
							if (treeNode.children.length == 0) {
								s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
							}
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" onclick="add('+treeNode.id+');">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
						} else if ( treeNode.level == 2 ) {//三级菜单
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"   href="#" title="修改权限信息" onclick="edit('+treeNode.id+');">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" onclick="deleteNode('+treeNode.id+')">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
						}		
						s += '</span>';
						aObj.after(s);
					},
					removeHoverDom: function(treeId, treeNode){
						$("#btnGroup"+treeNode.tId).remove();
					}
				}
		  };
	        $.fn.zTree.init($("#permissionTree"), setting);
      });

       //点击添加的按钮
       function add(id){
           window.location.href="${pageContext.request.contextPath}/system/resource-add?pid="+id;
       }

       //点击编辑按钮
       function edit(id) {
           window.location.href="${pageContext.request.contextPath}/system/resource-edit?id="+id;
       }

       
       //删除节点
       function deleteNode(id){
           alert('xxx');
    	   layer.confirm("删除资源信息, 是否继续",  {icon: 3, title:'提示'}, function(cindex){

				layer.close(cindex);
			},function(cindex){
			    layer.close(cindex);
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
    当前位置:权限管理>>权限维护
 </td>
 <td>

 </td>
 </tr>
</table>
</td>
</tr>
</table>


<!--  内容列表   -->
<form name="form2">
<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="12" background="${pageContext.request.contextPath}/skin/images/tbg.gif">&nbsp;权限列表&nbsp;</td>
</tr>
<tr align="center" bgcolor="#FAFAF1" height="22">
	 <td>
     <div class="panel-body">
           <ul id="permissionTree" class="ztree"></ul>
	 </div>
    </td>
</tr>

</table>

</form>
  

</body>
</html>