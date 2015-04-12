package idv.cjcat.stardustextended.twoD.geom {
	
	/**
	 * 2D vector value class.
	 * 
	 * <p>
	 * Unlike the <code>Vec2D</code> class, 
	 * the sole purpose of this class is to hold two numeric values (X and Y components). 
	 * It does not provide vector operations like the <code>Vec2D</code> class does.
	 * </p>
	 */
	public class MotionData2D {
		public var x:Number;
		public var y:Number;
		
		public function MotionData2D(x:Number = 0, y:Number = 0) {
			this.x = x;
			this.y = y;
		}
	}
}