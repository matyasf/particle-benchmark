package idv.cjcat.stardustextended.common.actions {
	
	public interface ActionCollector {
		
		function addAction(action:Action):void;
		function removeAction(action:Action):void;
		function clearActions():void;
	}
	
}