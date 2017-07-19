package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	import prt.component.MyRect;

	public class RectAttrBox extends ViewWnd
	{
		private var target:MyRect;
		
		private var mmwInput:JInputText;
		private var mmhInput:JInputText;
		private var thicknessInput:JInputText;
		private var applyBtn:JPushButton;
		private var deleteBtn:JPushButton;
		private var closeBtn:JPushButton;
		
		public function RectAttrBox()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("RectAttrBox");
			pane = uiPack.getCtrl("root");
			
			mmwInput = uiPack.getInputText("mmwInput");
			mmhInput = uiPack.getInputText("mmhInput");
			thicknessInput = uiPack.getInputText("thicknessInput");
			applyBtn = uiPack.getPushButton("applyBtn");
			deleteBtn = uiPack.getPushButton("deleteBtn");
			closeBtn = uiPack.getPushButton("closeBtn");
			
			canBringTop(true);
			canDrag(true);
			
			applyBtn.addEventListener(MouseEvent.CLICK, __applyBtn);
			deleteBtn.addEventListener(MouseEvent.CLICK, __deleteBtn);
			closeBtn.addEventListener(MouseEvent.CLICK, __closeBtn);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			if(pane)
			{
				pane.x = 0;
				pane.y = (Ctx.stage.stageHeight - pane.height);
			}
		}
		
		public function enter(c:MyRect):void
		{
			this.target = c;
			
			mmwInput.text = ""+target.mmw;
			mmhInput.text = ""+target.mmh;
			thicknessInput.text = ""+target.thickness;
				
			show();
		}
		
		private function __applyBtn(e:MouseEvent):void
		{
			target.mmw = parseFloat(mmwInput.text);
			target.mmh = parseFloat(mmhInput.text);
			target.thickness = parseInt(thicknessInput.text);
			
			e.stopPropagation();
		}
		
		private function __deleteBtn(e:MouseEvent):void
		{
			Ctx.ui.confirmDialog.warn("请确认", "您确定要删除吗？删除后不可取消", doDelete);
			e.stopPropagation();
		}
		
		private function doDelete():void
		{
			target.removeMe();
			target = null;
			this.hide();
		}
		
		private function __closeBtn(e:MouseEvent):void
		{
			this.hide();
		}
	}
}