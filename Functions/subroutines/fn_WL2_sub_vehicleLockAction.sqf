params ["_asset"];

private _lockActionId = _asset addAction [
	"",
	{
		_this params ["_asset", "_caller", "_lockActionId"];
		private _accessControl = _asset getVariable ["WL2_accessControl", 0];
		private _newAccess = (_accessControl + 1) % 6;
		_asset setVariable ["WL2_accessControl", _newAccess, true];
		[_asset, _lockActionId] call BIS_fnc_WL2_vehicleLock;
		playSound3D ["a3\sounds_f\sfx\objects\upload_terminal\terminal_lock_close.wss", _asset, false, getPosASL _asset, 1, 1, 0, 0];
	},
	[],
	-97,
	true,
	false,
	"",
	"alive _target && {getPlayerUID _this == (_target getVariable ['BIS_WL_ownerAsset', '123'])}",
	50,
	true
];

[_asset, _lockActionId] spawn {
    params ["_asset", "_lockActionId"];
    while { alive _asset } do {
		[_asset, _lockActionId] call BIS_fnc_WL2_vehicleLock;
        sleep 1;
    };
};

// Prevent AI shenanigans
_asset addEventHandler ["GetIn", {
	params ["_vehicle", "_role", "_unit", "_turret"];
	private _access = [_vehicle, _unit, _role] call BIS_fnc_WL2_accessControl;
	if !(_access # 0) then {
		moveOut _unit;
	};
}];

_asset addEventHandler ["SeatSwitched", {
	params ["_vehicle", "_unit1", "_unit2"];

	if (!isNull _unit1) then {
		private _unit1Role = (assignedVehicleRole _unit1) # 0;
		private _access = [_vehicle, _unit1, _unit1Role] call BIS_fnc_WL2_accessControl;
		if !(_access # 0) then {
			moveOut _unit1;
		};
	};

	if (!isNull _unit2) then {
		private _unit2Role = (assignedVehicleRole _unit2) # 0;
		private _access = [_vehicle, _unit2, _unit2Role] call BIS_fnc_WL2_accessControl;
		if !(_access # 0) then {
			moveOut _unit2;
		};
	};
}];