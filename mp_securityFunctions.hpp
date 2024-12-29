// MP Security
class CfgRemoteExec {
	class Functions {
		mode = 1;
		jip = 1;

		class APS_fnc_report {
			allowedTargets = 0;
		};

		class APS_fnc_serverHandleAPS {
			allowedTargets = 2;
		};

		class WL2_fnc_handleClientRequest {
			allowedTargets = 2;
		};

		class KS_fnc_unflipVehicle {
			allowedTargets = 2;
		};

		class WL2_fnc_forfeitHandleServer {
			allowedTargets = 2;
		};

		class WL2_fnc_pingFix {
			allowedTargets = 1;
		};

		class WL2_fnc_demolish {
			allowedTargets = 0;
		};

		class MRTM_fnc_invite {
			allowedTargets = 2;
		};

		class MRTM_fnc_accept {
			allowedTargets = 2;
		};

		class WL2_fnc_forgiveTeamkill {
			allowedTargets = 2;
		};

		class MRTM_fnc_execCode {
			allowedTargets = 2;
		};

		class WL2_fnc_forfeitHandle {
			allowedTargets = 0;
		};

		class WL2_fnc_killRewardHandle {
			allowedTargets = 2;
		};

		class WL2_fnc_dazzlerOn {
			allowedTargets = 2;
		};

		class WL2_fnc_vehicleLock {
			allowedTargets = 0;
		};

		class WL2_fnc_reloadOverride {
			allowedTargets = 0;
		};

		class WL2_fnc_slingloadInit {
			allowedTargets = 0;
		};

		class WL2_fnc_uavConnectRefresh {
			allowedTargets = 0;
		};

		class WL2_fnc_updateVehicleList {
			allowedTargets = 2;
		};

		class MRTM_fnc_leaveGroup {
			allowedTargets = 0;
		};

		class WLC_fnc_action {
			allowedTargets = 0;
		};

		class WLC_fnc_clientEquip {
			allowedTargets = 0;
		};

		class WLC_fnc_levelUp {
			allowedTargets = 0;
		};

		class WLC_fnc_serverRequest {
			allowedTargets = 2;
		};

		class WLC_fnc_setScore {
			allowedTargets = 2;
		};

		class WLM_fnc_applyPylon {
			allowedTargets = 0;
		};

		class WLM_fnc_applyVehicle {
			allowedTargets = 0;
		};

		class WLM_fnc_rearmVehicle {
			allowedTargets = 0;
		};

		class WLM_fnc_moveSmokes {
			allowedTargets = 0;
		};

		class WLM_fnc_changeHorn {
			allowedTargets = 0;
		};

		class SQD_fnc_server {
			allowedTargets = 2;
		};

		//Don't touch
		class BIS_fnc_effectKilledAirDestruction {allowedTargets = 0; jip = 0;};
		class BIS_fnc_effectKilledSecondaries {allowedTargets = 0; jip = 0;};
		class BIS_fnc_objectVar {allowedTargets = 0; jip = 0;};
		class BIS_fnc_setCustomSoundController {allowedTargets = 0; jip = 0;};
		class BIS_fnc_debugConsoleExec {allowedTargets = 0; jip = 0;};
		class BIS_fnc_setIdentity {allowedTargets = 0; jip = 0;};
		class BIS_fnc_curatorRespawn {allowedTargets = 0; jip = 0;};
		class BIs_fnc_fire {allowedTargets = 0; jip = 0;};
	};

	class Commands {
		mode = 1;

		class setVehicleAmmoDef {
			allowedTargets = 0;
		};

		class setPylonLoadOut {
			allowedTargets = 0;
		};

		class SetAmmoOnPylon {
			allowedTargets = 0;
		};

		class setFuel {
			allowedTargets = 0;
		};

		class setFuelCargo {
			allowedTargets = 0;
		};

		class setPylonsPriority {
			allowedTargets = 0;
		};

		class lock {
			allowedTargets = 0;
		};

		class selectLeader {
			allowedTargets = 0;
		};

		class setRepairCargo {
			allowedTargets = 0;
		};

		class setAmmoCargo {
			allowedTargets = 0;
		};

		class removeWeaponGlobal {
			allowedTargets = 0;
		};

		class systemChat {
			allowedTargets = 0;
		};

		class diag_log {
			allowedTargets = 2;
		};

		class lookAt {
			allowedTargets = 0;
		};

		class setVehicleRadar {
			allowedTargets = 0;
		};

		class setVelocityModelSpace {
			allowedTargets = 2;
		};

		class setMass {
			allowedTargets = 0;
		};

		class setAutonomous {
			allowedTargets = 0;
		};
	};
};