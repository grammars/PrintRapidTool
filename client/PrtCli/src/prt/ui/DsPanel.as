package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JScrollPanel;
	import com.anstu.jui.controls.JTextArea;
	
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	import prt.vo.tpl.PrtDsItem;

	public class DsPanel extends ViewWnd
	{
		private var scroll:JScrollPanel;
		private var showPanelBtn:JPushButton;
		private var addPanel:JPanel;
		private var dsNameInput:JInputText;
		private var dsApiInput:JTextArea;
		private var addBtn:JPushButton;
		private var cancelAddBtn:JPushButton;
		private var closeBtn:JPushButton;
		
		public function DsPanel()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("DsPanel");
			pane = uiPack.getCtrl("root");
			
			scroll = uiPack.getScrollPanel("scroll");
			showPanelBtn = uiPack.getPushButton("showPanelBtn");
			addPanel = uiPack.getPanel("addPanel");
			dsNameInput = uiPack.getInputText("dsNameInput");
			dsApiInput = uiPack.getTextArea("dsApiInput");
			addBtn = uiPack.getPushButton("addBtn");
			cancelAddBtn = uiPack.getPushButton("cancelAddBtn");
			closeBtn = uiPack.getPushButton("closeBtn");
			
			canDrag(true);
			canBringTop(true);
			
			addPanel.visible = false;
			
			showPanelBtn.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{ addPanel.visible=true; });
			addBtn.addEventListener(MouseEvent.CLICK, __addBtn);
			cancelAddBtn.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{ addPanel.visible=false; });
			closeBtn.addEventListener(MouseEvent.CLICK, __closeBtn);
		}
		
		private function __addBtn(e:MouseEvent):void
		{
			var di:PrtDsItem = new PrtDsItem();
			di.name = dsNameInput.text;
			di.api = dsApiInput.text;
			Ctx.editingTpl.dsItems.push(di);
			presentDsItems();
			this.hide();
		}
		
		private function __closeBtn(e:MouseEvent):void { this.hide(); }
		
		public function setup():void
		{
			presentDsItems();
		}
		
		private function presentDsItems():void
		{
			scroll.clearContent();
			for(var i:int = 0; i < Ctx.editingTpl.dsItems.length; i++)
			{
				var line:DsItemLine = new DsItemLine();
				line.setup(Ctx.editingTpl.dsItems[i]);
				line.x = 1;
				line.y = 1+i * line.height;
				scroll.addChild(line.pane);
			}
		}
	}
}