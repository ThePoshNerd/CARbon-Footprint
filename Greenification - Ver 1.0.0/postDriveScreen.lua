local composer = require( "composer" )


local save5Achieve = "CgkI-_Shl70OEAIQAg"
local save10Achieve = "CgkI-_Shl70OEAIQAw"
local save20Achieve = "CgkI-_Shl70OEAIQBA"

local drive25Achieve = "CgkI-_Shl70OEAIQBQ"
local drive50Achieve = "CgkI-_Shl70OEAIQBg"


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


local postDriveMenu = display.newImage("assets/menus/postDriveScreen.png", true)
postDriveMenu.anchorY = 0.5
postDriveMenu.anchorX = 0.5
postDriveMenu.y = _H*0.5
postDriveMenu.x = _W*0.5
sceneGroup:insert(postDriveMenu)

local leaderboardButton = display.newRect( 0, 0, 860, 250 )
leaderboardButton.x = _W*0.5
leaderboardButton.y = _H*0.5 - 75
leaderboardButton.alpha = 0.1
sceneGroup:insert(leaderboardButton)

local redeemButton = display.newRect( 0, 0, 860, 250 )
redeemButton.x = _W*0.5
redeemButton.y = _H*0.5 + 275
redeemButton.alpha = 0.1
sceneGroup:insert(redeemButton)


local newDriveButton = display.newRect( 0, 0, 860, 250 )
newDriveButton.x = _W*0.5
newDriveButton.y = _H*0.5 + 615
newDriveButton.alpha = 0.1
sceneGroup:insert(newDriveButton)


local function showLeaderboard (event)
	if event.phase == "began" then
		gameNetwork.show("leaderboards")
	end
end

leaderboardButton:addEventListener( "touch", showLeaderboard )


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
