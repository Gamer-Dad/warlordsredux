params ["_penalty"];

// Ensure no conflict with balancer block screen
private _uid = getPlayerUID player;
private _teamBlockVar = format ["teamBlocked_%1", _uid];
waitUntil { !isNil _teamBlockVar };
if (missionNamespace getVariable _teamBlockVar) exitWith {};

private _balanceBlockVar = format ["balanceBlocked_%1", _uid];
waitUntil { !isNil _balanceBlockVar };
if (missionNamespace getVariable _balanceBlockVar) exitWith {};

private _penaltyCheck = profileNameSpace getVariable ["teamkill_penalty", createHashMap];
if ((count _penaltyCheck) == 0) then {
	private _sessionID = missionNamespace getVariable ["sessionID", -1];
	if (_sessionID > 0) then {
		private _penaltyHash = createHashMapFromArray [
			["sessionID", _sessionID],
			["penaltyEndTime", _penalty]
		];
		profileNameSpace setVariable ["teamkill_penalty", _penaltyHash];
		saveProfileNamespace;
	};
};

if (!(isNil "BIS_WL_penalized") && {BIS_WL_penalized}) exitWith {};

_penalty spawn {
	params ["_penaltyEnd"];

	BIS_WL_penalized = true;
	"RequestMenu_close" call BIS_fnc_WL2_setupUI;
	titleCut ["", "BLACK IN", 1];

	showCinemaBorder true;
	private _camera = "FFCamera" camCreate position player;
	_camera camSetPos [0, 0, 10];
	_camera camSetTarget [-1000, -1000, 10];
	_camera camCommit 0;
	_camera cameraEffect ["Internal", "Back"];

	waitUntil {
		!isNull (findDisplay 46)
	};

	private _display = findDisplay 46;

	// when copying from here in the future, make sure to change these IDs so they don't conflict
	private _GULAG_DISPLAY_ID = 994000;
	private _GULAG_DISPLAY_BG_ID = 994001;

	private _displayBackground = _display ctrlCreate ["RscStructuredText", _GULAG_DISPLAY_BG_ID];
	_displayBackground ctrlSetPosition [safeZoneX, safeZoneY, safeZoneW, safeZoneH];
	_displayBackground ctrlSetBackgroundColor [0, 0, 0, 0.75];
	_displayBackground ctrlCommit 0;

	private _displayCtrl = _display ctrlCreate ["RscStructuredText", _GULAG_DISPLAY_ID];
	_displayCtrl ctrlSetPosition [safeZoneX + 0.1, safeZoneY + (safeZoneH * 0.5), (safeZoneW * 0.8), safeZoneH];
	_displayCtrl ctrlCommit 0;
	_displayCtrl ctrlSetStructuredText parseText format [
		"<t shadow = '0'><t size = '%1' color = '#ff4b4b'>%2</t><br/><t size = '%3'>%4</t></t>",
		(2.5 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale),
		([(_penaltyEnd - serverTime) max 0, "MM:SS"] call BIS_fnc_secondsToString),
		(1.3 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale),
		localize "STR_A3_mission_failed_friendly_fire"
	];

	player setVariable ["BIS_WL_incomeBlocked", true, [clientOwner, 2]];
	while {_penaltyEnd > serverTime} do {
		_displayCtrl ctrlSetStructuredText parseText format [
			"<t shadow = '0'><t size = '%1' color = '#ff4b4b'>%2</t><br/><t size = '%3'>%4</t></t>",
			(2.5 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale),
			[(_penaltyEnd - serverTime) max 0, "MM:SS"] call BIS_fnc_secondsToString,
			(1.5 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale),
			localize "STR_A3_mission_failed_friendly_fire"
		];
		sleep 1;
	};
	player setVariable ["BIS_WL_incomeBlocked", false, [clientOwner, 2]];

	ctrlDelete _displayBackground;
	ctrlDelete _displayCtrl;

	forceRespawn player;
	waitUntil {
		sleep 0.1;
		alive player
	};

	titleCut ["", "BLACK IN", 1];
	_camera cameraEffect ["Terminate", "Back"];
	camDestroy _camera;
	BIS_WL_penalized = false;
	player setVariable ["BIS_WL_friendlyKillTimestamps", [], [2, clientOwner]];
	profileNameSpace setVariable ["teamkill_penalty", nil];
	saveProfileNamespace;
};