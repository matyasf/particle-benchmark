package idv.cjcat.stardustextended.twoD.actions {
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.twoD.geom.Vec2D;
	import idv.cjcat.stardustextended.twoD.geom.Vec2DPool;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * Causes particles to attract each other.
	 * 
	 * <p>
	 * Default priority = -3;
	 * </p>
	 */
	public class MutualGravity extends MutualAction {
		
		/**
		 * The attraction strength multiplier.
		 */
		public var strength:Number;
		/**
		 * If the distance between two particle's is less than this value, 
		 * they are processed as if they were apart by distance of this value. 
		 * This property is meant to prevent simulation blowup, 1 by default.
		 */
		public var epsilon:Number;
		/**
		 * The attenuation power of the attraction, 1 by default.
		 */
		public var attenuationPower:Number;
		/**
		 * Whether particles are viewed as equal mass, true by default.
		 * 
		 * <p>
		 * When set to false, particle's mass is taken into account: 
		 * heavier particles tend not to move more than lighter particles.
		 * </p>
		 */
		public var massless:Boolean;
		public function MutualGravity(strength:Number = 1, maxDistance:Number = 100, attenuationPower:Number = 1) {
			priority = -3;
			
			this.strength = strength;
			this.maxDistance = maxDistance;
			this.epsilon = 1;
			this.attenuationPower = attenuationPower;
			this.massless = true;
		}
		
		override protected function doMutualAction(p1:Particle2D, p2:Particle2D, time:Number):void {
			var dx:Number = p1.x - p2.x;
			var dy:Number = p1.y - p2.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			if (dist < epsilon) dist = epsilon;
			
			var r:Vec2D = Vec2DPool.get(dx, dy);
			if (massless) {
				r.length = strength * Math.pow(dist, -attenuationPower);
				p2.vx += r.x * time;
				p2.vy += r.y * time;
				p1.vx -= r.x * time;
				p1.vy -= r.y * time;
			} else {
				var str:Number = strength * p1.mass * p2.mass * Math.pow(dist, -attenuationPower);
				r.length = str / p2.mass;
				p2.vx += r.x * time;
				p2.vy += r.y * time;
				r.length = str / p1.mass;
				p1.vx -= r.x * time;
				p1.vy -= r.y * time;
			}
			Vec2DPool.recycle(r);
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "MutualGravity";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@strength = strength;
			xml.@epsilon = epsilon;
			xml.@attenuationPower = attenuationPower;
			xml.@massless = massless;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@strength.length()) strength = parseFloat(xml.@strength);
			if (xml.@epsilon.length()) epsilon = parseFloat(xml.@epsilon);
			if (xml.@attenuationPower.length()) attenuationPower = parseFloat(xml.@attenuationPower);
			if (xml.@massless.length()) massless = (xml.@massless == "true");
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}