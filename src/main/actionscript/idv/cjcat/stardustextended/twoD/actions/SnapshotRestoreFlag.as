package idv.cjcat.stardustextended.twoD.actions {
	
	public class SnapshotRestoreFlag {
		
		public static const POSITION	:int = 1;
		public static const ROTATION	:int = 1 << 2;
		public static const SCALE		:int = 1 << 3;
		
		public static const ALL			:int = POSITION | ROTATION | SCALE;
	}
}