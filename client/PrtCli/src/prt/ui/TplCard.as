package prt.ui
{
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import prt.Ctx;
	import prt.vo.PrtTpl;

	public class TplCard extends ViewWnd
	{
		private var data:PrtTpl;
		
		private var nameLabel:JLabel;
		private var editBtn:JPushButton;
		private var deleteBtn:JPushButton;
		
		public function TplCard()
		{
			super();
		}
		
		private var overStatus:Boolean=false;
		private var overFill:DisplayObject;
		private var defaultFill:DisplayObject;
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("TplCard");
			pane = uiPack.getCtrl("root");
			
			nameLabel = uiPack.getLabel("nameLabel");
			editBtn = uiPack.getPushButton("editBtn");
			deleteBtn = uiPack.getPushButton("deleteBtn");
			
			pane.buttonMode = true;
			pane.addEventListener(MouseEvent.MOUSE_OVER, __paneOver);
			pane.addEventListener(MouseEvent.MOUSE_OUT, __paneOut);
			
			overFill = JResource.getBmp("color_263238$png", "PrtUI");
			overFill.width = pane.width;
			overFill.height = pane.height;
			defaultFill = JResource.getBmp("color_787878$png", "PrtUI");
			
			pane.addEventListener(MouseEvent.CLICK, __paneClick);
			editBtn.addEventListener(MouseEvent.CLICK, __editBtn);
			deleteBtn.addEventListener(MouseEvent.CLICK, __deleteBtn);
		}
		
		private function get THIS():JPanel
		{
			return pane as JPanel;
		}
		
		private function __paneOver(e:MouseEvent):void
		{
			if(!overStatus)
			{
				THIS.fillBackground(overFill);
				overStatus = true;
			}
		}
		
		private function __paneOut(e:MouseEvent):void
		{
			if(overStatus)
			{
				THIS.fillBackground(defaultFill);
				overStatus = false;
			}
		}
		
		private function __paneClick(e:MouseEvent):void
		{
			Ctx.ui.showLoading();
			
			setTimeout(goRender, 300);
		}
		
		private function goRender():void
		{
			Ctx.renderingTpl = this.data.copy();
			Ctx.render.startRender();
			
			Ctx.render.enter();
			Ctx.editor.exit();
		}
		
		private function __editBtn(e:MouseEvent):void
		{
			Ctx.ui.showLoading();
			e.stopPropagation();
			setTimeout(goEdit, 300);
		}
		
		private function goEdit():void
		{
			Ctx.editingTpl = this.data.copy();
			Ctx.editor.startEdit();
			
			Ctx.render.exit();
			Ctx.editor.enter();
		}
		
		private function __deleteBtn(e:MouseEvent):void
		{
			Ctx.ui.confirmDialog.warn("删除确认", "您真的要删除这个打印模版吗？删除之后将无法恢复！请慎重！！！", exeDeleteTpl);
			e.stopPropagation();
		}
		
		private function exeDeleteTpl():void
		{
			Ctx.core.deleteTpl(data.id);
		}
		
		public function setup(data:PrtTpl):void
		{
			this.data = data;
			nameLabel.text = data.tpl_name;
		}
	}
}