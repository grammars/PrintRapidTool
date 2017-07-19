package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JScrollPanel;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	import prt.events.InitDataEvent;
	import prt.vo.user.PrtEnvItem;

	public class EnvEditor extends ViewWnd
	{
		private var scroll:JScrollPanel;
		private var closeBtn:JPushButton;
		private var showBtn:JPushButton;
		private var addPanel:JPanel;
		private var keyInput:JInputText;
		private var valueInput:JInputText;
		private var addBtn:JPushButton;
		private var cancelAddBtn:JPushButton;
		
		public function EnvEditor()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("EnvEditor");
			pane = uiPack.getCtrl("root");
			
			scroll = uiPack.getScrollPanel("scroll");
			closeBtn = uiPack.getPushButton("closeBtn");
			showBtn = uiPack.getPushButton("showBtn");
			addPanel = uiPack.getPanel("addPanel");
			keyInput = uiPack.getInputText("keyInput");
			valueInput = uiPack.getInputText("valueInput");
			addBtn = uiPack.getPushButton("addBtn");
			cancelAddBtn = uiPack.getPushButton("cancelAddBtn");
			
			canBringTop(true);
			canDrag(true);
			
			closeBtn.addEventListener(MouseEvent.CLICK, __closeBtn);
			addPanel.visible = false;
			showBtn.addEventListener(MouseEvent.CLICK, __showBtn);
			addBtn.addEventListener(MouseEvent.CLICK, __addBtn);
			cancelAddBtn.addEventListener(MouseEvent.CLICK, __cancelAddBtn);
			
			Ctx.observer.addEventListener(InitDataEvent.INIT, initDataHandler);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			if(pane)
			{
				pane.x = 100;
				pane.y = (Ctx.stage.stageHeight - pane.height) / 2;
			}
		}
		
		private function initDataHandler(e:InitDataEvent):void
		{
			setup();
		}
		
		public function setup():void
		{
			presentEnvItems();
		}
		
		private function presentEnvItems():void
		{
			scroll.clearContent();
			for(var i:int = 0; i < Ctx.user.envItems.length; i++)
			{
				var line:EnvItemLine = new EnvItemLine();
				line.setup(Ctx.user.envItems[i]);
				line.x = 0;
				line.y = i * 110;
				scroll.addChild(line.pane);
			}
		}
		
		private function __closeBtn(e:MouseEvent):void
		{
			this.hide();
		}
		
		private function __showBtn(e:MouseEvent):void
		{
			addPanel.visible = true;
		}
		
		private function __addBtn(e:MouseEvent):void
		{
			var ei:PrtEnvItem = new PrtEnvItem();
			ei.key = keyInput.text;
			ei.value = valueInput.text;
			Ctx.user.envItems.push(ei);
			presentEnvItems();
			Ctx.editor.updateUserEnv();
			this.hide();
		}
		
		private function __cancelAddBtn(e:MouseEvent):void
		{
			addPanel.visible = false;
		}
	}
}