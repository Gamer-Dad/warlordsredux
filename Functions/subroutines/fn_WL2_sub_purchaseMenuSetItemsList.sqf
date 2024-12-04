#include "..\warlords_constants.inc"

_display = uiNamespace getVariable ["BIS_WL_purchaseMenuDisplay", displayNull];
_purchase_category = _display displayCtrl 100;
private _purchase_items_list = _display displayCtrl 101;
lbClear _purchase_items_list;
_id = lbCurSel _purchase_category;

{
	private _gearCode = "";
	private _zeroes = _forEachIndex / 9;
	for "_i" from 1 to _zeroes do {
		_gearCode = _gearCode + "0";
	};
	private _tailNumber = _forEachIndex % 9 + 1;
	_gearCode = _gearCode + str _tailNumber;

	_x params [
		"_className",
		"_cost",
		"_requirements",
		"_displayName",
		"_picture",
		"_text",
		["_offset", [0,0,0]]
	];

	_purchase_items_list lbAdd format ["%1 [%2]", _displayName, _gearCode];
	if (_className == "RemoveUnits") then {uiNamespace setVariable ["BIS_WL_removeUnitsListID", -1 + lbSize _purchase_items_list]};
	_purchase_items_list lbSetData [_forEachIndex, format ["%1|||%2|||%3|||%4|||%5|||%6", _className, _requirements, _displayName, _picture, _text, _offset]];
	_purchase_items_list lbSetValue [_forEachIndex, _x # 1];
} forEach (WL_PLAYER_REQUISITION_LIST # _id);

_purchase_items_list lbSetCurSel ((uiNamespace getVariable ["BIS_WL_purchaseMenuLastSelection", [0, 0, 0]]) # 1);;
_purchase_items = _display displayCtrl 1;
private _maxSubordinates = missionNamespace getVariable [format ["BIS_WL_maxSubordinates_%1", BIS_WL_playerSide], 1];

private _refreshTimerText = "";
private _refreshTimerVar = format ["WL2_manpowerRefreshTimers_%1", getPlayerUID player];
private _manpowerRefreshTimers = missionNamespace getVariable [_refreshTimerVar, []];
private _refreshTimerText = (_manpowerRefreshTimers apply {
	private _cooldown = _x # 0 - serverTime;
	[_cooldown, "MM:SS"] call BIS_fnc_secondsToString;
}) joinString ", ";

(_display displayCtrl 103) ctrlSetStructuredText parseText format [
	"<t align = 'left' size = '%2'>%1</t>",
	[
		format ["Max subordinates: %1<br/>Refresh Timers: %2", _maxSubordinates, _refreshTimerText],
		localize "STR_A3_WL_LightVehicle_Info",
		localize "STR_A3_WL_HeavyVehicle_Info",
		localize "STR_A3_WL_RotaryWing_Info",
		localize "STR_A3_WL_FixedWing_Info",
		localize "STR_A3_WL_RemoteControl_Info",
		localize "STR_A3_WL_AirDefense_Info",
		localize "STR_A3_WL_SectorDefense_Info",
	 	localize "STR_A3_WL_asset_naval_info",
	 	localize "STR_A3_WL_asset_gear_info",
	 	""
	] # _id,
	(0.85 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale)
];
call BIS_fnc_WL2_sub_purchaseMenuSetAssetDetails;