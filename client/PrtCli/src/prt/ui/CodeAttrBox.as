package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JTextArea;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	import prt.component.MyCode;

	public class CodeAttrBox extends ViewWnd
	{
		private var target:MyCode;
		
		private var dsNameInput:JInputText;
		private var colNameInput:JInputText;
		private var srcSelect:JComboBox;
		private var ctSelect:JComboBox;
		private var textInput:JTextArea;
		private var applyBtn:JPushButton;
		
		
		
		public function CodeAttrBox()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("CodeAttrBox");
			pane = uiPack.getCtrl("root");
			
			dsNameInput = uiPack.getInputText("dsNameInput");
			colNameInput = uiPack.getInputText("colNameInput");
			srcSelect = uiPack.getComboBox("srcSelect");
			ctSelect = uiPack.getComboBox("ctSelect");
			textInput = uiPack.getTextArea("textInput");
			applyBtn = uiPack.getPushButton("applyBtn");
			
			srcSelect.items = MyCode.SRC_NAMES;
			ctSelect.items = MyCode.CT_NAMES;
			
			canBringTop(true);
			canDrag(true);
			
			applyBtn.addEventListener(MouseEvent.CLICK, __applyBtn);
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
		
		public function enter(c:MyCode):void
		{
			this.target = c;
			dsNameInput.text = target.dsName;
			colNameInput.text = target.colName;
			srcSelect.selectedIndex = MyCode.indexFromSrc(target.src);
			ctSelect.selectedIndex = MyCode.indexFromCt(target.ct);
			textInput.text = target.text;
			
			show();
		}
		
		private function __applyBtn(e:MouseEvent):void
		{
			target.src = MyCode.srcFromIndex(srcSelect.selectedIndex);
			target.ct = MyCode.ctFromIndex(ctSelect.selectedIndex);
			target.dsName = dsNameInput.text;
			target.colName = colNameInput.text;
			target.text = textInput.text;
			
			e.stopPropagation();
		}
	}
}