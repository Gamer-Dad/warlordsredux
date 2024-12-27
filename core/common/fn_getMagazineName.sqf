params ["_magazine"];

private _menuTextOverrides = call WLM_fnc_menuTextOverrides;

if (_magazine == "EMPTY") exitWith {
    "EMPTY";
};

private _magazineName = getText (configFile >> "CfgMagazines" >> _magazine >> "displayName");
if (_magazineName == "") then {
    _magazineName = _magazine;
};

private _overrideMagazineName = (_menuTextOverrides # 0) getOrDefault [_magazine, "No Override"];
if (_overrideMagazineName != "No Override") then {
    _magazineName = _overrideMagazineName;
};

private _magSize = getNumber (configFile >> "CfgMagazines" >> _magazine >> "count");
_magazineName = format ["%1 (%2)", _magazineName, _magSize];

_magazineName;