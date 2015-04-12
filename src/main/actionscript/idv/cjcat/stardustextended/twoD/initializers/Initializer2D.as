package idv.cjcat.stardustextended.twoD.initializers {
	import idv.cjcat.stardustextended.common.initializers.Initializer;
	
	/**
	 * Base class for 2D initializers.
	 */
	public class Initializer2D extends Initializer {
		
		public function Initializer2D() {
			_supports3D = false;
			
			//priority = Initializer2DPriority.getInstance().getPriority(Object(this).constructor as Class);
		}
	}
}