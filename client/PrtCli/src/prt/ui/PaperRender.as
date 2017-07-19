package prt.ui
{
	import com.anstu.jui.build.JFactory;
	
	import flash.events.Event;
	
	import prt.Conf;
	import prt.Ctx;
	import prt.component.MyPaper;
	import prt.vo.PrtTpl;

	public class PaperRender extends ViewWnd
	{
		public var paper:MyPaper;
		
		public function PaperRender()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("PaperRender");
			pane = uiPack.getCtrl("root");
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
		
		public function setup(tpl:PrtTpl, requestParam:Object):void
		{
			this.pane.setSize(Conf.mm2px(tpl.paper_mmWidth), Conf.mm2px(tpl.paper_mmHeight));
			
			paper = Ctx.builder.decode(tpl.componentsJson, false) as MyPaper;
			paper.setup(tpl, requestParam);
			pane.addChild(paper);
		}
	}
}