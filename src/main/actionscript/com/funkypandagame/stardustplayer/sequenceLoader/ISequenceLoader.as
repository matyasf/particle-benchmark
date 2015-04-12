package com.funkypandagame.stardustplayer.sequenceLoader
{

import flash.display.DisplayObject;
import flash.events.IEventDispatcher;

public interface ISequenceLoader extends IEventDispatcher
{

    function addJob( loadJob : LoadByteArrayJob ) : void;

    function getCompletedJobs() : Vector.<LoadByteArrayJob>;

    function getJobContentByName( emitterName : String ) : DisplayObject;

    function getJobByName( emitterName : String ) : LoadByteArrayJob;

    function removeCompletedJobByName( jobName : String ) : void;

    function clearAllJobs() : void;

    function loadSequence() : void;

}
}
