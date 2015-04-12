package idv.cjcat.stardustextended.cjsignals {
	
	/**
	 * Defines the interface for the <code>Signal</code> class.
	 * @see idv.cjcat.signals.Signal
	 */
	public interface ISignal {
		/**
		 * A copy of the array of listeners listening to this signal.
		 */
		function get listeners():Array;
		
		/**
		 * A copy of the array of the signal's value classes.
		 */
		function get valueClasses():Array;
		
		/**
		 * Removes all listeners.
		 * <p/>
		 * You clear all listeners within a listener during a dispatch, but it will only 
		 * take effect after the dispatch is finished.
		 */
		function clear():void;
		
		/**
		 * Adds a listener to the signal. 
		 * Re-adding a listener that is already added to the signal overwrites its priority. 
		 * If a listener was added to the signal through the <code>addOnce()</code> method 
		 * and is not removed yet, the "onceness" is removed.
		 * <p/>
		 * You may add listeners within a listener during a dispatch, but it will only 
		 * take effect after the dispatch is finished.
		 * @param	listener The listener function, whose parameter types shall match 
		 * the signal's <code>valueClasses</code> array.
		 * @param	priority The priority of the listener function. Listeners with
		 * higher priority are invoked first when value objects are dispatched. 
		 * When two listeners have equal priority, whichever is added first is invoked first.
		 * @return The listener function.
		 */
		function add(listener:Function, priority:int = 0):Function;
		
		/**
		 * Same as the <code>addListner()</code> method, only that the listener is removed
		 * right after it is invoked when value objects are dispatched. 
		 * Re-adding a listener that is already added to the signal overwrites its priority. 
		 * If a listener was added to the signal through the <code>addOnce()</code> method 
		 * and is not removed yet, the "onceness" is added.
		 * <p/>
		 * You may add listeners within a listener during a dispatch, but it will only 
		 * take effect after the dispatch is finished.
		 * @param	listener The listener function, whose parameter types shall match 
		 * the signal's <code>valueClasses</code> array.
		 * @param	priority The priority of the listener function. Listeners with
		 * higher priority are invoked first when value objects are dispatched. 
		 * When two listeners have equal priority, whichever is added first is invoked first.
		 * @return The listener function.
		 */
		function addOnce(listener:Function, priority:int = 0):Function;
		
		/**
		 * Removes a listener function from the signal.
		 * <p/>
		 * You may remove listeners within a listener during a dispatch, but it will only 
		 * take effect after the dispatch is finished.
		 * @param	listener The listener function.
		 * @return The listener function.
		 */
		function remove(listener:Function):Function;
		
		/**
		 * Dispatches value objects. Listener functions added to the signal are invoked 
		 * with value objects passed as arguments.
		 * <p/>
		 * You may add or remove listeners within a listener during a dispatch, but it will only 
		 * take effect after the dispatch is finished.
		 * @param	...valueObjects The value objects dispatched.
		 * @return The signal.
		 */
		function dispatch(...valueObjects):Signal;
		
		/**
		 * @param	listener
		 * @return The prioirty of the listener function.
		 */
		function getPriority(listener:Function):Number;
	}
}