#include "..\..\warlords_constants.inc"

BIS_WL_assetInfoActive = false;

addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];

	private _userMarkerAlpha = if (profileNamespace getVariable ["MRTM_showMarkers", true]) then {
		1;
	} else {
		0;
	};
	{
		if ("_USER_DEFINED #" in _x) then {
			_x setMarkerAlphaLocal _userMarkerAlpha;
		};
	} forEach allMapMarkers;

	if (_mapIsOpened) then {
		MAP_CONTROL = addMissionEventHandler ["EachFrame", {
			_shown = false;
			_map = (uiNamespace getVariable ["BIS_WL_mapControl", controlNull]);

			if (visibleMap) then {
				_radius = (((ctrlMapScale _map) * 500) min 30);
				_pos = (_map ctrlMapScreenToWorld getMousePosition);
				_nearbyAssets = (_pos nearObjects _radius) select {(getPlayerUID player) == (_x getVariable ["BIS_WL_ownerAsset", "123"]) && {_x != player && {alive _x}}};
				_nearbyAssets append (allUnitsUAV select {(getPlayerUID player) == (_x getVariable ["BIS_WL_ownerAsset", "123"]) && {alive _x && {(_x distance2D _pos) < _radius && {!(_x in _nearbyAssets)}}}});

				if (count _nearbyAssets > 0) then {
					BIS_WL_mapAssetTarget = _nearbyAssets # 0;
					BIS_WL_assetInfoActive = true;
					_shown = true;
					((ctrlParent _map) getVariable "BIS_sectorInfoBox") ctrlSetPosition [(getMousePosition # 0) + safeZoneW / 100, (getMousePosition # 1) + safeZoneH / 50, safeZoneW, safeZoneH];
					((ctrlParent _map) getVariable "BIS_sectorInfoBox") ctrlCommit 0;
					((ctrlParent _map) getVariable "BIS_sectorInfoBox") ctrlSetStructuredText parseText format [
						"<t shadow = '2' size = '%1'>%2</t>",
						(1 call WL2_fnc_purchaseMenuGetUIScale),
						format [
							localize "STR_A3_WL_info_asset_map_deletion",
							"<t color = '#ff4b4b'>",
							"</t>",
							"<br/>",
							[BIS_WL_mapAssetTarget] call WL2_fnc_getAssetTypeName
						]
					];
					((ctrlParent _map) getVariable "BIS_sectorInfoBox") ctrlShow true;
					((ctrlParent _map) getVariable "BIS_sectorInfoBox") ctrlEnable true;
				};

				if (isNull (findDisplay 160 displayCtrl 51)) then {
					_mapScale = ctrlMapScale WL_CONTROL_MAP;
					_timer = (serverTime % WL_MAP_PULSE_FREQ);
					_timer = if (_timer <= (WL_MAP_PULSE_FREQ / 2)) then {_timer} else {WL_MAP_PULSE_FREQ - _timer};
					_markerSize = linearConversion [0, WL_MAP_PULSE_FREQ / 2, _timer, 1, WL_MAP_PULSE_ICON_SIZE];
					_markerSizeArr = [_markerSize, _markerSize];

					{
						_x setMarkerSizeLocal [WL_CONNECTING_LINE_AXIS * _mapScale * BIS_WL_mapSizeIndex, (markerSize _x) # 1];
					} forEach BIS_WL_sectorLinks;

					{
						if !(_x in BIS_WL_selection_availableSectors) then {
							((_x getVariable "BIS_WL_markers") # 0) setMarkerSizeLocal [1, 1];
						} else {
							if (_x == BIS_WL_targetVote) then {
								((_x getVariable "BIS_WL_markers") # 0) setMarkerSizeLocal [WL_MAP_PULSE_ICON_SIZE, WL_MAP_PULSE_ICON_SIZE];
							} else {
								((_x getVariable "BIS_WL_markers") # 0) setMarkerSizeLocal _markerSizeArr;
							};
						};
					} forEach BIS_WL_allSectors;
				};
			};

			if (!_shown && BIS_WL_assetInfoActive) then {
				BIS_WL_mapAssetTarget = objNull;
				BIS_WL_assetInfoActive = false;
				((ctrlParent _map) getVariable "BIS_sectorInfoBox") ctrlShow false;
				((ctrlParent _map) getVariable "BIS_sectorInfoBox") ctrlEnable false;
			};
		}];

		MAP_CONTROL_CLICK = addMissionEventHandler ["MapSingleClick", {
			params ["_units", "_pos", "_alt", "_shift"];
			_asset = BIS_WL_mapAssetTarget;
			if (_alt && _shift) then {
				if !(isNull _asset) then {
					_vehicles = (missionNamespace getVariable [format ["BIS_WL_ownedVehicles_%1", getPlayerUID player], []]);
					_asset spawn WL2_fnc_deleteAssetFromMap;
				};
			};
		}];
	} else {
		removeMissionEventHandler ["EachFrame", MAP_CONTROL];
		removeMissionEventHandler ["MapSingleClick", MAP_CONTROL_CLICK];
	};
}];