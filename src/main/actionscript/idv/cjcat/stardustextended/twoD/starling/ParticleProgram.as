package idv.cjcat.stardustextended.twoD.starling
{

import flash.display3D.Context3DTextureFormat;
import flash.display3D.Program3D;
import flash.utils.Dictionary;

import starling.core.RenderSupport;

import starling.core.Starling;
import starling.textures.TextureSmoothing;

public class ParticleProgram
{

    private static const sProgramNameCache:Dictionary = new Dictionary();

    public static function getProgram(hasTexure : Boolean,
                                      texTinted:Boolean = false,
                                      texMipmap : Boolean = true,
                                      texRepeat : Boolean = false,
                                      texFormat : String = "bgra",
                                      texSmoothing : String = "bilinear"):Program3D
    {
        var target:Starling = Starling.current;
        var programName:String;

        if (hasTexure)
        {
            programName = getImageProgramName(texTinted, texMipmap, texRepeat, texFormat, texSmoothing);
        }

        var program:Program3D = target.getProgram(programName);
        if (!program)
        {
            // this is the input data we'll pass to the shaders:
            //
            // va0 -> position
            // va1 -> color
            // va2 -> texCoords
            // vc0 -> alpha
            // vc1 -> mvpMatrix
            // fs0 -> texture
            var vertexShader:String;
            var fragmentShader:String;

            if (!hasTexure) // Quad shaders
            {
                vertexShader = "m44 op, va0, vc1 \n" + // 4x4 matrix transform to output clipspace
                               "mul v0, va1, vc0 \n"; // multiply alpha (vc0) with color (va1)

                fragmentShader = "mov oc, v0\n"; // output color
            }
            else // Image shaders
            {
                vertexShader = texTinted ? "m44 op, va0, vc1 \n" + // 4x4 matrix transform to output clipspace
                                           "mul v0, va1, vc0 \n" + // multiply alpha (vc0) with color (va1)
                                           "mov v1, va2      \n" // pass texture coordinates to fragment program
                                            : "m44 op, va0, vc1 \n" + // 4x4 matrix transform to output clipspace
                                            "mov v1, va2      \n"; // pass texture coordinates to fragment program

                fragmentShader = texTinted ? "tex ft1,  v1, fs0 <???> \n" + // sample texture 0
                                             "mul  oc, ft1,  v0       \n" // multiply color with texel color
                                             : "tex  oc,  v1, fs0 <???> \n"; // sample texture 0

                fragmentShader = fragmentShader.replace("<???>", RenderSupport.getTextureLookupFlags(texFormat, texMipmap, texRepeat, texSmoothing));
            }
            program = target.registerProgramFromSource(programName, vertexShader, fragmentShader);
        }
        return program;
    }

    private static function getImageProgramName(tinted:Boolean, mipMap:Boolean = true, repeat:Boolean = false, format:String = "bgra", smoothing:String = "bilinear"):String
    {
        var bitField:uint = 0;

        if (tinted)
            bitField |= 1;
        if (mipMap)
            bitField |= 1 << 1;
        if (repeat)
            bitField |= 1 << 2;

        if (smoothing == TextureSmoothing.NONE)
            bitField |= 1 << 3;
        else if (smoothing == TextureSmoothing.TRILINEAR)
            bitField |= 1 << 4;

        if (format == Context3DTextureFormat.COMPRESSED)
            bitField |= 1 << 5;
        else if (format == "compressedAlpha")
            bitField |= 1 << 6;

        var name:String = sProgramNameCache[bitField];

        if (name == null)
        {
            name = "__STARDUST_RENDERER." + bitField.toString(16);
            sProgramNameCache[bitField] = name;
        }
        return name;
    }
}
}
