package 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import fui.Button;
	import fui.UIParser;
	
	/**
	 * ...
	 * @author lizhi
	 */
	public class Main extends Sprite 
	{
		[Embed(source="ui.swf", mimeType="application/octet-stream")]
		private var c:Class;
		private var bytes:ByteArray = new c as ByteArray;
		public function Main():void 
		{
			var loader:Loader = new Loader;
			loader.loadBytes(bytes, new LoaderContext(false, ApplicationDomain.currentDomain));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
		}
		
		private function loader_complete(e:Event):void 
		{
			var mcc:Class = getDefinitionByName("ui_mc") as Class;
			var mc:MovieClip = new mcc as MovieClip;
			addChild(mc);
			
			var parser:UIParser = new UIParser(mc);
			parser.parser();
			
			var btn:Button = parser.getComponent("btn_mc") as Button;
			btn.text = "a btn";
		}
		
	}
	
}