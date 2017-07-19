<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="${STATIC}/sui/m/lib/zepto/zepto.min.js" charset='utf-8'></script>
<!-- 为了使用slideToggle等jQuery特性的方法而引入jquery , 原版sui中仅使用zepto -->
<!-- <script src="${STATIC}/jquery/jquery-1.11.3.min.js" charset='utf-8'></script> -->
<!-- <script>var Zepto = jQuery</script> -->

<script src="${STATIC}/sui/m/dist/js/sm.min.js" charset='utf-8'></script>
<script src="${STATIC}/sui/m/dist/js/sm-extend.min.js" charset='utf-8'></script>

<c:if test="${sui_city_picker==true}">
<script src="${STATIC}/sui/m/dist/js/sm-city-picker.min.js" charset='utf-8'></script>
</c:if>

<script>
	$.init();
</script>