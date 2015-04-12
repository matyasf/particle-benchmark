package idv.cjcat.stardustextended.threeD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * Causes a particle's rotations on each axis to change according to the corresponding omega values (angular velocity).
	 * 
	 * <p>
	 * Default priority = -4;
	 * </p>
	 */
	public class Spin3D extends Action3D {
		
		/**
		 * The multiplier of spinning, 1 by default.
		 * 
		 * <p>
		 * For instance, a multiplier value of 2 causes a particle to spin twice as fast as normal.
		 * </p>
		 */
		public var multiplier:Number;
		
		public function Spin3D(multiplier:Number = 1) {
			priority = -4;
			
			this.multiplier = multiplier;
		}
		
		override public final function preUpdate(emitter:Emitter, time:Number):void {
			factor = time * multiplier;
		}
		
		private var p3D:Particle3D;
		private var factor:Number;
		override public final function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			p3D = Particle3D(particle);
			p3D.rotationX += p3D.omegaX * factor;
			p3D.rotationY += p3D.omegaY * factor;
			p3D.rotationZ += p3D.omegaZ * factor;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "Spin3D";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@multiplier = multiplier;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@multiplier.length()) multiplier = parseFloat(xml.@multiplier);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}