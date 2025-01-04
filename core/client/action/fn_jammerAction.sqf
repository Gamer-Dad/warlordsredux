params ["_asset"];

private _actionID = _asset addAction [
	"",
	{
		_this params ["_asset", "_caller", "_actionID"];
		[_asset] call WL2_fnc_jammerToggle;
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
		private _isActive = _asset getVariable ["BIS_WL_jammerActivated", false] && isEngineOn _asset;
		private _isActivating = _asset getVariable ["BIS_WL_jammerActivating", false] && isEngineOn _asset;
		private _actionColor = if (_isActive) then {
			"#ff4b4b";
		} else {
			"#4b51ff";
		};

		private _actionText = if (_isActive) then {
			localize "STR_A3_jammer_disable";
		} else {
			if (_isActivating) then {
				localize "STR_A3_jammer_activating";
			} else {
				localize "STR_A3_jammer_enable";
			};
		};

        private _outerMarkerName = format ["BIS_WL_jammerMarkerOuter_%1", netId _asset];
		if (_isActive) then {
			_asset setFuelConsumptionCoef 5;
			_outerMarkerName setMarkerAlpha 1;
		} else {
			if (_isActivating) then {
				_asset setFuelConsumptionCoef 5;
				_outerMarkerName setMarkerAlpha 1;
			} else {
				_asset setFuelConsumptionCoef 1;
				_outerMarkerName setMarkerAlpha 0;
			};
		};

		_asset setUserActionText [_actionID, format ["<t color = '%1'>%2</t>", _actionColor, _actionText]];

		sleep 1;
	};
};