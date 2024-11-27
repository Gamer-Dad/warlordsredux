class Defences {
    class Land_Razorwire_F {
        cost = 50;
        requirements[] = {};
        offset[] = {0, 5, 0};
        killReward = 30;
        structure = 1;
    };  // "Razor Wire Fence"

    class Land_BagFence_Round_F {
        cost = 50;
        requirements[] = {};
        offset[] = {0, 2, 0};
        killReward = 30;
        demolishable = 1;
    };  // "Semi Circle Sand bags"

    class Land_DragonsTeeth_01_4x2_new_F {
        cost = 50;
        requirements[] = {};
        offset[] = {0, 5, 0};
        killReward = 30;
        demolishable = 1;
        structure = 1;
    };  // "Tank barrier"

    class CamoNet_OPFOR_big_F {
        cost = 100;
        requirements[] = {};
        offset[] = {0, 6, 0};
        killReward = 30;
        garbageCollect = 1;
        structure = 1;
    };  // "Camouflage Vehicle Cover (Hex)"

    class O_UGV_02_Demining_F {
        cost = 100;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 200;
        killReward = 100;
    };  // "UGAS demining"

    class O_HMG_01_F {
        cost = 150;
        requirements[] = {};
        rearm = 300;
        killReward = 100;
        loadable = 1;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {};
            removeWeapons[] = {
                "HMG_static"
            };
            addMagazines[] = {
                "100Rnd_127x99_mag_Tracer_Green",
                "100Rnd_127x99_mag_Tracer_Green",
                "100Rnd_127x99_mag_Tracer_Green",
                "100Rnd_127x99_mag_Tracer_Green"
            };
            addWeapons[] = {
                "HMG_static"
            };
        };
    };  // "Mk30 HMG .50"

    class O_UGV_01_F {
        cost = 150;
        requirements[] = {};
        offset[] = {0, 3, 0};
        killReward = 50;
    };  // "UGV Stomper"

    class Land_IRMaskingCover_01_F {
        cost = 200;
        requirements[] = {};
        offset[] = {0, 8, 0};
        killReward = 30;
        garbageCollect = 1;
        structure = 1;
    };  // "IR Masking Tent (Large)"

    class O_HMG_01_high_F {
        cost = 200;
        requirements[] = {};
        rearm = 300;
        killReward = 100;
        loadable = 1;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {};
            removeWeapons[] = {
                "HMG_static"
            };
            addMagazines[] = {
                "100Rnd_127x99_mag_Tracer_Green",
                "100Rnd_127x99_mag_Tracer_Green",
                "100Rnd_127x99_mag_Tracer_Green",
                "100Rnd_127x99_mag_Tracer_Green"
            };
            addWeapons[] = {
                "HMG_static"
            };
        };
    };  // "Mk30 HMG .50 (Raised)"

    class O_GMG_01_F {
        cost = 200;
        requirements[] = {};
        rearm = 300;
        killReward = 100;
        loadable = 1;
    };  // "Mk32 GMG 20 mm"

    class O_GMG_01_high_F {
        cost = 250;
        requirements[] = {};
        rearm = 300;
        killReward = 100;
        loadable = 1;
    };  // "Mk32 GMG 20 mm (Raised)"

    class O_static_AA_F {
        cost = 300;
        requirements[] = {};
        rearm = 300;
        killReward = 100;
        loadable = 1;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {};
            removeWeapons[] = {
                "missiles_titan_static"
            };
            addMagazines[] = {
                "1Rnd_GAA_missiles",
                "1Rnd_GAA_missiles",
                "1Rnd_GAA_missiles",
                "1Rnd_GAA_missiles",
                "1Rnd_GAA_missiles",
                "1Rnd_GAA_missiles"
            };
            addWeapons[] = {
                "missiles_titan_static"
            };
        };
    };  // "Static Titan Launcher (AA) [CSAT]"

    class O_static_AT_F {
        cost = 300;
        requirements[] = {};
        rearm = 300;
        killReward = 100;
        loadable = 1;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {};
            removeWeapons[] = {
                "missiles_titan_static"
            };
            addMagazines[] = {
                "1Rnd_GAT_missiles",
                "1Rnd_GAT_missiles",
                "1Rnd_GAT_missiles",
                "1Rnd_GAT_missiles",
                "1Rnd_GAT_missiles",
                "1Rnd_GAT_missiles"
            };
            addWeapons[] = {
                "missiles_titan_static"
            };
        };
    };  // "Static Titan Launcher (AT) [CSAT]"

    class O_HMG_01_A_F {
        name = "Mk30 HMG Auto Turret";
        cost = 500;
        requirements[] = {};
        rearm = 300;
        killReward = 150;
        loadable = 1;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {};
            removeWeapons[] = {
                "HMG_static"
            };
            addMagazines[] = {
                "100Rnd_127x99_mag_Tracer_Green",
                "100Rnd_127x99_mag_Tracer_Green",
                "100Rnd_127x99_mag_Tracer_Green",
                "100Rnd_127x99_mag_Tracer_Green"
            };
            addWeapons[] = {
                "HMG_static"
            };
        };
    };

    class O_UAV_01_F {
        cost = 500;
        requirements[] = {};
        killReward = 100;
    };  // "AR-2"

    class O_UGV_01_rcws_F {
        cost = 500;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 300;
        killReward = 100;
    };  // "UGAV rcws"

    class O_static_AA_UP_F {
        name = "Static AA Launcher (UP)";
        description = "Static AA Launcher (UP) is a variant of the Static AA Launcher armed with SAAMI missiles.<br/>Armament: 4Rnd SAAMI x3";
        spawn = "O_static_AA_F";
        cost = 600;
        requirements[] = {};
        rearm = 300;
        killReward = 200;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {
                "1Rnd_GAA_missiles"
            };
            removeWeapons[] = {
                "missiles_titan_static"
            };
            addMagazines[] = {
                "4Rnd_70mm_SAAMI_missiles",
                "4Rnd_70mm_SAAMI_missiles",
                "4Rnd_70mm_SAAMI_missiles"
            };
            addWeapons[] = {
                "missiles_SAAMI"
            };
        };
    };

    class O_GMG_01_A_F {
        name = "Mk32 GMG Auto Turret";
        cost = 650;
        requirements[] = {};
        rearm = 300;
        killReward = 150;
        loadable = 1;
    };

    class O_UAV_06_F {
        cost = 1000;
        requirements[] = {};
        killReward = 200;
    };  // "AR-6"

    class O_Radar_System_02_F {
        cost = 1000;
        requirements[] = {};
        offset[] = {0, 7, 0};
        killReward = 350;
        loadable = 1;
    };  // "R-750 Cronus Radar"

    class O_UAV_01_UP_F {
        name = "AR-2 Darter UP";
        description = "AR-2 Darter UP is a variant of the AR-2 Darter armed with a 45ACP SMG.<br/>Armament: 30Rnd 45ACP x20";
        spawn = "O_UAV_01_F";
        cost = 1200;
        requirements[] = {};
        killReward = 200;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {};
            removeWeapons[] = {};
            addMagazines[] = {
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",
                "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow"
            };
            addWeapons[] = {
                "SMG_01_F"
            };
        };
    };

    class O_UGV_01_rcws_up_F {
        name = "UGV Stomper UP";
        description = "UGV Stomper UP is a variant of the UGV Stomper armed with a 30mm autocannon.<br/>Armament: 140Rnd 30mm MP, 60Rnd 30mm APFSDS";
        spawn = "O_UGV_01_rcws_F";
        cost = 1500;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 300;
        killReward = 300;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {
                "96Rnd_40mm_G_belt"
            };
            removeWeapons[] = {
                "GMG_40mm"
            };
            addMagazines[] = {
                "140Rnd_30mm_MP_shells_Tracer_Red",
                "60Rnd_30mm_APFSDS_shells_Tracer_Red"
            };
            addWeapons[] = {
                "autocannon_30mm_CTWS"
            };
        };
    };

    class Land_Communication_F {
        name = "Jamming Tower";
        description = "Jamming Tower can be used to jam enemy autonomous assets. It must be placed outside the home base in an owned sector.";
        cost = 2500;
        requirements[] = {};
        offset[] = {0, 6, 0};
        killReward = 400;
        garbageCollect = 1;
        demolishable = 1;
        structure = 1;
    };

    class B_AAA_System_01_F {
        cost = 3500;
        requirements[] = {};
        offset[] = {0, 5.3, 0};
        rearm = 300;
        killReward = 400;
        loadable = 1;
    };  // "Praetorian 1C"

    class O_Mortar_01_F {
        cost = 4000;
        requirements[] = {};
        rearm = 900;
        killReward = 125;
        loadable = 1;
    };  // "Mortar"

    class O_SAM_System_04_F {
        cost = 8000;
        requirements[] = {};
        offset[] = {0, 6, 0};
        rearm = 450;
        killReward = 500;
        loadable = 1;
    };  // "S-750 Rhea"

    class B_SAM_System_01_F {
        cost = 10000;
        requirements[] = {};
        offset[] = {0, 5.3, 0};
        rearm = 600;
        killReward = 500;
        loadable = 1;
    };  // "Mk49 Spartan"

    class B_SAM_System_02_F {
        cost = 15000;
        requirements[] = {};
        offset[] = {0, 5.3, 0};
        rearm = 600;
        killReward = 600;
        loadable = 1;
    };  // "Mk21 Centurion"

    // class B_Ship_MRLS_01_F {
    //     cost = 30000;
    //     requirements[] = {};
    //     offset[] = {0, 7, 0};
    //     rearm = 2700;
    //     killReward = 700;
    // };  // "Mk41 VLS"
};