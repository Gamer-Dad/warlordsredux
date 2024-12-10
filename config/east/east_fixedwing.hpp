class FixedWing {
    class O_Plane_Caesar_hmggmg_01_F {
        name = "Caesar BTT (HMG/GMG)";
        description = "Caesar BTT (HMG/GMG) is a variant of the Caesar BTT armed with a HMG and GMG.<br/>Armament: 500Rnd 12.7mm x2, 96Rnd 40mm x2, 240Rnd Countermeasures";
        spawn = "C_Plane_Civil_01_F";
        cost = 1500;
        rearm = 300;

        requirements[] = {"A"};
        killReward = 300;
        class Gunner: WLTurretDefaults {
            turret[] = { -1 };
            removeMagazines[] = {};
            removeWeapons[] = {};
            addMagazines[] = {
                "500Rnd_127x99_mag_Tracer_Yellow",
                "500Rnd_127x99_mag_Tracer_Yellow",
                "96Rnd_40mm_G_belt",
                "96Rnd_40mm_G_belt",
                "240Rnd_CMFlare_Chaff_Magazine"
            };
            addWeapons[] = {
                "HMG_127",
                "GMG_40mm",
                "CMFlareLauncher"
            };
        };
    };

    class O_Plane_Caesar_rocket_01_F {
        name = "Caesar BTT (Rocket)";
        description = "Caesar BTT (Rocket) is a variant of the Caesar BTT armed with rockets.<br/>Armament: 14Rnd 80mm x2, 240Rnd Countermeasures";
        spawn = "C_Plane_Civil_01_F";
        cost = 1800;
        rearm = 400;

        requirements[] = {"A"};
        killReward = 300;
        class Pilot: WLTurretDefaults {
            turret[] = { -1 };
            removeMagazines[] = {};
            removeWeapons[] = {};
            addMagazines[] = {
                "14Rnd_80mm_rockets",
                "14Rnd_80mm_rockets",
                "240Rnd_CMFlare_Chaff_Magazine"
            };
            addWeapons[] = {
                "rockets_Skyfire",
                "CMFlareLauncher"
            };
        };
    };

    class O_Plane_Caesar_bomb_01_F {
        name = "Caesar BTT (Bomb)";
        description = "Caesar BTT (Bomb) is a variant of the Caesar BTT armed with a pair of Mk82 bombs.<br/>Armament: 2Rnd Mk82, 240Rnd Countermeasures";
        spawn = "C_Plane_Civil_01_F";
        cost = 2000;
        rearm = 400;

        requirements[] = {"A"};
        killReward = 300;
        class Pilot: WLTurretDefaults {
            turret[] = { -1 };
            removeMagazines[] = {};
            removeWeapons[] = {};
            addMagazines[] = {
                "2Rnd_Mk82",
                "240Rnd_CMFlare_Chaff_Magazine"
            };
            addWeapons[] = {
                "Mk82BombLauncher",
                "CMFlareLauncher"
            };
        };
    };

    class O_T_VTOL_02_infantry_dynamicLoadout_F {
        cost = 14000;
        requirements[] = {"A"};
        rearm = 700;
        killReward = 600;
    }; // "Y-32 Xi'an (Infantry Transport)"

    class I_Plane_Fighter_03_dynamicLoadout_F {
        cost = 15000;
        requirements[] = {"A"};
        textures[] = {
            "\a3\Air_F_Gamma\Plane_Fighter_03\Data\Plane_Fighter_03_body_1_brownhex_CO.paa",
            "\a3\Air_F_Gamma\Plane_Fighter_03\Data\Plane_Fighter_03_body_2_brownhex_CO.paa"
        };
        rearm = 900;
        killReward = 600;
    }; // "A-143 Buzzard"

    class O_Plane_CAS_02_dynamicLoadout_F {
        cost = 20000;
        requirements[] = {"A"};
        rearm = 900;
        killReward = 900;
    }; // "To-199 Neophron (CAS)"

    class O_Plane_Fighter_02_Stealth_F {
        cost = 28000;
        requirements[] = {"A"};
        rearm = 900;
        killReward = 1100;

        allowPylonMagazines[] = {
            "PylonMissile_Missile_KH58_x1"
        };
    }; // "To-201 Shikra (Stealth)"

    class O_Plane_Fighter_02_F {
        cost = 32000;
        requirements[] = {"A"};
        rearm = 900;
        killReward = 1100;

        allowPylonMagazines[] = {
            "PylonMissile_Missile_KH58_x1"
        };
    }; // "To-201 Shikra"
};