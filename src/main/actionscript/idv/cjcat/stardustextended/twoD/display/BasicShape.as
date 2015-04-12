package idv.cjcat.stardustextended.twoD.display {
	import flash.display.Shape;
	
	public class BasicShape extends Shape {
		
		private var _fillColor:uint;
		private var _fillAlpha:Number;
		private var _lineColor:uint;
		private var _lineAlpha:Number;
		private var _lineThickness:Number;
		public function BasicShape(fillColor:uint = 0xFFFFFF, fillAlpha:Number = 1, lineColor:uint = 0x006600, lineAlpha:Number = 1, lineThickness:Number = 0) {
			_fillColor = fillColor;
			_fillAlpha = fillAlpha;
			_lineColor = lineColor;
			_lineAlpha = lineAlpha;
			_lineThickness = lineThickness;
		}
		
		/**
		 * [Abstract Method] Updates the appearance of the shape.
		 */
		public function update():void {
			//abstract method
		}
		
		public final function get fillColor():uint { return _fillColor; }
		public final function set fillColor(value:uint):void {
			_fillColor = value;
			update();
		}
		
		public final function get fillAlpha():Number { return _fillAlpha; }
		public final function set fillAlpha(value:Number):void {
			_fillAlpha = value;
			update();
		}
		
		public final function get lineColor():uint { return _lineColor; }
		public final function set lineColor(value:uint):void {
			_lineColor = value;
			update();
		}
		
		public final function get lineAlpha():Number { return _lineAlpha; }
		public final function set lineAlpha(value:Number):void {
			_lineAlpha = value;
			update();
		}
		
		public final function get lineThickness():Number { return _lineThickness; }
		public final function set lineThickness(value:Number):void {
			_lineThickness = value;
			update();
		}
	}
}