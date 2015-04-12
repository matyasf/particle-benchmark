package idv.cjcat.stardustextended.common.particles {
	
	internal class ParticleNode {
		
		internal var next:ParticleNode;
		internal var prev:ParticleNode;
		internal var particle:Particle;
		
		public function ParticleNode(particle:Particle = null) {
			this.particle = particle;
		}
	}
}