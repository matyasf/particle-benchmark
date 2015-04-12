package idv.cjcat.stardustextended.common.xml {
	
	/**
	 * An <code>XMLBuilder</code> object needs to know the mapping between an XML tag's name and an actual class. 
	 * This class encapsulates multiple classes for the <code>XMLBuilder.registerClassesFromClassPackage()</code> method 
	 * to register multiple classes (i.e. build the mapping relations).
	 */
	public class ClassPackage {
		
		private static var _instance:ClassPackage;
		
		protected var classes:Array;
		
		public static function getInstance():ClassPackage {
			if (_instance) _instance = new ClassPackage();
			return _instance;
		}
		
		public function ClassPackage() {
			classes = [];
			populateClasses();
		}
		
		/**
		 * Returns an array of classes.
		 * @return
		 */
		public final function getClasses():Array { return classes.concat(); }
		
		/**
		 * [Abstract Method] Populates classes.
		 */
		protected function populateClasses():void {
			
		}
	}
}