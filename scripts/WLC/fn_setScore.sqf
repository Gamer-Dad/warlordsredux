params ["_uid", "_score"];

if !(isServer) exitWith {};

private _previousScore = WLC_Scores getOrDefault [_uid, 0];
private _previousLevel = floor (_previousScore / 1000);
private _newLevel = floor (_score / 1000);
if (_newLevel > _previousLevel) then {
    private _player = (allPlayers select {getPlayerUID _x == _uid}) # 0;
    [format ["%1 has reached level %2!", name _player, _newLevel]] remoteExec ["systemChat", _player];
};

WLC_Scores set [_uid, _score];
publicVariable "WLC_Scores";

diag_log format ["Score set for %1: %2", _uid, _score];