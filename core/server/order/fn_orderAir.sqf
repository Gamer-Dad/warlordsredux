params ["_sender", "_pos", "_orderedClass", "_cost"];

if !(isServer) exitWith {};
private _class = missionNamespace getVariable ["WL2_spawnClass", createHashMap] getOrDefault [_orderedClass, _orderedClass];

private _owner = owner _sender;
_uid = getPlayerUID _sender;

private _spawnPos = [];
private _dir = 0;

private _sector = _pos nearObjects ["Logic", 10];

private _carrierSectors = _sector select {
	count (_x getVariable ["WL_aircraftCarrier", []]) > 0
};
if (count _carrierSectors > 0) then {
	_sector = _carrierSectors # 0;

	private _carrierSettings = _sector getVariable ["WL_aircraftCarrier", []];
	{
		private _potentialSpawn = _x;
		private _potentialSpawnPos = getPosATL _potentialSpawn;
		private _potentialSpawnDir = getDir _potentialSpawn;

		private _potentialSpawnPosASL = ATLtoASL _potentialSpawnPos;
		private _collisionObjects = (_potentialSpawnPosASL nearObjects ["AllVehicles", 20]) select {
			!(_x isKindOf "Man")
		};
		if (count _collisionObjects == 0) then {
			_spawnPos = _potentialSpawnPos;
			_dir = _potentialSpawnDir;
			break;
		};
	} forEach (_carrierSettings call BIS_fnc_arrayShuffle);
} else {
	_sector = (_sector select {count (_x getVariable ["BIS_WL_runwaySpawnPosArr", []]) > 0}) # 0;

	private _taxiNodes = _sector getVariable "BIS_WL_runwaySpawnPosArr";
	private _taxiNodesCnt = count _taxiNodes;
	private _checks = 0;
	while {count _spawnPos == 0 && _checks < 100} do {
		_checks = _checks + 1;
		private _i = (floor random _taxiNodesCnt) max 1;
		private _pointB = _taxiNodes # _i;
		private _pointA = _taxiNodes # (_i - 1);
		_dir = _pointA getDir _pointB;
		private _pos = [_pointA, random (_pointA distance2D _pointB), _dir] call BIS_fnc_relPos;
		if (count (_pos nearObjects ["AllVehicles", 20]) == 0) then {
			_spawnPos = _pos;
		};
		sleep 0.001;
	};
};

if (count _spawnPos == 0) exitWith {
	diag_log format ["Ordering aircraft failed. Spawn position not found in sector %1.", _sector getVariable "BIS_WL_name"];
	"No suitable spawn position found. Clear the runways." remoteExec ["systemChat", _owner];
	_sender setVariable ["BIS_WL_isOrdering", false, [2, _owner]];

	// refund if nothing spawned
	(_cost) call WL2_fnc_fundsDatabaseWrite;
};

private _isUav = getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") == 1;
private _asset = if (_isUav) then {
	[_spawnPos, _class, _orderedClass, 0, _sender] call WL2_fnc_createUAVCrew;
} else {
	createVehicle [_class, _spawnPos, [], 0, "NONE"];
};

_asset setVehiclePosition [_spawnPos, [], 0, "CAN_COLLIDE"];
_asset setDir _dir;

private _textureHashmap = missionNamespace getVariable ["WL2_textures", createHashMap];
private _assetTextures = _textureHashmap getOrDefault [_orderedClass, []];
{
	_asset setObjectTextureGlobal [_forEachIndex, _x];
} forEach _assetTextures;

waitUntil {sleep 0.1; !(isNull _asset)};
_asset enableWeaponDisassembly false;
_asset setVehicleReportRemoteTargets true;
_asset setVehicleReceiveRemoteTargets true;
_asset setVehicleReportOwnPosition true;

private _turretOverrides = missionNamespace getVariable ["WL2_turretOverrides", createHashMap];
private _turretOverridesForVehicle = _turretOverrides getOrDefault [_orderedClass, []];

{
	private _turretOverride = _x;
	private _turret = getArray (_turretOverride >> "turret");
	private _removeMagazines = getArray (_turretOverride >> "removeMagazines");
	private _removeWeapons = getArray (_turretOverride >> "removeWeapons");
	private _addMagazines = getArray (_turretOverride >> "addMagazines");
	private _addWeapons = getArray (_turretOverride >> "addWeapons");

	{
		_asset removeMagazinesTurret [_x, _turret];
	} forEach _removeMagazines;

	{
		_asset removeWeaponTurret [_x, _turret];
	} forEach _removeWeapons;

	private _existingMagazines = _asset magazinesTurret _turret;
	private _existingWeapons = _asset weaponsTurret _turret;

	// exclude pylons
	private _pylonInfo = getAllPylonsInfo _asset;
	_existingMagazines = _existingMagazines - (_pylonInfo apply {_x # 3});
	_existingWeapons = _existingWeapons select {
		private _intersection = (compatibleMagazines _x) arrayIntersect _existingMagazines;
		count _intersection != 0;
	};

	{
		_asset removeMagazineTurret [_x, _turret];
	} forEach _existingMagazines;

	{
		_asset removeWeaponTurret [_x, _turret];
	} forEach _existingWeapons;

	{
		_asset addMagazineTurret [_x, _turret];
	} forEach _addMagazines;

	{
		_asset addWeaponTurret [_x, _turret];
	} forEach _addWeapons;

	{
		_asset addMagazineTurret [_x, _turret];
	} forEach _existingMagazines;

	{
		_asset addWeaponTurret [_x, _turret];
	} forEach _existingWeapons;
} forEach _turretOverridesForVehicle;

private _defaultMags = magazinesAllTurrets _asset;
_asset setVariable ["BIS_WL_defaultMagazines", _defaultMags, true];
_asset setVariable ["WLM_savedDefaultMags", _defaultMags, true];

_asset lock false;

_asset setVariable ["BIS_WL_ownerAsset", _uid, true];
[_asset] call WL2_fnc_lastHitHandler;
_asset setVariable ["WL2_orderedClass", _orderedClass, true];
[_asset, _sender] remoteExec ["WL2_fnc_newAssetHandle", _owner];
_sender setVariable ["BIS_WL_isOrdering", false, [2, _owner]];

[_asset] remoteExec ["WL2_fnc_catapultAction", 0];