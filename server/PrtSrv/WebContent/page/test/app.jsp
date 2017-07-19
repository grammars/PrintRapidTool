<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/page/";  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试应用场景</title>
<link href="${PATH}/page/comm/css/default.css" rel="stylesheet">
<%@ include file="../static/materialize_head.jsp" %>
</head>
<body>

<div class="container">

<ul id="dropdown1" class="dropdown-content">
  <li><a href="#">然而现在</a></li>
  <li><a href="#">并没有</a></li>
  <li class="divider"></li>
  <li><a href="#">什么文档</a></li>
</ul>
<nav>
  <div class="nav-wrapper">
    <a href="#" class="brand-logo">&nbsp;&nbsp;应用测试场景 </a>
    <ul class="right hide-on-med-and-down">
      <li><a href="#">应用体验</a></li>
      <li><a href="#">接入说明</a></li>
      <!-- Dropdown Trigger -->
      <li><a class="dropdown-button" href="#!" data-activates="dropdown1">开发文档<i class="material-icons right">arrow_drop_down</i></a></li>
    </ul>
  </div>
</nav>




<br><hr><br>
<nav style="background-color: #FF8EA0;">
    <div class="nav-wrapper">
      <div class="col s12">&nbsp;&nbsp;
      	<a href="javascript:void(0);" class="breadcrumb">所有订单</a>
        <a href="javascript:void(0);" class="breadcrumb">客服待受理</a>
      </div>
    </div>
</nav>
<br>
<a id="prtBtn1" class="waves-effect waves-light btn"><i class="material-icons left">cloud</i>打印确认单</a>
<%@ include file="orders.jsp" %>




<br><hr><br>
<nav style="background-color: #FF8EA0;">
    <div class="nav-wrapper">
      <div class="col s12">&nbsp;&nbsp;
        <a href="javascript:void(0);" class="breadcrumb">所有订单</a>
        <a href="javascript:void(0);" class="breadcrumb">客服待受理</a>
        <a href="javascript:void(0);" class="breadcrumb">生产待安排</a>
      </div>
    </div>
</nav>
<br>
<a id="prtBtn2" class="waves-effect waves-light btn"><i class="material-icons left">cloud</i>打印生产单</a>
<%@ include file="orders.jsp" %>




<br><hr><br>
<nav style="background-color: #FF8EA0;">
    <div class="nav-wrapper">
      <div class="col s12">&nbsp;&nbsp;
        <a href="javascript:void(0);" class="breadcrumb">所有订单</a>
        <a href="javascript:void(0);" class="breadcrumb">客服待受理</a>
        <a href="javascript:void(0);" class="breadcrumb">生产待安排</a>
        <a href="javascript:void(0);" class="breadcrumb">生产进行中</a>
        <a href="javascript:void(0);" class="breadcrumb">成品待发货</a>
      </div>
    </div>
</nav>
<br>
<a id="prtBtn2" class="waves-effect waves-light btn"><i class="material-icons left">cloud</i>打印发货单</a>
<%@ include file="orders.jsp" %>


</div>

<%@ include file="../static/materialize_foot.jsp" %>

<script type="text/javascript">

