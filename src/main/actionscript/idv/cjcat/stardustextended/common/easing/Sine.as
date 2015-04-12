package idv.cjcat.stardustextended.common.easing {
	
	/**
	 *  Easing Equations
	 *  <p>(c) 2003 Robert Penner, all rights reserved.</p>
	 *  <p>This work is subject to the terms in http://www.robertpenner.com/easing_terms_of_use.html.</p>
	 */
	public class Sine {
		private static const _HALF_PI:Number = Math.PI / 2;

		[Inline]
		public static function easeIn (t:Number, b:Number, c:Number, d:Number):Number {
			return -c * Math.cos(t/d * _HALF_PI) + c + b;
		}

		[Inline]
		public static function easeOut (t:Number, b:Number, c:Number, d:Number):Number {
			return c * Math.sin(t/d * _HALF_PI) + b;
		}

		[Inline]
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number):Number {
			return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
		}
	}
}