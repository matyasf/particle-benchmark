package idv.cjcat.stardustextended.common.actions {
	import idv.cjcat.stardustextended.common.easing.EasingFunctionType;
	import idv.cjcat.stardustextended.common.easing.Linear;
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	
	/**
	 * Alters a particle's scale according to its <code>life</code> property.
	 * 
	 * <p>
	 * The scale transition is applied using the easing functions designed by Robert Penner. 
	 * These functions can be found in the <code>idv.cjcat.stardust.common.easing</code> package.
	 * </p>
	 */
	public class ScaleCurve extends Action {
		
		/**
		 * The initial scale of a particle, 0 by default.
		 */
		public var inScale:Number;
		/**
		 * The final scale of a particle, 0 by default.
		 */
		public var outScale:Number;
		
		/**
		 * The transition lifespan of scale from the initial scale to the normal scale.
		 */
		public var inLifespan:Number;
		/**
		 * The transition lifespan of scale from the normal scale to the final scale.
		 */
		public var outLifespan:Number;
		
		private var _inFunction:Function;
		private var _outFunction:Function;
		private var _inFunctionExtraParams:Array;
		private var _outFunctionExtraParams:Array;
		
		public function ScaleCurve(inLifespan:Number = 0, outLifespan:Number = 0, inFunction:Function = null, outFunction:Function = null) {
			this.inScale = 0;
			this.outScale = 0;
			this.inLifespan = inLifespan;
			this.outLifespan = outLifespan;
			this.inFunction = inFunction;
			this.outFunction = outFunction;
			this.inFunctionExtraParams = [];
			this.outFunctionExtraParams = [];
		}
		
		override public final function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			if ((particle.initLife - particle.life) < inLifespan) {
                if (_inFunction != null)
                {
                    particle.scale = _inFunction.apply(null,[particle.initLife - particle.life, inScale, particle.initScale - inScale, inLifespan].concat(_inFunctionExtraParams));
                }
                else
                {
                    particle.scale = Linear.easeIn(particle.initLife - particle.life, inScale, particle.initScale - inScale, inLifespan);
                }
			} else if (particle.life < outLifespan) {
                if (_outFunction != null)
                {
                    particle.scale = _outFunction.apply(null,[outLifespan - particle.life, particle.initScale, outScale - particle.initScale, outLifespan].concat(_outFunctionExtraParams));
                }
                else
                {
                    particle.scale = Linear.easeOut(outLifespan - particle.life, particle.initScale, outScale - particle.initScale, outLifespan);
                }
			} else {
				particle.scale = particle.initScale;
			}
		}
		
		/**
		 * Some easing functions take more than four parameters. This property specifies those extra parameters passed to the <code>inFunction</code>.
		 */
		public function get inFunctionExtraParams():Array { return _inFunctionExtraParams; }
		public function set inFunctionExtraParams(value:Array):void {
			if (!value) value = [];
			_inFunctionExtraParams = value;
		}
		
		/**
		 * Some easing functions take more than four parameters. This property specifies those extra parameters passed to the <code>outFunction</code>.
		 */
		public function get outFunctionExtraParams():Array { return _outFunctionExtraParams; }
		public function set outFunctionExtraParams(value:Array):void {
			if (!value) value = [];
			_outFunctionExtraParams = value;
		}
		
		/**
		 * The easing function from the initial scale to the normal scale, <code>Linear.easeIn</code> by default.
		 */
		public function get inFunction():Function { return _inFunction; }
		public function set inFunction(value:Function):void {
			_inFunction = value;
		}
		
		/**
		 * The easing function from the normal scale to the final scale, <code>Linear.easeOut</code> by default.
		 */
		public function get outFunction():Function { return _outFunction; }
		public function set outFunction(value:Function):void {
			_outFunction = value;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "ScaleCurve";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@inScale = inScale;
			xml.@outScale = outScale;
			xml.@inLifespan = inLifespan;
			xml.@outLifespan = outLifespan;
            if (_inFunction != null)
            {
                xml.@inFunction = EasingFunctionType.functions[_inFunction];
            }
            if (_outFunction != null)
            {
                xml.@outFunction = EasingFunctionType.functions[_outFunction];
            }
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@inScale.length()) inScale = parseFloat(xml.@inScale);
			if (xml.@outScale.length()) outScale = parseFloat(xml.@outScale);
			if (xml.@inLifespan.length()) inLifespan = parseFloat(xml.@inLifespan);
			if (xml.@outLifespan.length()) outLifespan = parseFloat(xml.@outLifespan);
			if (xml.@inFunction.length()) inFunction = EasingFunctionType.functions[xml.@inFunction.toString()];
			if (xml.@outFunction.length()) outFunction = EasingFunctionType.functions[xml.@outFunction.toString()];
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}