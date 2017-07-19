package prt.component
{
	import com.anstu.jcommon.utils.StringUtils;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import prt.Conf;

	public class MyImage extends MyComponent
	{
		private var image:Loader;
		/** 当前用于加载图片的URL */
		private var urlForLoader:String;
		
		private static const SRC_DATASOURCE:String = "datasource";//
		private static const SRC_URL:String = "url";//
		private static const SRC_FILE:String = "file";//
		public static function get SRC_NAMES():Array { return ["从数据源获取", "网络链接","打印时提交"]; }
		public static function srcFromIndex(i:int):String
		{
			if(0 == i) return SRC_DATASOURCE;
			if(1 == i) return SRC_URL;
			if(2 == i) return SRC_FILE;
			return null;
		}
		public static function indexFromSrc(value:String):int
		{
			if(SRC_DATASOURCE == value) return 0;
			if(SRC_URL == value) return 1;
			if(SRC_FILE == value) return 2;
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
		
		protected var _url:String;
		public function set url(value:String):void
		{
			this._url = value;
			invalidate();
		}
		public function get url():String
		{
			return this._url;
		}
		
		public function MyImage()
		{
			super();
			this.type = Conf.COMPONENT_IMAGE;
			this.componentColor = 0x121212;
			this.mmw = 24;
			this.mmh = 16;
			invalidate();
		}
		
		override public function encode(obj:Object):void
		{
			super.encode(obj);
			obj.src = this.src;
			obj.colName = this.colName;
			obj.url = this.url;
		}
		
		override public function decode(obj:Object):void
		{
			super.decode(obj);
			this.src = obj.src;
			this.colName = obj.colName;
			this.url = obj.url;
		}
		
		override public function paint():void
		{
			super.paint();
			
			if(SRC_URL == this.src)
			{
				urlForLoader = this.url;
				loadByUrl();
			}
		}
		
		private function loadByUrl():void
		{
			if(image && image.parent) { image.parent.removeChild(image); }
			if(StringUtils.isEmpty(urlForLoader))
			{
				return;
			}
			image = new Loader();
			//image.alpha = 0.2;
			var req:URLRequest = new URLRequest(Conf.env(urlForLoader));
			image.contentLoaderInfo.addEventListener(Event.COMPLETE, __imageLoaded);
			image.load(req);
			this.addChild(image);
		}
		
		private function __imageLoaded(e:Event):void
		{
			if(mmw > 0)
			{
				image.width = Conf.mm2px(mmw);
			}
			else
			{
				mmw = Conf.px2mm(image.width);
			}
			if(mmh > 0)
			{
				image.height = Conf.mm2px(mmh);
			}
			else
			{
				mmh = Conf.px2mm(image.height);
			}
			this.drawBound();
			this.noticeLayoutRepaint();
		}
		
		override public function handleDs(jsonObj:Object):void
		{
			if(SRC_DATASOURCE == this.src)
			{
				if(jsonObj && !StringUtils.isEmpty(this.colName)  && !StringUtils.isEmpty(jsonObj[this.colName]))
				{
					urlForLoader = jsonObj[this.colName];
					loadByUrl();
				}
			}
		}
	}
}