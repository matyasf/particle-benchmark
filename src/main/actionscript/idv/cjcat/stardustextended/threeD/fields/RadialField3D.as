package idv.cjcat.stardustextended.threeD.fields {
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3DPool;
	import idv.cjcat.stardustextended.threeD.geom.Vec3D;
	import idv.cjcat.stardustextended.threeD.geom.Vec3DPool;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * Radial field.
	 */
	public class RadialField3D extends Field3D {
		
		/**
		 * The X coordinate of the center of the field.
		 */
		public var x:Number;
		/**
		 * The Y coordinate of the center of the field.
		 */
		public var y:Number;
		/**
		 * The Z coordinate of the center of the field.
		 */
		public var z:Number;
		
		/**
		 * The strength of the field.
		 */
		public var strength:Number;
		/**
		 * The attenuation power of the field, in powers per pixel.
		 */
		public var attenuationPower:Number;
		/**
		 * If a point is closer to the center than this value, 
		 * it's treated as if it's this far from the center. 
		 * This is to prevent simulation from blowing up for points too near to the center.
		 */
		public var epsilon:Number;
		
		public function RadialField3D(x:Number = 0, y:Number = 0, z:Number = 0, strength:Number = 1, attenuationPower:Number = 0, epsilon:Number = 1) {
			this.x = x;
			this.y = y;
			this.z = z;
			this.strength = strength;
			this.attenuationPower = attenuationPower;
			this.epsilon = epsilon;
		}
		
		private var r:Vec3D;
		private var len:Number;
		override protected final function calculateMotionData3D(particle:Particle3D):MotionData3D {
			r = Vec3DPool.get(particle.x - x, particle.y - y, particle.x - z);
			len = r.length;
			if (len < epsilon) len = epsilon;
			r.length = strength * Math.pow(len, -0.5 * attenuationPower);
			Vec3DPool.recycle(r);
			
			return MotionData3DPool.get(r.x, r.y, r.z);
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "RadialField3D";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@x = x;
			xml.@y = y;
			xml.@z = z;
			xml.@strength = strength;
			xml.@attenuationPower = attenuationPower;
			xml.@epsilon = epsilon;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@x.length()) x = parseFloat(xml.@x);
			if (xml.@y.length()) y = parseFloat(xml.@y);
			if (xml.@z.length()) z = parseFloat(xml.@z);
			if (xml.@strength.length()) strength = parseFloat(xml.@strength);
			if (xml.@attenuationPower.length()) attenuationPower = parseFloat(xml.@attenuationPower);
			if (xml.@epsilon.length()) epsilon = parseFloat(xml.@epsilon);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}