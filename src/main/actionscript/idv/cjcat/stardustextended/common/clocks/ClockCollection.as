package idv.cjcat.stardustextended.common.clocks {
	import idv.cjcat.stardustextended.sd;
	
	use namespace sd;
	
	/**
	 * This class is used internally by classes that implements the <code>ClockCollector</code> interface.
	 */
	public class ClockCollection implements ClockCollector {
		
		sd var clocks:Array;
		
		public function ClockCollection() {
			clocks = [];
		}
		
		public final function addClock(clock:Clock):void {
			clocks.push(clock);
		}
		
		public final function removeClock(clock:Clock):void {
			var index:int;
			while ((index = clocks.indexOf(clock)) >= 0) {
				clocks.splice(index, 1);
			}
		}
		
		public final function clearClocks():void {
			clocks = [];
		}
	}
}