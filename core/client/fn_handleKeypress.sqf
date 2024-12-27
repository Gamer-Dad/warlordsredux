params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"];

private _zeusKey = actionKeys "curatorInterface";
private _viewKey = actionKeys "tacticalView";
private _adminKeyPressed = _key in _viewKey || _key in _zeusKey;
private _isAdmin = (getPlayerUID player) in (getArray (missionConfigFile >> "adminIDs"));
if (_adminKeyPressed && !_isAdmin) exitWith {
    true;
};

if (inputAction "cycleThrownItems" > 0.01) exitWith {
    [vehicle player, 0, false] spawn APS_fnc_report;
    true;
};

if (_key in actionKeys "Gear" && {!(missionNamespace getVariable ["BIS_WL_gearKeyPressed", false]) && alive player}) exitWith {
    if !(isNull (uiNamespace getVariable ["BIS_WL_purchaseMenuDisplay", displayNull])) then {
        "RequestMenu_close" call WL2_fnc_setupUI;
    } else {
        BIS_WL_gearKeyPressed = true;
        0 spawn {
            _t = time + 0.5;
            waitUntil {!BIS_WL_gearKeyPressed || {time >= _t}};
            if (time < _t) then {
                if (isNull findDisplay 602) then {
                    if (vehicle player == player) then {
                        if (cursorTarget distanceSqr player <= 25 && {!(cursorTarget isKindOf "House") && {(!alive cursorTarget || {!(cursorTarget isKindOf "Man")})}}) then {
                            player action ["Gear", cursorTarget];
                        } else {
                            player action ["Gear", objNull];
                        };
                    } else {
                        vehicle player action ["Gear", vehicle player];
                    };
                } else {
                    closeDialog 602;
                };
            } else {
                if (BIS_WL_gearKeyPressed && {!(player getVariable ["BIS_WL_menuLocked", false])}) then {
                    if (BIS_WL_currentSelection in [0, 2]) then {
                        "RequestMenu_open" call WL2_fnc_setupUI;
                    } else {
                        playSound "AddItemFailed";
                        _action = if (BIS_WL_currentSelection == 1) then {
                            localize "STR_A3_WL_popup_voting";
                        } else {
                            if (BIS_WL_currentSelection in [3,8]) then {
                                localize "STR_A3_WL_action_destination_select";
                            } else {
                                if (BIS_WL_currentSelection in [4,5,7]) then {
                                    localize "STR_A3_WL_action_scan_select";
                                } else {
                                    "";
                                };
                            };
                        };
                        [toUpper format [(localize "STR_A3_WL_another_action") + (if (_action == "") then {"."} else {" (%1)."}), _action]] spawn WL2_fnc_smoothText;
                    };
                };
            };
        };
    };
    true;
};

false;
