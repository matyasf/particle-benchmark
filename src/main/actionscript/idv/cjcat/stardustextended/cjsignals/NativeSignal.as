package idv.cjcat.stardustextended.cjsignals {
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * This class relays native events dispatched by event dispatchers to signals.
	 */
	public class NativeSignal extends Signal implements INativeSignal {
		
		private var _dispatcher:IEventDispatcher;
		private var _eventType:String;
		private var _useCapture:Boolean;
		
		/**
		 * Creates a signal triggered by native events.
		 * @param	dispatcher The event dispatcher.
		 * @param	eventType The event type.
		 * @param	priority The priority of the signal listening to the event dispatcher.
		 * @param	useCapture
		 */
		public function NativeSignal(dispatcher:IEventDispatcher, eventType:String, priority:int = 0, useCapture:Boolean = false) {
			super(Event);
			listen(dispatcher, eventType, priority, useCapture);
		}
		
		/**
		 * @inheritDoc
		 */
		public final function listen(dispatcher:IEventDispatcher, eventType:String, priority:int = 0, useCapture:Boolean = false):void {
			if (dispatcher && eventType) {
				if (_dispatcher) _dispatcher.removeEventListener(_eventType, onEvent, _useCapture);
				_dispatcher = dispatcher;
				_eventType = eventType;
				_useCapture = useCapture;
				_dispatcher.addEventListener(eventType, onEvent, useCapture, priority);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public final function unlisten():void {
			if (_dispatcher) {
				_dispatcher.removeEventListener(_eventType, onEvent, _useCapture);
				_dispatcher = null;
			}
		}
		
		private final function onEvent(e:Event):void {
			dispatch(e);
		}
	}
}