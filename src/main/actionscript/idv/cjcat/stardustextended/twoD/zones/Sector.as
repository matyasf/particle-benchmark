package idv.cjcat.stardustextended.twoD.zones {
	import idv.cjcat.stardustextended.common.math.Random;
	import idv.cjcat.stardustextended.common.math.StardustMath;
	import idv.cjcat.stardustextended.common.math.UniformRandom;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
	
	/**
	 * Sector-shaped zone.
	 */
	public class Sector extends Zone {
		
		/**
		 * The X coordinate of the center of the sector.
		 */
		public var x:Number;
		/**
		 * The Y coordinate of the center of the sector.
		 */
		public var y:Number;

		private var _randomT:Random;
		private var _minRadius:Number;
		private var _maxRadius:Number;
		private var _minAngle:Number;
		private var _maxAngle:Number;
		private var _minAngleRad:Number;
		private var _maxAngleRad:Number;
		
		public function Sector(x:Number = 0, y:Number = 0, minRadius:Number = 0, maxRadius:Number = 100, minAngle:Number = 0, maxAngle:Number = 360) {
			_randomT = new UniformRandom();
			
			this.x = x;
			this.y = y;
			this._minRadius = minRadius;
			this._maxRadius = maxRadius;
			this._minAngle = minAngle;
			this._maxAngle = maxAngle;
			
			updateArea();
		}

        override public function setPosition(xc : Number, yc : Number):void {
            x = xc;
            y = yc;
        }
		
		/**
		 * The minimum radius of the sector.
		 */
		public function get minRadius():Number { return _minRadius; }
		public function set minRadius(value:Number):void {
			_minRadius = value;
			updateArea();
		}
		
		/**
		 * The maximum radius of the sector.
		 */
		public function get maxRadius():Number { return _maxRadius; }
		public function set maxRadius(value:Number):void {
			_maxRadius = value;
			updateArea();
		}
		
		/**
		 * The minimum angle of the sector.
		 */
		public function get minAngle():Number { return _minAngle; }
		public function set minAngle(value:Number):void {
			_minAngle = value;
			updateArea();
		}
		
		/**
		 * The maximum angle of the sector.
		 */
		public function get maxAngle():Number { return _maxAngle; }
		public function set maxAngle(value:Number):void {
			_maxAngle = value;
			updateArea();
		}
		
		override public function calculateMotionData2D():MotionData2D {
			if (_maxRadius == 0) return new MotionData2D(x, y);

			_randomT.setRange(_minAngleRad, _maxAngleRad);
			var theta:Number = _randomT.random();
			var r:Number = StardustMath.interpolate(0, _minRadius, 1, _maxRadius, Math.sqrt(Math.random()));
			
			return new MotionData2D(r * Math.cos(theta) + x, r * Math.sin(theta) + y);
		}
		
		override protected function updateArea():void {
			_minAngleRad = _minAngle * StardustMath.DEGREE_TO_RADIAN;
			_maxAngleRad = _maxAngle * StardustMath.DEGREE_TO_RADIAN;
            if (Math.abs(_minAngleRad) > StardustMath.TWO_PI)
            {
                _minAngleRad = _minAngleRad % StardustMath.TWO_PI;
            }
            if (Math.abs(_maxAngleRad) > StardustMath.TWO_PI)
            {
                _maxAngleRad = _maxAngleRad % StardustMath.TWO_PI;
            }
			var dT:Number = _maxAngleRad - _minAngleRad;

			var dRSQ:Number = _minRadius * _minRadius - _maxRadius * _maxRadius;
			
			area = Math.abs(dRSQ * dT);
		}
		
		override public function contains(x:Number, y:Number):Boolean {
            const dx:Number = this.x - x;
            const dy:Number = this.y - y;
            const isInsideOuterCircle : Boolean = ((dx * dx + dy * dy) <= _maxRadius * _maxRadius);
            if ( !isInsideOuterCircle )
            {
                return false;
            }
            const isInsideInnerCircle : Boolean = ((dx * dx + dy * dy) <= _minRadius * _minRadius);
            if ( isInsideInnerCircle )
            {
                return false;
            }
            const angle : Number = Math.atan2(dy, dx) + Math.PI;
            // TODO: does not work for edge cases, e.g. when minAngle = -20 and maxAngle = 20
            if (angle > _maxAngleRad || angle < _minAngleRad)
            {
                return false;
            }
			return true;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [];
		}
		
		override public function getXMLTagName():String {
			return "Sector";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@x = x;
			xml.@y = y;
			xml.@minRadius = minRadius;
			xml.@maxRadius = maxRadius;
			xml.@minAngle = minAngle;
			xml.@maxAngle = maxAngle;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@x.length()) x = parseFloat(xml.@x);
			if (xml.@y.length()) y = parseFloat(xml.@y);
			if (xml.@minRadius.length()) minRadius = parseFloat(xml.@minRadius);
			if (xml.@maxRadius.length()) maxRadius = parseFloat(xml.@maxRadius);
			if (xml.@minAngle.length()) minAngle = parseFloat(xml.@minAngle);
			if (xml.@maxAngle.length()) maxAngle = parseFloat(xml.@maxAngle);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}