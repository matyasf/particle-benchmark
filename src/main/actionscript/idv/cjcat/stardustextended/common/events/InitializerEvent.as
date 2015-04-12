package idv.cjcat.stardustextended.common.events {
	import flash.events.Event;
	import idv.cjcat.stardustextended.common.initializers.Initializer;

	/**
	 * Event dispatched by initializers.
	 */
	public class InitializerEvent extends Event {
		
		/**
		 * This event is dispatched when an initializer's priority value is changed.
		 */
		public static const PRIORITY_CHANGE:String = "stardustInitializerPriorityChange";
		
		private var _initializer:Initializer;
		public function InitializerEvent(type:String, initializer:Initializer) {
			super(type);
			_initializer = initializer;
		}
		
		/**
		 * The associated initializer.
		 */
		public function get initializer():Initializer { return _initializer; }
	}
}