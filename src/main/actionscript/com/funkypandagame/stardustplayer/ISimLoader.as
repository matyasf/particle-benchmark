package com.funkypandagame.stardustplayer
{

import com.funkypandagame.stardustplayer.project.ProjectValueObject;

import flash.events.IEventDispatcher;
import flash.utils.ByteArray;

public interface ISimLoader extends IEventDispatcher
{
    function loadSim(data : ByteArray) : void;

    function createProjectInstance() : ProjectValueObject;

    function dispose() : void;
}
}
