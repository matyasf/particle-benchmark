package idv.cjcat.stardustextended.threeD.zones {
	import idv.cjcat.stardustextended.common.math.Random;
	import idv.cjcat.stardustextended.common.math.StardustMath;
	import idv.cjcat.stardustextended.common.math.UniformRandom;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3D;
	
	public class DiskZone extends Surface {
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		private var _minRadius:Number;
		private var _maxRadius:Number;
		private var _randomR:Random;
		private var _randomT:Random;
		public function DiskZone(x:Number = 0, y:Number = 0, z:Number = 0, minRadius:Number = 0, maxRadius:Number = 100, randomR:Random = null) {
			this.x = x;
			this.y = y;
			this.z = z;
			this.minRadius = minRadius;
			this.maxRadius = maxRadius;
			this.randomR = randomR;
			_randomT = new UniformRandom();
		}
		
		public function get minRadius():Number { return _minRadius; }
		public function set minRadius(value:Number):void {
			_minRadius = value;
			updateVolume();
		}
		
		public function get maxRadius():Number { return _maxRadius; }
		public function set maxRadius(value:Number):void {
			_maxRadius = value;
			updateVolume();
		}
		
		public function get randomR():Random { return _randomR; }
		public function set randomR(value:Random):void {
			if (!value) value = new UniformRandom();
			_randomR = value;
		}
		
		override public final function calculateMotionData3D():MotionData3D {
			if (_maxRadius == 0) return new MotionData3D(x, y, z);
			
			randomR.setRange(_minRadius, _maxRadius);
			_randomT.setRange(0, StardustMath.TWO_PI);
			var theta:Number = _randomT.random();
			var r:Number = _maxRadius * Math.sqrt(randomR.random() / _maxRadius);
			
			return new MotionData3D(r * Math.cos(theta) + x, y, r * Math.sin(theta) + y);
		}
		
		override protected final function updateVolume():void {
			if (_minRadius > _maxRadius) {
				var tempR:Number = _minRadius;
				_minRadius = _maxRadius;
				_maxRadius = tempR;
			}
			
			volume = (_maxRadius * _maxRadius - _minRadius * minRadius) * Math.PI * virtualThickness;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [_randomR];
		}
		
		override public function getXMLTagName():String {
			return "DiskZone";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@x = x;
			xml.@y = y;
			xml.@z = z;
			xml.@minRadius = minRadius;
			xml.@maxRadius = maxRadius;
			xml.@randomR = randomR.name;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@x.length()) x = parseFloat(xml.@x);
			if (xml.@y.length()) y = parseFloat(xml.@y);
			if (xml.@z.length()) z = parseFloat(xml.@z);
			if (xml.@minRadius.length()) minRadius = parseFloat(xml.@minRadius);
			if (xml.@maxRadius.length()) maxRadius = parseFloat(xml.@maxRadius);
			if (xml.@randomR.length()) randomR = builder.getElementByName(xml.@randomR) as Random;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}