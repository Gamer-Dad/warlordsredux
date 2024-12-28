#include "constants.inc"

params ["_flag"];

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