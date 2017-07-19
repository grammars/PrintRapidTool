package prt.manager
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class DsLoader
	{	
		private var ancestor:int;
		private var dsName:String;
		private var api:String;
		private var params:URLVariables;
		private var jsonObjHandler:Function;
		
		public function DsLoader(ancestor:int, dsName:String, api:String, params:URLVariables, jsonObjHandler:Function)
		{
			this.ancestor = ancestor;
			this.dsName = dsName;
			this.api = api;
			this.params = params;
			this.jsonObjHandler = jsonObjHandler;
		}
		
		public function load():DsLoader
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
			if(null != jsonObjHandler)
			{
				jsonObjHandler(ancestor, dsName, jsonObj);
				jsonObjHandler = null;
			}
		}
	}
}