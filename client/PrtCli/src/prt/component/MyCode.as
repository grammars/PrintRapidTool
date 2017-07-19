package prt.component
{
	import barcode.BarcodeUtil;
	
	import com.anstu.jcommon.utils.StringUtils;
	import com.anstu.jui.controls.JLabel;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import prt.Conf;
	import prt.Ctx;

	public class MyCode extends MyComponent
	{
		private var image:Bitmap = new Bitmap();
		
		private static const SRC_STATIC:String = "static";//
		private static const SRC_DATASOURCE:String = "datasource";//
		public static function get SRC_NAMES():Array { return ["静态文本", "从数据源获取"]; }
		public static function srcFromIndex(i:int):String
		{
			if(0 == i) return SRC_STATIC;
			if(1 == i) return SRC_DATASOURCE;
			return null;
		}
		public static function indexFromSrc(value:String):int
		{
			if(SRC_STATIC == value) return 0;
			if(SRC_DATASOURCE == value) return 1;
			return 0;
		}
		
		protected var _src:String;
		public function set src(value:String):void
		{
			this._src = value;
			invalidate();
		}
		public function get src():String
		{
			return this._src;
		}
		
		private static const CT_QR_CODE:String = "QR_CODE";//
		private static const CT_EAN_8:String = "EAN_8";//
		private static const CT_EAN_13:String = "EAN_13";//
		private static const CT_UPC_A:String = "UPC_A";//
		private static const CT_CODE_39:String = "CODE_39";//
		private static const CT_CODE_128:String = "CODE_128";//
		private static const CT_ITF:String = "ITF";//
		public static function get CT_NAMES():Array { return ["二维码", "EAN-8", "EAN-13", "UPC-A", "CODE-39", "CODE-128", "ITF"]; }
		public static function ctFromIndex(i:int):String
		{
			if(0 == i) return CT_QR_CODE;
			if(1 == i) return CT_EAN_8;
			if(2 == i) return CT_EAN_13;
			if(3 == i) return CT_UPC_A;
			if(4 == i) return CT_CODE_39;
			if(5 == i) return CT_CODE_128;
			if(6 == i) return CT_ITF;
			return null;
		}
		public static function indexFromCt(value:String):int
		{
			if(CT_QR_CODE == value) return 0;
			if(CT_EAN_8 == value) return 1;
			if(CT_EAN_13 == value) return 2;
			if(CT_UPC_A == value) return 3;
			if(CT_CODE_39 == value) return 4;
			if(CT_CODE_128 == value) return 5;
			if(CT_ITF == value) return 6;
			return 0;
		}
		
		protected var _ct:String;
		public function set ct(value:String):void
		{
			this._ct = value;
			invalidate();
		}
		public function get ct():String
		{
			return this._ct;
		}
		
		protected var _colName:String;
		public function set colName(value:String):void
		{
			this._colName = value;
			invalidate();
		}
		public function get colName():String
		{
			return this._colName;
		}
		
		protected var _text:String;
		public function set text(value:String):void
		{
			this._text = value;
			invalidate();
		}
		public function get text():String
		{
			return this._text;
		}
		
		public function MyCode()
		{
			super();
			this.type = Conf.COMPONENT_CODE;
			this.componentColor = 0x212332;
			this.mmw = 14;
			this.mmh = 14;
			this.addChild(image);
			invalidate();
		}
		
		override public function encode(obj:Object):void
		{
			super.encode(obj);
			obj.src = this.src;
			obj.ct = this.ct;
			obj.colName = this.colName;
			obj.text = this.text;
		}
		
		override public function decode(obj:Object):void
		{
			super.decode(obj);
			this.src = obj.src;
			this.ct = obj.ct;
			this.colName = obj.colName;
			this.text = obj.text;
		}
		
		override public function paint():void
		{
			super.paint();
			
			if(SRC_STATIC == this.src)
			{
				genImage();
			}
		}
		
		override public function handleDs(jsonObj:Object):void
		{
			if(SRC_DATASOURCE == this.src)
			{
				if(jsonObj && !StringUtils.isEmpty(this.colName)  && !StringUtils.isEmpty(jsonObj[this.colName]))
				{
					text = jsonObj[this.colName];
					genImage();
				}
			}
		}
		
		private function genImage():void
		{
			
			var codeType:String = null;
			switch(ct)
			{
			case CT_QR_CODE: codeType = BarcodeUtil.TYPE_QR_CODE; break;
			case CT_EAN_8: codeType = BarcodeUtil.TYPE_EAN_8; break;
			case CT_EAN_13: codeType = BarcodeUtil.TYPE_EAN_13; break;
			case CT_UPC_A: codeType = BarcodeUtil.TYPE_UPC_A; break;
			case CT_CODE_39: codeType = BarcodeUtil.TYPE_CODE_39; break;
			case CT_CODE_128: codeType = BarcodeUtil.TYPE_CODE_128; break;
			case CT_ITF: codeType = BarcodeUtil.TYPE_ITF; break;
			}
			var errorTip:String = null;
			if(StringUtils.isEmpty(text))
			{
				errorTip = "条码内容不能为空!";
			}
			else
			{
				try
				{
					image.bitmapData = barcode.BarcodeUtil.Generate(codeType, text, Conf.mm2px(mmw), Conf.mm2px(mmh));
				}
				catch(e:Error)
				{
					errorTip = new String(e.message);
					Ctx.console.log("errorTip="+errorTip);
					Ctx.console.log(e.getStackTrace());
				}
			}
			
			if(errorTip != null)
			{
				image.bitmapData = new BitmapData(Conf.mm2px(mmw), Conf.mm2px(mmh), true, 0x00ffffff);
				var l:JLabel = new JLabel(errorTip);
				l.draw();
				image.bitmapData.draw(l);
			}
		}
	}
}