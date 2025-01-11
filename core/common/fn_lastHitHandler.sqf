params ["_asset"];

_asset addEventHandler ["Hit", {
	params ["_unit", "_source", "_damage", "_instigator"];

	private _responsiblePlayer = [_source, _instigator] call WL2_fnc_handleInstigator;
	private _ownerSide = [_unit] call WL2_fnc_getAssetSide;
	private _responsibleSide = side group _responsiblePlayer;

	if (_ownerSide == _responsibleSide) exitWith {};
	if (!alive _unit || !isDamageAllowed _unit) exitWith {};
	if (isNull _responsiblePlayer) exitWith {};

	_unit setVariable ["WL_lastHitter", _responsiblePlayer, 2];

	private _children = _unit getVariable ["WL2_children", []];
	{
		_x setVariable ["WL_lastHitter", _responsiblePlayer, 2];
	} forEach _children;

	private _crew = crew _unit;
	if (count _crew == 0) exitWith {};
	if (count _crew == 1 && _crew # 0 == _unit) exitWith {};
	{
		_x setVariable ["WL_lastHitter", _responsiblePlayer, 2];
	} forEach _crew;
}];