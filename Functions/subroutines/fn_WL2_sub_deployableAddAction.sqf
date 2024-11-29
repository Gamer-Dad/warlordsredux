params ["_asset"];

private _deployActionId = _asset addAction [
	"",
	{
		_this params ["_asset", "_caller", "_deployActionId"];

        private _assetLoadedItem = _asset getVariable ["WL2_loadedItem", objNull];
        if (isNull _assetLoadedItem) then {
            private _nearLoadableEntities = (_asset nearEntities 30) select {isNull attachedTo _x};
            private _loadableHashmap = missionNamespace getVariable ["WL2_loadable", createHashMap];
            private _nearLoadable = _nearLoadableEntities select {typeOf _x in _loadableHashmap};

            if (count _nearLoadable > 0) then {
                private _assetToLoad = _nearLoadable select 0;
                _assetToLoad attachTo [_asset, [0, 0, 1], "proxy:\a3\data_f\proxies\truck_01\cargo.001"];
                _assetToLoad setVehicleLock "LOCKED";
                {
                    _assetToLoad enableVehicleSensor [_x # 0, false];
                } forEach (listVehicleSensors _assetToLoad);

                _asset setVariable ["WL2_loadedItem", _assetToLoad];

                private _enemyGroups = allGroups select {side _x == BIS_WL_enemySide};
                {
                    _x forgetTarget _assetToLoad;
                } forEach _enemyGroups;
                private _enemyUnits = allUnits select {side _x == BIS_WL_enemySide};
                {
                    _x forgetTarget _assetToLoad;
                } forEach _enemyUnits;
            };
        } else {
            private _desiredPosRelative = [8, 0, 0];
            private _desiredPosRelativeHigh = [0, 0, 1] vectorAdd _desiredPosRelative;
            private _desiredPosWorld = _asset modelToWorld _desiredPosRelative;
            private _desiredPosWorldZero = [_desiredPosWorld # 0, _desiredPosWorld # 1, 0];

            private _direction = direction _assetLoadedItem;
            private _class = typeOf _assetLoadedItem;
            private _nearbyEntities = [_class, AGLtoASL _desiredPosWorldZero, _direction, "dontcheckuid", [_asset, _assetLoadedItem]] call BIS_fnc_WL2_grieferCheck;

            if (count _nearbyEntities > 0) exitWith {
                _assetLoadedItem attachTo [_asset, [0, 0, 1], "proxy:\a3\data_f\proxies\truck_01\cargo.001"];

                private _nearbyObjectName = [_nearbyEntities # 0] call BIS_fnc_WL2_getAssetTypeName;
                systemChat format ["Deploying too close to %1!", _nearbyObjectName];
                playSound "AddItemFailed";
            };

            _assetLoadedItem attachTo [_asset, _desiredPosRelativeHigh];
            detach _assetLoadedItem;

            private _assetLoadedItemPos = getPos _assetLoadedItem;
            _assetLoadedItem setPos [_assetLoadedItemPos # 0, _assetLoadedItemPos # 1, 0];
            _assetLoadedItem setVehicleLock "UNLOCKED";
            {
                _assetLoadedItem enableVehicleSensor [_x # 0, true];
            } forEach (listVehicleSensors _assetLoadedItem);

            _asset setVariable ["WL2_loadedItem", objNull];
        };
	},
	[],
	5,
	false,
	false,
	"",
	"[_target, _this] call BIS_fnc_WL2_sub_deployableEligibility",
	30,
	false
];

[_asset, _deployActionId] spawn {
    params ["_asset", "_deployActionId"];
    private _assetLastLoadedItem = objNull;
    while { alive _asset } do {
        _assetLastLoadedItem = _asset getVariable ["WL2_loadedItem", objNull];
        private _hasLoad = !isNull _assetLastLoadedItem;

        private _actionText = if (_hasLoad) then {
            "Unload deployable";
        } else {
            "Load deployable";
        };

        private _actionIcon = if (isNull (_asset getVariable ["WL2_loadedItem", objNull])) then {
            '\A3\ui_f\data\map\markers\handdrawn\start_CA.paa'
        } else {
            '\A3\ui_f\data\map\markers\handdrawn\end_CA.paa'
        };

        _asset setUserActionText [_deployActionId, _actionText, format ["<img size='3' image='%1'/>", _actionIcon]];
        sleep 1;
    };

    // Unload if killed/removed
    detach _assetLastLoadedItem;
    _assetLastLoadedItem setVehicleLock "UNLOCKED";
    {
        _assetLastLoadedItem enableVehicleSensor [_x # 0, true];
    } forEach (listVehicleSensors _assetLastLoadedItem);
};