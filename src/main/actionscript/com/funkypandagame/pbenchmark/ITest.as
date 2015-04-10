package com.funkypandagame.pbenchmark
{

public interface ITest
{

    // This will be called 60 times/second. The simulation should perform a step every time this is called
    // (no skipping frames)
    function stepSimulation(dt : Number) : void;

    // Increases the total number of particles on the screen by 100.
    // The increase does not need to be instant, for example you can
    // increase the particle creation rate, thus it will reach the value a few seconds
    // later.
    function increaseParticlesBy100() : void;

    // Decreases the total number of particles by 50. The decrease does not need to be
    // instantaneous
    function decreaseParticlesBy50() : void;

    // returns the current number of particles
    function get numberOfParticles() : uint;

}
}
