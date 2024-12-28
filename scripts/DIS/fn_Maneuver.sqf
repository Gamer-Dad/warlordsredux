#include "SAM.inc"

params ["_projectile"];

[_projectile] spawn {
    params ["_projectile"];
    private _startTime = time;
    private _isLOAL = getNumber (configfile >> "CfgAmmo" >> typeOf _projectile >> "autoSeekTarget") == 1;

    while { alive _projectile } do {
        sleep 7;

        // Ghost missile relocking check.
        if (_isLOAL && !(alive missileTarget _projectile)) exitWith {
            triggerAmmo _projectile;
        };
        if (time > (_startTime + WL_SAM_TIMEOUT)) exitWith {
            triggerAmmo _projectile;
        };
    };
};

[_projectile] spawn {
    params ["_projectile"];
    sleep 1;
    while { alive _projectile } do {
        sleep 0.5;
        private _missileTarget = missileTarget _projectile;
        private _missileTargetSide = _missileTarget getVariable ["BIS_WL_ownerAssetSide", side _missileTarget];
        private _projectileSide = side (group player);
        if (_missileTargetSide == _projectileSide) exitWith {
            triggerAmmo _projectile;
        };
    };
};

private _iteration = 0;
private _maxAcceleration = (getNumber (configfile >> "CfgAmmo" >> typeOf _projectile >> "thrust")) / 10.0 * WL_SAM_ACCELERATION_FACTOR;
private _maxSpeed = getNumber (configfile >> "CfgAmmo" >> typeOf _projectile >> "maxSpeed") * WL_SAM_MAX_SPEED_FACTOR;
sleep 1;
while { alive _projectile } do {
    private _currentVector = velocityModelSpace _projectile;

    private _currentSpeed = _currentVector # 1;

    if (_currentSpeed < _maxSpeed) then {
        _currentSpeed = _currentSpeed + _maxAcceleration;

        private _newVector = [
            _currentVector # 0,
            _currentSpeed,
            _currentVector # 2
        ];
        _projectile setVelocityModelSpace _newVector;
    };

    _iteration = _iteration + 1;
    sleep 0.1;
};
