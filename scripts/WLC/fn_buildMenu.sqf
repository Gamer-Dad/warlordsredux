#include "constants.inc"

private _display = findDisplay WLC_DISPLAY;

if (isNull _display) then {
    _display = createDialog ["WLC_MenuUI", true];
};

disableSerialization;

private _side = BIS_WL_playerSide;

private _closeButton = _display displayCtrl WLC_CLOSE_BUTTON;
_closeButton ctrlAddEventHandler ["ButtonClick", {
    closeDialog 0;
}];

private _controlMap = createHashMapFromArray [
    [WLC_PRIMARY_SELECT, "Primary"],
    [WLC_SECONDARY_SELECT, "Secondary"],
    [WLC_LAUNCHER_SELECT, "Launcher"],
    [WLC_UNIFORM_SELECT, "Uniform"],
    [WLC_VEST_SELECT, "Vest"],
    [WLC_HELMET_SELECT, "Helmet"]
];

private _score = WLC_Scores getOrDefault [getPlayerUID player, 0];
private _level = floor (_score / 1000);
private _nextLevelScore = (_level + 1) * 1000;

private _levelDisplay = _display displayCtrl WLC_LEVEL_TEXT;
_levelDisplay ctrlSetText format ["Level %1 (%2/%3)", _level, _score, _nextLevelScore];

{
    private _select = _display displayCtrl _x;
    private _type = _y;
    private _customizationList = missionNamespace getVariable [format ["WLC_%1_%2", _type, _side], createHashMap];

    lbClear _select;
    private _default = _select lbAdd "None";
    _select lbSetData [_default, ""];
    _select lbSetValue [_default, -1];

    {
        private _class = _x;
        private _customization = _y;
        private _name = _customization getOrDefault ["name", ""];
        private _value = _customization getOrDefault ["value", 0];

        private _index = _select lbAdd _name;
        _select lbSetData [_index, _class];
        _select lbSetTooltip [_index, _name];
        _select lbSetValue [_index, _value];

        if (_value > _level) then {
            _select lbSetColor [_index, [1, 0, 0, 1]];
            _select lbSetText [_index, format ["(Lvl %1) %2 ", _value, _name]];
        };

    } forEach _customizationList;
    _select lbSortBy ["VALUE", false];

    private _customizationData = player getVariable [format ["WLC_%1", _type], ""];
    if (_customizationData != "") then {
        for "_index" from 0 to lbSize _select - 1 do {
            if (_select lbData _index == _customizationData) then {
                _select lbSetCurSel _index;
                break;
            };
        };
    } else {
        _select lbSetCurSel 0;
    };

    _select ctrlAddEventHandler ["LBSelChanged", format ["[_this # 0, _this # 1, '%1'] spawn WLC_fnc_onSelection", _type]];
} forEach _controlMap;