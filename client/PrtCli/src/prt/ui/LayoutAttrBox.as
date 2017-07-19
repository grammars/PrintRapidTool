package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JRadioButton;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	import prt.component.MyLayout;
	
	public class LayoutAttrBox extends ViewWnd
	{
		private var target:MyLayout;
		
		private var mmwInput:JInputText;
		private var mmhInput:JInputText;
		private var lmodeSelect:JComboBox;
		private var ldirSelect:JComboBox;
		private var wrapBtn:JRadioButton;
		private var applyBtn:JPushButton;
		private var deleteBtn:JPushButton;
		private var closeBtn:JPushButton;
		
		public function LayoutAttrBox()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("LayoutAttrBox");
			pane = uiPack.getCtrl("root");
			
			mmwInput = uiPack.getInputText("mmwInput");
			mmhInput = uiPack.getInputText("mmhInput");
			lmodeSelect = uiPack.getComboBox("lmodeSelect");
			ldirSelect = uiPack.getComboBox("ldirSelect");
			wrapBtn = uiPack.getRadioButton("wrapBtn");
			applyBtn = uiPack.getPushButton("applyBtn");
			deleteBtn = uiPack.getPushButton("deleteBtn");
			closeBtn = uiPack.getPushButton("closeBtn");
			
			lmodeSelect.items = MyLayout.LMODE_NAMES;
			ldirSelect.items = MyLayout.LDIR_NAMES;
			
			canBringTop(true);
			canDrag(true);
			
			applyBtn.addEventListener(MouseEvent.CLICK, __applyBtn);
			deleteBtn.addEventListener(MouseEvent.CLICK, __deleteBtn);
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
		
		public function enter(c:MyLayout):void
		{
			this.target = c;
			
			mmwInput.text = ""+target.mmw;
			mmhInput.text = ""+target.mmh;
			lmodeSelect.selectedIndex = MyLayout.indexFromLmode(target.lmode);
			ldirSelect.selectedIndex = MyLayout.indexFromLdir(target.ldir);
			wrapBtn.selected = target.wrap;
			
			show();
		}
		
		private function __applyBtn(e:MouseEvent):void
		{
			target.mmw = parseFloat(mmwInput.text);
			target.mmh = parseFloat(mmhInput.text);
			target.lmode = MyLayout.lmodeFromIndex(lmodeSelect.selectedIndex);
			target.ldir = MyLayout.ldirFromIndex(ldirSelect.selectedIndex);
			target.wrap = wrapBtn.selected;
			
			e.stopPropagation();
		}
		
		private function __deleteBtn(e:MouseEvent):void
		{
			Ctx.ui.confirmDialog.warn("请确认", "您确定要删除吗？删除后不可取消", doDelete);
			e.stopPropagation();
		}
		
		private function doDelete():void
		{
			target.removeMe();
			target = null;
			this.hide();
		}
		
		private function __closeBtn(e:MouseEvent):void
		{
			this.hide();
		}
	}
}