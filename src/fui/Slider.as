package fui 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author lizhi
	 */
	public class Slider extends EventDispatcher
	{
		public var mc:MovieClip;
		public var bglength:Number;
		private var _length:Number;
		public var sliderbtn:Button;
		private var bg:Sprite;
		
		private var sy:Number;
		private var smy:Number;
		private var _scaleY:Number=1;
		public function Slider(mc:MovieClip) 
		{
			this.mc = mc;
			bglength = mc.rect_mc.height
			bg = mc.bg_mc;
			sliderbtn = new Button(mc.slider_btn_mc);
			sliderbtn.mc.addEventListener(MouseEvent.MOUSE_DOWN, mc_mouseDown);
			mc.addEventListener(MouseEvent.MOUSE_WHEEL, mc_mouseWheel);
		}
		
		private function mc_mouseWheel(e:MouseEvent):void 
		{
			value -= e.delta/100;
		}
		
		private function mc_mouseDown(e:MouseEvent):void 
		{
			if (mc.stage) {
				mc.stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
				mc.stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUp);
				sy = sliderbtn.mc.y;
				smy = mc.stage.mouseY;
			}
		}
		
		private function stage_mouseUp(e:MouseEvent):void 
		{
			if (mc.stage) {
				mc.stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMove);
				mc.stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUp);
			}
		}
		
		private function stage_mouseMove(e:MouseEvent):void 
		{
			if (mc.stage) {
				var ty:Number = mc.stage.mouseY - smy + sy;
				if (ty < 0) ty = 0;
				if (ty > length*_scaleY) ty = length*_scaleY;
				if (ty != sliderbtn.mc.y) {
					sliderbtn.mc.y = ty;
					dispatchEvent(new Event(Event.CHANGE));
				}
			}
		}
		
		
		public function get value():Number 
		{
			return sliderbtn.mc.y/length/_scaleY;
		}
		
		public function set value(v:Number):void 
		{
			setValueNoSendEvent(v);
			if (value!=v) {
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		public function setValueNoSendEvent(v:Number):void {
			v =Math.max(0, Math.min(1, v));
			var ty:Number = v * length*_scaleY;
			sliderbtn.mc.y = ty;
			
		}
		
		
		public function get scaleY():Number 
		{
			return _scaleY;
		}
		
		public function set scaleY(value:Number):void 
		{
			_scaleY = value;
			bg.scaleY = value;
		}
		
		public function get length():Number 
		{
			_length = bglength- sliderbtn.mc.height/_scaleY;
			return _length;
		}
	}

}