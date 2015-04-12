package com.funkypandagame.pbenchmark.ffparticlesystem
{

import com.funkypandagame.pbenchmark.ITest;

import de.flintfabrik.starling.display.FFParticleSystem;

import de.flintfabrik.starling.display.FFParticleSystem.SystemOptions;

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;
import starling.textures.TextureSmoothing;

public class FFParticleSystemTest extends Sprite implements ITest
{

    [Embed(source="../../../../../resources/FFSimple.pex",mimeType="application/octet-stream")]
    private static const FFSimpleConfig:Class;
    private var ffSimpleConfig:XML = XML(new FFSimpleConfig());

    [Embed(source="../../../../../resources/simpleAtlas.xml",mimeType="application/octet-stream")]
    private static var SimpleAtlasXML : Class;

    [Embed(source="../../../../../resources/star.png")]
    private static var EmitterImage : Class;

    private var soFFSimple : SystemOptions = SystemOptions.fromXML(
            ffSimpleConfig,
            Texture.fromBitmap(new EmitterImage()),
            XML(new SimpleAtlasXML()));

    private var psFFSimple : FFParticleSystem;

    public function FFParticleSystemTest()
    {
        FFParticleSystem.init(16000, false, 16000, 2);
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(evt : Event) : void
    {
        psFFSimple = new FFParticleSystem(soFFSimple);
        psFFSimple.smoothing = TextureSmoothing.NONE;
        addChild(psFFSimple);
        psFFSimple.start();
    }

    public function stepSimulation(dt : Number) : void
    {
        psFFSimple.advanceTime(dt);
    }

    public function increaseParticlesBy100() : void
    {
        psFFSimple.maxNumParticles = psFFSimple.maxNumParticles + 100;
    }

    public function decreaseParticlesBy50() : void
    {
        psFFSimple.maxNumParticles = psFFSimple.maxNumParticles - 50;
    }

    public function get numberOfParticles() : uint
    {
        return psFFSimple.numParticles / 2; //?? this seems to report 2x the amount of particles, thus thr division
    }

}
}
