while { !BIS_WL_missionEnd } do {
    waitUntil {
        sleep 0.001;
        !isNull findDisplay 160
    };

    while { !isNull findDisplay 160 } do {
        private _selectBox = findDisplay 160 displayCtrl 117;

        waitUntil { lbSize _selectBox != 0 || isNull findDisplay 160 };

        private _size = lbSize _selectBox;
        private _changes = false;

        for "_i" from 1 to (_size - 1) do {
            private _text = _selectBox lbText _i;
            private _data = _text splitString "#";

            if (count _data >= 2) then {
                _changes = true;

                private _playerName = _data # 0;
                private _assetType = _data # 1;

                _selectBox lbSetText [_i, format ["[%1] %2", _playerName, _assetType]];

                if (_playerName == name player) then {
                    _selectBox lbSetColor [_i, [0, 1, 0, 1]];
                } else {
                    private _player = allPlayers select { name _x == _playerName } select 0;
                    private _isInMySquad = ["isInMySquad", [getPlayerID _player]] call SQD_fnc_client;

                    if (_isInMySquad) then {
                        _selectBox lbSetColor [_i, [0, 1, 1, 1]];
                    };
                };
            };
        };

        if (_changes) then {
            lbSort _selectBox;
        };

        sleep 0.001;
    };
};