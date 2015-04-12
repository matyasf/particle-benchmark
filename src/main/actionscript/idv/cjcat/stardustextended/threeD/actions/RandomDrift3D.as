package idv.cjcat.stardustextended.threeD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.math.Random;
	import idv.cjcat.stardustextended.common.math.UniformRandom;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * Applies acceleration to particles.
	 * 
	 * <p>
	 * Default priority = -2;
	 * </p>
	 */
	public class RandomDrift3D extends Action3D {
		
		/**
		 * Whether the particles acceleration is divided by their masses before applied to them, true by default. 
		 * When set to true, it simulates a gravity that applies equal acceleration on all particles.
		 */
		public var massless:Boolean;
		/**
		 * The accleration's X component ranges from -maxX to maxX.
		 */
		public var maxX:Number;
		/**
		 * The accleration's Y component ranges from -maxY to maxY.
		 */
		public var maxY:Number;
		/**
		 * The accleration's Z component ranges from -maxZ to maxZ.
		 */
		public var maxZ:Number;
		private var _randomX:Random;
		private var _randomY:Random;
		private var _randomZ:Random;
		public function RandomDrift3D(maxX:Number = 0.2, maxY:Number = 0.2, maxZ:Number = 0.2, randomX:Random = null, randomY:Random = null, randomZ:Random = null) {
			priority = -3;
			
			this.massless = true;
			this.maxX = maxX;
			this.maxY = maxY;
			this.maxZ = maxZ;
			this.randomX = randomX;
			this.randomY = randomY;
			this.randomZ = randomZ;
		}
		
		/**
		 * The random object used to generate a random number for the acceleration's x component in the range [-maxX, maxX], uniform random by default. 
		 * You don't have to set the ranodm object's range. The range is automatically set each time before the random generation.
		 */
		public function get randomX():Random { return _randomX; }
		public function set randomX(value:Random):void {
			if (!value) value = new UniformRandom();
			_randomX = value;
		}
		
		/**
		 * The random object used to generate a random number for the acceleration's y component in the range [-maxX, maxX], uniform random by default. 
		 * You don't have to set the ranodm object's range. The range is automatically set each time before the random generation.
		 */
		public function get randomY():Random { return _randomY; }
		public function set randomY(value:Random):void {
			if (!value) value = new UniformRandom();
			_randomY = value;
		}
		
		/**
		 * The random object used to generate a random number for the acceleration's y component in the range [-maxX, maxX], uniform random by default. 
		 * You don't have to set the ranodm object's range. The range is automatically set each time before the random generation.
		 */
		public function get randomZ():Random { return _randomZ; }
		public function set randomZ(value:Random):void {
			if (!value) value = new UniformRandom();
			_randomZ = value;
		}
		
		override public final function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			var p3D:Particle3D = Particle3D(particle);
			
			randomX.setRange( -maxX, maxX);
			randomY.setRange( -maxY, maxY);
			randomZ.setRange( -maxZ, maxZ);
			var rx:Number = randomX.random();
			var ry:Number = randomY.random();
			var rz:Number = randomZ.random();
			
			if (!massless) {
				var factor:Number = 1 / p3D.mass;
				rx *= factor;
				ry *= factor;
				rz *= factor;
			}
			
			p3D.vx += rx * timeDelta;
			p3D.vy += ry * timeDelta;
			p3D.vz += rz * timeDelta;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [_randomX, _randomY, _randomZ];
		}
		
		override public function getXMLTagName():String {
			return "RandomDrift3D";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@massless = massless;
			xml.@maxX = maxX;
			xml.@maxY = maxY;
			xml.@maxZ = maxZ;
			xml.@randomX = _randomX.name;
			xml.@randomY = _randomY.name;
			xml.@randomZ = _randomZ.name;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@massless.length()) massless = (xml.@massless == "true");
			if (xml.@maxX.length()) maxX = parseFloat(xml.@maxX);
			if (xml.@maxY.length()) maxY = parseFloat(xml.@maxY);
			if (xml.@maxZ.length()) maxZ = parseFloat(xml.@maxZ);
			if (xml.@randomX.length()) randomX = builder.getElementByName(xml.@randomX) as Random;
			if (xml.@randomY.length()) randomY = builder.getElementByName(xml.@randomY) as Random;
			if (xml.@randomZ.length()) randomZ = builder.getElementByName(xml.@randomZ) as Random;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}