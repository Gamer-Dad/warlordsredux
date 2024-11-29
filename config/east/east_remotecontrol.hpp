class RemoteControl {
    class O_UGV_02_Demining_F {
        cost = 100;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 200;
        killReward = 100;
    };  // "UGAS demining"

    class O_UGV_01_F {
        cost = 150;
        requirements[] = {};
        offset[] = {0, 5, 0};
        killReward = 50;
    };  // "UGV Stomper"

    class O_HMG_01_A_F {
        name = "Mk30 HMG Auto Turret";
        cost = 500;
        requirements[] = {};
        offset[] = {0, 3, 0};
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
        offset[] = {0, 5, 0};
        rearm = 300;
        killReward = 100;
    };  // "UGAV rcws"

    class O_GMG_01_A_F {
        name = "Mk32 GMG Auto Turret";
        cost = 650;
        requirements[] = {};
        offset[] = {0, 3, 0};
        rearm = 300;
        killReward = 150;
        loadable = 1;
    };

    class O_UAV_06_F {
        cost = 1000;
        requirements[] = {};
        killReward = 200;
    };  // "AR-6"

    class O_UAV_01_UP_F {
        name = "AR-2 Darter UP";
        description = "AR-2 Darter UP is a variant of the AR-2 Darter armed with a 45ACP SMG.<br/>Armament: 30Rnd 45ACP x20";
        spawn = "O_UAV_01_F";
        cost = 1200;
        requirements[] = {};
        killReward = 200;
        rearm = 300;

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
        offset[] = {0, 5, 0};
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

    class O_T_UAV_04_CAS_F {
        cost = 6000;
        requirements[] = {"A"};
        rearm = 300;
        killReward = 600;
    }; // "KH-3A Fenghuang"

    class O_UAV_02_dynamicLoadout_F {
        cost = 8000;
        requirements[] = {"A"};
        rearm = 300;
        killReward = 600;

        allowPylonMagazines[] = {
            "PylonRack_12Rnd_PG_missiles"
        };
    }; // "K40 Ababil-3"

    // class B_Ship_MRLS_01_F {
    //     cost = 30000;
    //     requirements[] = {};
    //     offset[] = {0, 7, 0};
    //     rearm = 2700;
    //     killReward = 700;
    // };  // "Mk41 VLS"
};