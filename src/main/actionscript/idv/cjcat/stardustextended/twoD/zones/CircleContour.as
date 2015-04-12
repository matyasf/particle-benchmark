package idv.cjcat.stardustextended.twoD.zones {
	import idv.cjcat.stardustextended.common.math.StardustMath;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
	
	/**
	 * Circular contour zone.
	 */
	public class CircleContour extends Contour {
		
		/**
		 * The X coordinate of the center.
		 */
		public var x:Number;
		/**
		 * The Y coordinate of the center.
		 */
		public var y:Number;
		
		private var _radius:Number;
		private var _r1SQ:Number;
		private var _r2SQ:Number;
		
		public function CircleContour(x:Number = 0, y:Number = 0, radius:Number = 100) {
			this.x = x;
			this.y = y;
			this.radius = radius;
		}
		
		/**
		 * The radius of the zone.
		 */
		public function get radius():Number { return _radius;  }
		public function set radius(value:Number):void {
			_radius = value;
			var r1:Number = value + 0.5 * virtualThickness;
			var r2:Number = value - 0.5 * virtualThickness;
			_r1SQ = r1 * r1;
			_r2SQ = r2 * r2;
			updateArea();
		}
		
		override protected function updateArea():void {
			area = (_r1SQ - _r2SQ) * Math.PI * virtualThickness;
		}
		
		override public function contains(xc:Number, yc:Number):Boolean {
			var dx:Number = x - xc;
			var dy:Number = y - yc;
			var dSQ:Number = dx * dx + dy * dy;
			return !((dSQ > _r1SQ) || (dSQ < _r2SQ));
		}

        override public function setPosition(xc : Number, yc : Number):void {
            x = xc;
            y = yc;
        }
		
		override public function calculateMotionData2D():MotionData2D {
			var theta:Number = StardustMath.TWO_PI * Math.random();
			return new MotionData2D(_radius * Math.cos(theta) + x, _radius * Math.sin(theta) + y);
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [];
		}
		
		override public function getXMLTagName():String {
			return "CircleContour";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			xml.@x = x;
			xml.@y = y;
			xml.@radius = radius;
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@x.length()) x = parseFloat(xml.@x);
			if (xml.@y.length()) y = parseFloat(xml.@y);
			if (xml.@radius.length()) radius = parseFloat(xml.@radius);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}