private _side = BIS_WL_playerSide;

private _data = createHashMap;
{
    private _type = _x;
    private _customizationData = player getVariable [format ["WLC_%1", _type], ""];
    _data set [_type, _customizationData];
} forEach ["Uniform", "Vest", "Helmet", "Primary", "Secondary", "Launcher"];

[_data, _side, player] remoteExec ["WLC_fnc_serverRequest", 2];