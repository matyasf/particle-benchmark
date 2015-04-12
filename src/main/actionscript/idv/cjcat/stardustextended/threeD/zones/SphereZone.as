package idv.cjcat.stardustextended.threeD.zones {
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3DPool;
	import idv.cjcat.stardustextended.threeD.geom.Vec3D;
	import idv.cjcat.stardustextended.threeD.geom.Vec3DPool;
	
	public class SphereZone extends Zone3D {
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		private var _radius:Number;
		//private var _randomR:Random;
		
		public function SphereZone(x:Number = 0, y:Number = 0, z:Number = 0, radius:Number = 100) {
			this.x = x;
			this.y = y;
			this.z = z;
			this.radius = radius;
			//this.randomR = randomR;
		}
		
		public function get radius():Number { return _radius;  }
		public function set radius(value:Number):void {
			_radius = value;
			updateVolume();
		}
		
		//public function get randomR():Random { return _randomR; }
		//public function set randomR(value:Random):void {
			//if (!value) value = new UniformRandom();
			//_randomR = value;
		//}
		
		override public final function calculateMotionData3D():MotionData3D {
			//_randomR.setRange(0, 1);
			//var theta:Number = StardustMath.TWO_PI * Math.random();
			//var phy:Number = Math.PI * (Math.random() - 0.5 );
			//var r:Number = _radius * Math.sqrt(_randomR.random());
			
			var v:Vec3D = Vec3DPool.get(0.5 - Math.random(), 0.5 - Math.random(), 0.5 - Math.random());
			v.length = _radius * Math.random();
			Vec3DPool.recycle(v);
			
			return MotionData3DPool.get(v.x, v.y, v.z);
		}
		
		override public final function contains(x:Number, y:Number, z:Number):Boolean {
			var dx:Number = this.x - x;
			var dy:Number = this.y - y;
			var dz:Number = this.z - z;
			return ((dx * dx + dy * dy + dz * dz) <= _radius * _radius);
		}
		
		override protected final function updateVolume():void {
			volume = (4 / 3) * Math.PI * _radius * _radius * _radius;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [];
			//return [_randomR];
		}
		
		override public function getXMLTagName():String {
			return "SphereZone";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@x = x;
			xml.@y = y;
			xml.@z = z;
			xml.@radius = radius;
			//xml.@randomR = _randomR.name;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@x.length()) x = parseFloat(xml.@x);
			if (xml.@y.length()) y = parseFloat(xml.@y);
			if (xml.@z.length()) z = parseFloat(xml.@z);
			if (xml.@radius.length()) radius = parseFloat(xml.@radius);
			//randomR = builder.getElementByName(xml.@randomR) as Random;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}