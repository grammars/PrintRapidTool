
function easyui_date_formatter(date) {
	// alert("easyui_date_formatter " + date);
	var y = date.getFullYear();
	var m = date.getMonth() + 1;
	var d = date.getDate();
	var hour = date.getHours();
	var min = date.getMinutes();
	var sec = date.getSeconds();
	return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d)
			+ ' ' + (hour < 10 ? ('0' + hour) : hour) + ':'
			+ (min < 10 ? ('0' + min) : min) + ':'
			+ (sec < 10 ? ('0' + sec) : sec);
}

function easyui_date_parser(s) {
	var y = s.substring(0, 4);
	var m = s.substring(5, 7);
	var d = s.substring(8, 10);
	var hour = s.substring(11, 13);
	var min = s.substring(14, 16);
	var sec = s.substring(17, 19);
	if (isNaN(y) || isNaN(m) || isNaN(d) || isNaN(hour) || isNaN(min)
			|| isNaN(sec)) {
		return new Date();
	}
	return new Date(y, m - 1, d, hour, min, sec);
}


$(function(){
	var pager = $('#dg').datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		beforePageText: '第',//页数文本框前显示的汉字  
		afterPageText: '页    共 {pages} 页',  
		displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
	});	
});

var edit = edit ? edit : {
	//
	toAdd : function() {
		
	},
	
	//
	fill : function() {
		alert("edit.fillFromSelect 该方法应该被覆盖");
	},
	
	//
	getAddUrl : function() {
		return "";
	},
	//
	getEditUrl : function() {
		return "";
	},
	//
	getRemoveUrl : function() {
		return "";
	},
	
	//
	doAdd : function() {
		this.setIsNew(true);
		$('#editWnd').window({top:"0px"});
		$('#editWnd').window('open');
		this.toAdd();
	},
	
	//
	doEdit : function() {
		this.setIsNew(false);
		var selected = $('#dg').datagrid('getSelected');
		if (!selected) {
			$.messager.alert("提示", "请先选择一项进行编辑");
			return;
		}
		this.fill(selected);//该方法来自具体的editXxxx.jsp
		$('#editWnd').window({top:"0px"});
		$('#editWnd').window('open');
	},
	
	//
	doRemove : function () {
		var selected = $('#dg').datagrid('getSelected');
		if (!selected) {
			$.messager.alert("提示", "请先选择一项进行删除");
			return;
		}
		var submitUrl = this.getRemoveUrl();
		$.messager.confirm('确认', '您想要删除uid='+selected.uid+'的这一项吗？', function(r){
			if (r){
				$.ajax({
	  				type: "POST",
	  				url: submitUrl,
	  				data: {
	  					uid:selected.uid
	  				},
	  				dataType:"json",
	  				success:function(data, textStatus) {
	  					$.messager.show({
	  						title : '操作结果',
	  						msg : data.errormsg,
	  						timeout : 1000,
	  						showType : 'fade',
	  						style : {
	  							right : '',
	  							bottom : ''
	  						}
	  					});
	  					$('#dg').datagrid('reload');
	  				},
	  				error:function(xmlHttpRequest, textStatus, errorThrown) {
	  					alert("请求ajax删除失败 textStatus="+textStatus);
	  				}
	  			});
			}
		});
	},
	
	//
	saveHandler : function() {
		$('#editForm').form({
			url : this.getSaveUrl(),
			onSubmit : function() {
				// do some check
				// return false to prevent submit;
			},
			success : function(data) {
				var json = toJsonObj(data);
				$.messager.show({
					title : '操作结果',
					msg : json.errormsg,
					timeout : 2000,
					showType : 'fade',
					style : {
						right : '',
						bottom : ''
					}
				});
				$('#editWnd').window('close');
				$('#dg').datagrid('reload'); 
			}
		});
		// submit the form
		$('#editForm').submit();
	},
	
	//
	cancelHandler : function() {
		$('#editWnd').window('close');
	},
	
	getSaveUrl : function() {
		if(this.isNew) {
			return this.getAddUrl();
		} else {
			return this.getEditUrl();
		}
	},
	
	isNew : true,
	//
	/** 设置 是否是 新增 条目 */
	setIsNew : function (value) {
		this.isNew = value;
		var t = value == true ? "新增数据" : "修改数据";
		$('#editWnd').window({
			'title' : t
		});
	}
};


