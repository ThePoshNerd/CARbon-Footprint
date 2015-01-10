local composer = require( "composer" )

local gameNetwork = require "gameNetwork"
gameNetwork.init("google")

local leaderboardId = "CgkI-_Shl70OEAIQAQ" 
local achievementId = "CgkI-_Shl70OEAIQAg"


local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )

	local sceneGroup = self.view

carMakerGroup = display.newGroup()
sceneGroup:insert( carMakerGroup )


local myVehicle = display.newImage(myVehiclePath or "assets/cars/toyota-prius.png", true)
myVehicle.anchorY = 0
myVehicle.anchorX = 0.5
myVehicle.y = _H*0.5 + 500
myVehicle.x = _W*0.5
sceneGroup:insert(myVehicle)


local startDriveButton = display.newCircle( 100, 100, 256 )
startDriveButton.x = _W*0.5
startDriveButton.y = _H*0.5
sceneGroup:insert(startDriveButton)


local function goToDriveScreen (event)
	if event.phase == "began" then
		composer.gotoScene( "driveScreen", "fade", 400 )
	end
end

startDriveButton:addEventListener( "touch", goToDriveScreen )

---------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------






end

-- "scene:destroy()"
function scene:destroy( event )

	local sceneGroup = self.view

	-- Called prior to the removal of scene's view ("sceneGroup").
	-- Insert code here to clean up the scene.
	-- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene
