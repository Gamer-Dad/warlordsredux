#include "constants.inc"

params ["_data", "_side", "_sender"];

{
    private _type = _x;
    private _customizationData = _y;

    private _customizationMap = missionNamespace getVariable [format ["WLC_%1_%2", _type, _side], createHashMap];
    private _customization = _customizationMap getOrDefault [_customizationData, createHashMap];

    private _cost = _customization getOrDefault ["cost", 0];
    private _item = _customization getOrDefault ["item", ""];
    if (_cost >= 0 && playerFunds >= _cost && _item != "") then {
        private _uid = getPlayerUID _sender;
        (-_cost) call WL2_fnc_fundsDatabaseWrite;
        [_type, _customization] remoteExec ["WLC_fnc_clientEquip", _sender];
    };
} forEach _data;