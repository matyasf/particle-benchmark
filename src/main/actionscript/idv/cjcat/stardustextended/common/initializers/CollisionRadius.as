package idv.cjcat.stardustextended.common.initializers {
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	
	/**
	 * Particles are simulated as circles for collision simulation.
	 * 
	 * <p>
	 * This initializer sets the collision radius of a particle.
	 * </p>
	 */
	public class CollisionRadius extends Initializer {
		
		/**
		 * The collsion radius.
		 */
		public var radius:Number;
		public function CollisionRadius(radius:Number = 0) {
			this.radius = radius;
		}
		
		override public final function initialize(particle:Particle):void {
			particle.collisionRadius = radius;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "CollisionRadius";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@radius = radius;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@radius.length()) radius = parseFloat(xml.@radius);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}