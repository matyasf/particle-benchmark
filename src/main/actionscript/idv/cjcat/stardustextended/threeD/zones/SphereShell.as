package idv.cjcat.stardustextended.threeD.zones {
	import idv.cjcat.stardustextended.common.math.StardustMath;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3DPool;
	import idv.cjcat.stardustextended.threeD.geom.Vec3D;
	import idv.cjcat.stardustextended.threeD.geom.Vec3DPool;
	
	public class SphereShell extends Zone3D {
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		private var _minRadius:Number;
		private var _maxRadius:Number;
		//private var _randomR:Random;
		
		public function SphereShell(x:Number = 0, y:Number = 0, z:Number = 0, minRadius:Number = 50, maxRadius:Number = 100) {
			this.x = x;
			this.y = y;
			this.z = z;
			this.minRadius = minRadius;
			this.maxRadius = maxRadius;
			//this.randomR = randomR;
		}
		
		public function get minRadius():Number { return _minRadius;  }
		public function set minRadius(value:Number):void {
			_minRadius = value;
			updateVolume();
		}
		
		public function get maxRadius():Number { return _maxRadius;  }
		public function set maxRadius(value:Number):void {
			_maxRadius = value;
			updateVolume();
		}
		
		//public function get randomR():Random { return _randomR; }
		//public function set randomR(value:Random):void {
			//if (!value) value = new UniformRandom();
			//_randomR = value;
		//}
		
		override public final function calculateMotionData3D():MotionData3D {
			//randomR.setRange(_minRadius, _maxRadius);
			//var theta:Number = StardustMath.TWO_PI * Math.random();
			//var phy:Number = Math.PI * (Math.random() - 0.5 );
			//var r:Number = _maxRadius * Math.sqrt(randomR.random() / _maxRadius);
			
			var v:Vec3D = Vec3DPool.get(Math.random() - 0.5, Math.random() - 0.5, Math.random() - 0.5);
			v.length = StardustMath.interpolate(0, _minRadius, 1, _maxRadius, Math.random());
			Vec3DPool.recycle(v);
			
			return MotionData3DPool.get(v.x, v.y, v.z);
		}
		
		override public final function contains(x:Number, y:Number, z:Number):Boolean {
			var dx:Number = this.x - x;
			var dy:Number = this.y - y;
			var dz:Number = this.z - z;
			var rSQ:Number = dx * dx + dy * dy + dz * dz;
			return ((rSQ <= _maxRadius * _maxRadius) && (rSQ >= _minRadius *_minRadius));
		}
		
		override protected final function updateVolume():void {
			volume = (4 / 3) * Math.PI * (_maxRadius * _maxRadius * _maxRadius - _minRadius * _minRadius * _minRadius);
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			//return [_randomR];
			return [];
		}
		
		override public function getXMLTagName():String {
			return "SphereShell";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@x = x;
			xml.@y = y;
			xml.@z = z;
			xml.@minRadius = minRadius;
			xml.@maxRadius = maxRadius;
			//xml.@randomR = _randomR.name;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@x.length()) x = parseFloat(xml.@x);
			if (xml.@y.length()) y = parseFloat(xml.@y);
			if (xml.@z.length()) z = parseFloat(xml.@z);
			if (xml.@minRadius.length()) minRadius = parseFloat(xml.@minRadius);
			if (xml.@maxRadius.length()) maxRadius = parseFloat(xml.@maxRadius);
			//randomR = builder.getElementByName(xml.@randomR) as Random;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}