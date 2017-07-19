package prt.component
{
	import com.anstu.jcommon.utils.StringUtils;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.define.JuiConst;
	
	import prt.Conf;

	public class MyLabel extends MyComponent
	{
		private var label:JLabel;
		private var row:Object;
		
		public var dataType:String = DATA_TYPE_STATIC;
		
		private static const DATA_TYPE_STATIC:String = "static";//静态文本
		private static const DATA_TYPE_API:String = "api";//接口字段
		public static function get DATA_TYPE_NAMES():Array { return ["静态文本", "接口字段"]; }
		public static function dataTypeFromIndex(i:int):String
		{
			if(0 == i) return DATA_TYPE_STATIC;
			if(1 == i) return DATA_TYPE_API;
			return null;
		}
		public static function indexFromDataType(value:String):int
		{
			if(DATA_TYPE_STATIC == value) return 0;
			if(DATA_TYPE_API == value) return 1;
			return 0;
		}
		
		public var text:String = "一段文本";
		
		public var colKey:String;
		
		private var _size:Number = 3;
		public function set size(value:Number):void
		{
			if(_size != value)
			{
				_size = value;
				label.textFormat.size = Conf.mm2px(_size);
			}
		}
		public function get size():Number { return _size; }
		
		private var _align:String = Conf.ALIGN_LEFT;
		public function set align(value:String):void
		{
			if(_align != value)
			{
				_align = value;
				label.align = _align;
			}
		}
		public function get align():String { return _align; }
		
		public function MyLabel()
		{
			super();
			this.type = Conf.COMPONENT_LABEL;
			this.componentColor = 0xdea012;
			this.mmw = 28;
			this.mmh = 10;
			
			label = new JLabel(text);
			label.bmpMode = true;
			label.textFormat.font = "黑体";//"微软雅黑";
			label.textFormat.size = Conf.mm2px(_size);
			label.align = JuiConst.LEFT;
			this.addChild(label);
			
			invalidate();
		}
		
		override public function paint():void
		{
			super.paint();
			label.width = Conf.mm2px(_mmw);
			label.height = Conf.mm2px(_mmh);
			if(DATA_TYPE_API == dataType && row && !StringUtils.isEmpty(colKey))
			{
				label.text = ""+row[colKey];
			}
			else
			{
				label.text = this.text;
			}
		}
		
		override public function handleDs(jsonObj:Object):void
		{
			this.row = jsonObj;
			invalidate();
		}
		
		override public function encode(obj:Object):void
		{
			super.encode(obj);
			obj.dataType = this.dataType;
			obj.text = this.text;
			obj.colKey = this.colKey;
			obj.size = this.size;
			obj.align = this.align;
		}
		
		override public function decode(obj:Object):void
		{
			super.decode(obj);
			this.dataType = obj.dataType;
			this.text = obj.text;
			this.colKey = obj.colKey;
			this.size = obj.size ? obj.size : 8;
			this.align = obj.align ? obj.align : Conf.ALIGN_LEFT;
		}
	}
}