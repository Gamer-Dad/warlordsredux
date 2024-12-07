class HeavyVehicles {
    class B_APC_Tracked_01_CRV_F {
        cost = 1700;
        requirements[] = {};
        killReward = 300;
        rearm = 400;
        capValue = 2;
        aps = 2;
    }; // "CRV-6e Bobcat"

    class B_APC_Tracked_01_rcws_F {
        cost = 1800;
        requirements[] = {};
        rearm = 400;
        killReward = 300;
        capValue = 3;
        aps = 2;
    }; // "IFV-6c Panther"

    class B_APC_Wheeled_03_cannon_F {
        cost = 2900;
        requirements[] = {};
        rearm = 500;
        killReward = 300;
        capValue = 3;
        aps = 2;

        disallowMagazines[] = {
            "4Rnd_GAA_missiles"
        };

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {
                "2Rnd_GAT_missiles"
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
    }; // "BLUFOR Gorgon"

    class B_APC_Wheeled_03_up_F {
        name = "AFV-4 Gorgon UP";
        description = "AFV-4 Gorgon UP is a variant of the AFV-4 Gorgon armed with a Skyfire launcher.<br/>Armament: 14Rnd 80mm x2, 1000Rnd 20mm x2";
        spawn = "B_APC_Wheeled_03_cannon_F";
        cost = 3000;
        requirements[] = {};
        rearm = 500;
        killReward = 300;
        capValue = 3;
        aps = 2;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {
                "2Rnd_GAT_missiles",
                "60Rnd_30mm_APFSDS_shells_Tracer_Yellow",
                "140Rnd_30mm_MP_shells_Tracer_Yellow"
            };
            removeWeapons[] = {
                "missiles_titan",
                "autocannon_30mm_CTWS"
            };
            addMagazines[] = {
                "1000Rnd_20mm_shells",
                "1000Rnd_20mm_shells",
                "14Rnd_80mm_rockets",
                "14Rnd_80mm_rockets"
            };
            addWeapons[] = {
                "gatling_20mm_VTOL_01",
                "rockets_Skyfire"
            };
        };
    };

    class B_APC_Wheeled_01_cannon_F {
        cost = 3200;
        requirements[] = {};
        rearm = 500;
        killReward = 300;
        capValue = 3;
        aps = 2;
    }; // "AMV-7 Marshall"

    class B_APC_Wheeled_01_cannon_up_F {
        name = "AMV-7 Marshall UP";
        description = "AMV-7 Marshall UP is a variant of the AMV-7 Marshall armed with a 105mm cannon.<br/>Armament: 20Rnd 105mm HEAT x2";
        spawn = "B_APC_Wheeled_01_cannon_F";
        cost = 3500;
        requirements[] = {};
        rearm = 500;
        killReward = 300;
        capValue = 3;
        aps = 2;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {
                "60Rnd_40mm_GPR_Tracer_Red_shells",
                "40Rnd_40mm_APFSDS_Tracer_Red_shells"
            };
            removeWeapons[] = {
                "autocannon_40mm_CTWS"
            };
            addMagazines[] = {
                "20Rnd_105mm_HEAT_MP_T_Red",
                "20Rnd_105mm_HEAT_MP_T_Red"
            };
            addWeapons[] = {
                "cannon_105mm_VTOL_01"
            };
        };
    };

    class B_AFV_Wheeled_01_cannon_F {
        cost = 4500;
        requirements[] = {};
        rearm = 500;
        killReward = 450;
        capValue = 4;
        aps = 2;
    }; // "Rhino MGS"

    class B_APC_Tracked_01_AA_F {
        cost = 5000;
        requirements[] = {};
        rearm = 500;
        killReward = 350;
        capValue = 4;
        aps = 2;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {
                "4Rnd_Titan_long_missiles"
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
    }; // "IFV-6a Cheetah"

    class B_AFV_Wheeled_01_up_cannon_F {
        cost = 5000;
        requirements[] = {};
        rearm = 500;
        killReward = 500;
        capValue = 4;
        aps = 2;
    }; // "Rhino MGS UP"

    class B_MBT_01_cannon_F {
        cost = 5800;
        requirements[] = {};
        rearm = 600;
        killReward = 450;
        capValue = 4;
        aps = 3;

        disallowMagazines[] = {
            "4Rnd_120mm_LG_cannon_missiles"
        };
    }; // "M2A1 Slammer"

    class B_MBT_01_TUSK_F {
        cost = 6500;
        requirements[] = {};
        rearm = 600;
        killReward = 500;
        capValue = 4;
        aps = 3;

        disallowMagazines[] = {
            "4Rnd_120mm_LG_cannon_missiles"
        };
    }; // "M2A1 Slammer UP"

    class B_APC_Tracked_01_AA_UP_F {
        name = "IFV-6X Puma";
        description = "IFV-6X Puma is a variant of the IFV-6a Cheetah armed with Defender missiles.<br/>Armament: 680Rnd 35mm x2, 4Rnd Defender";
        spawn = "B_APC_Tracked_01_AA_F";
        cost = 8000;
        requirements[] = {};
        rearm = 450;
        killReward = 600;
        capValue = 4;
        aps = 2;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {
                "4Rnd_Titan_long_missiles"
            };
            removeWeapons[] = {
                "missiles_titan_AA"
            };
            addMagazines[] = {
                "magazine_Missile_mim145_x4",
                "680Rnd_35mm_AA_shells_Tracer_Red"
            };
            addWeapons[] = {
                "weapon_mim145Launcher"
            };
        };
    };

    // class B_MBT_01_TUSK_Railgun_F {
    //     name = "M2X Slammer (Railgun)";
    //     description = "M2X Slammer (Railgun) is a variant of the M2A1 Slammer armed with a railgun.<br/>Armament: 60Rnd 75mm APFSDS x2";
    //     spawn = "B_MBT_01_TUSK_F";
    //     cost = 13000;
    //     requirements[] = {};
    //     rearm = 600;
    //     killReward = 550;
    //     capValue = 4;
    //     aps = 3;

    //     class Gunner: WLTurretDefaults {
    //         turret[] = { 0 };
    //         removeMagazines[] = {
    //             "24Rnd_120mm_APFSDS_shells_Tracer_Red",
    //             "12Rnd_120mm_HE_shells_Tracer_Red",
    //             "12Rnd_120mm_HEAT_MP_T_Red"
    //         };
    //         removeWeapons[] = {
    //             "cannon_120mm"
    //         };
    //         addMagazines[] = {
    //             "RailGun_01_DummyMagazine",
    //             "60Rnd_75mm_RailGun_APFSDS_mag"
    //         };
    //         addWeapons[] = {
    //             "cannon_railgun",
    //             "cannon_railgun_fake"
    //         };
    //     };
    // };

    class B_MBT_01_arty_F {
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
    }; // "M4 Scorcher"

    class B_MBT_01_mlrs_F {
        cost = 20000;
        requirements[] = {};
        rearm = 1800;
        killReward = 600;
        capValue = 4;
        aps = 1;
        disallowMagazines[] = {
            "12Rnd_230mm_rockets_cluster"
        };
    }; // "M5 Sandstorm MLRS"
};