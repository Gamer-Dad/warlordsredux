#include "..\warlords_constants.inc"

params [["_fullRefresh", false, [false]]];

call BIS_fnc_WL2_sub_purchaseMenuRefresh;

waitUntil {!isNull (uiNamespace getVariable ["BIS_WL_osd_action_voting_title", controlNull])};
private _scale = (0.8 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale);
private _side = BIS_WL_playerSide;
private _maxSubordinates = missionNamespace getVariable [format ["BIS_WL_maxSubordinates_%1", _side], 1];
(uiNamespace getVariable "BIS_WL_osd_cp_current") ctrlSetStructuredText parseText format ["<t color='#ffffff' shadow = '2' size = '%2'>%3%1</t>", ((missionNamespace getVariable "fundsDatabaseClients") get (getPlayerUID player)), 1 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale, [_side] call BIS_fnc_WL2_getMoneySign];
(uiNamespace getVariable "BIS_WL_osd_income_side_2") ctrlSetStructuredText parseText format ["<t size = '%3' shadow = '2'>%1/%2</t>", BIS_WL_matesAvailable,_maxSubordinates , _scale];

if (_fullRefresh) then {
	(uiNamespace getVariable "BIS_WL_osd_sectors_side_1") ctrlSetStructuredText parseText format ["<t size = '%2' align = 'center' shadow = '2'>%1</t>", count (BIS_WL_sectorsArray # 0), 0.6 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale];
	(uiNamespace getVariable "BIS_WL_osd_income_side_1") ctrlSetStructuredText parseText format ["<t size = '%2' shadow = '2'>+%1</t>", BIS_WL_playerSide call BIS_fnc_WL2_income, _scale];
};

private _cdText = "";
if (vehicle player !=  player) then {
	private _cooldown = ((vehicle player getVariable ["BIS_WL_nextRearm", 0]) - serverTime) max 0;

	if (_cooldown > 0) then {
		private _cooldownDisplay = [_cooldown, "MM:SS"] call BIS_fnc_secondsToString;
		_cdText = format ["<t color = '#ff0000' size = '%1' shadow = '2'>%2</t>", _scale, _cooldownDisplay];
	} else {
		_cdText = format ["<t color = '#00ff00' size = '%1' shadow = '2'>Ready</t>", _scale];
	};
};

private _rearm_possible = uiNamespace getVariable "BIS_WL_osd_rearm_possible";
if (BIS_WL_showHint_maintenance) then {
	if (_cdText != "") then {
		_cdText = format ["(%1)", _cdText];
	};
	_rearm_possible ctrlSetStructuredText parseText format ["<t color = '#00ff00' size = '%1' shadow = '2' align = 'center'>%2 %3</t>", _scale, localize "STR_A3_WL_OSD_rearm_possible", _cdText];
} else {
	if (_cdText != "") then {
		_cdText = format ["Rearm: %1", _cdText];
	};
	_rearm_possible ctrlSetStructuredText parseText format ["<t color = '#ffffff' size = '%1' shadow = '2' align = 'center'>%2</t>", _scale, _cdText];
};

if (BIS_WL_showHint_nearSL) then {
	(uiNamespace getVariable "BIS_WL_osd_sl_nearby") ctrlSetStructuredText parseText format ["<img color='#3CB043' size='%1' image='\A3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeUnits_ca.paa'/>", 0.70 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale];
} else {
	(uiNamespace getVariable "BIS_WL_osd_sl_nearby") ctrlSetStructuredText parseText format ["<t color='#00ff00' size='%1' shadow='2'></t>", _scale];
};