params ["_entity"];
if (count MRTM_spawnedAT >= 25) then {
  private _mines = MRTM_spawnedAT;
  if (count MRTM_spawnedAT >= 25) then {
    private _t = _mines find objNull;
    if (_t == -1) then {break};
    _mines deleteAt _t;
  };
  if (count MRTM_spawnedAT >= 25) then {
    deleteVehicle _entity;
  } else {
    MRTM_spawnedAT pushBack _entity;
  };
} else {
  MRTM_spawnedAT pushBack _entity;
};