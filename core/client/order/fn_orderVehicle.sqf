params ["_orderedClass", "_cost", "_offset"];

player setVariable ["BIS_WL_isOrdering", true, [2, clientOwner]];

private _class = missionNamespace getVariable ["WL2_spawnClass", createHashMap] getOrDefault [_orderedClass, _orderedClass];

if (_class isKindOf "Man") then {
	_asset = (group player) createUnit [_class, (getPosATL player), [], 2, "NONE"];
	_asset setVariable ["BIS_WL_ownerAsset", getPlayerUID player, [2, clientOwner]];
	[player, "orderAI", _class] remoteExec ["WL2_fnc_handleClientRequest", 2];
	[_asset, player] spawn WL2_fnc_newAssetHandle;
	player setVariable ["BIS_WL_isOrdering", false, [2, clientOwner]];
} else {
	if (visibleMap) then {
		openMap [false, false];
		titleCut ["", "BLACK IN", 0.5];
	};

	if (count _offset != 3) then {
		_offset = [0, 8, 0];
	};

	private _asset = createSimpleObject [_class, AGLToASL (player modelToWorld _offset), true];

	_asset setDir direction player;
	_asset lock 2;

	private _textureHashmap = missionNamespace getVariable ["WL2_textures", createHashMap];
	private _assetTextures = _textureHashmap getOrDefault [_orderedClass, []];
	{
		_asset setObjectTextureGlobal [_forEachIndex, _x];
	} forEach _assetTextures;

	[player, "assembly"] call WL2_fnc_hintHandle;

	BIS_WL_spacePressed = false;
	BIS_WL_backspacePressed = false;

	_deployKeyHandle = (findDisplay 46) displayAddEventHandler ["KeyDown", {
		if (_this # 1 == 57) then {
			if !(BIS_WL_backspacePressed) then {
				BIS_WL_spacePressed = TRUE;
			};
		};
		if (_this # 1 == 14) then {
			if !(BIS_WL_spacePressed) then {
				BIS_WL_backspacePressed = TRUE;
			};
		};
	}];

	uiNamespace setVariable ["BIS_WL_deployKeyHandle", _deployKeyHandle];
	private _originalPosition = getPosATL player;

	[_asset, _offset] spawn {
		params ["_asset", "_offset"];

		private _boundingBoxHeight = (boundingBoxReal _asset) # 0 # 2;
		while { !(isNull _asset) && !(BIS_WL_spacePressed) && !(BIS_WL_backspacePressed) } do {
			private _assetPos = player modelToWorld _offset;
			private _assetHeight = getTerrainHeightASL [_assetPos # 0, _assetPos # 1];
			private _playerHeight = (getPosASL player) # 2;
			private _offset_tweaked = [_offset # 0, _offset # 1, _assetHeight - _playerHeight - _boundingBoxHeight];
			_asset attachTo [player, _offset_tweaked];
			sleep 1;
		};
	};

	[_originalPosition, _asset] spawn {
		params ["_originalPosition"];

		waitUntil {
			sleep 0.1;
			BIS_WL_spacePressed ||
			BIS_WL_backspacePressed ||
			[_originalPosition] call WL2_fnc_cancelVehicleOrder;
		};

		if !(BIS_WL_spacePressed) then {
			BIS_WL_backspacePressed = TRUE;
		};
	};

	waitUntil {sleep 0.1; BIS_WL_spacePressed || {BIS_WL_backspacePressed}};

	(findDisplay 46) displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "BIS_WL_deployKeyHandle"];
	uiNamespace setVariable ['BIS_WL_deployKeyHandle', nil];
	_offset set [1, _asset distance2D player];
	detach _asset;
	_p = getPosATL _asset;
	deleteVehicle _asset;

	[player, "assembly", false] call WL2_fnc_hintHandle;

	private _canStillOrderVehicle = !([_originalPosition] call WL2_fnc_cancelVehicleOrder);
	if (BIS_WL_spacePressed && _canStillOrderVehicle) then {
		playSound "assemble_target";
		[player, "orderAsset", "vehicle", [(_p # 0), (_p # 1), 0], _orderedClass, direction player] remoteExec ["WL2_fnc_handleClientRequest", 2];
	} else {
		"Canceled" call WL2_fnc_announcer;
		[toUpper localize "STR_A3_WL_deploy_canceled"] spawn WL2_fnc_smoothText;
		player setVariable ["BIS_WL_isOrdering", false, [2, clientOwner]];
	};
};

sleep 0.1;
showCommandingMenu "";