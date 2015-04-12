package idv.cjcat.stardustextended.twoD.zones {
	import idv.cjcat.stardustextended.common.math.Random;
	import idv.cjcat.stardustextended.common.math.StardustMath;
	import idv.cjcat.stardustextended.common.math.UniformRandom;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
	
	/**
	 * Line segment zone.
	 */
	public class Line extends Contour {
		
		/**
		 * The X coordinate of one end of the line.
		 */
        private var _x1:Number;

        public function get x1():Number {
            return _x1;
        }
        public function set x1(value:Number):void {
            _x1 = value;
            updateArea();
        }
		/**
		 * The Y coordinate of one end of the line.
		 */
        private var _y1:Number;
        public function get y1():Number {
            return _y1;
        }

        public function set y1(value:Number):void {
            _y1 = value;
            updateArea();
        }

        private var _x2:Number;
        /**
         * The X coordinate of the other end of the line.
         */
        public function get x2():Number {
            return _x2;
        }

        public function set x2(value:Number):void {
            _x2 = value;
            updateArea();
        }

        private var _y2:Number;
        /**
         * The Y coordinate of the other end of the line.
         */
        public function get y2():Number {
            return _y2;
        }

        public function set y2(value:Number):void {
            _y2 = value;
            updateArea();
        }

		private var _random:Random;
		public function Line(x1:Number = 0, y1:Number = 0, x2:Number = 0, y2:Number = 0, random:Random = null) {
			this._x1 = x1;
			this._y1 = y1;
			this._x2 = x2;
			this._y2 = y2;
			this.random = random;
			updateArea();
		}

        override public function setPosition(xc : Number, yc : Number):void {
            var xDiff : Number = _x2 - _x1;
            var yDiff : Number = _y2 - _y1;
            _x1 = xc;
            _x2 = xc + xDiff;
            _y1 = yc;
            _y2 = yc + yDiff;
        }
		
		public function get random():Random { return _random; }
		public function set random(value:Random):void {
			if (!value) value = new UniformRandom();
			_random = value;
		}
		
		override public function calculateMotionData2D():MotionData2D {
			_random.setRange(0, 1);
			var rand:Number = _random.random();
			return new MotionData2D(StardustMath.interpolate(0, _x1, 1, _x2, rand), StardustMath.interpolate(0, _y1, 1, _y2, rand));
		}
		
		override public function contains(x:Number, y:Number):Boolean {
			if ((x < _x1) && (x < _x2)) return false;
			if ((x > _x1) && (x > _x2)) return false;
			if (((x - _x1) / (_x2 - _x1)) == ((y - _y1) / (_y2 - _y1))) return true;
			return false;
		}
		
		override protected function updateArea():void {
			var dx:Number = _x1 - _x2;
			var dy:Number = _y1 - _y2;
			area = Math.sqrt(dx * dx + dy * dy) * virtualThickness;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "Line";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@x1 = _x1;
			xml.@y1 = _y1;
			xml.@x2 = _x2;
			xml.@y2 = _y2;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@x1.length()) _x1 = parseFloat(xml.@x1);
			if (xml.@y1.length()) _y1 = parseFloat(xml.@y1);
			if (xml.@x2.length()) _x2 = parseFloat(xml.@x2);
			if (xml.@y2.length()) _y2 = parseFloat(xml.@y2);
            updateArea();
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML

    }
}