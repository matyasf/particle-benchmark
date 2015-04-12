package idv.cjcat.stardustextended.common.math {
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	
	/**
	 * This class calls a <code>Random</code> object's <code>random()</code> method multiple times, 
	 * and averages the value.
	 * 
	 * <p>
	 * The larger the sample count, the more normally distributed the results.
	 * </p>
	 */
	public class AveragedRandom extends Random {
		
		public var randomObj:Random;
		public var sampleCount:int;
		
		public function AveragedRandom(randomObj:Random = null, sampleCount:int = 3) {
			this.randomObj = randomObj;
			this.sampleCount = sampleCount;
		}
		
		override public final function random():Number {
			if (!randomObj) return 0;
			
			var sum:Number = 0;
			for (var i:int = 0; i < sampleCount; i++) sum += randomObj.random();
			
			return sum / sampleCount;
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObjects():Array {
			return [randomObj];
		}
		
		override public function getXMLTagName():String {
			return "AveragedRandom";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@randomObj = randomObj.name;
			xml.@sampleCount = sampleCount;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@randomObj.length()) randomObj = builder.getElementByName(xml.@randomObj) as Random;
			if (xml.@sampleCount.length()) sampleCount = parseInt(xml.@sampleCount);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}