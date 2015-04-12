package idv.cjcat.stardustextended.cjsignals {
	import flash.utils.Dictionary;
	
	/**
	 * This class serves as the Subject in the Observer Pattern. 
	 * Listeners function listening to a signal are Observers. 
	 * One signal should correspond to one type of event. 
	 * A signal adds event-dispatching functionality thorugh composition rather than 
	 * inheriting the <code>EventDispatcher</code> class.
	 * <p/>
	 * A class with signals should expose getters to its signal objects, 
	 * allowing external listeners to listen to the signals.
	 */
	public class Signal implements ISignal {
		
		private static const DEFAULT_ARRAY_SIZE:int = 4;
		
		/**
		 * @inheritDoc
		 */
		public function get listeners():Array {
			//does not affect the current dispatch
			if (_listenerArrayNeedsCloning) {
				_listenerArray = _listenerArray.concat();
				_listenerArrayNeedsCloning = false;
			}
			
			if (_arrayDirty) sortListeners();
			
			var array:Array =
				(_isDispatching)?
				(_currentListenerArray.slice(0, _currentIndex)):
				(_listenerArray.slice(0, _index));
			
			for (var i:int = 0, len:int = array.length; i < len; ++i) {
				array[i] = ListenerData(array[i]).listener;
			}
			return array;
		}
		
		private var _listenerArray:Array;
		private var _index:int;
		private var _listenerDictionary:Dictionary;
		private var _arrayDirty:Boolean;
		
		
		//variables for handling add()/remove()/clear() during dispatch
		//-------------------------------------------------
		private var _currentListenerArray:Array;
		private var _currentIndex:int;
		private var _isDispatching:Boolean;
		private var _listenerArrayNeedsCloning:Boolean;
		private var _clearAfterDispatch:Boolean;
		
		
		private var _valueClasses:Array;
		/**
		 * @inheritDoc
		 */
		public function get valueClasses():Array { return _valueClasses.concat(); }
		
		/**
		 * Creates a signal to dispatch value objects.
		 * @param	...valueClasses An array of <code>Class</code> object references 
		 * for value object type-checking upon the invocation of the 
		 * <code>dispatch()</code> method.
		 * <p/>
		 * For instance, <code>new Signal(int, String)</code> allows
		 * <p/>
		 * <code>dispatch(123, "abc")</code>
		 * <p/>
		 * but not
		 * <p/>
		 * <code>dispatch("abc", 123)</code>
		 * <p/>
		 * nor
		 * <p/>
		 * <code>dispatch(123, "abc", true)</code>
		 * <p/>
		 * nor
		 * <p/>
		 * <code>dispatch()</code>
		 */
		public function Signal(...valueClasses) {
			_valueClasses = valueClasses;
			
			_currentListenerArray = _listenerArray = new Array(DEFAULT_ARRAY_SIZE);
			_index = 0;
			_listenerDictionary = new Dictionary();
			
			_isDispatching = false;
			_listenerArrayNeedsCloning = false;
			_clearAfterDispatch = false;
		}
		
		/**
		 * @inheritDoc
		 */
		public final function clear():void {
			if (_listenerArrayNeedsCloning) {
				//finish the current dispatch before clear()
				_clearAfterDispatch = true;
			} else {
				_currentListenerArray = _listenerArray = new Array(DEFAULT_ARRAY_SIZE);
				_index = 0;
				
				for (var key:* in _listenerDictionary) delete _listenerDictionary[key];
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public final function add(listener:Function, priority:int = 0):Function {
			if (listener.length < _valueClasses.length) {
				throw new ArgumentError(
					"Listener has " + listener.length + " " 
					+ ((listener.length == 1)?("argument"):("arguments")) 
					+ " but it needs at least " + _valueClasses.length + "."
				);
			}
			
			//does not affect the current dispatch
			if (_listenerArrayNeedsCloning) {
				_listenerArray = _listenerArray.concat();
				_listenerArrayNeedsCloning = false;
			}
			
			//check if the listener is already added
			var data:ListenerData = _listenerDictionary[listener];
			if (data) {
				//if true, update priority only
				data.priority = priority;
				data.once = false;
			} else {
				data = new ListenerData(listener, priority, false);
				_listenerDictionary[listener] = data;
				data.index = _index;
				++_index;
			}
			
			_listenerArray[_index] = data;
			if (_index == _listenerArray.length) _listenerArray.length *= 2;
			
			_arrayDirty = true;
			
			return listener;
		}
		
		/**
		 * @inheritDoc
		 */
		public final function addOnce(listener:Function, priority:int = 0):Function {
			add(listener, priority);
			ListenerData(_listenerDictionary[listener]).once = true;
			return listener;
		}
		
		/**
		 * @inheritDoc
		 */
		public final function remove(listener:Function):Function {
			var data:ListenerData = _listenerDictionary[listener];
			
			//does not affect the current dispatch
			if (_listenerArrayNeedsCloning) {
				_listenerArray = _listenerArray.concat();
				_listenerArrayNeedsCloning = false;
			}
			
			if (data) {
				_listenerArray[ListenerData(_listenerDictionary[listener]).index] = _listenerArray[--_index];
				_listenerArray[_index] = null;
				
				delete _listenerDictionary[listener];
				
				_arrayDirty = true;
			}
			return listener;
		}
		
		/**
		 * @inheritDoc
		 */
		public final function dispatch(...valueObjects):Signal {
			
			//argument checking
			//-------------------------------------------------
			
			if (valueObjects.length != _valueClasses.length) {
				throw new ArgumentError(
					"Incorrect number of arguments. Expected " + _valueClasses.length
					+ " but was " + valueObjects.length
				);
			}
			
			var i:int, len:int;
			for (i = 0, len = valueObjects.length; i < len; ++i) {
				if ((valueObjects[i] is _valueClasses[i]) || (valueObjects[i] == null)) continue;
				throw new ArgumentError(
					"Incorrect argument type. Expected " + _valueClasses[i]
					+ " but was " + valueObjects[i]
				);
			}
			
			
			//listener invocation
			//-------------------------------------------------
			
			if (_arrayDirty) sortListeners();
			
			_isDispatching = true;
			_listenerArrayNeedsCloning = true;
			_currentListenerArray = _listenerArray;
			_currentIndex = _index;
			
			var data:ListenerData;
			for (i = 0; i < _currentIndex; ++i) {
				data = _currentListenerArray[i];
				data.listener.apply(null, valueObjects);
				if (data.once) remove(data.listener);
			}
			
			_isDispatching = false;
			_listenerArrayNeedsCloning = false;
			_currentListenerArray = _listenerArray;
			_currentIndex = _index;
			
			if (_clearAfterDispatch) {
				clear();
				_clearAfterDispatch = false;
			}
			
			return this;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getPriority(listener:Function):Number {
			if (_listenerDictionary[listener]) return ListenerData(_listenerDictionary[listener]).priority;
			else return NaN;
		}
		
		private function sortListeners():void {
			_listenerArray.sort(prioritySorter);
			for (var i:int = 0; i < _index; ++i) {
				ListenerData(_listenerArray[i]).index = i;
			}
			_arrayDirty = false;
		}
		
		private var _diff:Number;
		private function prioritySorter(data1:ListenerData, data2:ListenerData):Number {
			if (data2) {
				if (data1) {
					return (_diff = data2.priority - data1.priority)?(_diff):(data1.index - data2.index);
				} else {
					return 1;
				}
			} else {
				if (data1) return -1;
				else return 0;
			}
		}
	}
}