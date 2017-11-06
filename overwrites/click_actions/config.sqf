//  DZE_CLICK_ACTIONS
//      This is where you register your right-click actions
//  FORMAT -- (no comma after last array entry)
//      [_classname,_text,_execute,_condition],
//  PARAMETERS
//  _classname  : the name of the class to click on 
//                  (example = "ItemBloodbag")
//  _text       : the text for the option that is displayed when right clicking on the item 
//                  (example = "Self Transfuse")
//  _execute    : compiled code to execute when the option is selected 
//                  (example = "execVM 'my\scripts\self_transfuse.sqf';")
//  _condition  : compiled code evaluated to determine whether or not the option is displayed
//                  (example = {true})
//  EXAMPLE -- see below for some simple examples
DZE_CLICK_ACTIONS = [
	["ItemMap","Disable Grass","setTerrainGrid 50;systemChat('Disabled Grass');","true"],
	["ItemMap","Enable Grass Lv.1","setTerrainGrid 25;systemChat('Enabled Grass');","true"],
	["ItemMap","Enable Grass Lv.2","setTerrainGrid 12.5;systemChat('Improved Grass');","true"],
	["ItemRadio","Environment Sound ON" ,"enableEnvironment true;systemChat('Environment Sound ON');","true"],
	["ItemRadio","Environment Sound OFF" ,"enableEnvironment false;systemChat('Environment Sound OFF');","true"],
	["Binocular","View Range Up"   ,"if(isNil 'DZE_CA_VIEWRANGE') then {DZE_CA_VIEWRANGE = 1200;};DZE_CA_VIEWRANGE = (DZE_CA_VIEWRANGE + 100) min 4000;  systemChat format['View Distance: %1',DZE_CA_VIEWRANGE];setViewDistance DZE_CA_VIEWRANGE;","true"],
	["Binocular","View Range Down" ,"if(isNil 'DZE_CA_VIEWRANGE') then {DZE_CA_VIEWRANGE = 1200;};DZE_CA_VIEWRANGE = (DZE_CA_VIEWRANGE - 100) max 200;   systemChat format['View Distance: %1',DZE_CA_VIEWRANGE];setViewDistance DZE_CA_VIEWRANGE;","true"],
	["Binocular_Vector","Range Up"   ,"if(isNil 'DZE_CA_VIEWRANGE') then {DZE_CA_VIEWRANGE = 1200;};DZE_CA_VIEWRANGE = (DZE_CA_VIEWRANGE + 100) min 4000;systemChat format['View Distance: %1',DZE_CA_VIEWRANGE];setViewDistance DZE_CA_VIEWRANGE;","true"],
	["Binocular_Vector","Range Down" ,"if(isNil 'DZE_CA_VIEWRANGE') then {DZE_CA_VIEWRANGE = 1200;};DZE_CA_VIEWRANGE = (DZE_CA_VIEWRANGE - 100) max 200; systemChat format['View Distance: %1',DZE_CA_VIEWRANGE];setViewDistance DZE_CA_VIEWRANGE;","true"],
    ["ItemGPS","Scan Nearby","if(isNil 'DZE_CLICK_ACTIONS_GPS_RANGE') then {DZE_CLICK_ACTIONS_GPS_RANGE = 1500;};DZE_CLICK_ACTIONS_ZOMBIE_COUNT = count ((position player) nearEntities ['zZombie_Base',DZE_CLICK_ACTIONS_GPS_RANGE]); DZE_CLICK_ACTIONS_MAN_COUNT = count ((position player) nearEntities ['CAManBase',DZE_CLICK_ACTIONS_GPS_RANGE]);cutText[format['Within %1 Meters: %2 AI/players, %3 zombies, %4 vehicles',DZE_CLICK_ACTIONS_GPS_RANGE,DZE_CLICK_ACTIONS_MAN_COUNT - DZE_CLICK_ACTIONS_ZOMBIE_COUNT,count ((position player) nearEntities ['zZombie_Base',DZE_CLICK_ACTIONS_GPS_RANGE]),count ((position player) nearEntities ['allVehicles',DZE_CLICK_ACTIONS_GPS_RANGE]) - DZE_CLICK_ACTIONS_MAN_COUNT],'PLAIN DOWN'];","true"],
    ["ItemGPS","Range Up"   ,"if(isNil 'DZE_CLICK_ACTIONS_GPS_RANGE') then {DZE_CLICK_ACTIONS_GPS_RANGE = 1500;};DZE_CLICK_ACTIONS_GPS_RANGE = (DZE_CLICK_ACTIONS_GPS_RANGE + 100) min 2500; cutText[format['GPS RANGE: %1',DZE_CLICK_ACTIONS_GPS_RANGE],'PLAIN DOWN'];","true"],
    ["ItemGPS","Range Down" ,"if(isNil 'DZE_CLICK_ACTIONS_GPS_RANGE') then {DZE_CLICK_ACTIONS_GPS_RANGE = 1500;};DZE_CLICK_ACTIONS_GPS_RANGE = (DZE_CLICK_ACTIONS_GPS_RANGE - 100) max 1000;  cutText[format['GPS RANGE: %1',DZE_CLICK_ACTIONS_GPS_RANGE],'PLAIN DOWN'];","true"],
    ["ItemGPS","Toggle Map Marker","execVM 'overwrites\click_actions\examples\marker.sqf';","true"],
    ["ItemMap","Toggle Map Marker","execVM 'overwrites\click_actions\examples\marker.sqf';","true"]
];

DZE_CLICK_ACTIONS = DZE_CLICK_ACTIONS + [["ItemKey","Eject players","spawn remoteVehicle;","true",1]];
DZE_CLICK_ACTIONS = DZE_CLICK_ACTIONS + [["ItemKey","Toggle engine on/off","spawn remoteVehicle;","true",2]];
DZE_CLICK_ACTIONS = DZE_CLICK_ACTIONS + [["ItemKey","Unlock vehicle","spawn remoteVehicle;","true",3]];
DZE_CLICK_ACTIONS = DZE_CLICK_ACTIONS + [["ItemKey","Lock vehicle","spawn remoteVehicle;","true",4]];
DZE_CLICK_ACTIONS = DZE_CLICK_ACTIONS + [["ItemKey","Toggle Lights","spawn remoteVehicle;","true",5]];
