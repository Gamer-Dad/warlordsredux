params ["_sector"];

private _area = _sector getVariable "objectArea";
private _size = (_area # 0) * (_area # 1) * (if (_area # 3) then { 4 } else { pi });
private _seizingTime = (30 max (_size / 2500)) min 90;

private _lastTime = serverTime;
while { !BIS_WL_missionEnd } do {
	private _originalOwner = _sector getVariable ["BIS_WL_owner", independent];

	private _capturingTeam = _sector getVariable ["BIS_WL_capturingTeam", independent];
	private _captureProgress = _sector getVariable ["BIS_WL_captureProgress", 0];

	private _actualTimeElapsed = serverTime - _lastTime;
	_lastTime = serverTime;
	private _progressMovement = _actualTimeElapsed / _seizingTime;

	private _info = _sector call WL2_fnc_getCapValues;
	private _sortedInfo = [_info, [], { _x # 1 }, "DESCEND"] call BIS_fnc_sortBy;

	private _topEntry = _sortedInfo # 0;
	private _winner = _topEntry # 0;
	private _winningScore = _topEntry # 1;

	if (_winningScore == 0) then {
		_winner = _originalOwner;
	};

	if (_winner == _capturingTeam) then {
		if (_capturingTeam != _originalOwner) then {
			_captureProgress = _captureProgress + _progressMovement;
		};
	} else {
		if (_captureProgress > 0) then {
			_captureProgress = _captureProgress - _progressMovement;
		} else {
			if (_winner != independent) then {
				_captureProgress = 0;
				_capturingTeam = _winner;
			};
		};
	};

	if (_captureProgress >= 1) then {
		_sector setVariable ["BIS_WL_owner", _capturingTeam, true];
		_sector setVariable ["BIS_WL_capturingTeam", independent, true];
		_sector setVariable ["BIS_WL_captureProgress", 0, true];
		_sector remoteExec ["WL2_fnc_handleEnemyCapture", [0, -2] select isDedicated];
		[_sector, _capturingTeam] call WL2_fnc_changeSectorOwnership;
	} else {
		_sector setVariable ["BIS_WL_captureProgress", _captureProgress, true];
		_sector setVariable ["BIS_WL_capturingTeam", _capturingTeam, true];
	};

	if ((_winner == _originalOwner) && (_captureProgress <= 0) || ((_originalOwner != independent) && _winner == independent)) then {
		sleep 2;
	} else {
		sleep 0.2;
	};
	// systemChat format ["Sector %1 | Owner: %2, Capturing Team: %3, Progress: %4", _sector getVariable ["BIS_WL_name", "Unknown"], _sector getVariable ["BIS_WL_owner", "Unknown"], _sector getVariable ["BIS_WL_capturingTeam", "Unknown"], _sector getVariable ["BIS_WL_captureProgress", 0]];
};