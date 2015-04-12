package idv.cjcat.stardustextended.twoD.starling {

public class Frame {

    public var particleHalfWidth:Number;
    public var particleHalfHeight:Number;
    public var topLeftX:Number;
    public var topLeftY:Number;
    public var bottomRightX:Number;
    public var bottomRightY:Number;

    public function Frame(_topLeftX:Number,
                          _topLeftY:Number,
                          _bottomRightX:Number,
                          _bottomRightY:Number,
                          _halfWidth:Number,
                          _halfHeight:Number)
    {
        topLeftX = _topLeftX;
        topLeftY = _topLeftY;
        bottomRightX = _bottomRightX;
        bottomRightY = _bottomRightY;
        particleHalfWidth = _halfWidth;
        particleHalfHeight = _halfHeight;
    }
}
}
