package com.funkypandagame.pbenchmark
{

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import starling.core.Starling;
import starling.events.Event;

[SWF(frameRate="60", backgroundColor="#FFFFFF")]
public class Main extends Sprite
{

    private var _starling : Starling;

    public function Main()
    {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        var viewPort : Rectangle = new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
        Starling.multitouchEnabled = false;
        _starling = new Starling(StarlingMain, stage, viewPort, null, "auto", "auto");
        _starling.enableErrorChecking = false;
        _starling.simulateMultitouch = false;
        _starling.stage.stageWidth = 640;
        _starling.stage.stageHeight = 640 * stage.fullScreenHeight / stage.fullScreenWidth;
        _starling.showStats = true;
        _starling.addEventListener(starling.events.Event.ROOT_CREATED, onStarlingRootCreated);
    }


    private function onStarlingRootCreated() : void
    {
        _starling.removeEventListener(starling.events.Event.ROOT_CREATED, onStarlingRootCreated);
        _starling.start();
    }

}
}