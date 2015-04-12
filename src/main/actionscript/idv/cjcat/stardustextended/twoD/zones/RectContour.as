package idv.cjcat.stardustextended.twoD.zones {
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	
	/**
	 * Rectangular contour.
	 */
	public class RectContour extends Composite {
		
		private var _virtualThickness:Number;
		
		private var _x:Number;
		private var _y:Number;
		private var _width:Number;
		private var _height:Number;
		
		private var _line1:Line;
		private var _line2:Line;
		private var _line3:Line;
		private var _line4:Line;
		
		public function RectContour(x:Number = 0, y:Number = 0, width:Number = 640, height:Number = 480) {
			_line1 = new Line();
			_line2 = new Line();
			_line3 = new Line();
			_line4 = new Line();
			
			addZone(_line1);
			addZone(_line2);
			addZone(_line3);
			addZone(_line4);
			
			virtualThickness = 1;
			
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
		
		public function get x():Number { return _x; }
		public function set x(value:Number):void {
			_x = value;
			updateContour();
			updateArea();
		}
		
		public function get y():Number { return _y; }
		public function set y(value:Number):void {
			_y = value;
			updateContour();
			updateArea();
		}
		
		public function get width():Number { return _width; }
		public function set width(value:Number):void {
			_width = value;
			updateContour();
			updateArea();
		}
		
		public function get height():Number { return _height; }
		public function set height(value:Number):void {
			_height = value;
			updateContour();
			updateArea();
		}
		
		public function get virtualThickness():Number { return _virtualThickness; }
		public function set virtualThickness(value:Number):void {
			_virtualThickness = value;
			_line1.virtualThickness = value;
			_line2.virtualThickness = value;
			_line3.virtualThickness = value;
			_line4.virtualThickness = value;
			updateArea();
		}

        override public function setPosition(xc : Number, yc : Number):void {
            _x = xc;
            _y = yc;
            updateContour();
        }
		
		private function updateContour():void {
			_line1.x1 = x;
			_line1.y1 = y;
			_line1.x2 = x + width;
			_line1.y2 = y;
			
			_line2.x1 = x;
			_line2.y1 = y + height;
			_line2.x2 = x + width;
			_line2.y2 = y + height;
			
			_line3.x1 = x;
			_line3.y1 = y;
			_line3.x2 = x;
			_line3.y2 = y + height;
			
			_line4.x1 = x + width;
			_line4.y1 = y;
			_line4.x2 = x + width;
			_line4.y2 = y + height;
		}

        override protected function updateArea():void {
            area = 0;
            for each (var line:Line in zones) {
                area += line.getArea();
            }
        }
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [];
		}
		
		override public function getXMLTagName():String {
			return "RectContour";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			delete xml.zones;
			
			xml.@virtualThickness = virtualThickness;
			xml.@x = x;
			xml.@y = y;
			xml.@width = width;
			xml.@height = height;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@virtualThickness.length()) virtualThickness = parseFloat(xml.@virtualThickness);
			
			if (xml.@x.length()) x = parseFloat(xml.@x);
			if (xml.@y.length()) y = parseFloat(xml.@y);
			if (xml.@width.length()) width = parseFloat(xml.@width);
			if (xml.@height.length()) height = parseFloat(xml.@height);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}