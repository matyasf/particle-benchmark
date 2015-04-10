package com.funkypandagame.pbenchmark.sap
{
import flash.display3D.Context3DBlendFactor;
import flash.geom.Vector3D;
import flash.utils.setTimeout;

import starling.extensions.sap.Particle;

import starling.extensions.sap.ParticleEffect;

import starling.extensions.sap.ParticlePrototype;
import starling.extensions.sap.ParticleTextureAtlas;

public class SAPSimpleEffect extends ParticleEffect
{

    static private var starPrototype:ParticlePrototype;

    static private var pos:Vector3D = new Vector3D();

    public function SAPSimpleEffect(flame:ParticleTextureAtlas, live:Number = 1, repeat:Boolean = false)
    {
        if (starPrototype == null)
        {
            starPrototype = new ParticlePrototype(16, 16, flame, true, Context3DBlendFactor.ONE, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
            starPrototype.addKey(1, 0, 1, 1, 1, 1, 1, 1);
            starPrototype.addKey(20, 20, 1, 1, 1, 1, 1, 1);
        }

        addKey(0.0001, keyFrame1);
        addKey(2, keyFrame1);

        if (repeat) {
            setTimeout(function ():void {
                var newEffect:SAPSimpleEffect = new SAPSimpleEffect(flame, live, repeat);
                newEffect.name = name;
                newEffect.scale = scale;
                newEffect.position = position;
                newEffect.direction = direction;
                particleSystem.addEffect(newEffect);
            }, live * 1000);
        }

        setLife(timeKeys[keysCount - 1] + live);
    }

    private function keyFrame1(keyTime:Number, time:Number):void {
        var currentParticle : Particle = particleList;
        while (currentParticle)
        {
            currentParticle.x++;
            currentParticle = currentParticle.next;
        }
        pos.x = random() * 60;
        pos.y = 10;
        starPrototype.createParticle(this, time, pos);
        pos.x = random() * 60;
        starPrototype.createParticle(this, time, pos);
    }


}
}
