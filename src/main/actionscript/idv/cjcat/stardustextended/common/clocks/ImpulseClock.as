package idv.cjcat.stardustextended.common.clocks {
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	
	/**
	 * The impulse clock causes the emitter to create a single burst of particles right after the <code>impulse()</code> method is called.
	 */
	public class ImpulseClock extends Clock {

		/**
		 * The time between bursts. You have to implement this functionality, Stardust is not using this property.
		 */
		public var burstInterval:int = 33;
		/**
		 * How many particles to burst out after each <code>impulse()</code> call.
		 */
		public var impulseCount:int;
		private var _repeatCount:int;
		private var _dischargeCount:int;
		private var _discharged:Boolean;
		
		public function ImpulseClock(impulseCount:int = 0, repeatCount:int = 1) {
			this.impulseCount = impulseCount;
			this.repeatCount = repeatCount;
			_discharged = true;
		}
		
		/**
		 * The repetition count of bursting.
		 * 
		 * <p>
		 * For instance, if set to 2, after the <code>impulse()</code> method is called, 
		 * the following successive two <code>getTicks()</code> call would both return a value equal to the <code>impulseCount</code> property. 
		 * After that, the <code>getTicks()</code> method simply returns zero before the next <code>impulse()</code> method call.
		 * </p>
		 */
		public function get repeatCount():int { return _repeatCount; }
		public function set repeatCount(value:int):void {
			if (value < 1) value = 1;
			_repeatCount = value;
		}
		
		/**
		 * The emitter step after the <code>impulse()</code> call creates a burst of particles.
		 */
		public function impulse():void {
			_dischargeCount = 0;
			_discharged = false;
		}
		
		override public final function getTicks(time:Number):int {
			var ticks:int;
			if (!_discharged) {
				if (_dischargeCount >= repeatCount) {
					_discharged = true;
					ticks = 0;
				} else {
					ticks = impulseCount;
					_dischargeCount++;
				}
			} else {
				ticks = 0;
			}
			return ticks;
		}

        override public function reset() : void
        {
            _discharged = true;
            _dischargeCount = 0;
        }
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "ImpulseClock";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@impulseCount = impulseCount;
			xml.@repeatCount = repeatCount;
			xml.@burstInterval = burstInterval;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@impulseCount.length()) impulseCount = parseInt(xml.@impulseCount);
			if (xml.@repeatCount.length()) repeatCount = parseInt(xml.@repeatCount);
			if (xml.@burstInterval.length()) burstInterval = parseInt(xml.@burstInterval);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}