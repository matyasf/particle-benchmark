package idv.cjcat.stardustextended.twoD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.geom.Vec2D;
	import idv.cjcat.stardustextended.twoD.geom.Vec2DPool;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * Accelerates particles along their velocity directions.
	 */
	public class Accelerate extends Action2D {
		
		/**
		 * The amount of acceleration in each emitter step.
		 */
		public var acceleration:Number;
		
		public function Accelerate(acceleration:Number = 0.1) {
			this.acceleration = acceleration;
		}
		
		override public function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			var p2D:Particle2D = Particle2D(particle);
			var v:Vec2D = Vec2DPool.get(p2D.vx, p2D.vy);
            const vecLength : Number = v.length;
			if (vecLength > 0) {
				var finalVal : Number = vecLength + acceleration * timeDelta;
				if (finalVal < 0) {
					finalVal = 0;
				}
				v.length = finalVal;
				p2D.vx = v.x;
				p2D.vy = v.y;
			}
			Vec2DPool.recycle(v);
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "Accelerate";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@acceleration = acceleration;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@acceleration.length()) acceleration = parseFloat(xml.@acceleration);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}