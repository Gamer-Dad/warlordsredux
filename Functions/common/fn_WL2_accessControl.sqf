params ["_asset", "_unit", "_role"];

private _accessControl = _asset getVariable ["WL2_accessControl", 0];

private _ownerUID = _asset getVariable ["BIS_WL_ownerUavAsset", _asset getVariable ["BIS_WL_ownerAsset", "123"]];
private _owner = _ownerUID call BIS_fnc_getUnitByUid;
private _ownerID = getPlayerID _owner;
private _callerID = getPlayerID (leader _unit);
private _isOwner = _ownerUID == getPlayerUID (leader _unit);

private _access = false;
private _message = "";
switch (_accessControl) do {
    case 0: {
        // All
        _access = true;
        _message = "Access: All";
    };
    case 1: {
        // All (Passenger Only)
        _access = _isOwner || (_role == "cargo");
        _message = "Access: All (Passenger Only)";
    };
    case 2: {
        // Squad
        private _areInSquad = ["areInSquad", [_callerID, _ownerID]] call SQD_fnc_client;
        _access = _isOwner || _areInSquad;
        _message = "Access: Squad";
    };
    case 3: {
        // Squad (Passenger Only)
        private _areInSquad = ["areInSquad", [_callerID, _ownerID]] call SQD_fnc_client;
        _access = _isOwner || (_areInSquad && _role == "cargo");
        _message = "Access: Squad (Passenger Only)";
    };
    case 4: {
        // Personal
        _access = _isOwner;
        _message = "Access: Personal";
    };
    case 5: {
        // Locked
        _access = false;
        _message = "Access: Locked";
    };
    default {
        _access = false;
        _message = "Access: Locked";
    };
};

[_access, _message];