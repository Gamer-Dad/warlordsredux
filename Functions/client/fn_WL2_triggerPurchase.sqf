#include "..\warlords_constants.inc"

params [
    "_className",
    "_requirements",
    "_displayName",
    "_picture",
    "_text",
    "_offset",
    "_cost",
    "_category"
];

if (typeName _offset == "STRING") then {
    _offset = call compile _offset;
};
if (typeName _requirements == "STRING") then {
    _requirements = call compile _requirements;
};
switch (_className) do {
    case "Arsenal": {if (isNull (findDisplay 602)) then {"RequestMenu_close" call BIS_fnc_WL2_setupUI; [player, "orderArsenal"] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2]} else {playSound "AddItemFailed"}};
    case "LastLoadout": {"RequestMenu_close" call BIS_fnc_WL2_setupUI; [player, "lastLoadout"] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2]};
    case "SaveLoadout": {"save" call BIS_fnc_WL2_orderSavedLoadout};
    case "SavedLoadout": {"RequestMenu_close" call BIS_fnc_WL2_setupUI; [player, "savedLoadout"] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2]};
    case "Scan": {0 spawn BIS_fnc_WL2_orderSectorScan};
    case "FTSeized": {false spawn BIS_fnc_WL2_orderFastTravel};
    case "FTConflict": {true spawn BIS_fnc_WL2_orderFastTravel};
    case "FTSquadLeader": {
        ["ftSquadLeader"] spawn SQD_fnc_client;
        private _ftNextUseVar = format ["BIS_WL_FTSLNextUse_%1", getPlayerUID player];
        missionNamespace setVariable [_ftNextUseVar, serverTime + WL_FAST_TRAVEL_SQUAD_LEADER_RATE];
    };
    case "FundsTransfer": {call BIS_fnc_WL2_orderFundsTransfer; [player, "fundsTransferBill"] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2]};
    case "TargetReset": {"RequestMenu_close" call BIS_fnc_WL2_setupUI; [player, "targetReset"] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2]};
    case "forfeitVote": {0 spawn BIS_fnc_WL2_orderForfeit};
    case "LockVehicles": {
        {
            [_x, false, true] remoteExec ["BIS_fnc_WL2_vehicleLock", _x];
        } forEach ((missionNamespace getVariable [format ["BIS_WL_ownedVehicles_%1", getPlayerUID player], []]) select {alive _x && {(!(typeOf _x == "B_Truck_01_medical_F")) && {!(typeOf _x == "O_Truck_03_medical_F") && {!(typeOf _x == "B_Slingload_01_Medevac_F") && {!(typeOf _x == "Land_Pod_Heli_Transport_04_medevac_F")}}}}});
        [toUpper localize "STR_A3_WL_feature_lock_all_msg"] spawn BIS_fnc_WL2_smoothText;
    };
    case "UnlockVehicles": {
        {
            [_x, false, false] remoteExec ["BIS_fnc_WL2_vehicleLock", _x];
        } forEach ((missionNamespace getVariable [format ["BIS_WL_ownedVehicles_%1", getPlayerUID player], []]) select {alive _x});
        [toUpper localize "STR_A3_WL_feature_unlock_all_msg"] spawn BIS_fnc_WL2_smoothText;
    };
    case "clearVehicles": {
        {
            {
                moveOut _x;
            } forEach ((crew _x) select {(_x != player) && {(getPlayerUID player) != (_x getVariable ["BIS_WL_ownerAsset", "123"])}});
        } forEach ((missionNamespace getVariable [format ["BIS_WL_ownedVehicles_%1", getPlayerUID player], []]) select {alive _x});
    };
    case "pruneAssets": {
        "RequestMenu_close" call BIS_fnc_WL2_setupUI;

        0 spawn {
            private _ownedVehicleVariable = format ["BIS_WL_ownedVehicles_%1", getPlayerUID player];
            private _allAssets = (missionNamespace getVariable [_ownedVehicleVariable, []]) select { alive _x };

            private _listText = "Your assets<br/>";
            {
                private _asset = _x;

                private _displayName = [_asset] call BIS_fnc_WL2_getAssetTypeName;
                private _assetSector = BIS_WL_allSectors select { _asset inArea (_x getVariable "objectAreaComplete") };
                private _assetLocation = if (count _assetSector > 0) then {
                    (_assetSector # 0) getVariable ["BIS_WL_name", str (mapGridPosition _asset)];
                } else {
                    mapGridPosition _asset;
                };
                _listText = _listText + format ["%1 @ %2<br/>", _displayName, _assetLocation];
            } forEach _allAssets;
            _listText = _listText + "Would you like to go through and delete some of them?";

            private _result = [_listText, "Asset List", "Yes", "Cancel"] call BIS_fnc_guiMessage;

            if (_result) then {
                {
                    sleep 0.2;
                    private _asset = _x;

                    private _displayName = [_asset] call BIS_fnc_WL2_getAssetTypeName;
                    private _assetSector = BIS_WL_allSectors select { _asset inArea (_x getVariable "objectAreaComplete") };
                    private _assetLocation = if (count _assetSector > 0) then {
                        (_assetSector # 0) getVariable ["BIS_WL_name", str (mapGridPosition _asset)];
                    } else {
                        mapGridPosition _asset;
                    };
                    _result = [format ["Would you would like to delete: %1 @ %2", _displayName, _assetLocation], "Delete asset", true, true] call BIS_fnc_guiMessage;

                    if (_result) then {
                        if (unitIsUAV _asset) then {
                            private _group = group effectiveCommander _asset;
                            {_asset deleteVehicleCrew _x} forEach crew _asset;
                            deleteGroup _group;
                        };

                        deleteVehicle _asset;
                    };
                } forEach _allAssets;
            };
        };
    };
    case "RemoveUnits": {
        {
            deleteVehicle _x;
        } forEach ((groupSelectedUnits player) select {_x != player && {_x getVariable ["BIS_WL_ownerAsset", "123"] == getPlayerUID player}});
        false spawn BIS_fnc_WL2_refreshOSD;
    };
    case "wipeMap": {
        {
            if ("_USER_DEFINED #" in _x) then {
                deleteMarkerLocal _x;
            };
        } forEach allMapMarkers;
    };
    case "RespawnVic": {"RequestMenu_close" call BIS_fnc_WL2_setupUI; [player, "orderFTVehicle"] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2]};
    case "RespawnVicFT": {0 spawn BIS_fnc_WL2_orderFTVehicleFT};
    case "RespawnPod" : {"RequestMenu_close" call BIS_fnc_WL2_setupUI; [player, "orderFTPod"] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2]};
    case "RespawnPodFT" : {0 spawn BIS_fnc_WL2_orderFTPodFT};
    case "welcomeScreen": {0 spawn BIS_fnc_WL2_welcome};
    default {[_className, _cost, _category, _requirements, _offset] call BIS_fnc_WL2_requestPurchase};
};