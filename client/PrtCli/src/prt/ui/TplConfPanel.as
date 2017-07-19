package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import prt.Conf;
	import prt.Ctx;
	import prt.PaperConf;
	import prt.vo.PrtTpl;

	public class TplConfPanel extends ViewWnd
	{
		private var nameLabel:JInputText;
		private var paperSelect:JComboBox;
		private var widthInput:JInputText;
		private var heightInput:JInputText;
		private var orientationSelect:JComboBox;
		private var applyBtn:JPushButton;
		private var saveBtn:JPushButton;
		private var dsBtn:JPushButton;
		
		public function TplConfPanel()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("TplConfPanel");
			pane = uiPack.getCtrl("root");
			
			nameLabel = uiPack.getInputText("nameLabel");
			paperSelect = uiPack.getComboBox("paperSelect");
			widthInput = uiPack.getInputText("widthInput");
			heightInput = uiPack.getInputText("heightInput");
			orientationSelect = uiPack.getComboBox("orientationSelect");
			applyBtn = uiPack.getPushButton("applyBtn");
			saveBtn = uiPack.getPushButton("saveBtn");
			dsBtn = uiPack.getPushButton("dsBtn");
			
			paperSelect.items = Conf.paperTypes;
			paperSelect.selectedIndex = 0;
			paperSelect.addEventListener(Event.SELECT, __paperSelected);
			orientationSelect.items = Conf.orientations;
			orientationSelect.selectedIndex = 0;
			
			canDrag(true);
			canBringTop(true);
			
			applyBtn.addEventListener(MouseEvent.CLICK, __applyBtn);
			saveBtn.addEventListener(MouseEvent.CLICK, __saveBtn);
			dsBtn.addEventListener(MouseEvent.CLICK, __dsBtn);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			if(pane)
			{
				pane.x = (Ctx.stage.stageWidth - pane.width);
				pane.y = 0;
			}
		}
		
		override public function show():void
		{
			paint();
			super.show();
		}
		
		private function paint():void
		{
			var tpl:PrtTpl = Ctx.editingTpl;
			nameLabel.text = tpl.tpl_name;
			paperSelect.selectedItem = tpl.paper_type;
			widthInput.text = tpl.paper_mmWidth.toString();
			heightInput.text = tpl.paper_mmHeight.toString();
			orientationSelect.selectedItem = tpl.paper_landscape ? Conf.ORIENTATION_H : Conf.ORIENTATION_V;
		}
		
		private function __paperSelected(e:Event):void
		{
			var pc:PaperConf = Conf.getPaper(paperSelect.selectedItem.toString());
			widthInput.text = pc.mmWidth.toString();
			heightInput.text = pc.mmHeight.toString();
			orientationSelect.selectedItem = pc.landscape ? Conf.ORIENTATION_H : Conf.ORIENTATION_V;
		}
		
		private function __applyBtn(e:MouseEvent):void
		{
			if(Ctx.editingTpl == null)
			{
				Ctx.ui.alertDialog.warn("友好的提醒", "请选择一个模版进行编辑或者新建一个模版进行编辑");
				return;	
			}
			Ctx.editingTpl.tpl_name = nameLabel.text;
			Ctx.editingTpl.paper_type = ""+paperSelect.selectedItem;
			Ctx.editingTpl.paper_mmWidth = parseFloat(widthInput.text);
			Ctx.editingTpl.paper_mmHeight = parseFloat(heightInput.text);
			Ctx.editingTpl.paper_landscape = orientationSelect.selectedItem == Conf.ORIENTATION_H;
			
			Ctx.ui.paperEdit.setup(Ctx.editingTpl, null);
		}
		
		private function __saveBtn(e:MouseEvent):void
		{
			Ctx.editor.saveTpl();
		}
		
		private function __dsBtn(e:MouseEvent):void
		{
			Ctx.ui.dsPanel.setup();
			Ctx.ui.dsPanel.show();
		}
	}
}