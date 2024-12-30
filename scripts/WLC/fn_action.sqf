#include "constants.inc"

params ["_flag"];

if (!WLC_ENABLED) exitWith {};

private _index = _flag addAction [
	"Customize Player",
	{
        0 spawn WLC_fnc_buildMenu;
	},
	[],
	5,
	true,
	false,
	"",
	"",
	WL_MAINTENANCE_RADIUS,
	false
];

_flag setUserActionText [_index, "<t color = '#4bff58'>Customize Player</t>", "<img size='1.5' image='a3\ui_f\data\igui\cfg\simpletasks\types\backpack_ca.paa'/>"];

if !(["(EU) #11", serverName] call BIS_fnc_inString) then {
	for "_i" from 0 to 5 do {
		_flag addAction [format ["<t color = '#000000'>(Debug) Set Level to %1</t>", _i * 10], {
			[getPlayerUID player, (_this # 3) * 10000] remoteExec ["WLC_fnc_setScore", 2];
		}, _i, 5];
	};
	_flag addAction ["<t color = '#000000'>(Debug) Set Instant Respawn</t>", {
		setPlayerRespawnTime 1;
	}, [], 5];
	_flag addAction ["<t color = '#000000'>(Debug) Set Normal Respawn</t>", {
		setPlayerRespawnTime (getMissionConfigValue ["respawnDelay", 30]);
	}, [], 5];
};