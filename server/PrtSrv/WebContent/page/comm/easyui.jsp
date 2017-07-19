<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- easyui -->
<link rel="stylesheet" href="${STATIC}/easyui/themes/metro/easyui.css">
<link rel="stylesheet" href="${STATIC}/easyui/themes/icon.css">
<!-- <script src="${STATIC}/easyui/jquery.min.js"></script> -->
<script src="${STATIC}/easyui/jquery.min.js"></script>
<script src="${STATIC}/easyui/jquery.easyui.min.js"></script>
<script src="${STATIC}/easyui/locale/easyui-lang-zh_CN.js"></script>

<script src="${STATIC}/comp/toolkit/toolkit.js" charset='utf-8'></script>

<link href='${PATH}/page/comm/css/default.css' rel='stylesheet' type='text/css'>
<!-- /easyui -->

<script>

function dg_fmt_bool(val,row){ 
    if (val == true || val == 'true'){    
        return "是";//'<span style="color:red;">('+val+')</span>';    
    } else {    
        return "否";    
    }    
}

function dg_fmt_user_type(val,row){ 
	switch(val){
	case "sys": return "系统内置";
	case "admin": return "管理员";
	case "oper": return "操作员";
	case "guest": return "访客";
	}
	return val;
}

</script>