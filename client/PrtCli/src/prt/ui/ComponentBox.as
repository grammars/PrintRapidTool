package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	import prt.component.MyComponent;
	import prt.component.MyLayout;
	import prt.events.DebugEvent;

	public class ComponentBox extends ViewWnd
	{
		private var addLayoutBtn:JPushButton;
		private var addLabelBtn:JPushButton;
		private var addTableBtn:JPushButton;
		private var addRectBtn:JPushButton;
		private var addImageBtn:JPushButton;
		private var addCodeBtn:JPushButton;
		private var addRichTableBtn:JPushButton;
		private var labelShowBtn:JPushButton;
		
		public function ComponentBox()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("ComponentBox");
			pane = uiPack.getCtrl("root");
			
			addLayoutBtn = uiPack.getPushButton("addLayoutBtn");
			addLabelBtn = uiPack.getPushButton("addLabelBtn");
			addTableBtn = uiPack.getPushButton("addTableBtn");
			addRectBtn = uiPack.getPushButton("addRectBtn");
			addImageBtn = uiPack.getPushButton("addImageBtn");
			addCodeBtn = uiPack.getPushButton("addCodeBtn");
			addRichTableBtn = uiPack.getPushButton("addRichTableBtn");
			labelShowBtn = uiPack.getPushButton("labelShowBtn");
			
			canDrag(true);
			canBringTop(true);
			
			addLayoutBtn.addEventListener(MouseEvent.CLICK, __addLayoutBtn);
			addLabelBtn.addEventListener(MouseEvent.CLICK, __addLabelBtn);
			addRectBtn.addEventListener(MouseEvent.CLICK, __addRectBtn);
			addTableBtn.addEventListener(MouseEvent.CLICK, __addTableBtn);
			addImageBtn.addEventListener(MouseEvent.CLICK, __addImageBtn);
			addCodeBtn.addEventListener(MouseEvent.CLICK, __addCodeBtn);
			addRichTableBtn.addEventListener(MouseEvent.CLICK, __addRichTableBtn);
			labelShowBtn.addEventListener(MouseEvent.CLICK, __labelShowBtn);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			if(pane)
			{
				pane.x = 0;
				pane.y = 0;
			}
		}
		
		private function __addLayoutBtn(e:MouseEvent):void
		{
			Ctx.ui.paperEdit.paper.addLayout();
		}
		
		private function __addLabelBtn(e:MouseEvent):void
		{
			Ctx.ui.paperEdit.paper.addLabel();
		}
		
		private function __addRectBtn(e:MouseEvent):void
		{
			Ctx.ui.paperEdit.paper.addRect();
		}
		
		private function __addTableBtn(e:MouseEvent):void
		{
			Ctx.ui.paperEdit.paper.addTable();
		}
		
		private function __addImageBtn(e:MouseEvent):void
		{
			Ctx.ui.paperEdit.paper.addImage();
		}
		
		private function __addCodeBtn(e:MouseEvent):void
		{
			Ctx.ui.paperEdit.paper.addCode();
		}
		
		private function __addRichTableBtn(e:MouseEvent):void
		{
			Ctx.ui.paperEdit.paper.addRichTable();
		}
		
		private function __labelShowBtn(e:MouseEvent):void
		{
			var event:DebugEvent = new DebugEvent(DebugEvent.DEBUG_MODE);
			DebugEvent.isDebug = !DebugEvent.isDebug;
			Ctx.observer.dispatchEvent(event);
		}
		
	}
}