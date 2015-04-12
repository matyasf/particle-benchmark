package idv.cjcat.stardustextended.common.utils {

public class ColorUtil
{
    private static const inv255 : Number = 1/255;
    /**
     * Converts a color from numeric values to its uint value. Input values are in the [0,1] range.
     */
    [Inline]
    public static function rgbToHex(r:Number, g:Number, b:Number) : uint
    {
        return ( ( int(r*256) << 16 ) | ( int(g*256) << 8 ) | int(b*256) );
    }

    [Inline]
    public static function extractRed(c:uint):Number {
        return (( c >> 16 ) & 0xFF) * inv255;
    }

    [Inline]
    public static function extractGreen(c:uint):Number {
        return ( (c >> 8) & 0xFF ) * inv255;
    }

    [Inline]
    public static function extractBlue(c:uint):Number {
        return ( c & 0xFF ) * inv255;
    }
}
}
