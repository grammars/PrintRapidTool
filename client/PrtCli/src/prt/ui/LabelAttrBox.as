package prt.ui
{	
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JTextArea;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import prt.Conf;
	import prt.Ctx;
	import prt.component.MyLabel;
	
	public class LabelAttrBox extends ViewWnd
	{
		private var target:MyLabel;
		
		private var typeSelect:JComboBox;
		private var textInput:JTextArea;
		private var colKeyInput:JInputText;
		private var sizeInput:JInputText;
		private var alignSelect:JComboBox;
		private var applyBtn:JPushButton;
		private var closeBtn:JPushButton;
		
		public function LabelAttrBox()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("LabelAttrBox");
			pane = uiPack.getCtrl("root");
			
			typeSelect = uiPack.getComboBox("typeSelect");
			textInput = uiPack.getTextArea("textInput");
			colKeyInput = uiPack.getInputText("colKeyInput");
			sizeInput = uiPack.getInputText("sizeInput");
			alignSelect = uiPack.getComboBox("alignSelect");
			applyBtn = uiPack.getPushButton("applyBtn");
			closeBtn = uiPack.getPushButton("closeBtn");
			
			typeSelect.items = MyLabel.DATA_TYPE_NAMES;
			alignSelect.items = Conf.ALIGN_NAMES;
			
			canBringTop(true);
			canDrag(true);
			
			applyBtn.addEventListener(MouseEvent.CLICK, __applyBtn);
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
		
		public function enter(c:MyLabel):void
		{
			this.target = c;
			typeSelect.selectedIndex = MyLabel.indexFromDataType(this.target.dataType);
			textInput.text = this.target.text;
			colKeyInput.text = this.target.colKey;
			sizeInput.text = "" + this.target.size;
			alignSelect.selectedIndex = Conf.indexFromAlign(this.target.align);
			show();
		}
		
		private function __applyBtn(e:MouseEvent):void
		{
			this.target.dataType = MyLabel.dataTypeFromIndex(typeSelect.selectedIndex);
			this.target.text = textInput.text;
			this.target.colKey = colKeyInput.text;
			this.target.size = parseFloat(sizeInput.text);
			this.target.align = Conf.alignFromIndex(alignSelect.selectedIndex);
			this.target.paint();
		}
		
		private function __closeBtn(e:MouseEvent):void
		{
			this.hide();
		}
	}
}