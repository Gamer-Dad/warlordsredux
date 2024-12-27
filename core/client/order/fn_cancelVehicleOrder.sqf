params ["_originalPosition"];

private _enemiesNearPlayer = (allPlayers inAreaArray [player, 100, 100]) select {_x != player && BIS_WL_playerSide != side group _x && alive _x};
private _homeBase = BIS_WL_playerSide call WL2_fnc_getSideBase;
private _isInHomeBase = player inArea (_homeBase getVariable "objectAreaComplete");
private _nearbyEnemies = count _enemiesNearPlayer > 0 && !_isInHomeBase;
private _isInOwnedSector = (BIS_WL_sectorsArray # 0) findIf {player inArea (_x getVariable "objectAreaComplete")} == -1;

vehicle player != player ||
!alive player ||
lifeState player == "INCAPACITATED" ||
_nearbyEnemies ||
(getPosATL player) select 2 > 1 ||
_isInOwnedSector ||
(_originalPosition distance2D player) > 100;
