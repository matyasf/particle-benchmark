package idv.cjcat.stardustextended.common.initializers {

import idv.cjcat.stardustextended.common.math.UniformRandom;
import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	
	public class Color extends Initializer {

		public var colorR : UniformRandom;
		public var colorG : UniformRandom;
		public var colorB : UniformRandom;

        public var endColorR : UniformRandom;
        public var endColorG : UniformRandom;
        public var endColorB : UniformRandom;

        /**
		 * Initializes a particle to the given color. Color values are in the [0-1] range where 0
		 * is the lack of the color. For example (0,0,0) means black, (1,1,1) means white.
         * Note that you can define color values outside the [0,1] range too to 'overdrive' the shader.
		 */
		public function Color()
		{
			colorR = new UniformRandom(0.5, 0.5);
			colorG = new UniformRandom(0.5, 0.5);
			colorB = new UniformRandom(0.5, 0.5);

            endColorR = new UniformRandom(0.5, 0.5);
            endColorG = new UniformRandom(0.5, 0.5);
            endColorB = new UniformRandom(0.5, 0.5);
		}
		
		override public final function initialize(particle:Particle):void {
			particle.initColorR = colorR.random();
			particle.initColorB = colorB.random();
			particle.initColorG = colorG.random();

            particle.endColorR = endColorR.random();
            particle.endColorB = endColorG.random();
            particle.endColorG = endColorB.random();

            particle.colorR = particle.initColorR;
            particle.colorG = particle.initColorG;
            particle.colorB = particle.initColorB;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		override public function getXMLTagName():String {
			return "Color";
		}

		override public function getRelatedObjects():Array {
			return [colorR, colorB, colorG, endColorR, endColorG, endColorB];
		}

		override public function toXML():XML {
			var xml:XML = super.toXML();
			xml.@colorR = colorR.name;
			xml.@colorG = colorG.name;
			xml.@colorB = colorB.name;
			xml.@endColorR = endColorR.name;
			xml.@endColorG = endColorG.name;
			xml.@endColorB = endColorB.name;
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);

			colorR = builder.getElementByName(xml.@colorR) as UniformRandom;
			colorG = builder.getElementByName(xml.@colorG) as UniformRandom;
			colorB = builder.getElementByName(xml.@colorB) as UniformRandom;
            if (xml.@endColorR.length()) endColorR = builder.getElementByName(xml.@endColorR) as UniformRandom;
            if (xml.@endColorG.length()) endColorG = builder.getElementByName(xml.@endColorG) as UniformRandom;
            if (xml.@endColorB.length()) endColorB = builder.getElementByName(xml.@endColorB) as UniformRandom;
		}
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}