params ["_asset", "_lockActionId"];

private _isUAV = unitIsUAV _asset;
private _accessControl = _asset getVariable ["WL2_accessControl", 0];

private _color = switch (_accessControl) do {
    case 0;
    case 1: {
        "#4bff58";
    };
    case 2;
    case 3: {
        "#00ffff";
    };
    case 4;
    case 5: {
        "#ff4b4b";
    };
};

private _lockLabel = switch (_accessControl) do {
    case 0: {
        "Access: All";
    };
    case 1: {
        "Access: All (Passenger Only)";
    };
    case 2: {
        "Access: Squad";
    };
    case 3: {
        "Access: Squad (Passenger Only)";
    };
    case 4: {
        "Access: Personal";
    };
    case 5: {
        "Access: Locked";
    };
};

private _lockIcon = "a3\modules_f\data\iconunlock_ca.paa";

_asset setUserActionText [_lockActionId, format ["<t color = '%1'>%2</t>", _color, _lockLabel], format ["<img size='2' image='%1'/>", _lockIcon]];

_asset call WL2_fnc_uavConnectRefresh;