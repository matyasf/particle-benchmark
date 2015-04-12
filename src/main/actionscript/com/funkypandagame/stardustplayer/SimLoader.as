package com.funkypandagame.stardustplayer
{

import com.funkypandagame.stardustplayer.emitter.EmitterBuilder;
import com.funkypandagame.stardustplayer.emitter.EmitterValueObject;
import com.funkypandagame.stardustplayer.project.ProjectValueObject;
import com.funkypandagame.stardustplayer.sequenceLoader.ISequenceLoader;
import com.funkypandagame.stardustplayer.sequenceLoader.LoadByteArrayJob;
import com.funkypandagame.stardustplayer.sequenceLoader.SequenceLoader;

import flash.display.Bitmap;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.ByteArray;

import idv.cjcat.stardustextended.Stardust;

import org.as3commons.zip.IZipFile;

import org.as3commons.zip.Zip;

public class SimLoader extends EventDispatcher implements ISimLoader
{
    public static const DESCRIPTOR_FILENAME : String = "descriptor.json";
    public static const BACKGROUND_FILENAME : String = "background.png";

    private const sequenceLoader : ISequenceLoader = new SequenceLoader();
    protected var projectLoaded : Boolean = false;
    protected var loadedZip : Zip;
    protected var descriptorJSON : Object;
    protected var rawEmitterDatas : Vector.<RawEmitterData> = new Vector.<RawEmitterData>();

    /** Loads an .sde file (that is in a byteArray). */
    public function loadSim(data : ByteArray) : void
    {
        projectLoaded = false;
        sequenceLoader.clearAllJobs();

        loadedZip = new Zip();
        loadedZip.loadBytes( data );
        descriptorJSON = JSON.parse( loadedZip.getFileByName(DESCRIPTOR_FILENAME).getContentAsString() );
        if (descriptorJSON == null)
        {
            throw new Error("Descriptor JSON not found in the simulation ByteArray.");
        }
        if (uint(descriptorJSON.version) < Stardust.VERSION)
        {
            trace("Stardust Sim Loader: WARNING loaded simulation is created with an old version of the editor, it might not run.");
        }
        for (var i:int = 0; i < loadedZip.getFileCount(); i++)
        {
            var loadedFileName : String = loadedZip.getFileAt(i).filename;
            if (ZipFileNames.isEmitterXMLName(loadedFileName))
            {
                var emitterId : uint = ZipFileNames.getEmitterID(loadedFileName);
                const loadImageJob : LoadByteArrayJob = new LoadByteArrayJob(
                        emitterId.toString(),
                        ZipFileNames.getImageName(emitterId),
                        loadedZip.getFileByName(ZipFileNames.getImageName(emitterId)).content );
                sequenceLoader.addJob( loadImageJob );
            }
        }
        sequenceLoader.addEventListener( Event.COMPLETE, onProjectAssetsLoaded );
        sequenceLoader.loadSequence();
    }

    private function onProjectAssetsLoaded( event : Event ) : void
    {
        sequenceLoader.removeEventListener( Event.COMPLETE, onProjectAssetsLoaded );

        for (var i:int = 0; i < loadedZip.getFileCount(); i++)
        {
            var loadedFileName : String = loadedZip.getFileAt(i).filename;
            if (ZipFileNames.isEmitterXMLName(loadedFileName))
            {
                const emitterId : uint = ZipFileNames.getEmitterID(loadedFileName);
                const stardustBA : ByteArray = loadedZip.getFileByName(loadedFileName).content;
                const job : LoadByteArrayJob = sequenceLoader.getJobByName( emitterId.toString() );
                var snapshot : IZipFile = loadedZip.getFileByName(ZipFileNames.getParticleSnapshotName(emitterId));

                var rawData : RawEmitterData = new RawEmitterData();
                rawData.emitterID = emitterId;
                rawData.emitterXML = new XML(stardustBA.readUTFBytes(stardustBA.length));
                rawData.image = Bitmap(job.content).bitmapData;
                rawData.snapshot = snapshot ? snapshot.content : null;
                rawEmitterDatas.push(rawData);
            }
        }
        loadedZip = null;
        sequenceLoader.clearAllJobs();
        projectLoaded = true;
        dispatchEvent( new Event(Event.COMPLETE) );
    }

    public function createProjectInstance() : ProjectValueObject
    {
        if (!projectLoaded)
        {
            throw new Error("ERROR: Project is not loaded, call loadSim(), and then wait for the Event.COMPLETE event.");
        }
        var project : ProjectValueObject = new ProjectValueObject(descriptorJSON.version);
        for each(var rawData : RawEmitterData in rawEmitterDatas)
        {
            const emitterVO : EmitterValueObject = new EmitterValueObject(rawData.emitterID, EmitterBuilder.buildEmitter(rawData.emitterXML));
            project.emitters[rawData.emitterID] = emitterVO;
            emitterVO.image = rawData.image.clone();
            if (rawData.snapshot)
            {
                emitterVO.emitterSnapshot = rawData.snapshot;
                emitterVO.addParticlesFromSnapshot();
            }
        }
        return project;
    }

    // Call this if you don't want to create more instances of this project to free up its memory.
    // After calling it createProjectInstance will not work.
    public function dispose() : void
    {
        projectLoaded = false;
        descriptorJSON = null;
        for each (var rawEmitterData:RawEmitterData in rawEmitterDatas) {
            rawEmitterData.image.dispose();
            if (rawEmitterData.snapshot)
            {
                rawEmitterData.snapshot.clear();
            }
        }
        rawEmitterDatas = new Vector.<RawEmitterData>();
    }

}
}

import flash.display.BitmapData;
import flash.utils.ByteArray;

class RawEmitterData
{
    public var emitterID : uint;
    public var emitterXML : XML;
    public var image : BitmapData;
    public var snapshot : ByteArray;
}