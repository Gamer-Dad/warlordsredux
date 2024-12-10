#include "..\warlords_constants.inc"

params ["_asset", ["_owner", objNull]];

[_asset] call BIS_fnc_WL2_lastHitHandler;

if (isServer && {isNull _owner}) exitWith {
	if !(_asset isKindOf "Man") then {
		[_asset] call APS_fnc_RegisterVehicle;
	};
	_asset call APS_fnc_SetupProjectiles;
	_asset setSkill (0.2 + random 0.3);
};

if (isPlayer _owner) then {
	WAS_store = true;

	if (_asset isKindOf "Man") then {
		_asset call APS_fnc_SetupProjectiles;

		private _refreshTimerVar = format ["WL2_manpowerRefreshTimers_%1", getPlayerUID player];
		private _manpowerRefreshTimers = missionNamespace getVariable [_refreshTimerVar, []];
		_manpowerRefreshTimers pushBack [serverTime + WL_MANPOWER_REFRESH_COOLDOWN, _asset];
		missionNamespace setVariable [_refreshTimerVar, _manpowerRefreshTimers, true];

		call BIS_fnc_WL2_teammatesAvailability;
	} else {
		private _side = side _owner;
		private _assetActualType = _asset getVariable ["WL2_orderedClass", typeOf _asset];

		[_asset] call APS_fnc_RegisterVehicle;
		_asset call APS_fnc_SetupProjectiles;
		_asset setVariable ["BIS_WL_nextRepair", 0];
		_asset setVariable ["BIS_WL_ownerAssetSide", _side, true];

		_var = format ["BIS_WL_ownedVehicles_%1", getPlayerUID player];
		_vehicles = missionNamespace getVariable [_var, []];
		_vehicles pushBack _asset;
		missionNamespace setVariable [_var, _vehicles, [2, clientOwner]];
		0 remoteExec ["BIS_fnc_WL2_updateVehicleList", 2];

		_asset spawn BIS_fnc_WL2_sub_rearmAction;

		switch (typeOf _asset) do {
			// Dazzlers
			case "O_T_Truck_03_device_ghex_F";
			case "O_Truck_03_device_F": {
				_asset setVariable ["BIS_WL_dazzlerActivated", false, true];
				_asset setVariable ["BIS_WL_jammerActivated", false, true];
				_asset call BIS_fnc_WL2_sub_dazzlerAction;
				_asset call BIS_fnc_WL2_sub_jammerAction;

				[_asset, _side] call BIS_fnc_drawJammerCircle;
			};
			case "Land_Communication_F": {
				_asset setVariable ["BIS_WL_jammerActivated", false, true];

				// reduce height for demolish action
				private _assetPos = getPosATL _asset;
				_asset setPosATL [_assetPos select 0, _assetPos select 1, -8];

				// too hardy otherwise, start off at 10% health
				_asset setDamage 0.9;
				_asset call BIS_fnc_WL2_sub_jammerAction;

				[_asset, _side] call BIS_fnc_drawJammerCircle;
			};

			// Logistics
			case "B_Truck_01_flatbed_F": {
				_asset call BIS_fnc_WL2_sub_deployableAddAction;
			};
			case "B_T_VTOL_01_vehicle_F": {
				_asset call BIS_fnc_WL2_sub_logisticsAddAction;
			};

			// Radars
			case "B_Radar_System_01_F";
			case "O_Radar_System_02_F": {
				_asset setVariable ["radarRotation", false, true];
				[_asset, "rotation"] call BIS_fnc_WL2_sub_radarOperate;
				[_asset] spawn {
					params ["_asset"];
					private _lookAtPositions = [0, 90, 180, 270] apply { _asset getRelPos [100, _x] };
					private _radarIter = 0;
					while {alive _asset} do {
						if (_asset getVariable "radarRotation") then {
							private _lookAtPos = _lookAtPositions # _radarIter;
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
			case "O_UAV_06_F": {
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
							(getConnectedUAVUnit player) addEventHandler ["Killed", { params ["_unit", "_killer", "_instigator", "_useEffects"];
								[player, "droneExplode", _unit] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2];
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
									[_caller, "droneExplode", _target] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2];
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
				_asset setAutonomous false;
			};
			_asset setVariable ["BIS_WL_ownerUavAsset", getPlayerUID player, true];
			[_asset, _owner] spawn BIS_fnc_WL2_uavJammer;
			_asset setVariable ["WL_canConnectUav", true];

			[_asset] call BIS_fnc_WL2_uavConnectRefresh;
		};

		private _notLockableVehicles = createHashMapFromArray [
			["B_Truck_01_medical_F", true],
			["O_Truck_03_medical_F", true],
			["Land_Pod_Heli_Transport_04_medevac_F", true],
			["B_Slingload_01_Medevac_F", true]
		];
		if !(_notLockableVehicles getOrDefault [typeOf _asset, false]) then {
			_asset call BIS_fnc_WL2_sub_vehicleLockAction;
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

		_asset spawn {
			params ["_asset"];
			_repairActionID = -1;
			while {alive _asset} do {
				_nearbyVehicles = (_asset nearEntities ["All", WL_MAINTENANCE_RADIUS]) select {alive _x};
				_repairCooldown = ((_asset getVariable "BIS_WL_nextRepair") - serverTime) max 0;

				if (_nearbyVehicles findIf {getNumber (configFile >> "CfgVehicles" >> typeOf _x >> "transportRepair") > 0} != -1) then {
					if (_repairActionID == -1) then {
						_repairActionID = _asset addAction [
							"",
							{
								params ["_asset"];
								if ((_asset getVariable "BIS_WL_nextRepair") <= serverTime) then {
									[player, "repair", (_asset getVariable "BIS_WL_nextRepair"), 0, _asset] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2];
									playSound3D ["A3\Sounds_F\sfx\UI\vehicles\Vehicle_Repair.wss", _asset, FALSE, getPosASL _asset, 2, 1, 75];
									[toUpper localize "STR_A3_WL_popup_asset_repaired"] spawn BIS_fnc_WL2_smoothText;
									_asset setVariable ["BIS_WL_nextRepair", serverTime + WL_MAINTENANCE_COOLDOWN_REPAIR];
								} else {
									playSound "AddItemFailed";
								};
							},
							[],
							5,
							TRUE,
							FALSE,
							"",
							"alive _target && {getPlayerUID _this == (_target getVariable ['BIS_WL_ownerAsset', '123']) && {vehicle _this == _this}}",
							WL_MAINTENANCE_RADIUS,
							FALSE
						];
					};
					_asset setUserActionText [_repairActionID, if (_repairCooldown == 0) then {format ["<t color = '#4bff58'>%1</t>", localize "STR_repair"]} else {format ["<t color = '#7e7e7e'><t align = 'left'>%1</t><t align = 'right'>%2     </t></t>", localize "STR_repair", [_repairCooldown, "MM:SS"] call BIS_fnc_secondsToString]}, format ["<img size='2' color = '%1' image='\A3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa'/>", if (_repairCooldown == 0) then {"#ffffff"} else {"#7e7e7e"}]];
				} else {
					if (_repairActionID != -1) then {
						_asset removeAction _repairActionID;
						_repairActionID = -1;
					};
				};
				sleep WL_TIMEOUT_STANDARD;
			};

			_asset removeAction _repairActionID;
		};

		if (getNumber (configFile >> "CfgVehicles" >> typeOf _asset >> "transportAmmo") > 0) then {
			[_asset, 0] remoteExec ["setAmmoCargo", 0];
			_amount = 10000;
			if (typeOf _asset == "B_Truck_01_ammo_F" || {typeOf _asset == "O_Truck_03_ammo_F" || {typeOf _asset == "Land_Pod_Heli_Transport_04_ammo_F" || {typeOf _asset == "B_Slingload_01_Ammo_F"}}}) then {
				_amount = ((getNumber (configfile >> "CfgVehicles" >> typeof _asset >> "transportAmmo")) min 30000);
			};
			_asset setVariable ["WLM_ammoCargo", _amount, true];
		};

		private _rearmTime = (missionNamespace getVariable "WL2_rearmTimers") getOrDefault [(typeOf _asset), 600];
		_asset setVariable ["BIS_WL_nextRearm", serverTime + _rearmTime];

		if (_asset call DIS_fnc_Check) then {
			_asset spawn DIS_fnc_RegisterLauncher;

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
					[_projectile, _unit] call DIS_fnc_StartMissileCamera;
				};
			}];
		};

		private _crewPosition = (fullCrew [_asset, "", true]) select {!("cargo" in _x)};
		private _radarSensor = (listVehicleSensors _asset) select {{"ActiveRadarSensorComponent" in _x} forEach _x};
		if ((count _radarSensor > 0) && (count _crewPosition > 1 || (unitIsUAV _asset))) then {
			_asset setVariable ["radarOperation", false, true];
			_asset setVehicleRadar 2;
			[_asset, "toggle"] call BIS_fnc_WL2_sub_radarOperate;

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
						_projectile spawn BIS_fnc_WL2_airburst;
					};
				};
			}];
		};

		private _demolishable = missionNamespace getVariable ["WL2_demolishable", createHashMap];
		if (_demolishable getOrDefault [_assetActualType, false]) then {
			_asset setVariable ["WL_demolishTurnsLeft", 4, true];
			[_asset] remoteExec ["BIS_fnc_WL2_sub_demolish", 0, true];
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
	};

	_asset call BIS_fnc_WL2_sub_removeAction;
};