params ["_projectile", "_unit"];

private _target = objNull;
private _frag = false;
private _projectileClass = typeOf _projectile;
private _range = getNumber (configfile >> "CfgAmmo" >> _projectileClass >> "indirectHitRange");
private _proxRange = _range * 1.5;

private _lastDistance = 10000;

private _target = missileTarget _projectile;

sleep 0.5;
while { alive _projectile } do {
	sleep 0.01;
	if (isNull _target) then {
		_target = missileTarget _projectile;
		continue;
	};

	private _distanceToTarget = _projectile distance _target;

	if (_distanceToTarget < _proxRange) then {
		_frag = true;

		// Don't detonate prematurely if we're still approaching target
		if (_distanceToTarget > _lastDistance) then {
			_lastDistance = _distanceToTarget;
			break;
		};
		if (_distanceToTarget < _range) then {
			_lastDistance = _distanceToTarget;
			break;
		};
	};

	_lastDistance = _distanceToTarget;
};

if (!_frag) exitWith {};

// Vanilla explosion
private _projectilePosition = getPos _projectile;
// private _targetPosition = getPos _target;

if !(isNull _target) then {
	systemChat format ["SAM detonated %1 meters from target.", round _lastDistance];
};

triggerAmmo _projectile;

// Burst Explosion
private _burst = createVehicle [_projectileClass, _projectilePosition, [], 50, "FLY"];
triggerAmmo _burst;