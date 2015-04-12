package idv.cjcat.stardustextended.common.initializers {
	import idv.cjcat.stardustextended.common.math.Random;
	import idv.cjcat.stardustextended.common.math.UniformRandom;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	
	/**
	 * Sets a particle's mass value based on the <code>random</code> property.
	 *
	 * <p>
	 * A particle's mass is important in collision and gravity simulation.
	 * </p>
	 */
	public class Mass extends Initializer {
		
		private var _random:Random;
		public function Mass(random:Random = null) {
			this.random = random;
		}
		
		public function get random():Random { return _random; }
		public function set random(value:Random):void {
			if (!value) value = new UniformRandom(1, 0);
			_random = value;
		}
		
		override public final function initialize(particle:Particle):void {
			particle.mass = random.random();
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [_random];
		}
		
		override public function getXMLTagName():String {
			return "Mass";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@random = random.name;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@random.length()) random = builder.getElementByName(xml.@random) as Random;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}