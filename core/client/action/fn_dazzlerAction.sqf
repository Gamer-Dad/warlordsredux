params ["_asset"];

private _actionID = _asset addAction [
	"",
	{
		_this params ["_asset", "_caller", "_actionID"];
		[_asset] call WL2_fnc_dazzlerToggle;
	},
	[],
	99,
	false,
	false,
	"",
	"alive _target && {getPlayerUID _this == (_target getVariable ['BIS_WL_ownerAsset', '123'])}",
	30,
	true
];

[_asset, _actionID] spawn {
	params ["_asset", "_actionID"];
	while { alive _asset } do {
		private _actionColor = if ([_asset] call APS_fnc_active) then {
			"#ff4b4b";
		} else {
			"#4bff58";
		};

		private _actionText = if ([_asset] call APS_fnc_active) then {
			localize "STR_A3_dazzler_disable";
		} else {
			localize "STR_A3_dazzler_enable";
		};

		_asset setUserActionText [_actionID, format ["<t color = '%1'>%2</t>", _actionColor, _actionText]];

		sleep 1;
	};
};
