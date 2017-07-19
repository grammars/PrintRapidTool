package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	import prt.component.MyImage;
	
	public class ImageAttrBox extends ViewWnd
	{
		private var target:MyImage;
		
		private var dsNameInput:JInputText;
		private var colNameInput:JInputText;
		private var srcSelect:JComboBox;
		private var mmwInput:JInputText;
		private var mmhInput:JInputText;
		private var urlInput:JInputText;
		private var applyBtn:JPushButton;
		private var deleteBtn:JPushButton;
		
		public function ImageAttrBox()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("ImageAttrBox");
			pane = uiPack.getCtrl("root");
			
			dsNameInput = uiPack.getInputText("dsNameInput");
			colNameInput = uiPack.getInputText("colNameInput");
			srcSelect = uiPack.getComboBox("srcSelect");
			mmwInput = uiPack.getInputText("mmwInput");
			mmhInput = uiPack.getInputText("mmhInput");
			urlInput = uiPack.getInputText("urlInput");
			applyBtn = uiPack.getPushButton("applyBtn");
			deleteBtn = uiPack.getPushButton("deleteBtn");
			
			srcSelect.items = MyImage.SRC_NAMES;
			
			canBringTop(true);
			canDrag(true);
			
			applyBtn.addEventListener(MouseEvent.CLICK, __applyBtn);
			deleteBtn.addEventListener(MouseEvent.CLICK, __deleteBtn);
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
		
		public function enter(c:MyImage):void
		{
			this.target = c;
			
			dsNameInput.text = target.dsName;
			colNameInput.text = target.colName;
			mmwInput.text = ""+target.mmw;
			mmhInput.text = ""+target.mmh;
			srcSelect.selectedIndex = MyImage.indexFromSrc(target.src);
			urlInput.text = target.url;
			
			show();
		}
		
		private function __applyBtn(e:MouseEvent):void
		{
			target.mmw = parseFloat(mmwInput.text);
			target.mmh = parseFloat(mmhInput.text);
			target.src = MyImage.srcFromIndex(srcSelect.selectedIndex);
			target.dsName = dsNameInput.text;
			target.colName = colNameInput.text;
			target.url = urlInput.text;
			
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
	}
}