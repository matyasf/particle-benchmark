package idv.cjcat.stardustextended.common.easing {
	
	/**
	 *  Easing Equations
	 *  <p>(c) 2003 Robert Penner, all rights reserved.</p>
	 *  <p>This work is subject to the terms in http://www.robertpenner.com/easing_terms_of_use.html.</p>
	 */
	public class Linear {

		[Inline]
		public static function easeNone (t:Number, b:Number, c:Number, d:Number):Number {
			return c*t/d + b;
		}

		[Inline]
		public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
			return c*t/d + b;
		}

		[Inline]
		public static function easeOut (t:Number, b:Number, c:Number, d:Number):Number {
			return c*t/d + b;
		}

		[Inline]
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
			return c*t/d + b;
		}
	}
}