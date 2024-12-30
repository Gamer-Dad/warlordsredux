params ["_asset"];

private _deployActionId = _asset addAction [
	"",
	{
		_this params ["_asset", "_caller", "_deployActionId"];

        private _speed = abs (speed _asset);
        if (_speed > 5) exitWith {
            systemChat "Cannot load/unload deployable while moving!";
            playSound "AddItemFailed";
        };

        private _timeSinceLastLoad = serverTime - (_asset getVariable ["WL2_lastLoadedTime", 0]);
        private _timeRemaining = 10 - _timeSinceLastLoad;
        if (_timeRemaining > 0) exitWith {
            systemChat format ["Please wait %1 seconds to load/unload again. (This prevents despawning.)", round _timeRemaining];
            playSound "AddItemFailed";
        };
        _asset setVariable ["WL2_lastLoadedTime", serverTime];

        private _assetLoadedItem = _asset getVariable ["WL2_loadedItem", objNull];
        if (isNull _assetLoadedItem) then {
            private _eligibilityQuery = [_asset, _caller] call WL2_fnc_deployableEligibility;
            private _nearLoadableEntities = _eligibilityQuery # 1;

            if (count _nearLoadableEntities > 0) then {
                private _assetToLoad = _nearLoadableEntities select 0;

                if ((_asset canVehicleCargo _assetToLoad) # 0) then {
                    _asset setVehicleCargo _assetToLoad;
                    private _offset = _asset getRelPos _assetToLoad;
                    objNull setVehicleCargo _assetToLoad;
                    _assetToLoad attachTo [_asset, _offset];
                } else {
                    private _offset = _eligibilityQuery # 2;
                    _assetToLoad attachTo [_asset, _offset];
                };

                [_asset, _assetToLoad, true] call WL2_fnc_attachVehicle;
            };
        } else {
            _asset setVariable ["WL2_loadingAsset", true];
            private _desiredPosRelative = [8, 0, 0];
            private _desiredPosRelativeHigh = [0, 0, 1] vectorAdd _desiredPosRelative;
            private _desiredPosWorld = _asset modelToWorld _desiredPosRelative;
            private _desiredPosWorldZero = [_desiredPosWorld # 0, _desiredPosWorld # 1, 0];

            private _isPosInWater = surfaceIsWater [_desiredPosWorldZero # 0, _desiredPosWorldZero # 1];
            if (_isPosInWater) exitWith {
                systemChat "Deploying in water is not allowed!";
                playSound "AddItemFailed";
            };

            private _direction = direction _assetLoadedItem;
            private _class = typeOf _assetLoadedItem;
            private _nearbyEntities = [_class, AGLtoASL _desiredPosWorldZero, _direction, "dontcheckuid", [_asset, _assetLoadedItem]] call WL2_fnc_grieferCheck;

            if (count _nearbyEntities > 0) exitWith {
                private _nearbyObjectName = [_nearbyEntities # 0] call WL2_fnc_getAssetTypeName;
                systemChat format ["Deploying too close to %1!", _nearbyObjectName];
                playSound "AddItemFailed";
            };

            _assetLoadedItem attachTo [_asset, _desiredPosRelativeHigh];
            detach _assetLoadedItem;

            private _assetLoadedItemPos = getPos _assetLoadedItem;
            _assetLoadedItem setPos [_assetLoadedItemPos # 0, _assetLoadedItemPos # 1, 0];

            [_asset, _assetLoadedItem, false] call WL2_fnc_attachVehicle;
        };
	},
	[],
	5,
	false,
	false,
	"",
	"([_target, _this] call WL2_fnc_deployableEligibility) # 0",
	30,
	false
];

[_asset, _deployActionId] spawn {
    params ["_asset", "_deployActionId"];
    while { alive _asset } do {
        private _assetLoadedItem = _asset getVariable ["WL2_loadedItem", objNull];
        private _hasLoad = !isNull _assetLoadedItem;

        private _actionText = if (_hasLoad) then {
            "Unload deployable";
        } else {
            "Load deployable";
        };

        if (_hasLoad) then {
            if (isAutonomous _assetLoadedItem) then {
				[_asset, false] remoteExec ["setAutonomous", 0];
            };
            if ((locked _assetLoadedItem) != 2) then {
                _assetLoadedItem setVehicleLock "LOCKED";
            };
            {
                moveOut _x;
            } forEach (crew _assetLoadedItem);
        };

        private _actionIcon = if (_hasLoad) then {
            '\A3\ui_f\data\map\markers\handdrawn\end_CA.paa'
        } else {
            '\A3\ui_f\data\map\markers\handdrawn\start_CA.paa'
        };

        _asset setUserActionText [_deployActionId, _actionText, format ["<img size='3' image='%1'/>", _actionIcon]];
        sleep 1;
    };
};
