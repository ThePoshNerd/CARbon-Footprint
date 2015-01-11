local composer = require( "composer" )
local widget = require "widget"

local save5Achieve = "CgkI-_Shl70OEAIQAg"
local save10Achieve = "CgkI-_Shl70OEAIQAw"
local save20Achieve = "CgkI-_Shl70OEAIQBA"

local drive25Achieve = "CgkI-_Shl70OEAIQBQ"
local drive50Achieve = "CgkI-_Shl70OEAIQBg"


composer.removeScene( "driveScreen", false )
composer.removeScene( "preDriveScreen", false )
composer.removeScene( "postDriveScreen", false )


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

local background = display.newRect( 0, 0, 1080, 1920 )
background.x = _W*0.5
background.y = _H*0.5
sceneGroup:insert(background)


local postDriveHeader = display.newImage("assets/menus/postDriveHeader.png", true)
postDriveHeader.anchorY = 0
postDriveHeader.anchorX = 0.5
postDriveHeader.x = _W*0.5
sceneGroup:insert(postDriveHeader)


local gcAmountText = display.newText( "0", 0, 0, native.systemFont, 80 )
gcAmountText.x = _W*0.5 - 400
gcAmountText.y =  400
gcAmountText:setFillColor( 0/255, 102/255, 0/255 )
gcAmountText.anchorX = 0.5
gcAmountText.text = myGreenCoinEarned
sceneGroup:insert(gcAmountText)







local function showLeaderboard (event)
	if event.phase == "ended" then
		gameNetwork.show("leaderboards")
	end
end


local function goToRedeemScreen (event)
	if event.phase == "ended" then
		composer.gotoScene( "redeemScreen", "fade", 400 )
	end
end


local function newDrive (event)
	if event.phase == "ended" then
		composer.gotoScene( "preDriveScreen", "fade", 400 )
	end
end




local leaderboardButton = widget.newButton
{
	width = 830,
	height = 238,
	defaultFile = "assets/buttons/leaderboard.png",
	overFile = "assets/buttons/leaderboardPress.png",
	onEvent = showLeaderboard
}

leaderboardButton.x = _W*0.5
leaderboardButton.y = _H*0.5 - 90
sceneGroup:insert(leaderboardButton)



local redeemButton = widget.newButton
{
	width = 830,
	height = 238,
	defaultFile = "assets/buttons/redeem.png",
	overFile = "assets/buttons/redeemPress.png",
	onEvent = goToRedeemScreen
}

redeemButton.x = _W*0.5
redeemButton.y = _H*0.5 + 275
sceneGroup:insert(redeemButton)


local newDriveButton = widget.newButton
{
	width = 830,
	height = 238,
	defaultFile = "assets/buttons/newDrive.png",
	overFile = "assets/buttons/newDrivePress.png",
	onEvent = newDrive
}

newDriveButton.x = _W*0.5
newDriveButton.y = _H*0.5 + 615
sceneGroup:insert(newDriveButton)

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
