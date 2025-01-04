params ["_asset"];

if ([_asset] call APS_fnc_active) then {
    _asset setVariable ["BIS_WL_dazzlerActivated", false, true];
} else {
    _asset setVariable ["BIS_WL_dazzlerActivated", true, true];
    if (!isEngineOn _asset) then {
        [_asset] remoteExec ["WL2_fnc_dazzlerOn", 2];
    };
};