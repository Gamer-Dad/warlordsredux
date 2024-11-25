params ["_sender", "_pos", "_orderedClass", "_direction"];

if !(isServer) exitWith {};

private _class = missionNamespace getVariable ["WL2_spawnClass", createHashMap] getOrDefault [_orderedClass, _orderedClass];

private _isUav = getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") == 1;
private _asset = if (_isUav) then {
	[_pos, _class, _direction, _sender] call BIS_fnc_WL2_createUAVCrew;
} else {
	[_class, _pos, _direction] call BIS_fnc_WL2_createVehicleCorrectly;
};

// Colored turret texture
// if (_class != _orderedClass) then {
// 	private _textures = getObjectTextures _asset;
// 	private _side = side group _sender;
// 	private _sideColor = if (_side == west) then {
// 		"#(argb,8,8,3)color(0,0.1,0.2,1)"
// 	} else {
// 		"#(argb,8,8,3)color(0.2,0.1,0,1)"
// 	};

// 	{
// 		// if the string includes texture
// 		private _isTurret = ["turret", _x] call BIS_fnc_inString || ["tow", _x] call BIS_fnc_inString;
// 		if (_isTurret) then {
// 			_asset setObjectTextureGlobal [_forEachIndex, _sideColor];
// 		};
// 	} forEach _textures;
// };

waitUntil {sleep 0.1; !(isNull _asset)};

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

_asset enableWeaponDisassembly false;

private _smallFlareMags = (_asset magazinesTurret [-1]) select {_x == "120Rnd_CMFlare_Chaff_Magazine"};
if (count _smallFlareMags == 1) then {
	_asset removeMagazineTurret ["120Rnd_CMFlare_Chaff_Magazine", [-1]];
	_asset addMagazineTurret ["240Rnd_CMFlare_Chaff_Magazine", [-1]]
};

_owner = owner _sender;
_asset setVariable ["BIS_WL_ownerAsset", (getPlayerUID _sender), [2, _owner]];
_asset setVariable ["BIS_WL_lastActive", 0, _owner];
[_asset] call BIS_fnc_WL2_lastHitHandler;
_asset setVariable ["WL2_orderedClass", _orderedClass, true];
[_asset, _sender] remoteExec ["BIS_fnc_WL2_newAssetHandle", _owner];
_sender setVariable ["BIS_WL_isOrdering", false, [2, _owner]];