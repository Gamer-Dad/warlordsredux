private _v = _this;
private _a = [];

_v setVariable ["dapsActive", TRUE, TRUE];
_v setVariable ["dapsLastAmmo", (_v call DAPS_fnc_CountAmmo), TRUE];
_v setVariable ["dapsType", "Light APS", TRUE];
_v setVariable ["dapsAmmo", 2, TRUE];
_v setVariable ["dapsAmmoMax", 2, TRUE];

private _reg = [];
dapsRegistered pushBackUnique _v;

while {alive _v} do {
	if (_v call DAPS_fnc_Active) then {
		_a = nearestObjects [_v, ["R_MRAAWS_HE_F", "R_MRAAWS_HEAT_F", "R_MRAAWS_HEAT55_F", "R_PG32V_F", "R_PG7_F", "M_NLAW_AT_F"], 125];

		if ((count _a) > 0) then {
			if !((_a select 0) in _reg) then {
				_d = _v distance (_a select 0);
				[_v, _a select 0, _d] remoteExec ["DAPS_fnc_Generic", 2];
				_reg pushBackUnique (_a select 0);
			};
		};
	};
	
	{
		if !(alive _x) then {
			_reg = _reg - [_x];
		};
	} forEach _reg;
	sleep 0.01;
};