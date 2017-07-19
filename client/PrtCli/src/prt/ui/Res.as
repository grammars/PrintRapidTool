package prt.ui
{	
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	
	public class Res
	{
		/** ui资源包最主要的命名空间 */
		public static const NS:String = "PrtUI";
		
		public static var RES_PATH:String;// = "http://ke110.com/page/"
		
		public static var SAME_DOMAIN:Boolean;// = true
		
		public static var SRV_PATH:String;// = "http://127.0.0.1/"
		
		/** 包装资源URL */
		public static function URL(ru:String):String
		{
			return RES_PATH + ru + "?v="+Math.random();
		}
		
		public static function URL_SWF_LIB(ru:String):String
		{
			if(Res.SAME_DOMAIN)
			{
				return ru + "?v="+Math.random();
			}
			return RES_PATH + ru + "?v="+Math.random();
		}
		
		/** 判断资源字符串是否属于空的情况 */
		public static function isNull(str:String):Boolean
		{
			if(str == null) { return true; }
			if(str == "") { return true; }
			if(str == "null" || str == "NULL" || str == "Null") { return true; }
			return false;
		}
		
		private static var loader:JLoader = new JLoader(4);
		
		public function Res()
		{
		}
		
		private static var taskCache:Dictionary = new Dictionary();
		
		public static function fillIcon(bmp:Bitmap, filePath:String, __onComplete:Function=null):void
		{
			var url:String = RES_PATH + "/icon/" + filePath;
			var task:ResTask = new ResTask(JLoadTask.TYPE_DISPLAY_CONTENT, url);
			task.__onComplete = __onComplete;
			task.bmpToFill = bmp;
			task.onComplete = __fillIcon;
			taskCache[task]
			loader.add(task);
			loader.start();
		}
		
		private static function __fillIcon(task:JLoadTask):void
		{
			var rt:ResTask = task as ResTask;
			if(rt)
			{
				if(rt.bmpToFill) { rt.bmpToFill.bitmapData = rt.result.getBmp().bitmapData; }
				if(rt.__onComplete != null) { rt.__onComplete(); }
			}
		}
		
	}
}