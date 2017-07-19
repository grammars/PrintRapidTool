package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import prt.Ctx;

	public class AddTplDialog extends ViewWnd
	{
		private var closeBtn:JPushButton;
		private var createBtn:JPushButton;
		private var nameInput:JInputText;
		
		public function AddTplDialog()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("AddTplDialog");
			pane = uiPack.getCtrl("root");
			
			closeBtn = uiPack.getPushButton("closeBtn");
			createBtn = uiPack.getPushButton("createBtn");
			nameInput = uiPack.getInputText("nameInput");
			
			canDrag(true);
			canBringTop(true);
			
			closeBtn.addEventListener(MouseEvent.CLICK, __closeBtnClick);
			createBtn.addEventListener(MouseEvent.CLICK, __createBtnClick);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			putCentre();
		}
		
		private function __closeBtnClick(e:MouseEvent):void { hide(); }
		
		private function __createBtnClick(e:MouseEvent):void
		{
			Ctx.editingTpl.clear();
			Ctx.editingTpl.tpl_name = nameInput.text;
			Ctx.ui.paperEdit.cleanPaper();
			Ctx.render.exit();
			Ctx.editor.enter();
		}
	}
}