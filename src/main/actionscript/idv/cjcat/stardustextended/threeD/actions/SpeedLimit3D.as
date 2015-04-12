package idv.cjcat.stardustextended.threeD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * Limits a particle's maximum traveling speed.
	 */
	public class SpeedLimit3D extends Action3D {
		
		/**
		 * The speed limit.
		 */
		public var limit:Number;
		public function SpeedLimit3D(limit:Number = Number.MAX_VALUE) {
			this.limit = limit;
		}
		
		override public final function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			var p3D:Particle3D = Particle3D(particle);
			var speedSQ:Number = p3D.vx * p3D.vx + p3D.vy * p3D.vy + p3D.vz * p3D.vz;
			
			if (speedSQ > limit * limit) {
				var factor:Number = limit / Math.sqrt(speedSQ);
				p3D.vx *= factor;
				p3D.vy *= factor;
				p3D.vz *= factor;
			}
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "SpeedLimit3D";
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