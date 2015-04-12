package idv.cjcat.stardustextended.twoD.handlers {

import flash.display.BitmapData;

public interface ISpriteSheetHandler {

    function set bitmapData(bitmapData : BitmapData) :void

    function get bitmapData() : BitmapData

    function set spriteSheetSliceWidth(value:uint):void

    function get spriteSheetSliceWidth() : uint

    function set spriteSheetSliceHeight(value:uint):void

    function get spriteSheetSliceHeight() : uint

    function set spriteSheetAnimationSpeed(spriteSheetAnimationSpeed:uint):void;

    function get spriteSheetAnimationSpeed():uint;

    function set spriteSheetStartAtRandomFrame(spriteSheetStartAtRandomFrame:Boolean):void;

    function get spriteSheetStartAtRandomFrame():Boolean;

    function get smoothing():Boolean;

    function set smoothing(value:Boolean):void;

    function get isSpriteSheet():Boolean;

    function set blendMode(blendMode:String):void;

    function get blendMode():String;
}
}
