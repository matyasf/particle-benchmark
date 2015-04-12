package com.funkypandagame.stardustplayer
{

import com.funkypandagame.stardustplayer.emitter.EmitterValueObject;
import com.funkypandagame.stardustplayer.project.ProjectValueObject;

import flash.display.BitmapData;

import flash.display.DisplayObjectContainer;

import idv.cjcat.stardustextended.common.clocks.ImpulseClock;

import idv.cjcat.stardustextended.common.handlers.ParticleHandler;
import idv.cjcat.stardustextended.twoD.emitters.Emitter2D;
import idv.cjcat.stardustextended.twoD.handlers.BitmapHandler;
import idv.cjcat.stardustextended.twoD.handlers.DisplayObjectHandler;
import idv.cjcat.stardustextended.twoD.handlers.DisplayObjectSpriteSheetHandler;
import idv.cjcat.stardustextended.twoD.handlers.PixelHandler;
import idv.cjcat.stardustextended.twoD.handlers.SingularBitmapHandler;
import idv.cjcat.stardustextended.twoD.starling.StarlingHandler;

import starling.display.QuadBatch;

/** Simple class to play back simulations. If you need something more custom write your own. */
public class SimPlayer
{
    protected var _sim : ProjectValueObject;
    protected var _renderTarget : Object;

    [Deprecated(message="Use setProject() and setRenderTarget() instead")]
    public function setSimulation( sim : ProjectValueObject, renderTarget : Object ) : void
    {
        setProject(sim);
        setRenderTarget(renderTarget);
    }

    public function setProject(sim : ProjectValueObject) : void
    {
        if (sim == null)
        {
            throw new Error("A simulation can not be null");
        }
        _sim = sim;
        setupSimulation();
    }

    public function setRenderTarget(renderTarget : Object) : void
    {
        if (renderTarget == null)
        {
            throw new Error("renderTarget must be a subclass of flash.display.DisplayObjectContainer or " +
            "starling.display.DisplayObjectContainer and it can not be null");
        }
        _renderTarget = renderTarget;
        setupSimulation();
    }

    protected function setupSimulation() : void
    {
        if (_renderTarget == null || _sim == null)
        {
            return;
        }
        for each (var emitter : Emitter2D in _sim.emittersArr)
        {
            const handler : ParticleHandler = emitter.particleHandler;
            if (handler is DisplayObjectHandler)
            {
                DisplayObjectHandler(handler).container = _renderTarget as DisplayObjectContainer;
            }
            if (handler is DisplayObjectSpriteSheetHandler)
            {
                DisplayObjectSpriteSheetHandler(handler).container = _renderTarget as DisplayObjectContainer;
            }
            else if (handler is BitmapHandler)
            {
                BitmapHandler(handler).targetBitmapData = BitmapData(_renderTarget);
            }
            else if (handler is SingularBitmapHandler)
            {
                SingularBitmapHandler(handler).targetBitmapData = BitmapData(_renderTarget);
            }
            else if (handler is PixelHandler)
            {
                PixelHandler(handler).targetBitmapData = BitmapData(_renderTarget);
            }
            else if (handler is StarlingHandler)
            {
                StarlingHandler(handler).container = _renderTarget as starling.display.DisplayObjectContainer;
            }
            else
            {
                throw new Error("Unknown particle handler " + handler);
            }
        }
    }

    public function stepSimulation( numSteps : uint = 1) : void
    {
        if (_sim == null || _renderTarget == null)
        {
            throw new Error("The simulation and its render target must be set.");
        }
        for each (var emVO : EmitterValueObject in _sim.emitters)
        {
            emVO.emitter.step( numSteps );
	        if (emVO.emitter.clock is ImpulseClock)
	        {
		        const impulseClock : ImpulseClock = ImpulseClock(emVO.emitter.clock);
		        if (emVO.emitter.currentTime % impulseClock.burstInterval == 1)
		        {
                    impulseClock.impulse();
		        }
	        }
        }
    }

}
}
