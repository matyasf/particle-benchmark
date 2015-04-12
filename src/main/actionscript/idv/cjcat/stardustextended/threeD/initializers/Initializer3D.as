package idv.cjcat.stardustextended.threeD.initializers {
	import idv.cjcat.stardustextended.common.initializers.Initializer;
	
	/**
	 * Base class for 3D initializers.
	 */
	public class Initializer3D extends Initializer {
		
		public function Initializer3D() {
			_supports2D = false;
			
			//priority = Initializer3DPriority.getInstance().getPriority(Object(this).constructor as Class);
		}
	}
}