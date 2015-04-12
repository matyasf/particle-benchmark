package idv.cjcat.stardustextended.common.particles {
	
	public interface InfoRecycler {
		function recycleInfo(particle:Particle):void;
		function get needsRecycle():Boolean;
	}
}