package idv.cjcat.stardustextended.common.initializers {
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	
	/**
	 * A composite initializer is a group of initiailizers.
	 * 
	 * <p>
	 * This class is usually used with the <code>SwitchInitializer</code> class to switch among multiple initializer groups to create different particles.
	 * </p>
	 */
	public class CompositeInitializer extends Initializer implements InitializerCollector {
		
		protected var initializers:Array;
		public function CompositeInitializer() {
			initializers = [];
		}
		
		override public final function initialize(particle:Particle):void {
			for each (var initializer:Initializer in initializers) {
				initializer.initialize(particle);
			}
		}
		
		public function addInitializer(initializer:Initializer):void {
			if (initializers.indexOf(initializer) < 0) initializers.push(initializer);
			initializer.onPriorityChange.add(sortInitializers);
			sortInitializers();
		}
		
		public function removeInitializer(initializer:Initializer):void {
			var index:int;
			if ((index = initializers.indexOf(initializer)) >= 0) {
				var toRem:Initializer = initializers.splice(index, 1)[0] as Initializer;
				toRem.onPriorityChange.remove(sortInitializers);
			}
		}
		
		public final function sortInitializers(initializer:Initializer = null):void {
			initializers.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
		}
		
		public function clearInitializers():void {
			for each (var initializer:Initializer in initializers) removeInitializer(initializer);
		}
		
		override public final function recycleInfo(particle:Particle):void {
			for each (var initializer:Initializer in initializers) {
				initializer.recycleInfo(particle);
			}
		}
		
		override public final function get needsRecycle():Boolean {
			for each (var initializer:Initializer in initializers) {
				if (initializer.needsRecycle) return true;
			}
			return false;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return initializers;
		}
		
		override public function getXMLTagName():String {
			return "CompositeInitializer";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			if (initializers.length > 0) {
				xml.appendChild(<initializers/>);
				var initializer:Initializer;
				for each (initializer in initializers) {
					xml.initializers.appendChild(initializer.getXMLTag());
				}
			}
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			clearInitializers();
			for each (var node:XML in xml.initializers.*) {
				addInitializer(builder.getElementByName(node.@name) as Initializer);
			}
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}