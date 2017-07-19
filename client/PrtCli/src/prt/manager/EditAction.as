package prt.manager
{
	import prt.component.MyComponent;
	import prt.component.MyLayout;

	public class EditAction
	{
		public var component:MyComponent;
		/** 之前的layout */
		public var lastLayout:MyLayout;
		
		public function EditAction(component:MyComponent, lastLayout:MyLayout)
		{
			this.component = component;
			this.lastLayout = lastLayout;
		}
	}
}