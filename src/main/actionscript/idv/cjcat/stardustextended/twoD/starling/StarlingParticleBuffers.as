package idv.cjcat.stardustextended.twoD.starling
{

import flash.display3D.Context3D;
import flash.display3D.IndexBuffer3D;
import flash.display3D.VertexBuffer3D;
import flash.system.ApplicationDomain;
import flash.utils.ByteArray;

import starling.core.Starling;
import starling.errors.MissingContextError;

import starling.utils.VertexData;

public class StarlingParticleBuffers {

    public static var indexBuffer:IndexBuffer3D;
    protected static var vertexBuffers:Vector.<VertexBuffer3D>;
    private static var indices:Vector.<uint>;
    protected static var sNumberOfVertexBuffers:int;
    protected static var _vertexBufferIdx:int = -1;

    /** Creates buffers for the simulation.
     * numberOfBuffers is the amount of vertex buffers used by the particle system for multi buffering. Multi buffering
     * can avoid stalling of the GPU but will also increases it's memory consumption. */
    public static function createBuffers(numParticles:uint, numberOfVertexBuffers : int):void
    {
        sNumberOfVertexBuffers = numberOfVertexBuffers;
        _vertexBufferIdx = -1;
        if (vertexBuffers)
        {
            for (var i:int = 0; i < vertexBuffers.length; ++i)
            {
                vertexBuffers[i].dispose();
            }
        }
        if (indexBuffer)
        {
            indexBuffer.dispose();
        }

        var context:Context3D = Starling.context;
        if (context == null) throw new MissingContextError();
        if (context.driverInfo == "Disposed") return;

        vertexBuffers = new Vector.<VertexBuffer3D>();
        if (ApplicationDomain.currentDomain.hasDefinition("flash.display3D.Context3DBufferUsage"))
        {
            for (i = 0; i < sNumberOfVertexBuffers; ++i)
            {
                // Context3DBufferUsage.DYNAMIC_DRAW; hardcoded for FP 11.x compatibility
                vertexBuffers[i] = context.createVertexBuffer.call(context, numParticles * 4, VertexData.ELEMENTS_PER_VERTEX, "dynamicDraw");
            }
        }
        else
        {
            for (i = 0; i < sNumberOfVertexBuffers; ++i)
            {
                vertexBuffers[i] = context.createVertexBuffer(numParticles * 4, VertexData.ELEMENTS_PER_VERTEX);
            }
        }

        var zeroBytes:ByteArray = new ByteArray();
        zeroBytes.length = numParticles * 16 * VertexData.ELEMENTS_PER_VERTEX;
        for (i = 0; i < sNumberOfVertexBuffers; ++i)
        {
            vertexBuffers[i].uploadFromByteArray(zeroBytes, 0, 0, numParticles * 4);
        }
        zeroBytes.length = 0;

        if (!indices)
        {
            indices = new Vector.<uint>();
            var numVertices:int = 0;
            var indexPosition:int = -1;
            for (i = 0; i < numParticles; ++i)
            {
                indices[++indexPosition] = numVertices;
                indices[++indexPosition] = numVertices + 1;
                indices[++indexPosition] = numVertices + 2;

                indices[++indexPosition] = numVertices + 1;
                indices[++indexPosition] = numVertices + 3;
                indices[++indexPosition] = numVertices + 2;
                numVertices += 4;
            }
        }
        indexBuffer = context.createIndexBuffer(numParticles * 6);
        indexBuffer.uploadFromVector(indices, 0, numParticles * 6);
    }

    /** Call this function to switch to the next Vertex buffer before calling uploadFromVector() to implement multi
     *  buffering. Has only effect if numberOfVertexBuffers > 1 */
    public static function switchVertexBuffer() : void
    {
        _vertexBufferIdx = ++_vertexBufferIdx % sNumberOfVertexBuffers;
    }

    public static function get vertexBuffer() : VertexBuffer3D
    {
        return vertexBuffers[_vertexBufferIdx];
    }

    public static function get vertexBufferIdx() : uint
    {
        return _vertexBufferIdx;
    }

    public static function get buffersCreated() : Boolean
    {
        // this has to look like this otherwise ASC 2.0 generates some garbage code
        if (vertexBuffers && vertexBuffers.length > 0)
        {
            return true;
        }
        return false;
    }
}
}
