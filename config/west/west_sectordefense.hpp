class SectorDefense {
    class Land_Razorwire_F {
        cost = 50;
        requirements[] = {};
        offset[] = {0, 5, 0};
        killReward = 30;
        structure = 1;
    }; // "Razor Wire Fence"

    class Land_BagFence_Round_F {
        cost = 50;
        requirements[] = {};
        offset[] = {0, 2, 0};
        killReward = 30;
        demolishable = 1;
        structure = 1;
    }; // "Semi Circle Sand bags"

    class Land_DragonsTeeth_01_4x2_new_F {
        cost = 50;
        requirements[] = {};
        offset[] = {0, 5, 0};
        killReward = 30;
        demolishable = 1;
        structure = 1;
    }; // "Tank barrier"

    class CamoNet_BLUFOR_big_F {
        cost = 100;
        requirements[] = {};
        offset[] = {0, 6, 0};
        killReward = 30;
        garbageCollect = 1;
        structure = 1;
    }; // "Camouflage Vehicle Cover (Green)"

    class B_HMG_01_F {
        cost = 150;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 300;
        killReward = 100;
        loadable[] = {0, -2.5, 0.4};

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {};
            removeWeapons[] = {
                "HMG_static"
            };
            addMagazines[] = {
                "100Rnd_127x99_mag_Tracer_Red",
                "100Rnd_127x99_mag_Tracer_Red",
                "100Rnd_127x99_mag_Tracer_Red",
                "100Rnd_127x99_mag_Tracer_Red"
            };
            addWeapons[] = {
                "HMG_static"
            };
        };
    }; // "Mk30 HMG .50"

    class Land_IRMaskingCover_01_F {
        cost = 200;
        requirements[] = {};
        offset[] = {0, 8, 0};
        killReward = 30;
        garbageCollect = 1;
        structure = 1;
    }; // "IR Masking Tent (Large)"

    class B_HMG_01_high_F {
        cost = 200;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 300;
        killReward = 100;
        loadable[] = {0, -2.5, 0.8};

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {};
            removeWeapons[] = {
                "HMG_static"
            };
            addMagazines[] = {
                "100Rnd_127x99_mag_Tracer_Red",
                "100Rnd_127x99_mag_Tracer_Red",
                "100Rnd_127x99_mag_Tracer_Red",
                "100Rnd_127x99_mag_Tracer_Red"
            };
            addWeapons[] = {
                "HMG_static"
            };
        };
    }; // "Mk30 HMG .50 (Raised)"

    class B_GMG_01_F {
        cost = 200;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 300;
        killReward = 100;
        loadable[] = {0, -2.5, 0.4};
    }; // "Mk32 GMG 20mm"

    class B_GMG_01_high_F {
        cost = 250;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 300;
        killReward = 100;
        loadable[] = {0, -2.5, 0.8};
    }; // "Mk32 GMG 20mm (Raised)"

    // class B_Minigun_01_high_F {
    //     name = "Mk30X Minigun (Raised)";
    //     cost = 250;
    //     spawn = "B_G_HMG_02_high_F";
    //     variant = 1;
    //     requirements[] = {};
    //     rearm = 300;
    //     killReward = 100;
    //     loadable[] = {0, -2.5, 0};

    //     class Gunner: WLTurretDefaults {
    //         turret[] = { 0 };
    //         removeMagazines[] = {
    //             "100Rnd_127x99_mag_Tracer_Yellow",
    //         };
    //         removeWeapons[] = {
    //             "HMG_M2_Mounted"
    //         };
    //         addMagazines[] = {
    //             "2000Rnd_65x39_Belt_Tracer_Yellow",
    //             "2000Rnd_65x39_Belt_Tracer_Yellow",
    //             "2000Rnd_65x39_Belt_Tracer_Yellow",
    //             "2000Rnd_65x39_Belt_Tracer_Yellow"
    //         };
    //         addWeapons[] = {
    //             "LMG_Minigun_Transport"
    //         };
    //     };
    // };

    class B_static_AA_F {
        cost = 300;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 300;
        killReward = 100;
        loadable[] = {0, -2.5, 0.2};

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
    }; // "Static Titan Launcher (AA) [NATO]"

    class B_static_AT_F {
        cost = 300;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 300;
        killReward = 100;
        loadable[] = {0, -2.5, 0.2};

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
    }; // "Static Titan Launcher (AT) [NATO]"

    class B_HMG_01_A_F {
        name = "Mk30 HMG Auto Turret";
        cost = 500;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 300;
        killReward = 150;
        loadable[] = {0, -2.5, 0.4};

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {};
            removeWeapons[] = {
                "HMG_static"
            };
            addMagazines[] = {
                "100Rnd_127x99_mag_Tracer_Red",
                "100Rnd_127x99_mag_Tracer_Red",
                "100Rnd_127x99_mag_Tracer_Red",
                "100Rnd_127x99_mag_Tracer_Red"
            };
            addWeapons[] = {
                "HMG_static"
            };
        };
    };

    class B_static_AA_UP_F {
        name = "Static AA Launcher (UP)";
        description = "Static AA Launcher (UP) is an upgraded variant of the Static AA Launcher.";
        spawn = "B_static_AA_F";
        variant = 1;
        cost = 600;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 300;
        killReward = 200;
        loadable[] = {0, -2.5, 0.2};

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

    class B_static_AT_UP_F {
        name = "Static AT Launcher (UP)";
        description = "Static AT Launcher (UP) is an upgraded variant of the Static AT Launcher.";
        spawn = "B_static_AT_F";
        variant = 1;
        cost = 600;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 300;
        killReward = 200;
        loadable[] = {0, -2.5, 0.2};

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {
                "1Rnd_GAT_missiles"
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
    };

    class B_GMG_01_A_F {
        name = "Mk32 GMG Auto Turret";
        cost = 650;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 300;
        killReward = 150;
        loadable[] = {0, -2.5, 0.4};
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
        // This is not loadable. It will break initialization code to load this.
    };

    class B_Mortar_01_F {
        cost = 4000;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 900;
        killReward = 125;
        loadable[] = {0, -2.5, 0};
    }; // "Mortar"

    class B_Ship_Gun_01_F {
        cost = 10000;
        requirements[] = {};
        offset[] = {0, 9, 0};
        rearm = 2700;
        killReward = 600;

        disallowMagazines[] = {
            "magazine_ShipCannon_120mm_HE_cluster_shells_x2",
            "magazine_ShipCannon_120mm_mine_shells_x6",
            "magazine_ShipCannon_120mm_AT_mine_shells_x6"
        };
    }; // "MK45 Hammer"


    // class B_Ship_MRLS_01_F {
    //     cost = 30000;
    //     requirements[] = {};
    //     offset[] = {0, 7, 0};
    //     rearm = 2700;
    //     killReward = 700;
    // }; // "Mk41 VLS"
};