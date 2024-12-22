params ["_uav"];

if (isDedicated) exitWith {};
if !(unitIsUAV _uav) exitWith {};

private _ownerUavAsset = _uav getVariable ["BIS_WL_ownerUavAsset", "123"];
private _ownerUnit = _ownerUavAsset call BIS_fnc_getUnitByUID;
private _ownerID = getPlayerID _ownerUnit;
private _isInMySquad = ["isInMySquad", [_ownerID]] call SQD_fnc_client;

private _isConnectable = player isUAVConnectable [_uav, true];
private _isLockedFromSquad = _uav getVariable ["BIS_WL_lockedFromSquad", false];

private _isTransporting = _uav getVariable ["WL2_transporting", false];

private _uavLocation = getPosASL _uav;
private _isPosInWater = surfaceIsWater [_uavLocation # 0, _uavLocation # 1] && _uavLocation # 2 < 3;
if (_isPosInWater) then {
    _uav setDamage 1;
    deleteVehicle _uav;
};
private _disableConnection = ((!_isInMySquad || _isLockedFromSquad) && _ownerUnit != player) || _isTransporting || _isPosInWater;

if (_disableConnection) then {
    _uav setVariable ["WL_canConnectUav", false];
    if (_isConnectable) then {
        player disableUAVConnectability [_uav, true];
    };
} else {
    _uav setVariable ["WL_canConnectUav", true];
    if (!_isConnectable) then {
        player enableUAVConnectability [_uav, true];
    };
};