params ["_asset", "_assetToLoad"];

private _bounds = boundingBoxReal [_assetToLoad, "FireGeometry"];
private _sphere = _bounds # 2;

private _offset = (_sphere / 2) min 1;

private _slingRope1 = ropeCreate [_asset, "slingload0", _assetToLoad, [_offset, _offset, 0], 15];
private _slingRope2 = ropeCreate [_asset, "slingload0", _assetToLoad, [-_offset, -_offset, 0], 15];
private _slingRope3 = ropeCreate [_asset, "slingload0", _assetToLoad, [_offset, -_offset, 0], 15];
private _slingRope4 = ropeCreate [_asset, "slingload0", _assetToLoad, [-_offset, _offset, 0], 15];

_assetToLoad setTowParent _asset;

waitUntil {
    sleep 1;
    local _assetToLoad || !alive _assetToLoad || !alive _asset;
};

[_assetToLoad, getMass _asset / 3] remoteExec ["setMass", 0];