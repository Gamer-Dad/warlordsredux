params ["_uav"];

if (isDedicated) exitWith {};
if !(unitIsUAV _uav) exitWith {};

private _isTransporting = _uav getVariable ["WL2_transporting", false];
private _uavLocation = getPosASL _uav;
private _isPosInWater = surfaceIsWater [_uavLocation # 0, _uavLocation # 1] && _uavLocation # 2 < 3;
if (_isPosInWater) then {
    if !(player getVariable ["BIS_WL_isOrdering", false]) then {
        _uav setDamage 1;
        deleteVehicle _uav;
    };
};

private _access = [_uav, player, "drone"] call BIS_fnc_WL2_accessControl;
private _disableConnection = (!_access) || _isTransporting || _isPosInWater;
private _isConnectable = player isUAVConnectable [_uav, true];

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