<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/include.jsp"%>

<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User list</title>
<script type="text/javascript">
//删除
function del(){
	var row = $("#dg").datagrid('getSelections');
	if(row.length!=0) {
		 $.messager.confirm("确认", "确认删除吗？", function (r) {
		        if (r) {
		        	var myArray=new Array();
		        	for(var i=0;i<row.length;i++){
		        		myArray.push(row[i].id);
		        	}
		        	$.ajax({   
					     url:'${pageContext.request.contextPath}/system/user/delete.do',   
					     type:'post',   
					     data:"id="+myArray,
					     success:function(data){   
					        if(data.msg==null){
					        	window.location="${pageContext.request.contextPath}/system/user/toList.do";
					        }else{
					        	$.messager.alert('提示',data.msg);
					        }
					     }
					});
		        }
		 });
	}else{
		$.messager.alert('提示','请选择一条');
	}
}

//弹窗修改
function upd(){
	var row =  $("#dg").datagrid('getSelections');
	if(row.length==1){
		window.location="${pageContext.request.contextPath}/system/user/toUpdate.do?id="+row[0].id;
	}else{
		$.messager.alert('提示','请选择一条');
	}
}

function cx(){
	var obj=$("#searchFrom").serializeObject(); 
	$("#dg").datagrid('load',obj); 
}

</script>
</head>
<body>
  	
   <table id="dg"  class="easyui-datagrid"  fit="true" 
            url="${pageContext.request.contextPath}/system/user/list.do"
            toolbar="#toolbar" pagination="true"
            rownumbers="true" fitColumns="true" singleSelect="false" >
        <thead>
            <tr>
            	<th field=""  data-options="checkbox:true"></th>
                <th field="username"  width="50">username</th>
            </tr>
        </thead>
    </table>
    <div id="toolbar" >
    	<form id="searchFrom" action="">
			username:<input type="text" name="username" class="easyui-validatebox" />
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="cx()">查询</a><br>
		</form>
		<shiro:hasPermission name="/system/user/add">
			<a href="${pageContext.request.contextPath}/system/user/toAdd.do" class="easyui-linkbutton" iconCls="icon-add" plain="true" >新增</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="/system/user/update">
        	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="upd()">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="/system/user/delete">
        	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="del()">删除</a>
        </shiro:hasPermission>
    </div>
</body>
</html>