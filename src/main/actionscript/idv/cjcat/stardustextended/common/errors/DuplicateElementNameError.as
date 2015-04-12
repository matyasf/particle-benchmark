package idv.cjcat.stardustextended.common.errors {
	import idv.cjcat.stardustextended.common.StardustElement;
	
	/**
	 * This error is thrown when an <code>XMLBuilder</code> object encounters more than one elements having the same name.
	 */
	public class DuplicateElementNameError extends Error {
		
		private var _element1:StardustElement;
		private var _element2:StardustElement;
		private var _name:String;
		
		public function DuplicateElementNameError(message:*, elementName:String, element1:StardustElement, element2:StardustElement) {
			super(message);
			_element1 = element1;
			_element2 = element2;
			_name = elementName;
		}
		
		public function get element1():StardustElement { return _element1; }
		public function get element2():StardustElement { return _element2; }
		public function get elementName():String { return _name; }
	}
}