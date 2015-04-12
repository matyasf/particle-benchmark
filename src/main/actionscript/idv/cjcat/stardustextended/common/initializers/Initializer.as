package idv.cjcat.stardustextended.common.initializers {

    import idv.cjcat.stardustextended.cjsignals.ISignal;
    import idv.cjcat.stardustextended.cjsignals.Signal;
    import idv.cjcat.stardustextended.common.emitters.Emitter;
    import idv.cjcat.stardustextended.common.particles.InfoRecycler;
    import idv.cjcat.stardustextended.common.particles.Particle;
    import idv.cjcat.stardustextended.common.StardustElement;
    import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	
	/**
	 * An initializer is used to alter just once (i.e. initialize) a particle's properties upon the particle's birth.
	 * 
	 * <p>
	 * An initializer can be associated with an emitter or a particle factory. 
	 * </p>
	 * 
	 * <p>
	 * Default priority = 0;
	 * </p>
	 */
	public class Initializer extends StardustElement implements InfoRecycler {
		
		
		//signals
		//------------------------------------------------------------------------------------------------
		
		private var _onPriorityChange:ISignal = new Signal(Initializer);
		/**
		 * Dispatched when the action's priority is changed.
		 * <p/>
		 * Signature: (initializer:Initializer)
		 */
		public function get onPriorityChange():ISignal { return _onPriorityChange; }
		
		private var _onAdd:ISignal = new Signal(Emitter, Initializer);
		/**
		 * Dispatched when the added to an emitter.
		 * <p/>
		 * Signature: (emitter:Emitter, action:Initializer)
		 */
		public function get onAdd():ISignal { return _onAdd; }
		
		private var _onRemove:ISignal = new Signal(Emitter, Initializer);
		/**
		 * Dispatched when the removed from an emitter.
		 * <p/>
		 * Signature: (emitter:Emitter, action:Initializer)
		 */
		public function get onRemove():ISignal { return _onRemove; }
		
		//------------------------------------------------------------------------------------------------
		//end of signals
		
		
		/**
		 * Denotes if the initializer is active, true by default.
		 */
		public var active:Boolean;
		
		//private var _mask:int;
		private var _priority:int;
		
		/** @private */
		protected var _supports2D:Boolean;
		/** @private */
		protected var _supports3D:Boolean;
		
		public function Initializer() {
			_supports2D = _supports3D = true;
			
			//priority = CommonInitializerPriority.getInstance().getPriority(Object(this).constructor as Class);
			priority = 0;
			
			active = true;
			//_mask = 1;
		}
		
		/**
		 * Whether this initializer supports 2D.
		 */
		public function get supports2D():Boolean { return _supports2D; }
		/**
		 * Whether this initializer supports 3D.
		 */
		public function get supports3D():Boolean { return _supports3D; }
		
		/** @private */
		public function doInitialize(particles:Vector.<Particle>, currentTime : Number):void {
			if (active) {
				var particle:Particle;
                for (var m : int = 0; m < particles.length; ++m) {
                    particle = particles[m];
					initialize(particle);
					if (needsRecycle) particle.recyclers[this] = this;
				}
			}
		}
		
		/**
		 * [Template Method] This is the method that alters a particle's properties.
		 * 
		 * <p>
		 * Override this property to create custom initializers.
		 * </p>
		 * @param	particle
		 */
		public function initialize(particle:Particle):void {
			//abstract method
		}
		
		/**
		 * Initializers will be sorted according to their priorities.
		 * 
		 * <p>
		 * This is important, 
		 * since some initializers may rely on other initializers to perform initialization beforehand. 
		 * You can alter the priority of an initializer, but it is recommended that you use the default values.
		 * </p>
		 */
		public function get priority():int { return _priority; } 	
		public function set priority(value:int):void {
			_priority = value;
			onPriorityChange.dispatch(this);
		}
		
		/**
		 * [Template Method] This method is called after a particle's death if the <code>needsRecycle()</code> method returns true.
		 * @param	particle
		 */
		public function recycleInfo(particle:Particle):void {
			
		}
		
		public function get needsRecycle():Boolean {
			return false;
		}

        public function reset():void {
            //override if needed
        }
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "Initializer";
		}
		
		override public function getElementTypeXMLTag():XML {
			return <initializers/>;
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			
			xml.@active = active;
			//xml.@mask = mask;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@active.length()) active = (xml.@active == "true");
			//mask = parseInt(xml.@mask);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}