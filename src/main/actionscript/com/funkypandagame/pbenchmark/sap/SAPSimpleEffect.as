package com.funkypandagame.pbenchmark.sap
{
import flash.display3D.Context3DBlendFactor;
import flash.geom.Vector3D;
import flash.utils.getTimer;
import flash.utils.setTimeout;

import starling.extensions.sap.Particle;

import starling.extensions.sap.ParticleEffect;

import starling.extensions.sap.ParticlePrototype;
import starling.extensions.sap.ParticleTextureAtlas;

public class SAPSimpleEffect extends ParticleEffect
{

    static private var starPrototype:ParticlePrototype;
    public static var numParticles : uint;

    public function SAPSimpleEffect(atlas:ParticleTextureAtlas)
    {
        const LIFE : Number = 6;
        if (starPrototype == null)
        {
            starPrototype = new ParticlePrototype(16, 16, atlas, false, Context3DBlendFactor.ONE, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
            starPrototype.addKey(0);
            starPrototype.addKey(LIFE);
        }

        for (var i:int = 0; i < LIFE * 100 / 2; i++)
        {
            addKey(i/60, keyFrame1);
        }
        for (i = LIFE * 100 / 2; i < LIFE * 100; i++)
        {
            addKey(i/60, keyFrame2);
        }
        setTimeout(function ():void
        {
            var newEffect:SAPSimpleEffect = new SAPSimpleEffect(atlas);
            newEffect.name = name;
            newEffect.scale = scale;
            newEffect.position = position;
            newEffect.direction = direction;
            particleSystem.addEffect(newEffect);
        }, LIFE * 1000);
        setLife(2*LIFE);
    }

    private function keyFrame1(keyTime:Number, time:Number):void {
        var currentParticle : Particle = particleList;
        while (currentParticle)
        {
            currentParticle.y += 1.6;
            currentParticle = currentParticle.next;
        }
        var pos:Vector3D = new Vector3D();
        for (var i:int = 0; i < 10; i++) {
            pos.x = random() * 600;
            starPrototype.createParticle(this, time, pos);
        }
        numParticles = numParticles + 10;
    }

    private function keyFrame2(keyTime:Number, time:Number):void {
        var currentParticle : Particle = particleList;
        while (currentParticle)
        {
            currentParticle.y += 1.6;
            currentParticle = currentParticle.next;
        }
    }
}
}
