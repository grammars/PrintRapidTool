package prt.manager
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import prt.Conf;
	import prt.Ctx;
	import prt.events.InitDataEvent;
	import prt.events.TplEvent;
	import prt.ui.Res;
	import prt.vo.PrtTpl;

	/** 核心管理器 */
	public class CoreManager
	{
		public function CoreManager()
		{
		}
		
		public function loadInitData():void 
		{
			var params:URLVariables = new URLVariables();
			params.taskId = Ctx.taskId;
			params.testids = ["ID-0","ID-1"];//测试着玩的
			new ApiLoader(ApiLoader.API_INIT_DATA, params, initDataHandler).load();
		}
		
		private function initDataHandler(jsonObj:Object):void
		{
			var data:InitData = new InitData();
			data.parseObj(jsonObj);
			if(data.isFail())
			{
				Ctx.ui.alertDialog.warn("异常", data.errormsg);
				return;
			}
			Ctx.user = data.user;
			Ctx.task = data.task;
			
			Conf.X = Ctx.user.cfg.X;
			
			var event:InitDataEvent = new InitDataEvent(InitDataEvent.INIT);
			event.data = data;
			Ctx.observer.dispatchEvent(event);
			
			Ctx.render.enter();
			
			Ctx.ui.hideLoading();
		}
		
		
		/** 加载模板列表 */
		public function loadTplList():void
		{
			var params:URLVariables = new URLVariables();
			Ctx.task.writeURLVariables(params);
			new ApiLoader(ApiLoader.API_TPL_LIST, params, tplListHandler).load();
		}
		
		private function tplListHandler(jsonObj:Object):void
		{
			if(jsonObj.list && jsonObj.list.length > 0)
			{
				var list:Vector.<PrtTpl> = parseTplList(jsonObj.list);
				var event:TplEvent = new TplEvent(TplEvent.LIST);
				event.list = list;
				Ctx.observer.dispatchEvent(event);
			}
		}
		
		public function parseTplList(tplObjList:Array):Vector.<PrtTpl>
		{
			var list:Vector.<PrtTpl> = new Vector.<PrtTpl>();
			for(var i:int = 0; i < tplObjList.length; i++)
			{
				var tpl:PrtTpl = new PrtTpl();
				tpl.parseObj(tplObjList[i]);
				list.push(tpl);
			}
			return list;
		}
		
		/** 请求服务器删除模版
		 * @param tplId 模版id */
		public function deleteTpl(tplId:int):void
		{
			var params:URLVariables = new URLVariables();
			params.tplId = tplId;
			Ctx.task.writeURLVariables(params);
			new ApiLoader(ApiLoader.API_TPL_DELETE, params, tplDeleteHandler, true).load();
		}
		
		private function tplDeleteHandler(jsonObj:Object):void
		{
			loadTplList();
		}
		
		public function saveX(value:Number):void
		{
			var params:URLVariables = new URLVariables();
			Ctx.user.cfg.X = value;
			Ctx.user.encode();
			params.config = Ctx.user.config;
			params.username = Ctx.user.username;
			params.password = Ctx.user.password;
			new ApiLoader(ApiLoader.API_USER_UPDATE_CONFIG, params, saveXHandler, true).load();
		}
		
		private function saveXHandler(jsonObj:Object):void
		{
			Conf.X = Ctx.user.cfg.X;
		}
		
	}
}