package com.funkypandagame.pbenchmark
{
import starling.display.Button;
import starling.textures.Texture;

public class Utils
{

    public static function createButton(text : String, width : Number) : Button
    {
        const height : Number = 40;
        var upTex : Texture = Texture.fromColor(width, height, 0xffe3e3e3);
        var downTex : Texture = Texture.fromColor(width, height, 0xffa3a3a3);
        var overTex : Texture = Texture.fromColor(width, height, 0xffc2c2c2);
        var b : Button = new Button(upTex, text, downTex, overTex);
        b.fontSize = 18;
        return b;
    }
}
}
