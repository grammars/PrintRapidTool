<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Dropdown Structure -->
<ul id="dropdownBasicInfo" class="dropdown-content">
	<li><a href="${PATH}/user/get.page" target="contentPage">我的帐号</a></li>
	<li><a href="${PATH}/building.page" target="contentPage">其他项目二</a></li>
	<li><a href="${PATH}/building.page" target="contentPage">其他项目三</a></li>
	<li class="divider"></li>
	<li><a href="${PATH}/logout.page">退出登录</a></li>
</ul>

<!-- Dropdown Structure -->
<ul id="dropdownOrgManage" class="dropdown-content">
	<c:if test="${permission.userManage==true}">
		<li><a href="${PATH}/user/list.page" target="contentPage">用户管理</a></li>
	</c:if>
	<c:if test="${permission.departmentSetup==true}">
		<li><a href="${PATH}/department/setup.page" target="contentPage">部门设置</a></li>
	</c:if>
	<li class="divider"></li>
	<c:if test="${permission.areaConfig==true}">
		<li><a href="${PATH}/building.page" target="contentPage">区域配置</a></li>
	</c:if>
</ul>

<!-- Dropdown Structure -->
<ul id="dropdownGoodsManage" class="dropdown-content">
	<li><a href="${PATH}/goods/list.page" target="contentPage">查看商品</a></li>
	<li><a href="${PATH}/goods/attrTemplateList.page" target="contentPage">商品属性模版</a></li>
	<li><a href="${PATH}/building.page" target="contentPage">其他项目三</a></li>
	<li class="divider"></li>
	<li><a href="${PATH}/building.page" target="contentPage">其他项目四</a></li>
</ul>

<!-- Dropdown Structure -->
<ul id="dropdownFinance" class="dropdown-content">
	<li><a href="${PATH}/building.page" target="contentPage">积极研发中</a></li>
	<li><a href="${PATH}/building.page" target="contentPage">积极研发中</a></li>
	<li class="divider"></li>
	<li><a href="${PATH}/building.page">积极研发中</a></li>
</ul>

<nav>
	<div class="nav-wrapper">
		<a href="#" data-activates="slide-out"
			class="brand-logo click-collapse"><i class="material-icons">menu</i>招财猫 SmartERP</a>
		<ul class="right hide-on-med-and-down">
			<li><a href="${PATH}/home.page">桌面</a></li>
			<li><a class="dropdown-button" href="${PATH}/home.page"
				data-activates="dropdownBasicInfo">基础信息<i
					class="material-icons right">arrow_drop_down</i></a></li>
			<li><a class="dropdown-button" href="${PATH}/home.page"
				data-activates="dropdownOrgManage">组织管理<i
					class="material-icons right">arrow_drop_down</i></a></li>
			<li><a class="dropdown-button" href="${PATH}/home.page"
				data-activates="dropdownGoodsManage">商品管理<i
					class="material-icons right">arrow_drop_down</i></a></li>
			<li><a class="dropdown-button" href="${PATH}/home.page"
				data-activates="dropdownFinance">财务管理<i
					class="material-icons right">arrow_drop_down</i></a></li>
			<li><a href="${PATH}/help.page" target="contentPage">帮助</a></li>
		</ul>
	</div>
</nav>

<script>
	$(function() {
		$(".dropdown-button").dropdown();
	});
</script>


<ul id="slide-out" class="side-nav">
	<li>
		<div class="userView">
			<img class="background" src="page/comm/img/office.jpg">
			<a href="#!user"><img class="circle" src="page/comm/img/yuna.jpg"></a>
			<a href="#!name"><span class="white-text name">${sessionScope.user.nickname}</span></a>
			<a href="#!email"><span class="white-text email">dabiaoge@gmail.com</span></a>
		</div>
	</li>
	
	<li><a href="${PATH}/home.page">桌面</a></li>
		
	<li><a class="subheader"><i class="material-icons">cloud</i>基础信息</a></li>
	<li><a href="${PATH}/user/get.page" target="contentPage">我的账号</a></li>
	<li><a href="${PATH}/building.page" target="contentPage">其他项目二</a></li>
	<li><a href="${PATH}/building.page" target="contentPage">其他项目三</a></li>
	<li><a href="${PATH}/logout.page">退出登录</a></li>
	<li><div class="divider"></div></li>
	
	<li><a class="subheader"><i class="material-icons">cloud</i>组织管理</a></li>
	<c:if test="${permission.userManage==true}">
		<li><a href="${PATH}/user/list.page" target="contentPage">用户管理</a></li>
	</c:if>
	<c:if test="${permission.departmentSetup==true}">
		<li><a href="${PATH}/department/setup.page" target="contentPage">部门设置</a></li>
	</c:if>
	<c:if test="${permission.areaConfig==true}">
		<li><a href="${PATH}/building.page" target="contentPage">区域配置</a></li>
	</c:if>
	<li><div class="divider"></div></li>

	<li><a class="subheader"><i class="material-icons">cloud</i>商品管理</a></li>
	<li><a href="${PATH}/goods/list.page" target="contentPage">查看商品</a></li>
	<li><a href="${PATH}/goods/attrTemplateList.page" target="contentPage">商品属性模版</a></li>
	<li><a href="${PATH}/building.page" target="contentPage">其他项目三</a></li>
	<li><a href="${PATH}/building.page" target="contentPage">其他项目四</a></li>
	<li><div class="divider"></div></li>
	
	<li><a class="subheader"><i class="material-icons">cloud</i>财务管理</a></li>
	<li><a href="${PATH}/building.page" target="contentPage">积极研发中</a></li>
	<li><a href="${PATH}/building.page" target="contentPage">积极研发中</a></li>
	<li><div class="divider"></div></li>

	<li><a class="waves-effect" href="${PATH}/help.page" target="contentPage">帮助</a></li>
</ul>

<script>
	$(function() {
		//Initialize collapse button
		$(".click-collapse").sideNav();
		// Initialize collapsible (uncomment the line below if you use the dropdown variation)
		//$('.collapsible').collapsible();
	});
</script>

