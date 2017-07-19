package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	import prt.events.InitDataEvent;
	import prt.manager.InitData;

	public class MenuBar extends ViewWnd
	{
		private var domainLabel:JLabel;
		private var folderLabel:JLabel;
		private var usernameLabel:JLabel;
		private var renderModeBtn:JPushButton;
		private var editModeBtn:JPushButton;
		private var envBtn:JPushButton;
		private var x1Btn:JPushButton;
		private var x2Btn:JPushButton;
		private var x4Btn:JPushButton;
		
		public function MenuBar()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("MenuBar");
			pane = uiPack.getCtrl("root");
			
			domainLabel = uiPack.getLabel("domainLabel");
			folderLabel = uiPack.getLabel("folderLabel");
			usernameLabel = uiPack.getLabel("usernameLabel");
			renderModeBtn = uiPack.getPushButton("renderModeBtn");
			editModeBtn = uiPack.getPushButton("editModeBtn");
			envBtn = uiPack.getPushButton("envBtn");
			x1Btn = uiPack.getPushButton("x1Btn");
			x2Btn = uiPack.getPushButton("x2Btn");
			x4Btn = uiPack.getPushButton("x4Btn");
			
			canDrag(true);
			canBringTop(true);
			
			renderModeBtn.addEventListener(MouseEvent.CLICK, __renderModeBtn);
			editModeBtn.addEventListener(MouseEvent.CLICK, __editModeBtn);
			renderModeBtn.disabled = editModeBtn.disabled = envBtn.disabled = true;
			envBtn.addEventListener(MouseEvent.CLICK, __envBtn);
			x1Btn.addEventListener(MouseEvent.CLICK, __x1Btn);
			x2Btn.addEventListener(MouseEvent.CLICK, __x2Btn);
			x4Btn.addEventListener(MouseEvent.CLICK, __x4Btn);
			
			Ctx.observer.addEventListener(InitDataEvent.INIT, initDataHandler);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			if(pane)
			{
				pane.x = (Ctx.stage.stageWidth - pane.width) / 2;
				pane.y = 0;
			}
		}
		
		private function initDataHandler(e:InitDataEvent):void
		{
			setup();
		}
		
		private function __renderModeBtn(e:MouseEvent):void
		{
			Ctx.editor.exit();
			Ctx.render.enter();
		}
		
		private function __editModeBtn(e:MouseEvent):void
		{
			Ctx.render.exit();
			Ctx.editor.enter();
		}
		
		private function __envBtn(e:MouseEvent):void
		{
			Ctx.ui.envEditor.show();
		}
		
		private function __x1Btn(e:MouseEvent):void
		{
			Ctx.core.saveX(1);
		}
		
		private function __x2Btn(e:MouseEvent):void
		{
			Ctx.core.saveX(2);
		}
		
		private function __x4Btn(e:MouseEvent):void
		{
			Ctx.core.saveX(4);
		}
		
		private function setup():void
		{
			renderModeBtn.disabled = editModeBtn.disabled = envBtn.disabled = false;
			trace("domainLabel",domainLabel," Ctx.user", Ctx.user);
			domainLabel.text = Ctx.user.domain;
			folderLabel.text = Ctx.task.prt_folder;
			usernameLabel.text = Ctx.user.nickname;
		}
		
	}
}