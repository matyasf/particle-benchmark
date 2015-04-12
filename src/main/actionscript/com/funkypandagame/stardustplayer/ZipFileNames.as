package com.funkypandagame.stardustplayer {

public class ZipFileNames {

    private static const EMITTER_NAME_PREFIX : String = "stardustEmitter_";

    public static function getXMLName(id : int) : String
    {
        return EMITTER_NAME_PREFIX + id + ".xml";
    }

    public static function getImageName(id : int) : String
    {
        return "emitterImage_" + id + ".png";
    }

    public static function getParticleSnapshotName(id : int) : String
    {
        return "emitterSnapshot_" + id + ".bytearray";
    }

    public static function isEmitterXMLName(filename : String) : Boolean
    {
        return (filename.substr(0,16) == EMITTER_NAME_PREFIX)
    }

    public static function getEmitterID(XMLFilename : String) : uint
    {
        return parseInt(XMLFilename.substr(16).split(".")[0]);
    }


}
}
