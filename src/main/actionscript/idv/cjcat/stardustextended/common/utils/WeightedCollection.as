package idv.cjcat.stardustextended.common.utils {
	
	/**
	 * Used internally by the <code>SwitchInitializer</code> class.
	 * @see idv.cjcat.stardustextended.common.initializers.SwitchInitializer
	 */
	public class WeightedCollection {
		
		private var _contents:Array;
		private var _weights:Array;
		private var _accumulatedWeights:Array;
		private var totalWeight:Number;
		public function WeightedCollection(contents:Array, weights:Array) {
			clear();
			for (var i:int = 0; i < contents.length; i++) {
				addContent(contents[i], weights[i]);
			}
		}
		
		public final function addContent(content:*, weight:Number):void {
			_contents.push(content);
			_weights.push(weight);
			_accumulatedWeights.push(totalWeight + weight);
			totalWeight += weight;
		}
		
		public final function clear():void {
			_contents = [];
			_weights = [];
			_accumulatedWeights = [];
			totalWeight = 0;
		}
		
		public function get contents():Array { return _contents.concat(); }
		public function get weights():Array { return _weights.concat(); }
		
		public final function get():* {
			if (_contents.length == 1) return _contents[0];
			else if (_contents.length == 0) return null;
			
			var index:int = 0;
			var weightIndex:Number = totalWeight * Math.random();
			while (_accumulatedWeights[index] < weightIndex) index++;
			return _contents[index];
		}
	}
}