package fui 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	/**
	 * ...
	 * @author lizhi http://game-develop.net/
	 */
	public class TabPanel 
	{
		private var target:DisplayObjectContainer;
		public var tabbar:Tabbar;
		private var children:Array = [];
		private var _selected:int;
		public function TabPanel(target:DisplayObjectContainer,tabbar:Tabbar=null) 
		{
			this.tabbar = tabbar;
			this.target = target;
			if(tabbar)
			tabbar.addEventListener(Event.SELECT, tabbar_select);
		}
		
		private function tabbar_select(e:Event):void 
		{
			update();
		}
		
		private function update():void {
			var current:DisplayObject = children[tabbar?tabbar.selected:selected];
			if (current&&current.parent==null) target.addChild(current);
			for each(var dis:DisplayObject in children) {
				if (dis != current && dis.parent) dis.parent.removeChild(dis);
			}
		}
		
		public function add(index:int, display:DisplayObject):void {
			children[index] = display;
			update();
		}
		
		public function getPanel(index:int):DisplayObject {
			return children[index];
		}
		
		public function get selected():int 
		{
			return _selected;
		}
		
		public function set selected(value:int):void 
		{
			_selected = value;
			update();
		}
	}

}