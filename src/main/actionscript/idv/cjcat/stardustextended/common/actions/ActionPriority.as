package idv.cjcat.stardustextended.common.actions {
	import flash.utils.Dictionary;
	
	/**
	 * The subclasses of this class specify priorities of some actions.
	 * Action priorities are zero by default.
	 */
	public class ActionPriority {
		
		private static var _instance:ActionPriority;
		
		public static function getInstance():ActionPriority {
			if (!_instance) _instance = new ActionPriority();
			return _instance;
		}
		
		protected var priorities:Dictionary;
		
		public function ActionPriority() {
			priorities = new Dictionary();
			
			populatePriorities();
		}
		
		/**
		 * Returns the priority of the given <code>Action</code> subclass.
		 * @param	actionClass
		 * @return
		 */
		public final function getPriority(actionClass:Class):int {
			if (priorities[actionClass] == undefined) return 0;
			return priorities[actionClass];
		}
		
		protected function populatePriorities():void {
			//abstract method
		}
	}
}