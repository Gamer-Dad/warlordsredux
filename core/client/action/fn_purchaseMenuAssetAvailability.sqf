#include "..\..\warlords_constants.inc"

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

private _ret = true;
private _tooltip = "";
private _class = _className;
private _DLCOwned = true;
private _DLCTooltip = "";

_funds = ((missionNamespace getVariable "fundsDatabaseClients") get (getPlayerUID player));

if (isNil "_class") exitWith {};
if (_cost > _funds) then {_ret = false; _tooltip = localize "STR_A3_WL_low_funds"};
if (!alive player) then {_ret = false; _tooltip = localize "STR_A3_WL_fasttravel_restr6"};
if (lifeState player == "INCAPACITATED") then {_ret = false; _tooltip = format [localize "STR_A3_Revive_MSG_INCAPACITATED", name player]};

if (_ret) then {
	private _enemiesNearPlayer = (allPlayers inAreaArray [player, 100, 100]) select {_x != player && BIS_WL_playerSide != side group _x && alive _x};
	private _homeBase = BIS_WL_playerSide call WL2_fnc_getSideBase;
	private _isInHomeBase = player inArea (_homeBase getVariable "objectAreaComplete");
	private _nearbyEnemies = count _enemiesNearPlayer > 0 && !_isInHomeBase;

	switch (_class) do {
		case "FTSeized": {
			if (vehicle player != player) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_fasttravel_restr3"};
			if (BIS_WL_currentSelection == WL_ID_SELECTION_FAST_TRAVEL) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_menu_resetvoting_restr1"};
			if (_nearbyEnemies) exitWith {_ret = false; _tooltip =  localize "STR_A3_WL_fasttravel_restr4"};
		};
		case "FTConflict": {
			if (vehicle player != player) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_fasttravel_restr3"};
			if (isNull WL_TARGET_FRIENDLY) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_no_conflict"};
			if (WL_TARGET_FRIENDLY in WL_BASES) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_fasttravel_restr1"};
			if !(WL_TARGET_FRIENDLY in (BIS_WL_sectorsArray # 1)) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_fasttravel_restr5"};
			if (BIS_WL_currentSelection == WL_ID_SELECTION_FAST_TRAVEL) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_menu_resetvoting_restr1"};
			if (_nearbyEnemies) exitWith {_ret = false; _tooltip =  localize "STR_A3_WL_fasttravel_restr4"};
		};
		case "FTSquadLeader": {
			if (vehicle player != player) exitWith {
				_ret = false;
				_tooltip = localize "STR_A3_WL_fasttravel_restr3"
			};
			if (_nearbyEnemies) exitWith {
				_ret = false;
				_tooltip =  localize "STR_A3_WL_fasttravel_restr4"
			};

			// Cooldown check
			private _ftNextUseVar = format ["BIS_WL_FTSLNextUse_%1", getPlayerUID player];
			private _ftNextUse = missionNamespace getVariable [_ftNextUseVar, 0];
			if (serverTime < _ftNextUse) exitWith {
				_ret = false;
				private _cooldownText = localize "STR_SQUADS_cooldown";
				private _timeoutDisplay = [_ftNextUse - serverTime, "MM:SS"] call BIS_fnc_secondsToString;
				_tooltip = format [_cooldownText, _timeoutDisplay];
			};

			// Squad leader checks
			private _squadLeaderID = ['getMySquadLeader'] call SQD_fnc_client;
			if (_squadLeaderID == getPlayerID player) exitWith {
				_ret = false;
				_tooltip = localize "STR_SQUADS_fastTravelSquadLeaderInvalid";
			};
			if (_squadLeaderID == "-1") exitWith {
				_ret = false;
				_tooltip = localize "STR_SQUADS_fastTravelSquadInvalidNoSquad";
			};

			private _squadLeader = allPlayers select {
				getPlayerID _x == _squadLeaderID
			} select 0;

			if !(isNull objectParent _squadLeader) exitWith {
				_ret = false;
				_tooltip = localize "STR_SQUADS_fastTravelSquadLeaderInVehicle";
			};
			if (!alive _squadLeader) exitWith {
				_ret = false;
				_tooltip = localize "STR_SQUADS_fastTravelSquadLeaderUnavailable";
			};
		};
		case "LastLoadout": {
			if (vehicle player != player) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_fasttravel_restr3"};
			if (count BIS_WL_lastLoadout == 0) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_no_loadout_saved"};
			if (BIS_WL_loadoutApplied) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_loadout_reapply_info"};
			if (BIS_WL_lastLoadout isEqualTo (getUnitLoadout player)) exitWith {_ret = false; _tooltip = "You have the same gear as last time."};
			_possibleSectors = (BIS_WL_sectorsArray # 0);
			_visitedSectorID = _possibleSectors findIf {player inArea (_x getVariable "objectAreaComplete")};
			if (_visitedSectorID == -1) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_menu_arsenal_restr1"};
			if (_nearbyEnemies) exitWith {_ret = false; _tooltip =  localize "STR_A3_WL_fasttravel_restr4"};
		};
		case "SavedLoadout": {
			if (vehicle player != player) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_fasttravel_restr3"};
			if (count BIS_WL_savedLoadout == 0) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_no_loadout_saved"};
			_possibleSectors = (BIS_WL_sectorsArray # 0);
			_visitedSectorID = _possibleSectors findIf {player inArea (_x getVariable "objectAreaComplete")};
			if (_visitedSectorID == -1) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_menu_arsenal_restr1"};
			if (_nearbyEnemies) exitWith {_ret = false; _tooltip =  localize "STR_A3_WL_fasttravel_restr4"};
		};
		case "FundsTransfer": {
			if ((playersNumber BIS_WL_playerSide) < 2) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_transfer_restr1_TODO_REWRITE"};
		};
		case "TargetReset": {
			if (isNull WL_TARGET_FRIENDLY) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_no_conflict"};
			_sectorSelectedTimestampVarID = format ["BIS_WL_sectorSelectedTimestamp_%1", BIS_WL_playerSide];
			_targetResetVotingVarID = format ["BIS_WL_targetResetVotingSince_%1", BIS_WL_playerSide];
			if (serverTime < ((missionNamespace getVariable [_sectorSelectedTimestampVarID, 0]) + (getMissionConfigValue ["BIS_WL_sectorResetTimeout", 300]))) exitWith {_ret = false; _tooltip = ([(((missionNamespace getVariable [_sectorSelectedTimestampVarID, 0]) + (getMissionConfigValue ["BIS_WL_sectorResetTimeout", 300])) - serverTime), "MM:SS"] call BIS_fnc_secondsToString)};
			if (serverTime < ((missionNamespace getVariable [_targetResetVotingVarID, 0]) + WL_TARGET_RESET_VOTING_TIME + 60)) exitWith {_ret = false; _tooltip = ([(((missionNamespace getVariable [_targetResetVotingVarID, 0]) + WL_TARGET_RESET_VOTING_TIME + 60) - serverTime), "MM:SS"] call BIS_fnc_secondsToString)};
		};
		case "forfeitVote": {
			private _countSide = playersNumber BIS_WL_playerSide;
			private _enemySide = playersNumber BIS_WL_enemySide;
			_forfeitVotingVarID = format ["BIS_WL_forfeitVotingSince_%1", BIS_WL_playerSide];
			if (_countSide < 10 && _countSide > (_enemySide - 5)) exitWith {_ret = false; _tooltip = format ["%1/10 Players", _countSide]};
			if (serverTime < ((missionNamespace getVariable [_forfeitVotingVarID, 0]) + 1200)) exitWith {_ret = false; _tooltip = ([(((missionNamespace getVariable [_forfeitVotingVarID, 0]) + 1200) - serverTime), "MM:SS"] call BIS_fnc_secondsToString)};
		};
		case "Arsenal": {
			if (vehicle player != player) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_fasttravel_restr3"};
			_possibleSectors = (BIS_WL_sectorsArray # 0);
			_visitedSectorID = _possibleSectors findIf {player inArea (_x getVariable "objectAreaComplete")};
			if (_visitedSectorID == -1) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_menu_arsenal_restr1"};
			if !(isNull (findDisplay 602)) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_menu_arsenal_restr2"};
			if (_nearbyEnemies) exitWith {_ret = false; _tooltip =  localize "STR_A3_WL_fasttravel_restr4"};
		};
		case "RemoveUnits": {
			if (count ((groupSelectedUnits player) select {_x != player && {(_x getVariable ["BIS_WL_ownerAsset", "123"]) == (getPlayerUID player)}}) == 0) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_info_no_units_selected"};
		};
		case "RespawnVic": {
			if (vehicle player != player) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_fasttravel_restr3"};
			if (_nearbyEnemies) exitWith {_ret = false; _tooltip =  localize "STR_A3_WL_fasttravel_restr4"};
			_visitedSectorID = (BIS_WL_sectorsArray # 0) findIf {player inArea (_x getVariable "objectAreaComplete")};
			if (_visitedSectorID == -1) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_restr1"};
			private _ftVehicle = if (BIS_WL_playerSide == west) then {((count ((entities "B_Truck_01_medical_F") select {alive _x})) > 0)} else {((count ((entities "O_Truck_03_medical_F") select {alive _x})) > 0)};
			if (_ftVehicle) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_restr"};
		};
		case "RespawnVicFT": {
			if (vehicle player != player) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_fasttravel_restr3"};
			if (_nearbyEnemies) exitWith {_ret = false; _tooltip =  localize "STR_A3_WL_fasttravel_restr4"};
			if (BIS_WL_playerSide == west) then {
				private _ftBlu = (((entities "B_Truck_01_medical_F") select {alive _x}) # 0);
				if ((count ((entities "B_Truck_01_medical_F") select {alive _x})) > 0) then {
					if (((getPosATL _ftBlu) select 2) > 5) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_ft_restr"};
					if ((count fullCrew [_ftBlu, "cargo", false]) >= 15) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_ft_restr"};
					if ((speed _ftBlu) > 0) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_ft_restr"};
				} else {
					if ((count ((entities "B_Truck_01_medical_F") select {alive _x})) == 0) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_ft_restr"};
				};
			} else {
				private _ftOpf = (((entities "O_Truck_03_medical_F") select {alive _x}) # 0);
				if ((count ((entities "O_Truck_03_medical_F") select {alive _x})) > 0) then {
					if (((getPosATL _ftOpf) select 2) > 5) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_ft_restr"};
					if ((count fullCrew [_ftOpf, "cargo", false]) >= 15) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_ft_restr"};
					if ((speed _ftOpf) > 0) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_ft_restr"};
				} else {
					if ((count ((entities "O_Truck_03_medical_F") select {alive _x})) == 0) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_ft_restr"};
				};
			};
		};
		case "RespawnPod": {
			if (vehicle player != player) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_fasttravel_restr3"};
			if (_nearbyEnemies) exitWith {_ret = false; _tooltip =  localize "STR_A3_WL_fasttravel_restr4"};
			_visitedSectorID = (BIS_WL_sectorsArray # 0) findIf {player inArea (_x getVariable "objectAreaComplete")};
			if (_visitedSectorID == -1) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_restr1"};
			private _ftVehicle = if (BIS_WL_playerSide == west) then {((count (entities "B_Slingload_01_Medevac_F")) > 0)} else {((count (entities "Land_Pod_Heli_Transport_04_medevac_F")) > 0)};
			if (_ftVehicle) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_restr"};
		};
		case "RespawnPodFT" : {
			if (vehicle player != player) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_fasttravel_restr3"};
			if (_nearbyEnemies) exitWith {_ret = false; _tooltip =  localize "STR_A3_WL_fasttravel_restr4"};
			if (BIS_WL_playerSide == west) then {
				private _ftBlu = ((entities "B_Slingload_01_Medevac_F") # 0);
				if ((count (entities "B_Slingload_01_Medevac_F")) > 0) then {
					if (((getPosATL _ftBlu) select 2) > 5) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_ft_restr"};
					if ((speed _ftBlu) > 0) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_ft_restr"};
				} else {
					if ((count (entities "B_Slingload_01_Medevac_F")) == 0) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_ft_restr"};
				};
			} else {
				private _ftOpf = ((entities "Land_Pod_Heli_Transport_04_medevac_F") # 0);
				if ((count (entities "Land_Pod_Heli_Transport_04_medevac_F")) > 0) then {
					if (((getPosATL _ftOpf) select 2) > 5) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_ft_restr"};
					if ((count fullCrew [_ftOpf, "cargo", false]) >= 4) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_ft_restr"};
					if ((speed _ftOpf) > 0) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_ft_restr"};
				} else {
					if ((count (entities "Land_Pod_Heli_Transport_04_medevac_F")) == 0) exitWith {_ret = false; _tooltip = localize "STR_A3_WL_ftVehicle_ft_restr"};
				};
			};
		};
		default {
			_possibleSectors = (BIS_WL_sectorsArray # 0);
			_visitedSectorID = _possibleSectors findIf {player inArea (_x getVariable "objectAreaComplete")};
			_servicesAvailable = BIS_WL_sectorsArray # 5;
			_var = format ["BIS_WL_ownedVehicles_%1", getPlayerUID player];
			private _ownedVehicles = missionNamespace getVariable [_var, []];
			_vehiclesCnt = count (_ownedVehicles select {alive _x});

			private _currentSector = if (_visitedSectorID != -1) then {
				_possibleSectors # _visitedSectorID
			} else {
				objNull;
			};

			private _servicesInSector = _currentSector getVariable ["BIS_WL_services", []];
			if ("H" in _requirements && !("H" in _servicesInSector)) exitWith {
				_ret = false;
				_tooltip = localize "STR_A3_WL_popup_appropriate_sector_selection";
			};

			if (_requirements findIf {!(_x in _servicesAvailable)} >= 0) exitWith {
				_ret = false;
				_tooltip = localize "STR_A3_WL_airdrop_restr1"
			};

			if (_className isKindOf "Man" && BIS_WL_matesAvailable <= 0) exitWith {
				_ret = false;
				_tooltip = localize "STR_A3_WL_airdrop_restr2"
			};

			if (_category == "Strategy") exitWith {};

			if (_vehiclesCnt >= (getMissionConfigValue ["BIS_WL_assetLimit", 10])) exitWith {
				_ret = false;
				_tooltip = localize "STR_A3_WL_popup_asset_limit_reached";
			};

			if (_nearbyEnemies) exitWith {
				_ret = false;
				_tooltip =  localize "STR_A3_WL_tooltip_deploy_enemies_nearby";
			};

			if (vehicle player != player && !("A" in _requirements)) exitWith {
				_ret = false;
				_tooltip = localize "STR_A3_WL_fasttravel_restr3";
			};

			if (!("A" in _requirements) && !("W" in _requirements) && _visitedSectorID == -1) exitWith {
				_ret = false;
				_tooltip = localize "STR_A3_WL_ftVehicle_restr1";
			};

			if (player getVariable ["BIS_WL_isOrdering", false]) exitWith {
				_ret = false;
				_tooltip = "Another order is in progress!";
			};

			private _spawnClass = missionNamespace getVariable ["WL2_spawnClass", createHashMap] getOrDefault [_class, _class];
			if (getNumber (configFile >> "CfgVehicles" >> _spawnClass >> "isUav") == 1) then {
				private _ownedUavs = _ownedVehicles select {
					private _isUav = unitIsUAV _x || getNumber (configFile >> "CfgVehicles" >> typeOf _x >> "isUav") == 1;
					_isUav && alive _x
				};

				if (count _ownedUavs >= getMissionConfigValue ["BIS_WL_autonomous_limit", 2]) exitWith {
					_ret = false;
					_tooltip = format [localize "STR_A3_WL_tip_max_autonomous", (getMissionConfigValue ["BIS_WL_autonomous_limit", 2])];
				};
			};

			if (_class == "Land_Communication_F") then {
				private _allJammerMarkers = allMapMarkers select {
					_x find "BIS_WL_jammerMarkerOuter_" == 0;
				};
				private _allJammers = _allJammerMarkers apply {
					objectFromNetId (_x regexReplace ["BIS_WL_jammerMarkerOuter_", ""]);
				};
				private _allTowersOnTeam = _allJammers select {
					typeOf _x == "Land_Communication_F"
					&& _x getVariable ["BIS_WL_ownerAssetSide", sideUnknown] == BIS_WL_playerSide
				};
				private _jammersNear = _allTowersOnTeam select { player distance _x < (WL_JAMMER_RANGE_OUTER * 2) };

				if (count _jammersNear > 0) exitWith {
					_ret = false;
					_tooltip = localize "STR_A3_WL_jammer_restr";
				};

				if (_isInHomeBase) exitWith {
					_ret = false;
					_tooltip = localize "STR_A3_WL_jammer_home_restr";
				};
			};

			_DLCOwned = [_class, "IsOwned"] call WL2_fnc_purchaseMenuHandleDLC;
			_DLCTooltip = [_class, "GetTooltip"] call WL2_fnc_purchaseMenuHandleDLC;
		};
	};
};

[_ret, _tooltip, _DLCOwned, _DLCTooltip];