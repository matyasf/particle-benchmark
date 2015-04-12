package idv.cjcat.stardustextended.common.actions {

	/**
	 * This class is used internally by classes that implements the <code>ActionCollector</code> interface.
	 */
	public class ActionCollection implements ActionCollector {
		
		protected var _actions:Array;
		
		public function ActionCollection() {
			_actions = [];
		}

		public function get actions() : Array {
			return _actions;
		}

		public final function addAction(action:Action):void {
			if (_actions.indexOf(action) >= 0) return;
			_actions.push(action);
			action.onPriorityChange.add(sortActions);
			sortActions();
		}
		
		public final function removeAction(action:Action):void {
			var index:int;
			if ((index = _actions.indexOf(action)) >= 0) {
				var toRem:Action = Action(_actions.splice(index, 1)[0]);
				toRem.onPriorityChange.remove(sortActions);
			}
		}
		
		public final function clearActions():void {
			for each (var action:Action in _actions) removeAction(action);
		}
		
		public final function sortActions(action:Action = null):void {
			_actions.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
		}
	}
}