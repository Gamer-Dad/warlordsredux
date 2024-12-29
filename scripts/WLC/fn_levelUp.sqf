params ["_newLevel"];

systemChat format ["You have reached level %1!", _newLevel];

private _sound = playSoundUI ["a3\music_f_tank\leadtrack06_f_tank.ogg", 1, 1, false, 0.5];
sleep 12.5;
stopSound _sound;