params ["_asset"];

private _deployActionId = _asset addAction [
	"",
	{
		_this params ["_asset", "_caller", "_deployActionId"];

        _asset removeAction _deployActionId;

        private _assetLoadedItem = _asset getVariable ["WL2_loadedItem", objNull];
        if (isNull _assetLoadedItem) then {
            private _nearEntities = _asset nearEntities 30;
            private _loadableHashmap = missionNamespace getVariable ["WL2_loadable", createHashMap];
            private _nearEntitiesLoadable = _nearEntities select {typeOf _x in _loadableHashmap};

            if (count _nearEntitiesLoadable > 0) then {
                private _assetToLoad = _nearEntitiesLoadable select 0;
                _assetToLoad attachTo [_asset, [0, 0, 1], "proxy:\a3\data_f\proxies\truck_01\cargo.001"];
                _assetToLoad setVehicleLock "LOCKED";
                {
                    _assetToLoad enableVehicleSensor [_x # 0, false];
                } forEach (listVehicleSensors _assetToLoad);

                _asset setVariable ["WL2_loadedItem", _assetToLoad];
            };
        } else {
            _assetLoadedItem attachTo [_asset, [8, 0, 10]];
            detach _assetLoadedItem;
            private _assetLoadedItemPos = getPos _assetLoadedItem;
            _assetLoadedItem setPos [_assetLoadedItemPos # 0, _assetLoadedItemPos # 1, 0];
            _assetLoadedItem setVehicleLock "UNLOCKED";
            {
                _assetLoadedItem enableVehicleSensor [_x # 0, true];
            } forEach (listVehicleSensors _assetLoadedItem);

            _asset setVariable ["WL2_loadedItem", objNull];
        };

        _asset call BIS_fnc_WL2_sub_deployableAddAction;
	},
	[],
	5,
	false,
	false,
	"",
	"alive _target && {getPlayerUID _this == (_target getVariable ['BIS_WL_ownerAsset', '123'])}",
	30,
	false
];

private _addActionText = if (isNull (_asset getVariable ["WL2_loadedItem", objNull])) then {
    "Load deployable"
} else {
    "Unload deployable"
};

private _addActionIcon = if (isNull (_asset getVariable ["WL2_loadedItem", objNull])) then {
    '\A3\ui_f\data\map\markers\handdrawn\start_CA.paa'
} else {
    '\A3\ui_f\data\map\markers\handdrawn\end_CA.paa'
};

_asset setUserActionText [_deployActionId, _addActionText, format ["<img size='2' image='%1'/>", _addActionIcon]];