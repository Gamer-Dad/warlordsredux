#include "constants.inc"

params ["_uid", "_score"];

if (!WLC_ENABLED) exitWith {};
if !(isServer) exitWith {};

private _previousScore = WLC_Scores getOrDefault [_uid, 0];
private _previousLevel = floor (_previousScore / 1000);
private _newLevel = floor (_score / 1000);
if (_newLevel > _previousLevel) then {
    private _player = (allPlayers select {getPlayerUID _x == _uid}) # 0;
    [_newLevel] remoteExec ["WLC_fnc_levelUp", _player];
};

WLC_Scores set [_uid, _score];
publicVariable "WLC_Scores";