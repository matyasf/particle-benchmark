package com.funkypandagame.stardustplayer.sequenceLoader
{

import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.utils.ByteArray;

public class LoadByteArrayJob extends EventDispatcher
{
    protected var _data : ByteArray;
    protected var _loader : Loader;
    public var jobName : String;
    public var fileName : String;

    public function LoadByteArrayJob( jobName : String, fileName : String, data : ByteArray )
    {
        _loader = new Loader();
        _loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onError );
        _data = data;
        this.jobName = jobName;
        this.fileName = fileName;
    }

    public function load() : void
    {
        _loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete );
        _loader.loadBytes( _data );
    }

    protected function onLoadComplete( event : Event ) : void
    {
        _loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onLoadComplete );
        dispatchEvent( new Event( Event.COMPLETE ) );
    }

    public function get byteArray() : ByteArray
    {
        return _data;
    }

    public function get content() : DisplayObject
    {
        return _loader.content;
    }

    public function destroy() : void
    {
        try
        {
            _loader.unloadAndStop();
        }
        catch (err: Error) {}
        _loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onLoadComplete );
        _loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onError );
        _data = null;
        _loader  = null;
        jobName  = null;
        fileName  = null;
    }

    private function onError(event : IOErrorEvent) : void
    {
        trace("Stardust sim loader: Error loading simulation", event);
    }
}
}
