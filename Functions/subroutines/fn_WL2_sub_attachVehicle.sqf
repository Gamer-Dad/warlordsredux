params ["_asset", "_childAsset", "_isAttaching"];

if (_isAttaching) then {
    _childAsset setVehicleLock "UNLOCKED";
    {
        moveOut _x;
    } forEach (crew _childAsset);

    private _ropes = ropes _asset;
    {
        ropeDestroy _x;
    } forEach _ropes;

    _asset setVariable ["WL2_loadedItem", _childAsset];
    _childAsset setVariable ["WL2_autonomousBeforeLoad", isAutonomous _childAsset];
    _childAsset setVariable ["WL2_massBeforeLoad", getMass _childAsset];
    _childAsset setVariable ["WL2_transporting", true, true];
    [_childAsset] remoteExec ["BIS_fnc_WL2_uavConnectRefresh", 0];

    _childAsset setMass (getMass _asset / 10);

    private _enemyGroups = allGroups select {side _x == BIS_WL_enemySide};
    {
        _x forgetTarget _childAsset;
    } forEach _enemyGroups;
    private _enemyUnits = allUnits select {side _x == BIS_WL_enemySide};
    {
        _x forgetTarget _childAsset;
    } forEach _enemyUnits;

    private _assetChildren = _asset getVariable ["WL2_children", []];
    _assetChildren pushBack _childAsset;
    _asset setVariable ["WL2_children", _assetChildren, [2, clientOwner]];
} else {
    private _ropes = ropes _asset;
    {
        ropeDestroy _x;
    } forEach _ropes;

    _childAsset setVehicleLock "UNLOCKED";

    private _wasAutonomous = _childAsset getVariable ["WL2_autonomousBeforeLoad", false];
    _childAsset setAutonomous _wasAutonomous;
    _childAsset setVariable ["WL2_transporting", false, true];
    [_childAsset] call BIS_fnc_WL2_uavConnectRefresh;

    private _massBeforeLoad = _childAsset getVariable ["WL2_massBeforeLoad", 1000];
    _childAsset setMass _massBeforeLoad;

    _asset setVariable ["WL2_loadedItem", objNull];

    private _assetChildren = _asset getVariable ["WL2_children", []];
    _assetChildren = _assetChildren - [_childAsset];
    _asset setVariable ["WL2_children", _assetChildren, [2, clientOwner]];

    _childAsset setVariable ["WL2_wasDeployed", true, true];

    [_childAsset] spawn {
        params ["_childAsset"];
        private _location = getPosASL _childAsset;
        private _height = _location # 2;
        private _fallTime = 15 + sqrt (_height / 5);

        sleep _fallTime;

        _location = getPosASL _childAsset;
        private _isPosInWater = surfaceIsWater [_location # 0, _location # 1];
        if (_isPosInWater) exitWith {
            systemChat "Asset deployed into water has been destroyed!";
            _childAsset setDamage 1;
        };
    };
};