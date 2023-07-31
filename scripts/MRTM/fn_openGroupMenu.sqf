/*
    Author: MrThomasM

    Description: Opens the group menu.
*/

if (isNull (findDisplay 4000)) then {
    createDialog "MRTM_groupsMenu";

    // ((findDisplay 4000) displayCtrl 4005) ctrlAddEventHandler ["LBSelChanged", {
    //     params ["_control", "_lbCurSel", "_lbSelection"];
    //     ["Group"] spawn MRTM_fnc_onLBSelChanged;
    // }];

    // ((findDisplay 4000) displayCtrl 4006) ctrlAddEventHandler ["LBSelChanged", {
    //     params ["_control", "_lbCurSel", "_lbSelection"];
    //     ["Players"] spawn MRTM_fnc_onLBSelChanged;
    // }];

    0 spawn {
        while {GROUP_ACTIVE} do {
            ["Group"] spawn MRTM_fnc_onLBSelChanged;
            ["Players"] spawn MRTM_fnc_onLBSelChanged;
            sleep 0.1;
        };
    };
};
disableSerialization;

lbClear 4005;
lbClear 4006;

{
    private _index = lbAdd [4005, ([_x] call MRTM_fnc_getLBText)];
    lbSetData [4005, _index, (getPlayerUID _x)];
    lbSetPicture [4005, _index, ([_x] call MRTM_fnc_getLBPicture)];
} forEach (units player);

{
    private _index = lbAdd [4006, ([_x] call MRTM_fnc_getLBText)];
    lbSetData [4006, _index, (getPlayerUID _x)];
    lbSetPicture [4006, _index, ([_x] call MRTM_fnc_getLBPicture)];
} forEach (allPlayers select {_x != player && {!(_x in (units player)) && {(side (group _x)) == (side (group player))}}});
