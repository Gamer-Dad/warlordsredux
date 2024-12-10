class AirDefense {
    class O_Radar_System_02_F {
        description = "Long range radar system, capable of detecting and tracking vehicles within line of sight at up to 16km.";
        cost = 1000;
        requirements[] = {};
        offset[] = {0, 7, 0};
        killReward = 350;
        loadable[] = {0, 0, 1};
    };  // "R-750 Cronus Radar"

    class O_AAA_System_01_F {
        name = "Praetorian 1C";
        description = "Short range air defense artillery with a high rate of fire. Effective range: 3km.";
        spawn = "B_AAA_System_01_F";
        cost = 3500;
        requirements[] = {};
        textures[] = {
            "a3\static_f_jets\aaa_system_01\data\aaa_system_01_olive_co.paa",
            "a3\static_f_jets\aaa_system_01\data\aaa_system_02_olive_co.paa"
        };
        offset[] = {0, 5.3, 0};
        rearm = 300;
        killReward = 400;
        loadable[] = {0, -1, 1.7};
    };

    class O_SAM_System_04_F {
        description = "Long range surface-to-air missile system, capable of engaging aircraft and helicopters. Effective range: >10km.";
        cost = 8000;
        requirements[] = {};
        offset[] = {0, 6, 0};
        rearm = 450;
        killReward = 500;
        loadable[] = {0, 0, 1};
    };  // "S-750 Rhea"

    class O_SAM_System_01_F {
        name = "Mk49 Spartan";
        description = "Short range surface-to-air missile system, capable of engaging aircraft and helicopters. Effective range: 4km.";
        spawn = "B_SAM_System_01_F";
        cost = 10000;
        requirements[] = {};
        textures[] = {
            "A3\Static_F_Jets\SAM_System_01\Data\SAM_system_01_olive_co.paa"
        };
        offset[] = {0, 5.3, 0};
        rearm = 600;
        killReward = 500;
        loadable[] = {0, -2, 0.8};
    };

    class O_SAM_System_02_F {
        name = "Mk21 Centurion";
        description = "Medium range surface-to-air missile system, capable of engaging aircraft and helicopters. Effective range: ~10km.";
        spawn = "B_SAM_System_02_F";
        cost = 15000;
        requirements[] = {};
        textures[] = {
            "A3\Static_F_Jets\SAM_System_02\Data\SAM_system_02_olive_co.paa"
        };
        offset[] = {0, 5.3, 0};
        rearm = 600;
        killReward = 600;
        loadable[] = {0, -2, 1};
    };
};