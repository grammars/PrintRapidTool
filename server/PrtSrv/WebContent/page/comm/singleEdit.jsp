<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="${STATIC}/jquery/jquery.form.js" charset='utf-8'></script>

<script type="text/javascript">
$(function(){
	var options = {
			//target: '#output',          //把服务器返回的内容放入id为output的元素中      
			   beforeSubmit: showRequest,  //提交前的回调函数  
			   success: showResponse,      //提交后的回调函数  
			   //url: url,                 //默认是form的action， 如果申明，则会覆盖  
			   //type: type,               //默认是form的method（get or post），如果申明，则会覆盖  
			   //dataType: null,           //html(默认), xml, script, json...接受服务端返回的类型  
			   //clearForm: true,          //成功提交后，清除所有表单元素的值  
			   //resetForm: true,          //成功提交后，重置所有表单元素的值  
			   timeout: 3000               //限制请求的时间，当请求大于3秒后，跳出请求  
	};
	
	// submit the form
	$("#editForm").ajaxForm(options);  
	  
	//$("#editForm").submit(funtion(){  
	//   $(this).ajaxSubmit(options);  
	//   return false;   //阻止表单默认提交  
	//}); 
});

function showRequest(formData, jqForm, options){  
	   //formData: 数组对象，提交表单时，Form插件会以Ajax方式自动提交这些数据，格式如：[{name:user,value:val },{name:pwd,value:pwd}]  
	   //jqForm:   jQuery对象，封装了表单的元素     
	   //options:  options对象  
	   //var queryString = $.param(formData); //name=1&address=2  
	   //var formElement = jqForm[0];              //将jqForm转换为DOM对象  
	   //var address = formElement.address.value;  //访问jqForm的DOM元素  
	   return true;  //只要不返回false，表单都会提交,在这里可以对表单元素进行验证  
	}
	
function showResponse(responseText, statusText){  
	var json = responseText;
	//var json = eval('(' + responseText + ')');
	Materialize.toast(json.errormsg, 4000);
	if(showResponseAfter) {
		//alert("有showResponseAfter");
		showResponseAfter(json);
	}else{
		//alert("无showResponseAfter");
	}
}

function formCancel() {
	window.location.reload();
}
</script>