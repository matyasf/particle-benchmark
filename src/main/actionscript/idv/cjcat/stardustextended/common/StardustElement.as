package idv.cjcat.stardustextended.common {
	import flash.utils.Dictionary;
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	import idv.cjcat.stardustextended.common.xml.XMLConvertible;
	
	/**
	 * All Stardust elements are subclasses of this class.
	 */
	public class StardustElement implements XMLConvertible {
		
		private static var elementCounter:Dictionary = new Dictionary();
		
		public var name:String;
		
		public function StardustElement() {
			var str:String = getXMLTagName();
			
			if (elementCounter[str] == undefined) elementCounter[str] = 0;
			else elementCounter[str]++;
			
			this.name = str + "_" + elementCounter[str];
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		/**
		 * [Abstract Method] Returns the related objects of the element.
		 * 
		 * <p>
		 * This tells the <code>XMLBuilder</code> which elements are related, 
		 * so the builder can include them in the XML representation.
		 * </p>
		 * @return
		 */
		public function getRelatedObjects():Array {
			return [];
		}
		
		/**
		 * [Abstract Method] Returns the name of the root node of the element's XML representation.
		 * @return
		 */
		public function getXMLTagName():String {
			return "StardustElement";
		}
		
		/**
		 * Returns the root tag of the XML representation.
		 * @return
		 */
		public final function getXMLTag():XML {
			var xml:XML = XML("<" + getXMLTagName() + "/>");
			xml.@name = name;
			return xml;
		}
		
		/**
		 * [Abstract Method] Returns the tag for containing elements of the same type.
		 * @return
		 */
		public function getElementTypeXMLTag():XML {
			return <elements/>;
		}
		
		/**
		 * [Abstract Method] Generates XML representation.
		 * @param	nameOnly
		 * @return
		 */
		public function toXML():XML {
			var xml:XML = getXMLTag();
			return xml;
		}
		
		/**
		 * [Abstract Method] Reconstructs the element from XML representations.
		 * @param	xml
		 * @param	builder
		 */
		public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			//name = xml.@name;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}