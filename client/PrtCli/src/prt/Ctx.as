package prt
{
	import com.adobe.serialization.json.JSON;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import prt.component.MyBuilder;
	import prt.events.Observer;
	import prt.manager.ConsoleManager;
	import prt.manager.CoreManager;
	import prt.manager.EditorManager;
	import prt.manager.RenderManager;
	import prt.ui.Res;
	import prt.ui.UILayer;
	import prt.vo.PrtTask;
	import prt.vo.PrtTpl;
	import prt.vo.PrtUser;

	public class Ctx
	{
		public static var docSprite:Sprite;
		public static var stage:Stage;
		public static var taskId:String;
		public static var conf:Conf = new Conf();
		public static var ui:UILayer;
		
		public static var observer:Observer = new Observer();
		
		public static var builder:MyBuilder = new MyBuilder();
		public static var core:CoreManager = new CoreManager();
		public static var console:ConsoleManager = new ConsoleManager();
		public static var render:RenderManager = new RenderManager();
		public static var editor:EditorManager = new EditorManager();
		
		/** 当前用户信息 */
		public static var user:PrtUser;
		/** 当前请求的任务 */
		public static var task:PrtTask;
		
		/** 正在编辑的模版数据 */
		public static var editingTpl:PrtTpl = new PrtTpl();
		/** 正在渲染的模版数据 */
		public static var renderingTpl:PrtTpl;
		
		public function Ctx()
		{
		}
		
		public static function initialize(docSp:Sprite):void
		{
			docSprite = docSp;
			stage = docSprite.stage;
			taskId = stage.loaderInfo.parameters["taskId"];
			Res.RES_PATH = stage.loaderInfo.parameters["resPath"];
			Res.SRV_PATH = stage.loaderInfo.parameters["srvPath"];
			Res.SAME_DOMAIN = stage.loaderInfo.parameters["sameDomain"];
			trace("taskId="+taskId + ", resPath="+Res.RES_PATH + ", srvPath=" + Res.SRV_PATH + ", sameDomain=" + Res.SAME_DOMAIN);
			ui = new UILayer();
			ui.initialize(__uiLoaded);
		}
		
		private static function __uiLoaded():void
		{
			docSprite.addChild(ui);
			
			render.initialize();
			editor.initialize();
			core.loadInitData();
		}
	}
}