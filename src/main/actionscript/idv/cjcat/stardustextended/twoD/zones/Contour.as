package idv.cjcat.stardustextended.twoD.zones {
	import idv.cjcat.stardustextended.common.xml.XMLBuilder;
	
	/**
	 * Zone with no thickness.
	 */
	public class Contour extends Zone {
		
		protected var _virtualThickness:Number;
		
		public function Contour() {
			_virtualThickness = 1;
		}
		
		/**
		 * Used to calculate "virtual area" for the <code>CompositeZone</code> class, 
		 * since contours have zero thickness. 
		 * The larger the virtual thickness, the larger the virtual area.
		 */
		public final function get virtualThickness():Number { return _virtualThickness; }
		public final function set virtualThickness(value:Number):void {
			_virtualThickness = value;
			updateArea();
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "Contour";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@virtualThickness = virtualThickness;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			if (xml.@virtualThickness.length()) virtualThickness = parseFloat(xml.@virtualThickness);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}