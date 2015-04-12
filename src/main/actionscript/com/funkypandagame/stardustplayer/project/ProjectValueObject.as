package com.funkypandagame.stardustplayer.project
{

import com.funkypandagame.stardustplayer.emitter.EmitterValueObject;

import flash.utils.Dictionary;

import idv.cjcat.stardustextended.common.initializers.Initializer;

import idv.cjcat.stardustextended.common.particles.Particle;

import idv.cjcat.stardustextended.twoD.emitters.Emitter2D;
import idv.cjcat.stardustextended.twoD.initializers.PositionAnimated;
import idv.cjcat.stardustextended.twoD.starling.StardustStarlingRenderer;
import idv.cjcat.stardustextended.twoD.starling.StarlingHandler;
import idv.cjcat.stardustextended.twoD.zones.Zone;

public class ProjectValueObject
{
    public var version : Number;

    public const emitters : Dictionary = new Dictionary(); // EmitterValueObject

    public function ProjectValueObject( _version : Number )
    {
        version = _version;
    }

    public function get numberOfEmitters() : int
    {
        var numEmitters : uint = 0;
        for each (var emitter : Object in emitters)
        {
            numEmitters++;
        }
        return numEmitters;
    }

    public function get numberOfParticles() : uint
    {
        var numParticles : uint = 0;
        for each (var emVO : EmitterValueObject in emitters)
        {
            numParticles += emVO.emitter.numParticles;
        }
        return numParticles;
    }

    /** Convenience function to get all emitters */
    public function get emittersArr() : Vector.<Emitter2D>
    {
        const emitterVec : Vector.<Emitter2D> = new Vector.<Emitter2D>();
        for each (var emVO : EmitterValueObject in emitters)
        {
            emitterVec.push(emVO.emitter);
        }
        return emitterVec;
    }

    /** Convenience function to get all initial positions */
    public function get initialPositions() : Vector.<Zone>
    {
        var zones : Vector.<Zone> = new Vector.<Zone>();
        for each (var emitter2D : Emitter2D in emittersArr)
        {
            for each (var init : Initializer in emitter2D.initializers)
            {
                if (init is PositionAnimated)
                {
                    zones.push(PositionAnimated(init).zone);
                }
            }
        }
        return zones;
    }

    /** Removes all particles and puts the simulation back to its initial state. */
    public function resetSimulation() : void
    {
        for each (var emitterValueObject : EmitterValueObject in emitters)
        {
            emitterValueObject.emitter.reset();
        }
    }

    /** The simulation will be unusable after calling this method. Note that this disposes StarlingHandler's texture. */
    public function destroy() : void
    {
        for each (var emitterValueObject : EmitterValueObject in emitters)
        {
            emitterValueObject.emitter.clearParticles();
            emitterValueObject.emitter.clearActions();
            emitterValueObject.emitter.clearInitializers();
            emitterValueObject.image = null;
            emitterValueObject.emitterSnapshot = null;
            if (emitterValueObject.emitter.particleHandler is StarlingHandler)
            {
                var renderer : StardustStarlingRenderer = StarlingHandler(emitterValueObject.emitter.particleHandler).renderer;
                // If this is not called, then Starling can call the render() function of the renderer,
                // which will try to render with disposed textures.
                renderer.advanceTime(new Vector.<Particle>());
                if (renderer.parent)
                {
                    renderer.parent.removeChild(renderer);
                }
            }
            if (emitterValueObject.texture)
            {
                emitterValueObject.texture.dispose();
            }
            delete emitters[emitterValueObject.id];
        }
    }

}
}
