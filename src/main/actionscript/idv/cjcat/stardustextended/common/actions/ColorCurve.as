package idv.cjcat.stardustextended.common.actions {

	import idv.cjcat.stardustextended.common.easing.Linear;
	import idv.cjcat.stardustextended.common.emitters.Emitter;
    import idv.cjcat.stardustextended.common.particles.Particle;
	/**
	 * Alters a particle's color during its lifetime.
	 */
	public class ColorCurve extends Action {

        override public final function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
            var currLife : Number = particle.initLife - particle.life;
            particle.colorR = Linear.easeOut(currLife, particle.initColorR, particle.endColorR - particle.initColorR, particle.initLife);
            particle.colorG = Linear.easeOut(currLife, particle.initColorG, particle.endColorG - particle.initColorG, particle.initLife);
            particle.colorB = Linear.easeOut(currLife, particle.initColorB, particle.endColorB - particle.initColorB, particle.initLife);
		}

		//XML
		//------------------------------------------------------------------------------------------------
		override public function getXMLTagName():String {
			return "ColorCurve";
		}
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}