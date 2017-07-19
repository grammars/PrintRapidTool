package prt.ui
{
	import com.anstu.jcommon.utils.StringUtils;
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JTextArea;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	import prt.component.MyCode;
	import prt.component.MyImage;
	import prt.component.MyLabel;
	import prt.component.MyLayout;
	import prt.component.MyRect;
	import prt.component.MyRichTable;
	import prt.component.rt.MyRichTableItem;

	public class RichTableAttrBox extends ViewWnd
	{
		private var target:MyRichTable;
		
		private var addLabelBtn:JPushButton;
		private var addImageBtn:JPushButton;
		private var addRectBtn:JPushButton;
		private var addCodeBtn:JPushButton;
		private var closeBtn:JPushButton;
		private var canvas:JPanel;
		private var dsNameInput:JInputText;
		private var ldirSelect:JComboBox;
		private var applyBtn:JPushButton;
		
		private var item:MyRichTableItem = new MyRichTableItem();
		
		public function RichTableAttrBox()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("RichTableAttrBox");
			pane = uiPack.getCtrl("root");
			
			addLabelBtn = uiPack.getPushButton("addLabelBtn");
			addImageBtn = uiPack.getPushButton("addImageBtn");
			addRectBtn = uiPack.getPushButton("addRectBtn");
			addCodeBtn = uiPack.getPushButton("addCodeBtn");
			closeBtn = uiPack.getPushButton("closeBtn");
			canvas = uiPack.getPanel("canvas");
			dsNameInput = uiPack.getInputText("dsNameInput");
			ldirSelect = uiPack.getComboBox("ldirSelect");
			applyBtn = uiPack.getPushButton("applyBtn");
			
			ldirSelect.items = MyLayout.LDIR_NAMES;
			
			canBringTop(true);
			canDrag(true);
			
			addLabelBtn.addEventListener(MouseEvent.CLICK, __addLabelBtn);
			addImageBtn.addEventListener(MouseEvent.CLICK, __addImageBtn);
			addRectBtn.addEventListener(MouseEvent.CLICK, __addRectBtn);
			addCodeBtn.addEventListener(MouseEvent.CLICK, __addCodeBtn);
			closeBtn.addEventListener(MouseEvent.CLICK, __closeBtn);
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
		
		public function enter(c:MyRichTable):void
		{
			this.target = c;
			if(item && item.parent) { item.parent.removeChild(item); }
			if(StringUtils.isEmpty(this.target.itemJson))
			{
				item = new MyRichTableItem();
			}
			else
			{
				item = Ctx.builder.decode(this.target.itemJson, true) as MyRichTableItem;
			}
			item.editable = false;
			item.x = 0;
			item.y = 0;
			canvas.addChild(item);
			dsNameInput.text = this.target.dsName;
			ldirSelect.selectedIndex = MyLayout.indexFromLdir(target.ldir);
			show();
		}
		
		private function __addLabelBtn(e:MouseEvent):void
		{
			var c:MyLabel = new MyLabel();
			this.item.addComponent(c);
		}
		
		private function __addImageBtn(e:MouseEvent):void
		{
			var c:MyImage = new MyImage();
			this.item.addComponent(c);
		}
		
		private function __addRectBtn(e:MouseEvent):void
		{
			var c:MyRect = new MyRect();
			this.item.addComponent(c);
		}
		
		private function __addCodeBtn(e:MouseEvent):void
		{
			var c:MyCode = new MyCode();
			this.item.addComponent(c);
		}
		
		private function __closeBtn(e:MouseEvent):void
		{
			this.hide();
		}
		
		private function __applyBtn(e:MouseEvent):void
		{
			this.item.paint();
			this.target.dsName = dsNameInput.text;
			this.target.ldir = MyLayout.ldirFromIndex(ldirSelect.selectedIndex);
			this.target.itemJson = Ctx.builder.encode(item);
			this.target.paint();
		}
	}
}