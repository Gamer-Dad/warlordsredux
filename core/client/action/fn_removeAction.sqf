#include "..\..\warlords_constants.inc"
params ["_asset"];

private _removeActionID = _asset addAction [
	"",
	{
		private _unit = _this # 0;

		private _displayName = [_unit] call WL2_fnc_getAssetTypeName;
		private _result = [format ["Are you sure you would like to delete: %1", _displayName], "Delete asset", true, true] call BIS_fnc_guiMessage;

		if (_result) exitWith {
			if (unitIsUAV _unit) then {
				private _grp = group effectiveCommander _unit;
				{_unit deleteVehicleCrew _x} forEach crew _unit;
				deleteGroup _grp;
			};
			deleteVehicle _unit;
		};
	},
	[],
	-98,
	false,
	true,
	"",
	"vehicle _this != _target && {getPlayerUID _this == (_target getVariable ['BIS_WL_ownerAsset', '123'])}",
	30,
	false
];

_asset setUserActionText [_removeActionID, format ["<t color = '#ff4b4b'>%1</t>", localize "STR_xbox_hint_remove"], "<img size='2' color='#ff4b4b' image='\a3\ui_f\data\IGUI\Cfg\Actions\Obsolete\ui_action_cancel_ca'/>"];