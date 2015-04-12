package com.funkypandagame.stardustplayer.sequenceLoader
{

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.EventDispatcher;

public class SequenceLoader extends EventDispatcher implements ISequenceLoader
{

    private var waitingJobs : Vector.<LoadByteArrayJob>;
    private var currentJob : LoadByteArrayJob;
    private var completedJobs : Vector.<LoadByteArrayJob>;

    public function SequenceLoader()
    {
        initialize();
    }

    private function initialize() : void
    {
        waitingJobs = new Vector.<LoadByteArrayJob>();
        completedJobs = new Vector.<LoadByteArrayJob>();
    }

    public function addJob( loadJob : LoadByteArrayJob ) : void
    {
        waitingJobs.push( loadJob );
    }

    public function getCompletedJobs() : Vector.<LoadByteArrayJob>
    {
        return completedJobs;
    }

    public function getJobContentByName( name : String ) : DisplayObject
    {
        var numCompletedJobs : int = completedJobs.length;
        for ( var i : int = 0; i < numCompletedJobs; i ++ )
        {
            if ( completedJobs[i].jobName == name )
            {
                return completedJobs[i].content;
            }
        }
        return null;
    }

    public function getJobByName( name : String ) : LoadByteArrayJob
    {
        var numCompletedJobs : int = completedJobs.length;
        for ( var i : int = 0; i < numCompletedJobs; i ++ )
        {
            if ( completedJobs[i].jobName == name )
            {
                return completedJobs[i];
            }
        }
        return null;
    }

    public function removeCompletedJobByName( jobName : String ) : void
    {
        var numCompletedJobs : int = completedJobs.length - 1;
        for ( var i : int = numCompletedJobs; i > - 1; i -- )
        {
            if ( completedJobs[i].jobName == jobName )
            {
                completedJobs.splice( i, 1 );
            }
        }
    }

    public function clearAllJobs() : void
    {
        for each (var job : LoadByteArrayJob in completedJobs)
        {
            job.destroy();
        }
        for each (var job2 : LoadByteArrayJob in waitingJobs)
        {
            job2.destroy();
        }
        waitingJobs = new Vector.<LoadByteArrayJob>();
        currentJob = null;
        completedJobs = new Vector.<LoadByteArrayJob>();

        initialize();
    }

    public function loadSequence() : void
    {
        if ( waitingJobs.length > 0 )
        {
            loadNextInSequence();
        }
        else
        {
            dispatchEvent( new Event( Event.COMPLETE ) );
        }
    }

    private function loadNextInSequence() : void
    {
        if ( currentJob )
        {
            completedJobs.unshift( currentJob );
        }
        currentJob = waitingJobs.pop();
        currentJob.addEventListener( Event.COMPLETE, loadComplete );
        currentJob.load();
    }

    private function loadComplete( event : Event ) : void
    {
        currentJob.removeEventListener( Event.COMPLETE, loadComplete );
        if ( waitingJobs.length > 0 )
        {
            loadNextInSequence();
        }
        else
        {
            completedJobs.unshift( currentJob );
            currentJob = null;
            dispatchEvent( new Event( Event.COMPLETE ) );
        }
    }
}
}