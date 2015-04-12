package idv.cjcat.stardustextended.twoD.geom {
	
	/**
	 * 4D vector value class.
	 */
	public class MotionData4D {
		public var x:Number;
		public var y:Number;
		public var vx:Number;
		public var vy:Number;
		
		public function MotionData4D(x:Number = 0, y:Number = 0, vx:Number = 0, vy:Number = 0) {
			this.x = x;
			this.y = y;
			this.vx = vx;
			this.vy = vy;
		}
	}
}