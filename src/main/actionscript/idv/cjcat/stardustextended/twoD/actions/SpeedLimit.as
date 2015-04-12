package idv.cjcat.stardustextended.twoD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * Limits a particle's maximum traveling speed.
	 */
	public class SpeedLimit extends Action2D {
		
		/**
		 * The speed limit.
		 */
		public var limit:Number;
		public function SpeedLimit(limit:Number = Number.MAX_VALUE) {
			this.limit = limit;
		}
		
		override public function preUpdate(emitter:Emitter, time:Number):void {
			limitSQ = limit * limit;
		}
		
		private var p2D:Particle2D;
		private var speedSQ:Number;
		private var limitSQ:Number;
		private var factor:Number;
		override public function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			p2D = Particle2D(particle);
			speedSQ = p2D.vx * p2D.vx + p2D.vy * p2D.vy;
			if (speedSQ > limitSQ) {
				factor = limit / Math.sqrt(speedSQ);
				p2D.vx *= factor;
				p2D.vy *= factor;
			}
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "SpeedLimit";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@limit = limit;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@limit.length()) limit = parseFloat(xml.@limit);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}