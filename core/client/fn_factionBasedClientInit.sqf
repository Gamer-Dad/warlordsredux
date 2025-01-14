_magazineTypes = [
	"1Rnd_SmokeRed_Grenade_shell",
	"1Rnd_SmokeGreen_Grenade_shell",
	"1Rnd_SmokeBlue_Grenade_shell",
	"1Rnd_SmokeOrange_Grenade_shell",
	"1Rnd_SmokeYellow_Grenade_shell",
	"SmokeShellOrange",
	"SmokeShellYellow"
];

if (side player == west) then {
	player linkItem "B_UavTerminal";
	{player removeMagazine _x} forEach _magazineTypes;
	{player removeMagazine "1Rnd_Smoke_Grenade_shell"} forEach magazines player;
	{player removeMagazine "Chemlight_green"} forEach magazines player;
	{player removeMagazine "SmokeShellGreen"} forEach magazines player;

};
if (side player == east) then {
	player linkItem "O_UavTerminal";
	{player removeMagazine _x} forEach _magazineTypes;
	{player removeMagazine "1Rnd_Smoke_Grenade_shell"} forEach magazines player;
	{player removeMagazine "Chemlight_red"} forEach magazines player;
	{player removeMagazine "SmokeShellGreen"} forEach magazines player;
};
if (side player == independent) then {
	player linkItem "I_UavTerminal";
	{player removeMagazine _x} forEach _magazineTypes;
	{player removeMagazine "1Rnd_Smoke_Grenade_shell"} forEach magazines player;
	{player removeMagazine "Chemlight_yellow"} forEach magazines player;
	{player removeMagazine "SmokeShellGreen"} forEach magazines player;
};
player linkItem "Integrated_NVG_TI_0_F";
player addPrimaryWeaponItem "muzzle_snds_H";
player addPrimaryWeaponItem "muzzle_snds_M";
player addMagazines ["SmokeShellGreen", 1];

0 spawn WLC_fnc_onRespawn;