class LightVehicles {
    class O_Quadbike_01_F {
        cost = 20;
        requirements[] = {};
        offset[] = {0, 3, 0};
        killReward = 20;
        capValue = 1;
    }; // "Quad Bike"

    class O_G_Offroad_01_armed_F {
        cost = 150;
        requirements[] = {};
        offset[] = {0, 5, 0};
        rearm = 120;
        killReward = 150;
        capValue = 1;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {};
            removeWeapons[] = {
                "HMG_M2_Mounted"
            };
            addMagazines[] = {
                "100Rnd_127x99_mag_Tracer_Yellow",
                "100Rnd_127x99_mag_Tracer_Yellow",
                "100Rnd_127x99_mag_Tracer_Yellow",
                "100Rnd_127x99_mag_Tracer_Yellow"
            };
            addWeapons[] = {
                "HMG_M2_Mounted"
            };
        };
    }; // "Offroad (HMG)"

    class O_LSV_02_armed_F {
        cost = 200;
        requirements[] = {};
        offset[] = {0, 5, 0};
        rearm = 120;
        killReward = 150;
        capValue = 1;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {};
            removeWeapons[] = {
                "LMG_Minigun_Transport"
            };
            addMagazines[] = {
                "500Rnd_65x39_Belt_Tracer_Green_Splash",
                "500Rnd_65x39_Belt_Tracer_Green_Splash",
                "500Rnd_65x39_Belt_Tracer_Green_Splash"
            };
            addWeapons[] = {
                "LMG_Minigun_Transport"
            };
        };
    }; // "Qilin (Minigun)"

    class O_Truck_03_transport_F {
        cost = 200;
        requirements[] = {};
        killReward = 80;
        capValue = 1;
    }; // "Tempest Transport"

    class O_MRAP_02_F {
        cost = 300;
        requirements[] = {};
        killReward = 70;
        capValue = 1;
    }; // "Ifrit"

    class O_Truck_01_flatbed_F {
        cost = 500;
        name = "HEMTT Flatbed";
        spawn = "B_Truck_01_flatbed_F";
        requirements[] = {};
        textures[] = {
            "\a3\soft_f_Exp\truck_01\data\truck_01_ext_01_olive_co.paa",
            "\a3\soft_f_Exp\truck_01\data\truck_01_ext_02_olive_co.paa",
            "\a3\Soft_F_Enoch\Truck_01\Data\truck_01_ammo_pacific_co.paa",
            "\a3\Soft_F_Enoch\Truck_01\Data\Truck_01_cargo_pacific_CO.paa"
        };
        killReward = 80;
        capValue = 1;
    }; // "HEMTT Flatbed"

    class O_G_Offroad_01_AT_F {
        cost = 500;
        requirements[] = {};
        offset[] = {0, 5, 0};
        rearm = 180;
        killReward = 180;
        capValue = 1;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {};
            removeWeapons[] = {
                "launcher_SPG9"
            };
            addMagazines[] = {
                "12Rnd_SPG9_HEAT"
            };
            addWeapons[] = {
                "launcher_SPG9"
            };
        };
    }; // "Offroad (AT)"

    class O_LSV_02_AT_F {
        cost = 750;
        requirements[] = {};
        offset[] = {0, 5, 0};
        rearm = 200;
        killReward = 200;
        capValue = 1;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            removeMagazines[] = {};
            removeWeapons[] = {
                "missiles_Vorona"
            };
            addMagazines[] = {
                "Vorona_HEAT",
                "Vorona_HEAT",
                "Vorona_HEAT",
                "Vorona_HEAT"
            };
            addWeapons[] = {
                "missiles_Vorona"
            };
        };
    }; // "Qilin (AT)"

    class O_MRAP_02_hmg_F {
        cost = 900;
        requirements[] = {};
        rearm = 300;
        killReward = 250;
        capValue = 2;
        aps = 1;
    }; // "Ifrit HMG"

    class O_Truck_03_ammo_F {
        cost = 1000;
        requirements[] = {};
        killReward = 80;
        capValue = 1;
    }; // "Tempest Ammo"

    class O_Truck_03_Fuel_F {
        cost = 1000;
        requirements[] = {};
        killReward = 80;
        capValue = 1;
    }; // "Tempest Fuel"

    class O_Truck_03_Repair_F {
        cost = 1000;
        requirements[] = {};
        killReward = 80;
        capValue = 1;
    }; // "Tempest Repair"

    class O_LSV_02_AT_M_F {
        name = "Qilin (AT-M)";
        description = "Qilin (AT-M) is a variant of the Qilin armed with a Firefist AT missile launcher.<br/>Armament: 2Rnd Firefist x5";
        spawn = "O_LSV_02_AT_F";
        cost = 1200;
        requirements[] = {};
        offset[] = {0, 5, 0};
        rearm = 200;
        killReward = 220;
        capValue = 1;

        class Gunner: WLTurretDefaults {
            turret[] = { 0 };
            reloadOverride = 6;
            removeMagazines[] = {
                "Vorona_HEAT"
            };
            removeWeapons[] = {
                "missiles_Vorona"
            };
            addMagazines[] = {
                "2Rnd_127mm_Firefist_missiles",
                "2Rnd_127mm_Firefist_missiles",
                "2Rnd_127mm_Firefist_missiles",
                "2Rnd_127mm_Firefist_missiles",
                "2Rnd_127mm_Firefist_missiles"
            };
            addWeapons[] = {
                "missiles_Firefist"
            };
        };
    };

    class O_MRAP_02_gmg_F {
        cost = 1250;
        requirements[] = {};
        rearm = 300;
        killReward = 250;
        capValue = 2;
        aps = 1;
    }; // "Ifrit GMG"

    class O_MRAP_02_gmg_m_F {
        name = "Ifrit-M Autocannon";
        description = "Ifrit-M is a variant of the Ifrit armed with a 20mm autocannon.<br/>Armament: 60Rnd 20mm HE x6, 60Rnd 20mm AP x3, 200Rnd 127mm x3";
        spawn = "O_MRAP_02_gmg_F";
        cost = 1500;
        requirements[] = {};
        rearm = 300;
        killReward = 300;
        capValue = 2;
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
                "60Rnd_20mm_HE_shells",
                "60Rnd_20mm_HE_shells",
                "60Rnd_20mm_HE_shells",
                "60Rnd_20mm_HE_shells",
                "60Rnd_20mm_HE_shells",
                "60Rnd_20mm_HE_shells",
                "60Rnd_20mm_AP_shells",
                "60Rnd_20mm_AP_shells",
                "60Rnd_20mm_AP_shells",
                "200Rnd_338_Mag",
                "200Rnd_338_Mag"
            };
            addWeapons[] = {
                "cannon_20mm",
                "MMG_02_coax"
            };
        };
    };

    class O_Truck_03_device_F {
        cost = 1500;
        requirements[] = {};
        killReward = 200;
        capValue = 1;
        aps = 4;
    }; // "Tempest Device"
};