#include "..\..\warlords_constants.inc"
params ["_asset"];

private _repairActionID = -1;
while {alive _asset} do {
    _nearbyVehicles = (_asset nearEntities ["All", WL_MAINTENANCE_RADIUS]) select {alive _x};
    _repairCooldown = ((_asset getVariable "BIS_WL_nextRepair") - serverTime) max 0;

    if (_nearbyVehicles findIf {getNumber (configFile >> "CfgVehicles" >> typeOf _x >> "transportRepair") > 0} != -1) then {
        if (_repairActionID == -1) then {
            _repairActionID = _asset addAction [
                "",
                {
                    params ["_asset"];
                    if ((_asset getVariable "BIS_WL_nextRepair") <= serverTime) then {
                        [player, "repair", (_asset getVariable "BIS_WL_nextRepair"), 0, _asset] remoteExec ["WL2_fnc_handleClientRequest", 2];
                        playSound3D ["A3\Sounds_F\sfx\UI\vehicles\Vehicle_Repair.wss", _asset, FALSE, getPosASL _asset, 2, 1, 75];
                        [toUpper localize "STR_A3_WL_popup_asset_repaired"] spawn WL2_fnc_smoothText;
                        _asset setVariable ["BIS_WL_nextRepair", serverTime + WL_MAINTENANCE_COOLDOWN_REPAIR];
                    } else {
                        playSound "AddItemFailed";
                    };
                },
                [],
                5,
                TRUE,
                FALSE,
                "",
                "alive _target && {getPlayerUID _this == (_target getVariable ['BIS_WL_ownerAsset', '123']) && {vehicle _this == _this}}",
                WL_MAINTENANCE_RADIUS,
                FALSE
            ];
        };
        _asset setUserActionText [_repairActionID, if (_repairCooldown == 0) then {format ["<t color = '#4bff58'>%1</t>", localize "STR_repair"]} else {format ["<t color = '#7e7e7e'><t align = 'left'>%1</t><t align = 'right'>%2     </t></t>", localize "STR_repair", [_repairCooldown, "MM:SS"] call BIS_fnc_secondsToString]}, format ["<img size='2' color = '%1' image='\A3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa'/>", if (_repairCooldown == 0) then {"#ffffff"} else {"#7e7e7e"}]];
    } else {
        if (_repairActionID != -1) then {
            _asset removeAction _repairActionID;
            _repairActionID = -1;
        };
    };
    sleep WL_TIMEOUT_STANDARD;
};

_asset removeAction _repairActionID;