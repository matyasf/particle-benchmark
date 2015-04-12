package idv.cjcat.stardustextended.twoD.actions  {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	import idv.cjcat.stardustextended.twoD.actions.Action2D;
	import idv.cjcat.stardustextended.twoD.particles.Particle2D;
	
	/**
	 * Takes a "snapshot" of the current particle states upon the <code>takeSnapshot</code> method call. 
	 * The particle states can be later restored using the <code>SnapshotRestore</code> class.
	 * 
	 * @see idv.cjcat.stardustextended.twoD.actions.SnapshotRestore
	 */
	public class Snapshot extends Action2D {
		
		public function Snapshot() {
			
		}
		
		public function takeSnapshot():void {
			_snapshotTaken = false;
		}
		
		private var _snapshotTaken:Boolean = true;
		override public function update(emitter:Emitter, particle:Particle, timeDelta:Number, currentTime:Number):void {
			var p2D:Particle2D = Particle2D(particle);
			
			if (_snapshotTaken) {
				skipThisAction = true;
				return;
			}
			
			p2D.dictionary[Snapshot] = new SnapshotData(p2D);
		}
		
		override public function postUpdate(emitter:Emitter, time:Number):void {
			if (!_snapshotTaken) _snapshotTaken = true;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "Snapshot";
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}