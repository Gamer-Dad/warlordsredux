class FixedWing {
    class B_Plane_Caesar_hmggmg_01_F {
        name = "Caesar BTT (HMG/GMG)";
        description = "Caesar BTT (HMG/GMG) is a variant of the Caesar BTT armed with a HMG and GMG.<br/>Armament: 500Rnd 12.7mm x2, 96Rnd 40mm x2, 240Rnd Countermeasures";
        spawn = "C_Plane_Civil_01_F";
        cost = 1500;
        rearm = 300;

        requirements[] = {"A"};
        killReward = 300;
        class Pilot: WLTurretDefaults {
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

    class B_Plane_Caesar_rocket_01_F {
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

    class B_Plane_Caesar_bomb_01_F {
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

    class B_T_VTOL_01_infantry_F {
        cost = 2000;
        requirements[] = {"A"};
        killReward = 300;
    }; // "V-44 X Blackfish (Inf)"

    class B_T_VTOL_01_vehicle_F {
        cost = 2000;
        requirements[] = {"A"};
        killReward = 300;
    }; // "V-44 X Blackfish (Vic)"

    class B_T_VTOL_01_armed_F {
        cost = 8000;
        requirements[] = {"A"};
        rearm = 500;
        killReward = 350;
    }; // "V-44 X Blackfish (Armed)"

    class B_Plane_CAS_01_dynamicLoadout_F {
        cost = 15000;
        requirements[] = {"A"};
        rearm = 900;
        killReward = 800;
    }; // "A-164 Wipeout (CAS)"

    class I_Plane_Fighter_04_F {
        cost = 23000;
        requirements[] = {"A"};
        rearm = 900;
        killReward = 600;
    }; // "A-149 Gryphon"

    class B_Plane_Fighter_01_F {
        cost = 30000;
        requirements[] = {"A"};
        rearm = 900;
        killReward = 1000;

        allowPylonMagazines[] = {
            "PylonMissile_Missile_HARM_x1"
        };
    }; // "F/A-181 Black Wasp II"

    class B_Plane_Fighter_01_Stealth_F {
        cost = 35000;
        requirements[] = {"A"};
        rearm = 900;
        killReward = 1000;

        allowPylonMagazines[] = {
            "PylonMissile_Missile_HARM_x1"
        };
    }; // "F/A-181 Black Wasp II (Stealth)"
};