$(function(){
	$('#prtBtn1').click(function(){
	    // 创建Form  
	    var form = $('<form></form>');  
	    // 设置属性  
	    form.attr('action', '${PATH}/task.page');  
	    form.attr('method', 'post');
	    form.attr('target', '_blank');  
	    // 创建Input  
	    var prt_domain = $('<input type="text" name="prt_domain" value="donline" />');  
	    var prt_username = $('<input type="text" name="prt_username" value="demo" />'); 
	    var prt_password = $('<input type="text" name="prt_password" value="123456" />'); 
	    var prt_folder = $('<input type="text" name="prt_folder" value="接单部" />'); 
	    var prt_segment = $('<input type="text" name="prt_segment" value="fgid" />'); 
	    var fgid_0 = $('<input type="text" name="fgid" value="fg0" />'); 
	    var fgid_1 = $('<input type="text" name="fgid" value="fg1" />'); 
	    var fgid_2 = $('<input type="text" name="fgid" value="fg2" />'); 
	    var other_params = $('<input type="text" name="other_params" value="GetOrderInfo" />'); 
	    // 附加到Form  
	    form.append(prt_domain);
	    form.append(prt_username);
	    form.append(prt_password);
	    form.append(prt_folder);
	    form.append(prt_segment);
	    form.append(fgid_0);
	    form.append(fgid_1);
	    form.append(fgid_2);
	    form.append(other_params);
	    // 提交表单  
	    $(document.body).append(form);
	    form.submit();  
	    // 注意return false取消链接的默认动作  
	    return false;  
	});
	
	
	$('#prtBtn2').click(function(){
	    // 创建Form  
	    var form = $('<form></form>');  
	    // 设置属性  
	    form.attr('action', '${PATH}/task.page');  
	    form.attr('method', 'post');
	    form.attr('target', '_blank');  
	    // 创建Input  
	    var prt_domain = $('<input type="text" name="prt_domain" value="donline" />');  
	    var prt_username = $('<input type="text" name="prt_username" value="demo" />'); 
	    var prt_password = $('<input type="text" name="prt_password" value="123456" />'); 
	    var prt_folder = $('<input type="text" name="prt_folder" value="生产车间" />'); 
	    var prt_segment = $('<input type="text" name="prt_segment" value="fgid" />'); 
	    var fgid_0 = $('<input type="text" name="fgid" value="fg0" />'); 
	    var fgid_1 = $('<input type="text" name="fgid" value="fg1" />'); 
	    var fgid_2 = $('<input type="text" name="fgid" value="fg2" />'); 
	    var other_params = $('<input type="text" name="other_params" value="GetOrderInfo" />'); 
	    // 附加到Form  
	    form.append(prt_domain);
	    form.append(prt_username);
	    form.append(prt_password);
	    form.append(prt_folder);
	    form.append(prt_segment);
	    form.append(fgid_0);
	    form.append(fgid_1);
	    form.append(fgid_2);
	    form.append(other_params);
	    // 提交表单  
	    $(document).append(form);
	    form.submit();  
	    // 注意return false取消链接的默认动作  
	    return false;  
	});
	
	
	$('#prtBtn3').click(function(){
	    // 创建Form  
	    var form = $('<form></form>');  
	    // 设置属性  
	    form.attr('action', '${PATH}/task.page');  
	    form.attr('method', 'post');
	    form.attr('target', '_blank');  
	    // 创建Input  
	    var prt_domain = $('<input type="text" name="prt_domain" value="donline" />');  
	    var prt_username = $('<input type="text" name="prt_username" value="demo" />'); 
	    var prt_password = $('<input type="text" name="prt_password" value="123456" />'); 
	    var prt_folder = $('<input type="text" name="prt_folder" value="发货部" />'); 
	    var prt_segment = $('<input type="text" name="prt_segment" value="fgid" />'); 
	    var fgid_0 = $('<input type="text" name="fgid" value="fg0" />'); 
	    var fgid_1 = $('<input type="text" name="fgid" value="fg1" />'); 
	    var fgid_2 = $('<input type="text" name="fgid" value="fg2" />'); 
	    var other_params = $('<input type="text" name="other_params" value="GetOrderInfo" />'); 
	    // 附加到Form  
	    form.append(prt_domain);
	    form.append(prt_username);
	    form.append(prt_password);
	    form.append(prt_folder);
	    form.append(prt_segment);
	    form.append(fgid_0);
	    form.append(fgid_1);
	    form.append(fgid_2);
	    form.append(other_params);
	    // 提交表单  
	    $(document).append(form);
	    form.submit();  
	    // 注意return false取消链接的默认动作  
	    return false;  
	});
});

</script>

</body>
</html>