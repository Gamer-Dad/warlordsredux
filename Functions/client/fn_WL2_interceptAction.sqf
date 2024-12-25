inGameUISetEventHandler ["Action", '
    params ["_target", "_caller", "_index", "_name", "_text", "_priority", "_showWindow", "_hideOnUse", "_shortcut", "_visibility", "_eventName"];
    switch (_name) do {
        case "MoveToPilot": {
            private _access = [_target, _caller, "driver"] call BIS_fnc_WL2_accessControl;
            if !(_access # 0) then {
                systemChat format ["Pilot seat locked. (%1)", _access # 1];
                playSoundUI ["AddItemFailed"];
                true;
            } else {
                false;
            };
        };
        case "MoveToDriver": {
            private _access = [_target, _caller, "driver"] call BIS_fnc_WL2_accessControl;
            if !(_access # 0) then {
                systemChat format ["Driver seat locked. (%1)", _access # 1];
                playSoundUI ["AddItemFailed"];
                true;
            } else {
                false;
            };
        };
        case "MoveToTurret": {
            private _access = [_target, _caller, "gunner"] call BIS_fnc_WL2_accessControl;
            if !(_access # 0) then {
                systemChat format ["Turret seat locked. (%1)", _access # 1];
                playSoundUI ["AddItemFailed"];
                true;
            } else {
                false;
            };
        };
        case "MoveToCargo": {
            private _access = [_target, _caller, "cargo"] call BIS_fnc_WL2_accessControl;
            if !(_access # 0) then {
                systemChat format ["Passenger seat locked. (%1)", _access # 1];
                playSoundUI ["AddItemFailed"];
                true;
            } else {
                false;
            };
        };
        case "GetInPilot": {
            private _access = [_target, _caller, "driver"] call BIS_fnc_WL2_accessControl;
            if !(_access # 0) then {
                systemChat format ["Pilot seat locked. (%1)", _access # 1];
                playSoundUI ["AddItemFailed"];
                true;
            } else {
                false;
            };
        };
        case "GetInDriver": {
            private _access = [_target, _caller, "driver"] call BIS_fnc_WL2_accessControl;
            if !(_access # 0) then {
                systemChat format ["Driver seat locked. (%1)", _access # 1];
                playSoundUI ["AddItemFailed"];
                true;
            } else {
                false;
            };
        };
        case "GetInTurret": {
            private _access = [_target, _caller, "gunner"] call BIS_fnc_WL2_accessControl;
            if !(_access # 0) then {
                systemChat format ["Turret seat locked. (%1)", _access # 1];
                playSoundUI ["AddItemFailed"];
                true;
            } else {
                false;
            };
        };
        case "GetInCargo": {
            private _access = [_target, _caller, "cargo"] call BIS_fnc_WL2_accessControl;
            if !(_access # 0) then {
                systemChat format ["Passenger seat locked. (%1)", _access # 1];
                playSoundUI ["AddItemFailed"];
                true;
            } else {
                false;
            };
        };
        default {
            false;
        };
    };
'];