params ["_unit", "_actionId"];

private _parachuteActionId = _unit addAction [
    "<t color='#00ff00'>Open Parachute</t>",
    WL2_fnc_parachuteAction,
    [],
    100
];

waitUntil {
    sleep 1;
    !alive _unit || (getPosATL _unit # 2) < 100 || vehicle _unit != _unit;
};

if (alive _unit && vehicle _unit == _unit) then {
    _unit removeAction _parachuteActionId;
    [objNull, _unit, -1, []] call WL2_fnc_parachuteAction;
};