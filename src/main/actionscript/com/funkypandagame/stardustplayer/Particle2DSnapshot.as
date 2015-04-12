package com.funkypandagame.stardustplayer
{
import idv.cjcat.stardustextended.twoD.particles.Particle2D;
// TODO could be a dynamic class that writes only the needed properties, but it might be slow
public class Particle2DSnapshot {

    public var x:Number;
    public var y:Number;
    public var vx:Number;
    public var vy:Number;
    public var rotation:Number;
    public var omega:Number;
    public var initLife:Number;
    public var initScale:Number;
    public var initAlpha:Number;
    public var life:Number;
    public var scale:Number;
    public var alpha:Number;
    public var mass:Number;
    public var mask:int;
    public var isDead:Boolean;
//    public var collisionRadius:Number;
    public var colorR:Number;
    public var colorG:Number;
    public var colorB:Number;
    public var initColorR:Number;
    public var initColorG:Number;
    public var initColorB:Number;
    public var endColorR:Number;
    public var endColorG:Number;
    public var endColorB:Number;
    public var currentAnimationFrame : int;

    public function storeParticle(p2d : Particle2D) : void
    {
        x = toLowPrecision(p2d.x);
        y = toLowPrecision(p2d.y);
        vx = toLowPrecision(p2d.vx);
        vy = toLowPrecision(p2d.vy);
        rotation = toLowPrecision(p2d.rotation);
        omega = toLowPrecision(p2d.omega);
        initLife = toLowPrecision(p2d.initLife);
        initScale = toLowPrecision(p2d.initScale);
        initAlpha = toLowPrecision(p2d.initAlpha);
        life = toLowPrecision(p2d.life);
        scale = toLowPrecision(p2d.scale);
        alpha = toLowPrecision(p2d.alpha);
        mass = toLowPrecision(p2d.mass);
        mask = p2d.mask;
        isDead = p2d.isDead;
//        collisionRadius = p2d.collisionRadius;
        colorR = toLowPrecision(p2d.colorR);
        colorG = toLowPrecision(p2d.colorG);
        colorB = toLowPrecision(p2d.colorB);
        initColorR = toLowPrecision(p2d.initColorR);
        initColorG = toLowPrecision(p2d.initColorG);
        initColorB = toLowPrecision(p2d.initColorB);
        endColorR = toLowPrecision(p2d.endColorR);
        endColorG = toLowPrecision(p2d.endColorG);
        endColorB = toLowPrecision(p2d.endColorB);
        currentAnimationFrame = p2d.currentAnimationFrame;
    }

    // round to the last 3 decimals, this improves compression
    private static function toLowPrecision(num : Number) : Number
    {
        return int(num * 1000) * 0.001;
    }

    public function writeDataTo(p2d : Particle2D) : void
    {
        p2d.x = x;
        p2d.y = y;
        p2d.vx = vx;
        p2d.vy = vy;
        p2d.rotation = rotation;
        p2d.omega = omega;
        p2d.initLife = initLife;
        p2d.initScale = initScale;
        p2d.initAlpha = initAlpha;
        p2d.life = life;
        p2d.scale = scale;
        p2d.alpha = alpha;
        p2d.mass = mass;
        p2d.mask = mask;
        p2d.isDead = isDead;
//        p2d.collisionRadius = collisionRadius;
        p2d.colorR = colorR;
        p2d.colorG = colorG;
        p2d.colorB = colorB;
        p2d.initColorR = initColorR;
        p2d.initColorG = initColorG;
        p2d.initColorB = initColorB;
        p2d.endColorR = endColorR;
        p2d.endColorG = endColorG;
        p2d.endColorB = endColorB;
        p2d.currentAnimationFrame = currentAnimationFrame;
    }
}
}
