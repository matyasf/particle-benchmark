package idv.cjcat.stardustextended.cjsignals {
	
	internal class ListenerData{
		
		public var listener:Function;
		public var priority:int;
		public var once:Boolean;
		public var index:int;
		
		public function ListenerData(listener:Function, priority:int, once:Boolean) {
			this.listener = listener;
			this.priority = priority;
			this.once = once;
		}
	}
}