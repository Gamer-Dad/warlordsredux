#include "..\..\warlords_constants.inc"

private _isCarrierSector = count (WL_TARGET_FRIENDLY getVariable ["WL_aircraftCarrier", []]) > 0;
if (_isCarrierSector) exitWith {
    private _objective = WL_TARGET_FRIENDLY getVariable "objectAreaComplete";
    private _marker = createMarkerLocal ["localMarker", _objective # 0];
    _marker setMarkerShapeLocal "RECTANGLE";
    _marker setMarkerColorLocal BIS_WL_colorMarkerFriendly;
    _marker setMarkerDirLocal (_objective # 3);
    _marker setMarkerSizeLocal [_objective # 1, _objective # 2];
	[_marker, ""];
};

private _startArr = (synchronizedObjects WL_TARGET_FRIENDLY) select {
    (_x getVariable "BIS_WL_owner") == BIS_WL_playerSide
};
_startArr = _startArr apply {
    [_x distance2D player, _x]
};
_startArr sort true;

private _start = (_startArr # 0) # 1;
private _area = WL_TARGET_FRIENDLY getVariable "objectArea";
private _size = if (_area # 3) then {
    sqrt (((_area # 0) ^ 2) + ((_area # 1) ^ 2));
} else {
    (_area # 0) max (_area # 1);
};

private _marker = createMarkerLocal ["localMarker", [WL_TARGET_FRIENDLY, _size + WL_FAST_TRAVEL_OFFSET, WL_TARGET_FRIENDLY getDir _start] call BIS_fnc_relPos];
_marker setMarkerShapeLocal "RECTANGLE";
_marker setMarkerColorLocal BIS_WL_colorMarkerFriendly;
_marker setMarkerDirLocal (WL_TARGET_FRIENDLY getDir _start);
_marker setMarkerSizeLocal [_size, WL_FAST_TRAVEL_RANGE_AXIS];

_markerText = createMarkerLocal ["localMarkerText", markerPos _marker];
_markerText setMarkerColorLocal BIS_WL_colorMarkerFriendly;
_markerText setMarkerSizeLocal [0, 0];
_markerText setMarkerTypeLocal "mil_dot";
_markerText setMarkerTextLocal localize "STR_A3_cfgvehicles_moduletasksetdestination_f_arguments_destination_0";

[_marker, _markerText];