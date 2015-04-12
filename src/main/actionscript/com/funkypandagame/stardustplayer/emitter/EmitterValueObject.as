package com.funkypandagame.stardustplayer.emitter
{

import com.funkypandagame.stardustplayer.Particle2DSnapshot;

import flash.display.BitmapData;
import flash.net.registerClassAlias;
import flash.utils.ByteArray;
import flash.utils.getQualifiedClassName;

import idv.cjcat.stardustextended.common.particles.Particle;

import idv.cjcat.stardustextended.twoD.emitters.Emitter2D;
import idv.cjcat.stardustextended.twoD.handlers.ISpriteSheetHandler;
import idv.cjcat.stardustextended.twoD.particles.Particle2D;
import idv.cjcat.stardustextended.twoD.particles.PooledParticle2DFactory;
import idv.cjcat.stardustextended.twoD.starling.StarlingHandler;

import starling.textures.Texture;

public class EmitterValueObject
{
    public var emitter : Emitter2D;
    /** Snapshot of the particles. If its not null then the emitter will have the particles here upon creation. */
    public var emitterSnapshot : ByteArray;
    private var _id : uint;
    private var _image : BitmapData;


    public function EmitterValueObject( emitterId : uint, _emitter : Emitter2D )
    {
        emitter = _emitter;
        _id = emitterId;
    }

    public function get id() : uint
    {
        return _id;
    }

    public function get image() : BitmapData
    {
        return _image;
    }

    public function set image(imageBD : BitmapData) : void
    {
        _image = imageBD;
        if (emitter.particleHandler is ISpriteSheetHandler)
        {
            ISpriteSheetHandler(emitter.particleHandler).bitmapData = imageBD;
        }
    }

    /** Returns the texture used by the simulation. Only has value if image has been set and its rendering via Starling.
     *  Note, that this texture does *not* get disposed automatically, you need to do it manually if you are no longer
     *  using it or call ProjectValueObject.destroy() */
    public function get texture():Texture
    {
        if (emitter.particleHandler is StarlingHandler)
        {
            return StarlingHandler(emitter.particleHandler).texture;
        }
        return null;
    }

    public function addParticlesFromSnapshot() : void
    {
        registerClassAlias(getQualifiedClassName(Particle2DSnapshot), Particle2DSnapshot);
        emitterSnapshot.position = 0;
        var particlesData : Array = emitterSnapshot.readObject();
        var factory : PooledParticle2DFactory = new PooledParticle2DFactory();
        var particles:Vector.<Particle> = factory.createParticles(particlesData.length, 0);
        for (var j:int = 0; j < particlesData.length; j++) {
            var particle:Particle2D = Particle2D(particles[j]);
            Particle2DSnapshot(particlesData[j]).writeDataTo(particle);
        }
        emitter.addParticles(particles);
    }

}
}
