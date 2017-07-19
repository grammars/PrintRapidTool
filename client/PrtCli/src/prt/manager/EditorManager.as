package prt.manager
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	import prt.Conf;
	import prt.Ctx;
	import prt.component.MyCode;
	import prt.component.MyComponent;
	import prt.component.MyImage;
	import prt.component.MyLabel;
	import prt.component.MyLayout;
	import prt.component.MyPaper;
	import prt.component.MyRect;
	import prt.component.MyRichTable;
	import prt.component.MyTable;
	import prt.events.DebugEvent;
	import prt.ui.Res;
	import prt.vo.ErrorCodeSupport;

	public class EditorManager
	{
		/** 是否可以拖拽控件 */
		public var dragable:Boolean = true;
		
		private var _currentComponent:MyComponent;
		public function set currentComponent(value:MyComponent):void
		{
			_currentComponent = value;
		}
		public function get currentComponent():MyComponent { return _currentComponent; }
		
		private var _editAction:EditAction;
		public function set editAction(value:EditAction):void
		{
			_editAction = value;
		}
		public function get editAction():EditAction { return _editAction; }
		
		public function EditorManager()
		{
		}
		
		public function initialize():void
		{
			Ctx.stage.addEventListener(KeyboardEvent.KEY_DOWN, __keyDown);
		}
		
		private function __keyDown(e:KeyboardEvent):void
		{
			if(e.target is TextField) { return; }
			var step:Number = Conf.px2mm(1);
			if(e.shiftKey)
			{
				step = 3;
			}
			switch(e.keyCode)
			{
			case Keyboard.LEFT:
				if(e.ctrlKey)
				{
					switchComponent(-1);
				}
				else
				{
					if(currentComponent) { currentComponent.mmx -= step; }
				}
				break;
			case Keyboard.RIGHT:
				if(e.ctrlKey)
				{
					switchComponent(+1);
				}
				else
				{
					if(currentComponent) { currentComponent.mmx += step; }
				}
				break;
			case Keyboard.UP:
				if(e.ctrlKey)
				{
					switchLayout();
				}
				else
				{
					if(currentComponent) { currentComponent.mmy -= step; }
				}
				break;
			case Keyboard.DOWN:
				if(e.ctrlKey)
				{
					switchChild();
				}
				else
				{
					if(currentComponent) { currentComponent.mmy += step; }
				}
				break;
			case Keyboard.DOWN:
				if(currentComponent) { currentComponent.mmy += step; }
				break;
			case Keyboard.A:
				if(currentComponent) { currentComponent.mmw -= step; }
				break;
			case Keyboard.D:
				if(currentComponent) { currentComponent.mmw += step; }
				break;
			case Keyboard.W:
				if(currentComponent) { currentComponent.mmh -= step; }
				break;
			case Keyboard.S:
				if(currentComponent) { currentComponent.mmh += step; }
				break;
			case Keyboard.DELETE:
				removeSelectedComponent();
				break;
			}
			e.stopPropagation();
		}
		
		/** 进入编辑模式 */
		public function enter():void
		{
			if(Ctx.editingTpl == null)
			{
				Ctx.ui.alertDialog.warn("警告", "请先选中一个需要编辑的模版");
				return;
			}
			Ctx.ui.paperEdit.setup(Ctx.editingTpl, Ctx.task.reqList[0]);
			Ctx.ui.paperEdit.show();
			Ctx.ui.componentBox.show();
			Ctx.ui.tplConfPanel.show();
			Ctx.ui.commonAttrBox.show();
			
			Ctx.ui.hideLoading();
		}
		
		/** 退出编辑模式 */
		public function exit():void
		{
			Ctx.ui.paperEdit.hide();
			Ctx.ui.componentBox.hide();
			Ctx.ui.tplConfPanel.hide();
			Ctx.ui.commonAttrBox.hide();
			Ctx.ui.layoutAttrBox.hide();
			Ctx.ui.labelAttrBox.hide();
			Ctx.ui.tableAttrBox.hide();
			Ctx.ui.imageAttrBox.hide();
			Ctx.ui.codeAttrBox.hide();
			Ctx.ui.richTableAttrBox.hide();
		}
		
		public function startEdit():void
		{
			trace("Ctx.editingTpl.componentsJson="+Ctx.editingTpl.componentsJson);
			var paper:MyPaper = Ctx.builder.decode(Ctx.editingTpl.componentsJson, true) as MyPaper;
			paper.setup(Ctx.editingTpl, Ctx.task.reqList[0]);
			Ctx.ui.paperEdit.setPaper(paper);
		}
		
		/** 设置当前编辑组件 */
		public function setCurrentComponent(c:MyComponent):void
		{
			Ctx.ui.commonAttrBox.enter(c);
			if(Ctx.editor.currentComponent == c) { return; }
			Ctx.editor.currentComponent = c;
			
			Ctx.ui.layoutAttrBox.hide();
			Ctx.ui.labelAttrBox.hide();
			Ctx.ui.tableAttrBox.hide();
			Ctx.ui.imageAttrBox.hide();
			Ctx.ui.codeAttrBox.hide();
			Ctx.ui.rectAttrBox.hide();
			
			switch(c.type)
			{
			case Conf.COMPONENT_LAYOUT:
				Ctx.ui.layoutAttrBox.enter(c as MyLayout);
				break;
			case Conf.COMPONENT_LABEL:
				Ctx.ui.labelAttrBox.enter(c as MyLabel);
				break;
			case Conf.COMPONENT_TABLE:
				Ctx.ui.tableAttrBox.enter(c as MyTable);
				break;
			case Conf.COMPONENT_IMAGE:
				Ctx.ui.imageAttrBox.enter(c as MyImage);
				break;
			case Conf.COMPONENT_CODE:
				Ctx.ui.codeAttrBox.enter(c as MyCode);
				break;
			case Conf.COMPONENT_RECT:
				Ctx.ui.rectAttrBox.enter(c as MyRect);
				break;
			case Conf.COMPONENT_RICH_TABLE:
				Ctx.ui.richTableAttrBox.enter(c as MyRichTable);
				break;
			case Conf.COMPONENT_RICH_TABLE_ITEM:
				Ctx.ui.layoutAttrBox.enter(c as MyLayout);
				break;
			}
			
			var event:DebugEvent = new DebugEvent(DebugEvent.COMPONENT_SELECT);
			event.component = c;
			Ctx.observer.dispatchEvent(event);
		}
		
		public function saveTpl():void
		{
			Ctx.editingTpl.componentsJson = Ctx.builder.encode(Ctx.ui.paperEdit.paper);
			
			var params:URLVariables = new URLVariables();
			Ctx.task.writeURLVariables(params);
			Ctx.editingTpl.writeURLVariables(params);
			new ApiLoader(ApiLoader.API_TPL_SAVE, params, saveTplHandler, true).load();
		}
		
		private function saveTplHandler(jsonObj:Object):void
		{
			Ctx.core.loadTplList();
		}
		
		public function updateUserEnv():void
		{
			Ctx.user.encode();
			var params:URLVariables = new URLVariables();
			params.env = Ctx.user.env;
			params.username = Ctx.user.username;
			params.password = Ctx.user.password;
			new ApiLoader(ApiLoader.API_USER_UPDATE_ENV, params, null, true).load();
		}
		
		
		/** 移除选中的控件 */
		public function removeSelectedComponent():void
		{
			if(Ctx.editor.currentComponent)
			{
				Ctx.ui.confirmDialog.warn("请确认", "您确定要删除吗？删除后不可取消", exeRemoveComponent);
			}
		}
		
		private function exeRemoveComponent():void
		{
			trace("exeRemoveComponent," + Ctx.editor.currentComponent);
			if(Ctx.editor.currentComponent)
			{
				Ctx.editor.currentComponent.removeMe();
				Ctx.editor.currentComponent = null;
			}
		}
		
		/** 切换到下一个控件  */
		public function switchComponent(step:int):void
		{
			if(Ctx.editor.currentComponent && Ctx.editor.currentComponent.layout)
			{
				var curInd:int = Ctx.editor.currentComponent.layout.getComponentIndex(Ctx.editor.currentComponent);
				trace("curInd=",curInd);
				curInd += step;
				trace("   curInd=",curInd);
				if(curInd < 0)
				{
					curInd = Ctx.editor.currentComponent.layout.components.length-1;
					trace("curInd <= 0    curInd=",curInd);
				}
				else
				{
					curInd = curInd % Ctx.editor.currentComponent.layout.components.length;
					trace("curInd > 0    curInd=",curInd);
				}
				setCurrentComponent( Ctx.editor.currentComponent.layout.components[curInd] );
			}
		}
		
		/** 切换到父容器 */
		public function switchLayout():void
		{
			if(Ctx.editor.currentComponent && Ctx.editor.currentComponent.layout)
			{
				setCurrentComponent( Ctx.editor.currentComponent.layout );
			}
		}
		
		/** 切换到父容器 */
		public function switchChild():void
		{
			if(Ctx.editor.currentComponent && Ctx.editor.currentComponent is MyLayout)
			{
				var l:MyLayout = (Ctx.editor.currentComponent) as MyLayout;
				if(l.components.length > 0)
				{
					setCurrentComponent( l.components[0] );
				}
			}
		}
		
	}
}