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


local redeemMenu = display.newImage("assets/menus/redeemGreenCoin.png", true)
redeemMenu.anchorY = 0.5
redeemMenu.anchorX = 0.5
redeemMenu.y = _H*0.5
redeemMenu.x = _W*0.5
sceneGroup:insert(redeemMenu)


local redeemHeader = display.newImage("assets/menus/preDriveHeader.png", true)
redeemHeader.anchorY = 0
redeemHeader.anchorX = 0.5
redeemHeader.x = _W*0.5
sceneGroup:insert(redeemHeader)

local gcAmountText = display.newText( "0", 0, 0, native.systemFont, 80 )
gcAmountText.x = _W*0.5 - 100
gcAmountText.y =  380
gcAmountText:setFillColor( 0/255, 102/255, 0/255 )
gcAmountText.anchorX = 0.5
gcAmountText.text = myGreenCoin
sceneGroup:insert(gcAmountText)



local backButton = display.newImage("assets/backArrow.png", true)
backButton.x = 90
backButton.y = 80
sceneGroup:insert(backButton)

local function goBack (event)
	if event.phase == "began" then
		composer.gotoScene( "preDriveScreen", "fade", 400 )
	end
end

backButton:addEventListener( "touch", goBack )





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
