params ["_killRewardMap"];

private _scale = 0.75 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale;
private _moneySign = [BIS_WL_playerSide] call BIS_fnc_WL2_getMoneySign;

private _killFeed = "";
{
	private _killRewardText = _x;
	private _repetitions = _y # 0;
	private _killRewardPoints = _y # 1;
	private _killRewardColor = _y # 2;
	private _killText = if (_repetitions > 1) then {
		format ["<t size='%1' align='right' color='%2'><t color='#fff'>(x%3)</t>    %4    %5%6</t>", _scale, _killRewardColor, _repetitions, _killRewardText, _moneySign, _killRewardPoints];
	} else {
		format ["<t size='%1' align='right' color='%2'>%3    %4%5</t>", _scale, _killRewardColor, _killRewardText, _moneySign, _killRewardPoints];
	};
	_killFeed = _killFeed + _killText + "<br />";
} forEach _killRewardMap;

private _scoreControl = uiNamespace getVariable ["WL_scoreControl", controlNull];
if (!isNull _scoreControl) then {
	_scoreControl ctrlSetStructuredText parseText _killFeed;
};