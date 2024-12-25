#include "..\warlords_constants.inc"

{_x setMarkerAlphaLocal 0} forEach BIS_WL_sectorLinks;

while {!BIS_WL_missionEnd} do {
	private _lastTarget = WL_TARGET_FRIENDLY;

	sleep WL_TIMEOUT_SHORT;
	_isRegularSquadMember = ["isRegularSquadMember", [getPlayerID player]] call SQD_fnc_client;

	waitUntil {
		sleep 1;
		if (BIS_WL_currentSelection in [WL_ID_SELECTION_VOTING, WL_ID_SELECTION_VOTED]) then {
			BIS_WL_currentSelection = WL_ID_SELECTION_NONE;
		};
		isNull WL_TARGET_FRIENDLY
	};

	BIS_WL_currentSelection = WL_ID_SELECTION_VOTING;

	if (!_isRegularSquadMember) then {
		if !(isNull (uiNamespace getVariable ["BIS_WL_purchaseMenuDisplay", displayNull])) then {
			[player, "fundsTransferCancel"] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2];
			playSound "AddItemFailed";
		};
		"RequestMenu_close" call BIS_fnc_WL2_setupUI;

		0 spawn {
			sleep 0.1;
			if (BIS_WL_missionEnd) exitWith {};
			"Voting" call BIS_fnc_WL2_announcer;
			[toUpper localize "STR_A3_WL_popup_voting"] spawn BIS_fnc_WL2_smoothText;
			waitUntil {visibleMap || {!isNull WL_TARGET_FRIENDLY}};
			if (visibleMap && {isNull BIS_WL_targetVote}) then {
				"Sector" call BIS_fnc_WL2_announcer;
				[toUpper localize "STR_A3_WL_info_voting_click"] spawn BIS_fnc_WL2_smoothText;
			};
		};
		if !(isNull _lastTarget) then {
			_t = serverTime + 3;
			waitUntil {(_lastTarget getVariable "BIS_WL_owner") == BIS_WL_playerSide || {serverTime > _t}};
		};
	};

	["client"] call BIS_fnc_WL2_updateSectorArrays;

	0 spawn {
		private _mostVotedVar = format ["BIS_WL_mostVoted_%1", BIS_WL_playerSide];

		waitUntil {count (missionNamespace getVariable [_mostVotedVar, []]) > 0};
		_data = (missionNamespace getVariable _mostVotedVar);
		["voting", [(_data # 1) - (getMissionConfigValue ["BIS_WL_sectorVotingDuration", 30]), _data # 1, _mostVotedVar]] spawn BIS_fnc_WL2_setOSDEvent;
	};

	private _voteLocked = missionNamespace getVariable ["voteLocked", true];
	if !(_voteLocked) then {
		0 spawn {
			private _mostVotedVar = format ["BIS_WL_mostVoted_%1", BIS_WL_playerSide];
			private _voteTallyDisplayVar = format ["BIS_WL_sectorVoteTallyDisplay_%1", BIS_WL_playerSide];

			private _voteDisplay = uiNamespace getVariable ["RscWLVoteDisplay", objNull];
			if (isNull _voteDisplay) then {
				"VoteDisplay" cutRsc ["RscWLVoteDisplay", "PLAIN", -1, true, false];
				_voteDisplay = uiNamespace getVariable "RscWLVoteDisplay";
			};

			private _indicator = _voteDisplay displayCtrl 7002;
			private _indicatorBackground = _voteDisplay displayCtrl 7003;
			_indicatorBackground ctrlSetBackgroundColor [0, 0, 0, 0.7];

			while { isNull WL_TARGET_FRIENDLY && !BIS_WL_missionEnd && !BIS_WL_resetTargetSelection_client } do {
				_voteLocked = missionNamespace getVariable ["voteLocked", true];
				if (_voteLocked) then {
					break;
				};

				private _sortedVoteList = missionNamespace getVariable [_voteTallyDisplayVar, []];
				private _mostVoted = missionNamespace getVariable [_mostVotedVar, []];
				private _eta = if (count _mostVoted > 0) then {
					round (_mostVoted # 1 - serverTime);
				} else {
					-1;
				};
				private _etaDisplay = format ["<t size='1.2' align='center'>%1 s</t><br/>", _eta max 0];

				private _displayText = format ["<t size='1.8' align='center'>%1</t><br/>%2", localize "STR_WL2_VOTE_IN_PROGRESS", _etaDisplay];
				{
					private _vote = _x # 0;
					private _voteCount = _x # 1;

					private _sectorName = _vote getVariable ["BIS_WL_name", "???"];
					private _isSectorRevealed = BIS_WL_playerSide in (_vote getVariable ["BIS_WL_revealedBy", []]);

					private _color = if (_isSectorRevealed) then {
						private _sectorOwner = _vote getVariable ["BIS_WL_owner", independent];
						['#004d99', '#7f0400', '#007f04'] # ([west, east, independent] find _sectorOwner);
					} else {
						'#ffff00';
					};
					_displayText = _displayText + format ["<t size='1.2' align='center' color='%1' shadow='2'>%2: %3 pts</t><br/>", _color, _vote getVariable "BIS_WL_name", _voteCount];
				} forEach _sortedVoteList;

				_indicator ctrlSetStructuredText (parseText _displayText);
				_indicatorBackground ctrlSetPositionH (0.13 + (count _sortedVoteList) * 0.04);
				_indicatorBackground ctrlSetBackgroundColor [0, 0, 0, 0.7];
				_indicatorBackground ctrlCommit 0;

				if !(profileNamespace getVariable ["MRTM_muteVoiceInformer", false]) then {
					if (_eta <= 10 && _eta >= 0) then {
						playSoundUI ["a3\ui_f\data\sound\readout\readouthideclick1.wss", 6 - (_eta / 2)];
					};
				};

				sleep WL_TIMEOUT_STANDARD;
			};

			_indicator ctrlSetText "";
			_indicatorBackground ctrlSetBackgroundColor [0, 0, 0, 0];
		};
	};

	if !(isServer) then {
		waitUntil {
			private _selectedTarget = !isNull WL_TARGET_FRIENDLY;
			private _joinedSquad = ["isRegularSquadMember", [getPlayerID player]] call SQD_fnc_client;

			_selectedTarget || BIS_WL_missionEnd || BIS_WL_resetTargetSelection_client || _joinedSquad
		};
	} else {
		_pass = FALSE;
		while {!_pass} do {
			waitUntil {!isNull WL_TARGET_FRIENDLY || {BIS_WL_missionEnd || {BIS_WL_resetTargetSelection_client}}};

			if (BIS_WL_resetTargetSelection_client) then {
				sleep WL_TIMEOUT_STANDARD;
				if (BIS_WL_resetTargetSelection_client) then {
					_pass = TRUE;
				};
			} else {
				_pass = TRUE;
			};
		};
	};

	BIS_WL_targetVote = objNull;

	if (BIS_WL_currentSelection in [WL_ID_SELECTION_VOTING, WL_ID_SELECTION_VOTED]) then {
		BIS_WL_currentSelection = WL_ID_SELECTION_NONE;
	};

	// missionNamespace setVariable [format ["BIS_WL_mostVoted_%1", BIS_WL_playerSide], []];
	missionNamespace setVariable [format ["BIS_WL_targetVote_%1", getPlayerID player], objNull, 2];

	if (BIS_WL_resetTargetSelection_client) then {
		BIS_WL_resetTargetSelection_client = FALSE;
		"Reset" call BIS_fnc_WL2_announcer;
		["voting", []] spawn BIS_fnc_WL2_setOSDEvent;
		[toUpper localize "STR_A3_WL_voting_reset"] spawn BIS_fnc_WL2_smoothText;
		sleep 2;
	} else {
		if !(BIS_WL_missionEnd) then {
			waitUntil {sleep WL_TIMEOUT_MIN; !isNull WL_TARGET_FRIENDLY};
			call BIS_fnc_WL2_refreshCurrentTargetData;
			"Selected" call BIS_fnc_WL2_announcer;
			[toUpper format [localize "STR_A3_WL_popup_voting_done", WL_TARGET_FRIENDLY getVariable "BIS_WL_name"]] spawn BIS_fnc_WL2_smoothText;
			["client", TRUE] call BIS_fnc_WL2_updateSectorArrays;
		};
	};
};