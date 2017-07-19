package prt.ui
{
	import com.anstu.jui.build.JFactory;
	
	import flash.events.Event;
	
	import prt.Conf;
	import prt.Ctx;
	import prt.component.MyPaper;
	import prt.vo.PrtTpl;

	public class PaperEdit extends ViewWnd
	{
		public var paper:MyPaper;
	
		private var tpl:PrtTpl;
		private var requestParam:Object
		
		private static const MARGIN:int = 10;
		
		public function PaperEdit()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("PaperEdit");
			pane = uiPack.getCtrl("root");
			
			canDrag(true);
			canBringTop(true);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			if(pane)
			{
				pane.x = (Ctx.stage.stageWidth - pane.width)/2;
				pane.y = (Ctx.stage.stageHeight - pane.height)/2;
			}
		}
		
		public function setPaper(p:MyPaper):void
		{
			if(this.paper != null && this.paper.parent) { this.paper.parent.removeChild(this.paper); }
			this.paper = p;
			this.paper.x = this.paper.y = MARGIN;
			this.pane.addChild(this.paper);
		}
		
		public function cleanPaper():void
		{
			if(paper && paper.parent)
			{
				paper.parent.removeChild(paper);
			}
			paper = null;
		}
		
		public function setup(tpl:PrtTpl, requestParam:Object):void
		{
			if(tpl != null) { this.tpl = tpl; }
			if(requestParam != null) { this.requestParam = requestParam; }
			this.pane.setSize(Conf.mm2px(this.tpl.paper_mmWidth)+MARGIN*2, Conf.mm2px(this.tpl.paper_mmHeight)+MARGIN*2);
			
			if(paper == null)
			{
				paper = new MyPaper();
				pane.addChild(paper);
			}
			
			this.paper.setup(tpl, this.requestParam);
		}
		
	}
}