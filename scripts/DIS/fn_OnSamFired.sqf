params ["_unit", "_ammo", "_projectile"];

if (!(_ammo isKindOf "MissileBase")) exitWith {};

private _airlock = getNumber (configfile >> "CfgAmmo" >> _ammo >> "airLock");
private _thrust = getNumber (configfile >> "CfgAmmo" >> _ammo >> "thrust");
if (_airlock == 0 && _thrust == 0) exitWith {};

[_projectile, _unit] spawn DIS_fnc_frag;
[_projectile, _unit] spawn DIS_fnc_maneuver;
[_projectile, _unit] spawn DIS_fnc_startMissileCamera;