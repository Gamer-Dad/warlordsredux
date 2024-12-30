#include "constants.inc"

if (!WLC_ENABLED) exitWith {};

private _customizationConfig = missionConfigFile >> "CfgWLCCustomization";

{
    private _side = str _x;
    private _customizationSide = _customizationConfig >> _side;
    {
        private _type = _x;
        private _customization = createHashMap;
        private _customizationByType = configProperties [_customizationSide >> _type];
        {
            private _customizationClass = configName _x;
            private _customizationName = getText (_x >> "name");
            private _customizationItem = getText (_x >> "item");
            private _customizationLevel = getNumber (_x >> "level");
            private _customizationCost = getNumber (_x >> "cost");
            private _customizationMagazines = getArray (_x >> "magazines");
            private _customizationAttachments = getArray (_x >> "attachments");

            if (_customizationName == "") then {
                _customizationName = getText (configFile >> "CfgWeapons" >> _customizationItem >> "displayName");
            };

            private _customizationHashMap = createHashMapFromArray [
                ["name", _customizationName],
                ["item", _customizationItem],
                ["level", _customizationLevel],
                ["cost", _customizationCost],
                ["magazines", _customizationMagazines],
                ["attachments", _customizationAttachments]
            ];

            _customization set [_customizationClass, _customizationHashMap];
        } forEach _customizationByType;
        missionNamespace setVariable [format ["WLC_%1_%2", _type, _side], _customization];
    } forEach ["Primary", "Secondary", "Launcher", "Uniform", "Vest", "Helmet"];
} forEach [west, east];

if (isServer) then {
    private _scores = profileNamespace getVariable ["WLC_Scores", createHashMap];
    if (count _scores == 0) then {
        // status: 0 = unknown, 1 = initializing, 2 = initialized
        missionNamespace setVariable ["WLC_status", 1, true];
        WLC_Scores = createHashMap;
    } else {
        missionNamespace setVariable ["WLC_status", 2, true];
        WLC_Scores = profileNamespace getVariable ["WLC_Scores", createHashMap];
    };
    publicVariable "WLC_Scores";

    0 spawn {
        while { !BIS_WL_missionEnd } do {
            profileNamespace setVariable ["WLC_Scores", WLC_Scores];
            saveProfileNamespace;
            sleep 5;
        };
    };
} else {
    0 spawn {
        waitUntil {
            !isNull player && player == player
        };
        private _status = missionNamespace getVariable ["WLC_status", 0];
        waitUntil {
            sleep 1;
            _status = missionNamespace getVariable ["WLC_status", 0];
            _status != 0;
        };
        if (_status == 1) then {
            private _myScore = profileNamespace getVariable ["WLC_ScoreBackup", 0];
            private _uid = getPlayerUID player;
            [_uid, _myScore] remoteExec ["WLC_fnc_setScore", 2];
        };
    };

    0 spawn {
        while { !BIS_WL_missionEnd } do {
            private _uid = getPlayerUID player;
            private _myScore = WLC_Scores getOrDefault [_uid, 0];
            profileNamespace setVariable ["WLC_ScoreBackup", _myScore];
            sleep 5;
        };
    };
};