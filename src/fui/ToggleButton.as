package fui 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author lizhi http://game-develop.net/
	 */
	public class ToggleButton extends Button
	{
		private var _toogle:Boolean=false;
		public function ToggleButton(mc:MovieClip) 
		{
			super(mc);
			mc.addEventListener(MouseEvent.CLICK, mc_click);
		}
		
		private function mc_click(e:MouseEvent):void 
		{
			toogle = !toogle;
		}
		
		public function get toogle():Boolean 
		{
			return _toogle;
		}
		
		public function set toogle(value:Boolean):void 
		{
			_toogle = value;
			updateButtonEffect();
			dispatchEvent(new Event(Event.CHANGE));
			
		}
		override protected function updateButtonEffect():void {
			if (!mc.mouseEnabled) {
				setState(4);
			}else if (toogle) {
				setState(2);
			}
			else if (isOver&&isPressed) {
				setState(2);
			}else if (isOver&&!isPressed) {
				setState(1);
			}else {
					setState(0);
			}
		}
		
	}

}