package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.*;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	import prt.ui.ViewWnd;
	
	public class ConsoleFrame extends ViewWnd
	{	
		private var output:JTextArea;
		
		/** 控制台窗体 */
		public function ConsoleFrame()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("ConsoleFrame");
			pane = uiPack.getCtrl("root");
			
			output = uiPack.getTextArea("output");
			
			//canDrag(true);
			//canBringTop(true);
		}
		
		
		private function __bagTab0Click(e:MouseEvent):void { }
		private function __bagTab1Click(e:MouseEvent):void { }
		private function __bagTab2Click(e:MouseEvent):void { }
		
		private function __bagTab0Over(e:MouseEvent):void
		{
			//if(Drag.getInstance().isDragging()) { iconField.switchPage(0); bagTab0.selected = true; }
		}
		private function __bagTab1Over(e:MouseEvent):void
		{
			//if(Drag.getInstance().isDragging()) { iconField.switchPage(1); bagTab1.selected = true; }
		}
		private function __bagTab2Over(e:MouseEvent):void
		{
			//if(Drag.getInstance().isDragging()) { iconField.switchPage(2); bagTab2.selected = true; }
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			if(pane)
			{
				pane.x = (Ctx.stage.stageWidth - pane.width);
				pane.y = (Ctx.stage.stageHeight - pane.height);
			}
		}
		
		public function write(content:String):void
		{
			this.output.text = content;
		}
	}
}