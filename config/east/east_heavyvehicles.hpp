class HeavyVehicles {
    class O_APC_Wheeled_02_rcws_v2_F {
        cost = 1500;
        requirements[] = {};
        rearm = 400;
        killReward = 300;
        capValue = 2;
        aps = 2;
    }; // "MSE-3 Marid"

    class O_APC_Wheeled_02_rcws_v2_m_F {
        name = "MSE-3M Marid Autocannon";
        description = "MSE-3M Marid is a variant of the MSE-3 Marid armed with a 30mm autocannon.<br/>Armament: 250Rnd 30mm HE x2, 250Rnd 30mm APDS x2";
        spawn = "O_APC_Wheeled_02_rcws_v2_F";
        cost = 2600;
        requirements[] = {};
        rearm = 500;
        killReward = 300;
        capValue = 3;
        aps = 2;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {
                "96Rnd_40mm_G_belt"
            };
            removeWeapons[] = {
                "GMG_40mm"
            };
            addMagazines[] = {
                "250Rnd_30mm_HE_shells_Tracer_Red",
                "250Rnd_30mm_HE_shells_Tracer_Red",
                "250Rnd_30mm_APDS_shells_Tracer_Red",
                "250Rnd_30mm_APDS_shells_Tracer_Red"
            };
            addWeapons[] = {
                "gatling_30mm"
            };
        };
    };

    class O_APC_Tracked_02_cannon_F {
        cost = 3200;
        requirements[] = {};
        rearm = 500;
        killReward = 350;
        capValue = 3;
        aps = 2;

        disallowMagazines[] = {
            "4Rnd_GAA_missiles"
        };

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {
                "2Rnd_GAT_missiles_O"
            };
            removeWeapons[] = {
                "missiles_titan"
            };
            addMagazines[] = {
                "5Rnd_GAT_missiles",
                "5Rnd_GAT_missiles"
            };
            addWeapons[] = {
                "missiles_titan"
            };
        };
    }; // "BTR-K Kamysh"

    class O_APC_Tracked_02_AA_F {
        cost = 5000;
        requirements[] = {};
        rearm = 500;
        killReward = 350;
        capValue = 4;
        aps = 2;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {
                "4Rnd_Titan_long_missiles_O"
            };
            removeWeapons[] = {
                "missiles_titan_AA"
            };
            addMagazines[] = {
                "4Rnd_GAA_missiles",
                "4Rnd_GAA_missiles"
            };
            addWeapons[] = {
                "missiles_titan_AA"
            };
        };
    }; // "ZSU-39 Tigris"

    class O_MBT_02_cannon_F {
        cost = 7500;
        requirements[] = {};
        rearm = 600;
        killReward = 500;
        capValue = 4;
        aps = 3;
    }; // "T-100 Varsuk"

    class O_APC_Tracked_02_AA_M_F {
        name = "ZSU-49 Euphrates";
        description = "ZSU-49 Euphrates is a variant of the ZSU-39 Tigris armed with Rhea missiles.<br/>Armament: 680Rnd 35mm AA x2, 4Rnd Rhea";
        spawn = "O_APC_Tracked_02_AA_F";
        cost = 8000;
        requirements[] = {};
        rearm = 450;
        killReward = 600;
        capValue = 4;
        aps = 2;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {
                "4Rnd_Titan_long_missiles_O"
            };
            removeWeapons[] = {
                "missiles_titan_AA"
            };
            addMagazines[] = {
                "magazine_Missile_s750_x4",
                "680Rnd_35mm_AA_shells_Tracer_Green"
            };
            addWeapons[] = {
                "weapon_s750Launcher"
            };
        };
    };

    class O_MBT_04_cannon_F {
        cost = 11000;
        requirements[] = {};
        rearm = 600;
        killReward = 550;
        capValue = 4;
        aps = 3;
    }; // "T-140 Angara"

    class O_MBT_04_command_F {
        cost = 13000;
        requirements[] = {};
        rearm = 600;
        killReward = 600;
        capValue = 4;
        aps = 3;
    }; // "T-140K Angara"

    // class O_MBT_02_railgun_F {
    //     cost = 15000;
    //     requirements[] = {};
    //     rearm = 600;
    //     killReward = 500;
    //     capValue = 4;
    //     aps = 3;
    // }; // "T-100 Futura"

    class O_MBT_04_nato_F {
        name = "T-140N Yukon";
        description = "T-140N Yukon is a variant of the T-140 Angara armed with a NATO 120mm cannon.<br/>Armament: 4Rnd 120mm ATGM LG x8";
        spawn = "O_MBT_04_command_F";
        cost = 18000;
        requirements[] = {};
        rearm = 600;
        killReward = 800;
        capValue = 4;
        aps = 3;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {
                "20Rnd_125mm_APFSDS_T_Green",
                "12Rnd_125mm_HEAT_T_Green",
                "12Rnd_125mm_HE_T_Green"
            };
            removeWeapons[] = {
                "cannon_125mm_advanced"
            };
            addMagazines[] = {
                "4Rnd_120mm_LG_cannon_missiles",
                "4Rnd_120mm_LG_cannon_missiles",
                "4Rnd_120mm_LG_cannon_missiles",
                "4Rnd_120mm_LG_cannon_missiles",
                "4Rnd_120mm_LG_cannon_missiles",
                "4Rnd_120mm_LG_cannon_missiles",
                "4Rnd_120mm_LG_cannon_missiles",
                "4Rnd_120mm_LG_cannon_missiles"
            };
            addWeapons[] = {
                "cannon_120mm"
            };
        };
    };

    class I_Truck_02_MRL_F {
        cost = 18000;
        requirements[] = {};
        rearm = 1800;
        killReward = 600;
        capValue = 4;
        aps = 1;
        disallowMagazines[] = {
            "12Rnd_230mm_rockets_cluster"
        };
    }; // "Zamak MRL"

    class O_MBT_02_arty_F {
        cost = 20000;
        requirements[] = {};
        rearm = 1800;
        killReward = 600;
        capValue = 4;
        aps = 1;
        disallowMagazines[] = {
            "2Rnd_155mm_Mo_Cluster",
            "2Rnd_155mm_Mo_Cluster_O"
        };
    }; // "2S9 Sochor"
};