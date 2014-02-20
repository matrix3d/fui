package fui 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author lizhi 
	 */
	public class ScrollPanel 
	{
		public var content:DisplayObject;
		public var slider:Slider;
		public var contentRect:Rectangle;
		public var viewRect:Rectangle;
		
		private var scrollRect:Rectangle = new Rectangle;
		public function ScrollPanel(content:DisplayObject,slider:Slider,contentRect:Rectangle,viewRect:Rectangle) 
		{
			this.viewRect = viewRect;
			this.contentRect = contentRect;
			this.slider = slider;
			this.content = content;
			slider.addEventListener(Event.CHANGE, slider_change);
			content.addEventListener(MouseEvent.MOUSE_WHEEL, content_mouseWheel);
		}
		
		private function content_mouseWheel(e:MouseEvent):void 
		{
			slider.mc.dispatchEvent(e);
		}
		
		private function slider_change(e:Event):void 
		{
			update();
		}
		
		public function update():void { 
			scrollRect.x = viewRect.x;
			scrollRect.y = Math.max(viewRect.y,viewRect.y+(contentRect.height-viewRect.height)*slider.value);
			scrollRect.width = viewRect.width;
			scrollRect.height = viewRect.height;
			content.scrollRect = scrollRect;	
		}
	}

}