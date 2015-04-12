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
	 * For native Stardust 3D engine only.
	 * </p>
	 * 
	 * <p>
	 * Default priority = -6;
	 * </p>
	 */
	public class BillboardOriented extends Action3D {
		
		/**
		 * How fast the particles align to their velocities, 1 by default.
		 * 
		 * <p>
		 * 1 means immediate alignment. 0 means no alignment at all.
		 * </p>
		 */
		public var factor:Number;
		/**
		 * The rotation angle offset in degrees.
		 */
		public var offset:Number;
		public function BillboardOriented(factor:Number = 1, offset:Number = 0) {
			priority = -6;
			
			this.factor = factor;
			this.offset = offset;
		}
		
		override public final function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			var p3D:Particle3D = Particle3D(particle);
			var displacement:Number = (Math.atan2(p3D.screenVX, -p3D.screenVY) * StardustMath.RADIAN_TO_DEGREE + offset) - p3D.rotationZ;
			p3D.rotationZ += factor * displacement;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "BillboardOriented";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@factor = factor;
			xml.@offset = offset;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@factor.length()) factor = parseFloat(xml.@factor);
			if (xml.@offset.length()) offset = parseFloat(xml.@offset);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}