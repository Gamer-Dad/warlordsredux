params ["_asset", "_unit", "_role"];

private _accessControl = _asset getVariable ["WL2_accessControl", 0];

private _ownerUID = _asset getVariable ["BIS_WL_ownerUavAsset", _asset getVariable ["BIS_WL_ownerAsset", "123"]];
private _owner = _ownerUID call BIS_fnc_getUnitByUid;
private _ownerID = getPlayerID _owner;
private _callerID = getPlayerID (leader _unit);
private _isOwner = _ownerUID == getPlayerUID (leader _unit);

private _access = false;
switch (_accessControl) do {
    case 0: {
        // All
        _access = true;
    };
    case 1: {
        // All (Passenger Only)
        _access = _isOwner || (_role == "cargo");
    };
    case 2: {
        // Squad
        private _areInSquad = ["areInSquad", [_callerID, _ownerID]] call SQD_fnc_client;
        _access = _isOwner || _areInSquad;
    };
    case 3: {
        // Squad (Passenger Only)
        private _areInSquad = ["areInSquad", [_callerID, _ownerID]] call SQD_fnc_client;
        _access = _isOwner || (_areInSquad && _role == "cargo");
    };
    case 4: {
        // Personal
        _access = _isOwner;
    };
    case 5: {
        // Locked
        _access = false;
    };
    default {
        _access = false;
    };
};
_access;