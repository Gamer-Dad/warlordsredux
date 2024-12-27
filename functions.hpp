class CfgFunctions {
	class MRTM {
		class Default {
			file = "scripts\MRTM";
			class accept {};
			class getLBPicture {};
			class getLBText {};
			class invite {};
			class leaveGroup {};
			class onButtonClick {};
			class onChar {};
			class onLBSelChanged {};
			class onSliderChanged {};
			class openGroupMenu {};
			class openMenu {};
			class settingsInit {};
			class settingsMenu {};
			class updateSettings {};
			class updateViewDistance {};
		};

		class Debug {
			file = "scripts\MRTMDebug";
			class execCode {};
			class openDebugMenu {};
			class setReturnValue {};
		};
	};
	class GFE {
		class Default {
			file = "scripts\GF_Earplugs";
			class credits {};
			class earplugs {};
		};
	};
	class KS {
		class Default {
			file = "scripts\VUnflip\functions";
			class unflipVehicle {};
			class unflipVehicleAddAction {};
			class isFlipped {};
		};
	};
	class APS {
		class Default {
			file = "scripts\APS\Scripts";
			class defineVehicles {};
		};
		class APS {
			file = "scripts\APS\Scripts\APS";
			class setupProjectiles {};
			class firedProjectile {};
			class serverHandleAPS {};
		};
		class Management {
			file = "scripts\APS\Scripts\Management";
			class rearmAPS {};
			class registerVehicle {};
		};
		class Misc {
			file = "scripts\APS\Scripts\Misc";
			class active {};
			class getDirection {};
			class hasCharges {};
			class misguideMissile {};
			class relDir2 {};
			class getMaxAmmo {};
		};
		class Report {
			file = "scripts\APS\Scripts\Report";
			class report {};
		};
	};
	class DIS {
		class SAM {
			file = "scripts\DIS";
			class check {};
			class frag {};
			class maneuver {};
			class missileCamera {};
			class onSamFired {};
			class registerLauncher {};
			class startMissileCamera {};
		};
	};
	class Fxr {
		class Default {
			file = "scripts\Fxr";
			class openReportMenu {};
			class closeReportMenu {};
		};
	};
	class SQD {
		class Default {
			file = "scripts\Squads";
			class client {};
			class initClient {};
			class initServer {};
			class menu {};
			class playerSelectionChanged {};
			class server {};
			class treeSelectionChanged {};
			class voice {};
		};
	};
	class WL2 {
		class Client {
			file = "core\client";
			class airburst {};
			class announcer {};
			class avTerminal {};
			class betty {};
			class clientEH {};
			class cpBalance {};
			class factionBasedClientInit {};
			class forfeitHandle {};
			class handleBuyMenuKeypress {};
			class handleKeypress {};
			class handleSelectionState {};
			class hintHandle {};
			class initClient {};
			class interceptAction {};
			class mineLimitHint {};
			class onPause {};
			class pingFix {};
			class pingFixInit {};
			class repackMagazines {};
			class rita {};
			class sideToFaction {};
			class spectrumAction {};
			class teammatesAvailability {};
			class timer {};
			class triggerPurchase {};
			class wasMain {};
			class welcome {};
			class zoneRestrictionHandleClient {};
		};
		class ClientAction {
			file = "core\client\action";
			class arsenalSetup {};
			class attachVehicle {};
			class dazzlerAction {};
			class demolish {};
			class deployableAddAction {};
			class deployableEligibility {};
			class jammerAction {};
			class logisticsAddAction {};
			class purchaseMenuAssetAvailability {};
			class purchaseMenuGetUIScale {};
			class purchaseMenuHandleDLC {};
			class purchaseMenuRefresh {};
			class purchaseMenuSetAssetDetails {};
			class purchaseMenuSetItemsList {};
			class radarOperate {};
			class rearmAction {};
			class removeAction {};
			class slingAddAction {};
			class vehicleLockAction {};
		};
		class ClientDraw {
			file = "core\client\draw";
			class drawJammerCircle {};
			class getDir {};
			class getPos {};
			class iconColor {};
			class iconDrawGPS {};
			class iconDrawMap {};
			class iconSize {};
			class iconText {};
			class iconTextSectorScan {};
			class iconType {};
			class mapIcons {};
			class refreshCurrentTargetData {};
			class refreshOSD {};
			class sceneDrawHandle {};
			class setOSDEvent {};
			class setupUI {};
			class smoothText {};
			class uavJammer {};
			class updateJammerMarkers {};
		};
		class ClientKill {
			file = "core\client\kill";
			class askForgiveness {};
			class deathInfo {};
			class friendlyFireHandleClient {};
			class handleKillFeedUpdate {};
			class killRewardClient {};
			class updateKillFeed {};
		};
		class ClientMap {
			file = "core\client\map";
			class assetMapControl {};
			class captureList {};
			class deleteAssetFromMap {};
			class getRespawnMarkers {};
			class getSideBase {};
			class groupIconClickHandle {};
			class groupIconEnterHandle {};
			class groupIconLeaveHandle {};
			class handleEnemyCapture {};
			class mapControlHandle {};
			class sectorCaptureStatus {};
			class sectorMarkerUpdate {};
			class sectorOwnershipHandleClient {};
			class sectorRevealHandle {};
			class sectorScanHandle {};
			class sectorsInitClient {};
			class selectedTargetsHandle {};
			class targetResetHandle {};
			class targetResetHandleVote {};
			class targetSelected {};
			class targetSelectionHandleClient {};
		};
		class ClientOrder {
			file = "core\client\order";
			class cancelVehicleOrder {};
			class orderAircraft {};
			class orderArsenal {};
			class orderFastTravel {};
			class orderForfeit {};
			class orderFTPodFT {};
			class orderFTVehicleFT {};
			class orderFundsTransfer {};
			class orderLastLoadout {};
			class orderNaval {};
			class orderSavedLoadout {};
			class orderSectorScan {};
			class orderVehicle {};
			class requestPurchase {};
		};
		class Common {
			file = "core\common";
			class accessControl {};
			class findSpawnPositions {};
			class getAssetSide {};
			class getAssetTypeName {};
			class getMagazineName {};
			class getMoneySign {};
			class getVehicleWeapons {};
			class grieferCheck {};
			class handleInstigator {};
			class handleRespawnMarkers {};
			class income {};
			class initCommon {};
			class lastHitHandler {};
			class missionEndHandle {};
			class newAssetHandle {};
			class parsePurchaseList {};
			class reloadOverride {};
			class slingloadInit {};
			class sortSectorArrays {};
			class tablesSetUp {};
			class uavConnectRefresh {};
			class updateSectorArrays {};
			class varsInit {};
			class vehicleLock {};
		};
		class Server {
			file = "core\server";
			class assetRelevanceCheck {};
			class calcImbalance {};
			class changeSectorOwnership {};
			class createUAVCrew {};
			class createVehicleCorrectly {};
			class dazzlerOn {};
			class detectNewPlayers {};
			class forfeitHandleServer {};
			class forgiveTeamkill {};
			class friendlyFireHandleServer {};
			class fundsDatabaseUpdate {};
			class fundsDatabaseWrite {};
			class garbageCollector {};
			class handleClientRequest {};
			class handleEntityRemoval {};
			class incomePayoff {};
			class initServer {};
			class killRewardHandle {};
			class populateSector {};
			class processRunways {};
			class selectTarget {};
			class serverEHs {};
			class setupNewWarlord {};
			class targetResetHandleServer {};
			class targetSelectionHandleServer {};
			class updateVehicleList {};
			class WLAC {};
			class zoneRestrictionHandleServer {};
		};
		class ServerSector {
			file = "core\server\sector";
			class getCapValues {};
			class sectorCaptureHandle {};
			class sectorsInitServer {};
		};
		class ServerOrder {
			file = "core\server\order";
			class orderAir {};
			class orderGround {};
			class orderWater {};
		};
	};
	class WLM {
		class WLM {
			file = "Scripts\WLM\functions";
			class applyCustomization {};
			class applyLoadoutAircraft {};
			class applyLoadoutVehicle {};
			class applyPylon {};
			class applyVehicle {};
			class calculateFreeRearmEligibility {};
			class changeHorn {};
			class constructAircraftPylons {};
			class constructPresetMenu {};
			class constructVehicleMagazine {};
			class initMenu {};
			class menuTextOverrides {};
			class moveSmokes {};
			class rearmAircraft {};
			class rearmVehicle {};
			class saveLoadout {};
			class selectLoadout {};
			class startRearmVehicle {};
			class switchUser {};
			class textureLists {};
			class textureSlots {};
			class wipePylonSaves {};
		};
	};
};