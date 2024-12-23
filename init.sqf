/*******************************START OF SCRIPTS****************************/

APS_fnc_DefineVehicles = compileFinal preprocessFile "scripts\APS\Scripts\DefineVehicles.sqf";
0 spawn APS_fnc_DefineVehicles;

if !(isDedicated) then {
	private _fncEarPlugsCredit = compileFinal preprocessFileLineNumbers "scripts\GF_Earplugs\Credits.sqf";
	call _fncEarPlugsCredit;

	waitUntil { !isNull player };
	0 spawn KS_fnc_unflipVehicleAddAction;
};
/*******************************END OF SCRIPTS****************************/

BIS_fnc_WL2_findSpawnPositions = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_findSpawnPositions.sqf";
BIS_fnc_WL2_getSideBase = compileFinal preprocessFileLineNumbers "Functions\client\fn_WL2_getSideBase.sqf";
BIS_fnc_WL2_getAssetSide = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_getAssetSide.sqf";
BIS_fnc_WL2_getAssetTypeName = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_getAssetTypeName.sqf";
BIS_fnc_WL2_getMagazineName = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_getMagazineName.sqf";
BIS_fnc_WL2_getMoneySign = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_getMoneySign.sqf";
BIS_fnc_WL2_getVehicleWeapons = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_getVehicleWeapons.sqf";
BIS_fnc_WL2_grieferCheck = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_grieferCheck.sqf";
BIS_fnc_WL2_handleRespawnMarkers = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_handleRespawnMarkers.sqf";
BIS_fnc_WL2_handleInstigator = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_handleInstigator.sqf";
BIS_fnc_WL2_income = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_income.sqf";
BIS_fnc_WL2_initCommon = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_initCommon.sqf";
BIS_fnc_WL2_lastHitHandler = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_lastHitHandler.sqf";
BIS_fnc_WL2_missionEndHandle = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_missionEndHandle.sqf";
BIS_fnc_WL2_newAssetHandle = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_newAssetHandle.sqf";
BIS_fnc_WL2_parsePurchaseList = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_parsePurchaseList.sqf";
BIS_fnc_WL2_reloadOverride = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_reloadOverride.sqf";
BIS_fnc_WL2_slingloadInit = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_slingloadInit.sqf";
BIS_fnc_WL2_sortSectorArrays = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_sortSectorArrays.sqf";
BIS_fnc_WL2_tablesSetUp = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_tablesSetUp.sqf";
BIS_fnc_WL2_uavConnectRefresh = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_uavConnectRefresh.sqf";
BIS_fnc_WL2_updateSectorArrays = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_updateSectorArrays.sqf";
BIS_fnc_WL2_varsInit = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_varsInit.sqf";
BIS_fnc_WL2_vehicleLock = compileFinal preprocessFileLineNumbers "Functions\common\fn_WL2_vehicleLock.sqf";

MRTM_fnc_execCode = compileFinal preprocessFileLineNumbers "Scripts\MRTMDebug\fn_execCode.sqf";

call BIS_fnc_WL2_initCommon;