params ["_largeText", "_smallText"];

closeDialog 1;

player setVariable ["BIS_WL_incomeBlocked", true, [clientOwner, 2]];
missionNamespace setVariable ["voteLocked", true];
player setVariable ["voteLocked", true, true];
showCinemaBorder true;

private _camera = "BalanceCamera" camCreate position player;
_camera camSetPos [0, 0, 10];
_camera camSetTarget [-1000, -1000, 10];
_camera camCommit 0;
_camera cameraEffect ["Internal", "Back"];

waitUntil {!isNull (findDisplay 46)};

private _display = findDisplay 46;

private _BLOCK_DISPLAY_ID = 995000;
private _BLOCK_DISPLAY_BG_ID = 995001;

private _displayBackground = _display ctrlCreate ["RscStructuredText", _BLOCK_DISPLAY_BG_ID];

_displayBackground ctrlSetPosition [safeZoneX, safeZoneY, safeZoneW, safeZoneH];
_displayBackground ctrlSetBackgroundColor [0, 0, 0, 0.75];
_displayBackground ctrlCommit 0;

private _displayCtrl = _display ctrlCreate ["RscStructuredText", _BLOCK_DISPLAY_ID];
_displayCtrl ctrlSetPosition [safeZoneX + 0.1, safeZoneY + (safeZoneH * 0.5), (safeZoneW * 0.8), safeZoneH];
_displayCtrl ctrlCommit 0;
_displayCtrl ctrlSetStructuredText parseText format [
	"<t shadow = '0'><t size = '%1' color = '#ff4b4b'>%2</t><br/><t size = '%3'>%4</t></t>",
	(2.5 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale),
	_largeText,
	(1.3 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale),
	_smallText
];