package idv.cjcat.stardustextended.threeD {
	import idv.cjcat.stardustextended.common.xml.ClassPackage;
	import idv.cjcat.stardustextended.threeD.actions.Accelerate3D;
	import idv.cjcat.stardustextended.threeD.actions.BillboardOriented;
	import idv.cjcat.stardustextended.threeD.actions.Collide3D;
	import idv.cjcat.stardustextended.threeD.actions.Damping3D;
	import idv.cjcat.stardustextended.threeD.actions.DeathZone3D;
	import idv.cjcat.stardustextended.threeD.actions.Deflect3D;
	import idv.cjcat.stardustextended.threeD.actions.Explode3D;
	import idv.cjcat.stardustextended.threeD.actions.Gravity3D;
	import idv.cjcat.stardustextended.threeD.actions.Move3D;
	import idv.cjcat.stardustextended.threeD.actions.MutualGravity3D;
	import idv.cjcat.stardustextended.threeD.actions.NormalDrift3D;
	import idv.cjcat.stardustextended.threeD.actions.Oriented3D;
	import idv.cjcat.stardustextended.threeD.actions.RandomDrift3D;
	import idv.cjcat.stardustextended.threeD.actions.Snapshot3D;
	import idv.cjcat.stardustextended.threeD.actions.SnapshotRestore3D;
	import idv.cjcat.stardustextended.threeD.actions.Spawn3D;
	import idv.cjcat.stardustextended.threeD.actions.SpeedLimit3D;
	import idv.cjcat.stardustextended.threeD.actions.Spin3D;
	import idv.cjcat.stardustextended.threeD.actions.StardustSpriteUpdate3D;
	import idv.cjcat.stardustextended.threeD.actions.triggers.DeflectorTrigger3D;
	import idv.cjcat.stardustextended.threeD.actions.triggers.ZoneTrigger3D;
	import idv.cjcat.stardustextended.threeD.actions.VelocityField3D;
	import idv.cjcat.stardustextended.threeD.deflectors.BoundingCube;
	import idv.cjcat.stardustextended.threeD.deflectors.BoundingSphere;
	import idv.cjcat.stardustextended.threeD.deflectors.PlaneDeflector;
	import idv.cjcat.stardustextended.threeD.deflectors.SphereDeflector;
	import idv.cjcat.stardustextended.threeD.deflectors.WrappingCube;
	import idv.cjcat.stardustextended.threeD.emitters.Emitter3D;
	import idv.cjcat.stardustextended.threeD.fields.RadialField3D;
	import idv.cjcat.stardustextended.threeD.fields.UniformField3D;
	import idv.cjcat.stardustextended.threeD.handlers.DisplayObjectHandler3D;
	import idv.cjcat.stardustextended.threeD.initializers.DisplayObjectClass3D;
	import idv.cjcat.stardustextended.threeD.initializers.Omega3D;
	import idv.cjcat.stardustextended.threeD.initializers.PooledDisplayObjectClass3D;
	import idv.cjcat.stardustextended.threeD.initializers.Position3D;
	import idv.cjcat.stardustextended.threeD.initializers.Rotation3D;
	import idv.cjcat.stardustextended.threeD.initializers.StardustSpriteInit3D;
	import idv.cjcat.stardustextended.threeD.initializers.Velocity3D;
	import idv.cjcat.stardustextended.threeD.zones.CubeZone;
	import idv.cjcat.stardustextended.threeD.zones.DiskZone;
	import idv.cjcat.stardustextended.threeD.zones.SinglePoint3D;
	import idv.cjcat.stardustextended.threeD.zones.SphereCap;
	import idv.cjcat.stardustextended.threeD.zones.SphereShell;
	import idv.cjcat.stardustextended.threeD.zones.SphereSurface;
	import idv.cjcat.stardustextended.threeD.zones.SphereZone;
	
	/**
	 * Packs together classes for 3D.
	 */
	public class ThreeDClassPackage extends ClassPackage {
		
		private static var _instance:ThreeDClassPackage;
		
		public static function getInstance():ThreeDClassPackage {
			if (!_instance) _instance = new ThreeDClassPackage();
			return _instance;
		}
		
		public function ThreeDClassPackage() {
			
		}
		
		
		override protected final function populateClasses():void {
			//3D actions
			classes.push(RandomDrift3D);
			classes.push(Accelerate3D);
			classes.push(BillboardOriented);
			classes.push(Collide3D);
			classes.push(DeathZone3D);
			classes.push(Damping3D);
			classes.push(Deflect3D);
			classes.push(Explode3D);
			classes.push(Gravity3D);
			classes.push(Move3D);
			classes.push(MutualGravity3D);
			classes.push(NormalDrift3D);
			classes.push(Oriented3D);
			classes.push(Snapshot3D);
			classes.push(SnapshotRestore3D);
			classes.push(Spawn3D);
			classes.push(SpeedLimit3D);
			classes.push(Spin3D);
			classes.push(StardustSpriteUpdate3D);
			classes.push(VelocityField3D);
			
			//3D action triggers
			classes.push(DeflectorTrigger3D);
			classes.push(ZoneTrigger3D);
			
			//3D deflectors
			classes.push(BoundingCube);
			classes.push(BoundingSphere);
			classes.push(PlaneDeflector);
			classes.push(SphereDeflector);
			classes.push(WrappingCube);
			
			//3D emitters
			classes.push(Emitter3D);
			
			//3D fields
			classes.push(RadialField3D);
			classes.push(UniformField3D);
			
			//3D initializers
			classes.push(DisplayObjectClass3D);
			classes.push(Omega3D);
			classes.push(PooledDisplayObjectClass3D);
			classes.push(Position3D);
			classes.push(Rotation3D);
			classes.push(StardustSpriteInit3D);
			classes.push(Velocity3D);
			
			//3D particle handlers
			classes.push(DisplayObjectHandler3D);
			
			//3D zones
			classes.push(CubeZone);
			classes.push(DiskZone);
			classes.push(SinglePoint3D);
			classes.push(SphereCap);
			classes.push(SphereShell);
			classes.push(SphereSurface);
			classes.push(SphereZone);
		}
	}
}