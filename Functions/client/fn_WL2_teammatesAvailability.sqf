private _side = BIS_WL_playerSide;
private _refreshTimerVar = format ["WL2_manpowerRefreshTimers_%1", getPlayerUID player];

while {!BIS_WL_missionEnd} do {
	sleep 1;

	private _manpowerRefreshTimers = missionNamespace getVariable [_refreshTimerVar, []];
	_manpowerRefreshTimers = _manpowerRefreshTimers select {
		private _asset = _x # 1;
		_x # 0 > serverTime || alive _asset
	};
	missionNamespace setVariable ["WL2_manpowerRefreshTimers", _manpowerRefreshTimers, true];

	private _maxSubordinates = missionNamespace getVariable [format ["BIS_WL_maxSubordinates_%1", _side], 1];
	BIS_WL_matesAvailable = _maxSubordinates - (count _manpowerRefreshTimers);

	false spawn BIS_fnc_WL2_refreshOSD;
};