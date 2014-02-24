package fui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author lizhi
	 */
	public class ColorPick extends Sprite
	{
		private var s1:Sprite = new Sprite;
		private var s2:Sprite = new Sprite;
		private var bmd:BitmapData;
		private var bmd2:BitmapData;
		private var bmd3:BitmapData;
		public function ColorPick() 
		{
			bmd = new BitmapData(100, 10,false, 0);
			s1.addChild(new Bitmap(bmd));
			addChild(s1);
			var rarr:Array = [1 ,1, 0, 0, 0, 1];
			var garr:Array = [0, 1, 1, 1, 0, 0];
			var barr:Array = [0, 0, 0, 1, 1, 1];
			for (var x:int = 0; x < bmd.width; x++ ) {
				var v:Number = x / bmd.width;
				var r:int = getColorBase(rarr, v);
				var g:int = getColorBase(garr, v);
				var b:int = getColorBase(barr, v);
				var color:int =  (r << 16) | (g << 8) | b;
				bmd.fillRect(new Rectangle(x, 0, 1, bmd.height), color);
			}
			
			bmd2 = new BitmapData(100, 100, false, 0);
			s2.addChild(new Bitmap(bmd2));
			s2.y = bmd.height + 2;
			addChild(s2);
			
			bmd3 = new BitmapData(30, 30, false, 0);
			var image3:Bitmap = new Bitmap(bmd3);
			addChild(image3);
			image3.x = bmd.width;
			
			s1.addEventListener(MouseEvent.MOUSE_MOVE, s1_mouseMove);
			s2.addEventListener(MouseEvent.MOUSE_MOVE, s2_mouseMove);
		}
		
		private function s2_mouseMove(e:MouseEvent):void 
		{
			bmd3.fillRect(bmd3.rect, bmd2.getPixel(s2.mouseX, s2.mouseY));
		}
		
		private function s1_mouseMove(e:MouseEvent):void 
		{
			var c:uint = bmd.getPixel(s1.mouseX, s1.mouseY);
			for (var x:int = 0; x < bmd2.width;x++ ) {
				for (var y:int = 0; y < bmd2.height;y++ ) {
					var xc:uint =getCenColor( x / bmd2.width , 0,c);
					var yc:uint = getCenColor(y / bmd2.height ,0, xc);
					bmd2.setPixel(x,y, yc);
				}
			}
		}
		
		private function getCenColor(v:Number, c1:uint, c2:int):uint {
			var r1:uint = (c1 >> 16) & 0xff;
			var r2:uint = (c2 >> 16) & 0xff;
			var g1:uint = (c1 >> 8) & 0xff;
			var g2:uint = (c2 >> 8) & 0xff;
			var b1:uint = c1  & 0xff;
			var b2:uint = c2  & 0xff;
			var r:uint = r1 + (r2 - r1) * v;
			var g:uint = g1 + (g2 - g1) * v;
			var b:uint = b1 + (b2 - b1) * v;
			return (r << 16) | (g << 8) | b;
		}
		
		private function getColorBase(arr:Array, v:Number):int {
			var lenv:Number = v * arr.length;
			var part:Number = lenv % 1;
			var x0:int = int(lenv);
			var x1:int = x0 + 1;
			if (x1==arr.length) x1 = 0;
			var c0:Number = arr[x0];
			var c1:Number = arr[x1];
			return 0xff*(c0+part*(c1-c0));
			
		}
		
	}

}