package prt.ui
{
	import com.anstu.jcommon.utils.StringUtils;
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JCheckBox;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import prt.Ctx;
	import prt.component.MyComponent;
	import prt.component.MyLayout;
	import prt.events.EditEvent;
	import prt.manager.EditAction;
	import prt.vo.PrtTpl;
	import prt.vo.tpl.PrtDsItem;

	public class CommonAttrBox extends ViewWnd
	{
		private var target:MyComponent;
		
		private var mmxInput:JInputText;
		private var mmyInput:JInputText;
		private var mmwInput:JInputText;
		private var mmhInput:JInputText;
		private var borderWidthInput:JInputText;
		private var dsNameInput:JInputText;
		
		private var forwardBtn:JPushButton;
		private var backwardBtn:JPushButton;
		private var copyBtn:JPushButton;
		private var cutBtn:JPushButton;
		private var pasteBtn:JPushButton;
		private var dragOpt:JCheckBox;
		private var fragmentBtn:JPushButton;
		private var applyBtn:JPushButton;
		private var deleteBtn:JPushButton;
		
		public function CommonAttrBox()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("CommonAttrBox");
			pane = uiPack.getCtrl("root");
			
			mmxInput = uiPack.getInputText("mmxInput");
			mmyInput = uiPack.getInputText("mmyInput");
			mmwInput = uiPack.getInputText("mmwInput");
			mmhInput = uiPack.getInputText("mmhInput");
			borderWidthInput = uiPack.getInputText("borderWidthInput");
			dsNameInput = uiPack.getInputText("dsNameInput");
			forwardBtn = uiPack.getPushButton("forwardBtn");
			backwardBtn = uiPack.getPushButton("backwardBtn");
			copyBtn = uiPack.getPushButton("copyBtn");
			cutBtn = uiPack.getPushButton("cutBtn");
			pasteBtn = uiPack.getPushButton("pasteBtn");
			dragOpt = uiPack.getCheckBox("dragOpt");
			fragmentBtn = uiPack.getPushButton("fragmentBtn");
			applyBtn = uiPack.getPushButton("applyBtn");
			deleteBtn = uiPack.getPushButton("deleteBtn");
			
			canBringTop(true);
			canDrag(true);
			
			forwardBtn.addEventListener(MouseEvent.CLICK, __forwardBtn);
			backwardBtn.addEventListener(MouseEvent.CLICK, __backwardBtn);
			copyBtn.addEventListener(MouseEvent.CLICK, __copyBtn);
			cutBtn.addEventListener(MouseEvent.CLICK, __cutBtn);
			pasteBtn.addEventListener(MouseEvent.CLICK, __pasteBtn);
			fragmentBtn.addEventListener(MouseEvent.CLICK, __fragmentBtn);
			applyBtn.addEventListener(MouseEvent.CLICK, __applyBtn);
			deleteBtn.addEventListener(MouseEvent.CLICK, __deleteBtn);
			dragOpt.addEventListener(Event.CHANGE, __dragOpt);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			if(pane)
			{
				pane.x = (Ctx.stage.stageWidth - pane.width);
				pane.y = 350;
			}
		}
		
		public function enter(c:MyComponent):void
		{
			this.target = c;
			c.addEventListener(EditEvent.CHANGED, __componentChanged);
			c.addEventListener(EditEvent.REMOVED, __componentRemoved);
			readFromComponent();
			show();
		}
		
		private function __componentChanged(e:EditEvent):void
		{
			if(this.target)
			{
				readFromComponent();
			}
		}
		
		private function __componentRemoved(e:EditEvent):void
		{
			if(this.target)
			{
				target = null;
				this.hide();
			}
		}
		
		private function readFromComponent():void
		{
			mmxInput.text = ""+target.mmx;
			mmyInput.text = ""+target.mmy;
			mmwInput.text = ""+target.mmw;
			mmhInput.text = ""+target.mmh;
			borderWidthInput.text = ""+target.borderWidth;
			dsNameInput.text = ""+target.dsName;
		}
		
		private function __forwardBtn(e:MouseEvent):void
		{
			this.target.bringForward();
		}
		
		private function __backwardBtn(e:MouseEvent):void
		{
			this.target.bringBackward();
		}
		
		private function __copyBtn(e:MouseEvent):void
		{
			var action:EditAction = new EditAction(this.target, this.target.layout);
			Ctx.editor.editAction = action;
		}
		
		private function __cutBtn(e:MouseEvent):void
		{
			var action:EditAction = new EditAction(this.target, this.target.layout);
			Ctx.editor.editAction = action;
			this.target.removeMe();
			e.stopPropagation();
		}
		
		private function __pasteBtn(e:MouseEvent):void
		{
			if(Ctx.editor.editAction == null)
			{
				Ctx.ui.alertDialog.warn("错误", "没有可以粘贴的对象，请先选择一个对象进行复制或剪切！");
			}
			else
			{
				if(!this.target.isLayout)
				{
					Ctx.ui.alertDialog.warn("错误", "只能粘贴到布局容器中！");
				}
				else
				{
					(this.target as MyLayout).addComponent(Ctx.editor.editAction.component);
				}
			}
			e.stopPropagation();
		}
		
		private function __fragmentBtn(e:MouseEvent):void
		{
			if(!Ctx.editingTpl)
			{
				Ctx.ui.alertDialog.warn("错误", "缺少正在编辑的模版！");
				return;
			}
			if(!Ctx.editor.currentComponent) 
			{
				Ctx.ui.alertDialog.warn("提示", "请选选择一个目标组件，然后再保存为组件片段！");
				return;
			}
			var dsArr:Array = [];
			findAllDs(Ctx.editor.currentComponent, dsArr);
			trace("dsArr=》", dsArr);
			function contains(name:String):Boolean
			{
				for(var d:int = 0; d < dsArr.length; d++)
				{
					if(dsArr[d] == name) { return true; }
				}
				return false;
			}
			var items:Vector.<PrtDsItem> = new Vector.<PrtDsItem>();
			for(var i:int = 0; i < Ctx.editingTpl.dsItems.length; i++)
			{
				var dsi:PrtDsItem = Ctx.editingTpl.dsItems[i];
				if(contains(dsi.name))
				{
					items.push(dsi);
				}
			}
			var dsJson:String = PrtTpl.ENCODE_DS(items);
			var componentJson:String = Ctx.builder.encode(Ctx.editor.currentComponent);
			trace("dsJson===>", dsJson);
			trace("componentJson===>", componentJson);
		}
		
		private function findAllDs(c:MyComponent, dsArr:Array):void
		{
			var i:int = 0;
			if(!StringUtils.isEmpty(c.dsName))
			{
				var exist:Boolean = false;
				for(i = 0; i < dsArr.length; i++)
				{
					if(dsArr[i] == c.dsName)
					{
						exist = true;
					}
				}
				if(!exist)
				{
					dsArr.push(c.dsName);
				}
			}
			if(c.isLayout)
			{
				var l:MyLayout = c as MyLayout;
				for(i = 0; i < l.components.length; i++)
				{
					findAllDs(l.components[i], dsArr);
				}
			}
		}
		
		private function __applyBtn(e:MouseEvent):void
		{
			target.mmx = parseFloat(mmxInput.text);
			target.mmy = parseFloat(mmyInput.text);
			target.mmw = parseFloat(mmwInput.text);
			target.mmh = parseFloat(mmhInput.text);
			target.borderWidth = parseFloat(borderWidthInput.text);
			target.dsName = dsNameInput.text;
			
			e.stopPropagation();
		}
		
		private function __deleteBtn(e:MouseEvent):void
		{
			Ctx.editor.removeSelectedComponent();
			e.stopPropagation();
		}
		
		private function __dragOpt(e:Event):void
		{
			Ctx.editor.dragable = dragOpt.selected;
		}
		
	}
}