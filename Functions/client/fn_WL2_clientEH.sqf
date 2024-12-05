
private _voteLocked = missionNamespace getVariable ["voteLocked", true];
private _start = serverTime + 10;
waitUntil {sleep 0.1; !_voteLocked || (_start < serverTime);};
if (_voteLocked) exitwith {};

"fundsDatabaseClients" addPublicVariableEventHandler {
	false spawn BIS_fnc_WL2_refreshOSD;
};

addMissionEventHandler ["GroupIconClick", BIS_fnc_WL2_groupIconClickHandle];
addMissionEventHandler ["GroupIconOverEnter", BIS_fnc_WL2_groupIconEnterHandle];
addMissionEventHandler ["GroupIconOverLeave", BIS_fnc_WL2_groupIconLeaveHandle];

player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	VIC_ENTERED = true;
	if ((typeOf _vehicle == "B_Plane_Fighter_01_F") || {(typeOf _vehicle == "B_Plane_CAS_01_dynamicLoadout_F") || {(typeOf _vehicle == "B_Heli_Attack_01_dynamicLoadout_F") || {(typeOf _vehicle == "B_T_VTOL_01_armed_F") || {(typeOf _vehicle == "B_T_VTOL_01_vehicle_F") || {(typeOf _vehicle == "B_T_VTOL_01_infantry_F")}}}}}) then  {
		0 spawn BIS_fnc_WL2_betty;
	};
	if ((typeOf _vehicle == "O_Plane_Fighter_02_F") || {(typeOf _vehicle == "O_Plane_CAS_02_dynamicLoadout_F") || {(typeOf _vehicle == "O_Heli_Attack_02_dynamicLoadout_F") || {(typeOf _vehicle == "O_T_VTOL_02_vehicle_dynamicLoadout_F")}}}) then {
		0 spawn BIS_fnc_WL2_rita;
	};
	if ((_vehicle getVariable "BIS_WL_ownerAsset") == (getPlayerUID player)) then {
		_vehicle setVariable ["BIS_WL_lastActive", 0];
	};
}];

player addEventHandler ["InventoryOpened",{
	params ["_unit","_container"];
	_override = false;
	_allUnitBackpackContainers = (player nearEntities ["Man", 50]) select {isPlayer _x} apply {backpackContainer _x};

	if (_container in _allUnitBackpackContainers) then {
		systemchat "Access denied!";
		_override = true;
	};
	_override;
}];

