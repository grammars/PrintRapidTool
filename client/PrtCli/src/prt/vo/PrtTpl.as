package prt.vo
{
	import com.adobe.serialization.json.JSON;
	import com.anstu.jcommon.utils.StringUtils;
	
	import flash.net.URLVariables;
	
	import flashx.textLayout.elements.OverflowPolicy;
	
	import prt.Conf;
	import prt.Ctx;
	import prt.PaperConf;
	import prt.vo.tpl.PrtDsItem;

	public class PrtTpl
	{
		public var id:int;
		public var tpl_name:String;
		public var prt_domain:String;
		public var prt_username:String;
		public var prt_folder:String;
		public var paper_type:String;
		public var paper_mmWidth:int;
		public var paper_mmHeight:int;
		public var paper_landscape:Boolean;
		public var componentsJson:String;
		public var dsJson:String;
		
		public var dsItems:Vector.<PrtDsItem> = new Vector.<PrtDsItem>();;
		
		public function PrtTpl()
		{
			
		}
		
		public function parseObj(obj:Object):void
		{
			this.id = obj.id;
			this.tpl_name = obj.tpl_name;
			this.prt_domain = obj.prt_domain;
			this.prt_username = obj.prt_username;
			this.prt_folder = obj.prt_folder;
			this.paper_type = obj.paper_type;
			this.paper_mmWidth = obj.paper_mmWidth;
			this.paper_mmHeight = obj.paper_mmHeight;
			this.paper_landscape = obj.paper_landscape;
			this.componentsJson = obj.componentsJson;
			this.dsJson = obj.dsJson;
			decode();
		}
		
		public function toString():String
		{
			return "[PrtTpl]{name:"+tpl_name+"}";
		}
		
		public function clear():void
		{
			this.id = 0;
			this.tpl_name = null;
			this.prt_domain = null;
			this.prt_username = null;
			this.prt_folder = null;
			var pc:PaperConf = Conf.PAPER_A4_V
			this.paper_type = pc.type;
			this.paper_mmWidth = pc.mmWidth;
			this.paper_mmHeight = pc.mmHeight;
			this.paper_landscape = pc.landscape;
			this.componentsJson = null;
			dsItems.length = 0;
		}
		
		/** 内部encode */
		private function encode():void
		{
//			var jsonArr:Array = [];
//			for(var i:int = 0; i < this.dsItems.length; i++)
//			{
//				jsonArr.push(this.dsItems[i]);
//			}
//			this.dsJson = com.adobe.serialization.json.JSON.encode(jsonArr);
			this.dsJson = ENCODE_DS(this.dsItems);
		}
		
		/** 对数据源信息编码 */
		public static function ENCODE_DS(dsItems:Vector.<PrtDsItem>):String
		{
			var jsonArr:Array = [];
			for(var i:int = 0; i < dsItems.length; i++)
			{
				jsonArr.push(dsItems[i]);
			}
			var jsonStr:String = com.adobe.serialization.json.JSON.encode(jsonArr);
			return jsonStr;
		}
		
		/** 内部decode */
		private function decode():void
		{
//			dsItems.length = 0;
//			if(!StringUtils.isEmpty(this.dsJson))
//			{
//				var dsJsonArr:Object = com.adobe.serialization.json.JSON.decode(this.dsJson);
//				if(dsJsonArr && dsJsonArr.length > 0)
//				{
//					for(var i:int = 0; i < dsJsonArr.length; i++)
//					{
//						var di:PrtDsItem = new PrtDsItem();
//						di.parseObj(dsJsonArr[i]);
//						dsItems.push(di);
//					}
//				}
//			}
			dsItems = DECODE_DS(this.dsJson);
		}
		
		/** 对数据源信息解码 */
		public static function DECODE_DS(jsonStr:String):Vector.<PrtDsItem>
		{
			var dsItems:Vector.<PrtDsItem> = new Vector.<PrtDsItem>();
			if(!StringUtils.isEmpty(jsonStr))
			{
				var dsJsonArr:Object = com.adobe.serialization.json.JSON.decode(jsonStr);
				if(dsJsonArr && dsJsonArr.length > 0)
				{
					for(var i:int = 0; i < dsJsonArr.length; i++)
					{
						var di:PrtDsItem = new PrtDsItem();
						di.parseObj(dsJsonArr[i]);
						dsItems.push(di);
					}
				}
			}
			return dsItems;
		}
		
		/** 为向服务器提交上下文信息而写入URLVariables */
		public function writeURLVariables(params:URLVariables):void
		{
			encode();
			params.id = this.id;
			params.tpl_name = this.tpl_name;
			params.paper_type = this.paper_type;
			params.paper_mmWidth = this.paper_mmWidth;
			params.paper_mmHeight = this.paper_mmHeight;
			params.paper_landscape = this.paper_landscape;
			params.componentsJson = this.componentsJson;
			params.dsJson = this.dsJson;
		}
		
		public function copy():PrtTpl
		{
			var t:PrtTpl = new PrtTpl();
			t.id = this.id;
			t.tpl_name = this.tpl_name;
			t.prt_domain = this.prt_domain;
			t.prt_username = this.prt_username;
			t.prt_folder = this.prt_folder;
			t.paper_type = this.paper_type;
			t.paper_mmWidth = this.paper_mmWidth;
			t.paper_mmHeight = this.paper_mmHeight;
			t.paper_landscape = this.paper_landscape;
			t.componentsJson = this.componentsJson;
			t.dsItems = this.dsItems;
			return t;
		}
	}
}