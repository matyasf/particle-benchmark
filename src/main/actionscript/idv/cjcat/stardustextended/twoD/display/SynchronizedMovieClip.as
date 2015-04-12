package idv.cjcat.stardustextended.twoD.display {
	import idv.cjcat.stardustextended.common.emitters.Emitter;
	import idv.cjcat.stardustextended.common.particles.Particle;
	
	public class SynchronizedMovieClip extends StardustMovieClip {
		
		protected var stopAtEnd:Boolean = false;
		private var _playHead:Number;
		
		public function SynchronizedMovieClip() {
			
		}
		
		override public function init(particle:Particle):void {
			gotoAndStop(1);
			_playHead = 1;
		}
		
		override public function update(emitter:Emitter, particle:Particle, time:Number):void {
			_playHead += time;
			var max:int = totalFrames + 1;
			while (_playHead >= max) {
				if (stopAtEnd) {
					gotoAndStop(totalFrames);
					return;
				}
				_playHead -= totalFrames;
			}
			this.gotoAndStop(int(_playHead));
		}
	}
}