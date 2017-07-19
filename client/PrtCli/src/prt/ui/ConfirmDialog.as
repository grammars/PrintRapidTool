package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import prt.Ctx;

	public class ConfirmDialog extends ViewWnd
	{
		private var titleLabel:JLabel;
		private var contentLabel:JLabel;
		private var sureBtn:JPushButton;
		private var cancelBtn:JPushButton;
		
		private var sureCallback:Function;
		private var cancelCallback:Function;
		
		public function ConfirmDialog()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("ConfirmDialog");
			pane = uiPack.getCtrl("root");
			
			titleLabel = uiPack.getLabel("titleLabel");
			contentLabel = uiPack.getLabel("contentLabel");
			sureBtn = uiPack.getPushButton("sureBtn");
			cancelBtn = uiPack.getPushButton("cancelBtn");
			
			canDrag(true);
			canBringTop(true);
			
			sureBtn.addEventListener(MouseEvent.CLICK, __sureBtnClick);
			Ctx.stage.addEventListener(KeyboardEvent.KEY_DOWN, __keyDown);
		}
		
		public function warn(title:String, content:String, sureCallback:Function=null, cancelCallback:Function=null):void
		{
			this.sureCallback = sureCallback;
			this.cancelCallback = cancelCallback;
			titleLabel.text = title;
			contentLabel.text = content;
			show();
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			putCentre();
		}
		
		private function __sureBtnClick(e:MouseEvent):void
		{
			this.hide();
			if(null != this.sureCallback)
			{
				this.sureCallback();
				this.sureCallback = null;
			}
		}
		
		private function __cancelBtnClick(e:MouseEvent):void
		{
			handleCallback();
		}
		
		private function __keyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.ENTER)
			{
				handleCallback();
			}
		}
		
		private function handleCallback():void
		{
			this.hide();
			if(null != this.sureCallback)
			{
				this.sureCallback();
				this.sureCallback = null;
			}	
		}
	}
}