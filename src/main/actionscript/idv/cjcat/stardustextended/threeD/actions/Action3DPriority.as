package idv.cjcat.stardustextended.threeD.actions {
	import idv.cjcat.stardustextended.common.actions.ActionPriority;
	import idv.cjcat.stardustextended.threeD.actions.triggers.DeflectorTrigger3D;
	import idv.cjcat.stardustextended.threeD.actions.triggers.ZoneTrigger3D;
	
	/**
	 * Defines priorities of some 3D actions.
	 */
	public class Action3DPriority extends ActionPriority {
		
		private static var _instance:Action3DPriority;
		
		public static function getInstance():Action3DPriority {
			if (!_instance) _instance = new Action3DPriority();
			return _instance;
		}
		
		public function Action3DPriority() {
			
		}
		
		override protected final function populatePriorities():void {
			priorities[Damping3D] = -1;
			
			priorities[VelocityField3D] = -2;
			
			priorities[Gravity3D] = -3;
			priorities[MutualGravity3D] = -3;
			priorities[RandomDrift3D] = -3;
			
			priorities[Move3D] = -4;
			priorities[Spin3D] = -4;
			
			priorities[Deflect3D] = -5;
			
			priorities[BillboardOriented] = -6;
			priorities[Collide3D] = -6;
			priorities[DeathZone3D] = -6;
			priorities[Oriented3D] = -6;
			priorities[ZoneTrigger3D] = -6;
			priorities[DeflectorTrigger3D] = -6;
			
			priorities[SnapshotRestore3D] = -7;
		}
	}
}