player addEventHandler ["Killed", {
	BIS_WL_loadoutApplied = FALSE;
	"RequestMenu_close" call BIS_fnc_WL2_setupUI;

	BIS_WL_lastLoadout = +getUnitLoadout player;
	private _varName = format ["BIS_WL_purchasable_%1", BIS_WL_playerSide];
	private _gearArr = (missionNamespace getVariable _varName) # 5;
	private _lastLoadoutArr = _gearArr # 1;
	private _text = localize "STR_A3_WL_last_loadout_info";
	_text = _text + "<br/><br/>";
	{
		if (_forEachIndex in [0,1,2,3,4]) then {
			if (count _x > 0) then {
				_text = _text + (getText (configFile >> "CfgWeapons" >> _x # 0 >> "displayName")) + "<br/>";
			};
		};
		if (_forEachIndex == 5) then {
			if (count _x > 0) then {
				_text = _text + (getText (configFile >> "CfgVehicles" >> _x # 0 >> "displayName")) + "<br/>";
			};
		};
	} forEach BIS_WL_lastLoadout;
	_lastLoadoutArr set [5, _text];
	_gearArr set [1, _lastLoadoutArr];
	(missionNamespace getVariable _varName) set [5, _gearArr];

	_connectedUAV = getConnectedUAV player;
	if (_connectedUAV != objNull) exitWith {
		player connectTerminalToUAV objNull;
	};
	player setVariable ["BIS_WL_isOrdering", false, [2, clientOwner]];
	_canUse = player isUniformAllowed (uniform player);
	if !(_canUse) then {
		[format ["Player:%1, player's UID:%2: Uses a uniform from another faction: %3", player, getPlayerUID player, uniform player]] remoteExec ["diag_log", 2];
	};
	closeDialog 2;
}];

player addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit"];
	_base = (([BIS_WL_base1, BIS_WL_base2] select {(_x getVariable "BIS_WL_owner") == (side group _unit)}) # 0);
	if ((_unit inArea (_base getVariable "objectAreaComplete")) && {!(_base getVariable ["BIS_WL_baseUnderAttack", false])}) then {
		0;
	} else {
		_damage;
	};
}];

player addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret", "_isEject"];
	if (((_vehicle getVariable "BIS_WL_ownerAsset") == (getPlayerUID player)) && (pricehash getOrDefault [typeOf _vehicle, 300] <= 200)) then {
		_vehicle setVariable ["BIS_WL_lastActive", serverTime + 600];
	};
}];

if ((getPlayerUID player) in (getArray (missionConfigFile >> "adminIDs"))) then {
	addMissionEventHandler ["HandleChatMessage", {
		params ["_channel", "_owner", "_from", "_text", "_person"];
		_text = toLower _text;
		_list = getArray (missionConfigFile >> "adminFilter");
		_return = ((_list findIf {[_x, _text] call BIS_fnc_inString}) != -1);

		if (_owner == clientOwner) then {
			_input = _text splitString " ";
			_command = _input # 0;
			_count = count _input;
			if (_count == 1 && {_command == "!updateZeus"}) then {
				[player, 'updateZeus'] remoteExec ['BIS_fnc_WL2_handleClientRequest', 2];
			};
		};
		_senderLocked = _person getVariable ["voteLocked", false];
		if (_senderLocked) then {
			_senderLocked;
		} else {
			_return;
		};
	}];
} else {
	addMissionEventHandler ["HandleChatMessage", {
		params ["_channel", "_owner", "_from", "_text"];
		_text = toLower _text;
		_list = getArray (missionConfigFile >> "adminFilter");
		_return = ((_list findIf {[_x, _text] call BIS_fnc_inString}) != -1);

		_senderLocked = _person getVariable ["voteLocked", false];
		if (_senderLocked) then {
			_senderLocked;
		} else {
			_return;
		};
	}];
};

0 spawn {
	waituntil {sleep 0.1; !isnull (findDisplay 46)};
	private _display = findDisplay 46;
	_display displayAddEventHandler ["KeyUp", {
		_key = _this # 1;
		if (_key in actionKeys "Gear") then {
			BIS_WL_gearKeyPressed = false;
		};
	}];

	_display displayAddEventHandler ["KeyDown", {
		_this call BIS_fnc_WL2_handleKeypress;
	}];

	// intentionally separate handler
	_display displayAddEventHandler ["KeyDown", {
		private _key = _this # 1;
		[_key] call BIS_fnc_WL2_handleBuyMenuKeypress;
	}];
};

//***Fetch price from requisitions.hpp using "priceHash getOrDefault [typeOf _asset, 200]"***/
priceHash = createHashMap;
_fullList = (missionNamespace getVariable (format ["BIS_WL_purchasable_%1", side player]));
{
	if (_forEachIndex < 7) then {
		_category = _x;
		{
			_x params["_name", "_cost"];
			priceHash set [_name, _cost]
		}forEach _category;
	};
}forEach _fullList;

addMissionEventHandler ["EntityCreated", {
	params ["_entity"];
	if (!local _entity) exitWith {};
	_entityType = (typeOf _entity);
	if (isClass (configFile >> "CfgAmmo" >> _entityType)) then {
		_minesDB = (missionNamespace getVariable [format ["BIS_WL2_minesDB_%1", getPlayerUID player], []]);
		if ((_minesDB getOrdefault [_entityType, 0]) isEqualType []) then {
			_limit = (_minesDB get _entityType) # 0;
			_mines = ((_minesDB get _entityType) # 1) select {alive _x};
			if (count _mines >= _limit) then {
				private _t = _mines find objNull;
				if (_t != -1) then {_mines deleteAt _t;};
					if (count _mines >= _limit) then {
						deleteVehicle _entity;
						missionNameSpace setVariable ["mineDisplayActive", serverTime + 5];
						return;
					} else {
						_mines pushBack _entity;
						_minesDB set [_entityType, [_limit, _mines]];
					};
				} else {
				_mines pushBack _entity;
				_minesDB set [_entityType, [_limit, _mines]];
			};
			missionNameSpace setVariable ["mineDisplayActive", serverTime + 5];
			missionNamespace setVariable [format ["BIS_WL2_minesDB_%1", getPlayerUID player], _minesDB, [2, clientOwner]];
		};
	};
}];

addMissionEventHandler ["EntityRespawned", {
	params ["_newEntity", "_oldEntity"];
	private _wasMan = _oldEntity getEntityInfo 0;
	if (_wasMan) then {
		removeAllActions _oldEntity;
	};
}];