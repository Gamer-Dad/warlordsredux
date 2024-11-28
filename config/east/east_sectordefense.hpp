class SectorDefense {
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

    class O_HMG_01_F {
        cost = 150;
        requirements[] = {};
        offset[] = {0, 3, 0};
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
        offset[] = {0, 3, 0};
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
        offset[] = {0, 3, 0};
        rearm = 300;
        killReward = 100;
        loadable = 1;
    };  // "Mk32 GMG 20 mm"

    class O_GMG_01_high_F {
        cost = 250;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 300;
        killReward = 100;
        loadable = 1;
    };  // "Mk32 GMG 20 mm (Raised)"

    class O_static_AA_F {
        cost = 300;
        requirements[] = {};
        offset[] = {0, 3, 0};
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
        offset[] = {0, 3, 0};
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

    class O_static_AA_UP_F {
        name = "Static AA Launcher (UP)";
        description = "Static AA Launcher (UP) is a variant of the Static AA Launcher armed with SAAMI missiles.<br/>Armament: 4Rnd SAAMI x3";
        spawn = "O_static_AA_F";
        cost = 600;
        requirements[] = {};
        offset[] = {0, 3, 0};
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

    class O_Mortar_01_F {
        cost = 4000;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 900;
        killReward = 125;
        loadable = 1;
    };  // "Mortar"
};