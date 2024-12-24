params ["_asset", "_caller"];
private _assetOwner = _asset getVariable ["BIS_WL_ownerAsset", "123"];
private _callerUID = getPlayerUID _caller;
private _callerID = getPlayerID _caller;
private _loadedItem = _asset getVariable ["WL2_loadedItem", objNull];
private _loadedVehicles = getVehicleCargo _asset;
private _slingLoadedVehicle = getSlingLoad _asset;
private _hasLoadedItem = !isNull _loadedItem || count _loadedVehicles > 0 || !isNull _slingLoadedVehicle;

private _nearLoadableEntities = (_asset nearEntities 30) select {
    (isNull attachedTo _x) && (count ropesAttachedTo _x == 0);
};
private _loadableHashmap = missionNamespace getVariable ["WL2_loadable", createHashMap];
private _nearLoadable = _nearLoadableEntities select {
    private _assetActualType = _x getVariable ["WL2_orderedClass", typeOf _x];
    private _access = [_x, _caller, "tow"] call BIS_fnc_WL2_accessControl;
    _assetActualType in _loadableHashmap && _access;
};
private _hasNearLoadable = count _nearLoadable > 0;

private _offset = if (_hasNearLoadable) then {
    private _loadable = _nearLoadable # 0;
    private _loadableType = _loadable getVariable ["WL2_orderedClass", typeOf _loadable];
    _loadableHashmap getOrDefault [_loadableType, [0, 0, 1]];
} else {
    [0, 0, 1];
};

// 0: eligible
// 1: near loadables
// 2: offset
[_assetOwner == _callerUID && alive _asset && (_hasLoadedItem || _hasNearLoadable), _nearLoadable, _offset];