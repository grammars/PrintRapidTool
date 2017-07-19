package prt.ui
{
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	import prt.vo.table.PrtTableCol;

	public class TableColLine extends ViewWnd
	{
		private var owner:TableAttrBox;
		public var data:PrtTableCol;
		
		private var colKeyLabel:JLabel;
		private var colNameLabel:JLabel;
		private var deleteBtn:JPushButton;
		private var forwardBtn:JPushButton;
		private var backwardBtn:JPushButton;
		
		public function TableColLine(owner:TableAttrBox)
		{
			super();
			this.owner = owner;
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("TableColLine");
			pane = uiPack.getCtrl("root");
			
			colKeyLabel = uiPack.getLabel("colKeyLabel");
			colNameLabel = uiPack.getLabel("colNameLabel");
			deleteBtn = uiPack.getPushButton("deleteBtn");
			forwardBtn = uiPack.getPushButton("forwardBtn");
			backwardBtn = uiPack.getPushButton("backwardBtn");
			
			deleteBtn.addEventListener(MouseEvent.CLICK, __deleteBtn);
			forwardBtn.addEventListener(MouseEvent.CLICK, __forwardBtn);
			backwardBtn.addEventListener(MouseEvent.CLICK, __backwardBtn);
		}
		
		private function __deleteBtn(e:MouseEvent):void
		{
			Ctx.ui.confirmDialog.warn("警告", "您真的要删除这个字段设置吗？", doDelete);
		}
		
		private function doDelete():void
		{
			this.owner.removeCol(this);
		}
		
		public function setup(data:PrtTableCol):void
		{
			this.data = data;
			colKeyLabel.text = data.key;
			colNameLabel.text = data.name;
		}
		
		private function __forwardBtn(e:MouseEvent):void
		{
			this.owner.moveCol(this, true);
		}
		
		private function __backwardBtn(e:MouseEvent):void
		{
			this.owner.moveCol(this, false);
		}
	}
}