<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>欢迎使用Print Rapid Tool</title>
</head>
<body>

<form action="${PATH}/task.page" method="post">
<div>prt_domain:</div><input type="text" name="prt_domain" value="donline"><br>
<div>prt_username:</div><input type="text" name="prt_username" value="demo"><br>
<div>prt_password:</div><input type="text" name="prt_password" value="123456"><br>
<div>prt_folder:</div><input type="text" name="prt_folder" value="接单部"><br>
<div>prt_segment:</div><input type="text" name="prt_segment" value="orderid"><br>
<div>orderid:</div><input type="text" name="orderid" value="ord2017-09-11"><br>
<div>orderid:</div><input type="text" name="orderid" value="ord2018-10-12"><br>
<div>orderid:</div><input type="text" name="orderid" value="ord2019-11-13"><br>
<div>command:</div><input type="text" name="command" value="GetOrderInfo"><br>
<div>description:</div><input type="text" name="description" value="这是一段神奇的描述"><br>
<input type="submit" value="提交打印任务">
</form>

<hr>
<a href="${PATH}/test/app.page" target="_blank">前往模拟使用场景</a>

</body>
</html>