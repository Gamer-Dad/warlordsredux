#include "constants.inc"

params ["_control", "_lbCurSel", "_type"];

private _display = findDisplay WLC_DISPLAY;

if (isNull _display) exitWith {};
if (_lbCurSel <= 0) exitWith {
    player setVariable [format ["WLC_%1", _type], ""];
};

private _selectedValue = _control lbValue _lbCurSel;
private _score = WLC_Scores getOrDefault [getPlayerUID player, 0];
private _level = floor (_score / 1000);
if (_selectedValue > _level) then {
    private _customizationData = player getVariable [format ["WLC_%1", _type], ""];
    if (_customizationData != "") then {
        for "_index" from 0 to lbSize _control - 1 do {
            if (_control lbData _index == _customizationData) then {
                _control lbSetCurSel _index;
                break;
            };
        };
    } else {
        _control lbSetCurSel 0;
    };
} else {
    private _customizationData = _control lbData _lbCurSel;
    player setVariable [format ["WLC_%1", _type], _customizationData];
};