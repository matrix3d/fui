package fui 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	/**
	 * ..."tab_"+i+"_mc"
	 * 
	 * @author lizhi
	 */
	public class Tabbar extends EventDispatcher
	{
		public var mc:MovieClip;
		public var btns:Array = [];
		public var selected:int = -1;
		public var lastSelected:int;//上次选择的
		public function Tabbar(mc:MovieClip) 
		{
			this.mc = mc;
			mc.TABBAR = this;
			var i:int = 0;
			while (mc["tab_"+i+"_mc"]) {
				var btn:Button = new Button(mc["tab_" + i + "_mc"]);
				btn.mc.addEventListener(MouseEvent.CLICK, mc_click);
				btns.push(btn);
				i++;
			}
			select(0);
		}
		
		private function mc_click(e:MouseEvent):void 
		{
			for (var i:int = 0; i < btns.length;i++ ) {
				var btn:Button = btns[i];
				if (btn.mc == e.currentTarget) {
					select(i);
					return;
				}
			}
		}
		
		public function select(index:int):void {
			lastSelected = selected;
			if (index!=selected) {
				if (btns[selected]) {
					(btns[selected] as Button).addMouseEffect();
					(btns[selected] as Button).setState(0);
				}
				if (btns[index]) {
					(btns[index] as Button).removeMouseEffect();
					(btns[index] as Button).setState(3);
					mc.setChildIndex((btns[index] as Button).mc ,mc.numChildren - 1);
					selected = index;
				}
				dispatchEvent(new Event(Event.SELECT));
			}
		}
		
		public function setTexts(arr:Array):void {
			for (var i:int = 0; i < btns.length;i++ ) {
				btns[i].text = arr[i] + "";
			}
		}
	}

}