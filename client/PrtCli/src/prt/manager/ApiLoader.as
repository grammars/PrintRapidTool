package prt.manager
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import prt.Ctx;
	import prt.ui.Res;
	import prt.vo.ErrorCodeSupport;

	public class ApiLoader
	{
		public static function get API_INIT_DATA():String { return Res.SRV_PATH+"initData.json"; }
		public static function get API_TPL_SAVE():String { return Res.SRV_PATH+"tpl/save.json"; }
		public static function get API_TPL_LIST():String { return Res.SRV_PATH+"tpl/list.json"; }
		public static function get API_TPL_DELETE():String { return Res.SRV_PATH+"tpl/delete.json"; }
		public static function get API_USER_UPDATE_ENV():String { return Res.SRV_PATH+"user/updateEnv.json"; }
		public static function get API_USER_UPDATE_CONFIG():String { return Res.SRV_PATH+"user/updateConfig.json"; }
		
		private var api:String;
		private var params:URLVariables;
		private var jsonObjHandler:Function;
		private var needAlert:Boolean;
		
		public function ApiLoader(api:String, params:URLVariables, jsonObjHandler:Function, needAlert:Boolean=false)
		{
			this.api = api;
			this.params = params;
			this.jsonObjHandler = jsonObjHandler;
			this.needAlert = needAlert;
		}
		
		public function load():ApiLoader
		{
			var ul:URLLoader = new URLLoader();
			ul.dataFormat = URLLoaderDataFormat.TEXT;
			var req:URLRequest = new URLRequest(api);
			req.data = params;
			req.method = URLRequestMethod.POST;
			ul.addEventListener(Event.COMPLETE, responseHandler);
			ul.load(req);
			return this;
		}
		
		private function responseHandler(e:Event):void
		{
			var ul:URLLoader = e.target as URLLoader;
			var jsonStr:String = ul.data as String;
			var jsonObj:Object = com.adobe.serialization.json.JSON.decode(jsonStr);
			if(needAlert)
			{
				if(jsonObj.errorcode==ErrorCodeSupport.EC_SUCC)
				{
					Ctx.ui.alertDialog.warn("恭喜", ""+jsonObj.errormsg);
				}
				else
				{
					Ctx.ui.alertDialog.warn("很遗憾", ""+jsonObj.errormsg);
				}
			}
			if(null != jsonObjHandler)
			{
				jsonObjHandler(jsonObj);
				jsonObjHandler = null;
			}
		}
	}
}