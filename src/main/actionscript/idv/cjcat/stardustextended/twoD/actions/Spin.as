package idv.cjcat.stardustextended.twoD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * Causes a particle's rotation to change according to it's omega value (angular velocity).
	 * 
	 * <p>
	 * Default priority = -4;
	 * </p>
	 */
	public class Spin extends Action2D {
		
		/**
		 * The multiplier of spinning, 1 by default.
		 * 
		 * <p>
		 * For instance, a multiplier value of 2 causes a particle to spin twice as fast as normal.
		 * </p>
		 */
		public var multiplier:Number;
		
		public function Spin(multiplier:Number = 1) {
			priority = -4;
			
			this.multiplier = multiplier;
		}
		
		override public function preUpdate(emitter:Emitter, time:Number):void {
			factor = time * multiplier;
		}
		
		private var p2D:Particle2D;
		private var factor:Number;
		override public function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			p2D = Particle2D(particle);
			p2D.rotation += p2D.omega * factor;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "Spin";
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