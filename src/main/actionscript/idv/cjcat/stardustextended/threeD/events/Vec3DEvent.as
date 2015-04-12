package idv.cjcat.stardustextended.threeD.events {
	import flash.events.Event;
	import idv.cjcat.stardustextended.threeD.geom.Vec3D;
	
	public class Vec3DEvent extends Event {
		
		public static const CHANGE:String = "stardustVec3DChange";
		
		private var _vec:Vec3D;
		public function Vec3DEvent(type:String, vec:Vec3D) {
			super(type);
			_vec = vec;
		}
		
		public function get vec():Vec3D { return _vec ; }
	}
}