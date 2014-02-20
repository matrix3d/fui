package fui 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author lizhi http://game-develop.net/
	 */
	public class ToggleButtonGroup extends EventDispatcher
	{
		public var btns:Array;
		
		public function ToggleButtonGroup(btns:Array) 
		{
			this.btns = btns;
			for each(var btn:ToggleButton in btns) {
				btn.addEventListener(Event.CHANGE, btn_change);
			}
		}
		
		public function add(btn:ToggleButton):void {
			btns.push(btn);
			btn.addEventListener(Event.CHANGE, btn_change);
		}
		
		private function btn_change(e:Event):void 
		{
			var btn:ToggleButton = e.currentTarget as ToggleButton;
			if (btn.toogle) {
				for each(var btn2:ToggleButton in btns) {
					if (btn2 != btn&&btn2.toogle) {
						btn2.toogle = false;
					}
				}
				dispatchEvent(e);
			}else {
				var flag:Boolean = true;
				for each(btn2 in btns) {
					if (btn2.toogle) {
						flag = false;
						break;
					}
				}
				if (flag) {
					btn.toogle = true;
				}
			}
			
		}
		
	}

}