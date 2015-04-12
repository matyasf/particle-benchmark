package idv.cjcat.stardustextended.threeD.actions {
	import idv.cjcat.stardustextended.threeD.particles.Particle3D;
	
	internal class SnapshotData3D {
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		public var rotationX:Number;
		public var rotationY:Number;
		public var rotationZ:Number;
		public var scale:Number;
		
		public function SnapshotData3D(particle:Particle3D) {
			this.x = particle.x;
			this.y = particle.y;
			this.z = particle.z;
			this.rotationX = particle.rotationX;
			this.rotationY = particle.rotationY;
			this.rotationZ = particle.rotationZ;
			this.scale = particle.scale;
		}
	}
}