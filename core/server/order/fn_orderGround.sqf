params ["_sender", "_pos", "_orderedClass", "_direction"];

if !(isServer) exitWith {};

private _class = missionNamespace getVariable ["WL2_spawnClass", createHashMap] getOrDefault [_orderedClass, _orderedClass];

private _isUav = getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") == 1;
private _asset = if (_isUav) then {
	[_pos, _class, _direction, _sender] call WL2_fnc_createUAVCrew;
} else {
	[_class, _pos, _direction] call WL2_fnc_createVehicleCorrectly;
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

private _side = side group _sender;
private _isAircraft = _asset isKindOf "Air";
private _variant = missionNamespace getVariable ["WL2_variant", createHashMap] getOrDefault [_orderedClass, 0];
if (!_isAircraft && _variant != 0) then {
	private _sideFlag = if (_side == west) then {
		"\A3\Ui_f\data\Map\Markers\Flags\nato_ca.paa"
	} else {
		"\A3\Ui_f\data\Map\Markers\Flags\CSAT_ca.paa"
	};

	private _flagMap = missionNamespace getVariable ["WL2_flagOffsets", createHashMap];
	private _flagOffset = _flagMap getOrDefault [_orderedClass, []];
	if (count _flagOffset > 0) then {
		private _flag = createVehicle ["FlagChecked_F", _asset, [], 0, "CAN_COLLIDE"];
		_flag setFlagTexture _sideFlag;
		_flag attachTo [_asset, _flagOffset, "otocvez", true];

		private _assetChildren = _asset getVariable ["WL2_children", []];
		_assetChildren pushBack _flag;
		_asset setVariable ["WL2_children", _assetChildren, [2, _sender]];
	} else {
		_asset forceFlagTexture _sideFlag;
	};
};

private _turretOverrides = missionNamespace getVariable ["WL2_turretOverrides", createHashMap];
private _turretOverridesForVehicle = _turretOverrides getOrDefault [_orderedClass, []];

{
	private _turretOverride = _x;
	private _turret = getArray (_turretOverride >> "turret");
	private _removeMagazines = getArray (_turretOverride >> "removeMagazines");
	private _removeWeapons = getArray (_turretOverride >> "removeWeapons");
	private _addMagazines = getArray (_turretOverride >> "addMagazines");
	private _addWeapons = getArray (_turretOverride >> "addWeapons");
	private _reloadOverride = getNumber (_turretOverride >> "reloadOverride");

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

	if (_reloadOverride != 0) then {
		_asset setVariable ["WL2_reloadOverride", [_reloadOverride, _turret]];
		_asset addEventHandler ["Fired", {
			params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
			private _reloadOverride = _unit getVariable ["WL2_reloadOverride", []];
			private _reloadTime = _reloadOverride # 0;
			private _turret = _reloadOverride # 1;

			private _weaponState = weaponState [_unit, _turret];
			if (_weaponState # 6 > 0) then {
				[_unit, _weapon, _turret, _reloadTime] remoteExec ["WL2_fnc_reloadOverride", _gunner];
			};
		}];
	};
} forEach _turretOverridesForVehicle;

private _defaultMags = magazinesAllTurrets _asset;
_asset setVariable ["BIS_WL_defaultMagazines", _defaultMags, true];
_asset setVariable ["WLM_savedDefaultMags", _defaultMags, true];

_asset lock false;

_owner = owner _sender;
_asset setVariable ["BIS_WL_ownerAsset", getPlayerUID _sender, true];
_asset setVariable ["BIS_WL_lastActive", 0, _owner];
[_asset] call WL2_fnc_lastHitHandler;
_asset setVariable ["WL2_orderedClass", _orderedClass, true];
[_asset, _sender] remoteExec ["WL2_fnc_newAssetHandle", _owner];
_sender setVariable ["BIS_WL_isOrdering", false, [2, _owner]];