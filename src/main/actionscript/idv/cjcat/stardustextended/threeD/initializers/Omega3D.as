package idv.cjcat.stardustextended.threeD.initializers {
	import idv.cjcat.stardustextended.common.math.Random;
	import idv.cjcat.stardustextended.common.math.UniformRandom;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * Sets a particle's omega values (angular velocity), in degrees per emitter step, based on the <code>randomX</code>, <code>randomY</code>, and <code>randomZ</code> properties.
	 * 
	 * <p>
	 * For 3D objects, there are three omega values for each axis.
	 * </p>
	 */
	public class Omega3D extends Initializer3D {
		
		private var _randomX:Random;
		private var _randomY:Random;
		private var _randomZ:Random;
		public function Omega3D(randomX:Random = null, randomY:Random = null, randomZ:Random = null) {
			this.randomX = randomX;
			this.randomY = randomY;
			this.randomZ = randomZ;
		}
		
		override public final function initialize(particle:Particle):void {
			var p3D:Particle3D = Particle3D(particle);
			p3D.omegaX = _randomX.random();
			p3D.omegaY = _randomY.random();
			p3D.omegaZ = _randomZ.random();
		}
		
		public function get randomX():Random { return _randomX; }
		public function set randomX(value:Random):void {
			if (!value) value = new UniformRandom(0, 0);
			_randomX = value;
		}
		
		public function get randomY():Random { return _randomY; }
		public function set randomY(value:Random):void {
			if (!value) value = new UniformRandom(0, 0);
			_randomY = value;
		}
		
		public function get randomZ():Random { return _randomZ; }
		public function set randomZ(value:Random):void {
			if (!value) value = new UniformRandom(0, 0);
			_randomZ = value;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [_randomX, _randomY, _randomZ];
		}
		
		override public function getXMLTagName():String {
			return "Omega3D";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@randomX = _randomX.name;
			xml.@randomY = _randomY.name;
			xml.@randomZ = _randomZ.name;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@randomX.length()) randomX = builder.getElementByName(xml.@randomX) as Random;
			if (xml.@randomY.length()) randomY = builder.getElementByName(xml.@randomY) as Random;
			if (xml.@randomZ.length()) randomZ = builder.getElementByName(xml.@randomZ) as Random;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}