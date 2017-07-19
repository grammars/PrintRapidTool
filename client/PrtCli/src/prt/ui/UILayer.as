package prt.ui
{
	import com.anstu.jload.JLoadEvent;
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.build.pack.PackItem;
	import com.anstu.jui.build.pack.PackTool;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	
	import prt.Ctx;

	public class UILayer extends Sprite
	{
		private var templatesItems:Vector.<PackItem>;
		private var docsItems:Vector.<PackItem>;
		private var assetsXml:XML;
		private var assetsDomain:ApplicationDomain;
		
		private var uiLoadedCallback:Function;
		
		public var consoleFrame:ConsoleFrame;
		public var tplPanel:TplPanel;
		public var menuBar:MenuBar;
		public var addTplDialog:AddTplDialog;
		public var paperEdit:PaperEdit;
		public var alertDialog:AlertDialog;
		public var confirmDialog:ConfirmDialog;
		public var componentBox:ComponentBox;
		public var tplConfPanel:TplConfPanel;
		public var commonAttrBox:CommonAttrBox;
		public var codeAttrBox:CodeAttrBox;
		public var imageAttrBox:ImageAttrBox;
		public var tableAttrBox:TableAttrBox;
		public var labelAttrBox:LabelAttrBox;
		public var layoutAttrBox:LayoutAttrBox;
		public var richTableAttrBox:RichTableAttrBox;
		public var rectAttrBox:RectAttrBox;
		public var envEditor:EnvEditor;
		public var dsPanel:DsPanel;
		
		public var renderCanvas:RenderCanvas;
		
		private var loading:Loader;
		
		public function UILayer()
		{
		}
		
		public function initialize(uiLoadedCallback:Function):void
		{
			this.uiLoadedCallback = uiLoadedCallback;
			
			loading = new Loader();
			loading.load(new URLRequest(Res.URL("ui/loading.swf")));
			
			showLoading();
			
			loadUiTxt();
		}
		
		private function loadUiTxt():void
		{
			trace("loadUiTxt");
			var jl:JLoader = new JLoader();
			var templatesTask:JLoadTask = new JLoadTask(JLoadTask.TYPE_DATA_BINARY, Res.URL("ui/"+Res.NS+"_templates.zlib"), Res.SAME_DOMAIN);
			templatesTask.onComplete = __templatesLoaded;
			var docsTask:JLoadTask = new JLoadTask(JLoadTask.TYPE_DATA_BINARY, Res.URL("ui/"+Res.NS+"_docs.zlib"), Res.SAME_DOMAIN);
			docsTask.onComplete = __docsLoaded;
			jl.add(templatesTask);
			jl.add(docsTask);
			jl.addEventListener(JLoadEvent.FINISH, __txtLoaded);
			jl.start();
		}
		
		private function __templatesLoaded(task:JLoadTask):void
		{
			trace("__templatesLoaded");
			templatesItems = PackTool.decode(task.result.getBinary());
		}
		
		private function __docsLoaded(task:JLoadTask):void
		{
			trace("__docsLoaded");
			docsItems = PackTool.decode(task.result.getBinary());
		}
		
		private function __txtLoaded(e:JLoadEvent):void
		{
			(e.target as JLoader).removeEventListener(JLoadEvent.FINISH, __txtLoaded);
			JFactory.regTemplates(templatesItems, Res.NS);
			JFactory.regDocs(docsItems, Res.NS);
			
			//setupView();
			
			var jl:JLoader = new JLoader();
			var assetsXmlTask:JLoadTask = new JLoadTask(JLoadTask.TYPE_DATA_BINARY, Res.URL("ui/"+Res.NS+"_assets.zlib"), Res.SAME_DOMAIN);
			assetsXmlTask.onComplete = __assetsXmlLoaded;
			var assetsUrl:String = Res.URL_SWF_LIB("ui/"+Res.NS+"_assets.swf");
			var assetsSwfTask:JLoadTask = new JLoadTask(JLoadTask.TYPE_CLASS_DOMAIN, assetsUrl, Res.SAME_DOMAIN);
			assetsSwfTask.onComplete = __assetsSwfLoaded;
			jl.add(assetsXmlTask);
			jl.add(assetsSwfTask);
			jl.addEventListener(JLoadEvent.FINISH, __assetsLoaded);
			jl.start();
		}
		
		private function __assetsXmlLoaded(task:JLoadTask):void
		{
			trace("__assetsXmlLoaded");
			var bytes:ByteArray = task.result.getBinary();
			bytes.uncompress();
			var content:String = bytes.readMultiByte(bytes.bytesAvailable, "UTF-8");
			assetsXml = XML(content);
		}
		
		private function __assetsSwfLoaded(task:JLoadTask):void
		{
			trace("__assetsSwfLoaded");
			assetsDomain = task.result.getDomain();
		}
		
		private function __assetsLoaded(e:JLoadEvent):void
		{
			trace("__assetsLoaded");
			(e.target as JLoader).removeEventListener(JLoadEvent.FINISH, __assetsSwfLoaded);
			JResource.add(assetsXml, assetsDomain);
			
			setupView();
			uiLoadedCallback();
		}
		
		/** 设置View */
		private function setupView():void
		{
			renderCanvas = new RenderCanvas();
			
			consoleFrame = new ConsoleFrame();
			//consoleFrame.show();
			tplPanel = new TplPanel();
			menuBar = new MenuBar();
			menuBar.show();
			addTplDialog = new AddTplDialog();
			paperEdit = new PaperEdit();
			alertDialog = new AlertDialog();
			confirmDialog = new ConfirmDialog();
			componentBox = new ComponentBox();
			tplConfPanel = new TplConfPanel();
			commonAttrBox = new CommonAttrBox();
			codeAttrBox = new CodeAttrBox();
			imageAttrBox = new ImageAttrBox();
			tableAttrBox = new TableAttrBox();
			labelAttrBox = new LabelAttrBox();
			layoutAttrBox = new LayoutAttrBox();
			richTableAttrBox = new RichTableAttrBox();
			rectAttrBox = new RectAttrBox();
			envEditor = new EnvEditor();
			dsPanel = new DsPanel();
		}
		
		public function showLoading():void
		{
			Masker.show();
			loading.x = (Ctx.stage.stageWidth-320)/2;
			loading.y = (Ctx.stage.stageHeight-240)/2;
			Masker.addChild(loading);
		}
		
		public function hideLoading():void
		{
			Masker.hide();
			if(loading.parent) { loading.parent.removeChild(loading); }
		}
		
	}
}