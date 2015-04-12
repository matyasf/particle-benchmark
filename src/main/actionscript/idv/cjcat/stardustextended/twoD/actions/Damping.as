package idv.cjcat.stardustextended.twoD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * Causes particles to decelerate.
	 * 
	 * <p>
	 * Default priority = -1;
	 * </p>
	 */
	public class Damping extends Action2D {
		
		/**
		 * In each emitter step, each particle's velocity is multiplied by this value.
		 * 
		 * <p>
		 * A value of 0 denotes no damping at all, and a value of 1 means all particles will not move at all.
		 * </p>
		 */
		public var damping:Number;
		
		public function Damping(damping:Number = 0) {
			priority = -1;
			
			this.damping = damping;
		}
		
		
		override public function preUpdate(emitter:Emitter, time:Number):void {
			damp = 1;
			if (damping) damp = Math.pow(1 - damping, time);  
		}
		
		private var damp:Number;
		override public function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			var p2D:Particle2D = Particle2D(particle);
			p2D.vx *= damp;
			p2D.vy *= damp;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "Damping";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@damping = damping;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@damping.length()) damping = parseFloat(xml.@damping);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}