params ["_customization", ["_forceOn", false]];

private _asset = uiNamespace getVariable "WLM_asset";
private _assetConfig = configFile >> "CfgVehicles" >> typeOf _asset;

private _finalizeCustomization = {
    params ["_asset"];
    sleep 0.5;
    0 spawn WLM_fnc_constructVehicleMagazine;
};

if (["setHornTo", _customization] call BIS_fnc_inString) then {
    private _hornName = _customization regexReplace ["setHornTo", ""];
    [_asset, _hornName] remoteExec ["WLM_fnc_changeHorn", _asset];
} else {
    switch (_customization) do {
        case "setSmokeToGunner": {
            [_asset, [0]] remoteExec ["WLM_fnc_moveSmokes", _asset];
            _asset spawn _finalizeCustomization;
        };
        case "setSmokeToCommander": {
            [_asset, [0, 0]] remoteExec ["WLM_fnc_moveSmokes", _asset];
            _asset spawn _finalizeCustomization;
        };
        case "setSmokeToDriver": {
            [_asset, [-1]] remoteExec ["WLM_fnc_moveSmokes", _asset];
            _asset spawn _finalizeCustomization;
        };
        default {
            private _currentValue = if (_forceOn) then {
                0;
            } else {
                _asset animationPhase _customization;
            };

            if (_currentValue == 1) then {
                private _forceAnimations = getArray (_assetConfig >> "animationSources" >> _customization >> "forceAnimate2");
                for "_i" from 0 to ((count _forceAnimations - 1) / 2) do {
                    private _forceAnimationName = _forceAnimations # (_i * 2);
                    private _forceAnimationValue = _forceAnimations # (_i * 2 + 1);
                    _asset animateSource [_forceAnimationName, _forceAnimationValue];
                };
                _asset animateSource [_customization, 0];
            } else {
                private _forceAnimations = getArray (_assetConfig >> "animationSources" >> _customization >> "forceAnimate");
                for "_i" from 0 to ((count _forceAnimations - 1) / 2) do {
                    private _forceAnimationName = _forceAnimations # (_i * 2);
                    private _forceAnimationValue = _forceAnimations # (_i * 2 + 1);
                    _asset animateSource [_forceAnimationName, _forceAnimationValue];
                };
                _asset animateSource [_customization, 1];
            };
        };
    };
};