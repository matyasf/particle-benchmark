package idv.cjcat.stardustextended.common.xml {
	
	/**
	 * This interface is implemented by all Stardust elements. 
	 * All Stardust elements can generate XML representation and reconstruct from existing XML data.
	 */
	public interface XMLConvertible {
		
		function toXML():XML;
		function parseXML(xml:XML, builder:XMLBuilder = null):void;
	}
}