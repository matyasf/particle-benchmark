package idv.cjcat.stardustextended.threeD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.math.StardustMath;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * Causes particles' rotation to align to their velocities.
	 * 
	 * <p>
	 * Default priority = -6;
	 * </p>
	 */
	public class Oriented3D extends Action3D {
		
		/**
		 * How fast the particles align to their velocities, 1 by default.
		 * 
		 * <p>
		 * 1 means immediate alignment. 0 means no alignment at all.
		 * </p>
		 */
		public var factor:Number;
		/**
		 * The X rotation angle offset in degrees.
		 */
		public var offsetX:Number;
		/**
		 * The Y rotation angle offset in degrees.
		 */
		public var offsetY:Number;
		/**
		 * The Z rotation angle offset in degrees.
		 */
		public var offsetZ:Number;
		public function Oriented3D(factor:Number = 1, offsetX:Number = 0, offsetY:Number = 90, offsetZ:Number = 0) {
			priority = -6;
			
			this.factor = factor;
			this.offsetX = offsetX;
			this.offsetY = offsetY;
			this.offsetZ = offsetZ;
		}
		
		override public final function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			var p3D:Particle3D = Particle3D(particle);
			var displacementX:Number = (Math.atan2(Math.sqrt(p3D.vx * p3D.vx + p3D.vz * p3D.vz), p3D.vy) * StardustMath.RADIAN_TO_DEGREE + offsetX) - p3D.rotationX;
			var displacementY:Number = (Math.atan2(-p3D.vz, p3D.vx) * StardustMath.RADIAN_TO_DEGREE + offsetY) - p3D.rotationY;
			var displacementZ:Number = offsetZ - p3D.rotationZ;
			
			p3D.rotationX += factor * displacementX;
			p3D.rotationY += factor * displacementY;
			p3D.rotationZ += factor * displacementZ;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "Oriented3D";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@factor = factor;
			xml.@offsetX = offsetX;
			xml.@offsetY = offsetY;
			xml.@offsetZ = offsetZ;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@factor.length()) factor = parseFloat(xml.@factor);
			if (xml.@offsetX.length()) offsetX = parseFloat(xml.@offsetX);
			if (xml.@offsetY.length()) offsetY = parseFloat(xml.@offsetY);
			if (xml.@offsetZ.length()) offsetZ = parseFloat(xml.@offsetZ);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}