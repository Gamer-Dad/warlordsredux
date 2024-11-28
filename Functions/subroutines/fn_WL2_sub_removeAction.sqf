#include "..\warlords_constants.inc"
params ["_asset"];

private _removeActionID = _asset addAction [
	"",
	{
		private _unit = _this # 0;

		private _assetActualType = _unit getVariable ["WL2_orderedClass", typeOf _unit];
		private _nameOverrides = missionNamespace getVariable ["WL2_nameOverrides", createHashMap];
		private _displayName = _nameOverrides getOrDefault [_assetActualType, getText (configFile >> 'CfgVehicles' >> _assetActualType >> 'displayName')];

		private _result = [format ["Are you sure you would like to delete: %1", _displayName], "Delete asset", true, true] call BIS_fnc_guiMessage;

		if (_result) exitWith {
			if (unitIsUAV _unit) then {
				private _grp = group effectiveCommander _unit;
				{_unit deleteVehicleCrew _x} forEach crew _unit;
				deleteGroup _grp;
			};

			[_unit] remoteExec ["BIS_fnc_WL2_removeAsset", 2];
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