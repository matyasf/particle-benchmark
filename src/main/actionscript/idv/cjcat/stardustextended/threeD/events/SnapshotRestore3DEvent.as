package idv.cjcat.stardustextended.threeD.events {
	import flash.events.Event;
	
	public class SnapshotRestore3DEvent extends Event {
		
		public static const COMPLETE:String = "stardustSnapshotRestore3DComplete";
		
		public function SnapshotRestore3DEvent(type:String) {
			super(type);
		}
	}
}