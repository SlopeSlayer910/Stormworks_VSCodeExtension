
require("LifeBoatAPI.Tools.Builder.LBBuilder")

local neloAddonPath = LBFilepath:new(arg[1]);
local neloMCPath = LBFilepath:new(arg[2]);
local outputDir = LBFilepath:new(arg[3]);
local params = {boilerPlate = arg[4]};
local rootDirs = {};

for i=5, #arg do
    table.insert(rootDirs, LBFilepath:new(arg[i]));
end

local _builder = LBBuilder:new(rootDirs, outputDir, neloMCPath, neloAddonPath)
_builder:buildAddonScript([[assets\LifeBoatAPI\Tools\LifeBoatAPI\Tools\Simulator\LBSimulator_ScreenAPI.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Tools\LifeBoatAPI\Tools\Simulator\LBSimulator_ScreenAPI.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Tools\LifeBoatAPI\Tools\Simulator\LBSimulator_InputOutputAPI.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Tools\LifeBoatAPI\Tools\Simulator\LBSimulator_InputOutputAPI.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Tools\LifeBoatAPI\Tools\Simulator\LBSimulatorInputHelpers.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Tools\LifeBoatAPI\Tools\Simulator\LBSimulatorInputHelpers.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Tools\LifeBoatAPI\Tools\Simulator\LBSimulatorConfig.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Tools\LifeBoatAPI\Tools\Simulator\LBSimulatorConfig.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Tools\LifeBoatAPI\Tools\Simulator\LBSimulator.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Tools\LifeBoatAPI\Tools\Simulator\LBSimulator.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Microcontroller\Vehicle\Utils\LBTable.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Microcontroller\Vehicle\Utils\LBTable.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Microcontroller\Vehicle\Utils\LBCopy.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Microcontroller\Vehicle\Utils\LBCopy.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Utils\LBTable.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Utils\LBTable.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Utils\LBStringMatch.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Utils\LBStringMatch.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Utils\LBStringBuilder.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Utils\LBStringBuilder.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Utils\LBString.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Utils\LBString.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Utils\LBIteratorProtection.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Utils\LBIteratorProtection.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Utils\LBEvent.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Utils\LBEvent.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Utils\LBBase.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Utils\LBBase.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Collections\LBVehicleManager.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Collections\LBVehicleManager.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Collections\LBPlayerManager.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Collections\LBPlayerManager.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Collections\LBGlobalEventHandler.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Collections\LBGlobalEventHandler.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\LifeBoatAPI.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\LifeBoatAPI.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBVehicle.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBVehicle.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBPlayer.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBPlayer.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBObject.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBObject.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBNPC.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBNPC.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBFire.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBFire.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBEntityBase.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBEntityBase.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBCharacter.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBCharacter.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBAnimal.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Entity\LBAnimal.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Math\LBVec.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Math\LBVec.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Math\LBMatrix.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Math\LBMatrix.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\UI\LBNotification.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\UI\LBNotification.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\UI\Popups\LBWorldPopup.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\UI\Popups\LBWorldPopup.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\UI\Popups\LBScreenPopup.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\UI\Popups\LBScreenPopup.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\UI\Popups\LBPopupBase.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\UI\Popups\LBPopupBase.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\UI\MapMarkers\LBMapMarkers.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\UI\MapMarkers\LBMapMarkers.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Admin\LBServer.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Admin\LBServer.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Admin\LBGameSettings.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Admin\LBGameSettings.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Addon\LBWorldTiles.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Addon\LBWorldTiles.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Addons\LifeBoatAPI\Addon\LBAddon.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Addons\LifeBoatAPI\Addon\LBAddon.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Microcontroller\Vehicle\Screen\LBUITree.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Microcontroller\Vehicle\Screen\LBUITree.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Microcontroller\Vehicle\Maths\LBVec3.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Microcontroller\Vehicle\Maths\LBVec3.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Microcontroller\Vehicle\Maths\LBVec2.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Microcontroller\Vehicle\Maths\LBVec2.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Microcontroller\Vehicle\Maths\LBAngles.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Microcontroller\Vehicle\Maths\LBAngles.lua]]), params)
_builder:buildAddonScript([[assets\LifeBoatAPI\Microcontroller\Vehicle\Instruments\Weapons\LBWeapons.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\LifeBoatAPI\Microcontroller\Vehicle\Instruments\Weapons\LBWeapons.lua]]), params)
_builder:buildAddonScript([[assets\nelodocs\docs_vehicles.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\nelodocs\docs_vehicles.lua]]), params)
_builder:buildAddonScript([[assets\nelodocs\docs_missions.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\nelodocs\docs_missions.lua]]), params)
_builder:buildAddonScript([[assets\luasocket\socket.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\luasocket\socket.lua]]), params)
_builder:buildAddonScript([[assets\luasocket\re.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\luasocket\re.lua]]), params)
_builder:buildAddonScript([[assets\luasocket\mime.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\luasocket\mime.lua]]), params)
_builder:buildAddonScript([[assets\luasocket\ltn12.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\luasocket\ltn12.lua]]), params)
_builder:buildAddonScript([[assets\luasocket\socket\url.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\luasocket\socket\url.lua]]), params)
_builder:buildAddonScript([[assets\luasocket\socket\tp.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\luasocket\socket\tp.lua]]), params)
_builder:buildAddonScript([[assets\luasocket\socket\smtp.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\luasocket\socket\smtp.lua]]), params)
_builder:buildAddonScript([[assets\luasocket\socket\http.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\luasocket\socket\http.lua]]), params)
_builder:buildAddonScript([[assets\luasocket\socket\headers.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\luasocket\socket\headers.lua]]), params)
_builder:buildAddonScript([[assets\luasocket\socket\ftp.lua]], LBFilepath:new([[c:\personal\STORMWORKS_VSCodeExtension\Extension\assets\luasocket\socket\ftp.lua]]), params)