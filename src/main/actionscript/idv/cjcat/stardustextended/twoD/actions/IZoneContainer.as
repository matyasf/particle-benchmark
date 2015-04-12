package idv.cjcat.stardustextended.twoD.actions
{
import idv.cjcat.stardustextended.twoD.zones.Zone;

public interface IZoneContainer
{
    function get zone() : Zone;

    function set zone( value : Zone ) : void;
}
}
