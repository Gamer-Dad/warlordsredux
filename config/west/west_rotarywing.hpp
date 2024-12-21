class RotaryWing {
    class B_Heli_Light_01_F {
        cost = 300;
        requirements[] = {"H"};
        killReward = 100;
    }; // "MH-9 Hummingbird"

    class B_Heli_Transport_01_F {
        cost = 800;
        requirements[] = {"H"};
        offset[] = {0, 11, 0};
        killReward = 100;
        rearm = 300;
    }; // "UH-80 Ghost Hawk"

    class B_Heli_Transport_03_F {
        cost = 1000;
        requirements[] = {"H"};
        offset[] = {0, 10, 0};
        killReward = 100;
        rearm = 300;
    }; // "CH-67 Huron"

    class B_Heli_Transport_01_UP_F {
        name = "UH-80 Ghost Hawk UP";
        description = "UH-80 Ghost Hawk UP is a variant of the UH-80 Ghost Hawk armed with 20mm autocannons.";
        spawn = "B_Heli_Transport_01_F";
        cost = 2000;
        requirements[] = {"H"};
        offset[] = {0, 11, 0};
        killReward = 200;
        rearm = 300;

        class LeftGunner: WLTurretDefaults {
            turret[] = { 1 };
            removeMagazines[] = {
                "2000Rnd_65x39_Belt_Tracer_Red"
            };
            removeWeapons[] = {
                "LMG_Minigun_Transport"
            };
            addMagazines[] = {
                "250Rnd_30mm_HE_shells_Tracer_Green",
                "250Rnd_30mm_HE_shells_Tracer_Green",
                "250Rnd_30mm_APDS_shells_Tracer_Green",
                "250Rnd_30mm_APDS_shells_Tracer_Green"
            };
            addWeapons[] = {
                "gatling_30mm"
            };
        };

        class RightGunner: WLTurretDefaults {
            turret[] = { 2 };
            removeMagazines[] = {
                "2000Rnd_65x39_Belt_Tracer_Red"
            };
            removeWeapons[] = {
                "LMG_Minigun_Transport2"
            };
            addMagazines[] = {
                "250Rnd_30mm_HE_shells_Tracer_Green",
                "250Rnd_30mm_HE_shells_Tracer_Green",
                "250Rnd_30mm_APDS_shells_Tracer_Green",
                "250Rnd_30mm_APDS_shells_Tracer_Green"
            };
            addWeapons[] = {
                "gatling_30mm"
            };
        };
    };

    class B_Heli_Light_01_dynamicLoadout_F {
        cost = 2500;
        requirements[] = {"H"};
        rearm = 300;
        killReward = 200;
    }; // "AH-9 Pawnee"

    class B_Heli_light_03_dynamicLoadout_F {
        cost = 6000;
        name = "WY-55 Hellcat";
        spawn = "I_Heli_light_03_dynamicLoadout_F";
        requirements[] = {"H"};
        textures[] = {
            "\A3\Air_F_Enoch\Heli_Light_03\data\Heli_Light_03_base_EAF_CO.paa",
            "\a3\Supplies_F_Enoch\Ammoboxes\Data\AmmoBox_EAF_CO.paa",
            "\a3\Supplies_F_Enoch\Ammoboxes\Data\AmmoBox_signs_EAF_CA.paa"
        };
        offset[] = {0, 9, 0};
        rearm = 300;
        killReward = 300;
    };

    class B_Heli_Attack_01_dynamicLoadout_F {
        cost = 13000;
        requirements[] = {"H"};
        offset[] = {0, 10, 0};
        rearm = 700;
        killReward = 550;

        allowPylonMagazines[] = {
            "PylonMissile_Missile_HARM_x1"
        };
    }; // "AH-99 Blackfoot"
};