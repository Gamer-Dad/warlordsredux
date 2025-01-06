#include "..\warlords_constants.inc"

params ["_asset", ["_owner", objNull]];

[_asset] call WL2_fnc_lastHitHandler;

if (isServer) then {
	_asset setSkill (0.2 + random 0.3);

	private _defaultMags = magazinesAllTurrets _asset;
	_asset setVariable ["BIS_WL_defaultMagazines", _defaultMags, true];
	_asset setVariable ["WLM_savedDefaultMags", _defaultMags, true];
};

if (isPlayer _owner) then {
	WAS_store = true;
};

if (_asset isKindOf "Man") then {
	_asset call APS_fnc_setupProjectiles;

	if (isPlayer _owner) then {
		private _refreshTimerVar = format ["WL2_manpowerRefreshTimers_%1", getPlayerUID player];
		private _manpowerRefreshTimers = missionNamespace getVariable [_refreshTimerVar, []];
		_manpowerRefreshTimers pushBack [serverTime + WL_MANPOWER_REFRESH_COOLDOWN, _asset];
		missionNamespace setVariable [_refreshTimerVar, _manpowerRefreshTimers, true];

		call WL2_fnc_teammatesAvailability;
	};
} else {
	private _side = if (isPlayer _owner) then {
		side group _owner
	} else {
		independent
	};
	private _playerUID = if (isPlayer _owner) then {
		getPlayerUID _owner
	} else {
		"123"
	};

	private _assetActualType = _asset getVariable ["WL2_orderedClass", typeOf _asset];

	[_asset] call APS_fnc_registerVehicle;
	_asset call APS_fnc_setupProjectiles;
	_asset setVariable ["BIS_WL_nextRepair", 0, true];
	_asset setVariable ["BIS_WL_ownerAssetSide", _side, true];
	_asset setVariable ["WL2_massDefault", getMass _asset];

	_var = format ["BIS_WL_ownedVehicles_%1", _playerUID];
	_vehicles = missionNamespace getVariable [_var, []];
	_vehicles pushBack _asset;
	missionNamespace setVariable [_var, _vehicles, [2, clientOwner]];
	0 remoteExec ["WL2_fnc_updateVehicleList", 2];

	[_asset] remoteExec ["WL2_fnc_rearmAction", 0, true];

	_asset setVariable ["WL2_lastLoadedTime", serverTime];

	switch (typeOf _asset) do {
		// Dazzlers
		case "O_T_Truck_03_device_ghex_F";
		case "O_Truck_03_device_F": {
			_asset setVariable ["BIS_WL_dazzlerActivated", false, true];
			_asset setVariable ["BIS_WL_jammerActivated", false, true];

			[_asset] remoteExec ["WL2_fnc_dazzlerAction", 0, true];
			[_asset] remoteExec ["WL2_fnc_jammerAction", 0, true];

			[_asset, _side] call WL2_fnc_drawJammerCircle;
		};
		case "Land_Communication_F": {
			_asset setVariable ["BIS_WL_jammerActivated", false, true];

			// reduce height for demolish action
			private _assetPos = getPosATL _asset;
			_asset setPosATL [_assetPos select 0, _assetPos select 1, -8];

			// too hardy otherwise, start off at 10% health
			_asset setDamage 0.9;
			[_asset] remoteExec ["WL2_fnc_jammerAction", 0, true];

			[_asset, _side] call WL2_fnc_drawJammerCircle;
		};

		// Logistics
		case "B_Truck_01_flatbed_F": {
			[_asset] remoteExec ["WL2_fnc_deployableAddAction", 0, true];
		};
		case "B_T_VTOL_01_vehicle_F": {
			_asset call WL2_fnc_logisticsAddAction;
		};
		case "B_Heli_Transport_01_F";
		case "B_Heli_Transport_03_F";
		case "O_Heli_Light_02_unarmed_F";
		case "O_Heli_Light_02_dynamicLoadout_F";
		case "O_Heli_Transport_04_F": {
			[_asset] remoteExec ["WL2_fnc_slingAddAction", 0, true];
		};

		// Radars
		case "B_Radar_System_01_F";
		case "O_Radar_System_02_F";
		case "I_E_Radar_System_01_F": {
			_asset setVariable ["radarRotation", false, true];
			[_asset] remoteExec ["WL2_fnc_radarRotateAction", 0, true];

			[_asset] spawn {
				params ["_asset"];
				private _lookAtAngles = [0, 90, 180, 270];
				private _radarIter = 0;
				while {alive _asset} do {
					private _radarRotation = _asset getVariable ["radarRotation", false];
					if (_radarRotation) then {
						private _lookAtPos = _asset getRelPos [100, _lookAtAngles # _radarIter];
						if (local _asset) then {
							_asset lookAt _lookAtPos;
						} else {
							[_asset, _lookAtPos] remoteExec ["lookAt", _asset];
						};
						_radarIter = (_radarIter + 1) % 4;
					};
					sleep 2.4;
				};
			};
		};

		// Suicide drones
		case "B_UAV_06_F";
		case "O_UAV_06_F";
		case "I_UAV_06_F": {
			waitUntil {sleep 0.1; !(isNull group _asset)};
			_asset spawn {
				params ["_asset"];
				[
					driver _asset,
					format["<t color='#E5E500' shadow='2'>&#160;%1</t>", "*Arm Drone*"],
					"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\attack_ca.paa",
					"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\attack_ca.paa",
					"!(isNull (getConnectedUAVUnit player))",
					"!(isNull (getConnectedUAVUnit player))",
					{
						playSound3D ["a3\sounds_f\sfx\objects\upload_terminal\terminal_antena_close.wss", (getConnectedUAVUnit player), false, getPosASL (getConnectedUAVUnit player), 1, 1, 0];
					},
					{},
					{
						(getConnectedUAVUnit player) addEventHandler ["Killed", {
							params ["_unit", "_killer", "_instigator", "_useEffects"];
							[player, "droneExplode", _unit] remoteExec ["WL2_fnc_handleClientRequest", 2];
						}];
						[
							getConnectedUAVUnit player,
							format["<t color='#f80e1a' shadow='2'>&#160;%1</t>", "*Detonate*"],
							"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\destroy_ca.paa",
							"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\destroy_ca.paa",
							"!(isNull (getConnectedUAVUnit player))",
							"!(isNull (getConnectedUAVUnit player))",
							{},
							{},
							{
								[player, "droneExplode", _target] remoteExec ["WL2_fnc_handleClientRequest", 2];
							},
							{},
							[],
							1
						] call BIS_fnc_holdActionAdd;
					},
					{},
					[],
					2
				] call BIS_fnc_holdActionAdd;
			};
		};

		case "C_IDAP_UAV_06_antimine_F": {
			waitUntil {sleep 0.1; !(isNull group _asset)};
		};
	};

	if (unitIsUAV _asset) then {
		if (profileNamespace getVariable ["MRTM_enableAuto", true]) then {
			[_asset, false] remoteExec ["setAutonomous", 0];
		};
		_asset setVariable ["BIS_WL_ownerUavAsset", _playerUID, true];
		[_asset, _owner] spawn WL2_fnc_uavJammer;
		_asset setVariable ["WL_canConnectUav", true];

		private _assetGrp = group _asset;
		private _assetTypeName = [_asset] call WL2_fnc_getAssetTypeName;
		_assetGrp setGroupIdGlobal [format ["%1#%2#%3", name _owner, _assetTypeName, groupId _assetGrp]];

		[_asset] call WL2_fnc_uavConnectRefresh;
	};

	private _notLockableVehicles = createHashMapFromArray [
		["B_Truck_01_medical_F", true],
		["O_Truck_03_medical_F", true],
		["Land_Pod_Heli_Transport_04_medevac_F", true],
		["B_Slingload_01_Medevac_F", true]
	];
	if !(_notLockableVehicles getOrDefault [typeOf _asset, false]) then {
		if (_asset isKindOf "ReammoBox_F") then {
			_asset setVariable ["WL2_accessControl", 2, true];
		} else {
			_asset setVariable ["WL2_accessControl", 4, true];
		};
		[_asset] remoteExec ["WL2_fnc_vehicleLockAction", 0, true];
	};

	if (profileNamespace getVariable ["MRTM_spawnEmpty", false]) then {
		if (typeOf _asset != "B_supplyCrate_F" && {typeOf _asset != "O_supplyCrate_F"}) then {
			if !((typeOf _asset) in (getArray (missionConfigFile >> "logisticsConfig" >> "cargoTypes" >> "Cargo"))) then {
				clearMagazineCargoGlobal _asset;
				clearItemCargoGlobal _asset;
				clearWeaponCargoGlobal _asset;
			};
		};
	};

	[_asset] remoteExec ["WL2_fnc_repairAction", 0, true];

	if (getNumber (configFile >> "CfgVehicles" >> typeOf _asset >> "transportAmmo") > 0) then {
		[_asset, 0] remoteExec ["setAmmoCargo", 0];
		_amount = 10000;
		if (typeOf _asset == "B_Truck_01_ammo_F" || {typeOf _asset == "O_Truck_03_ammo_F" || {typeOf _asset == "Land_Pod_Heli_Transport_04_ammo_F" || {typeOf _asset == "B_Slingload_01_Ammo_F"}}}) then {
			_amount = ((getNumber (configfile >> "CfgVehicles" >> typeof _asset >> "transportAmmo")) min 30000);
		};
		_asset setVariable ["WLM_ammoCargo", _amount, true];
	};

	if (getNumber (configFile >> "CfgVehicles" >> typeOf _asset >> "transportRepair") > 0) then {
		[_asset, 0] remoteExec ["setRepairCargo", 0];
	};

	private _rearmTime = (missionNamespace getVariable "WL2_rearmTimers") getOrDefault [(typeOf _asset), 600];
	_asset setVariable ["BIS_WL_nextRearm", serverTime + _rearmTime, true];

	if (_asset call DIS_fnc_check) then {
		_asset spawn DIS_fnc_registerLauncher;

		// Warning for turret ownership change
		[_asset] spawn {
			params ["_asset"];
			private _weaponSafe = -1;
			private _warned = false;
			while { alive _asset && !_warned } do {
				private _uavControl = UAVControl _asset;
				private _isTurretTransferring = _uavControl # 1 != "" && !(_asset turretLocal [0]);
				if (_isTurretTransferring && _weaponSafe == -1) then {
					_weaponSafe = _asset addAction ["Weapon Safety", {
						systemChat "Changing turret ownership (arma bug). Wait a few seconds before firing.";
					}, [], 0, false, false, "DefaultAction", ""];
				};
				if (!_isTurretTransferring && _weaponSafe != -1) then {
					_asset removeAction _weaponSafe;
					_weaponSafe = -1;
					_warned = true;
				};
				sleep 0.1;
			};
		};
	};
	if (typeOf _asset == "B_Ship_MRLS_01_F") then {
		_asset addEventHandler ["Fired", {
			params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
			if (local _projectile) then {
				[_projectile, _unit] call DIS_fnc_startMissileCamera;
			};
		}];
	};

	private _crewPosition = (fullCrew [_asset, "", true]) select {!("cargo" in _x)};
	private _radarSensor = (listVehicleSensors _asset) select {{"ActiveRadarSensorComponent" in _x} forEach _x};
	private _hasRadar = count _radarSensor > 0 && (count _crewPosition > 1 || unitIsUAV _asset);
	if (_hasRadar) then {
		_asset setVariable ["radarOperation", false, true];
		_asset setVehicleRadar 2;
		[_asset] remoteExec ["WL2_fnc_radarOperateAction", 0, true];

		_asset spawn {
			params ["_asset"];

			while {alive _asset} do {
				private _radarValue = if (_asset getVariable "radarOperation") then {
					1;
				} else {
					2;
				};

				if (local _asset) then {
					_asset setVehicleRadar _radarValue;
				} else {
					[_asset, _radarValue] remoteExec ["setVehicleRadar", _asset];
				};

				sleep 10;
			};
		};
	};

	if (typeOf _asset == "B_APC_Tracked_01_AA_F" || typeOf _asset == "O_APC_Tracked_02_AA_F") then {
		_asset addEventHandler ["Fired", {
			params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
			if (_muzzle == "autocannon_35mm") then {
				private _ammoCount = _unit ammo "autocannon_35mm";
				if (_ammoCount % 5 == 0) then {
					_projectile spawn WL2_fnc_airburst;
				};
			};
		}];
	};

	private _demolishable = missionNamespace getVariable ["WL2_demolishable", createHashMap];
	if (_demolishable getOrDefault [_assetActualType, false]) then {
		_asset setVariable ["WL_demolishTurnsLeft", 4, true];
		[_asset] remoteExec ["WL2_fnc_demolish", 0, true];
	};

	private _structure = missionNamespace getVariable ["WL2_structure", createHashMap];
	if (_structure getOrDefault [typeOf _asset, false]) then {
		_asset setVariable ["WL_structure", true, 2];
	};

	private _parachuteCount = count ((backpackCargo _asset) select {_x == "B_Parachute"});
	if (_parachuteCount > 0) then {
		_asset addEventHandler ["GetOut", {
			params ["_vehicle", "_role", "_unit", "_turret", "_isEject"];

			if (!_isEject) exitWith {};


			[_vehicle, _unit] spawn {
				params ["_vehicle", "_unit"];

				private _height = (getPos _unit) # 2;
				private _distance = _vehicle distance _unit;

				waitUntil {
					sleep 1;
					_height = (getPos _unit) # 2;
					_distance = _vehicle distance _unit;
					_height < 5 || _distance > 10 || !alive _unit || !alive _vehicle;
				};

				if (_height > 5 && alive _unit) then {
					private _parachute = createVehicle ["Steerable_Parachute_F", position _unit, [], 0, "CAN_COLLIDE"];
					_unit moveInDriver _parachute;
				};
			};
		}];
	};

	if ("hide_rail" in (animationNames _asset)) then {
		_asset animateSource ["hide_rail", 0];
	};

	[_asset] remoteExec ["WL2_fnc_claimAction", 0, true];
};

[_asset] remoteExec ["WL2_fnc_removeAction", 0, true];