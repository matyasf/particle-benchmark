package com.funkypandagame.pbenchmark
{

import com.funkypandagame.pbenchmark.ffparticlesystem.FFParticleSystemTest;
import com.funkypandagame.pbenchmark.sap.SAPTest;
import com.funkypandagame.pbenchmark.stardust.StardustTest;

import starling.display.Button;
import starling.display.DisplayObject;
import starling.display.Sprite;
import starling.events.EnterFrameEvent;
import starling.events.Event;
import starling.text.TextField;

public class StarlingMain extends Sprite
{

    private var choseTestButtons : Sprite;
    private var testControls : Sprite;
    private var numParticles : TextField;
    private var currentTest : DisplayObject;
    private var cnt : uint = 0;
    private var frameTime : Number = 0;

    public function StarlingMain()
    {
        testControls = new Sprite();

        var decreaseParticlesButton : Button = Utils.createButton("-50 particles", 290);
        testControls.addChild(decreaseParticlesButton);
        decreaseParticlesButton.x = 20;
        decreaseParticlesButton.y = 25;
        decreaseParticlesButton.addEventListener(Event.TRIGGERED, decreaseParticles);

        var increaseParticlesButton : Button = Utils.createButton("+100 particles", 290);
        testControls.addChild(increaseParticlesButton);
        increaseParticlesButton.x = 20 + 290 + 20;
        increaseParticlesButton.y = 25;
        increaseParticlesButton.addEventListener(Event.TRIGGERED, increaseParticles);

        numParticles = new TextField(300, 25, "", "Verdana", 18);
        numParticles.x = 100;
        testControls.addChild(numParticles);

        choseTestButtons = new Sprite();
        addChild(choseTestButtons);

        var stardustButton : Button = Utils.createButton("Stardust test", 600);
        choseTestButtons.addChild(stardustButton);
        stardustButton.x = 20;
        stardustButton.y = 70;
        stardustButton.addEventListener(Event.TRIGGERED, onStardustButtonTriggered);

        var sapButton : Button = Utils.createButton("SAP test(not working)", 600);
        choseTestButtons.addChild(sapButton);
        sapButton.x = 20;
        sapButton.y = 140;
        sapButton.addEventListener(Event.TRIGGERED, onSAPButtonTriggered);

        var ffButton : Button = Utils.createButton("FFParticleSystem test", 600);
        choseTestButtons.addChild(ffButton);
        ffButton.x = 20;
        ffButton.y = 210;
        ffButton.addEventListener(Event.TRIGGERED, onFFButtonTriggered);

        // add a button for your simulation here
    }

    private function onStardustButtonTriggered(evt : Event) : void
    {
        switchToTest(StardustTest);
    }

    private function onSAPButtonTriggered(evt : Event) : void
    {
        switchToTest(SAPTest);
    }

    private function onFFButtonTriggered(evt : Event) : void
    {
        switchToTest(FFParticleSystemTest);
    }

    private function decreaseParticles(evt : Event) : void
    {
        ITest(currentTest).decreaseParticlesBy50();
    }

    private function increaseParticles(evt : Event) : void
    {
        ITest(currentTest).increaseParticlesBy100();
    }

    private function switchToTest(testClass : Class) : void
    {
        removeChild(choseTestButtons);
        addChild(testControls);

        currentTest = new testClass();
        addChild(currentTest);
        currentTest.y = 65;

        addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
    }

    private function onEnterFrame(evt : EnterFrameEvent) : void
    {
        frameTime += evt.passedTime;
        ITest(currentTest).stepSimulation(evt.passedTime);
        cnt++;
        if (cnt % 120 == 0)
        {
            numParticles.text = ITest(currentTest).numberOfParticles.toString();
            frameTime = 0;
        }
    }

}
}
