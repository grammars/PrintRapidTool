package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	import prt.vo.user.PrtEnvItem;

	public class EnvItemLine extends ViewWnd
	{
		private var keyLabel:JLabel;
		private var valueLabel:JLabel;
		private var deleteBtn:JPushButton;
		
		private var data:PrtEnvItem;
		
		public function EnvItemLine()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("EnvItemLine");
			pane = uiPack.getCtrl("root");
			
			keyLabel = uiPack.getLabel("keyLabel");
			valueLabel = uiPack.getLabel("valueLabel");
			deleteBtn = uiPack.getPushButton("deleteBtn");
			
			deleteBtn.addEventListener(MouseEvent.CLICK, __deleteBtn);
		}
		
		public function setup(data:PrtEnvItem):void
		{
			this.data = data;
			keyLabel.text = data.key;
			valueLabel.text = data.value;
		}
		
		private function __deleteBtn(e:MouseEvent):void
		{
			for(var i:int = 0; i < Ctx.user.envItems.length; i++)
			{
				if(Ctx.user.envItems[i] == data)
				{
					Ctx.user.envItems.splice(i, 1);
					Ctx.ui.envEditor.setup();
					break;
				}
			}
		}
	}
}