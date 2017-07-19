package prt.component
{
	import com.adobe.serialization.json.JSON;
	
	import prt.Conf;
	import prt.component.rt.MyRichTableItem;

	public class MyBuilder
	{
		public function MyBuilder()
		{
		}
		
		public function getComponentName(type:String):String
		{
			switch(type)
			{
				case Conf.COMPONENT_PAPER: return "纸";
				case Conf.COMPONENT_LAYOUT: return "布局";
				case Conf.COMPONENT_TABLE: return "表格";
				case Conf.COMPONENT_LABEL: return "文本";
				case Conf.COMPONENT_IMAGE: return "图像";
				case Conf.COMPONENT_CODE: return "条码";
				case Conf.COMPONENT_RECT: return "方框";
				case Conf.COMPONENT_RICH_TABLE: return "复杂表格";
				case Conf.COMPONENT_RICH_TABLE_ITEM: return "复杂表格项目";
			}
			return "无法识别的新类型";
		}
		
		public function encode(c:MyComponent):String
		{
			var jsonObj:Object = new Object();
			__ENCODE__(c, jsonObj);
			return com.adobe.serialization.json.JSON.encode(jsonObj);
		}
		
		private function __ENCODE__(c:MyComponent, jsonObj:Object):void
		{
			c.encode(jsonObj);
			if(c.isLayout)
			{
				jsonObj.children = new Array();
				var layout:MyLayout = c as MyLayout;
				for(var i:int = 0; i < layout.components.length; i++)
				{
					var ch:MyComponent = layout.components[i];
					var chObj:Object = new Object();
					__ENCODE__(ch, chObj);
					jsonObj.children.push(chObj);
				}
			}
		}
		
		public function decode(componentsJson:String, editable:Boolean):MyComponent
		{
			var jsonObj:Object = com.adobe.serialization.json.JSON.decode(componentsJson);
			var virtualLayout:MyLayout = new MyLayout();
			__DECODE__(virtualLayout, jsonObj, editable);
			return virtualLayout.components[0];
		}
		
		private function __DECODE__(layout:MyLayout, jsonObj:Object, editable:Boolean):void
		{
			var c:MyComponent = null;
			switch(jsonObj.type)
			{
				case Conf.COMPONENT_PAPER: c = new MyPaper(); break;
				case Conf.COMPONENT_LAYOUT: c = new MyLayout(); break;
				case Conf.COMPONENT_TABLE: c = new MyTable(); break;
				case Conf.COMPONENT_LABEL: c = new MyLabel(); break;
				case Conf.COMPONENT_IMAGE: c = new MyImage(); break;
				case Conf.COMPONENT_CODE: c = new MyCode(); break;
				case Conf.COMPONENT_RECT: c = new MyRect(); break;
				case Conf.COMPONENT_RICH_TABLE: c = new MyRichTable(); break;
				case Conf.COMPONENT_RICH_TABLE_ITEM: c = new MyRichTableItem(); break;
			}
			c.editable = editable;
			c.decode(jsonObj);
			if(c.isLayout && jsonObj.children != null && jsonObj.children.length > 0)
			{
				for(var i:int = 0; i < jsonObj.children.length; i++)
				{
					var chJsonObj:Object = jsonObj.children[i];
					__DECODE__(c as MyLayout, chJsonObj, editable);
				}
			}
			layout.addComponent(c);
		}
		
	}
}