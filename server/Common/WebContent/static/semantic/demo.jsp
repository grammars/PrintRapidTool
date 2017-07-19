<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>演示</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%@include file="../../page/static/semantic_head.jsp"%>
</head>

<body>

<!-- 两种Tab演示 beg -->
<div class="myTab ui pointing secondary menu">
  <a class="active red item" data-tab="first">First菜单</a>
  <a class="blue item" data-tab="second">Second菜单</a>
  <a class="green item" data-tab="third">Third菜单</a>
</div>
<div class="ui active tab segment" data-tab="first">First内容</div>
<div class="ui tab segment" data-tab="second">Second内容</div>
<div class="ui tab segment" data-tab="third">Third内容</div>


<div class="ui grid">
  <div class="four wide column">
    <div class="myTab ui vertical fluid tabular menu">
      <a class="item active" data-tab="a">a菜单</a>
      <a class="item" data-tab="b">b菜单</a>
      <a class="item" data-tab="c">c菜单</a>
      <a class="item" data-tab="d">d菜单</a>
    </div>
  </div>
  <div class="twelve wide stretched column">
    <div class="ui segment tab active" data-tab="a">a内容 </div>
    <div class="ui segment tab" data-tab="b">b内容</div>
    <div class="ui segment tab" data-tab="c">c内容</div>
    <div class="ui segment tab" data-tab="d">d内容 </div>
  </div>
</div>
<!-- 两种Tab演示 end -->


<%@include file="../../page/static/semantic_foot.jsp"%>

<script type="text/javascript">
	//两种Tab演示
    $(function (){
        $('.myTab.menu .item').tab();
    })
	//
</script>

</body>
</html>
