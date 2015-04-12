package idv.cjcat.stardustextended.threeD.initializers {
	import idv.cjcat.stardustextended.common.initializers.InitializerPriority;
	
	/**
	 * Defines priorities of some 3D initializers.
	 */
	public class Initializer3DPriority extends InitializerPriority {
		
		private static var _instance:Initializer3DPriority;
		
		public static function getInstance():Initializer3DPriority {
			if (!_instance) _instance = new Initializer3DPriority();
			return _instance;
		}
		
		public function Initializer3DPriority() {
			
		}
		
		override protected final function populatePriorities():void {
			priorities[DisplayObjectClass3D] = 1;
			priorities[PooledDisplayObjectClass3D] = 1;
		}
	}
}