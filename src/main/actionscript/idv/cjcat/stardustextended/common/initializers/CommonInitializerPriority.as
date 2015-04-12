package idv.cjcat.stardustextended.common.initializers {
	
	/**
	 * The subclasses of this class specify priorities of some initializers. 
	 * Initializer priorities are zero by default.
	 */
	public class CommonInitializerPriority extends InitializerPriority {
		
		private static var _instance:CommonInitializerPriority;
		
		public static function getInstance():CommonInitializerPriority {
			if (!_instance) _instance = new CommonInitializerPriority();
			return _instance;
		}
		
		public function CommonInitializerPriority() {
			
		}
		
		override protected final function populatePriorities():void {
			priorities[Mask] = 1;
		}
	}
}