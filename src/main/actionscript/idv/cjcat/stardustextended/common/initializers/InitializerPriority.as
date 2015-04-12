package idv.cjcat.stardustextended.common.initializers {
	import flash.utils.Dictionary;
	
	/**
	 * The subclasses of this class specify priorities of some initializers.
	 * Initializer priorities are zero by default.
	 */
	public class InitializerPriority {
		
		private static var _instance:InitializerPriority;
		
		public static function getInstance():InitializerPriority {
			if (!_instance) _instance = new InitializerPriority();
			return _instance;
		}
		
		protected var priorities:Dictionary;
		
		public function InitializerPriority() {
			priorities = new Dictionary();
			
			populatePriorities();
		}
		
		public function getPriority(actionClass:Class):int {
			if (priorities[actionClass] == undefined) return 0;
			return priorities[actionClass];
		}
		
		protected function populatePriorities():void {
			//abstract method
		}
	}
}