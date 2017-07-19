package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JTextArea;
	
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	import prt.vo.tpl.PrtDsItem;

	public class DsItemLine extends ViewWnd
	{
		private var dsNameInput:JInputText;
		private var dsApiInput:JTextArea;
		private var deleteBtn:JPushButton;
		
		private var data:PrtDsItem;
		
		public function DsItemLine()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("DsItemLine");
			pane = uiPack.getCtrl("root");
			
			dsNameInput = uiPack.getInputText("dsNameInput");
			dsApiInput = uiPack.getTextArea("dsApiInput");
			deleteBtn = uiPack.getPushButton("deleteBtn");
			
			deleteBtn.addEventListener(MouseEvent.CLICK, __deleteBtn);
		}
		
		public function setup(data:PrtDsItem):void
		{
			this.data = data;
			dsNameInput.text = data.name;
			dsApiInput.text = data.api;
		}
		
		private function __deleteBtn(e:MouseEvent):void
		{
			for(var i:int = 0; i < Ctx.editingTpl.dsItems.length; i++)
			{
				if(Ctx.editingTpl.dsItems[i] == data)
				{
					Ctx.editingTpl.dsItems.splice(i, 1);
					Ctx.ui.dsPanel.setup();
					break;
				}
			}
		}
	}
}