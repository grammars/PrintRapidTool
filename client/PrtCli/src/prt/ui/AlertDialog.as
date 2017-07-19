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

	public class AlertDialog extends ViewWnd
	{
		private var titleLabel:JLabel;
		private var contentLabel:JLabel;
		private var sureBtn:JPushButton;
		
		public function AlertDialog()
		{
			super();
		}
		
		private var callback:Function;
		
		public function warn(title:String, content:String, callback:Function=null):void
		{
			this.callback = callback;
			titleLabel.text = title;
			contentLabel.text = content;
			show();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("AlertDialog");
			pane = uiPack.getCtrl("root");
			
			titleLabel = uiPack.getLabel("titleLabel");
			contentLabel = uiPack.getLabel("contentLabel");
			sureBtn = uiPack.getPushButton("sureBtn");
			
			canDrag(true);
			canBringTop(true);
			
			sureBtn.addEventListener(MouseEvent.CLICK, __sureBtnClick);
			Ctx.stage.addEventListener(KeyboardEvent.KEY_DOWN, __keyDown);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			putCentre();
		}
		
		private function __sureBtnClick(e:MouseEvent):void
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
			if(null != this.callback)
			{
				this.callback();
				this.callback = null;
			}
		}
		
	}
}