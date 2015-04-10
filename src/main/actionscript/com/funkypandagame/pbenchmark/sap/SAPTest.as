package com.funkypandagame.pbenchmark.sap
{

import com.funkypandagame.pbenchmark.ITest;
import flash.geom.Vector3D;

import starling.display.Sprite;
import starling.extensions.sap.ParticleSystem;
import starling.extensions.sap.ParticleTextureAtlas;
import starling.textures.Texture;

public class SAPTest extends Sprite implements ITest
{

    [Embed(source="../../../../../resources/star.png")]
    private static var EmitterImage : Class;

    private var particleSystem:ParticleSystem = new ParticleSystem();

    public function SAPTest()
    {
        var tex:Texture = Texture.fromEmbeddedAsset(EmitterImage);
        var starAtlas:ParticleTextureAtlas = new ParticleTextureAtlas(tex, null, 1, 1, 0, 1, 60, true);

        var effect:SAPSimpleEffect = new SAPSimpleEffect(starAtlas, 100, true);
        particleSystem.gravity = new Vector3D(0, -1, 0);
       // particleSystem.wind = new Vector3D(1, 1, 0);
        addChild(particleSystem);
        particleSystem.addEffect(effect);
        particleSystem.play();

        particleSystem.x = 125;
        particleSystem.y = 170;
    }

    public function stepSimulation(dt : Number) : void
    {

    }

    public function increaseParticlesBy100() : void
    {

    }

    public function decreaseParticlesBy50() : void
    {

    }

    public function get numberOfParticles() : uint
    {
        return 0;
    }

}
}
