package idv.cjcat.stardustextended.common.actions {
	import idv.cjcat.stardustextended.common.actions.triggers.DeathTrigger;
	import idv.cjcat.stardustextended.common.actions.triggers.LifeTrigger;
	
	/**
	 * Defines priorities of some common actions for both 2D and 3D.
	 */
	public class CommonActionPriority extends ActionPriority {
		
		private static var _instance:CommonActionPriority;
		
		public static function getInstance():CommonActionPriority {
			if (!_instance) _instance = new CommonActionPriority();
			return _instance;
		}
		
		public function CommonActionPriority() {
			
		}
		
		override protected final function populatePriorities():void {
			priorities[DeathLife] = -1;
			
			priorities[DeathTrigger] = -5;
			priorities[LifeTrigger] = -5;
		}
	}
}