package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JScrollPanel;
	
	import flash.display.Sprite;
	
	import prt.Ctx;
	
	public class RenderCanvas extends ViewWnd
	{
		public var scroll:JScrollPanel;
		
		public function RenderCanvas()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("RenderCanvas");
			pane = uiPack.getCtrl("root");
			
			scroll = uiPack.getScrollPanel("scroll");
			
			canDrag(true);
			canBringTop(true);
			
			setPaneWidth(600);
			setPaneHeight(Ctx.stage.stageHeight - 100);
		}
		
		public function removePaperRenderAll():void
		{
			scroll.clearContent();
		}
		
		public function addPaperRender(pr:PaperRender):void
		{
			setPaneWidth(pr.pane.width);
			setPaneHeight(Ctx.stage.stageHeight - 100);
			scroll.addChild(pr.pane);
		}
		
		private function setPaneWidth(value:int):void
		{
			pane.width = value+20;
			scroll.width = value;
		}
		
		private function setPaneHeight(value:int):void
		{
			pane.height = value;
			scroll.height = value-50;
		}
		
	}
}