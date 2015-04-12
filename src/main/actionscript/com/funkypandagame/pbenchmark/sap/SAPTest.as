package com.funkypandagame.pbenchmark.sap
{

import com.funkypandagame.pbenchmark.ITest;
import flash.geom.Vector3D;

import starling.core.RenderSupport;

import starling.display.Sprite;
import starling.extensions.sap.ParticleSystem;
import starling.extensions.sap.ParticleTextureAtlas;
import starling.textures.Texture;

public class SAPTest extends Sprite implements ITest
{

    [Embed(source="../../../../../resources/star.png")]
    private static var EmitterImage : Class;

    private var particleSystem:ParticleSystem = new ParticleSystem();
    private var effect:SAPSimpleEffect;

    public function SAPTest()
    {
        var tex:Texture = Texture.fromEmbeddedAsset(EmitterImage);
        var starAtlas:ParticleTextureAtlas = new ParticleTextureAtlas(tex, null, 1, 1, 0, 1, 60, true);

        effect = new SAPSimpleEffect(starAtlas);
        addChild(particleSystem);
        particleSystem.addEffect(effect);
        particleSystem.play();

        particleSystem.x = 0;
        particleSystem.y = 0;
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

    private var numParticles : uint;

    override public function render(support : RenderSupport, parentAlpha : Number) : void
    {
        numParticles = SAPSimpleEffect.numParticles;
        SAPSimpleEffect.numParticles = 0;
        super.render(support, parentAlpha);
    }
    public function get numberOfParticles() : uint
    {
        // does not report the actual particles on the screen lots of times, it reports up to 2x more
        return numParticles;
    }

}
}
