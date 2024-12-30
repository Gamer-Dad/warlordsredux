#include "..\..\warlords_constants.inc"

params ["_target", "_caller"];

private _isAlive = alive _target;
private _isOwner = getPlayerUID _caller == (_target getVariable ["BIS_WL_ownerAsset", "123"]);
private _isInVehicle = vehicle _caller == _target;
private _nearbyRepair = (_target nearEntities ["All", WL_MAINTENANCE_RADIUS]) select {
    alive _x && getNumber (configFile >> "CfgVehicles" >> typeOf _x >> "transportRepair") > 0
};

_isAlive && _isOwner && _isInVehicle && count _nearbyRepair > 0;