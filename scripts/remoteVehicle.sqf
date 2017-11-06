/*
	Remote vehicle script by salival (https://github.com/oiad) modified by Schalldampfer
*/

private ["_characterID","_checkDistance","_display","_distance","_fuel","_group","_keyFound","_keyID","_keyName","_option","_time","_ownerID","_vehicle","_vehicleType","_vehicleName"];

_keyName = _this select 0;
_option = _this select 1;

_checkDistance = true; // Check to see if the player is too far away from the remote
_distance = 300; // Maximum distance the player can be away from the vehicle to be able to use the remote.

disableSerialization;

_display = findDisplay 106;
_display closeDisplay 0;

if ( !("ItemRadio" in ([player] call BIS_fnc_invString)) ) exitWith {"You don't have a radio." call dayz_rollingMessages;};

_keyID = 0;
{
	if (configName(inheritsFrom(configFile >> "CfgWeapons" >> _x)) in ["ItemKeyYellow","ItemKeyBlue","ItemKeyRed","ItemKeyGreen","ItemKeyBlack"]) then {
		if (_x == _keyName) then {
			_keyID = getNumber(configFile >> "CfgWeapons" >> _x >> "keyid");
		};
	};
} forEach (items player);

if (_keyID == 0) exitWith {"No valid keys in your toolbelt." call dayz_rollingMessages;};

_keyFound = false;
_vehList = [];
{
	_ownerID = parseNumber (_x getVariable ["CharacterID","0"]);
	if (_keyID == _ownerID) then {
		_vehList set [count _vehList,_x];//Add vehicle to list
	};
} count vehicles;
CC_vehID = count _vehList;
_keyFound = count _vehList > 0;

if (!_keyFound) exitWith {"Unable to find any vehicle for this key." call dayz_rollingMessages;};


//Selection menu
SelectKitt = [
	[format["Remote Key %1",_keyName],true],
	["Select car", [0], "", -2, [["expression", ""]], "1", "0"]
];
{
	SelectKitt set[count SelectKitt, [ format["%1@%2m", getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName"), round(player distance _x)], [0], "", -5, [ ["expression",format["CC_vehID=%1;",_forEachIndex]] ], "1", "1"] ];
} forEach _vehList;
SelectKitt set [count SelectKitt, ["Exit", [1], "", -3, [["expression", "CC_vehID = count _vehList;"]], "1", "1"] ];

if (count _vehList == 1) then {
	CC_vehID = 0;
} else {
	showCommandingMenu "#USER:SelectKitt";
	//Wait for selection
	waitUntil {(CC_vehID != count _vehList)||(commandingMenu == "")};
};

//Set selected Vehicle
_vehicle = _vehList select CC_vehID;
_vehicleName =getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");

if (!alive _vehicle) exitWith {"The vehicle has been destroyed." call dayz_rollingMessages;};

if (_checkDistance && {(player distance _vehicle) >= _distance}) exitWith {format ["The %1 is out of range.",_vehicleName] call dayz_rollingMessages;};

if (_option == 1) then {
	_group = units group player;

	format ["Ejecting all players not in your group from %1",_vehicleName] call dayz_rollingMessages;

	{
		if !(_x in _group) then {
			_x action ["eject",_vehicle];
			format ["Ejecting %1, he is NOT in your group.",name _x] call dayz_rollingMessages;
		};
	} forEach (crew _vehicle);
};

if (_option == 2) then {
	format ["Toggling engine of %1",_vehicleName] call dayz_rollingMessages;
	if (isEngineOn _vehicle) then {
		if (_vehicle isKindOf "Helicopter") then { // This is needed because dayz_engineSwitch won't turn off the engine for a helicopter.
			_fuel = fuel _vehicle;
			_vehicle setFuel 0;
			player action ["engineOff",_vehicle];
			uiSleep 4; 
			_vehicle setFuel _fuel;
		} else {
			[_vehicle,false] call dayz_engineSwitch;
		};
	} else {
		[_vehicle,true] call dayz_engineSwitch;
	};
};

if (_option == 3) then {
	format ["Unlocking %1",_vehicleName] call dayz_rollingMessages;
	PVDZE_veh_Lock = [_vehicle,false];
	_time = diag_tickTime;

	if (local _vehicle) then {
		PVDZE_veh_Lock call local_lockUnlock;
	} else {
		publicVariable "PVDZE_veh_Lock";
		//Wait for lock status to update over network (can take up to a few seconds)
		waitUntil {uiSleep 0.1;(!locked _vehicle or (diag_tickTime - _time > 4))};
	};
};

if (_option == 4) then {
	format ["Locking %1",_vehicleName] call dayz_rollingMessages;
	PVDZE_veh_Lock = [_vehicle,true];
	_time = diag_tickTime;

	if (local _vehicle) then {
		PVDZE_veh_Lock call local_lockUnlock;
	} else {
		publicVariable "PVDZE_veh_Lock";
		//Wait for lock status to update over network (can take up to a few seconds)
		waitUntil {uiSleep 0.1;(locked _vehicle or (diag_tickTime - _time > 4))};
	};
};

if (_option == 5) then {
	if (_vehicle getVariable["lightOff",true]) then {
		player action ["lightOn", _vehicle];
		format ["Lights on %1",_vehicleName] call dayz_rollingMessages;
		_vehicle setVariable ["lightOn",true];
		_vehicle setVariable ["lightOff",false];
	} else {
		player action ["lightOff", _vehicle];
		format ["Lights off %1",_vehicleName] call dayz_rollingMessages;
		_vehicle setVariable ["lightOn",false];
		_vehicle setVariable ["lightOff",true];
	};
};

if (_option == 6) then {
	_locked = locked _vehicle;
	format ["%2 %1",_vehicleName,if(_locked) then {"Unlocking"} else {"Locking"}] call dayz_rollingMessages;
	PVDZE_veh_Lock = [_vehicle,!_locked];
	_time = diag_tickTime;

	if (local _vehicle) then {
		PVDZE_veh_Lock call local_lockUnlock;
	} else {
		publicVariable "PVDZE_veh_Lock";
	};
};
