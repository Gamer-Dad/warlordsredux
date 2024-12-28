private _side = BIS_WL_playerSide;

private _data = createHashMap;
{
    private _type = _x;

    private _customizationData = player getVariable [format ["WLC_%1", _type], ""];
    private _customizationMap = missionNamespace getVariable [format ["WLC_%1_%2", _type, _side], createHashMap];
    private _customization = _customizationMap getOrDefault [_customizationData, createHashMap];

    _data set [_type, _customization];
} forEach ["Primary", "Secondary", "Launcher", "Uniform", "Vest", "Helmet"];

private _checkForSpace = {
    params ["_toAdd"];
    if !(player canAdd _toAdd) then {
        player addBackpack "B_Carryall_mcamo";
    };
};

// Uniform
private _uniformData = _data getOrDefault ["Uniform", createHashMap];
if (count _uniformData > 0) then {
    removeUniform player;
    private _uniform = _uniformData getOrDefault ["item", ""];
    player addUniform _uniform;
};

// Vest
private _vestData = _data getOrDefault ["Vest", createHashMap];
if (count _vestData > 0) then {
    removeVest player;
    private _vest = _uniformData getOrDefault ["item", ""];
    player addVest _vest;
};

// Helmet
private _helmetData = _data getOrDefault ["Helmet", createHashMap];
if (count _helmetData > 0) then {
    removeHeadgear player;
    private _helmet = _uniformData getOrDefault ["item", ""];
    player addHeadgear _helmet;
};

// Primary
private _primaryData = _data getOrDefault ["Primary", createHashMap];
if (count _primaryData > 0) then {
    private _oldMagazines = compatibleMagazines (primaryWeapon player);
    {
        player removeMagazines _x;
    } forEach _oldMagazines;

    player removeWeapon (primaryWeapon player);

    private _magazines = _primaryData getOrDefault ["magazines", []];
    {
        [_x] call _checkForSpace;
        player addMagazine _x;
    } forEach _magazines;

    private _primary = _primaryData getOrDefault ["item", ""];
    player addWeapon _primary;

    private _attachments = _primaryData getOrDefault ["attachments", []];
    {
        player addPrimaryWeaponItem _x;
    } forEach _attachments;

    player selectWeapon _primary;
};

// Secondary
private _secondaryData = _data getOrDefault ["Secondary", createHashMap];
if (count _secondaryData > 0) then {
    private _oldMagazines = compatibleMagazines (handgunWeapon player);
    {
        player removeMagazines _x;
    } forEach _oldMagazines;

    player removeWeapon (handgunWeapon player);

    private _magazines = _secondaryData getOrDefault ["magazines", []];
    {
        [_x] call _checkForSpace;
        player addMagazine _x;
    } forEach _magazines;

    private _secondary = _secondaryData getOrDefault ["item", ""];
    player addWeapon _secondary;

    private _attachments = _secondaryData getOrDefault ["attachments", []];
    {
        player addHandgunItem _x;
    } forEach _attachments;
};

// Launcher
private _launcherData = _data getOrDefault ["Launcher", createHashMap];
if (count _launcherData > 0) then {
    private _oldMagazines = compatibleMagazines (secondaryWeapon player);
    {
        player removeMagazines _x;
    } forEach _oldMagazines;

    player removeWeapon (secondaryWeapon player);

    private _magazines = _launcherData getOrDefault ["magazines", []];
    {
        [_x] call _checkForSpace;
        player addMagazine _x;
    } forEach _magazines;

    private _launcher = _launcherData getOrDefault ["item", ""];
    player addWeapon _launcher;
};