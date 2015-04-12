package idv.cjcat.stardustextended.threeD.fields {
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3D;
	import idv.cjcat.stardustextended.threeD.geom.MotionData3DPool;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * Uniform vector field. It yields a <code>MotionData3D</code> object of same X, Y, and  components no matter what.
	 * 
	 * <p>
	 * This can be used to simulate uniform gravity.
	 * </p>
	 */
	public class UniformField3D extends Field3D {
		
		/**
		 * The X component of the returned <code>MotionData3D</code> object.
		 */
		public var x:Number;
		/**
		 * The Y component of the returned <code>MotionData3D</code> object.
		 */
		public var y:Number;
		/**
		 * The Z component of the returned <code>MotionData3D</code> object.
		 */
		public var z:Number;
		
		public function UniformField3D(x:Number = 0, y:Number = 0, z:Number = 0) {
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		override protected final function calculateMotionData3D(particle:Particle3D):MotionData3D {
			return MotionData3DPool.get(x, y, z);
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "UniformField3D";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@x = x;
			xml.@y = y;
			xml.@z = z;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@x.length()) x = parseFloat(xml.@x);
			if (xml.@y.length()) y = parseFloat(xml.@y);
			if (xml.@z.length()) z = parseFloat(xml.@z);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}