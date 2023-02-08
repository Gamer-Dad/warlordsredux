private["_v","_i","_d","_vel","_c","_las","_ir","_g","_exit","_speed","_side","_z"];

_v = _this select 0;
_i = _this select 1;
_exit = false;
if ((typeOf _i) in dapsExcludedAmmo) exitWith {};
if (_i in dapsDazzled) exitWith {};
dapsDazzled pushBack _i;

_g = getNumber (configFile>>"CfgAmmo">>(typeOf _i)>>"maneuvrability");
if (_g == 0) exitWith {};

_speed = getNumber (configFile>>"CfgAmmo">>(typeOf _i)>>"maxSpeed");
_d = _v distance _i;

sleep .0001;

if ((_v distance _i) > _d) exitWith {
	dapsDazzled = dapsDazzled - [_i];
};

_p = getPosATL _i;
_id = getDir _i;
[ _v, _id, _p, _i] call DAPS_fnc_React;

if !(alive _i) exitWith {};
if (_exit) exitWith {
	dapsDazzled = dapsDazzled - [_i]
};

_d = 0;
_side = "left";
if ((random 10) > 5) then{
	_side = "right"
};
_z = "up";
if ((random 10)>5) then {
	_z = "down"
};
_d = 10+random 10;
if (_side == "left") then {
	_d = (getDir _i) - _d;
} else {
	_d = (getDir _i) + _d;
};
if (_d>359.9) then {
	_d = 0;
};
if (_d<0) then {
	_d = 0;
};

_c = 40;
_vel = velocity _i;
_i setDir _d;

if (_z == "up") then {
	_i setVelocity [_vel select 0, _vel select 1, (_vel select 2) + _c];
} else {
	_i setVelocity [_vel select 0, _vel select 1, (_vel select 2) - _c];
};

[_v, "", 0, false] remoteExec ["DAPS_fnc_Report"];

while {alive _i} do {
	sleep 3;
};
dapsDazzled = dapsDazzled - [_i];