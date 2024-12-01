// APS projectile block lists (heavy contains everything medium, medium contains everything light)
// value = [APS Type (0-2, 3), APS ammo consumption]

// APS Type in config file:
// 0 = Light APS
// 1 = Medium APS
// 2 = Heavy APS
// 3 = Dazzler

// Hashmap
// Key: Projectile classname
// Value: [APS Type (0-2, 3 if not applicable), APS ammo consumption, Dazzleable]

private _projectileSettings = [
    // Laser-guided bombs
    ["ammo_Bomb_SDB", [3, 1, true]],            // GBU SDB
    ["Bo_GBU12_LGB", [3, 1, true]],             // GBU-12 LGB
    ["Bo_GBU12_LGB_MI10", [3, 1, true]],        // GBU-12 LGB
    ["Bomb_04_F", [3, 1, true]],                // GBU-12 LGB
    ["Bomb_03_F", [3, 1, true]],                // KAB-250 LGB

    // Tank ATGM
    ["M_120mm_cannon_ATGM", [2, 1, true]],      // 120mm Cannon ATGM
    ["M_120mm_cannon_ATGM_LG", [2, 1, true]],   // 120mm Cannon ATGM (Laser Guided)
    ["M_125mm_cannon_ATGM", [2, 1, true]],      // 125mm Cannon ATGM

    // Ground Vehicle AT
    ["M_127mm_Firefist_AT", [2, 2, true]],      // Nyx Firefist AT - Max loadout: 6
    ["M_Titan_AT_long", [2, 1, true]],          // Titan AT (Vehicle)
    ["M_SPG9_HE", [2, 1, false]],               // SPG-9 HE
    ["M_SPG9_HEAT", [2, 1, false]],             // SPG-9 HEAT

    // Air Vehicle SEAD
    ["ammo_Missile_HARM", [2, 3, true]],        // AGM-88 HARM - Max loadout: 2
    ["ammo_Missile_KH58", [2, 2, true]],        // KH-58 ARM - Max loadout: 3

    // Air Vehicle Guided
    ["M_Jian_AT", [2, 2, true]],                // Jian - Max loadout: 4
    ["M_PG_AT", [2, 1, true]],                  // DAGR
    ["M_Scalpel_AT", [2, 1, true]],             // Scalpel
    ["M_Scalpel_AT_hidden", [2, 1, true]],      // Scalpel (x2)
    ["Missile_AGM_01_F", [2, 3, true]],         // Sharur && KH25 - Max loadout: 8
    ["Missile_AGM_02_F", [2, 2, true]],         // Macer I && II (same mag) - Max loadout: 20

    // Air Vehicle Unguided
    ["M_AT", [2, 1, false]],                    // DAR
    ["R_80mm_HE", [2, 1, false]],               // Skyfire
    ["Rocket_03_AP_F", [2, 1, false]],          // Tratnyr AP
    ["Rocket_03_HE_F", [2, 1, false]],          // Tratnyr HE
    ["Rocket_04_AP_F", [2, 1, false]],          // Shrieker AP
    ["Rocket_04_HE_F", [2, 1, false]],          // Shrieker HE

    // Infantry
    ["M_NLAW_AT_F", [2, 1, true]],              // PCML
    ["M_Titan_AP", [2, 1, true]],               // Titan AP
    ["M_Titan_AT", [2, 1, true]],               // Titan AT
    ["M_Titan_AT_static", [2, 1, true]],        // Titan AT (Static)
    ["M_Vorona_HE", [2, 1, true]],              // Vorona HE
    ["M_Vorona_HEAT", [2, 1, true]],            // Vorona HEAT

    // Unguided Infantry
    ["R_MRAAWS_HE_F", [0, 1, false]],           // MAAWS HE
    ["R_MRAAWS_HEAT_F", [0, 1, false]],         // MAAWS HEAT
    ["R_MRAAWS_HEAT55_F", [0, 1, false]],       // MAAWS HEAT55
    ["R_PG32V_F", [0, 1, false]],               // RPG-42 AT
    ["R_PG7_F", [0, 1, false]],                 // RPG-7 HEAT
    ["R_TBG32V_F", [0, 1, false]]               // RPG-42 HE
];

APS_ProjectileMap = createHashMapFromArray _projectileSettings;