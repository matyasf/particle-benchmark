package com.funkypandagame.pbenchmark.stardust
{

import com.funkypandagame.pbenchmark.ITest;
import com.funkypandagame.stardustplayer.SimLoader;
import com.funkypandagame.stardustplayer.SimPlayer;
import com.funkypandagame.stardustplayer.project.ProjectValueObject;

import flash.events.Event;

import idv.cjcat.stardustextended.common.clocks.SteadyClock;

import idv.cjcat.stardustextended.twoD.starling.StardustStarlingRenderer;

import starling.display.Sprite;

public class StardustTest extends Sprite implements ITest
{

    [Embed(source="../../../../../resources/stardustSimple.sde", mimeType="application/octet-stream")]
    private static var StardustSim : Class;

    private var loader : SimLoader;
    private var player : SimPlayer;
    private var project : ProjectValueObject;

    public function StardustTest()
    {
        //StardustStarlingRenderer.init(2, 16000);

        loader = new SimLoader();
        loader.loadSim(new StardustSim());

        loader.addEventListener(Event.COMPLETE, onSimLoaded);
    }

    private function onSimLoaded(evt : Event) : void
    {
        project = loader.createProjectInstance();
        loader.dispose();
        loader = null;

        player = new SimPlayer();
        player.setProject(project);
        player.setRenderTarget(this);
    }

    public function stepSimulation(dt : Number) : void
    {
        if (player)
        {
            player.stepSimulation();
        }
    }

    public function increaseParticlesBy100() : void
    {
        SteadyClock(project.emittersArr[0].clock).ticksPerCall += 0.5;
    }

    public function decreaseParticlesBy50() : void
    {
        var clock : SteadyClock = SteadyClock(project.emittersArr[0].clock);
        if (clock.ticksPerCall > 0)
        {
            clock.ticksPerCall -= 0.25;
        }
    }

    public function get numberOfParticles() : uint
    {
        return project.numberOfParticles;
    }

}
}
