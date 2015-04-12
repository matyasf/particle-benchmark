package idv.cjcat.stardustextended.cjsignals {
	import flash.events.IEventDispatcher;
	
	/**
	 * Defines the interface for the <code>NativeSignal</code> class.
	 */
	public interface INativeSignal extends ISignal {
		/**
		 * Sets the event dispatcher whose event is relayed to the signal.
		 * @param	dispatcher The event dispatcher. If null, nothing is changed.
		 * @param	eventType The event type. If null, nothing is changed.
		 * @param	priority The priority of the signal listening to the event dispatcher.
		 * @param	useCapture
		 */
		function listen(dispatcher:IEventDispatcher, eventType:String, priority:int = 0, useCapture:Boolean = false):void;
		
		/**
		 * Unlistens to the event dispatcher, disabling the signal.
		 */
		function unlisten():void;
	}
}