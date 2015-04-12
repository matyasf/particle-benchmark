package idv.cjcat.stardustextended.threeD.zones {
	import idv.cjcat.stardustextended.common.math.StardustMath;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3DPool;
	import idv.cjcat.stardustextended.threeD.geom.Vec3D;
	import idv.cjcat.stardustextended.threeD.geom.Vec3DPool;
	
	public class SphereCap extends Zone3D {
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		private var _angle:Number;
		private var _minRadius:Number;
		private var _maxRadius:Number;
		//private var _randomR:Random;
		
		public function SphereCap(x:Number = 0, y:Number = 0, z:Number = 0, minRadius:Number = 50, maxRadius:Number = 100, angle:Number = 30) {
 			this.x = x;
			this.y = y;
			this.z = z;
			this.minRadius = minRadius;
			this.maxRadius = maxRadius;
			this.angle = angle;
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
		
		public function get angle():Number { return _angle; }
		public function set angle(value:Number):void {
			if (value <= 0) value = 0;
			_angle = value;
			updateVolume();
		}
		
		override public final function calculateMotionData3D():MotionData3D {
			var theta:Number = StardustMath.TWO_PI * Math.random();
			var r:Number = Math.random();
			var v:Vec3D = Vec3DPool.get(r * Math.cos(theta), -1 / Math.tan(angle * StardustMath.DEGREE_TO_RADIAN), r * Math.sin(theta));
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
			//volume =  (1 / 3) * (_maxRadius * _maxRadius * _maxRadius - _minRadius * _minRadius * _minRadius) * (cos * Math.PI);
			volume = (StardustMath.TWO_PI / 3) * (_maxRadius * _maxRadius * _maxRadius - _minRadius * _minRadius * _minRadius) * (1 - Math.cos(angle * StardustMath.DEGREE_TO_RADIAN));
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			//return [_randomR];
			return [];
		}
		
		override public function getXMLTagName():String {
			return "SphereCap";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@x = x;
			xml.@y = y;
			xml.@z = z;
			xml.@minRadius = minRadius;
			xml.@maxRadius = maxRadius;
			xml.@angle = angle;
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
			if (xml.@angle.length()) angle = parseFloat(xml.@angle);
			//randomR = builder.getElementByName(xml.@randomR) as Random;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}