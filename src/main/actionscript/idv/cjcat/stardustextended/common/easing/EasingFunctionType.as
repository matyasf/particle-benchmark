package idv.cjcat.stardustextended.common.easing {
	import flash.utils.Dictionary;
	
	public class EasingFunctionType {
		
		private static var _functions:Dictionary;
		public static function get functions():Dictionary {
			if (!_functions) {
				_functions = new Dictionary();
				
				_functions["Back.easeIn"] = Back.easeIn;
				_functions["Back.easeInOut"] = Back.easeInOut;
				_functions["Back.easeOut"] = Back.easeOut;
				
				_functions["Circ.easeIn"] = Circ.easeIn;
				_functions["Circ.easeInOut"] = Circ.easeInOut;
				_functions["Circ.easeOut"] = Circ.easeOut;
				
				_functions["Cubic.easeIn"] = Cubic.easeIn;
				_functions["Cubic.easeInOut"] = Cubic.easeInOut;
				_functions["Cubic.easeOut"] = Cubic.easeOut;
				
				_functions["Elastic.easeIn"] = Elastic.easeIn;
				_functions["Elastic.easeInOut"] = Elastic.easeInOut;
				_functions["Elastic.easeOut"] = Elastic.easeOut;
				
				_functions["Expo.easeIn"] = Expo.easeIn;
				_functions["Expo.easeInOut"] = Expo.easeInOut;
				_functions["Expo.easeOut"] = Expo.easeOut;
				
				_functions["Linear.easeIn"] = Linear.easeIn;
				_functions["Linear.easeInOut"] = Linear.easeInOut;
				_functions["Linear.easeNone"] = Linear.easeNone;
				_functions["Linear.easeOut"] = Linear.easeOut;
				
				_functions["Quad.easeIn"] = Quad.easeIn;
				_functions["Quad.easeInOut"] = Quad.easeInOut;
				_functions["Quad.easeOut"] = Quad.easeOut;
				
				_functions["Quart.easeIn"] = Quart.easeIn;
				_functions["Quart.easeInOut"] = Quart.easeInOut;
				_functions["Quart.easeOut"] = Quart.easeOut;
				
				_functions["Quint.easeIn"] = Quint.easeIn;
				_functions["Quint.easeInOut"] = Quint.easeInOut;
				_functions["Quint.easeOut"] = Quint.easeOut;
				
				_functions["Sine.easeIn"] = Sine.easeIn;
				_functions["Sine.easeInOut"] = Sine.easeInOut;
				_functions["Sine.easeOut"] = Sine.easeOut;
				
				_functions[Back.easeIn] = "Back.easeIn";
				_functions[Back.easeInOut] = "Back.easeInOut";
				_functions[Back.easeOut] = "Back.easeOut";
				
				_functions[Circ.easeIn] = "Circ.easeIn";
				_functions[Circ.easeInOut] = "Circ.easeInOut";
				_functions[Circ.easeOut] = "Circ.easeOut";
				
				_functions[Cubic.easeIn] = "Cubic.easeIn";
				_functions[Cubic.easeInOut] = "Cubic.easeInOut";
				_functions[Cubic.easeOut] = "Cubic.easeOut";
				
				_functions[Elastic.easeIn] = "Elastic.easeIn";
				_functions[Elastic.easeInOut] = "Elastic.easeInOut";
				_functions[Elastic.easeOut] = "Elastic.easeOut";
				
				_functions[Expo.easeIn] = "Expo.easeIn";
				_functions[Expo.easeInOut] = "Expo.easeInOut";
				_functions[Expo.easeOut] = "Expo.easeOut";
				
				_functions[Linear.easeIn] = "Linear.easeIn";
				_functions[Linear.easeInOut] = "Linear.easeInOut";
				_functions[Linear.easeNone] = "Linear.easeNone";
				_functions[Linear.easeOut] = "Linear.easeOut";
				
				_functions[Quad.easeIn] = "Quad.easeIn";
				_functions[Quad.easeInOut] = "Quad.easeInOut";
				_functions[Quad.easeOut] = "Quad.easeOut";
				
				_functions[Quart.easeIn] = "Quart.easeIn";
				_functions[Quart.easeInOut] = "Quart.easeInOut";
				_functions[Quart.easeOut] = "Quart.easeOut";
				
				_functions[Quint.easeIn] = "Quint.easeIn";
				_functions[Quint.easeInOut] = "Quint.easeInOut";
				_functions[Quint.easeOut] = "Quint.easeOut";
				
				_functions[Sine.easeIn] = "Sine.easeIn";
				_functions[Sine.easeInOut] = "Sine.easeInOut";
				_functions[Sine.easeOut] = "Sine.easeOut";
			}
			return _functions;
		}
	}
}