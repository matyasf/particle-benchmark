package idv.cjcat.stardustextended.common.initializers {
	import idv.cjcat.stardustextended.sd;
	
	use namespace sd;
	
	/**
	 * This class is used internally by classes that implements the <code>InitializerCollector</code> interface.
	 */
	public class InitializerCollection implements InitializerCollector {
		
		/** @private */
		sd var initializers:Array;
		
		public function InitializerCollection() {
			initializers = [];
		}
		
		public final function addInitializer(initializer:Initializer):void {
			if (initializers.indexOf(initializer) >= 0) return;
			initializers.push(initializer);
			initializer.onPriorityChange.add(sortInitializers);
			sortInitializers();
		}
		
		public final function removeInitializer(initializer:Initializer):void {
			var index:int;
			if ((index = initializers.indexOf(initializer)) >= 0) {
				var toRem:Initializer = Initializer(initializers.splice(index, 1)[0]);
				toRem.onPriorityChange.remove(sortInitializers);
			}
		}
		
		public final function sortInitializers(initializer:Initializer = null):void {
			initializers.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
		}
		
		public final function clearInitializers():void {
			for each (var initializer:Initializer in initializers) removeInitializer(initializer);
		}
	}
}