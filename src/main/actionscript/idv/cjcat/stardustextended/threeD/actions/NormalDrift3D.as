package idv.cjcat.stardustextended.threeD.actions {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.math.Random;
	import idv.cjcat.stardustextended.common.math.UniformRandom;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.threeD.geom.Vec3D;
	import idv.cjcat.stardustextended.threeD.geom.Vec3DPool;
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	/**
	 * Applies acceleration normal to a particle's velocity to the particle.
	 */
	public class NormalDrift3D extends Action3D {
		
		/**
		 * Whether the particles acceleration is divided by their masses before applied to them, true by default. 
		 * When set to true, it simulates a gravity that applies equal acceleration on all particles.
		 */
		public var massless:Boolean;
		/**
		 * The accleration ranges from -max to max.
		 */
		public var max:Number;
		private var _random:Random;
		public function NormalDrift3D(max:Number = 0.2, random:Random = null) {
			this.massless = true;
			this.max = max;
			this.random = random;
		}
		
		/**
		 * The random object used to generate a random number for the acceleration in the range [-max, max], uniform random by default. 
		 * You don't have to set the ranodm object's range. The range is automatically set each time before the random generation.
		 */
		public function get random():Random { return _random; }
		public function set random(value:Random):void {
			if (!value) value = new UniformRandom();
			_random = value;
		}
		
		override public final function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			var p3D:Particle3D = Particle3D(particle);
			var v:Vec3D = Vec3DPool.get(p3D.vx, p3D.vy, p3D.vz);
			var temp:Vec3D = Vec3DPool.get(Math.random(), Math.random(), Math.random());
			temp = temp.cross(v);
			random.setRange( -max, max);
			temp.length = random.random();
			temp.rotateThis(v, 360 * Math.random());
			if (!massless) v.length /= p3D.mass;
			p3D.vx += temp.x * timeDelta;
			p3D.vy += temp.y * timeDelta;
			p3D.vz += temp.z * timeDelta;
			
			Vec3DPool.recycle(v);
			Vec3DPool.recycle(temp);
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "NormalDrift3D";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@massless = massless;
			xml.@max = max;
			xml.@random = _random.name;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@massless.length()) massless = (xml.@massless == "true");
			if (xml.@max.length()) max = parseFloat(xml.@max);
			if (xml.@random.length()) random = builder.getElementByName(xml.@random) as Random;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}