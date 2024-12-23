class AirDefense {
    class B_Radar_System_01_F {
        description = "Long range radar system, capable of detecting and tracking vehicles within line of sight at up to 16km.";
        cost = 1000;
        requirements[] = {};
        offset[] = {0, 7, 0};
        killReward = 350;
        loadable[] = {0, 0, 1};
    }; // "AN/MPQ-105 Radar"

    class B_AAA_System_01_F {
        description = "Short range air defense artillery with a high rate of fire. Effective range: 3km.";
        cost = 3500;
        requirements[] = {};
        offset[] = {0, 5.3, 0};
        rearm = 300;
        killReward = 400;
        loadable[] = {0, -1, 1.7};
    }; // "Praetorian 1C"

    class B_SAM_System_03_F {
        description = "Long range surface-to-air missile system, capable of engaging aircraft and helicopters. Effective range: >10km.";
        cost = 8000;
        requirements[] = {};
        offset[] = {0, 6, 0};
        rearm = 450;
        killReward = 500;
        loadable[] = {0, 0, 1};
    }; // "MIM-145 Defender"

    class B_SAM_System_01_F {
        description = "Short range surface-to-air missile system, capable of engaging aircraft and helicopters. Effective range: 4km.";
        cost = 10000;
        requirements[] = {};
        offset[] = {0, 5.3, 0};
        rearm = 600;
        killReward = 500;
        loadable[] = {0, -2, 0.8};
    }; // "Mk49 Spartan"

    class B_SAM_System_02_F {
        description = "Medium range surface-to-air missile system, capable of engaging aircraft and helicopters. Effective range: ~10km.";
        cost = 15000;
        requirements[] = {};
        offset[] = {0, 5.3, 0};
        rearm = 600;
        killReward = 600;
        loadable[] = {0, -2, 1};
    }; // "Mk21 Centurion"

    // class B_SAM_System_03_UP_F {
    //     name = "MIM-145 Defender (UP)";
    //     description = "Long range surface-to-air missile system, capable of engaging aircraft and helicopters, upgraded for more ammo. Effective range: >10km.";
    //     spawn = "B_SAM_System_03_F";
    //     variant = 1;

    //     cost = 12000;
    //     requirements[] = {};
    //     offset[] = {0, 6, 0};
    //     rearm = 450;
    //     killReward = 700;
    //     loadable[] = {0, 0, 1};

    //     class Gunner: WLTurretDefaults {
    //         turret[] = { 0 };
    //         removeMagazines[] = {};
    //         removeWeapons[] = {};
    //         addMagazines[] = {
    //             "magazine_Missile_mim145_x4"
    //         };
    //         addWeapons[] = {};
    //     };
    // };

    // class B_SAM_System_02_UP_F {
    //     name = "Mk21 Centurion (UP)";
    //     description = "Medium range surface-to-air missile system, capable of engaging aircraft and helicopters, upgraded for more ammo. Effective range: ~10km.";
    //     spawn = "B_SAM_System_02_F";
    //     variant = 1;

    //     cost = 20000;
    //     requirements[] = {};
    //     offset[] = {0, 5.3, 0};
    //     rearm = 600;
    //     killReward = 800;
    //     loadable[] = {0, -2, 1};

    //     class Gunner: WLTurretDefaults {
    //         turret[] = { 0 };
    //         removeMagazines[] = {};
    //         removeWeapons[] = {};
    //         addMagazines[] = {
    //             "magazine_Missile_rim162_x8"
    //         };
    //         addWeapons[] = {};
    //     };
    // };
};